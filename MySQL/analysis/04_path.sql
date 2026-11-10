-- 三种行为路径分析（互斥）（严格时间顺序）
with
temp_1 as (
	select user_id,item_id,min(timestamps) `first_pv`
	from user_behavior
	where behavior_type = 'pv'
	group by user_id,item_id),
temp_2 as (
	select temp_1.user_id,temp_1.item_id,temp_1.first_pv,
	min(case when user_behavior.behavior_type = 'fav' then timestamps end) `fav_time`,
	min(case when user_behavior.behavior_type = 'cart' then timestamps end) `cart_time`,
	min(case when user_behavior.behavior_type = 'buy' then timestamps end) `buy_time`
	from temp_1
	left join user_behavior
	on temp_1.user_id = user_behavior.user_id
	and temp_1.item_id = user_behavior.item_id
	and temp_1.first_pv < user_behavior.timestamps
	group by temp_1.user_id,temp_1.item_id,temp_1.first_pv),
temp_3 as (
	select *,
	case when buy_time is not null and (cart_time is null or buy_time < cart_time) and (fav_time is null or buy_time < fav_time) then 1 end `direct_buy`,
	case when buy_time is not null and cart_time is not null and cart_time < buy_time and (fav_time is null or buy_time < fav_time) then 1 end `cart_buy`,
	case when buy_time is not null and fav_time is not null and fav_time < buy_time and (cart_time is null or buy_time < cart_time) then 1 end `fav_buy`
	from temp_2)
select 'direct_buy' `conversion_path`,sum(direct_buy) `converted_count`,count(*) `start_count`,sum(direct_buy)/count(*) `conversion_rate`
from temp_3
union all
select 'fav_buy',sum(fav_buy),sum(case when fav_time is not null then 1 end),sum(fav_buy)/sum(case when fav_time is not null then 1 end)
from temp_3
union all
select 'cart_buy',sum(cart_buy),sum(case when cart_time is not null then 1 end),sum(cart_buy)/sum(case when cart_time is not null then 1 end)
from temp_3;