-- 商品类目分析（条形图）
select category_id,
	sum(case when behavior_type = 'pv' then 1 end) `pv_cnt`,
	sum(case when behavior_type = 'fav' then 1 end) `fav_cnt`,
	sum(case when behavior_type = 'cart' then 1 end) `cart_cnt`,
	sum(case when behavior_type = 'buy' then 1 end) `buy_cnt`,
	count(distinct case when behavior_type = 'buy' then user_id end) `buyer_cnt`
from user_behavior
group by category_id
order by buyer_cnt desc
limit 10;