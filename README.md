#LAMP Stack on CentOS 6.4 Built with Vagrant/Puppet#

For anyone wanting to try out Vagrant, here's some sample code to help you setup your own LAMP dev sandbox quickly. It runs on CentOS 6.4 and the internal setup is done with Puppet.

Do note that the first run might take a while. Depending on your speed, 10 minutes to download the base VM (CentOS 6.4) and 5 minutes to startup and provision the VM. But subsequent startup should be quite fast.

You can spin up new boxes very easily. Just put your PHP scripts in the `project` folder and add a new vhost. If you are lazy, just throw your PHP files into the `project/webroot` folder.

## Pre-Requisite Software ##

* VirtualBox (>= 4.3.2) ([https://www.virtualbox.org/](https://www.virtualbox.org/))
* VirtualBox Extension Pack ([https://www.virtualbox.org/wiki/Downloads](https://www.virtualbox.org/wiki/Downloads))
* Vagrant (>= 1.3.5) ([http://vagrantup.com/](http://vagrantup.com/))
* Librarian-Puppet ([https://github.com/rodjek/librarian-puppet](https://github.com/rodjek/librarian-puppet))

##Installation Instructions##

1. Install `Puppet` & `Librarian-Puppet`

	```bash
$ sudo gem install puppet
$ sudo gem install librarian-puppet
```

2. Clone this Git Repository

	```bash
$ git clone git@github.com:sgphpug/vagrant-lamp-centos64.git
$ cd vagrant-lamp-centos64
```

3. Install Puppetfile dependencies

	```bash
$ cd puppet
$ librarian-puppet install
```
4. Start Vagrant

	```bash
$ cd ..
$ vagrant up --provision
```

5.  Once startup in complete, point your browser to `http://localhost:8080` to make sure Apache is running.


## Usage ##

* Put your files in `project/webroot` to make it appear in the Apache document root. The `./project` folder is mapped to `/data` in the VM.

* The MySQL username is `root` and the root password is `media1`.

* To login into the VM type

	```bash
$ vagrant ssh
```

* To stop the VM:

	```bash
$ vagrant suspend
```

* To halt the VM:

	```bash
$ vagrant halt
```

* To destroy the VM:

	```bash
$ vagrant destroy
```

* To run Puppet again:

	```bash
$ vagrant provision
```

* Whenever you make any changes to `Vagrantfile`, run:

	```bash
$ vagrant reload --provision
```

## Customization ##

All the configuration are in `Vagrantfile` and in the `puppet/manifests/hieradata/common.yaml`. Feel free to explore and tweak the settings to your liking.

## Disclaimer ##

This configuration was successfully tested on Mac OSX Mavericks.