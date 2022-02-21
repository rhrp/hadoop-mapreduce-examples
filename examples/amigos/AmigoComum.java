import java.io.IOException;
import java.util.StringTokenizer;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.mapreduce.Reducer;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class AmigoComum
{
  private static Logger logger = LoggerFactory.getLogger(AmigoComum.class);

  public static class TokenizerMapper extends Mapper<Object, Text, Text, IntWritable>
  {
     private final static IntWritable one = new IntWritable(1);
     private Text word = new Text();

    /**
     * Produz um mapa Amigo
     */ 
     public void map(Object pKey, Text friends, Context context) throws IOException, InterruptedException 
     {
         String[] lPersonFriends = friends.toString().split(":");
         String lPerson=lPersonFriends[0];
         String lListOfFriends=lPersonFriends[1];

         int n=0;
         StringTokenizer itr = new StringTokenizer(lListOfFriends);
         while (itr.hasMoreTokens()) 
         {
           word.set(itr.nextToken());
           context.write(word, one);
           n++;
         }
         logger.info("MAP :: pKey={}  Text={}   Person: {}    List of friends: {}  Total: {}",pKey,friends.toString(),lPerson,lListOfFriends,n);
     }
  }

  public static class IntSumReducer extends Reducer<Text,IntWritable,Text,IntWritable> 
  {
    private IntWritable lResult = new IntWritable();

    public void reduce(Text pKey, Iterable<IntWritable> values,Context context) throws IOException, InterruptedException 
    {
      int sum = 0;
      for (IntWritable val : values) 
      {
        sum += val.get();
        logger.info("REDUCE :: pKey={}  val={}",pKey,val); 
      }
      lResult.set(sum);
      context.write(pKey,lResult);

      logger.info("REDUCE :: pKey={}  result: {}",pKey,lResult);
    }
  }

  public static void main(String[] args) throws Exception 
  {
    Configuration conf = new Configuration();
    Job job = Job.getInstance(conf, "Friends count");
    job.setJarByClass(AmigoComum.class);
    job.setMapperClass(TokenizerMapper.class);
    job.setCombinerClass(IntSumReducer.class);
    job.setReducerClass(IntSumReducer.class);
    job.setOutputKeyClass(Text.class);
    job.setOutputValueClass(IntWritable.class);
    FileInputFormat.addInputPath(job, new Path(args[0]));
    FileOutputFormat.setOutputPath(job, new Path(args[1]));
    System.exit(job.waitForCompletion(true) ? 0 : 1);
  }
}
