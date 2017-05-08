#!/bin/bash

seed_ip=$1
echo "Seed Node: $seed_ip"

node_ip=`hostname -i`
echo "Node_ip: $node_ip"

sed -i "s/seeds: \"127.0.0.1\"/seeds: $seed_ip/" /app/cassandra/apache-cassandra-3.0.12/conf/cassandra.yaml.bak
sed -i "s/listen_address: localhost/listen_address: $node_ip/" /app/cassandra/apache-cassandra-3.0.12/conf/cassandra.yaml.bak
sed -i "s/rpc_address: localhost/rpc_address: $node_ip/" /app/cassandra/apache-cassandra-3.0.12/conf/cassandra.yaml.bak
sed -i 's/endpoint_snitch: SimpleSnitch/endpoint_snitch: GossipingPropertyFileSnitch/' /app/cassandra/apache-cassandra-3.0.12/conf/cassandra.yaml.bak

cp /etc/profile /etc/profile.bak
sed -i '$ a\export JAVA_HOME=/usr/lib/jvm/jre' /etc/profile
sed -i '$ a\export CASSANDRA_HOME = /app/cassandra/apache-cassandra-3.0.12' /etc/profile
sed -i '$ a\export PATH=$PATH:$JAVA_HOME/bin:$CASSANDRA_HOME/bin' /etc/profile
sed -i '$ a\export CLASSPATH=.:$JAVA_HOME/lib' /etc/profile
