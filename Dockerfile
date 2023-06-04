FROM centos:7.9.2009
RUN curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
RUN curl -o /etc/yum.repos.d/epel.repo http://mirrors.aliyun.com/repo/epel-7.repo
RUN yum -y install  telnet   inetutils-ping  curl  net-tools vim nmap nc
CMD echo "this is tool registry from centos7" > /tmp/test.txt && tail -f /tmp/test.txt
RUN yum install -y rsyslog logrotate \
    && sed -i 's/#module(load="imklog")/module(load="imklog")/' /etc/rsyslog.conf \
    && sed -i 's/#module(load="imudp")/module(load="imudp")/' /etc/rsyslog.conf \
    && sed -i 's/#input(type="imudp" port="514")/input(type="imudp" port="514")/' /etc/rsyslog.conf \
    && sed -i 's/#module(load="imtcp")/module(load="imtcp")/' /etc/rsyslog.conf \
    && sed -i 's/#input(type="imtcp" port="514")/input(type="imtcp" port="514")/' /etc/rsyslog.conf \
    && echo '*.info    /dev/stdout' > /etc/rsyslog.d/50-default.conf \
    && sed -i 's|/var/log/messages {|-/var/log/messages {|' /etc/logrotate.conf \
    && echo '/var/log/messages {' > /etc/logrotate.d/messages \
    && echo '    missingok' >> /etc/logrotate.d/messages \
    && echo '    notifempty' >> /etc/logrotate.d/messages \
    && echo '    delaycompress' >> /etc/logrotate.d/messages \
    && echo '    sharedscripts' >> /etc/logrotate.d/messages \
    && echo '    postrotate' >> /etc/logrotate.d/messages \
    && echo '        /usr/bin/logger -p local1.notice -t logrotate "logrotate completed for /var/log/messages"' >> /etc/logrotate.d/messages \
    && echo '    endscript' >> /etc/logrotate.d/messages \
    && echo '    create 0644 root root' >> /etc/logrotate.d/messages \
    && echo '    compress' >> /etc/logrotate.d/messages \
    && echo '    rotate 7' >> /etc/logrotate.d/messages \
    && echo '    dateext' >> /etc/logrotate.d/messages \
    && echo '    dateformat -%Y%m%d' >> /etc/logrotate.d/messages \
    && echo '    maxage 7' >> /etc/logrotate.d/messages \
    && echo '    ifempty' >> /etc/logrotate.d/messages \
    && echo '    sharedscripts' >> /etc/logrotate.d/messages \
    && echo '} ' >> /etc/logrotate.d/messages
CMD ["/usr/sbin/rsyslogd", "-n"]
