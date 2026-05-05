-----------------------------------------------------------------------------------------------------------
--1. Data Inspection & Exploratory Data Analysis
------------------------------------------------------------------------------------------------------------

-- 1.1 Sample of all the available columns and types of data 
------------------------------------------------------------------------------
select*
from workspace.default.bright_tv_user_profiles;
select*
from workspace.default.bright_tv_viewership;

--1.2 How many rows of data in our table
------------------------------------------------------------------------------
select count(*) AS number_of_rows,
       count(distinct userID) AS number_of_users
from workspace.default.bright_tv_user_profiles;
--we have 5375 rows in the user profiles table and each row is for a new client. Therefore, 5375 distinct users.

select count(*) AS number_of_rows,
       count(distinct UserID0) AS number_of_users
from workspace.default.bright_tv_viewership;
--we have 10 000  rows in the viewership table. This table shows only 4386 distinct users with logged sessions, this means out of the 5376 with subscriptions, only 4386 watched during this period. 
--A left outer Join with the user_profiles table as the left will work here to make one table. 

select min(RecordDate2)
from workspace.default.bright_tv_viewership;

select max(RecordDate2)
from workspace.default.bright_tv_viewership;
--Our analysis period is from 01 Jan 2016 to 31 Mar 2016. So this is 3 months worth of vieiwership--

select count(distinct Channel2)
from workspace.default.bright_tv_viewership;

select count(distinct Province)
from workspace.default.bright_tv_user_profiles;

select distinct Province
from workspace.default.bright_tv_user_profiles;

select max(age)
from workspace.default.bright_tv_user_profiles;

select min(age)
from workspace.default.bright_tv_user_profiles;

--We have 21 channels, with viership accross 9 Provinces (exlcuding none province).

-----------------------------------------------------------------------------------------------------------
----2. Feature Engineering & Final Script 
------------------------------------------------------------------------------------------------------------

select
    a.UserID, 
    a.`Name`,
    a.Surname,
    a.Gender,
    a.Race,
    a.Province,
    b.Channel2,
    b.RecordDate2,
    b.`Duration 2`
from workspace.default.bright_tv_user_profiles as a
left join workspace.default.bright_tv_viewership as b 
on a.UserID = b.UserID0;

--feature buildig & final script 

select min(date_format(RecordDate2,'HH:mm:ss')) as earliest_session
from workspace.default.bright_tv_viewership;

select max(date_format(RecordDate2,'HH:mm:ss')) as latest_session
from workspace.default.bright_tv_viewership;


select
---categorical Data
    a.UserID, 
    a.Gender,
    a.Race,
    a.Province,
    b.Channel2,
---TIme & Date Features
    dayofmonth(b.RecordDate2) as day_of_month,
    monthname(b.RecordDate2) as month_name,
    year(b.RecordDate2) as `year`,
    dayname(b.RecordDate2) as day_name,
    date_format(b.RecordDate2,'HH:mm:ss') as session_time,
---Create total minutes wtached feature
    date_format(b.`Duration 2`,'HH:mm:ss') as session_duration,
    ((hour(b.`Duration 2`)*60) + minute(b.`Duration 2`)+(second(b.`Duration 2`)/60)) as total_minutes,
---Time Segments
case 
    when date_format(b.RecordDate2,'HH:mm:ss') between '00:00:00'and '04:59:59' then '6.night owl'
    when date_format(b.RecordDate2,'HH:mm:ss') between '05:00:00'and '11:59:59' then '1.morning'
    when date_format(b.RecordDate2,'HH:mm:ss') between '12:00:00'and '13:59:59' then '2.midday'
    when date_format(b.RecordDate2,'HH:mm:ss') between '14:00:00'and '16:59:59' then '3.afternoon'
    when date_format(b.RecordDate2,'HH:mm:ss') between '17:00:00'and '19:59:59' then '4.early evening'
    when date_format(b.RecordDate2,'HH:mm:ss') between '20:00:00'and '23:59:59' then '5.late evening'
    end as time_segments,
--age segement
case
    when a.age between 0 and 2 then 'infants'
    when a.age between 3 and 12 then 'children'
    when a.age between 13 and 19 then 'teens'
    when a.age between 20 and 34 then 'young adults'
    when a.age between 35 and 54 then 'adults'
    when a.age >= 55 then 'seniors'
end as age_segments,
--Active & Dormant Clients
case 
    when b.`Duration 2` is null then 'dormant'
    else 'active'
end as ClientStatus
from workspace.default.bright_tv_user_profiles as a
left join workspace.default.bright_tv_viewership as b 
on a.UserID = b.UserID0
order by total_minutes desc;
--looks like we dont need to suffer with the long group by statements like the Bright Coffee. 
