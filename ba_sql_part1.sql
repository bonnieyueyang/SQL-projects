select * from dbo.boston_house

/*BA project SQL training in class questions*/

/*Boston house pricing data*/

--Question 1: Run the following code and check the result

SELECT * FROM dbo.boston_house

--Question 2: Now, can you only select the data for regions 
--close to Charles River?

select id, chas, medv from dbo.boston_house
where chas=1
;

--Question 3: Can you find the number of regions close to 
--Charles river and not close? Also, what is the average median 
--price for those two groups?

select chas, count(*) as cnt,
avg(medv) as avg_price
from dbo.boston_house
group by chas
;

--Question 4: If the crime rate is lower than or equal to 1 
--per thousand, we define this region's safety as 'high', 
--between 1 and 5 would be 'medium',
--higher than 5 would be 'low'. Can you create a variable 
--safety_ind to represent this info?

select 
case when crim <=1 then 'high'
when crim between 1 and 5 then 'medium'
when crim >5 then 'low'
end as safety_ind,
crim 
from dbo.boston_house
;

--Question 5: Find the number of regions under each safety 
--indicator group and the max/min/average value of the median prices.

-- method 1
select 
case when crim <=1 then 'high'
when crim between 1 and 5 then 'medium'
when crim >5 then 'low'
end as safety_ind,
count(*) as cnt,
max(medv) as max_price,
min(medv) as min_price,
avg(medv) as avg_price
from dbo.boston_house
group by 
case when crim <=1 then 'high'
when crim between 1 and 5 then 'medium'
when crim >5 then 'low'
end
;

-- method 2: with statement
with boston_house_safety_ind AS
(
select *, 
case when crim <=1 then 'high'
when crim between 1 and 5 then 'medium'
when crim >5 then 'low'
end as safety_ind
from dbo.boston_house
)
select safety_ind, 
count(*) as cnt,
max(medv) as max_price,
min(medv) as min_price,
avg(medv) as avg_price
from boston_house_safety_ind
group by safety_ind
;

-- method 3: select into

select *, 
case when crim <=1 then 'high'
when crim between 1 and 5 then 'medium'
when crim >5 then 'low'
end as safety_ind
into boston_house_safety_table
from dbo.boston_house
;

select safety_ind, 
count(*) as cnt,
max(medv) as max_price,
min(medv) as min_price,
avg(medv) as avg_price
from boston_house_safety_table
group by safety_ind
;

/*Order and fulfillment data*/

--Question 6: Now run left/inner join on the order data and fulfillment data. Check the result and elaborate the difference between those 
--joins 

/*Walmart sales and features data*/

--Question 7: Join the Walmart sales data and feature data (which join would you use?).


/*SQL 101 Homework problems*/

/*Boston house pricing data*/

--Problem 1: Can you only select the data for median price higher than 25?

--Problem 2:If the medv is higher than the average medv, then we see the region is expensive, otherwise it is cheap. Can you create a variable for that?

--Problem 3: If the average number of rooms per dwelling is higher than 6 and the proportion ofold owner-occupied units is lower than 80%), then we say that the region's fancy_house indicator is 'Y' otherwise it would be 'N'. Create a new variable fancy_house to capture that.

--Problem 4: If the pupil-teacher ratio is lower than 20 then we say the edu_ind ='good' else it would be 'ok'. Create a new variable in edu_ind to capture that.

--Problem 5: If both of the fancy house and education indicator are positive, then we say that the house has quality_ind as Super, if the fancy house is positive but the education indicator is negative, then we say that the quality_ind is 'Nice to live', if the education indicator is positive but the fancy house is negative, then we say that the quality_ind is 'Good education', if either of them is positive, then the quality_ind is 'No good'. Create a new variable quality_ind for that.

--Problem 6: Check the average medv for each quality_ind.

/*Walmart sales and features data*/

--Problem 7: With the feature and sales data joined, define a variable temp_ind with the following logic: if temperature is higher than 86 then 'Hot', between 50 and 86 would be 'Nice', and lower than 50 would be 'Cold'.

--Problem 8: Find the average weekly sales per store under different temp_ind. Note: for this question, you need to aggregate the total sales for each store on a given week first.


