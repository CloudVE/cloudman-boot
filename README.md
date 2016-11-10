# Rancher-HA-Ansible

This playbook will install Rancher (Multi-node) High available setup, see the [Documention](http://docs.rancher.com/rancher/v1.2/en/installing-rancher/installing-server/multi-nodes/#requirements) for Prequisites.

## Usage

- Add the connection information for the nodes in the inventory.

```
[Rancher]
[Rancher-LB]
rancher-lb ansible_ssh_port=22 ansible_ssh_host=x.x.x.x

[HA-Nodes]
ha-node1 ansible_ssh_port=22 ansible_ssh_host=y.y.y.y
ha-node2 ansible_ssh_port=22 ansible_ssh_host=y.y.y.y
ha-node3 ansible_ssh_port=22 ansible_ssh_host=y.y.y.y

[Database]
ha-db ansible_ssh_port=22 ansible_ssh_host=z.z.z.z

```


- run the ansible-playbook command to setup the environment:

```
# ansible-playbook -i hosts rancher.yml
```


