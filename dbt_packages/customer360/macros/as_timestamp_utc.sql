{% macro as_timestamp_utc(column_name) %}

    {% if target.name == 'local' %}

        to_timestamp({{ column_name }},'YYYY-MM-DD HH24:MI:SS.MS') :: timestamp at TIME zone 'UTC'

    {% else %}

        from_utc_timestamp(to_timestamp({{ column_name }}, 'yyyy-MM-dd HH:mm:ss.SSS'),'Australia/Melbourne')

    {% endif %}

{% endmacro %}