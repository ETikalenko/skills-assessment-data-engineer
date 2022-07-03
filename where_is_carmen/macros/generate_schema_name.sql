{#  https://docs.getdbt.com/docs/building-a-dbt-project/building-models/using-custom-schemas #}
{#- By default dbt concatenate the custom schema to the target schema
    This macro is to generate a schema name for our models
    The logic is if custom schema exists then use the custom schema without concatenating to the target schema
#}

{% macro generate_schema_name(custom_schema_name, node) -%}

    {%- set default_schema = target.schema -%}

    {%- if custom_schema_name is not none -%}
        {{ custom_schema_name | trim }}
    {%- else -%}
        {{ default_schema }}
    {%- endif -%}

{%- endmacro %}
