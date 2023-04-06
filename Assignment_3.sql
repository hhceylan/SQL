

create database Manufacturer
use Manufacturer

create table [Product] 
(
[prod_id] int primary key not null,
[prod_name] nvarchar(50)  not null,
[quantity] int not null
);


create table [Component] 
(
[comp_id] int primary key not null,
[comp_name] nvarchar(50)  not null,
[description] nvarchar(50)  not null,
[quantity_comp] int not null
);


create table [Supplier] 
(
[supp_id] int primary key not null,
[supp_name] nvarchar(50)  not null,
[supp_location] nvarchar(50)  not null,
[supp_country] nvarchar(50)  not null,
[is_active] bit not null
);


create table [Prod_Comp]
(
[prod_id] int not null references [Product],
[comp_id] int not null references [Component],
primary key ([prod_id], [comp_id]),
[quantity_comp] int not null
);


create table [Comp_Supp]
(
[supp_id] int not null references [Supplier],
[comp_id] int not null references [Component],
primary key ([supp_id], [comp_id]),
[order_date] date not null,
[quantity] int not null
);

--------

select *
from Product, Component, Supplier, Prod_Comp, Comp_Supp