-- RFM（无金额数据，实际做R/F）
with 
t1 as (
	select user_id,datediff((select max(dates) from user_behavior),max(dates)) `r`,count(*) `f`
	from user_behavior
	where behavior_type = 'buy'
	group by user_id ),
t2 as (
	select *,ntile(5) over(order by r desc) `r_score`,ntile(5) over(order by f asc) `f_score`
	from t1 ),
t3 as (
	select *,case
	when r_score >= 4 and f_score >= 4 then 'Important Value Users'
	when r_score >= 4 and f_score < 4 then 'Important Growth Users'
	when r_score < 4 and f_score >= 4 then 'Important Retention Users'
	else 'General Value Users' end `user_type`
	from t2 )
select user_type,count(*) `count`,count(*)/sum(count(*)) over() `ratio`
from t3
group by user_type;