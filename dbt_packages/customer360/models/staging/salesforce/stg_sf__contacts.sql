
with source as (
    select * from {{ source('salesforce','contacts') }}
),

renamed as (
    select
        id,
        case 
            when row_number() over(partition by id)>1 then concat(id,'-',row_number() over(partition by id)) 
            else id end as new_id,
        username as user_name,
        name,
        gender,
        address, 
        mail as email_address,
        birthdate as birth_date,
        _loaded_at_utc,
        now() as updated_at
    from source     
)

select * from renamed

