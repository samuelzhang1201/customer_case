select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    select 
    * 
    from "dbt"."staging"."stg_web__transactions"
    where amount <= 0

      
    ) dbt_internal_test