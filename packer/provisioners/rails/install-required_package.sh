#!/usr/bin/env bash
#####################################################################
# Title    :Installing Ruby and Rails with rbenv
# Overview :The first step is to install dependencies for Ruby.
#####################################################################
# Global variable definition area.
#####################################################################
typeset userid='webmaster'            #

#####################################################################
# Function definition area.
#####################################################################

#####################################################################
# Main process definition area.
#####################################################################
# 'Ruby on Rails' depends on package for setting.
typeset PACKAGE=""                    # package list.
PACKAGE="${PACKAGE} git-core"         # git with minimal functionality.
PACKAGE="${PACKAGE} zlib"             # compression and decompression library.
PACKAGE="${PACKAGE} zlib-devel"       # Header files and libraries for Zlib.
PACKAGE="${PACKAGE} gcc-c++"          # C++ support for GCC.
PACKAGE="${PACKAGE} patch"            # Utility for modifying/upgrading files.
PACKAGE="${PACKAGE} readline"         # editing typed command lines.
PACKAGE="${PACKAGE} readline-devel"   # readline develop library.
PACKAGE="${PACKAGE} libyaml-devel"    # LibYAML applications.
PACKAGE="${PACKAGE} libffi-devel"     #
PACKAGE="${PACKAGE} openssl-devel"    #
PACKAGE="${PACKAGE} make"             #
PACKAGE="${PACKAGE} bzip2"            #
PACKAGE="${PACKAGE} autoconf"         #
PACKAGE="${PACKAGE} automake"         #
PACKAGE="${PACKAGE} libtool"          #
PACKAGE="${PACKAGE} bison"            #
PACKAGE="${PACKAGE} curl"             #
PACKAGE="${PACKAGE} sqlite-devel"     #
PACKAGE="${PACKAGE} epel-release"     #
PACKAGE="${PACKAGE} nodejs"           #
yum -y install ${PACKAGE}
