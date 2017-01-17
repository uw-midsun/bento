# bento
Vagrant base box building, clone of https://github.com/chef/bento

## Requirements
* Ruby
* [Packer](https://www.packer.io/downloads.html)
* [VirtualBox](https://www.virtualbox.org/wiki/Downloads)

## Getting Started
To build a base box

```bash
bundle install
bento build --only=virtualbox-iso vagrant-base.json
```

## Provision Scripts
Boxes are provisioned after install using [Chef](https://www.chef.io/chef) provisioning scripts and ``chef-solo``.

We use Berkshelf to maintain our [vendor cookbooks](https://supermarket.chef.io), located at ``chef/cookbooks/``. To update vendor recipes, add a recipe to the ``Berksfile``.

```bash
cd chef/
vim Berksfile
berks vendor cookbooks
```

Our own cookbooks are stored in ``chef/uwmidsun-cookbooks/``.
