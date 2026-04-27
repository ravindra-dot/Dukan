create database dukan;
use dukan;

CREATE TABLE logs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    admin_id INT NOT NULL,
    action_type VARCHAR(50) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

create table Categories(
id int auto_increment primary key,
category_name varchar(50) not null unique
);

Create table Users(
id int auto_increment primary key,
full_name varchar(100) not null,
email varchar(100) not null,
phone varchar(15) unique not null,
password varchar(255) not null,
address text ,
created_at timestamp default current_timestamp
);

create table Products(
id int auto_increment primary key,
name varchar(100) not null,
brand varchar(50),
price decimal(10,2) not null,
unit varchar(20) not null,
stock int default 0,
category_id int,
expiry_date date,
foreign key(category_id) references Categories(id)
);

create table Orders(
id int auto_increment primary key,
user_id int,
order_date timestamp default current_timestamp,
total_amount decimal(10,2),
payment_status Enum('Paid','Pending') default 'Pending',
foreign key (user_id) references Users(id)
);

create table Order_Items (
    id int auto_increment primary key,
    order_id int,
    product_id int,
    quantity int not null,
    price_at_purchase decimal(10,2),
    foreign key (order_id) references Orders(id),
    foreign key (product_id) references Products(id)
);
