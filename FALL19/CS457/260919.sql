--give all ono where the order contains parts 10601 and 10701
select * from odetails s, odetails t where s.ono = t.ono and s.pno = 10601 and t.pno = 10701;

--for each part get pno and pname values along with a new column containing total_sales
select parts.pno, pname, sum(qty*price) TOTAL_SALES from odetails, parts where odetails.pno = parts.pno group by parts.pno, pname;

--for each part get pno and pname with a new column containing total_SALES but only when the total sale exceeds $50
select parts.pno, pname, sum(qty*price) TOTAL_SALES from odetails, parts where odetails.pno = parts.pno group by parts.pno, pname having sum(qty*price) > 50;

--get pno and pname of parts ordered by at least 9 different customers
select parts.pno, parts.pname from orders, odetails, parts where orders.ono = odetails.ono group by parts.pno, parts.pname having count(distinct cno) > 2;

--get pno values of parts that have been ordered by all customers from Fort Dodge
select pno from parts as p where not exists (select cno from customer as c, zipcodes as z where z.zip = c.zip and z.city = 'Fort Dodge' and not exists (select * from orders as o, odetails as od where o.ono = od.ono and od.pno = p.pno and c.cno = o.cno));

--sql functions
delimiter // --default delimiter = ;
show tables//
source ~/cs457/procedure.sql

--example
use mailorders;
drop procedure if exists p;
delimiter //

create procedure p()
begin
    select * from zipcodes;
    select * from employees;
    select count(*) from zipcodes;
end//

delimiter ;

declare vaiable.name type(size)
default default_value;

declare total int default 0;
set total = 5;

select count (*) into total from zipcode,

-- hello

select @total

--if exp then statement;
--endif;

--if exp then
--  statement;
--elif
--  