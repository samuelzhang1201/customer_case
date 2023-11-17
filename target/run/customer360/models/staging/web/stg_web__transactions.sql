
  
    

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
        _loaded_at_utc
    from source
    where contact_id in (select new_id from "dbt"."staging"."stg_sf__contacts")       
)

select * from renamed
  );
  