select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select new_id
from "dbt"."public"."stg_sf__contacts"
where new_id is null



      
    ) dbt_internal_test