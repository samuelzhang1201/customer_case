{% macro age_in_years(date_column) %}

    {% if target.name == 'local' %}

        date_part('year', age(current_date, {{ date_column }}))

    {% else %}

        floor(datediff(now(), {{ date_column }})/365)

    {% endif %}

{% endmacro %}