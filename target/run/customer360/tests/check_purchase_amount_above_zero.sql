select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      select
	new_id
from
	"dbt"."marts"."customers"
where 
    "Apps & Games_amount"+"Beauty_amount"+ "Books_amount"+ "Clothing, Shoes & Accessories_amount"+ "Movies & TV_amount"+ "Sports, Fitness & Outdoors_amount"+"Kitchen_amount" <= 0
      
    ) dbt_internal_test