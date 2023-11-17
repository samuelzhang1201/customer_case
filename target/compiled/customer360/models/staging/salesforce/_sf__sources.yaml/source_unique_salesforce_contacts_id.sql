
    
    

select
    id as unique_field,
    count(*) as n_records

from "dbt"."public"."contacts"
where id is not null
group by id
having count(*) > 1


