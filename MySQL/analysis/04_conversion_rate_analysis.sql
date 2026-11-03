#日度-用户购买转化率：
select dates,
count(distinct case when behavior_type = 'buy' then user_id end)/count(distinct case when behavior_type = 'pv' then user_id end) as buy_conversion_rate
from user_behavior
group by dates
order by dates;
#日度-行为购买转化率：
select dates,
sum(case when behavior_type = 'buy' then 1 else 0 end)/sum(case when behavior_type = 'pv' then 1 else 0 end) as buy_conversion_rate
from user_behavior
group by dates
order by dates;