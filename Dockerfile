FROM centos:7.9.2009
RUN curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
RUN curl -o /etc/yum.repos.d/epel.repo http://mirrors.aliyun.com/repo/epel-7.repo
RUN yum -y install  telnet   inetutils-ping  curl  net-tools vim nmap nc
CMD echo "this is tool registry from centos7" > /tmp/test.txt && tail -f /tmp/test.txt
