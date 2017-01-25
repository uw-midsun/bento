# packer
Packer templates for building Vagrant base boxes

## Requirements
* Ruby
* [Packer](https://www.packer.io/downloads.html)
* [VirtualBox](https://www.virtualbox.org/wiki/Downloads)

## Getting Started
To build a base box

```bash
bundle install
packer build vagrant-base.json
```

## Provision Scripts
Boxes are provisioned after install using [Chef](https://www.chef.io/chef) provisioning scripts and ``chef-solo``.

We use Berkshelf to maintain our [vendor cookbooks](https://supermarket.chef.io), located at ``chef/cookbooks/``. To update vendor recipes, add a recipe to the ``Berksfile``. Typically, you should not need to modify these cookbooks, unless you're adding a new cookbook from the Chef Supermarket.

```bash
cd chef/
vim Berksfile
berks vendor cookbooks
```

Our own cookbooks are stored in ``chef/uwmidsun-cookbooks/``. Most likely, you'll want to modify the recipes here.
