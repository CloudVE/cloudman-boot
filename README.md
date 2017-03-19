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
[Agents]
agent1 ansible_ssh_port=22 ansible_ssh_host=y.y.y.y
agent2 ansible_ssh_port=22 ansible_ssh_host=z.z.z.z
```

- run the ansible-playbook command to setup the environment:

```
# ansible-playbook -i hosts rancher.yml
```
