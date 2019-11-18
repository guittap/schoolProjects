--Wargen Guittap
--CS457 Homework #5

--1. get the names of the parts that cost less than $20.00.
select p.pname 
from Parts p 
where p.price < 20.00;

-- output
-- +----------------------+
-- | pname                |
-- +----------------------+
-- | Land Before Time I   |
-- | Land Before Time II  |
-- | Land Before Time III |
-- | Land Before Time IV  |
-- | When Harry Met Sally |
-- | Dirty Harry          |
-- +----------------------+

--2. get the names and the cities of employees who have taken orders for parts costing more than $50.00.
select distinct e.ename, z.city 
from Zipcodes z, Employees e, Odetails od, Parts p, Orders o
where z.zip = e.zip 
and e.eno = o.eno 
and o.ono = od.ono 
and od.pno = p.pno 
and p.price > 50.00;

-- output
-- Empty set

--3. get the pairs of customer number values of customers having the same zipcode.
select c1.cno as cno1, c2.cno as cno2
from Customers c1, Customers c2
where c1.zip = c2.zip
and c1.cno < c2.cno;

-- output
-- +------+------+
-- | cno1 | cno2 |
-- +------+------+
-- | 1111 | 2222 |
-- +------+------+

--4. get the name of customers who have ordered parts from employees living in Wichita.
select distinct c1.cname
from Customers c1, Employees e, Zipcodes z, Orders o
where c1.cno = o.cno 
and o.eno = e.eno 
and e.zip = z.zip 
and z.city ='Wichita';

-- output
-- +---------+
-- | cname   |
-- +---------+
-- | Charles |
-- | Barbara |
-- +---------+

--5. get the name of customers who have ordered parts ONLY from employees living in Wichita.
select distinct c1.cname
from Customers c1
where not exists
    (select z.zip from Zipcodes z where z.city ='Wichita' 
    and not exists 
        (select * from Orders o, Employees e 
        where c1.cno = o.cno 
        and o.eno = e.eno 
        and e.zip = z.zip));

-- output
-- +---------+
-- | cname   |
-- +---------+
-- | Charles |
-- | Barbara |
-- +---------+

--6. get names of customers who have ordered ALL parts costing less than $20.00.
select distinct c1.cname
from Customers c1
where not exists
    (select p.pno from Parts p where price < 20 
    and not exists
        (select * from Orders o, Odetails od
        where c1.cno = o.cno 
        and p.pno = od.pno 
        and o.ono = od.ono));

-- output
-- Empty set

--7. get the names of employees along with the total sales for 1995.
select ename , sum(od.qty*price) as totalSales
from  Employees e, Orders o, Odetails od, Parts p 
where e.eno = o.eno 
and o.ono = od.ono 
and od.pno = p.pno
and o.shipped like '1995%'
group by e.ename;

--output
-- +-------+------------+
-- | ename | totalSales |
-- +-------+------------+
-- | Jones |      99.96 |
-- | Smith |      44.98 |
-- +-------+------------+

--8. get the numbers and names of employees who have never made a sale to a customer living in the same zipcode as the employee.
select e1.eno, e1.ename
from Employees e1
where e1.eno not in
    (select e2.eno
    from Employees e2, Orders o, Customers c
    where e1.zip=c.zip 
    and e1.eno=o.eno 
    and c.cno=o.cno);

-- output
-- +------+-------+
-- | eno  | ename |
-- +------+-------+
-- | 1001 | Smith |
-- | 1002 | Brown |
-- +------+-------+

--9. get the names of customers who have placed the highest number of orders.
select c1.cname, count(*) as orderCount
from Customers c1, Orders o
where c1.cno = o.cno
group by c1.cname
order by orderCount desc
limit 1;

-- output
-- +---------+------------+
-- | cname   | orderCount |
-- +---------+------------+
-- | Charles |          2 |
-- +---------+------------+

--10. get the names of customers who have placed the most expensive orders.
select c1.cname, sum(od.qty*price) as mostExpensive
from  Customers c1, Orders o, Odetails od, Parts p 
where c1.cno = o.cno 
and o.ono = od.ono 
and od.pno = p.pno
group by od.ono
order by mostExpensive desc
limit 1;

-- output
-- +---------+---------------+
-- | cname   | mostExpensive |
-- +---------+---------------+
-- | Charles |        139.93 |
-- +---------+---------------+

--11. get the names of parts that have been ordered the most (in terms of quantity ordered, not number of orders).
select pname p, sum(od.qty) as sumParts
from Parts p, Odetails od
where p.pno = od.pno 
group by p.pname
order by sumParts desc
limit 1;

-- output
-- +-----------------+----------+
-- | p               | sumParts |
-- +-----------------+----------+
-- | Sleeping Beauty |        5 |
-- +-----------------+----------+

--12. get the names of parts along with the number of orders they appear in sorted order of the number of orders.
select p.pname, count(o.ono) as numOfOrderAppear
from Parts p, Orders o, Odetails od
where o.ono = od.ono 
and p.pno = od.pno
group by od.pno, p.pname
order by numOfOrderAppear desc;

-- output
-- +----------------------+------------------+
-- | pname                | numOfOrderAppear |
-- +----------------------+------------------+
-- | Sleeping Beauty      |                2 |
-- | When Harry Met Sally |                1 |
-- | Land Before Time I   |                1 |
-- | Dirty Harry          |                1 |
-- | Land Before Time II  |                1 |
-- | Dr. Zhivago          |                1 |
-- | Land Before Time III |                1 |
-- | Land Before Time IV  |                1 |
-- +----------------------+------------------+

--13. get the average waiting time for all orders in number of days. The waiting time for an order is defined as the difference
--    between the shipped date and the recieved date. Note: The dates should be trncated to 12:00 AM so that the difference is always
--    a whole number of days.
select avg(waitTime) as averageWaitTime 
from (select datediff(shipped, received) as waitTime 
    from Orders order by ono) as waitRow;

-- output
-- +-----------------+
-- | averageWaitTime |
-- +-----------------+
-- |          4.0000 |
-- +-----------------+