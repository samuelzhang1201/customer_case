
    
    

with child as (
    select contact_id as from_field
    from "dbt"."staging"."stg_web__transactions"
    where contact_id is not null
),

parent as (
    select new_id as to_field
    from "dbt"."staging"."stg_sf__contacts"
)

select
    from_field

from child
left join parent
    on child.from_field = parent.to_field

where parent.to_field is null


