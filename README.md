# ansible-canvas-lms
Deploy Canvas LMS With Postgresql and redis to `Ubuntu 18.04 Bionic`  using ansible

Example Playbook
----------------

```yml
- hosts: all
  roles:
  - postgres
  
- hosts: all 
  roles:
  - canvas
```

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
host  all  all localhost  trust
```

In `postgresql.conf` 
```
listen_addresses = '*'   
```

---

#### Helpful Postgresql commands:
```bash
\l # Display list of databases 
\du # Display user list
```
---

#### Debugging:
* Canvas error log files are stored at `/var/log/apache2/canvas_errors.log`
* Check the postgresql db using 
```bash
sudo su - postgres
psql
```
---

#### TODO:
1. Configure SSL for domain (file located at canvs/templates/domain.j2) 

---

Author Information
------------------

Created by [theJaxon](https://github.com/theJaxon)