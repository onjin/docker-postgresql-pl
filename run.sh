#!/bin/bash
DB_USER=${DB_USER:-docker}
DB_PASS=${DB_PASS:-`date | md5sum | head -c10`}
DB_NAME=${DB_NAME:-docker}
DATA_DIR=${DATA_DIR:-/var/lib/postgresql/9.3/main}
INITDB=/usr/lib/postgresql/9.3/bin/initdb
PG_CMD=/usr/lib/postgresql/9.3/bin/postgres
CONF=/etc/postgresql/9.3/main/postgresql.conf

# create dirs if needed
mkdir -p $DATA_DIR

# initialize db if needed
if [ ! "`ls -A $DATA_DIR`" ] ; then
    chown -R postgres $DATA_DIR
    su postgres sh -c "$INITDB $DATA_DIR"
fi

su postgres /bin/bash -c "$PG_CMD --single -D $DATA_DIR -c config_file=$CONF" <<< "CREATE USER $DB_USER WITH SUPERUSER PASSWORD '$DB_PASS';"
su postgres /bin/bash -c "$PG_CMD --single -D $DATA_DIR -c config_file=$CONF" <<< "CREATE DATABASE $DB_NAME WITH OWNER $DB_USER ENCODING 'utf8' TEMPLATE template0;"
# run
echo "Starting Postgres..."
echo "Info"
echo "  Username: $DB_USER"
echo "  Password: $DB_PASS"
echo "  Database: $DB_NAME"
su postgres sh -c "$PG_CMD -D $DATA_DIR -c config_file=$CONF"
