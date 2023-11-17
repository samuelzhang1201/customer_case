{%- set category_list = ['Apps & Games', 'Beauty', 'Books', 'Clothing, Shoes & Accessories', 'Movies & TV', 'Sports, Fitness & Outdoors','Kitchen']  -%}

with intermediate as (
SELECT
    new_id,
    gender,
    first_value (transaction_date::date) over(partition by id order by transaction_date) as first_purchase_date,
    last_value (transaction_date::date) over(partition by id order by transaction_date rows between unbounded preceding and unbounded following) as last_purchase_date,
    {{ age_in_years('birth_date') }} AS age,
    {% for  category in category_list -%}
    case when category = '{{ category }}' then amount else 0 end as "{{ category }}_amount"
    {% if not loop.last  -%}
      ,
    {%- endif %}
    {%- endfor %}
FROM {{ ref('contacts_joined_with_transactions') }}
)
, final as (
select 
    new_id,
    gender,
    first_purchase_date,
    last_purchase_date,
    age,
    {% for  category in category_list -%}
    sum("{{ category }}_amount") as "{{ category }}_amount"
    {% if not loop.last  -%}
      ,
    {%- endif %}
    {%- endfor %}
FROM intermediate 
group by 
1,2,3,4,5
)
select * from final