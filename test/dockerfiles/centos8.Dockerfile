FROM geerlingguy/docker-centos8-ansible:latest

COPY . /opt/kickstart-ansible
COPY test/hosts.yml /opt/kickstart-ansible