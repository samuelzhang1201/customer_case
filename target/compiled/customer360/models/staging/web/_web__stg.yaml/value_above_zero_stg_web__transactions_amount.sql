
    select 
    * 
    from "dbt"."public"."stg_web__transactions"
    where amount <= 0
