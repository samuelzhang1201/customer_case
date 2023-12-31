with pivot_table as (
select
	new_id,
	min(transaction_date::date) as first_date
from
	{{ ref('contacts_joined_with_transactions') }}
	group by 1
)
, comparing_table as (
select
	a.new_id,
	a.first_purchase_date,
	b.first_date
from
	{{ ref('customers') }} a 
left join 
pivot_table b
on a.new_id = b.new_id
)
select 
*
from comparing_table
where 
first_purchase_date <> first_date