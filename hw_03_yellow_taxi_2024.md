--question 1

select count(1)
from `dezc2025.external_yellow_tripdata_2024` 


--question 2

select count(distinct PULocationID)
from `dezc2025.nonpartition_yellow_tripdata_2024`

--QUESTION 3
select PULocationID, DOLocationID
from `dezc2025.nonpartition_yellow_tripdata_2024`

--QUESTION 4
select COUNT(1)
from `dezc2025.nonpartition_yellow_tripdata_2024`
WHERE fare_amount=0

--question 5
CREATE OR REPLACE TABLE data-engineer-zoomcamp-449104.dezc2025.partition_yellow_tripdata_2024
PARTITION BY
  DATE(tpep_dropoff_datetime) 
CLUSTER BY 
  VendorID 
AS
SELECT * FROM data-engineer-zoomcamp-449104.dezc2025.external_yellow_tripdata_2024;

--question 6
select
  distinct VendorID
from `dezc2025.partition_yellow_tripdata_2024`
where
  tpep_dropoff_datetime between "2024-03-01" and "2024-03-15"
