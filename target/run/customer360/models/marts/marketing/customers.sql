
  
    

  create  table "dbt"."marts"."customers__dbt_tmp"
  
  
    as
  
  (
    with intermediate as (
SELECT
    new_id,
    gender,
    first_value (transaction_date::date) over(partition by id order by transaction_date) as first_purchase_date,
    last_value (transaction_date::date) over(partition by id order by transaction_date rows between unbounded preceding and unbounded following) as last_purchase_date,
    

    

        date_part('year', age(current_date,birth_date))

    

 AS age,
    case when category = 'Apps & Games' then amount else 0 end as "Apps & Games_amount"
    ,case when category = 'Beauty' then amount else 0 end as "Beauty_amount"
    ,case when category = 'Books' then amount else 0 end as "Books_amount"
    ,case when category = 'Clothing, Shoes & Accessories' then amount else 0 end as "Clothing, Shoes & Accessories_amount"
    ,case when category = 'Movies & TV' then amount else 0 end as "Movies & TV_amount"
    ,case when category = 'Sports, Fitness & Outdoors' then amount else 0 end as "Sports, Fitness & Outdoors_amount"
    ,case when category = 'Kitchen' then amount else 0 end as "Kitchen_amount"
    
FROM "dbt"."marts"."contacts_joined_with_transactions"
)
, final as (
select 
    new_id,
    gender,
    first_purchase_date,
    last_purchase_date,
    age,
    sum("Apps & Games_amount") as "Apps & Games_amount"
    ,sum("Beauty_amount") as "Beauty_amount"
    ,sum("Books_amount") as "Books_amount"
    ,sum("Clothing, Shoes & Accessories_amount") as "Clothing, Shoes & Accessories_amount"
    ,sum("Movies & TV_amount") as "Movies & TV_amount"
    ,sum("Sports, Fitness & Outdoors_amount") as "Sports, Fitness & Outdoors_amount"
    ,sum("Kitchen_amount") as "Kitchen_amount"
    
FROM intermediate 
group by 
1,2,3,4,5
)
select * from final
  );
  