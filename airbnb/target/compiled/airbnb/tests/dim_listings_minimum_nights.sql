SELECT * FROM AIRBNB.DBT_MYDEV.dim_listings_cleansed
WHERE minimum_nights < 1
limit 10