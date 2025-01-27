# DEZoomCamp

## Question 1. Understanding docker first run

docker run -it python:3.12.8 bash
Unable to find image 'python:3.12.8' locally
3.12.8: Pulling from library/python
fd0410a2d1ae: Already exists
bf571be90f05: Already exists
684a51896c82: Already exists
fbf93b646d6b: Already exists
12f3828c4288: Pull complete
4d8be491b866: Pull complete
ec162e081748: Pull complete
Digest: sha256:2e726959b8df5cd9fd95a4cbd6dcd23d8a89e750e9c2c5dc077ba56365c6a925
Status: Downloaded newer image for python:3.12.8


root@b54bec9a0c22:/# pip --version
pip 24.3.1 from /usr/local/lib/python3.12/site-packages/pip (python 3.12)

## Question 4. Longest trip for each day
select cast(lpep_pickup_datetime as date), trip_distance from green_trips as gt
order by trip_distance desc
limit 1

## Question 5. Three biggest pickup zones
select z."Zone", cast(gt.lpep_pickup_datetime as date) as pu_date, sum(gt.total_amount) as sum_amount
from zones as z
join green_trips as gt
on gt."PULocationID" = z."LocationID"
where cast(gt.lpep_pickup_datetime as date) ='2019-10-18'
group by 1,2
having sum(gt.total_amount)>13000


## Question 6. Largest tip
select "Zone"
from zones
where "LocationID" in (
select gt."DOLocationID"
from zones as z
join green_trips as gt
on z."LocationID" = gt."PULocationID"
where to_char(gt.lpep_pickup_datetime, 'YYYY-MM')='2019-10'
and z."Zone"='East Harlem North'
order by tip_amount desc
limit 1)
