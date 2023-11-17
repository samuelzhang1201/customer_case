{% snapshot stg_sf__contacts_snapshot %}

{{
        config(
            target_schema = 'snapshots',
            unique_key = 'new_id',
            strategy = 'timestamp',
            updated_at = 'updated_at'
        )
}}



select * from {{ref('stg_sf__contacts')}}

{% endsnapshot %}

