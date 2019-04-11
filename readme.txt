Cách rotate log file bằng crontab:
- Tạo file script thực hiện nén file log
- install crontab (sử dụng website: https://crontab-generator.org/ để generator): crontab -e (để insert lệnh chạy)


--
File script: logrotate.sh
lệnh chạy: 59 23 * * * bash /usr/local/apache-tomcat-8.5.29/webapps/cmap2/bashscript/logrotate.sh >/dev/null 2>&1

*/5 * * * * bash /usr/local/apache-tomcat-8.5.29/webapps/cmap2/bashscript/logrotate.sh >/dev/null 2>&1



bash /usr/local/apache-tomcat-8.5.29/webapps/bashscript/logrotate.sh


59 23 * * * bash /usr/local/apache-tomcat-8.5.29/webapps/bashscript/logrotate.sh >/dev/null 2>&1