#!/usr/bin/env bash

create_dir () {
  mkdir -p /home/$1
  mkdir -p /home/$1/dev
  mkdir -p /home/$1/bin
  mkdir -p /home/$1/etc
}

create_user_sessions_files () {
  for files in 'null c 1 3' 'tty c 5 0' 'zero c 1 5' 'random c 1 8'; do
    mknod -m 666 /home/$1/dev/${files}
  done
}

chmod_to_user () {
  chmod 0755 /home/$1
}

copy_libs () {
  LIB_PATH=$(ldd /bin/bash |
              grep -o '/lib.*/' |
              sed 's@/@@')
  LIBS="$(ldd /bin/bash |
          grep '/lib.*/' |
          grep -o '.*so.* ' |
          awk '{print $NF}')"

  for dir_name in ${LIB_PATH}; do
    mkdir -p /home/$1/${dir_name}
  done

  for lib_name in ${LIBS}; do
    DEST_PATH="$(echo ${lib_name}|
                grep -E '/lib.*/|/lib64.*/' |
                sed 's@/@@')"
    cp -v ${lib_name} /home/$1/${DEST_PATH}
  done
}

create_user () {
  useradd $1
  echo $1:$1 | chpasswd
}

copy_etc () {
  cp -vf /etc/{passwd,group} /home/$1/etc
}


create_dir "jail"
create_user_sessions_files "jail"
chmod_to_user "jail"
create_user "jail"
copy_libs "jail"
copy_etc "jail"
