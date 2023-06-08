# packer-ami-automation-build
Issues found with puppet ami with packer

We utilised the CIS ubuntu 20.04 as the base image, which was locked down pretty tough

A few errors that we saw was not enough permissions when running the installer command:

This was due to the umask being set to 0027 → which prevented db init from successfully installing. We bypassed this with the following commands to change the umask to 0022, in three locations

sed -Ei 's/^UMASK\s+027$/UMASK           022/g' /etc/login.defs
sed 's/umask 027/umask 022/g' /etc/bash.bashrc
sed 's/umask 027/umask 022/g' /etc/profile
umask 0022

This must be reverted back to 0027 for the ami to be saved properly.

There was also another issue with the packer scripts to initialise IMDSv2, this required the aws plugin, we did this by specifying this packer.pkr.hcl file 

packer {
  required_plugins {
    amazon = {
      version = ">= 1.2.5"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

and then running a packer init within the pipeline, mamking sure packer was executable. Refer to skoro’s pipeline.

      - chmod a+x ./packer
      - ./packer init .
