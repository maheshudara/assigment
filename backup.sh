#!/bin/bash

cp /var/log/httpd/*_log /home/ec2-user/

for f in *_log; do
    mv -- "$f" "${f%_log}.log"   
done

tar czf status_2021.tar.gz *.log Log files ZIP

aws s3 cp status_2021.tar.gz s3://maheshbackup Upload file to S3.


if [ $? -ne 1 ]
then
        rm -rf status_2021.tar.gz  Delete existing file 
        echo "Zip File removed"
else
        echo "there was an error"
        echo "Auto Tested Tomcat Status" | mailx -s "Upload Failed" mucreationz@gmail.com

fi
