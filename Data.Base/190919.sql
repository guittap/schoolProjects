create table zipcode (
    -> zip int(5) not null,
    -> city varchar(30) default null,
    -> primary key(zip));

--select everything from odetails where the quantity is larger than 1

select * from odetails where qty > 1;

--select 3 cols pname, qoh, price from parts where price is less than 20

select 
    pname,
    qoh,
    price
from parts
where price < 20;

--select all from zipcodes where the city starts with "co"

select * from zipcodes where city like 'Co%'; --percent is trhe wild card we use for zero or more

--select from customers where customer name starts with B and zipcode is 60606

select * from customers where cname like 'B%' and zip = 60606;

--rename select cno and alias it as 'customer-number' from table customer

select cno as CustomerNumber from customer;

--select all columns from odetails sorted ascending by one and descending by the pno

select * from odetails order by ono asc, pno desc;

--select all from zipcodes where city name is in columbia, FOrt Hays, Las Vegas

select * from zipcodes where city in ('Colombia', 'Fort Hays', 'Las Vegas');

select * from zipcodes 
where city like 'Columbia' 
or city like 'Fort Hays' 
or city like 'Las Vegas';

--select all from table parts where qoh is not between 50 and 130

select * from parts where qoh not between 50 and 130;

--select all orders that have not shipped

select * from orders where shipped is NULL;

--select cno and show how many orders each cno has placed

select cno, count(*) from orders group by cno;

-- remove duplicated ono from odetails

select distinct ono from odetails;



