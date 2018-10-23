A = load '/home/rajamv9497/PIG/purchase.txt' using PigStorage(',') as (prod:int, pqty:int);
B = load '/home/rajamv9497/PIG/sales.txt' using PigStorage(',') as (prod:int, sqty:int);

C = cogroup A by $0, B by $0;
D = foreach C generate group, SUM(A.pqty), SUM(B.sqty);


PigStorage, TextLoader,BinStorage

prod
bag containing data from A
bag containing data from B

cogroup means create ind groups and join them together


(101,{(101,30),(101,20)},{(101,40),(101,30)})
(102,{(102,40),(102,25)},{(102,50),(102,30)})
(105,{},{(105,100)})
(106,{},{(106,120)})
(107,{(107,500)},{})
(108,{(108,1000)},{})

group,sum:

=========
A = load '/home/rajamv9497/PIG/purchase.txt' using PigStorage(',') as (prod:int, pqty:int);
A1 = group A by ($0,$1); 
A2 = foreach A1 generate group, SUM(A.$1);

(101,50)
(102,65)
(107,500)
(108,1000)
---------------------------
A = load '/home/rajamv9497/PIG/purchase.txt' using PigStorage(',') as (prod:int, pqty:int);
A1 = group A all;
A2 = foreach A1 generate group, SUM(A.$1),AVG(A.$1),COUNT(A.$1),MAX(A.$1);


(all,1615,269.1666666666667,6,1000)




union:
-----------------------------------------------

A = load '/home/rajamv9497/PIG/purchase.txt' using PigStorage(',') as (prod:int, pqty:int);
B = load '/home/rajamv9497/PIG/purchase.txt' using PigStorage(',') as (prod:int, sqty:int);
C= union A,B;


(101,30)
(101,20)
(102,30)
(102,25)
(101,40)
(101,30)
(102,50)
(102,40)
(105,100)
(107,500)
(106,120)
(108,1000)




C= cross A,B;

(108,1000,106,120)
(108,1000,105,100)
(108,1000,102,50)
(108,1000,101,40)
(108,1000,102,30)
(108,1000,101,30)
(107,500,106,120)
(107,500,105,100)
(107,500,102,50)
(107,500,101,40)
(107,500,102,30)
(107,500,101,30)
(102,40,106,120)
(102,40,105,100)
(102,40,102,50)
(102,40,101,40)
(102,40,102,30)
(102,40,101,30)
(101,30,106,120)
(101,30,105,100)
(101,30,102,50)
(101,30,101,40)
(101,30,102,30)
(101,30,101,30)
(102,25,106,120)
(102,25,105,100)
(102,25,102,50)
(102,25,101,40)
(102,25,102,30)
(102,25,101,30)
(101,20,106,120)
(101,20,105,100)
(101,20,102,50)
(101,20,101,40)
(101,20,102,30)
(101,20,101,30)

----------------------------
join:
=====
C = join A by $0, B by $0;
dump C;

(101,30,101,40)
(101,30,101,30)
(101,20,101,40)
(101,20,101,30)
(102,40,102,50)
(102,40,102,30)
(102,25,102,50)
(102,25,102,30) 


C = join A by $0 left outer, B by $0;


(101,30,101,40)
(101,30,101,30)
(101,20,101,40)
(101,20,101,30)
(102,40,102,50)
(102,40,102,30)
(102,25,102,50)
(102,25,102,30)
(107,500,,)
(108,1000,,)

C = join A by $0 right outer, B by $0;


(101,30,101,40)
(101,30,101,30)
(101,20,101,40)
(101,20,101,30)
(102,40,102,50)
(102,40,102,30)
(102,25,102,50)
(102,25,102,30)
(,,105,100)
(,,106,120)

C = join A by $0 full outer, B by $0;

(101,30,101,40)
(101,30,101,30)
(101,20,101,40)
(101,20,101,30)
(102,40,102,50)
(102,40,102,30)
(102,25,102,50)
(102,25,102,30)
(,,105,100)
(,,106,120)
(107,500,,)
(108,1000,,)






prod id, total purchase qty, # of tran, total sales qty, # of sales trans
C = cogroup A by $0, B by $0;
D = foreach C generate group, SUM(A.pqty),COUNT(A), SUM(B.sqty), COUNT(B);


by using co-group
-----------------
txns1.txt and custs

find the total count of transactions, value of those transactions and first name of the customer


John	5	800
Smith	8	700

txn = load '/home/rajamv9497/Hadooppractice/Inputfile/txns1.txt' using PigStorage(',') as (txnid, txndate, custno:chararray, amount:double, cat, prod, city, state, type);

cust = Load '/home/rajamv9497/Hadooppractice/Inputfile/custs.txt' using PigStorage(',') as (custno:chararray, firstname:chararray, lastname, age:int, profession:chararray);

txn = foreach txn generate custno, amount;
cust = foreach cust generate custno, firstname;

joined = cogroup cust by $0, txn by $0;

final = foreach joined generate cust.firstname, COUNT(txn), ROUND_TO(SUM(txn.amount),2);












