--1. Find the top 3 customers who have the maximum count of orders.

select top 3 
			Cust_ID, 
			cnt_orders
from (
		select 
				distinct Cust_ID, 
				COUNT(Ord_ID) over (partition by Cust_ID order by Cust_ID) cnt_orders
		from e_commerce_data
	) t

order by cnt_orders desc


--2. Find the customer whose order took the maximum time to get shipping.

select top 1
	Cust_ID, 
	Order_Date, 
	Ship_Date, 
	DATEDIFF(DAY, Order_Date, Ship_Date) time_of_shipping_in_days
from 
	e_commerce_data
order by 
	time_of_shipping_in_days desc



--3. Count the total number of unique customers in January and how many of them came back every month over the entire year in 2011

select t.cnt
from
(

select COUNT(Cust_ID) cnt
						from (
						select distinct Cust_ID
						from e_commerce_data
						where YEAR(Order_Date)=2011 and MONTH(Order_Date)=1) t1
							
							union all

select COUNT(Cust_ID) from (
						select distinct Cust_ID
						from e_commerce_data
						where YEAR(Order_Date)=2011 and MONTH(Order_Date)=1
						intersect
						select distinct Cust_ID
						from e_commerce_data
						where YEAR(Order_Date)=2011 and MONTH(Order_Date)=2) t2

							union all

select COUNT(Cust_ID) from (
						select distinct Cust_ID
						from e_commerce_data
						where YEAR(Order_Date)=2011 and MONTH(Order_Date)=1
						intersect
						select distinct Cust_ID
						from e_commerce_data
						where YEAR(Order_Date)=2011 and MONTH(Order_Date)=3) t3
						
							union all

select COUNT(Cust_ID) from (
						select distinct Cust_ID
						from e_commerce_data
						where YEAR(Order_Date)=2011 and MONTH(Order_Date)=1
						intersect
						select distinct Cust_ID
						from e_commerce_data
						where YEAR(Order_Date)=2011 and MONTH(Order_Date)=4) t4
						
							union all

select COUNT(Cust_ID) from (
						select distinct Cust_ID
						from e_commerce_data
						where YEAR(Order_Date)=2011 and MONTH(Order_Date)=1
						intersect
						select distinct Cust_ID
						from e_commerce_data
						where YEAR(Order_Date)=2011 and MONTH(Order_Date)=5) t5
						
							union all

select COUNT(Cust_ID) from (
						select distinct Cust_ID
						from e_commerce_data
						where YEAR(Order_Date)=2011 and MONTH(Order_Date)=1
						intersect
						select distinct Cust_ID
						from e_commerce_data
						where YEAR(Order_Date)=2011 and MONTH(Order_Date)=6) t6
						
							union all

select COUNT(Cust_ID) from (
						select distinct Cust_ID
						from e_commerce_data
						where YEAR(Order_Date)=2011 and MONTH(Order_Date)=1
						intersect
						select distinct Cust_ID
						from e_commerce_data
						where YEAR(Order_Date)=2011 and MONTH(Order_Date)=7) t7
							
							union all

select COUNT(Cust_ID) from (
						select distinct Cust_ID
						from e_commerce_data
						where YEAR(Order_Date)=2011 and MONTH(Order_Date)=1
						intersect
						select distinct Cust_ID
						from e_commerce_data
						where YEAR(Order_Date)=2011 and MONTH(Order_Date)=8) t8
						
							union all

select COUNT(Cust_ID) from (
						select distinct Cust_ID
						from e_commerce_data
						where YEAR(Order_Date)=2011 and MONTH(Order_Date)=1
						intersect
						select distinct Cust_ID
						from e_commerce_data
						where YEAR(Order_Date)=2011 and MONTH(Order_Date)=9) t9
						
							union all

select COUNT(Cust_ID) from (
						select distinct Cust_ID
						from e_commerce_data
						where YEAR(Order_Date)=2011 and MONTH(Order_Date)=1
						intersect
						select distinct Cust_ID
						from e_commerce_data
						where YEAR(Order_Date)=2011 and MONTH(Order_Date)=10) t10
						
							union all

select COUNT(Cust_ID) from (
						select distinct Cust_ID
						from e_commerce_data
						where YEAR(Order_Date)=2011 and MONTH(Order_Date)=1
						intersect
						select distinct Cust_ID
						from e_commerce_data
						where YEAR(Order_Date)=2011 and MONTH(Order_Date)=11) t11

							union all

select COUNT(Cust_ID) from (
						select distinct Cust_ID
						from e_commerce_data
						where YEAR(Order_Date)=2011 and MONTH(Order_Date)=1
						intersect
						select distinct Cust_ID
						from e_commerce_data
						where YEAR(Order_Date)=2011 and MONTH(Order_Date)=12) t12
) t



