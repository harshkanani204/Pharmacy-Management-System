CREATE OR REPLACE FUNCTION check_inventory() RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS (
        SELECT 1 FROM Inventory WHERE DrugID = NEW.DrugID AND Quantity >= NEW.SalesQuantity
    ) THEN
        -- Deduct the sales quantity from the inventory
        WITH sub AS (
            SELECT InventoryID, Quantity,
                ROW_NUMBER() OVER (ORDER BY ExpiryDate, PurchaseDate) AS row_num
            FROM Inventory
            WHERE DrugID = NEW.DrugID AND Quantity > 0
        )
        UPDATE Inventory i
        SET Quantity = sub.Quantity - NEW.SalesQuantity
        FROM sub
        WHERE i.InventoryID = sub.InventoryID AND sub.row_num <= sub.Quantity - NEW.SalesQuantity
        RETURNING i.*;

        RETURN NEW;
    ELSE
        RAISE EXCEPTION 'Not enough quantity in the inventory for Drug ID: %', NEW.DrugID;
    END IF;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER check_inventory_trigger
BEFORE INSERT ON Sales
FOR EACH ROW
EXECUTE FUNCTION check_inventory();

INSERT INTO Inventory (DrugID, SupplierID, PurchaseID, BatchNumber, PurchaseDate, ExpiryDate, Quantity, PurchasePrice, SellingPrice)
VALUES (1, 1, 1, 'B001', '2022-01-01', '2024-01-01', 10, 10.00, 15.00);

INSERT INTO Sales (DrugID, PurchaseID, SalesDate, SalesQuantity, SalesPrice)
VALUES (1, 22, '2023-05-04', 40, 15.00);



CREATE OR REPLACE FUNCTION check_inventory() RETURNS TRIGGER AS $$
DECLARE
    inventory_qty INTEGER;
BEGIN
    SELECT SUM(Quantity) INTO inventory_qty FROM Inventory 
    WHERE DrugID = NEW.DrugID AND ExpiryDate >= CURRENT_DATE;
    
    IF inventory_qty >= NEW.SalesQuantity THEN
        UPDATE Inventory SET Quantity = Quantity - NEW.SalesQuantity 
        WHERE InventoryID IN (
            SELECT InventoryID FROM Inventory 
            WHERE DrugID = NEW.DrugID AND ExpiryDate >= CURRENT_DATE 
            ORDER BY ExpiryDate ASC 
            LIMIT NEW.SalesQuantity
        );
        RETURN NEW;
    ELSE
        RAISE EXCEPTION 'Insufficient inventory for this sale.';
    END IF;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER sales_trigger BEFORE INSERT ON Sales FOR EACH ROW EXECUTE FUNCTION check_inventory();


ALTER TABLE Purchase ADD COLUMN ExpiryDate DATE;

UPDATE Purchase SET ExpiryDate = PurchaseDate + INTERVAL '1 YEAR';

CREATE OR REPLACE FUNCTION add_to_inventory() RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO Inventory (DrugID, SupplierID, PurchaseID, BatchNumber, PurchaseDate, ExpiryDate, Quantity, PurchasePrice, SellingPrice)
    VALUES (NEW.DrugID, NEW.SupplierID, NEW.PurchaseID, NEW.PurchaseID, NEW.PurchaseDate, NEW.ExpiryDate, NEW.Quantity, NEW.PurchasePrice, NEW.PurchasePrice * 1.2);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER purchase_trigger
AFTER INSERT ON Purchase
FOR EACH ROW
EXECUTE FUNCTION add_to_inventory();

SELECT * FROM PUrchase

INSERT INTO Purchase (DrugID, SupplierID, PurchaseDate, Quantity, PurchasePrice,expirydate)
VALUES (4, 2, '2023-05-02', 150, 10.00,'2024-05-02');

CREATE OR REPLACE FUNCTION add_sales_from_prescription()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO Sales (DrugID, PurchaseID, SalesDate, SalesQuantity, SalesPrice)
  SELECT NEW.DrugID, p.PurchaseID, CURRENT_DATE, NEW.PrescriptionQuantity, i.SellingPrice
  FROM Purchase p
  JOIN Inventory i ON i.PurchaseID = p.PurchaseID
  WHERE p.DrugID = NEW.DrugID
    AND p.PurchaseDate = (
      SELECT MIN(PurchaseDate)
      FROM Purchase
      WHERE DrugID = p.DrugID
    )
  ORDER BY i.ExpiryDate ASC, i.PurchaseDate ASC
  LIMIT NEW.PrescriptionQuantity;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER add_sales_from_prescription_trigger
AFTER INSERT ON Prescription
FOR EACH ROW
EXECUTE FUNCTION add_sales_from_prescription();

INSERT INTO prescription (customerid, drugid, prescriptionquantity, prescriptiondate)
VALUES (1, 1, 1, '2023-05-03');

DELETE from prescription WHERE prescriptionid>=23 and prescriptionid<=26

