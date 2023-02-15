#!/bin/bash
echo -e "\n\nExecuting some fixes..."
echo "Current User: $(whoami)"

echo "Preparing requirements..."
yum -y install https://packages.endpointdev.com/rhel/7/os/x86_64/endpoint-repo.x86_64.rpm

echo -e "\n\nRemoving old git224..."
yum -y erase git224*

echo -e "\n\nInstalling updated git..."
yum -y install git

echo -e "\n\nInstalling Development Tools..."
yum -y groupinstall 'Development Tools'

echo -e "\n\nInstalling updated curl..."
yum -y install curl

echo -e "\n\nInstalling .Net SDK and Runtime..."
rpm -Uvh https://packages.microsoft.com/config/centos/7/packages-microsoft-prod.rpm
yum -y install dotnet-sdk-6.0
yum -y install dotnet-sdk-3.1

echo -e "\n\nPreparing GHE Login tool..."
cp -av /vagrant/user-github-auth.sh /home/ndsadmin/user-github-auth.sh
chown ndsadmin: /home/ndsadmin/user-github-auth.sh
chmod 775 /home/ndsadmin/user-github-auth.sh

echo -e "\n\nPreparing custom user provision..."
cp -av /vagrant/user-provision.sh /home/ndsadmin/user-provision.sh
chown ndsadmin: /home/ndsadmin/user-provision.sh
chmod 775 /home/ndsadmin/user-provision.sh




echo -e "\n\nCompleted custom root provisioning.\n\n"
