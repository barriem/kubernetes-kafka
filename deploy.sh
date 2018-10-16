#! bin/bash

declare -a arr=(
	"./configure/aws-storageclass-broker-gp2.yml" 
	"./configure/aws-storageclass-zookeeper-gp2.yml" 
	"00-namespace.yml"
	"./rbac-namespace-default"
	"./zookeeper"
	"./kafka"
	"./outside-services"
	"./yahoo-kafka-manager")

for i in $(seq 0 2);
do
  cat volumes/kafka-volume-template.yml | sed "s/\$ITEM/$i/" | kubectl apply -f -
done

for i in $(seq 0 2);
do
  cat volumes/zookeeper-volume-template.yml | sed "s/\$ITEM/$i/" | kubectl apply -f -
done

for i in "${arr[@]}"
do
   kubectl apply -f $i
done