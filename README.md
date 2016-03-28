# Rancher-Ansible

This playbook will install Rancher platform (latest version) and register hosts automatically with Rancher, this playbook can be used to set up Rancher environment without manually registering each host with Rancher.

## Usage

- Add the connection information for the Rancher server under the [rancher] group:

```
[Rancher]
rancher ansible_ssh_port=22 ansible_ssh_host=x.x.x.x
```

- Add all the nodes that will be registered with Rancher under the [nodes] group:

```
[nodes]
node1 ansible_ssh_port=22 ansible_ssh_host=y.y.y.y
node2 ansible_ssh_port=22 ansible_ssh_host=z.z.z.z
```

- run the ansible-playbook command to setup the environment:

```
# ansible-playbook -i hosts rancher.yml
```

## Docker Deployments

The playbook adds the example of deploying docker container directly to your Rancher environment using Docker module in Ansible, if you just want to install the Rancher environment, make sure to comment the following part in rancher.yml:

```
- name: Deploy MySQL Container
  hosts: 'database'
  sudo: yes
  roles:
    - { role: mysql_docker, tags: ["mysql_docker"] }

- name: Deploy Wordpress App
  hosts: "application"
  sudo: yes
  roles:
    - { role: wordpress_docker, tags: ["wordpress_docker"] }
```

For more information about deploying Docker containers to Rancher environment using Ansible, check the follwoing blog [post](http://rancher.com/using-ansible-with-docker-to-deploy-a-wordpress-service-on-rancher/).
