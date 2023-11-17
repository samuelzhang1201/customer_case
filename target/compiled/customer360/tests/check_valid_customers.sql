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