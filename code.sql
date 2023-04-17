INSERT INTO medicine (id, name, quantity, unit_price, expiration_date) 
VALUES 
(1, 'Aspirin', 100, 0.5, '2024-01-01'),
(2, 'Paracetamol', 50, 0.3, '2025-02-01'),
(3, 'Amoxicillin', 30, 2.5, '2023-05-01');

-- Insert data into the 'supplier' table
INSERT INTO supplier (id, name, email, phone, address) 
VALUES 
(1, 'ABC Pharma', 'abcpharma@gmail.com', '123-456-7890', '123 Main St, Anytown USA'),
(2, 'XYZ Pharma', 'xyzpharma@gmail.com', '987-654-3210', '456 Elm St, Anytown USA');

-- Insert data into the 'purchase' table
INSERT INTO purchase (id, supplier_id, total, date) 
VALUES 
(1, 1, 20.0, '2022-10-01'),
(2, 2, 50.0, '2022-11-01');

-- Insert data into the 'purchase_item' table
INSERT INTO purchase_item (purchase_id, medicine_id, quantity) 
VALUES 
(1, 1, 50),
(1, 2, 100),
(2, 2, 200),
(2, 3, 50);

-- Insert data into the 'customer' table
INSERT INTO customer (id, name, email, phone, address) 
VALUES 
(1, 'John Doe', 'johndoe@gmail.com', '555-1234', '789 Maple St, Anytown USA'),
(2, 'Jane Smith', 'janesmith@yahoo.com', '555-5678', '456 Oak St, Anytown USA');

-- Insert data into the 'sale' table
INSERT INTO sale (id, customer_id, total, date) 
VALUES 
(1, 1, 10.0, '2022-10-01'),
(2, 2, 25.0, '2022-11-01');

-- Insert data into the 'sale_item' table
INSERT INTO sale_item (sale_id, medicine_id, quantity) 
VALUES 
(1, 1, 10),
(1, 2, 20),
(2, 2, 50),
(2, 3, 10);

-- Insert data into the 'prescription' table
INSERT INTO prescription (id, patient_id, doctor_id, date) 
VALUES 
(1, 1, 2, '2022-10-01'),
(2, 2, 1, '2022-11-01');

-- Insert data into the 'prescription_item' table
INSERT INTO prescription_item (prescription_id, medicine_id, quantity) 
VALUES 
(1, 1, 10),
(1, 2, 20),
(2, 2, 50),
(2, 3, 10);

-- Insert data into the 'users' table
INSERT INTO users (id, username, password, role) 
VALUES 
(1, 'admin', 'password', 'admin'),
(2, 'user', 'password', 'user');