--4. Write a query to return for each user the time elapsed between the first purchasing and the third purchasing, in ascending order by Customer ID.

with t as (

select 
		distinct
		Cust_ID,
		Ord_ID,
		Order_Date,
		MIN(Order_Date) over (partition by Cust_ID order by Order_Date) first_order,
		row_number() over (partition by Cust_ID order by Order_Date) row_num
from 
		e_commerce_data
			)
--order by Cust_ID, Order_Date

select 
		Cust_ID, 
		first_order, 
		Order_Date third_order, 
		DATEDIFF(DAY, first_order, Order_Date) num_of_days_between_1st_3rd_orders
from t
where row_num=3
order by Cust_ID



--5. Write a query that returns customers who purchased both product 11 and product 14, as well as the ratio of these products to the total number of products purchased by the customer.

select 
		distinct 
		Cust_ID,
		sum(case when Prod_ID='Prod_11' or Prod_ID='Prod_14' then 1 else 0 end) over (partition by Cust_ID) cnt1,
		COUNT(Prod_ID) over (partition by Cust_ID) total_pro_per_cus,
		cast(1.0 * sum(case when Prod_ID='Prod_11' or Prod_ID='Prod_14' then 1 else 0 end) over (partition by Cust_ID) /
		COUNT(Prod_ID) over (partition by Cust_ID) as decimal(38,2)) ratio
		
from e_commerce_data
where Cust_ID in (
					select Cust_ID from e_commerce_data where Prod_ID='Prod_11' 
						intersect
					select Cust_ID from e_commerce_data where Prod_ID='Prod_14'
				 )
order by Cust_ID

-------------

-- Customer Segmentation

-- 1. Create a “view” that keeps visit logs of customers on a monthly basis. (For each log, three field is kept: Cust_id, Year, Month)

create view vw_cus_year_month as

select Cust_ID, YEAR(Order_Date) years, MONTH(Order_Date) months 
from e_commerce_data



-- 2. Create a “view” that keeps the number of monthly visits by users. (Show separately all months from the beginning business)

create view vw_total_cus_per_month as

select distinct months, COUNT(Cust_ID) over (partition by months) cnt_cus_per_month
from vw_cus_year_month



--3. For each visit of customers, create the next month of the visit as a separate column.

select Cust_ID, Order_Date, LEAD(month(Order_Date)) over (partition by Cust_ID order by Order_Date) month_of_next_visit
from e_commerce_data
order by Cust_ID, Order_Date



--4. Calculate the monthly time gap between two consecutive visits by each customer.

select 
	Cust_ID, 
	Order_Date, 
	LEAD(Order_Date) over (partition by Cust_ID order by Order_Date) month_of_next_visit,
	DATEDIFF(MONTH, Order_Date, LEAD(Order_Date) over (partition by Cust_ID order by Order_Date)) monthly_time_gap 
from e_commerce_data
order by Cust_ID, Order_Date



-- 5. Categorise customers using average time gaps. Choose the most fitted labeling model for you. For example: Labeled as churn if the customer hasn't made another purchase in the months since they made their first purchase. Labeled as regular if the customer has made a purchase every month.Etc.

select 
distinct Cust_ID, 
case when avg(monthly_time_gap) over (partition by Cust_ID order by Cust_ID) <= 12 then 'regular' 
else 'churn' end label_customer 

from
(select 
	Cust_ID, 
	Order_Date, 
	LEAD(Order_Date) over (partition by Cust_ID order by Order_Date) month_of_visit_next,
	DATEDIFF(MONTH, Order_Date, LEAD(Order_Date) over (partition by Cust_ID order by Order_Date)) monthly_time_gap 
from e_commerce_data
) t
order by Cust_ID



--Month-Wise Retention Rate
--1. Find the number of customers retained month-wise. (You can use time gaps)
--2. Calculate the month-wise retention rate.

select *, cast(1.0 * cnt_cus_per_month / SUM(cnt_cus_per_month) over () as decimal(38,3)) retention_rate
from vw_total_cus_per_month
order by months