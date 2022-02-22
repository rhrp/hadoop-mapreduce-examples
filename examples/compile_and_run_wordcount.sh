# Compile
${HADOOP_HOME}/bin/hadoop com.sun.tools.javac.Main src/main/rhp/hadoop/examples/WordCount.java  -d target/classes
jar cvf wordcount.jar -C target/classes/  rhp/hadoop/examples/

# Put input data into hdfs
${HADOOP_HOME}/bin/hdfs dfs -mkdir -p /examples/wc/input
${HADOOP_HOME}/bin/hdfs dfs -put src/resources/wordcount/*.txt /examples/wc/input

# run the app
${HADOOP_HOME}/bin/hadoop jar commonfriends.jar rhp.hadoop.examples.WordCount /examples/wc/input /examples/wc/output  -Dmapreduce.map.log.level=DEBUG

# Present the results
${HADOOP_HOME}/bin/hadoop fs -cat /examples/wc/output/part-r-00000

# Clean the output and binaries
${HADOOP_HOME}/bin/hadoop fs -rm -r  /examples/wc/output
rm wordcount.jar
rm target/classes/rhp -rf
