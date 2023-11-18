
{{
    config(
        materialized ='view',
        post_hook = "REVOKE SELECT ON {{ this }} FROM dbt"      
) }}

with mask_data as (
select
	id,
	new_id,
	user_name,
	"name",
	gender,
	address,
    concat('***',substr(email_address, position('@' in email_address))) AS email_address,
	birth_date,
	"_loaded_at_utc",
	updated_at
from
    {{ ref('stg_sf__contacts') }}
)
select * from mask_data 
