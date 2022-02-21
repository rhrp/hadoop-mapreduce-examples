#Stop the NameNode with the following command, run on the designated NameNode as hdfs:
${HADOOP_HOME}/bin/hdfs --daemon stop namenode

#Run a script to stop a DataNode as hdfs:
${HADOOP_HOME}/bin/hdfs --daemon stop datanode

#Stop the ResourceManager with the following command, run on the designated ResourceManager as yarn:
${HADOOP_HOME}/bin/yarn --daemon stop resourcemanager
#Run a script to stop a NodeManager on a worker as yarn:
${HADOOP_HOME}/bin/yarn --daemon stop nodemanager
#Stop the WebAppProxy server. Run on the WebAppProxy server as yarn. If multiple servers are used with load balancing it should be run on each of them:
${HADOOP_HOME}/bin/yarn --daemon stop proxyserver

#Stop the MapReduce JobHistory Server with the following command, run on the designated server as mapred:
${HADOOP_HOME}/bin/mapred --daemon stop historyserver
