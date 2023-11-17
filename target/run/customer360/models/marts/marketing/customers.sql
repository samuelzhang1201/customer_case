
  
    

  create  table "dbt"."public"."customers__dbt_tmp"
  
  
    as
  
  (
    with intermediate as (
SELECT
    id,
    gender,
    first_value (transaction_date::date) over(partition by id order by transaction_date) as first_purchase_date,
    last_value (transaction_date::date) over(partition by id order by transaction_date rows between unbounded preceding and unbounded following) as last_purchase_date,
    date_part('year', age(current_date, birth_date)) AS age,
    case when category = 'Apps & Games' then amount else 0 end as Apps_and_Games_amount,
   	case when category = 'Beauty' then amount else 0 end as Beauty_amount,
   	case when category = 'Books' then amount else 0 end as Books_amount,
   	case when category = 'Clothing' then amount else 0 end as Clothing_amount,
   	case when category = 'Shoes & Accessories' then amount else 0 end as Shoes_and_Accessories_amount,
   	case when category = 'Movies & TV' then amount else 0 end as Movies_and_TV_amount,
   	case when category = 'Sports' then amount else 0 end as Sports_amount,
    case when category = 'Fitness & Outdoors' then amount else 0 end as Fitness_and_Outdoors_amount,
   	case when category = 'Kitchen' then amount else 0 end as Kitchen_amount
FROM "dbt"."public"."contacts_joined_with_transactions"
)
, final as (
select 
    id,
    gender,
    first_purchase_date,
    last_purchase_date,
    age,
    sum(Apps_and_Games_amount) Apps_and_Games_amount,
   	sum(Beauty_amount) Beauty_amount,
   	sum(Books_amount) Books_amount,
   	sum(Clothing_amount) Clothing_amount,
   	sum(Shoes_and_Accessories_amount) Shoes_and_Accessories_amount,
   	sum(Movies_and_TV_amount) Movies_and_TV_amount,
    sum(Sports_amount) Sports_amount,
    sum(Fitness_and_Outdoors_amount) Fitness_and_Outdoors_amount,
   	sum(Kitchen_amount) Kitchen_amount
FROM intermediate 
group by 
1,2,3,4,5
)
select * from final
  );
  