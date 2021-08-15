FROM ubuntu:xenial

# buat CMD untuk nge print hello saat container di jalankan
# menggunakan command 'echo', yang berada di 'bash'
# ENV PATH="${PATH}:/app"

WORKDIR /
ENV PATH=${PATH}:/home
# format penulisan CMD[""]
# CMD ["letak program atau script", "argument1", "argument2", "argumentN"]
COPY app/hello.sh /home/hello.sh
# error karna kurang permissions executable
# jadi kalo mau jalanin script hello.sh itu harus ditambahkan dulu permissions nya
# nah ini mau lanjut menjelaskan permissions
RUN chmod u+x /home/hello.sh
# CMD ["/bin/bash", "-c", "/home/hello.sh"]
CMD [ "hello.sh" ]
# CMD [ "/bin/bash", ]

# Script & Permissions

# script atau program itu harus memiliki permissions/ijin executable
# macam2 tipe permissions di linux itu ada 3:
# 1. read (r)  -> ijin agar file bisa dibaca
# 2. write (w) -> ijin agar file bisa ditulis
# 3. executable (x) -> ijin agar`` file bisa dieksekusi sebagai program/script

# cara membaca permissions sebuah file
# contoh format (cara check permissions sebuah file -> $: ls -l /bin/bash):
# f/d user  group  other
# -   rwx   r-x    r-x     /bin/bash`
# terdapat 4 bagian

# - (bagian 1 paling kiri menunjukan file (-) atau folder (d))
# contoh:
# drwxr-xr-x  bin (bin disini adalah folder)

# rwx (bagian 2 atau nomor 2 dari kiri menunjukan kolom untuk user)
# r-x
# r-x

# exec: "echo test": executable file not found in $PATH: unknown.
# sifat container itu membutuhkan program yang akan di eksekusi saat pertama kali container dijalankan

# ada program -> command -> argument

#             user group
#-rwxr--r-x 1 test test 38 Jul 24 10:31 hello.sh
# user: rwx
# group: r--
# other: r--

# cara menambahkan permissions user, group, other

# chmod o+x /var/test/hello.sh
# chmod g+
# chmod u+

# cara mengurahi permissions
# chmod o-rx /var/test/hello.sh
