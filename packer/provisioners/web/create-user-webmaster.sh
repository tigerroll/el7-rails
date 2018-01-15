#!/usr/bin/env bash
########################################################
# Title    :Create user script.
# Overview :Add web content management account.
########################################################
# Define Authentication information.
typeset users=()
users=( "${users[@]}" "1101,webmaster,webmaster123,webmaster,," )

#####################################################################
# Function definition area.
#####################################################################

#####################################################################
# Main process definition area.
#####################################################################

# Create users.
for i in ${users[@]}; do

  # Authentication information.
  typeset uid=$(echo ${i} | awk -F, '{print $1}')
  typeset gid=$(echo ${i} | awk -F, '{print $1}')
  typeset userid=$(echo ${i} | awk -F, '{print $2}')
  typeset passwd=$(echo ${i} | awk -F, '{print $3}')
  typeset groups=$(echo ${i} | awk -F, '{print $4}')
  typeset expire=$(echo ${i} | awk -F, '{print $5}')
  typeset prior=$(echo ${i} | awk -F, '{print $6}')

  # Add Groups.
  groupadd -g "${gid}" "${groups}"

  # Add Users.
  useradd -u "${uid}" -g "${groups}" "${userid}" 

  # Set Password expiration time to 90 days.
  [[ -n "${expire}" ]] && chage -M "${expire}" "${userid}"
  # Set Password due date N days prior warning.
  [[ -n "${prior}" ]] && chage -W "${prior}" "${userid}"
  # Password change.
  yes "${passwd}" | passwd "${userid}"

done

# Create web directory.
install -g "${groups}" -o "${userid}" -m 705 -d /home/"${userid}"/www
install -g "${groups}" -o "${userid}" -m 705 -d /home/"${userid}"/www/html

# Create Database DUMP directory.
install -g "${groups}" -o "${userid}" -m 705 -d /home/"${userid}"/backup
install -g "${groups}" -o "${userid}" -m 705 -d /home/"${userid}"/backup/logs
install -g "${groups}" -o "${userid}" -m 705 -d /home/"${userid}"/backup/logs/nginx
install -g "${groups}" -o "${userid}" -m 705 -d /home/"${userid}"/backup/logs/unicorn
install -g "${groups}" -o "${userid}" -m 705 -d /home/"${userid}"/backup/logs/sidekiq

# Set to allow httpd access.
chmod 701 /home/"${userid}"