INSERT INTO sales (drugid, purchaseid,salesdate,salesquantity, salesprice) VALUES (2,2,'2023-05-04',1,24.99);
INSERT INTO purchase (drugid, supplierid,purchasedate, , expiry_date)
VALUES ('Aspirin', 100, 1.5, '2022-01-01', '2023-01-01');

CREATE VIEW unique_drugs AS
SELECT DISTINCT ON (drug.drugid, drug.drugname)
       drug.drugid,
       drug.drugname
FROM inventory
INNER JOIN drug ON inventory.drugid = drug.drugid
WHERE inventory.quantity > 0;

SELECT * FROM unique_drugs;

CREATE VIEW most_sold_drugs AS
SELECT s.drugid, i.drugname, SUM(s.salesquantity) as total_sales
FROM sales s
INNER JOIN drug i ON s.drugid = i.drugid
GROUP BY s.drugid, i.drugname
ORDER BY total_sales DESC;

SELECT * FROM most_sold_drugs;


CREATE VIEW most_regular_customer AS
SELECT customer.customerid, customer.firstname||' '||customer.lastname, COUNT(sales.salesid) AS num_purchases
FROM customer
JOIN sales ON customer.customerid = sales.customerid
GROUP BY customer.customerid, customer.firstname||' '||customer.lastname
ORDER BY num_purchases DESC;

SELECT * FROM most_regular_customer;

ALTER TABLE sales
ADD COLUMN customerid INTEGER REFERENCES customer(customerid);

UPDATE sales
SET customerid = (SELECT ROUND(RANDOM() * 19 + 1)::INT FROM generate_series(1,1))
WHERE customerid IS NULL;

INSERT INTO sales (drugid,purchaseid,salesdate,salesquantity,salesprice,customerid) VALUES(2,2,'2023-06-07',35,79.99,6)

CREATE OR REPLACE FUNCTION check_inventory() RETURNS TRIGGER AS $$
DECLARE
    drug_quantity INTEGER;
BEGIN
    SELECT quantity INTO drug_quantity
    FROM inventory
    WHERE inventory.drugid = NEW.drugid AND inventory.purchaseid = NEW.purchaseid;
    
    IF drug_quantity >= NEW.salesquantity THEN
        UPDATE inventory
        SET quantity = quantity - NEW.salesquantity
        WHERE inventory.drugid = NEW.drugid AND inventory.purchaseid = NEW.purchaseid;
        RETURN NEW;
    ELSE
        RAISE EXCEPTION 'Insufficient inventory for this sale.';
    END IF;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER check_inventory_trigger
BEFORE INSERT ON sales
FOR EACH ROW
EXECUTE FUNCTION check_inventory();

CREATE OR REPLACE FUNCTION check_inventoryps() RETURNS TRIGGER AS $$
BEGIN
    DECLARE
        purchase_id INTEGER;
        drug_id INTEGER;
		price INTEGER;
        available_quantity INTEGER;
        prescription_quantity INTEGER;
    BEGIN
        -- Find the purchase_id and drug_id for the given prescription
        SELECT p.purchaseid, p.drugid INTO purchase_id, drug_id
        FROM inventory p
        WHERE p.drugid = NEW.drugid AND p.quantity >= NEW.prescriptionquantity
        ORDER BY p.expirydate ASC, p.purchasedate ASC
        LIMIT 1;
        
        IF purchase_id IS NULL THEN
            RAISE EXCEPTION 'Insufficient inventory for this prescription.';
        ELSE
            -- Reduce the quantity in inventory
            UPDATE inventory
            SET quantity = quantity - NEW.prescriptionquantity
            WHERE purchaseid = purchase_id;
			
			SELECT inventory.sellingprice INTO price FROM inventory WHERE purchaseid = purchase_id;
            
            -- Insert the data into sales table
            INSERT INTO sales (purchaseid, drugid, customerid, salesquantity, salesprice)
            VALUES (purchase_id, drug_id, NEW.customerid, NEW.prescriptionquantity, price);
        END IF;
        
        RETURN NEW;
    END;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER insert_sales_trigger
AFTER INSERT ON prescription
FOR EACH ROW
EXECUTE FUNCTION check_inventoryps();

CREATE OR REPLACE FUNCTION add_sales_from_prescription()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO Sales (DrugID, PurchaseID, SalesDate, SalesQuantity, SalesPrice)
  SELECT NEW.DrugID, p.PurchaseID, CURRENT_DATE, NEW.PrescriptionQuantity, i.SellingPrice
  FROM Purchase p
  JOIN Inventory i ON i.PurchaseID = p.PurchaseID
  WHERE p.DrugID = NEW.DrugID
    AND p.PurchaseDate = (
      SELECT MIN(PurchaseDate)
      FROM Purchase
      WHERE DrugID = p.DrugID
    )
  ORDER BY i.ExpiryDate ASC, i.PurchaseDate ASC
  LIMIT NEW.PrescriptionQuantity;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER add_sales_from_prescription_trigger
AFTER INSERT ON Prescription
FOR EACH ROW
EXECUTE FUNCTION add_sales_from_prescription();


INSERT INTO prescription (customerid, drugid, prescriptiondate, prescriptionquantity)
VALUES (8, 2, '2023-05-03', 13);

