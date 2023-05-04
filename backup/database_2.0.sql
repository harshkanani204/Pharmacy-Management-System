---Tables

    -- Company table
    CREATE TABLE Company (
    CompanyID SERIAL PRIMARY KEY,
    CompanyName VARCHAR(255),
    CompanyAddress VARCHAR(255),
    CompanyPhone VARCHAR(20),
    CompanyEmail VARCHAR(255)
    );

    --- Insert data into Company table
    INSERT INTO Company (CompanyName, CompanyAddress, CompanyPhone, CompanyEmail) VALUES
    ('ABC Pharmacy', '123 Main Street, Anytown USA', '+1 (555) 555-1234', 'info@abcpharmacy.com'),
    ('XYZ Drugstore', '456 Oak Avenue, Anytown USA', '+1 (555) 555-5678', 'info@xyzdrugstore.com'),
    ('MNO Health Mart', '789 Elm Road, Anytown USA', '+1 (555) 555-9012', 'info@mnohealthmart.com'),
    ('PQR Pharmacy', '321 Maple Drive, Anytown USA', '+1 (555) 555-3456', 'info@pqrpharmacy.com'),
    ('EFG Drugs', '654 Pine Street, Anytown USA', '+1 (555) 555-7890', 'info@efgdrugs.com');
    ('LMN Pharmacy', '987 Cedar Lane, Anytown USA', '+1 (555) 555-4321', 'info@lmnpharmacy.com'),
    ('JKL Drugstore', '654 Birch Street, Anytown USA', '+1 (555) 555-8765', 'info@jkldrugstore.com'),
    ('QRS Health Mart', '321 Elmwood Drive, Anytown USA', '+1 (555) 555-2109', 'info@qrshealthmart.com'),
    ('UVW Pharmacy', '246 Maple Road, Anytown USA', '+1 (555) 555-6543', 'info@uvwpharmacy.com'),
    ('HIJ Drugs', '753 Oak Lane, Anytown USA', '+1 (555) 555-0987', 'info@hijdrugs.com'),
    ('NOP Pharmacy', '159 Pine Drive, Anytown USA', '+1 (555) 555-4321', 'info@noppharmacy.com'),
    ('RST Drugstore', '753 Cedar Street, Anytown USA', '+1 (555) 555-8765', 'info@rstdrugstore.com'),
    ('GHI Health Mart', '987 Elm Avenue, Anytown USA', '+1 (555) 555-2109', 'info@ghihealthmart.com'),
    ('JKM Pharmacy', '357 Maple Lane, Anytown USA', '+1 (555) 555-6543', 'info@jkmpharmacy.com'),
    ('QPT Drugs', '753 Birch Drive, Anytown USA', '+1 (555) 555-0987', 'info@qptdrugs.com'),
    ('LMR Pharmacy', '159 Oak Road, Anytown USA', '+1 (555) 555-4321', 'info@lmrpharmacy.com'),
    ('UVT Drugstore', '753 Pine Avenue, Anytown USA', '+1 (555) 555-8765', 'info@uvtdrugstore.com'),
    ('GHJ Health Mart', '357 Elm Lane, Anytown USA', '+1 (555) 555-2109', 'info@ghjhealthmart.com'),
    ('KMN Pharmacy', '987 Maple Street, Anytown USA', '+1 (555) 555-6543', 'info@kmnpharmacy.com');

    -- Supplier table
    CREATE TABLE Supplier (
    SupplierID SERIAL PRIMARY KEY,
    SupplierName VARCHAR(255),
    SupplierAddress VARCHAR(255),
    SupplierPhone VARCHAR(20),
    SupplierEmail VARCHAR(255)
    );

    --- Insert data into Supplier table
    INSERT INTO Supplier (SupplierName, SupplierAddress, SupplierPhone, SupplierEmail) VALUES
    ('ABC Pharma', '123 Main St, Anytown', '555-123-4567', 'info@abcpharma.com'),
    ('XYZ Pharmaceuticals', '456 Park Ave, Anycity', '555-987-6543', 'sales@xyzpharma.com'),
    ('Medi Supplies Inc.', '789 Elm St, Anytown', '555-456-7890', 'info@medisupplies.com'),
    ('Global Health Products', '555 5th Ave, Anycity', '555-555-5555', 'sales@globalhealth.com'),
    ('Acme Pharma Inc.', '1 Industrial Blvd, Anytown', '555-111-2222', 'info@acmepharma.com'),
    ('Pharmax', '1234 Main St, Anytown', '555-555-1234', 'info@pharmax.com'),
    ('Top Notch Pharmaceuticals', '789 Oak Ave, Anycity', '555-555-5678', 'sales@topnotchpharma.com'),
    ('Meds R Us', '456 Elm St, Anytown', '555-555-9012', 'info@medsrus.com'),
    ('Global Pharma Corp', '555 6th Ave, Anycity', '555-555-3456', 'sales@globalpharma.com'),
    ('Better Health Supplies', '2 Industrial Blvd, Anytown', '555-222-3333', 'info@betterhealth.com'),
    ('Pharma One', '10 Main St, Anytown', '555-555-4444', 'info@pharmaone.com'),
    ('MediSolutions', '234 Oak Ave, Anycity', '555-555-6789', 'sales@medisolutions.com'),
    ('National Pharma', '567 Elm St, Anytown', '555-555-0123', 'info@nationalpharma.com'),
    ('PharmaCo', '890 5th Ave, Anycity', '555-555-7890', 'sales@pharmaco.com'),
    ('First Aid Supplies', '3 Industrial Blvd, Anytown', '555-333-4444', 'info@firstaidsupplies.com'),
    ('Medicorp', '11 Main St, Anytown', '555-555-5678', 'info@medicorp.com'),
    ('Global Meds', '345 Oak Ave, Anycity', '555-555-9012', 'sales@globalmeds.com'),
    ('Pharma Distributors', '678 Elm St, Anytown', '555-555-3456', 'info@pharmadistributors.com'),
    ('MediPharma', '901 5th Ave, Anycity', '555-555-6789', 'info@medipharma.com');

    -- Drug table
    CREATE TABLE Drug (
    DrugID SERIAL PRIMARY KEY,
    DrugName VARCHAR(255),
    DrugDescription VARCHAR(255),
    DrugCategory VARCHAR(255),
    CompanyID INT,
    FOREIGN KEY (CompanyID) REFERENCES Company(CompanyID)
    );

    --- Insert data into Drug table
    INSERT INTO Drug (DrugName, DrugDescription, DrugCategory, CompanyID) VALUES
    ('Aspirin', 'Pain reliever and fever reducer', 'Over-the-counter', 1),
    ('Tylenol', 'Pain reliever and fever reducer', 'Over-the-counter', 1),
    ('Lipitor', 'Cholesterol-lowering medication', 'Prescription', 2),
    ('Nexium', 'Acid reflux medication', 'Prescription', 2),
    ('Zoloft', 'Antidepressant medication', 'Prescription', 3),
    ('Advil', 'Pain reliever and fever reducer', 'Over-the-counter', 1),
    ('Aleve', 'Pain reliever and fever reducer', 'Over-the-counter', 1),
    ('Motrin', 'Pain reliever and fever reducer', 'Over-the-counter', 1),
    ('Prilosec', 'Acid reflux medication', 'Prescription', 2),
    ('Prozac', 'Antidepressant medication', 'Prescription', 3),
    ('Xanax', 'Anti-anxiety medication', 'Prescription', 3),
    ('Ambien', 'Sleeping pill', 'Prescription', 3),
    ('Viagra', 'Erectile dysfunction medication', 'Prescription', 4),
    ('Cialis', 'Erectile dysfunction medication', 'Prescription', 4),
    ('Adderall', 'Attention deficit hyperactivity disorder medication', 'Prescription', 5),
    ('Ritalin', 'Attention deficit hyperactivity disorder medication', 'Prescription', 5),
    ('Lamictal', 'Anticonvulsant medication', 'Prescription', 3),
    ('Keppra', 'Anticonvulsant medication', 'Prescription', 3),
    ('Humira', 'Immunosuppressive medication', 'Prescription', 2),
    ('Rituxan', 'Immunosuppressive medication', 'Prescription', 2);

    -- Purchase table
    CREATE TABLE Purchase (
    PurchaseID SERIAL PRIMARY KEY,
    DrugID INT,
    SupplierID INT,
    PurchaseDate DATE,
    Quantity INT,
    PurchasePrice DECIMAL(10, 2),
    FOREIGN KEY (DrugID) REFERENCES Drug(DrugID),
    FOREIGN KEY (SupplierID) REFERENCES Supplier(SupplierID)
    );

    --- Insert data into Purchase table
    INSERT INTO Purchase (DrugID, SupplierID, PurchaseDate, Quantity, PurchasePrice) VALUES
    (1, 1, '2023-04-28', 100, 50.00),
    (2, 2, '2023-04-29', 50, 75.00),
    (3, 3, '2023-04-30', 200, 25.00),
    (4, 4, '2023-05-01', 75, 60.00),
    (5, 5, '2023-04-28', 150, 40.00),
    (6, 1, '2023-04-25', 100, 20.00),
    (3, 4, '2023-04-26', 50, 30.00),
    (2, 5, '2023-04-27', 75, 35.00),
    (4, 1, '2023-04-28', 150, 55.00),
    (1, 2, '2023-04-29', 200, 45.00),
    (5, 3, '2023-04-30', 100, 30.00),
    (3, 5, '2023-05-01', 50, 25.00),
    (1, 3, '2023-05-02', 75, 40.00),
    (6, 4, '2023-05-03', 100, 18.00),
    (2, 1, '2023-05-04', 150, 60.00),
    (4, 2, '2023-05-05', 200, 50.00),
    (5, 3, '2023-05-06', 75, 35.00),
    (1, 4, '2023-05-07', 100, 42.00),
    (3, 5, '2023-05-08', 50, 28.00),
    (2, 1, '2023-05-09', 150, 65.00);

    -- Inventory table
     CREATE TABLE Inventory (
    InventoryID SERIAL PRIMARY KEY,
    DrugID INT,
    SupplierID INT,
    PurchaseID INT,
    BatchNumber VARCHAR(255),
    PurchaseDate DATE,
    ExpiryDate DATE,
    Quantity INT,
    PurchasePrice DECIMAL(10, 2), 
    SellingPrice DECIMAL(10, 2),
    FOREIGN KEY (DrugID) REFERENCES Drug(DrugID),
    FOREIGN KEY (PurchaseID) REFERENCES Purchase(PurchaseID),
    FOREIGN KEY (SupplierID) REFERENCES Supplier(SupplierID)
    );

    --- Insert data into Inventory table
    INSERT INTO Inventory (DrugID, SupplierID, PurchaseID, BatchNumber, PurchaseDate, ExpiryDate, Quantity, PurchasePrice, SellingPrice) VALUES
    (1, 1, 1, 'ABC123', '2023-04-28', '2024-04-28', 100, 50.00, 75.00),
    (2, 2, 2, 'XYZ456', '2023-04-29', '2024-04-29', 50, 75.00, 100.00),
    (3, 3, 3, 'PQR789', '2023-04-30', '2024-04-30', 200, 25.00, 40.00),
    (4, 4, 4, 'LMN321', '2023-05-01', '2024-05-01', 75, 60.00, 80.00),
    (5, 5, 5, 'DEF654', '2023-04-28', '2024-04-28', 150, 40.00, 60.00),
    (1, 1, 1, 'ABC123', '2023-04-28', '2024-04-28', 100, 50.00, 75.00),
    (2, 2, 2, 'XYZ456', '2023-04-29', '2024-04-29', 50, 75.00, 100.00),
    (3, 3, 3, 'PQR789', '2023-04-30', '2024-04-30', 200, 25.00, 40.00),
    (4, 4, 4, 'LMN321', '2023-05-01', '2024-05-01', 75, 60.00, 80.00),
    (5, 5, 5, 'DEF654', '2023-04-28', '2024-04-28', 150, 40.00, 60.00),
    (1, 2, 6, 'XYZ321', '2023-05-02', '2024-05-02', 50, 45.00, 70.00),
    (2, 3, 7, 'PQR654', '2023-05-03', '2024-05-03', 100, 80.00, 120.00);

    -- Sales table
    CREATE TABLE Sales (
    SalesID SERIAL PRIMARY KEY,
    DrugID INT,
    PurchaseID INT,
    SalesDate DATE,
    SalesQuantity INT,
    SalesPrice DECIMAL(10, 2),
    FOREIGN KEY (DrugID) REFERENCES Drug(DrugID)
    FOREIGN KEY (PurchaseID) REFERENCES Purchase(PurchaseID)
    );

    --- Insert data into Sales table
    INSERT INTO Sales (DrugID, SalesDate, SalesQuantity, SalesPrice) VALUES
    (1, 1, '2023-05-01', 10, 2.99),
    (2, 2, '2023-05-01', 5, 3.99),
    (3, 3, '2023-05-02', 2, 10.99),
    (4, 4, '2023-05-02', 1, 15.99),
    (5, 5, '2023-05-03', 3, 7.99),
    (1, 6, '2023-05-04', 8, 3.49),
    (2, 7, '2023-05-04', 6, 4.99),
    (3, 8, '2023-05-05', 4, 11.99),
    (4, 9, '2023-05-06', 2, 18.99),
    (5, 10, '2023-05-06', 1, 9.99),
    (1, 11, '2023-05-07', 7, 3.99),
    (2, 12, '2023-05-07', 9, 5.99),
    (3, 13, '2023-05-08', 5, 12.99),
    (4, 14, '2023-05-08', 3, 20.99),
    (5, 15, '2023-05-09', 2, 8.99),
    (1, 16, '2023-05-10', 6, 4.49),
    (2, 17, '2023-05-10', 4, 6.99),
    (3, 18, '2023-05-11', 3, 13.99),
    (4, 19, '2023-05-11', 2, 22.99),
    (5, 20, '2023-05-12', 1, 11.99);

    -- Customer table
    CREATE TABLE Customer (
    CustomerID SERIAL PRIMARY KEY,
    FirstName VARCHAR(255),
    LastName VARCHAR(255),
    Address VARCHAR(255),
    Phone VARCHAR(20),
    Email VARCHAR(255)
    );

    --- Insert data into Customer table
    INSERT INTO Customer (FirstName, LastName, Address, Phone, Email) VALUES
    ('John', 'Doe', '456 Main Street, Anytown USA', '+1 (555) 555-1234', 'johndoe@example.com'),
    ('Jane', 'Doe', '789 Elm Road, Anytown USA', '+1 (555) 555-5678', 'janedoe@example.com'),   
    ('Bob', 'Smith', '123 Oak Avenue, Anytown USA', '+1 (555) 555-9012', 'bobsmith@example.com'),
    ('Sue', 'Jones', '321 Maple Drive, Anytown USA', '+1 (555) 555-3456', 'suejones@example.com'),
    ('Mike', 'Johnson', '654 Pine Street, Anytown USA', '+1 (555) 555-7890', 'mikejohnson@example.com'),
    ('Lisa', 'Lee', '987 Cherry Lane, Anycity USA', '+1 (555) 555-2345', 'lisalee@example.com'),
    ('Tom', 'Thompson', '456 Park Place, Anycity USA', '+1 (555) 555-6789', 'tomthompson@example.com'),
    ('Maria', 'Garcia', '1234 Elm Street, Anycity USA', '+1 (555) 555-0123', 'mariagarcia@example.com'),
    ('David', 'Davis', '789 Maple Avenue, Anycity USA', '+1 (555) 555-4567', 'daviddavis@example.com'),
    ('Emily', 'Edwards', '456 Oak Road, Anycity USA', '+1 (555) 555-8901', 'emilyedwards@example.com'),
    ('Eric', 'Evans', '123 Pine Lane, Anytown USA', '+1 (555) 555-2345', 'ericevans@example.com'),
    ('Olivia', 'Owens', '456 Cherry Drive, Anytown USA', '+1 (555) 555-6789', 'oliviaowens@example.com'),
    ('Frank', 'Franklin', '789 Park Boulevard, Anytown USA', '+1 (555) 555-0123', 'frankfranklin@example.com'),
    ('Linda', 'Lee', '1234 Elm Street, Anytown USA', '+1 (555) 555-4567', 'lindalee@example.com'),
    ('George', 'Gonzalez', '789 Maple Avenue, Anytown USA', '+1 (555) 555-8901', 'georgegonzalez@example.com'),
    ('Hannah', 'Harris', '456 Oak Road, Anytown USA', '+1 (555) 555-2345', 'hannahharris@example.com'),
    ('Peter', 'Peters', '123 Pine Lane, Anycity USA', '+1 (555) 555-6789', 'peterpeters@example.com'),
    ('Sam', 'Samuels', '456 Cherry Drive, Anycity USA', '+1 (555) 555-0123', 'samsamuels@example.com'),
    ('Tina', 'Taylor', '789 Park Boulevard, Anycity USA', '+1 (555) 555-4567', 'tinataylor@example.com'),
    ('William', 'Wilson', '1234 Elm Street, Anycity USA', '+1 (555) 555-8901', 'williamwilson@example.com');


    -- Prescription table
    CREATE TABLE Prescription (
    PrescriptionID SERIAL PRIMARY KEY,
    CustomerID INT,
    DrugID INT,
    PrescriptionDate DATE,
    PrescriptionQuantity INT,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (DrugID) REFERENCES Drug(DrugID)
    );

    --- Insert data into Prescription table
    INSERT INTO Prescription (CustomerID, DrugID, PrescriptionDate, PrescriptionQuantity) VALUES
    (1, 1, '2023-05-01', 30),
    (2, 2, '2023-05-01', 20),
    (3, 3, '2023-04-30', 10),
    (4, 4, '2023-05-01', 15),
    (5, 5, '2023-04-29', 25),
    (6, 6, '2023-05-02', 5),
    (7, 7, '2023-05-02', 10),
    (8, 8, '2023-05-02', 15),
    (9, 9, '2023-05-02', 20),
    (10, 10, '2023-05-01', 5),
    (11, 11, '2023-05-01', 10),
    (12, 12, '2023-05-01', 15),
    (13, 13, '2023-05-01', 20),
    (14, 14, '2023-05-02', 25),
    (15, 15, '2023-05-02', 30),
    (16, 16, '2023-05-02', 5),
    (17, 17, '2023-05-02', 10),
    (18, 18, '2023-05-02', 15),
    (19, 19, '2023-05-02', 20),
    (20, 20, '2023-05-02', 25);

    -- Employee table
    CREATE TABLE Employee (
    EmployeeID SERIAL PRIMARY KEY,
    FirstName VARCHAR(255),
    LastName VARCHAR(255),
    Address VARCHAR(255),
    Phone VARCHAR(20),
    Email VARCHAR(255),
    Role VARCHAR(255)
    );

    --- Insert data into Employee table
    INSERT INTO Employee (FirstName, LastName, Address, Phone, Email, Role) VALUES
    ('John', 'Doe', '123 Main St, New York', '555-1234', 'johndoe@example.com', 'Pharmacist'),
    ('Jane', 'Smith', '456 Elm St, Los Angeles', '555-5678', 'janesmith@example.com', 'Sales Rep'),
    ('Bob', 'Johnson', '789 Maple St, Chicago', '555-9012', 'bobjohnson@example.com', 'Manager'),
    ('Alice', 'Williams', '321 Oak St, Miami', '555-3456', 'alicewilliams@example.com', 'Pharmacy Technician'),
    ('Tom', 'Davis', '654 Pine St, San Francisco', '555-7890', 'tomdavis@example.com', 'Pharmacy Technician'),
    ('Sarah', 'Brown', '987 Maple St, Houston', '555-2345', 'sarahbrown@example.com', 'Sales Rep'),
    ('Mike', 'Wilson', '246 Oak St, Denver', '555-6789', 'mikewilson@example.com', 'Pharmacist'),
    ('Karen', 'Taylor', '369 Pine St, Seattle', '555-0123', 'karentaylor@example.com', 'Pharmacy Technician'),
    ('David', 'Lee', '135 Main St, Boston', '555-4567', 'davidlee@example.com', 'Manager'),
    ('Jessica', 'Nguyen', '753 Elm St, Atlanta', '555-8901', 'jessicanguyen@example.com', 'Pharmacist'),
    ('Eric', 'Miller', '951 Park Ave, Dallas', '555-2345', 'ericmiller@example.com', 'Sales Rep'),
    ('Megan', 'Chen', '864 5th Ave, San Diego', '555-6789', 'meganchen@example.com', 'Pharmacy Technician'),
    ('Kevin', 'Garcia', '753 Maple St, Miami', '555-0123', 'kevingarcia@example.com', 'Pharmacist'),
    ('Anna', 'Wang', '246 Oak St, Chicago', '555-4567', 'annawang@example.com', 'Pharmacy Technician'),
    ('William', 'Johnson', '357 Pine St, New York', '555-8901', 'williamjohnson@example.com', 'Manager'),
    ('Emma', 'Davis', '753 Elm St, Los Angeles', '555-2345', 'emmadavis@example.com', 'Sales Rep'),
    ('Jason', 'Gonzalez', '951 Park Ave, San Francisco', '555-6789', 'jasongonzalez@example.com', 'Pharmacist'),
    ('Grace', 'Li', '753 Maple St, Seattle', '555-0123', 'graceli@example.com', 'Pharmacy Technician'),
    ('Brian', 'Clark', '357 Pine St, Boston', '555-4567', 'brianclark@example.com', 'Manager'),
    ('Olivia', 'Hernandez', '864 5th Ave, Atlanta', '555-8901', 'oliviahernandez@example.com', 'Sales Rep');
    



