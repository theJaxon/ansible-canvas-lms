# ansible-canvas-lms
Deploy Canvas LMS to using ansible


### [Running Postgres on a different server](https://github.com/instructure/canvas-lms/wiki/Production-Start#running-postgres-on-a-different-server)
To allow communication between our server and postgresql, the following 2 files must be modified: 
1. [`pg_hba.conf`](https://www.postgresql.org/docs/current/auth-pg-hba-conf.html) located at /etc/postgresql/9.5/main/pg_hba.conf 

2. [`postgresql.conf`] located at /etc/postgresql/9.5/main/postgresql.conf 

In `pg_hba.conf` to test the connection i've allowed all types of connection to the DB (This should never be done on production)
```
# TYPE  DATABASE        USER            ADDRESS                 METHOD
local   all             postgres                                trust
# "local" is for Unix domain socket connections only
local   all             all                                     trust
# IPv4 local connections:
host    all             all             0.0.0.0/0            trust
# IPv6 local connections:
host    all             all             ::1/128                 trust
host  all  all 192.168.100.201/16  trust
```

In `postgresql.conf` 
```
# - Connection Settings -
listen_addresses = '*'   
```

Use the following command to connect from the remote machine 
`psql -h <address> -U postgres -p 5432`

#### Configure canvas user for postgres:
```bash
sudo -u postgres createuser canvas --no-createdb --no-superuser --no-createrole --pwprompt
sudo -u postgres createdb canvas_production --owner=canvas
```

---

#### Helpful Postgresql commands:
```
\l # Display list of databases 
\du # Display user list
```
---

#### Debugging:
Canvas error log files are stored at `/var/log/apache2/canvas_errors.log`