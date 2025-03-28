# K3S Install using Ansible
### Requirements
- ansible installed on the machine running this script 
- 3 Debian 12 VM with static IPs

### How to use it
In a terminal, execute the following command: 
```sh
ansible-playbook playbook/k3s-install.yaml -i inventory/cluster-inventory.yaml -u <your-remote-user>
```