#!/bin/bash    
      
      
      sudo mkdir /var/lib/mysql
      sudo mkfs.ext4 -F /dev/sdb
      sudo echo UUID=`sudo blkid -s UUID -o value /dev/sdb` /var/lib/mysql ext4 discard,defaults,nofail 0 0 | sudo tee -a /etc/fstab
      sudo mount -a
      sudo curl -sS https://downloads.mariadb.com/MariaDB/mariadb_repo_setup | sudo bash