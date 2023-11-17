select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      select
	new_id
from
	"dbt"."marts"."customers"
where
	new_id not in (
	select
		new_id
	from
		"dbt"."staging"."stg_sf__contacts"
    )
      
    ) dbt_internal_test