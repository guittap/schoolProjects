-- Wargen Guittap --
-- Homework #6 --
-- CS 457 --

-- add_order: This procedure takes as input an order number, customer
-- number, and received date and tries to insert a new row in the orders
-- table. if the received date is null, the current date is used. the shipped 
-- date is left null

-- refresh the table
source ~/cs457/ass4.sql

delimiter //
drop procedure if exists add_order//
create procedure add_order(
    in newOno int(5),
    in newCno int(5),
    in newEno int(4),
    in newReceived DATE
)
begin
    insert into Orders(ONO, CNO, ENO, RECEIVED, SHIPPED)
        values (newOno, newCno, newEno, newReceived, NULL);
    if newReceived is NULL then
        update Orders set RECEIVED = curdate() where ono = newOno;
    end if;
end//
delimiter ;

-- add_order_details: this procedure receives as input an order number,
-- part number, and quantity and attempts to add a row corresponding
-- to the input in the odetails table. if the quantity on hand for
-- the part is less than what is ordered, an error message is sent to the 
-- odetails_errors table, which consists of four columns: (1) transaction
-- date, (2) order number, (3) part number, and (4) message column.
-- Otherwise, the part is sold by subtracting the quantity on hand for 
-- this part. A check is also made for the reorder level. If the updated
-- quantity for the part is below the reorder level, a message is sent to
-- the restock table, which consists of two columns: the transaction date
-- and the part number of the part to be reordered.

drop table if exists Odetails_Errors;
drop table if exists Restock;

-- creating tables necessary for this procedure
create table Odetails_Errors (
    TDATE DATE,
    ONO int(5),
    PNO int(5),
    MESS varchar(50)
);

create table Restock (
    TDATE DATE,
    PNO int(5)
);

delimiter //
drop procedure if exists add_order_details//
create procedure add_order_details (
    in newOno int(5),
    in newPno int(5),
    in newQty int(11)
)
begin
    if newQty > (select QOH from Parts where PNO = newPno) then
        insert into Odetails_Errors(TDATE, ONO, PNO, MESS)
            values (curdate(), newOno, newPno, 'order quantity exceeds quantity on hand');
    else
        insert into Odetails(ONO, PNO, QTY)
            values (newOno, newPno, newQty);
        update Parts set QOH = QOH - newQty where PNO = newPno;
        if (select qoh from Parts where PNO = newPno) < (select olevel from Parts where PNO = newPno) then
            insert into Restock(TDATE, PNO)
                values (curdate(), newPno);
        end if;
    end if;                                                                                                                                         
end//
delimiter ;

-- ship_order: this procedure takes as input as input an order nunber and a 
-- shipped date and tries to update the shipped value for the order. If
-- the shipped date is null, the current date is used.

delimiter //
drop procedure if exists ship_order//
create procedure ship_order (
    in newOno int(5),
    in newShipped DATE
)
begin
    update Orders set SHIPPED = newShipped where ono = newOno;
    if newShipped is NULL then
        update Orders set SHIPPED = curdate() where ono = newOno;
    end if;
end//
delimiter ;

-- test queries
-- call add_order (2000,1111,1000,NULL);
-- call add_order_details (2000,10509,50);
-- call add_order_details (2000, 10701, 200);
-- call ship_order (2000,'1998-01-29');
-- call add_order (2001,1234,1000,NULL);
-- call orders.add_order_details (2000,10999,5);

-- select statements
-- select * from Orders;
-- select * from Odetails;
-- select * from Parts;
-- select * from Odetails_Errors;
-- select * from Restock;