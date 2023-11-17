with pivot_table as (
select
	new_id,
	max(transaction_date::date) as last_date
from
	"dbt"."public"."contacts_joined_with_transactions"
	group by 1
)
, comparing_table as (
select
	a.new_id,
	a.last_purchase_date,
	b.last_date
from
	"dbt"."public"."customers" a 
left join 
pivot_table b
on a.new_id = b.new_id
)
select 
*
from comparing_table
where 
last_purchase_date <> last_date