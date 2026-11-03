#数据量级变小，不必再使用MySQL Command Line Client，采用Workbench等工具更加方便
#数据清洗时涉及删除等操作，提前备份，临时关闭安全模式
use taobao;
create table user_behavior_copy like user_behavior;
set sql_safe_updates = 0;
#查空
select * from user_behavior
where user_id is null or item_id is null or category_id is null or behvior_type is null or timestamps is null;
#去空
delete * from user_behavior
where user_id is null or item_id is null or category_id is null or behvior_type is null or timestamps is null;
#查重
select user_id,item_id,category_id,behavior_type,timestamps
from user_behavior
group by user_id,item_id,category_id,behavior_type,timestamps
having count(*) > 1;
#去重
create table temp as(select distinct * from user_behavior);
drop table user_behavior;
rename table temp to user_behavior;
#转换时间戳：
alter table user_behavior add datetimes timestamp;
update user_behavior set datetimes = from_unixtime(timestamps);
alter table user_behavior add column dates date;
alter table user_behavior add column times time;
alter table user_behavior add column hours int;
update user_behavior set dates = date(datetimes);
update user_behavior set times = time(datetimes);
update user_behavior set hours = hour(datetimes);
#查异常：
select max(datetimes),min(datetimes) from user_behavior;
#去异常：
delete from user_behavior
where datetimes < '2017-11-25 00:00:00' or datetimes > '2017-12-03 23:59:59';