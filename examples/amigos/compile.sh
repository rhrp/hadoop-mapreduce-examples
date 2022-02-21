#Compilar
../../../bin/hadoop com.sun.tools.javac.Main AmigoComum.java
jar cf wc.jar AmigoComum*.class

# Coloca em execução
../../../bin/hadoop jar wc.jar AmigoComum /teste/amigos/input /teste/amigos/output  -Dmapreduce.map.log.level=DEBUG

# Apresenta o resultado
../../../bin/hadoop fs -cat /teste/amigos/output/part-r-00000

# Elimina o output e binarios das classes
../../../bin/hadoop fs -rm -r  /teste/amigos/output
rm *.class
