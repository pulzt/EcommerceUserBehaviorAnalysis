-- 正式开始分析前可以在纸上预设Dashboard，根据所需指标优化工作流

-- 基本描述性分析（卡片图）PV、UV、购买用户数、购买行为数、购买转化率（购买用户数/UV）
select
	count(case when behavior_type = 'pv' then behavior_type end) `total_pv`,
	count(distinct user_id) `total_uv`,
	count(distinct case when behavior_type = 'buy' then user_id end) `total_buyers`,
	count(case when behavior_type = 'buy' then behavior_type end) `total_buy_cnt`,
	count(distinct case when behavior_type = 'buy' then user_id end)/count(distinct user_id) `conversion_rate`
from user_behavior;
