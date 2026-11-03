#日度PUV
select dates,count(*) as `pv`,count(distinct user_id) as `uv`,
count(*)/count(distinct user_id) as `puv`
from user_behavior
where behavior_type = 'pv'
group by dates
order by dates;
#小时PUV
select hours,count(*) as `pv`,count(distinct user_id) as `uv`,
count(*)/count(distinct user_id) as `puv`
from user_behavior
where behavior_type = 'pv'
group by hours
order by hours;