DELETE FROM sales WHERE salesid=44 or salesid=45;

CREATE ROLE administrator;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO administrator;

CREATE ROLE inventory_manager;
GRANT SELECT, INSERT, UPDATE ON inventory TO inventory_manager;
GRANT SELECT, INSERT, UPDATE ON purchase TO inventory_manager;


CREATE ROLE salesperson;
GRANT SELECT, INSERT, UPDATE ON sales TO salesperson;
GRANT SELECT, INSERT, UPDATE ON prescription TO salesperson;

CREATE OR REPLACE FUNCTION less_drugs() RETURNS trigger AS $$
DECLARE
    drug_id integer;
    drug_name text;
    current_quantity integer;
    min_quantity integer;
BEGIN
    SELECT NEW.drugid, drug.drugname, inventory.quantity, 50 INTO drug_id, drug_name, current_quantity, min_quantity FROM inventory JOIN drug ON inventory.drugid = drug.drugid WHERE inventory.drugid = NEW.drugid;

    IF current_quantity - NEW.salesquantity < min_quantity THEN
		RAISE INFO 'Inventory level for % (%), has fallen below the minimum threshold of %.', drug_name, drug_id, min_quantity;
	
	END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER inventory_threshold_trigger
AFTER INSERT ON sales
FOR EACH ROW
EXECUTE FUNCTION less_drugs();

INSERT INTO sales (drugid,purchaseid,salesdate,salesquantity,salesprice,customerid) VALUES(1,23,'2023-06-07',50,79.99,6)

RAISE NOTICE 'HEllo';

-- Create roles with login privilege and add passwords
CREATE ROLE administrator LOGIN PASSWORD 'administrator';
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO administrator;

CREATE ROLE inventory_manager LOGIN PASSWORD 'inventory_manager';
GRANT SELECT, INSERT, DELETE, UPDATE ON inventory TO inventory_manager;
GRANT SELECT, INSERT, DELETE, UPDATE ON company TO inventory_manager;
GRANT SELECT, INSERT, DELETE, UPDATE ON drug TO inventory_manager;
GRANT SELECT, INSERT, DELETE, UPDATE ON purchase TO inventory_manager;
GRANT SELECT, INSERT, DELETE, UPDATE ON supplier TO inventory_manager;

CREATE ROLE salesperson LOGIN PASSWORD 'salesperson';
GRANT SELECT, INSERT, DELETE, UPDATE ON inventory TO salesperson;
GRANT SELECT, INSERT, DELETE, UPDATE ON customer TO salesperson;
GRANT SELECT, INSERT, DELETE, UPDATE ON sales TO salesperson;
GRANT SELECT, INSERT, DELETE, UPDATE ON prescription TO salesperson;

-- Create a role with login privilege that can edit all tables
CREATE ROLE manager LOGIN PASSWORD 'manager';
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO manager;


REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA public FROM role_name;
DROP ROLE role_name;

CREATE OR REPLACE FUNCTION increase_inventory()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE inventory
    SET quantity = quantity + OLD.salesquantity
    WHERE drugid = OLD.drugid AND purchaseid = OLD.purchaseid;
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER increase_inventory_trigger
AFTER DELETE ON sales
FOR EACH ROW
EXECUTE FUNCTION increase_inventory();

DELETE FROM sales where salesid=53;

CREATE FUNCTION count_drugs_by_company(company_id INT)
RETURNS INT AS $$
BEGIN
RETURN COUNT(*)
FROM Drug WHERE CompanyID = company_id;
END; $$ LANGUAGE plpgsql

CREATE FUNCTION increase_selling_price(percentage INT)
RETURNS VOID AS $$
BEGIN
UPDATE Inventory SET SellingPrice = SellingPrice * (1 + (percentage/100.0));
END; $$ LANGUAGE plpgsql;

CREATE FUNCTION remove_expired_drugs()
RETURNS VOID AS $$
BEGIN
DELETE FROM Inventory WHERE ExpiryDate < NOW();
END; $$ LANGUAGE plpgsql;

CREATE FUNCTION top_n_drugs(top_count INT)
RETURNS TABLE (drug_id INT, drug_name VARCHAR, sales_revenue DECIMAL) AS $$
SELECT drug.DrugID, DrugName, SUM(SalesPrice * SalesQuantity) AS sales_revenue
FROM Sales JOIN Drug ON Sales.DrugID = Drug.DrugID
GROUP BY drug.DrugID, DrugName
ORDER BY sales_revenue DESC
LIMIT top_count;
$$ LANGUAGE sql;

CREATE FUNCTION top_n_suppliers(top_count INT)
RETURNS TABLE (supplier_id INT, supplier_name VARCHAR, total_cost DECIMAL) AS $$
SELECT supplier.SupplierID, SupplierName, SUM(PurchasePrice * Quantity) AS total_cost
FROM Purchase JOIN Supplier ON Purchase.SupplierID = Supplier.SupplierID
GROUP BY supplier.SupplierID, SupplierName
ORDER BY total_cost DESC
LIMIT top_count;
$$ LANGUAGE sql;
