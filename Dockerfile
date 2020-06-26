FROM postgres

RUN apt-get update && apt-get install -y postgresql-11-repmgr vim gettext-base

