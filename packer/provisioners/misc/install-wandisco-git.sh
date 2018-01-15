#!/usr/bin/env bash
#####################################################################
# Title    :git command install script( build by wandisco ).
# Overview :install git command and provisoning.
#####################################################################
# Global variable definition area.
#####################################################################

#####################################################################
# Function definition area.
#####################################################################

#####################################################################
# Main process definition area.
#####################################################################
# registration for wandisco-yum repository.
cat << EOM >> /etc/yum.repos.d/wandisco.repo
[wandisco-git]
name=WANdisco Repository - git centos7
baseurl=http://opensource.wandisco.com/centos/7/git/x86_64/$basearch
enabled=0
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-WANdisco
EOM

# registration for RPM-GPG-KEY-WANdisco.
rpm --import http://opensource.wandisco.com/RPM-GPG-KEY-WANdisco

# git command install.
yum -y -R 1 install git --enablerepo=wandisco-git

