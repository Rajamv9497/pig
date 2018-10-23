A = load '/home/rajamv9497/Pigpract/medical.txt' using PigStorage('\t') as (name:chararray,job_des:chararray,salary:double);
register /home/rajamv9497/Pigpract/JarFiles/pigudf.jar;
DEFINE TitleContains myudfs.Search();
B = foreach A generate TitleContains($1,'hr');
dump B;



 
