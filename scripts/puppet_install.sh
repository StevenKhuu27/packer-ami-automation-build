#!/bin/bash

# "sudo su",
# "cd ~",
# "pwd",
# "whoami",
# "wget https://pm.puppetlabs.com/puppet-enterprise/2021.7.3/puppet-enterprise-2021.7.3-ubuntu-20.04-amd64.tar.gz -P ~/",
# "sudo tar xf ~/puppet-enterprise-2021.7.3-ubuntu-20.04-amd64.tar.gz",
# "umask 0022",
# "~/puppet-enterprise-2021.7.3-ubuntu-20.04-amd64/puppet-enterprise-installer -c ~/puppet-enterprise-2021.7.3-ubuntu-20.04-amd64/conf.d/pe.conf",
# "puppet agent -t",
# "puppet agent -t"   
sed -Ei 's/^UMASK\s+027$/UMASK           022/g' /etc/login.defs
sed 's/umask 027/umask 022/g' /etc/bash.bashrc
sed 's/umask 027/umask 022/g' /etc/profile
umask 0022
sudo su

VERSION=2021.7.3
OS=ubuntu-20.04-amd64
wget https://pm.puppetlabs.com/puppet-enterprise/2021.7.3/puppet-enterprise-2021.7.3-ubuntu-20.04-amd64.tar.gz

sudo tar xf ./puppet-enterprise-${VERSION}-${OS}.tar.gz
sudo ~/puppet-enterprise-${VERSION}-${OS}/puppet-enterprise-uninstaller -Y
sudo mv ./puppet-enterprise-${VERSION}-${OS} ~/
sudo ~/puppet-enterprise-${VERSION}-${OS}/puppet-enterprise-installer -c ~/puppet-enterprise-${VERSION}-${OS}/conf.d/pe.conf
cd 
cd puppet-enterprise-${VERSION}-${OS}
puppet agent -t
puppet agent -t

sed -Ei 's/^UMASK\s+022$/UMASK           027/g' /etc/login.defs
sed 's/umask 022/umask 027/g' /etc/bash.bashrc
sed 's/umask 022/umask 027/g' /etc/profile
umask 0027
