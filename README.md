# Ansible Plausible

Setup your own [Plausible Analytics](https://plausible.io) instance in a few minutes.

Buying a subscription is the easiest way to get started with Plausible but this Ansible
playbook makes it easier for DIYers to self host an instance.

## Requirements

1. A server with Debian 11 installed.
2. A domain name managed at Cloudflare.
3. Your Cloudflare api token.
4. Email address with SMTP access.

## Quick start

Setup your ssh connection first. Edit your `~/.ssh/config` on your local machine like so:


```shell
Host myhostname
    HostName 192.168.1.1
    User root
    IdentitiesOnly yes
```

*HostName* will equal to your server's IP address.

Now you can edit `inventory.yml` to look like this:

```yaml
all:
  hosts: myserver
  vars:
    admin_username: "myusername"
    plausible_port: "10000"
```

Make sure to copy your SSH public key to your server and enable passwordless login.

1. Change the Common variables

Edit the file at `common/vars/main.yml`.

Passwords have to be generated with mkpasswd, which is commonly available on Linux systems but not on macOS. There are a couple of (options)[https://serversforhackers.com/c/create-user-in-ansible]. The official docs (recommend)[https://docs.ansible.com/ansible/latest/reference_appendices/faq.html#how-do-i-generate-encrypted-passwords-for-the-user-module] using the pip library passlib with some inline python. 


2. Update nginx conf

Rename the file at `common/templates/example.com.conf` and set it to `yourdomain.com.conf`.
Or keep the example template and make a copy of it instead.


3. Change the plausible variables

Now edit the file at `plausible/vars/main.yml` 


4. Add a vault password

Create a file in the project root called 'vault_password_file'. Do not share this with anyone. Do not check this file into version control. The name of this file is controlled by ansible.cfg file. 

5. Encrypt your Ansible vars files

After having setup all the variables, you *NEED TO* encrypt your variables files like so:

```shell
ansible-vault encrypt common/vars/main.yml
ansible-vault encrypt plausible/vars/main.yml
```

6. Run make

Run `make`

Once the play is complete, your plausible instance should be accessible at *yourdomain.com*.


### Ansible Collections 

Collections to be added as roles/tasks are updated to current

- ansible-galaxy collection install community.general


## Installing on an existing server

If you already have a server that you use to host other stuff, you should avoid running the
*common* role because it will destroy your Nginx configs and possibly lock you out from SSH.

Instead, run `make plausible` to only install Plausible. You will need to have *docker* and
*docker-compose* installed.

## Support and feature requests

Feel free to request support and features on the Github issue tracker.

## License and Copyright

License is MIT.

Copyright 2022 Josh Michael karamuth <michael@confuzeus.com>
