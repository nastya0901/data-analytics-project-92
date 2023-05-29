
select count(*)as customers_count from customers;

select CONCAT (e.first_name,' ',e.last_name) as name,count(*) as operations, sum (p.price*s.quantity) as income from sales s  
left join employees e  
on s.sales_person_id = e.employee_id
left join products p
on s.product_id = p.product_id
group by CONCAT (e.first_name,' ',e.last_name)
order by 3 desc 
limit 10;


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

select name, weekday, income from (
select CONCAT (e.first_name,' ',e.last_name) as name,
extract (isodow from s.sale_date) as num, to_char (s.sale_date,'Day') as weekday,
round (sum (p.price*s.quantity)) as income from sales s  
left join employees e  
on s.sales_person_id = e.employee_id
left join products p
on s.product_id = p.product_id
group by 2,3,1) as t
order by num, name
;


