bag1 = load '/home/hduser/Downloads/pig project/2000.txt' using PigStorage(',') as (id:int, name:chararray, jan:double, feb:double, march:double, april:double, may:double, june:double, july:double, august:double, september:double, october:double, november:double, december:double);

bag2 = load '/home/hduser/Downloads/pig project/2001.txt' using PigStorage(',') as (id:int, name:chararray, jan:double, feb:double, march:double, april:double, may:double, june:double, july:double, august:double, september:double, october:double, november:double, december:double);

bag3 = load '/home/hduser/Downloads/pig project/2002.txt' using PigStorage(',') as (id:int, name:chararray, jan:double, feb:double, march:double, april:double, may:double, june:double, july:double, august:double, september:double, october:double, november:double, december:double);

newbag1 = foreach bag1 generate id, name, ($2+$3+$4+$5+$6+$7+$8+$9+$10+$11+$12+$13);

newbag2 = foreach bag2 generate id, name, ($2+$3+$4+$5+$6+$7+$8+$9+$10+$11+$12+$13);

newbag3 = foreach bag3 generate id, name, ($2+$3+$4+$5+$6+$7+$8+$9+$10+$11+$12+$13);

--dump newbag2;

--dump newbag3;

joined = join newbag1 by $0, newbag2 by $0, newbag3 by $0;

--dump joined;

net_join = foreach joined generate $0, $1, $2, $5, $8;

--dump net_join;

growth = foreach net_join generate $0, $1, ($3 - $2)/$2 * 100, ($4 - $3)/$3 * 100;


--dump growth;

average = foreach growth generate $0, $1, ROUND_TO(($2 + $3)/ 2,2);

--dump  average;

final = filter average by $2 >= 10.00;

--dump final;

finalans2 = filter average by $2 <= -5.00;

--dump finalans2;

sales = foreach net_join generate $0, $1,($2 + $3 + $4);

--dump sales;

salesorder = order sales by $2;

--dump salesorder;

bottom5 = limit salesorder 5;

--dump bottom5;


order1 = order sales by $2 desc;

top5 = limit order1 5;

dump top5;
