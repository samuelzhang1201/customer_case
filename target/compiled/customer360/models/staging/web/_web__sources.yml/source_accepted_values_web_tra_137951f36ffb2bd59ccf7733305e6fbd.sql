
    
    

with all_values as (

    select
        category as value_field,
        count(*) as n_records

    from "dbt"."public"."transactions"
    group by category

)

select *
from all_values
where value_field not in (
    'Apps & Games','Beauty','Books','Clothing, Shoes & Accessories','Movies & TV','Sports, Fitness & Outdoors'
)


