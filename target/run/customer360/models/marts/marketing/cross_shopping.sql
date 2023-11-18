
  
    

  create  table "dbt"."marts"."cross_shopping__dbt_tmp"
  
  
    as
  
  (
    with combo as (
select
	a.contact_id,
	a.category as cate_01
	, b.category as cate_02
from
	"dbt"."staging"."stg_web__transactions" a 
join 
    "dbt"."staging"."stg_web__transactions" b
on a.contact_id = b.contact_id 
and a.category > b.category 
)
select 
cate_01
,cate_02
, count(distinct contact_id)
from
combo
group by 1,2
order by 3 desc
  );
  