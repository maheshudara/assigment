#!/bin/bash
this_pid=$$

ss -luntp | grep httpd | grep -v "grep" | grep -v this_pid &> /dev/null

if [ $? -eq 0 ];then
    echo "`date`||The httpd service is running"  >> CheckStatus.log
 else
    #echo "The httpd service is shutdown" > statuscheck.log
    echo "`date`||The httpd service is shutdown 200 Status Code" >> CheckStatus.log
    echo "Auto Tested Tomcat Status" | mailx -s "Tomcat not running. Starting tomcat server --> `hostname -i`" mucreationz@gmail.com
    echo "Mail send"  >> CheckStatus.log
fi
