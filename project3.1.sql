select * from base;
select * from call_record;
select * from change_record;
select * from letter;
select * from decision;
select * from credit.credit_card_balance; 


-- Q1
select change_date, count(distinct account_number) as response_num
from change_record
group by 1;

-- Q2
select count(cr.acct_num)/count(b.acct_num) as response_rate, 
1 - count(cr.acct_num)/count(b.acct_num) as deline_rate
from base as b
left join call_record as cr
on cr.acct_num = b.acct_num; 

-- Q3
select d.acct_decision_id 
from decision as d
left join base as b
on d.acct_decision_id = b.acct_num
left join change_record as cr
on b.acct_num = cr.account_number
where d.decision_status = 'AP' and 
not b.offer_amount = cr.credit_limit_after - cr.credit_limit_before;

-- Q4.1
select l.account_number
from letter as l 
left join decision as d
on l.account_number = d.acct_decision_id
where l.letter_trigger_date < d.decision_date;

-- Q4.2
select l.account_number,
case when language = 'English' and d.decision_status = 'AP' and letter_code = 'AE001' then 1
when language = 'English' and d.decision_status = 'DL' and letter_code = 'RE001' then 1 
when language = 'French' and d.decision_status = 'AP' and letter_code = 'AE002' then 1 
when language = 'French' and d.decision_status = 'AP' and letter_code = 'RE002' then 1 
else 'invalid' end as check_valid
from letter as l 
left join decision as d
on l.account_number = d.acct_decision_id
where check_valid = 'invalid'; 

-- Q5
select b.*, d.*, l.*, cr.credit_limit_after
from base as b
left join decision as d
on b.acct_num = d.acct_decision_id
left join letter as l 
on b.acct_num = l.account_number
left join change_record as cr
on b.acct_num = cr.account_number
;


