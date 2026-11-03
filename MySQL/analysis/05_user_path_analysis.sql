#没有金额数据
create table rfm as
select user_id,
count(user_id) as 'frequency',
max(dates) as 'latest_time',
(case when count(user_id) > 36 then 5
when count(user_id) > 27 then 4
when count(user_id) > 18 then 3
when count(user_id) > 9 then 2
else 1 end) as 'fscore',
(case when max(dates) = '2017-12-03' then 5
when max(dates) in ('2017-12-01','2017-12-02') then 4
when max(dates) in ('2017-11-29','2017-11-30') then 3
when max(dates) in ('2017-11-27','2017-11-28') then 2
else 1 end) as 'rscore'
from user_behavior
where behavior_type='buy'
group by user_id
order by 2 desc,3 desc;

select avg(fscore) into @f_avg from rfm;
select avg(rscore) into @r_avg from rfm;

select *,(case when fscore>@f_avg and rscore>@r_avg then '价值用户'
when fscore>@f_avg and rscore<@r_avg then '保持用户'
when fscore<@f_avg and rscore>@r_avg then '发展用户'
when fscore<@f_avg and rscore<@r_avg then '挽留用户'
end) class
from rfm;