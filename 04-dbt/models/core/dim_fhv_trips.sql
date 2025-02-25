{{
    config(
        materialized='table'
    )
}}

select 
    a.dispatching_base_num,
    extract( year from {{ dbt.date_trunc("year", "pickup_datetime") }}) as pu_year,
    extract( month from {{ dbt.date_trunc("month", "pickup_datetime") }}) as pu_month,
    a.pickup_datetime,
    a.dropoff_datetime, 
    pickup_zone.zone as pickup_zone, 
    a.pickup_locationid, 
    dropoff_zone.zone as dropoff_zone, 
    a.dropoff_locationid,
    a.SR_Flag,
    a.Affiliated_base_number

from {{ref("stg_staging_fhv_tripdata")}} as a
inner join {{ref("dim_zones")}} as pickup_zone
on a.pickup_locationid = pickup_zone.locationid
inner join {{ref("dim_zones")}} as dropoff_zone
on a.dropoff_locationid = dropoff_zone.locationid