{{ config(materialized='table') }}

with new_tbl as 
    (select
        *,
        timestamp_diff(dropoff_datetime, pickup_datetime, second) as duration
    from {{ref("dim_fhv_trips")}}),
    p90_tbl as (select 
        pu_year, pu_month, pickup_zone, dropoff_zone,
        percentile_cont(duration,0.9) over (partition by pu_year,pu_month,pickup_zone,dropoff_zone) as p90
    from new_tbl)

select distinct pu_year, pu_month, pickup_zone, dropoff_zone, p90
from p90_tbl 