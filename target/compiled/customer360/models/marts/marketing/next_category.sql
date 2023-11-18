with next_purcase as (
select
	contact_id,
	transaction_date,
	item_count,
	category,
	lead(category) over(partition by contact_id order by transaction_date ) as next_category
from
	"dbt"."staging"."stg_web__transactions"
)
select 
category 
, next_category
, count(distinct contact_id) as cust_count
from 
next_purcase
where next_category is not null
group by 1,2