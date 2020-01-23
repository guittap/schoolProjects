create table orders (
    orderid int not null,
    orderno int not null,
    personid int 
    primary key (orderid)
    foreign key (personid) references
    persons(personid)
);

--select all from parts and inner join with odetails based on pno
select * from parts join odetails on odetails.pno = parts.pno;

--select all from zipcodes and inner join it with customers based or zipcodes
select * from zipcodes inner join customers on customers.zip = zicodes.zip;

--select all from zipxodes and left join it with costomers based on zipcodes
select * from zipcodes left join customers on customers.zip = zipcodes.zip;

--select all different zipcodes from employees and zipcode tables and remove duplicates
select zip from employees union select zip from zipcodes order by zip;

--find the average part price 
select avg(price) from parts;
--we could do avg, min, max, sum, count

--how many parts are avilable for sale
select count(pno) from parts;

--select all parts where the qoh is greater than the average of all parts
select * from parts where qoh > (select avg(qoh) from parts);

--select pname and price from parts with highest quantity ordered
select pname from parts where pno = (select pno from odetails where qty = (selet max(qty) from odetails));

--show all cities from zipcodes where customers do not live in
select * from zipcodes where zip not in (select zip from customers);

--=show all zipcodes and cities from zipcode table where none of the employees live
select * from zipcodes where not exists (select * from employees where employees.zip = zipcodes.zip);

--give all order ono where the order contains both parts 10601 and 10701
select * from odetails where pno = 10601 and pno = 10701; --not the right answer
select * from odetails where pno = 10601 union sele
