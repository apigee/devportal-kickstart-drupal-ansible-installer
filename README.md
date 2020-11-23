# Apigee Devportal Kickstart for Drupal Ansible Installation Scripts
This project automates the installation of [Apigee Kickstart developer portal](https://www.drupal.org/project/apigee_devportal_kickstart)
for Drupal using [Ansible](https://docs.ansible.com/).

By using this project, you can get Apigee Kickstart developer portal installed on a Linux system, including all dependencies. This Ansible playbook will install:

- MySQL
- Nginx
- PHP
- Composer
- Drupal
- Apigee Kickstart Drupal profile

This playbook is intended to be a starting point and not a "one size fits all" playbook. We recommend you fork this project and make changes to the `playbook.xml` and other files to fit your specific needs.

The topology can be one host with everything, or two hosts where one is the database, and the other is the web server which contains the Drupal site.

## Target Platforms
This project may work with other operating systems, but has currently been tested with:
* CentOS 7
* RedHat 7

If you successfully install onto any other platforms, let us know and we can add it to the list. We are also accepting contributions to this project if you end up making modifications, see our [contributing guide](docs/contributing.md) for more information.

## Installation and Usage
The following section explains how to install and use this playbook.

### Clone Repo and Install Ansible 
1. Clone or download this repo to the machine which will be your Ansible 
   control node. This can be a local workstation or a server which has ssh access to the
   target host(s).
2. Install Ansible following the official [Installing Ansible documentation](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html).
    
### Configuration 

Copy the `example.hosts.yml` file to `hosts.yml` and edit the hostnames/IPs
listed. If you are installing everything on one host use the same hostname/IP
on both.

If you are not using SSH agent, you may need to configure Ansible to you the correct SSH key by setting 
`private_key_file` in the ansible.cfg file. Read more in the [SSH key setup Ansible documentation](https://docs.ansible.com/ansible/latest/user_guide/connection_details.html#ssh-key-setup).

### Pull down requirements from Ansible Galaxy
From the root of this project, run:
`ansible-galaxy install -r requirements.yml`

### Update variables
Look through group_vars/dbservers.yml and modify any variables as needed. It is highly recommended
to change the following variables:
- `mysql_root_password`
- `mysql_users.password`

Look through group_vars/webservers.yml and modify any variables as needed. It is highly recommended
to change the following variables:
- `drupal_db_password`
- `php_date_timezone`

### Run playbook
Run the following command to run the playbook:
`ansible-playbook playbook.yml`

## Issues and Feedback
You can add issues and ask for help by putting an issue into this repository's 
issue queue.

## Contributing
This is an open source project that encourages contributions from the community. Read the 
[contributing guide](docs/contributing.md) to learn more about making contributions.

## Tests
This project uses [Molecule](https://molecule.readthedocs.io/en/latest/) to validate that the playbook installs correctly.
By default Molecule will run the playbook on a CentOS 8 Docker image. To run the tests you
need to have molecule and molecule[docker] installed locally. On a system where pip is already
installed this can be achieved with a single command invocation.

```
$ pip3 install molecule molecule\[docker\]
```

Afterwards, when `molecule test` is invoked it will download Galaxy dependencies, lint the yaml
files, create a container called instance, provision it with Ansible, and validate the playbook
idempotency.

## License
Apache 2.0

## Support
This is not an officially supported Google product. The architectural choices of these scripts do not 
connote support implications. Please refer to the extensive documentation on drupal.org for guidance on installation. 

If you find a bug, have questions or want to give feedback, add an issue to the 
[project's issue queue](https://github.com/apigee/devportal-kickstart-drupal-ansible-installer/issues). If you 
have issues running Ansible or with one of the open source [Ansible roles included](https://github.com/apigee/devportal-kickstart-drupal-ansible-installer/blob/master/requirements.yml)
in this project, you can work with those projects to find solutions to your issue.




