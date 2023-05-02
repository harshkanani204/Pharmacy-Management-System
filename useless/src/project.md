# For creating the tables...

```sql

CREATE TABLE Medicine (
    ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Quantity INT,
    Unit_Price DECIMAL(10,2),
    Expiration_Date DATE
);

CREATE TABLE Customer (
    ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(20),
    Address VARCHAR(200)
);

CREATE TABLE users (
    ID INT PRIMARY KEY,
    Username VARCHAR(50),
    Password VARCHAR(50),
    Role VARCHAR(20)
);

CREATE TABLE Sale (
    ID INT PRIMARY KEY,
    Customer_ID INT,
    Total DECIMAL(10,2),
    Date DATE,
    CONSTRAINT FK_Sale_Customer FOREIGN KEY (Customer_ID) REFERENCES Customer(ID)
);

CREATE TABLE Sale_Item (
    Sale_ID INT,
    Medicine_ID INT,
    Quantity INT,
    CONSTRAINT PK_Sale_Item PRIMARY KEY (Sale_ID, Medicine_ID),
    CONSTRAINT FK_Sale_Item_Sale FOREIGN KEY (Sale_ID) REFERENCES Sale(ID),
    CONSTRAINT FK_Sale_Item_Medicine FOREIGN KEY (Medicine_ID) REFERENCES Medicine(ID)
);

CREATE TABLE Prescription (
    ID INT PRIMARY KEY,
    Patient_ID INT,
	Doctor_ID INT,
    Date DATE
);

CREATE TABLE Prescription_Item (
    Prescription_ID INT,
    Medicine_ID INT,
    Quantity INT,
    CONSTRAINT PK_Prescription_Item PRIMARY KEY (Prescription_ID, Medicine_ID),
    CONSTRAINT FK_Prescription_Item_Prescription FOREIGN KEY (Prescription_ID) REFERENCES Prescription(ID),
    CONSTRAINT FK_Prescription_Item_Medicine FOREIGN KEY (Medicine_ID) REFERENCES Medicine(ID)
);

CREATE TABLE Supplier (
    ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(20),
    Address VARCHAR(200)
);

CREATE TABLE Purchase (
    ID INT PRIMARY KEY,
    Supplier_ID INT,
    Total DECIMAL(10,2),
    Date DATE,
    CONSTRAINT FK_Purchase_Supplier FOREIGN KEY (Supplier_ID) REFERENCES Supplier(ID)
);

CREATE TABLE Purchase_Item (
    Purchase_ID INT,
    Medicine_ID INT,
    Quantity INT,
    CONSTRAINT PK_Purchase_Item PRIMARY KEY (Purchase_ID, Medicine_ID),
    CONSTRAINT FK_Purchase_Item_Purchase FOREIGN KEY (Purchase_ID) REFERENCES Purchase(ID),
    CONSTRAINT FK_Purchase_Item_Medicine FOREIGN KEY (Medicine_ID) REFERENCES Medicine(ID)
);
```

# For inserting the data into database

```sql
-- Insert data into the 'medicine' table
INSERT INTO public.medicine (id, name, quantity, unit_price, expiration_date) 
VALUES 
(1, 'Aspirin', 100, 0.5, '2024-01-01'),
(2, 'Paracetamol', 50, 0.3, '2025-02-01'),
(3, 'Amoxicillin', 30, 2.5, '2023-05-01');

-- Insert data into the 'supplier' table
INSERT INTO public.supplier (id, name, email, phone, address) 
VALUES 
(1, 'ABC Pharma', 'abcpharma@gmail.com', '123-456-7890', '123 Main St, Anytown USA'),
(2, 'XYZ Pharma', 'xyzpharma@gmail.com', '987-654-3210', '456 Elm St, Anytown USA');

-- Insert data into the 'purchase' table
INSERT INTO public.purchase (id, supplier_id, total, date) 
VALUES 
(1, 1, 20.0, '2022-10-01'),
(2, 2, 50.0, '2022-11-01');

-- Insert data into the 'purchase_item' table
INSERT INTO public.purchase_item (purchase_id, medicine_id, quantity) 
VALUES 
(1, 1, 50),
(1, 2, 100),
(2, 2, 200),
(2, 3, 50);

-- Insert data into the 'customer' table
INSERT INTO public.customer (id, name, email, phone, address) 
VALUES 
(1, 'John Doe', 'johndoe@gmail.com', '555-1234', '789 Maple St, Anytown USA'),
(2, 'Jane Smith', 'janesmith@yahoo.com', '555-5678', '456 Oak St, Anytown USA');

-- Insert data into the 'sale' table
INSERT INTO public.sale (id, customer_id, total, date) 
VALUES 
(1, 1, 10.0, '2022-10-01'),
(2, 2, 25.0, '2022-11-01');

-- Insert data into the 'sale_item' table
INSERT INTO public.sale_item (sale_id, medicine_id, quantity) 
VALUES 
(1, 1, 10),
(1, 2, 20),
(2, 2, 50),
(2, 3, 10);

-- Insert data into the 'prescription' table
INSERT INTO public.prescription (id, patient_id, doctor_id, date) 
VALUES 
(1, 1, 2, '2022-10-01'),
(2, 2, 1, '2022-11-01');

-- Insert data into the 'prescription_item' table
INSERT INTO public.prescription_item (prescription_id, medicine_id, quantity) 
VALUES 
(1, 1, 10),
(1, 2, 20),
(2, 2, 50),
(2, 3, 10);

-- Insert data into the 'users' table
INSERT INTO public.users (id, username, password, role) 
VALUES 
(1, 'admin', 'password', 'admin'),
(2, 'user', 'password', 'user');

```