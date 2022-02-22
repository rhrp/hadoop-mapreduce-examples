# Compile
${HADOOP_HOME}/bin/hadoop com.sun.tools.javac.Main src/main/rhp/hadoop/examples/CommonFriends.java  -d target/classes
jar cvf commonfriends.jar -C target/classes/  rhp/hadoop/examples/

# Put input data into hdfs
${HADOOP_HOME}/bin/hdfs dfs -mkdir -p /examples/amigos/input
${HADOOP_HOME}/bin/hdfs dfs -put src/resources/commonfriends/amigos.txt /examples/amigos/input

# run the app
${HADOOP_HOME}/bin/hadoop jar commonfriends.jar rhp.hadoop.examples.CommonFriends /examples/amigos/input /examples/amigos/output  -Dmapreduce.map.log.level=DEBUG

# Present the results
${HADOOP_HOME}/bin/hadoop fs -cat /examples/amigos/output/part-r-00000

# Clean the output and binaries
${HADOOP_HOME}/bin/hadoop fs -rm -r  /examples/amigos/output
rm commonfriends.jar
rm  target/classes/rhp -rf
