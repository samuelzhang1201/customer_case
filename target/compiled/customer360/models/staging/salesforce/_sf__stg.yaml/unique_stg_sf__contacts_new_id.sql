
    
    

select
    new_id as unique_field,
    count(*) as n_records

from "dbt"."public"."stg_sf__contacts"
where new_id is not null
group by new_id
having count(*) > 1


