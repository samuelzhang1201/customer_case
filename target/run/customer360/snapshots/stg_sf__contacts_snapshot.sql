
      update "dbt"."snapshots"."stg_sf__contacts_snapshot"
    set dbt_valid_to = DBT_INTERNAL_SOURCE.dbt_valid_to
    from "stg_sf__contacts_snapshot__dbt_tmp142106052175" as DBT_INTERNAL_SOURCE
    where DBT_INTERNAL_SOURCE.dbt_scd_id::text = "dbt"."snapshots"."stg_sf__contacts_snapshot".dbt_scd_id::text
      and DBT_INTERNAL_SOURCE.dbt_change_type::text in ('update'::text, 'delete'::text)
      and "dbt"."snapshots"."stg_sf__contacts_snapshot".dbt_valid_to is null;

    insert into "dbt"."snapshots"."stg_sf__contacts_snapshot" ("id", "new_id", "user_name", "name", "gender", "address", "email_address", "birth_date", "_loaded_at_utc", "updated_at", "dbt_updated_at", "dbt_valid_from", "dbt_valid_to", "dbt_scd_id")
    select DBT_INTERNAL_SOURCE."id",DBT_INTERNAL_SOURCE."new_id",DBT_INTERNAL_SOURCE."user_name",DBT_INTERNAL_SOURCE."name",DBT_INTERNAL_SOURCE."gender",DBT_INTERNAL_SOURCE."address",DBT_INTERNAL_SOURCE."email_address",DBT_INTERNAL_SOURCE."birth_date",DBT_INTERNAL_SOURCE."_loaded_at_utc",DBT_INTERNAL_SOURCE."updated_at",DBT_INTERNAL_SOURCE."dbt_updated_at",DBT_INTERNAL_SOURCE."dbt_valid_from",DBT_INTERNAL_SOURCE."dbt_valid_to",DBT_INTERNAL_SOURCE."dbt_scd_id"
    from "stg_sf__contacts_snapshot__dbt_tmp142106052175" as DBT_INTERNAL_SOURCE
    where DBT_INTERNAL_SOURCE.dbt_change_type::text = 'insert'::text;

  