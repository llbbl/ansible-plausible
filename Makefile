.PHONY: all common system packages users ssh firewall fail2ban nginx vim cron plausible

all: common plausible

common:
	ansible-playbook common.yml

system:
	ansible-playbook --tags "system" common.yml

packages:
	ansible-playbook --tags "packages" common.yml

users:
	ansible-playbook --tags "users" common.yml

ssh:
	ansible-playbook --tags "ssh" common.yml

firewall:
	ansible-playbook --tags "firewall" common.yml

fail2ban:
	ansible-playbook --tags "fail2ban" common.yml

nginx:
	ansible-playbook --tags "nginx" common.yml

vim:
	ansible-playbook --tags "vim" common.yml

cron:
	ansible-playbook --tags "cron" common.yml

plausible:
	ansible-playbook plausible.yml
