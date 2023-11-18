
  create view "dbt"."staging"."masked_contact__dbt_tmp"
    
    
  as (
    

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
    "dbt"."staging"."stg_sf__contacts"
)
select * from mask_data
  );