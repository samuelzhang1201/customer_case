select
	new_id
from
	"dbt"."marts"."customers"
where 
    "Apps & Games_amount"+"Beauty_amount"+ "Books_amount"+ "Clothing, Shoes & Accessories_amount"+ "Movies & TV_amount"+ "Sports, Fitness & Outdoors_amount"+"Kitchen_amount" <= 0