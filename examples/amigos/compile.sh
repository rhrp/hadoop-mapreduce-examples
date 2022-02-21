#Compilar
${HADOOP_HOME}/bin/hadoop com.sun.tools.javac.Main AmigoComum.java
jar cf wc.jar AmigoComum*.class

# Coloca em execução
${HADOOP_HOME}/bin/hadoop jar wc.jar AmigoComum /examples/amigos/input /examples/amigos/output  -Dmapreduce.map.log.level=DEBUG

# Apresenta o resultado
${HADOOP_HOME}/bin/hadoop fs -cat /examples/amigos/output/part-r-00000

# Elimina o output e binarios das classes
${HADOOP_HOME}/bin/hadoop fs -rm -r  /examples/amigos/output
rm *.class
