--Wargen Guittap
--CS457 Homework #4

--table Employees
create table Employees (
    ENO int(4),
    ENAME varchar(30),
    ZIP int(5),
    HDATE DATE,
    primary key (ENO)
);

insert into Employees(ENO, ENAME, ZIP, HDATE)
values
    (1000, 'Jones', 67226, '1995-12-12'),
    (1001, 'Smith', 60606, '2009-01-01'),
    (1002, 'Brown', 50302, '1994-09-01');

--table Parts
create table Parts (
    PNO int(5),
    PNAME varchar(30),
    QOH int(3),
    PRICE decimal(4,2),
    OLEVEL int(2),
    primary key (PNO)
);

insert into Parts(PNO, PNAME, QOH, PRICE, OLEVEL)
values
    (10506, 'Land Before Time I', 200, 19.99, 20),
    (10507, 'Land Before Time II', 156, 19.99, 20),
    (10508, 'Land Before Time III', 190, 19.99, 20),
    (10509, 'Land Before Time IV', 60, 19.99, 20),
    (10601, 'Sleeping Beauty', 300, 24.99, 20),
    (10701, 'When Harry Met Sally', 120, 19.99, 30),
    (10800, 'Dirty Harry', 140, 14.99, 30),
    (10900, 'Dr. Zhivago', 100, 24.99, 30);

--Customers
create table Customers (
    CNO int(4),
    CNAME varchar(30),
    STREET varchar(30),
    ZIP int(5),
    PHONE varchar(12),
    primary key (CNO)
);

insert into Customers(CNO, CNAME, STREET, ZIP, PHONE)
values
    (1111, 'Charles', '123 Main St.', 67226, '316-636-5555'),
    (2222, 'Berram', '237 Ash Avenue', 67226, '316-689-5555'),
    (3333, 'Barbara', '111 Inwood St.', 60606, '316-111-1234');

--Orders
create table Orders (
    ONO int(4),
    CNO int(4),
    ENO int(4),
    RECEIVED DATE,
    SHIPPED DATE,
    primary key (ONO)
);

insert into Orders(ONO, CNO, ENO, RECEIVED, SHIPPED)
values
    (1020, 1111, 1000, '1994-12-10', '1994-12-12'),
    (1021, 1111, 1000, '1995-01-12', '1995-01-15'),
    (1022, 2222, 1001, '1995-02-13', '1995-02-20'),
    (1023, 3333, 1000, '1997-06-20', NULL);

--Odetails
create table Odetails (
    ONO int(4),
    PNO int(5),
    QTY int(1),
    primary key(ONO, PNO)
);

insert into Odetails(ONO, PNO, QTY)
values
    (1020, 10506, 1),
    (1020, 10507, 1),
    (1020, 10508, 2),
    (1020, 10509, 3),
    (1021, 10601, 4),
    (1022, 10601, 1),
    (1022, 10701, 1),
    (1023, 10800, 1),
    (1023, 10900, 1);

--Zipcodes
create table Zipcodes (
    ZIP int(5),
    CITY varchar(30),
    primary key(ZIP)
);

insert into Zipcodes(ZIP, CITY)
values
    (67226, 'Wichita'),
    (60606, 'Fort Dodge'),
    (50302, 'Kansas City'),
    (54444, 'Colombia'),
    (66002, 'Liberal'),
    (61111, 'Fort Hays');

--alter statements
-- alter table Employees add foreign key (ZIP) references Zipcodes(ZIP);
-- alter table Parts add foreign key (PNO) references Odetails(PNO);
-- alter table Customers add foreign key (CNO) references Orders(CNO);
-- alter table Customers add foreign key (ZIP) references Zipcodes(ZIP);
-- alter table Orders add foreign key (ONO) references Odetails(ONO);
-- alter table Orders add foreign key (CNO) references Customers(CNO);
-- alter table Orders add foreign key (ENO) references Employees(ENO);
-- alter table Odetails add foreign key(ONO) references Orders(ONO);
-- alter table Odetails add foreign key(PNO) references Parts(PNO);

--select statements
select ENO, ENAME, ZIP, date_format(HDATE, '%d-%b-%y') from Employees;
select * from Parts;
select * from Customers;
select ONO, CNO, ENO, date_format(RECEIVED, '%d-%b-%y'), date_format(SHIPPED, '%d-%b-%y') from Orders;
select * from Odetails;
select * from Zipcodes;