#继承构建的JDK镜像
FROM centos_jdk:1.0
RUN yum update -y
#安装必要的软件包
RUN yum install -y openssh-server supervisor vim host
#生成SSH的密钥对
RUN ssh-keygen -t rsa -f ~/.ssh/id_rsa -P '' && \
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys &&\
chmod 0600 ~/.ssh/authorized_keys
#ssh_config新增两条配置StrictHostKeyChecking no和UserKnownHostsFile /dev/null
RUN echo "StrictHostKeyChecking no">>/etc/ssh/ssh_config && \
echo "UserKnownHostsFile /dev/null" >>/etc/ssh/ssh_config
#将hadoop包复制到镜像中
ADD hadoop-3.3.4.tar.gz /opt/
RUN mv /opt/hadoop-3.3.4 /opt/hadoop
#将本地的core-site.xml/hdfs-site.xml文件复制到镜像并覆盖对应的文件
COPY hadoop/etc/core-site.xml /opt/hadoop/etc/hadoop
COPY hadoop/etc/hdfs-site.xml /opt/hadoop/etc/hadoop
#替换镜像hadoop-env.sh文件的java_home目录
RUN sed -i "s? JAVA_HOME=\${JAVA_HOME}? JAVA_HOME=/opt/java? g" \
/opt/hadoop/etc/hadoop/hadoop-env.sh
ENV HADOOP_HOME /opt/hadoop
ENV HADOOP_INSTALL=$HADOOP_HOME
ENV HADOOP_MAPRED_HOME=$HADOOP_HOME
ENV HADOOP_COMMON_HOME=$HADOOP_HOME
ENV HADOOP_HDFS_HOME=$HADOOP_HOME
ENV YARN_HOME=$HADOOP_HOME
ENV PATH ${HADOOP_HOME}/bin:${HADOOP_HOME}/sbin:$PATH
EXPOSE 22
ENV HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native
