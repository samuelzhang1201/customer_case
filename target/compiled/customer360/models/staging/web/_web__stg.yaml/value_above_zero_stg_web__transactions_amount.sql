
    select 
    * 
    from "dbt"."staging"."stg_web__transactions"
    where amount <= 0
