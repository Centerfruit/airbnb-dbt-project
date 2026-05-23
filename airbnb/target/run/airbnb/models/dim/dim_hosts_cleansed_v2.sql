
  
    

create or replace transient table AIRBNB.DBT_MYDEV.dim_hosts_cleansed_v2
    
  (
    host_id integer not null,
    is_superhost TEXT,
    updated_at timestamp,
    created_at timestamp,
    host_name TEXT not null
    
    )

    
    
    
    as (
    select host_id, is_superhost, updated_at, created_at, host_name
    from (
        

WITH  __dbt__cte__src_hosts as (
WITH raw_hosts AS (
    SELECT
        *
    FROM
       AIRBNB.raw.raw_hosts
)
SELECT
    id AS host_id,
    NAME AS host_name,
    is_superhost,
    created_at,
    updated_at
FROM
    raw_hosts
), src_hosts AS (
    SELECT
        *
    FROM
        __dbt__cte__src_hosts
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
    ) as model_subq
    )
;


  