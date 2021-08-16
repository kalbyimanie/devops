#!/bin/bash

USERNAME=$1
GROUPNAME=$2

# user
function createUser {
  useradd -m -N -d /home/${USERNAME} ${USERNAME}
}

# create group
function createGroup {
  groupadd ${GROUPNAME}
}

# add user into the new group
function registerUserToNewGroup {
  usermod -aG ${GROUPNAME} ${USERNAME}
}


function main {
  createUser
  createGroup
  registerUserToNewGroup

  if [[ $? -eq 0 ]];then
    echo "username: ${USERNAME}, groupname: ${GROUPNAME}"
    id ${USERNAME}
  else
    echo "error" && exit 1
  fi
}

if [[ $1 == 'del' ]];then
  userdel -fr $2
else
  main
fi
