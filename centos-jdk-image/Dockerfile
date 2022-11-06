FROM --platform=linux/amd64 centos:7.9.2009
#将JDK文件放到镜像/opt目录下，add命令会自动解压
ADD ./jdk-8u201-linux-x64.tar.gz /opt/
#重命名解压后的JDK文件目录
RUN mv /opt/jdk1.8.0_201 /opt/java
#创建环境变量，同Linux中的export命令
ENV JAVA_HOME /opt/java
ENV JRE_HOME ${JAVA_HOME}/jre
ENV CLASSPATH .:${JAVA_HOME}/lib:${JRE_HOME}/lib
ENV PATH $PATH:$JAVA_HOME/bin
