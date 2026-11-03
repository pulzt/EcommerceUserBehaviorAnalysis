#已有数据文件：UserBehavior.csv
#启动MySQL Command Line Client（MySQL命令行）
show variables like '%secure%';
#若不为OFF须手动修改MySQL Server路径下的my.ini文件：secure_file_priv=''
#修改后重启MySQL所有程序
show variables like 'local_infile';
set global local_infile = on;
#创建
create database taobao;
create table user_behavior_raw(
user_id int,item_id int,category_id int,behavior_type varchar(5),timestamps int);
#导入前须手动将数据集UserBehavior.csv放到MySQL Server路径下的taobao文件夹里，后期可优化该操作
#正式导入
load data infile 'UserBehavior.csv' into table user_behavior_raw fields terminated by ',' lines terminated by '\n';
#导入耗时约7分钟；