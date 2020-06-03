# Devportal Kickstart Ansible Installation Scripts
Ansible playbook for installing [Apigee Kickstart developer portal](https://www.drupal.org/project/apigee_devportal_kickstart)
for Drupal.

This playbook is intended to be a starting point and you may want to fork this project
to make your own changes to the `playbook.xml` and other files for your own
requirements.

This playbook will install:

- MySQL
- Nginx
- PHP
- Composer
- Drupal
- Apigee Kickstart Drupal profile

The topology can be one host with everything, or two hosts where one is the 
database and the other is the web server which contains the Drupal site.

## Installation and Usage

The following section explains how to install and use this playbook.

### Clone Repo and Install Ansible 
1. Clone or download this repo to the machine which will be your Ansible 
   control node. This can be a local workstation which has ssh access to the
   hosts which will have the software installed.
2. Install Ansible following the offical [Installing Ansible documentation](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html).
    
### Configuration 

Copy the `example.hosts.yml` file to `hosts.yml` and edit the hostnames/IPs
listed. If you are installing everything on one host use the same hostname/IP
on both.

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
Read the [contributing guide](docs/contributing.md) to learn more about making contributions.

## Tests
This project comes with a simple testing tool to validate the playbook installs
correctly. The test script will run the playbook on a Docker instance. To run
tests:
`cd test; ./run-tests.sh`