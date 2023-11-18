with combo as (
select
	a.contact_id,
	a.category as cate_01
	, b.category as cate_02
from
	{{ ref('stg_web__transactions') }} a 
join 
    {{ ref('stg_web__transactions') }} b
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