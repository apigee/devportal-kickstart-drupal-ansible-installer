Drupal File Permissions
========================

Configures the file permissions of the Drupal site files following the [Drupal.org file and permissions
ownership documentation](https://www.drupal.org/node/244924)

Requirements
------------

None

Role Variables
--------------

Variables are listed here, along with default values, see `defaults/main.yml`:

The root directory of the Drupal installation:

```
drupal_root: /opt/devportal/web
```

The Unix owner that should own all Drupal files
```
drupal_file_owner: devportal
```

The unix group that should be set for all Drupal files
```
drupal_file_group: nginx
```

Dependencies
------------

None

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers
      tasks:
      - name: Set Drupal file permissions
        import_role:
          name: drupal-file-permissions
        become: true

License
-------

Apache License, Version 2.0

