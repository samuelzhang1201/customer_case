SELECT 
    contacts.*,
    transactions.id as transaction_id,
    transactions.transaction_date,
    transactions.amount,
    transactions.item_count,
    transactions.category
FROM "dbt"."staging"."stg_web__transactions" as transactions
LEFT JOIN "dbt"."staging"."stg_sf__contacts" as contacts ON contacts.new_id = transactions.contact_id