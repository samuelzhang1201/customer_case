
      
  
    

  create  table "dbt"."staging"."stg_web__transactions__dbt_tmp"
  
  
    as
  
  (
    


with source as (
    select * from "dbt"."public"."transactions"



),

renamed as (
    select
        id,
        contact_id,
        

    

        to_timestamp(transaction_date,'YYYY-MM-DD HH24:MI:SS.MS') :: timestamp at TIME zone 'UTC'

    

 as transaction_date,
        amount,
        item_count,
        category, 
        _loaded_at_utc,
        '80fa3c74-9845-4286-b629-8fef3a2a244b' as batch_id
    from source
    where contact_id in (select new_id from "dbt"."staging"."stg_sf__contacts")       
)

select * from renamed
  );
  
  