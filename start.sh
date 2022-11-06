#! /bin/bash
N=${1:1}
#在本机上创建一个虚拟网络，master及slaves通过这个网络实现互联
docker network rm -f hadoop_network &> /dev/null
docker network create --driver=bridge hadoop_network
#启动N个从属节点
#--network指定所用的虚拟网络，master和slave节点要指定相同的网络名
#--name指定Docker的容器的名称
#--hostname指定的容器的主机名
i=1
while [ $i -lt $N ]
do
    sudo docker rm -f slave$i &> /dev/null
    echo "start slave$i container..."
    sudo docker run -itd \
                    --network=hadoop_network \
                    --platform linux/amd64 \
                    --name slave$i \
                    --hostname slave$i \
                    cluster_hive:1.0  &> /dev/null
    i=$(( $i + 1 ))
done
# start hadoop master container
sudo docker rm -f master &> /dev/null
echo "start master container..."
sudo docker run -itd \
            --network=hadoop_network \
            --platform linux/amd64 \
            -p 50070:50070 \
            -p 8088:8088 \
            --name master \
            --hostname master \
            cluster_hive:1.0 &> /dev/null
#进入master节点
sudo docker exec -it master bash
