/*BA project SQL training in class questions*/

/*Boston house pricing data*/

--Question 1: Run the following code and check the result

SELECT * FROM dbo.boston_house;

--Question 2: Now, can you only select the data for regions close to Charles River?
select * from dbo.boston_house
where chas = 1;

--Question 3: Can you find the number of regions close to Charles river and not close? Also, what is the average median price for those two groups?
select chas, count(*) as cnt, avg(medv) as avg_med_price
from dbo.boston_house 
group by chas;

--Question 4: If the crime rate is lower than or equal to 1 per thousand, we define this region's safety as 'high', between 1 and 5 would be 'medium',
--higher than 5 would be 'low'. Can you create a variable safety_ind to represent this info?
select
case when crim <= 1 then 'high'
when crim <=5 then 'medium'
when crim > 5 then 'low'
else 'invalid' end as safety_ind, 
crim -- quality check (optional, recommended)
from dbo.boston_house;

--Question 5: Find the number of regions under each safety indicator group and the max/min/average value of the median prices.
-- method 1
select
case when crim <= 1 then 'high'
when crim <=5 then 'medium'
when crim > 5 then 'low'
else 'invalid' end as safety_ind,
count(*) as cnt, max(medv) as max_price, min(medv) as min_price, avg(medv) as avg_price
from dbo.boston_house
group by 
case when crim <= 1 then 'high'
when crim <=5 then 'medium'
when crim > 5 then 'low'
else 'invalid' end;

-- method 2 
with boston_house_safety_ind as 
(
    select *, 
    case when crim <= 1 then 'high'
    when crim <=5 then 'medium'
    when crim > 5 then 'low'
    else 'invalid' end as safety_ind
    from dbo.boston_house
)
select safety_ind, 
count(*) as cnt, max(medv) as max_price, min(medv) as min_price, avg(medv) as avg_price
from boston_house_safety_ind
group by safety_ind;


-- method 3 
select *, 
case when crim <= 1 then 'high'
when crim <=5 then 'medium'
when crim > 5 then 'low'
else 'invalid' end as safety_ind
into boston_house_safety_table0
from dbo.boston_house;

select safety_ind, 
count(*) as cnt, max(medv) as max_price, min(medv) as min_price, avg(medv) as avg_price
from boston_house_safety_table0
group by safety_ind;

/*Order and fulfillment data*/

--Question 6: Now run left/inner join on the order data and fulfillment data. Check the result and elaborate the difference between those 
--joins 
select * from dbo.order_table;
select * from dbo.fulfill_table;

-- left join 
select a.order_id, a.order_time, b.fulfillment_time
from dbo.order_table as a 
left join dbo.fulfill_table as b  -- all data in left (base) is attained, if right doesnt have, null
on a.order_ID = b.order_ID;

-- example want to represent the fulfillment status
select a.order_id, a.order_time, 
case when b.fulfillment_time is null then 'not fulfilled'
else 'fulfilled'
end as fulfill_status
from dbo.order_table as a 
left join dbo.fulfill_table as b  -- all data in right (base) is attained, if right doesnt have, null
on a.order_ID = b.order_ID;

-- inner join
select a.order_id, a.order_time, b.fulfillment_time
from dbo.order_table as a 
inner join dbo.fulfill_table as b  -- only output the result where the data in both left and right is attained
on a.order_ID = b.order_ID;

-- right join 
select a.order_id, a.order_time, b.fulfillment_time
from dbo.order_table as a 
right join dbo.fulfill_table as b  -- all data in right (base) is attained, if right doesnt have, null
on a.order_ID = b.order_ID;

-- full join
select a.order_id, a.order_time, b.fulfillment_time
from dbo.order_table as a 
full join dbo.fulfill_table as b  -- all data in both tables are attained
on a.order_ID = b.order_ID;

/*Walmart sales and features data*/

--Question 7: Join the Walmart sales data and feature data (which join would you use?).


/*SQL 101 Homework problems*/

/*Boston house pricing data*/

--Problem 1: Can you only select the data for median price higher than 25?
select * 
from dbo.boston_house
where medv > 25;

