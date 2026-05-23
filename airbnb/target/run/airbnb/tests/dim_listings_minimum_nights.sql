
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
        select *
        from AIRBNB.DBT_MYDEV__TEST_FAILURES.dim_listings_minimum_nights
    
      
    ) dbt_internal_test