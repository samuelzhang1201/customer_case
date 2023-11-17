
  create view "dbt"."public"."contacts_joined_with_transactions__dbt_tmp"
    
    
  as (
    SELECT 
    contacts.*,
    transactions.id as transaction_id,
    transactions.transaction_date,
    transactions.amount,
    transactions.item_count,
    transactions.category
FROM "dbt"."public"."stg_web__transactions" as transactions
LEFT JOIN "dbt"."public"."stg_sf__contacts" as contacts ON contacts.new_id = transactions.contact_id
  );