-- Materialize this model as a table for better performance and easier downstream querying
{{
  config(
    materialized = 'table' 
    )
}}

WITH src_hosts AS (
    SELECT
        *
    FROM
        {{ ref('src_hosts') }} -- Reference to the source hosts table, which contains raw host data
)
SELECT
    host_id,
    NVL(
        host_name,
        'N/A'
    ) AS host_name,
    is_superhost,
    created_at,
    updated_at
FROM
    src_hosts