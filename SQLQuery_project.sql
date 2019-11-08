-- Still do the analysis based on the Boston house pricing data
-- (the data dictionary can be found in the appendix).
-- Problem 1: Can you only select the data for median price higher 
-- than 25?

select * from dbo.boston_house
where medv>25
;

-- Problem 2:If the medv is higher than the average medv, then we 
-- see the region is expensive, otherwise it is cheap. 
-- Can you create a variable for that?

select avg(medv) as avg_medv from dbo.boston_house
;

select 
case when medv > (select avg(medv) as avg_medv from dbo.boston_house)
then 'expensive'
else 'cheap'
end as price_ind,
medv
from dbo.boston_house
; 

-- Problem 3: If the average number of rooms per dwelling is 
-- higher than 6 and the proportion of old owner-occupied units 
-- is lower than 80%), then we say that the region's fancy_house 
-- indicator is 'Y' otherwise it would be 'N'. 
-- Create a new variable fancy_house to capture that.


select *, 
case when rm>6 and age < 80 then 'Y'
else 'N'
end as fancy_house
from dbo.boston_house
;


-- Problem 4: If the pupil-teacher ratio is lower than 20 then 
-- we say the edu_ind ='good' else it would be 'ok'. 
-- Create a new variable in edu_ind to capture that.

select *,
case when ptratio < 20 then 'good'
else 'ok'
end as edu_ind
from dbo.boston_house
;

-- Problem 5: If both of the fancy house and education indicator are
-- positive, then we say that the house has quality_ind as Super, 
-- if the fancy house is positive but the education indicator is 
-- negative, then we say that the quality_ind is 'Nice to live', 
--if the education indicator is positive but the fancy house is 
-- negative, then we say that the quality_ind is 'Good education', 
-- if either of them is positive, then the quality_ind is 'No good'. 
-- Create a new variable quality_ind for that.

with boston_house_ind AS
(
select *, 
case when rm>6 and age < 80 then 'Y'
else 'N'
end as fancy_house,
case when ptratio < 20 then 'good'
else 'ok'
end as edu_inds
from dbo.boston_house
)
select *, 
case when fancy_house='Y' and edu_ind='good' then 'Super'
when fancy_house='Y' and edu_ind='ok' then 'Nice to live'
when fancy_house='N' and edu_ind='good' then 'Good education'
when fancy_house='N' and edu_ind='ok' then 'No good'
else null end as quality_ind
from boston_house_ind
;


--Problem 6: Check the average medv for each quality_ind.

with boston_house_ind AS
(
select *, 
case when rm>6 and age < 80 then 'Y'
else 'N'
end as fancy_house,
case when ptratio < 20 then 'good'
else 'ok'
end as edu_ind
from dbo.boston_house
)
select 
case when fancy_house='Y' and edu_ind='good' then 'Super'
when fancy_house='Y' and edu_ind='ok' then 'Nice to live'
when fancy_house='N' and edu_ind='good' then 'Good education'
when fancy_house='N' and edu_ind='ok' then 'No good'
else null end as quality_ind,
avg(medv) as avg_price
from boston_house_ind
group by 
case when fancy_house='Y' and edu_ind='good' then 'Super'
when fancy_house='Y' and edu_ind='ok' then 'Nice to live'
when fancy_house='N' and edu_ind='good' then 'Good education'
when fancy_house='N' and edu_ind='ok' then 'No good'
else null end
;

with boston_house_ind AS
(
select *, 
case when rm>6 and age < 80 then 'Y'
else 'N'
end as fancy_house,
case when ptratio < 20 then 'good'
else 'ok'
end as edu_ind
from dbo.boston_house
),
boston_house_ind_2 as
(
select *,
case when fancy_house='Y' and edu_ind='good' then 'Super'
when fancy_house='Y' and edu_ind='ok' then 'Nice to live'
when fancy_house='N' and edu_ind='good' then 'Good education'
when fancy_house='N' and edu_ind='ok' then 'No good'
else null end as quality_ind
from boston_house_ind
)
select quality_ind, 
avg(medv) as avg_price
from boston_house_ind_2
group by quality_ind
;

STAR  
Scenario
Task
Action 
Result

-- 1. During the campaign period, what is the response rate 
-- (customers that spend more than $500 in Feb 2016 – ME_DT 
-- should be 2016/02/29)?


select 
case when b.purchase >500 then 'Y'
else 'N'
end as resp,
count(*) as cnt 
from dbo.campaign_info as a 
left join dbo.acct_perf as b 
on a.account_number=b.account_number
where a.campaign='SS201601'
and a.offer='Action'
and b.me_dt ='2016-02-29'
group by 
case when b.purchase >500 then 'Y'
else 'N'
end
;



select 
a.offer,
case when b.purchase >500 then 'Y'
else 'N'
end as resp,
count(*) as cnt 
from dbo.campaign_info as a 
left join dbo.acct_perf as b 
on a.account_number=b.account_number
where a.campaign='SS201601'
and b.me_dt ='2016-02-29'
group by 
a.offer,
case when b.purchase >500 then 'Y'
else 'N'
end
;

select 
a.offer,
sum(case when b.purchase >500 then 1 else 0 end)/(1.0*count(*)) as resp_rate
from dbo.campaign_info as a 
left join dbo.acct_perf as b 
on a.account_number=b.account_number
where a.campaign='SS201601'
and b.me_dt ='2016-02-29'
group by 
a.offer
;


select 
a.offer,
b.me_dt,
sum(b.purchase) as pvol,
sum(b.balance) as bal,
count(*) as cnt
from dbo.campaign_info as a 
left join dbo.acct_perf as b 
on a.account_number=b.account_number
where a.campaign='SS201601'
group by 
a.offer,
b.me_dt
;

select * from dbo.email_acct_detail;


select * from dbo.email_performance;


select a.segment, 
count(*) as cnt,
sum(visit)/(1.0*count(*)) as visit_rate,
sum(conversion)/(1.0*count(*)) as conv_rate,
sum(spend)/(1.0*count(*)) as avg_spend
from dbo.email_acct_detail as a
left join dbo.email_performance as b 
on a.customer_id=b.customer_id 
group by a.segment
;

select a.segment, 
a.recency, a.history_segment, a.mens, a.womens, a.zip_code,
a.newbie, a.channel,
count(*) as cnt,
sum(visit) as tot_visit,
sum(conversion) as tot_conv,
sum(spend) as tot_spend
from dbo.email_acct_detail as a
left join dbo.email_performance as b 
on a.customer_id=b.customer_id 
group by a.segment, 
a.recency, a.history_segment, a.mens, a.womens, a.zip_code,
a.newbie, a.channel
;