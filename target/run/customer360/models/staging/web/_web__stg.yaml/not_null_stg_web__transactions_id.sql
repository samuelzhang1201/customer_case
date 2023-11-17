select
      count(*) as failures,
      count(*) >0 as should_warn,
      count(*) >5 as should_error
    from (
      
    
    



select id
from "dbt"."public"."stg_web__transactions"
where id is null



      
    ) dbt_internal_test