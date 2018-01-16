#!/usr/bin/env bash
#####################################################################
# Title    :Base package install script.
# Overview :install package and provisoning confing.
#####################################################################
# Global variable definition area.
#####################################################################
typeset PACKAGE=''                    # package list.

#####################################################################
# Function definition area.
#####################################################################

#####################################################################
# Main process definition area.
#####################################################################
# Configured to allow sudo run without a tty.
sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers

# for updating packages.
yum upgrade -y

# inportant repos file add to repository store.
# Install EPEL - Extra Packages for Enterprise Linux 7
yum -y install epel-release

# Utility package for setting.
typeset PACKAGE=""                    # package list.
PACKAGE="${PACKAGE} unzip"            # extract ZIP archive.
PACKAGE="${PACKAGE} bzip2"            # block-sorting file compressor.
PACKAGE="${PACKAGE} sudo"             # execute a another user.
PACKAGE="${PACKAGE} curl"             # transfer a URL.
PACKAGE="${PACKAGE} wget"             # non-interactive network downloader.
PACKAGE="${PACKAGE} file"             # determine file type.
PACKAGE="${PACKAGE} man"              # online manual interface.
PACKAGE="${PACKAGE} screen"           # screen manager with VT100/ANSI. 
PACKAGE="${PACKAGE} w3m"              # text base pager/WWW browser.
PACKAGE="${PACKAGE} nkf"              # network kanji filter.
PACKAGE="${PACKAGE} vim-enhanced"     # Vi IMproved.
PACKAGE="${PACKAGE} ntp"              # Network Time Protocol (NTP) daemon.
PACKAGE="${PACKAGE} net-tools"        # The NET-3 networking toolkit.
PACKAGE="${PACKAGE} mailx"            # send and receive Internet mail.
PACKAGE="${PACKAGE} patch"            # apply a diff file to an original.
PACKAGE="${PACKAGE} screen"           # Multiplex a physical terminal.
PACKAGE="${PACKAGE} lsof"             # list open files.
PACKAGE="${PACKAGE} jq"               # Command-line JSON processor.
PACKAGE="${PACKAGE} nc"               # arbitrary connections and listens.
PACKAGE="${PACKAGE} expect"           # Programmed dialogue with programs.
PACKAGE="${PACKAGE} nfs-utils"        # special filesystem for controlling.
PACKAGE="${PACKAGE} libnfsidmap"      # NFSv4 User and Group ID Mapping Lib.
PACKAGE="${PACKAGE} samba-client"     # Accessing the Samba protocol.
PACKAGE="${PACKAGE} samba-winbind*"   # Name resolution of Windows domain.
PACKAGE="${PACKAGE} cifs-utils"       # Utilities for managing CIFS mounts.
PACKAGE="${PACKAGE} pam_krb5"         # Kerberos 5 authentication.
yum -y install ${PACKAGE}

# Package for Operational maintenance.
typeset PACKAGE=""                    # package list.
PACKAGE="${PACKAGE} openssh-clients"  # for openssh-clients.
PACKAGE="${PACKAGE} rsync"            # for rsync.
PACKAGE="${PACKAGE} bind-utils"       # for dns utility.
PACKAGE="${PACKAGE} sysstat"          # sysstat configuration file.
PACKAGE="${PACKAGE} dstat"            # system resource viewer.
PACKAGE="${PACKAGE} htop"             # hardware status.
PACKAGE="${PACKAGE} traceroute"       # trace to network host.
PACKAGE="${PACKAGE} dmidecode"        # DMI table decoder.
PACKAGE="${PACKAGE} deltarpm"         # rpm difference management.
PACKAGE="${PACKAGE} python-deltarpm"  # python version deltarpm.
PACKAGE="${PACKAGE} createrepo"       # Create repomd repository.
PACKAGE="${PACKAGE} nmap"             # Network exploration tool. 
yum -y install ${PACKAGE}

# Develop tools for module build.
typeset PACKAGE=""                    # package list.
PACKAGE="${PACKAGE} gcc"              # GNU project C and C++ compiler.
PACKAGE="${PACKAGE} gcc-c++"          # GNU project C++ compiler.
PACKAGE="${PACKAGE} make"             # GNU make utility.
PACKAGE="${PACKAGE} automake"         # Generate Makefile.in.
PACKAGE="${PACKAGE} autoconf"         # Generate configuration scripts.
PACKAGE="${PACKAGE} libtidy"          # validate correct and pretty-print lib.
PACKAGE="${PACKAGE} libpcap"          # packet capture lib.
PACKAGE="${PACKAGE} zlib-devel"       # compression/decompression library
PACKAGE="${PACKAGE} perl"             # ractical Extraction and ReportLanguage.
PACKAGE="${PACKAGE} openssl-devel"    # OpenSSL command line tool.
PACKAGE="${PACKAGE} readline-devel"   # get a line from a user with editing.
PACKAGE="${PACKAGE} sqlite-devel"     # sqllite develop package.
PACKAGE="${PACKAGE} strace"           # trace system calls and signals.
PACKAGE="${PACKAGE} ltrace"           # A library call tracer.
PACKAGE="${PACKAGE} bison"            # GNU Project parser generator.
PACKAGE="${PACKAGE} flex"             # fast lexical analyzer generator.
yum -y install ${PACKAGE}

# Develop tools for module build.
typeset PACKAGE=""                    # package list.
PACKAGE="${PACKAGE} kernel-devel"     # Package for kernel build.
PACKAGE="${PACKAGE} kernel-headers"   # Header file for kernel build.
PACKAGE="${PACKAGE} ivtv-firmware"    # Binary firmware for iTVC15-family.
PACKAGE="${PACKAGE} libffi-devel"     # Development files for libffi.
PACKAGE="${PACKAGE} libtool"          # The GNU Portable Library Tool.
PACKAGE="${PACKAGE} libyaml-devel"    # Development files for LibYAML applications.
PACKAGE="${PACKAGE} libyaml"          # YAML 1.1 parser and emitter written in C.
yum -y install ${PACKAGE}

# shows the full path of which commands.
which wget

# enable sysstat daemon. 
systemctl start sysstat
systemctl enable sysstat
