-- add_order: This procedure takes as input an order number, customer
-- number, and received date and tries to insert a new row in the orders
-- table. if the received date is null, the current date is used. the shipped 
-- date is left null

delimiter //


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

-- ship_order: this procedure takes as input as input an order nunber and a 
-- shipped date and tries to update the shipped value for the order. If
-- the shipped date is null, the current date is used.