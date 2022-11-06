#继承3.2.2节构建镜像
FROM cluster_hadoop:1.0
#复制hive文件到镜像/opt目录下
ADD apache-hive-3.1.3-bin.tar.gz /opt
#授予/opt/data/hive, rw权限
RUN mv /opt/apache-hive-3.1.3-bin/ /opt/hive/ && \
mkdir -p /opt/data/hive_resources /opt/data/hive && \
chmod 666 /opt/data/hive
#声明两个变量
ENV HIVE_HOME /opt/hive
ENV PATH ${HIVE_HOME}/bin:$PATH
#目录切换到/opt/hive/conf
WORKDIR /opt/hive/conf
RUN mv hive-default.xml.template hive-site.xml && \
mv hive-log4j2.properties.template hive-log4j2.properties
#用sed替换hive-site.xml的配置项
RUN sed -i "s? \${system:java.io.tmpdir}? /opt/data? g" hive-site.xml && \
sed -i "s? \${system:user.name}? hive? g" hive-site.xml
# RUN rm /opt/hadoop/share/hadoop/yarn/lib/jline-0.9.94.jar && \
# cp -r /opt/hive/lib/jline-2.12.jar /opt/hadoop/share/hadoop/yarn/lib
WORKDIR /opt
#运行容器，启动SSH服务
CMD [ "sh", "-c", "service ssh start; bash"]
