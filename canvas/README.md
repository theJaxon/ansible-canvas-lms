Ansible Role: Canvas
=========

This role is responsible for deploying the canvas LMS part of the installation.

Requirements
------------

Before executing this role you must first execute the postgres role in order to setup DB connection.

Role Variables
--------------

Change **`username`** variable to match the name of the privileged user that the playbook will run as.

Example Playbook
----------------
```yml
- hosts: all
  roles:
  - postgres
  - canvas

```

License
-------

GPL

Author Information
------------------

Created by [theJaxon](https://github.com/theJaxon)