--Problem 2:If the medv is higher than the average medv, then we see the region is expensive, otherwise it is cheap. Can you create a variable for that?

select 
case when medv > (select avg(medv) as avg_medv from dbo.boston_house) then 'expensive'
else 'cheap' end as price_ind, 
medv
from dbo.boston_house;

--Problem 3: If the average number of rooms per dwelling is higher than 6 and the proportion of old owner-occupied units is lower than 80%), then we say that the region's fancy_house indicator is 'Y' otherwise it would be 'N'. Create a new variable fancy_house to capture that.
select id, rm, age, 
case when rm > 6 and age < 80  then 'Y'
else 'N' end as fancy_house_ind
from dbo.boston_house;

--Problem 4: If the pupil-teacher ratio is lower than 20 then we say the edu_ind ='good' else it would be 'ok'. Create a new variable in edu_ind to capture that.
select id, ptratio,
case when ptratio < 20 then 'good'
else 'ok' end as edu_ind
from dbo.boston_house;

--Problem 5: If both of the fancy house and education indicator are positive, then we say that the house has quality_ind as Super, 
-- if the fancy house is positive but the education indicator is negative, then we say that the quality_ind is 'Nice to live', 
-- if the education indicator is positive but the fancy house is negative, then we say that the quality_ind is 'Good education', 
-- if either of them is positive, then the quality_ind is 'No good'. Create a new variable quality_ind for that.
select *, 
case when (rm > 6 and age < 80) and ptratio < 20 then 'Super'
when (rm > 6 and age < 80) and  ptratio >= 20 then 'Nice to live'
when (rm <= 6 or age >= 80) and ptratio < 20 then 'Good Education'
when (rm <= 6 or age >= 80) and ptratio >= 20 then 'No good'
else null end as quality_ind
from dbo.boston_house;

with boston_house_ind as 
(
    select *, 
    case when rm>6 and age<80 then 'Y'
    else 'N'
    end as fancy_house,

    case when ptratio < 20 then 'good' 
    else 'ok'
    end as edu_ind
    from dbo.boston_house
)
select *, 
case when fancy_house='Y' and edu_ind = 'good' then 'Super'
when fancy_house='Y' and edu_ind = 'ok' then 'Nice to live'
when fancy_house='N' and edu_ind = 'good' then 'Good education'
when fancy_house='N' and edu_ind = 'ok' then 'No good'
else null end as quality_ind
from boston_house_ind;

--Problem 6: Check the average medv for each quality_ind.
with boston_house_quality_ind as 
(
select *,
case when (rm > 6 and age < 80) and ptratio < 20 then 'Super'
when (rm > 6 and age < 80) and  ptratio >= 20 then 'Nice to live'
when (rm <= 6 or age >= 80) and ptratio < 20 then 'Good Education'
when (rm <= 6 or age >= 80) and ptratio >= 20 then 'No good'
else null end as quality_ind
from dbo.boston_house
)
select quality_ind, avg(medv) as avg_med_price
from boston_house_quality_ind
group by quality_ind;

/*Walmart sales and features data*/

--Problem 7: With the feature and sales data joined, define a variable temp_ind with the following logic: if temperature is higher than 86 then 'Hot', between 50 and 86 would be 'Nice', and lower than 50 would be 'Cold'.

--Problem 8: Find the average weekly sales per store under different temp_ind. Note: for this question, you need to aggregate the total sales for each store on a given week first.



-- Project 1 
select campaign, offer, count(*) as cnt
from dbo.campaign_info
group by campaign, offer;

select * from dbo.campaign_info
where Campaign='SS201601' and offer='Action';

select * from dbo.acct_perf

select * from dbo.campaign_info as a 
left join dbo.acct_perf as b 
on a.account_number=b.Account_number
where a.Campaign='SS201601'
and a.offer='Action'
and b.ME_DT='2016-02-29';


with total as 
(
select campaign, count(*) as cnt
from dbo.campaign_info 
where campaign = 'SS201601'
group by campaign
), 
response as 
(
select c.campaign, count(a.account_number) as response_num
from dbo.campaign_info as c 
left join dbo.acct_perf as a
on a.account_number=c.Account_number
where a.purchase >500
and a.ME_DT='2016-02-29'
group by campaign
)
select r.response_num/ (1.0*t.cnt) as rate
from response as r
left join total as t
on r.campaign = t.campaign;

