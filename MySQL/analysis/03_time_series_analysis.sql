select dates,hours,
sum(case when behavior_type = 'pv' then 1 else 0 end) as `pv`,
sum(case when behavior_type = 'cart' then 1 else 0 end) as `cart`,
sum(case when behavior_type = 'fav' then 1 else 0 end) as `fav`,
sum(case when behavior_type = 'buy' then 1 else 0 end) as `buy`
from user_behavior
group by dates,hours
order by dates,hours;