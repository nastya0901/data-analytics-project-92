/* customers_count.csv */
select count(*)as customers_count from customers;

/* top_10_total_income.csv */
select CONCAT (e.first_name,' ',e.last_name) as name,count(*) as operations, sum (p.price*s.quantity) as income from sales s  
left join employees e  
on s.sales_person_id = e.employee_id
left join products p
on s.product_id = p.product_id
group by CONCAT (e.first_name,' ',e.last_name)
order by 3 desc 
limit 10;

/* lowest_average_income.csv */
select * from (
select CONCAT (e.first_name,' ',e.last_name) as name, round(avg (p.price*s.quantity)) as average_income from sales s  
left join employees e  
on s.sales_person_id = e.employee_id
left join products p
on s.product_id = p.product_id
group by CONCAT (e.first_name,' ',e.last_name)) A
where average_income < (select  round(avg (p.price*s.quantity)) as average_income from sales s  
left join products p
on s.product_id = p.product_id ) 
order by 2;

/* day_of_the_week_income.csv */
select name, weekday, income from (
select CONCAT (e.first_name,' ',e.last_name) as name,
extract (isodow from s.sale_date) as num, to_char (s.sale_date,'Day') as weekday,
round (sum (p.price*s.quantity)) as income from sales s  
left join employees e  
on s.sales_person_id = e.employee_id
left join products p
on s.product_id = p.product_id
group by 2,3,1) as t
order by num, name;

/* age_groups.csv */
select 
case when age between 10 and 15 then '10-15' 
     when age between 16 and 25 then '16-25'
     when age between 26 and 40 then '26-40'else '40+' end as count,
    count (*) as age from customers
   group by age_category
   order by age_category;
  
  
/* customers_by_month.csv */
select  to_char(sale_date, 'YYYY-MM') as date, count( distinct customer_id) as total_customers, sum(price*quantity)as income from sales s
left join products p
on s.product_id = p.product_id
group by date;



/* special_offer.csv */
select customer, sale_date, seller from (
select s.customer_id, CONCAT (c.first_name,' ',c.last_name) as customer,
sale_date, CONCAT (e.first_name,' ',e.last_name) as seller, p.price, s.sales_id,
row_number() over (partition by s.customer_id order by sale_date, sales_id) as salenumber
from sales s
left join employees e  
on s.sales_person_id = e.employee_id
left join products p
on s.product_id = p.product_id
left join customers c
on s.customer_id=c.customer_id
) s 
where salenumber = 1 and price = 0
order by customer_id




