select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      with pivot_table as (
select
	new_id,
	min(transaction_date::date) as first_date
from
	"dbt"."marts"."contacts_joined_with_transactions"
	group by 1
)
, comparing_table as (
select
	a.new_id,
	a.first_purchase_date,
	b.first_date
from
	"dbt"."marts"."customers" a 
left join 
pivot_table b
on a.new_id = b.new_id
)
select 
*
from comparing_table
where 
first_purchase_date <> first_date
      
    ) dbt_internal_test