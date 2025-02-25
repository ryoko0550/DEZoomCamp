{{ config(materialized='table') }}

with trips_data as (
    select * from {{ ref('fact_trips') }}
),
 m as (select 
    service_type, 
    -- Revenue grouping 
    extract( year from {{ dbt.date_trunc("year", "pickup_datetime") }}) as revenue_year,
    extract( month from {{ dbt.date_trunc("month", "pickup_datetime") }}) as revenue_month,
    percentile_cont (fare_amount, 0.95) over (partition by service_type, extract( year from {{ dbt.date_trunc("year", "pickup_datetime") }}), extract( month from {{ dbt.date_trunc("month", "pickup_datetime") }})) as revenue_95th_percentile
    -- Revenue calculation 
    from trips_data
    where fare_amount>0 and trip_distance>0 and payment_type_description in ('Cash', 'Credit card'))

select distinct
    service_type, revenue_year, revenue_month, revenue_95th_percentile
from m
order by 1,2,3

    