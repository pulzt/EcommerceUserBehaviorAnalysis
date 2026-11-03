select a.dates,count(distinct a.user_id) as uv,count(distinct b.user_id) as next_day_uv,
count(distinct b.user_id)/count(distinct a.user_id) as next_day_return_rate
from user_behavior a
left join user_behavior b
on a.user_id = b.user_id
and b.dates = date_add(a.dates,interval 1 day)
and b.behavior_type = 'pv'
where a.behavior_type = 'pv'
group by a.dates
order by a.dates;