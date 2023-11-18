


with source as (
    select * from "dbt"."public"."transactions"



  where _loaded_at_utc > (select max(_loaded_at_utc) from "dbt"."staging"."stg_web__transactions")



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
        '09a375b1-409d-41b6-a95c-6e62b6822a92' as batch_id
    from source
    where contact_id in (select new_id from "dbt"."staging"."stg_sf__contacts")       
)

select * from renamed