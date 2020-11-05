Ansible Role: Canvas
=========

This role is responsible for deploying the Postgresql part of the installation.

Requirements
------------

This role must execute before running the canvas role.

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