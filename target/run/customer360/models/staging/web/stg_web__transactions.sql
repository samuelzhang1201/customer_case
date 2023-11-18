
      
        
            delete from "dbt"."staging"."stg_web__transactions"
            where (
                id) in (
                select (id)
                from "stg_web__transactions__dbt_tmp150447732651"
            );

        
    

    insert into "dbt"."staging"."stg_web__transactions" ("id", "contact_id", "transaction_date", "amount", "item_count", "category", "_loaded_at_utc", "batch_id")
    (
        select "id", "contact_id", "transaction_date", "amount", "item_count", "category", "_loaded_at_utc", "batch_id"
        from "stg_web__transactions__dbt_tmp150447732651"
    )
  