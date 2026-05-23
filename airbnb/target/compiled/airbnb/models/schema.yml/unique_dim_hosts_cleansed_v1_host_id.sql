
    
    

select
    host_id as unique_field,
    count(*) as n_records

from AIRBNB.DBT_MYDEV.dim_hosts_cleansed_v1
where host_id is not null
group by host_id
having count(*) > 1


