select
	new_id
from
	{{ ref('customers') }}
where
	new_id not in (
	select
		new_id
	from
		{{ ref('stg_sf__contacts') }}
    )