-- Q1
/* 
During the campaign period, what is the response rate (customers that spend more than $500 in Feb 2016 – ME_DT should be 2016/02/29)?
*/

select 
case when b.purchase >500 then 'Y'
else 'N' end as resp, 
count(*) as cnt
from dbo.campaign_info as a 
left join dbo.acct_perf as b 
on a.account_number=b.account_number
where a.campaign = 'SS201601' and a.offer='Action'
and b.me_dt='2016-02-29'
group by 
case when b.purchase>500 then 'Y'
else 'N'
end
;

-- Q2 What is the "response rate" for control (customers that spend more than $500 regardless)?

select a.offer,
case when b.purchase >500 then 'Y'
else 'N' end as resp, 
count(*) as cnt
from dbo.campaign_info as a 
left join dbo.acct_perf as b 
on a.account_number=b.account_number
where a.campaign = 'SS201601'
and b.me_dt='2016-02-29'
group by a.offer,
case when b.purchase>500 then 'Y'
else 'N'
end
;

-- Q3 Do we see higher spend for the action group overall in the short term?
select a.offer,
sum(case when b.purchase >500 then 1 else 0 end)/(1.0 * count(*)) as resp_rate
from dbo.campaign_info as a 
left join dbo.acct_perf as b 
on a.account_number=b.account_number
where a.campaign = 'SS201601'
and b.me_dt='2016-02-29'
group by a.offer
;
-- export to excel, plot (data visualization)

-- Q4
select 
a.offer,
b.me_dt,
sum(b.purchase) as pvol,  -- purchase volume
sum(b.balance) as bal,
count(*) as cnt 
from dbo.campaign_info as a 
left join dbo.acct_perf as b 
on a.account_number=b.account_number
where a.campaign = 'SS201601'
group by 
a.offer,
b.me_dt
;

-- Project 2 
-- Q1
select * from dbo.email_acct_detail;
select * from dbo.email_performance;

-- Q2
select segment, count(*) as cnt
from dbo.email_acct_detail
group by segment;

-- Q3
select segment,
sum(visit)/(1.0*count(*)) as visit_rate, 
sum(conversion)/(1.0*count(*)) as conversion_rate, 
avg(spend) as avg_spend
from dbo.email_performance as p
left join dbo.email_acct_detail as a 
on a.customer_id = p.customer_id
group by a.segment;

-- Q4 How much incremental sales per customer did the Mens version of the e-mail campaign drive? 
-- How much incremental sales per customer did the Womens version of the e-mail campaign drive?
select segment,
sum(p.spend)/(1.0*count(*)) as incr_sales_per_customer
from dbo.email_performance as p
left join dbo.email_acct_detail as a 
on a.customer_id = p.customer_id
group by a.segment;

-- If you could only send an e-mail campaign to the best 10,000 customers, which customers would receive the e-mail campaign? Why?
select a.segment, 
a.recency, a.history_segment, a.mens, a.womens, a.zip_code, a.newbie, a.channel, 
count(*) as cnt, 
sum(b.visit) as tot_visit, 
sum(b.conversion) as tot_cov,
sum(spend) as tot_spend
from dbo.email_acct_detail as a 
left join dbo.email_performance as b 
on a.customer_id = b.customer_id
group by a.segment, 
a.recency, a.history_segment, a.mens, a.womens, a.zip_code, a.newbie, a.channel;


-- Q4 - 10: use discrete variable 
select a.segment, 
a.recency, a.history_segment, a.mens, a.womens, a.zip_code,
a.newbie, a.channel, 
count(*) as cnt, 
sum(visit) as tot_visit, 
sum(conversion) as tot_cov, 
sum(spend) as tot_spend
from dbo.email_acct_detail as a 
left join dbo.email_performance as b 
on a.customer_id=b.customer_id
group by a.segment, 
a.recency, a.history_segment, a.mens, a.womens, a.zip_code,
a.newbie, a.chsannel
;




