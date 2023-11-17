select
      count(*) as failures,
      count(*) >0 as should_warn,
      count(*) >5 as should_error
    from (
      
    
    



select transaction_id
from "dbt"."marts"."contacts_joined_with_transactions"
where transaction_id is null



      
    ) dbt_internal_test