#Apenas a primeira vez
#bin/hdfs namenode -format <cluster_name>

#Start the HDFS NameNode with the following command on the designated node as hdfs:
bin/hdfs --daemon start namenode

#Start a HDFS DataNode with the following command on each designated node as hdfs:
bin/hdfs --daemon start datanode

#Start the YARN with the following command, run on the designated ResourceManager as yarn:
bin/yarn --daemon start resourcemanager
#Run a script to start a NodeManager on each designated host as yarn:
bin/yarn --daemon start nodemanager
#Start a standalone WebAppProxy server. Run on the WebAppProxy server as yarn. If multiple servers are used with load balancing it should be run on each of them:
bin/yarn --daemon start proxyserver

#Start the MapReduce JobHistory Server with the following command, run on the designated server as mapred:
bin/mapred --daemon start historyserver
