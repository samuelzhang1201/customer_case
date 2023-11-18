{{
    config(
        materialized='incremental',
        unique_key = 'id',
        on_schema_change = 'append_new_columns'
    )
}}


with source as (
    select * from {{ source('web','transactions') }}

{% if is_incremental() %}

  where _loaded_at_utc > (select max(_loaded_at_utc) from {{ this }})

{% endif %}

),

renamed as (
    select
        id,
        contact_id,
        {{ as_timestamp_utc('transaction_date') }} as transaction_date,
        amount,
        item_count,
        category, 
        _loaded_at_utc,
        '{{ invocation_id }}' as batch_id
    from source
    where contact_id in (select new_id from {{ ref('stg_sf__contacts') }})       
)

select * from renamed

