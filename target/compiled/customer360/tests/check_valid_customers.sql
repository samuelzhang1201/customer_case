select
	new_id
from
	"dbt"."public"."customers"
where
	new_id not in (
	select
		new_id
	from
		"dbt"."public"."stg_sf__contacts"
    )