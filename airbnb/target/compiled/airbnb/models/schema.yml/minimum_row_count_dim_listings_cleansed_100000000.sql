


SELECT
    COUNT(*) as cnt
FROM
    AIRBNB.DBT_MYDEV.dim_listings_cleansed
HAVING
    COUNT(*) < 100000000
