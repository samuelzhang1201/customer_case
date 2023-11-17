
    
    

select
    transaction_id as unique_field,
    count(*) as n_records

from "dbt"."marts"."contacts_joined_with_transactions"
where transaction_id is not null
group by transaction_id
having count(*) > 1


