#受限于电脑配置，抽取约1%的数据再作分析（1万个用户、约百万条数据）
#该数据集主要目标是研究用户行为，所以先随机抽取用户，再保留每个用户的完整行为
create table user_behavior as
with id_sample as(
	select distinct user_id
	from user_behavior_raw
	order by rand()
	limit 10000)
select user_behavior_raw.*
from user_behavior_raw
join id_sample
on user_behavior_raw.user_id = id_sample.user_id;
#抽样耗时约3分钟；
