WITH
l AS (
    SELECT
        *
    FROM
        {{ ref('dim_listings_cleansed') }} -- Reference to the dim_listings_cleansed model, which contains cleansed listing data
),
h AS (
    SELECT *
    FROM {{ ref('dim_hosts_cleansed', v=2) }} -- Reference to the dim_hosts_cleansed_v2 model, which contains cleansed host data with improved performance
)

SELECT
    l.listing_id,
    l.listing_name, 
    l.room_type,
    l.minimum_nights,
    l.price price_usd,
    l.price_str,
    l.host_id,
    h.host_name,
    h.is_superhost as host_is_superhost,
    l.created_at,
    GREATEST(l.updated_at, h.updated_at) as updated_at -- Use GREATEST to get the most recent update timestamp between listing and host
FROM l
LEFT JOIN h ON (h.host_id = l.host_id)
