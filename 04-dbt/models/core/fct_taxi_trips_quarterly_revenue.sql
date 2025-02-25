{{ config(materialized='table') }}

with trips_data as (
    select * from {{ ref('fact_trips') }}
)
    select 
    service_type, 
    -- Revenue grouping 
    extract( year from {{ dbt.date_trunc("year", "pickup_datetime") }}) as revenue_year,
    concat('Q', cast(floor((extract(month FROM {{ dbt.date_trunc("quarter", "pickup_datetime") }}) - 1) / 3) + 1 as string)) as revenue_quarter,
    -- Revenue calculation 
    sum(total_amount) as revenue_quarterly_total_amount,


    from trips_data
    group by 1,2,3