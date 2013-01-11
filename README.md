# Install Tibco products on a CentOS VirtualBox VM using Vagrant and Puppet

In this project I aim to share what I have done to install the following TIBCO products on a dev machine:
* TIBCO Enterprise Message Service (EMS)
* TIBCO ActiveMatrix Service Grid (AMSG)
* TIBCO Rendezvous (RV)
* TIBCO Runtime Agent(TRA)
* TIBCO ActiveMatrix BusinessWorks (BW)
* TIBCO ActiveMatrix BusinessWorks Service Engine (BWSE)
 
This proof of concept can be expanded for other environments.
Disclaimer: This is my first attempt using Vagrant and Puppet.

There are probably two (obvious) ways of installing TIBCO products. Either extract the installation zip/tar files and then to do silent installs or create rpm files.
I chose the option to install from rpms as that is often recommended in forums for other products. Creating the rpm files takes a bit longer, but the actual installs are then reasonably fast.

I did not commit the actual rpm files I created as Tibco will not approve.

## Git clone this project

Start of by cloning [this github project](https://github.com/charlbrink/vagrant-puppet-tibco-amsg)
Verify the configuration:
* Set your proxy settings in manifests/nodes.pp or remove if not required
* Verify modules/amsg/manifests/params.pp
* Verify modules/ems/manifests/params.pp

## Create Tibco RPMs

The method I used was to manually install TIBCO ActiveMatrix Service Grid (AMSG), TIBCO Rendezvous (RV), TIBCO Runtime Agent(TRA), TIBCO ActiveMatrix BusinessWorks (BW), TIBCO ActiveMatrix BusinessWorks Service Engine (BWSE) together in one TIBCO_HOME (/home/vagrant/amsg_home) and also sharing the same configuration folder (/home/vagrant/amsg_data).
TIBCO Enterprise Message Service (EMS) was installed in another TIBCO_HOME (/home/vagrant/ems_home) with its own configuration folder (/home/vagrant/ems_data).
**Do not run the TIBCO Configuration tool as part of the installtion!**

Using [FPM](https://github.com/jordansissel/fpm/wiki) one can easily create rpms as follows:
*fpm -s dir -t rpm -n "amsg" -v 3.2.0 /home/vagrant/amsg_home /home/vagrant/amsg_data to create the file amsg-3.2.0-1.x86_64.rpm and
*fpm -s dir -t rpm -n "ems" -v 6.3 /home/vagrant/ems_home /home/vagrant/ems_data to create the file ems-6.3-1.x86_64.rpm

Overwrite the provided modules/amsg/files/amsg-3.2.0-1.x86_64.rpm and modules/ems/files/ems-6.3-1.x86_64.rpm files

## Create the CentOS VM instance

Required software to be installed on the host:
* [Vagrant](http://www.vagrantup.com/)
* [Oracle VM VirtualBox](https://www.virtualbox.org/)

Run "vagrant up" to set up a Virtualbox VM with CentOS and then install the required packages as well as GNOME.
Log in to the vm with username/password vagrant/vagrant and start GNOME with "sudo init 5" if a graphical environment is required.
Now run the TIBCO Configuration Tool if you need to set up an environment.
