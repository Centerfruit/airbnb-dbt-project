-- Materialize this model as an incremental table to optimize performance and manage large datasets
-- Fail the run if there are schema changes to ensure data integrity
-- Specify the event time column for incremental loading based on review_date
{{
  config(
    materialized = 'incremental', 
    on_schema_change='fail', 
    event_time = 'review_date', 
    
    )
}}
WITH src_reviews AS (
  SELECT * FROM {{ ref('src_reviews') }} -- Reference to the source reviews table, which contains raw review data
)
SELECT 
-- below line generates a surrogate key for the review_id 
-- using the dbt_utils package using specified columns
{{ dbt_utils.generate_surrogate_key(['listing_id', 'review_date', 'reviewer_name', 'review_text']) }} as review_id,
* FROM src_reviews
WHERE review_text is not null

{% if is_incremental() %} -- Only include new or updated records based on the review_date column for incremental loading
  {% if var("start_date", False) and var("end_date", False) %} 
    {{ log('Loading ' ~ this ~ ' incrementally (start_date: ' ~ var("start_date") ~ ', end_date: ' ~ var("end_date") ~ ')', info=True) }} -- Log the incremental loading process with specified start and end dates for better visibility
    AND review_date >= '{{ var("start_date") }}'
    AND review_date < '{{ var("end_date") }}'
  {% else %}
    AND review_date > (select max(review_date) from {{ this }}) -- Load all records with review_date greater than the maximum review_date in the existing table for incremental loading
    {{ log('Loading ' ~ this ~ ' incrementally (all missing dates)', info=True)}} -- Log the incremental loading process when no specific date range is provided, indicating that all missing dates will be loaded
  {% endif %}
{% endif %}