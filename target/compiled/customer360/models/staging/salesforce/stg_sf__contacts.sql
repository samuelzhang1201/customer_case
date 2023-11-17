with source as (
    select * from "dbt"."public"."contacts"
),

renamed as (
    select
        id,
        username as user_name,
        name,
        gender,
        address, 
        mail as email_address,
        birthdate as birth_date,
        _loaded_at_utc
    from source     
)

select * from renamed