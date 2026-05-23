
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
        select *
        from AIRBNB.DBT_MYDEV__TEST_FAILURES.minimum_row_count_dim_listings_cleansed_100000000
    
      
    ) dbt_internal_test