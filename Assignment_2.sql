-- 1. Product Sales
--You need to create a report on whether customers who purchased the product named '2TB Red 5400 rpm SATA III 3.5 Internal NAS HDD' buy the product below or not.

--1. 'Polk Audio - 50 W Woofer - Black' -- (other_product)

select c.customer_id, c.first_name, c.last_name, 'no' as other_product 
from sale.customer c, sale.orders o, sale.order_item oi, product.product p
where c.customer_id=o.customer_id and o.order_id=oi.order_id and oi.product_id=p.product_id and p.product_name='2TB Red 5400 rpm SATA III 3.5 Internal NAS HDD'

except 

select c.customer_id, c.first_name, c.last_name, 'no' as other_product
from sale.customer c, sale.orders o, sale.order_item oi, product.product p
where c.customer_id=o.customer_id and o.order_id=oi.order_id and oi.product_id=p.product_id and p.product_name='Polk Audio - 50 W Woofer - Black'


-- 2. Conversion Rate
--Below you see a table of the actions of customers visiting the website by clicking on two different types of advertisements given by an E-Commerce company. Write a query to return the conversion rate for each Advertisement type.

--a.    Create above table (Actions) and insert values,

create table Actions (VisitorID int, Adv_Type varchar(255), Action varchar(255))

/*insert into Actions (VisitorID, Adv_Type, Action)
values(1, 'A', 'Left')

insert into Actions (VisitorID, Adv_Type, Action)
values(2, 'A', 'Order')

insert into Actions (VisitorID, Adv_Type, Action)
values(3, 'B', 'Left')

insert into Actions (VisitorID, Adv_Type, Action)
values(4, 'A', 'Order')

insert into Actions (VisitorID, Adv_Type, Action)
values(5, 'A', 'Review')

insert into Actions (VisitorID, Adv_Type, Action)
values(6, 'A', 'Left')

insert into Actions (VisitorID, Adv_Type, Action)
values(7, 'B', 'Left')

insert into Actions (VisitorID, Adv_Type, Action)
values(8, 'B', 'Order')

insert into Actions (VisitorID, Adv_Type, Action)
values(9, 'B', 'Review')

insert into Actions (VisitorID, Adv_Type, Action)
values(10, 'A', 'Review')*/

select *
from Actions

--b.    Retrieve count of total Actions and Orders for each Advertisement Type,
--c.    Calculate Orders (Conversion) rates for each Advertisement Type by dividing by total count of actions casting as float by multiplying by 1.0.

-- Answer to the questions b and c:

with t1 as (select A.Adv_Type, COUNT(A.Action) num_order
from Actions A
where Action='Order'
group by A.Adv_Type),

t2 as (
select B.Adv_Type, COUNT(B.Action) num_action
from Actions B
group by B.Adv_Type)

select t1.Adv_Type, t1.num_order, t2.num_action, convert(decimal(38,2), (1.0*t1.num_order) / (1.0*t2.num_action)) as conversion_rate
from t1
inner join t2 on t1.Adv_Type=t2.Adv_Type