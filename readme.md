# pl_PL.UTF-8 PostgreSQL (basing on shipyard-db)

This provides PostgreSQL 9.3 for production deployment.

* `docker build -t postgresql-pl .`
* `docker run postgresql-pl`

Exposed ports

* 5432

Environment Variables

* `DB_USER`: Database user (default: docker)
* `DB_PASS`: Database pass (default: \<randomly generated\>)
* `DB_NAME`: Database name (default: docker)
