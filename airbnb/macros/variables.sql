{% macro learn_variables() %}

    {% set your_name = "tanuj" %}
    {{ log("Hello " ~ your_name, info=True) }}

    {{ log("hello dbt user " ~ var("user_name", "NO USERNAME") ~ "!", info=True) }}
{% endmacro %}
 