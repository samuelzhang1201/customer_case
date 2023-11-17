SELECT
    id,
    gender,
    
    date_part('year', age(current_date, birth_date))
 AS age,
    sum(amount) as total_expense
FROM "dbt"."public"."contacts_joined_with_transactions"
GROUP BY
    1,2,3