## **Triggers:**

### **1. While Making a Sale**

Whenever someone tries a purchase it'll first check the inventory and see if that drug is available. If it is available then only it'll insert that data into Sales table. and After inserting into the sales table it'll also update the inventory by substracting that quantity.

- Case a) There is sufficient quantity available.
    - [Inventory Table Before](./images/trigger11-inventory.png)
    - [Inventory Table After](./images/trigger12-inventory.png)
    - [Sales Table after](./images/trigger13-sales.png)

- Case b) There isn't sufficient quantity available.
    - [Error Message](./images/trigger14-error.png)

```sql

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

INSERT INTO sales (drugid,purchaseid,salesdate,salesquantity,salesprice,customerid) VALUES(3,3,'2023-06-07',20,49.99,2)

```

### **2. While Making a Purchase**
Whenever we make a purchase we add that thing into the inventory. with the relevant values.

- [Purchase Table Before](./images/Trigger22-purchase.png)
- [Purchase Table After](./images/Trigger23-purchase.png)
- [Inventory Table Before](./images/Trigger21-inventory.png)
- [Inventory Table After](./images/Trigger24-inventory.png)

```sql
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
```

### **3. Low stock Trigger**
a trigger that alerts the administrator if the inventory level of any drug falls below a certain threshold. 

- [Info Message](./images/Trigger3.png)

```sql
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
```

### 4. **Delete from sales Trigger.**
Whenever someone returns a medicine a sale is deleted and the quantity will be updated in the inventory table.
    - [Sales Before](./images/trigger41-sales.png)
    - [Inventory Before](./images/trigger42-sales.png)
    - [Sales After](./images/trigger43-inventory.png)
    - [Inventory After](./images/trigger44-inventory.png)
```sql
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
```
<hr>

## **Views:**

### **1. View to see all the available drugs.**

```sql
CREATE VIEW unique_drugs AS
SELECT DISTINCT ON (drug.drugid, drug.drugname)
       drug.drugid,
       drug.drugname
FROM inventory
INNER JOIN drug ON inventory.drugid = drug.drugid
WHERE inventory.quantity > 0;
```

### **2. View to see most sold drugs.**

```sql
CREATE VIEW most_sold_drugs AS
SELECT s.drugid, i.drugname, SUM(s.salesquantity) as total_sales
FROM sales s
INNER JOIN drug i ON s.drugid = i.drugid
GROUP BY s.drugid, i.drugname
ORDER BY total_sales DESC;
```

### **3. View to see the most frequent customers.**

```sql
CREATE VIEW most_regular_customer AS
SELECT customer.customerid, customer.firstname||' '||customer.lastname, COUNT(sales.salesid) AS num_purchases
FROM customer
JOIN sales ON customer.customerid = sales.customerid
GROUP BY customer.customerid, customer.firstname||' '||customer.lastname
ORDER BY num_purchases DESC;
```

<hr>

### **Roles:**

**1. Salesperson: This role has the ability to select, insert, and update data in the sales and prescription tables.**

```sql
CREATE ROLE salesperson LOGIN PASSWORD 'salesperson';
GRANT SELECT, INSERT, DELETE, UPDATE ON inventory TO salesperson;
GRANT SELECT, INSERT, DELETE, UPDATE ON customer TO salesperson;
GRANT SELECT, INSERT, DELETE, UPDATE ON sales TO salesperson;
GRANT SELECT, INSERT, DELETE, UPDATE ON prescription TO salesperson;
```

**2. Inventory Manager: This role has the ability to select, insert, and update data in the inventory and purchase tables.**

```sql
CREATE ROLE inventory_manager LOGIN PASSWORD 'inventory_manager';
GRANT SELECT, INSERT, DELETE, UPDATE ON inventory TO inventory_manager;
GRANT SELECT, INSERT, DELETE, UPDATE ON company TO inventory_manager;
GRANT SELECT, INSERT, DELETE, UPDATE ON drug TO inventory_manager;
GRANT SELECT, INSERT, DELETE, UPDATE ON purchase TO inventory_manager;
GRANT SELECT, INSERT, DELETE, UPDATE ON supplier TO inventory_manager;
```
**3. Administrator: This role has the ability to manage all aspects of the database, including creating tables, creating views, and granting privileges to other roles.**

```sql
CREATE ROLE administrator LOGIN PASSWORD 'administrator';
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO administrator;
```

**4. Manager: Can edit all the tables.**

```sql
CREATE ROLE manager LOGIN PASSWORD 'manager';
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO manager;
```

<hr>

### **Functions**

**1. To get count of drugs by company ID:**
```sql
CREATE FUNCTION count_drugs_by_company(company_id INT)
RETURNS INT AS $$
BEGIN
RETURN COUNT(*)
FROM Drug WHERE CompanyID = company_id;
END; $$ LANGUAGE plpgsql
```

**2. To increase selling price by percentage:**
```sql
CREATE FUNCTION increase_selling_price(percentage INT)
RETURNS VOID AS $$
BEGIN
UPDATE Inventory SET SellingPrice = SellingPrice * (1 + (percentage/100.0));
END; $$ LANGUAGE plpgsql;
```


**3. To remove expired drugs:**
```sql
CREATE FUNCTION remove_expired_drugs()
RETURNS VOID AS $$
BEGIN
DELETE FROM Inventory WHERE ExpiryDate < NOW();
END; $$ LANGUAGE plpgsql;
```

**4. A function to get top n drugs by sales revenue:**
```sql
CREATE FUNCTION top_n_drugs(top_count INT)
RETURNS TABLE (drug_id INT, drug_name VARCHAR, sales_revenue DECIMAL) AS $$
SELECT drug.DrugID, DrugName, SUM(SalesPrice * SalesQuantity) AS sales_revenue
FROM Sales JOIN Drug ON Sales.DrugID = Drug.DrugID
GROUP BY drug.DrugID, DrugName
ORDER BY sales_revenue DESC
LIMIT top_count;
$$ LANGUAGE sql;
```

**5. A function to get top n suppliers by total purchase cost:**

```sql
CREATE FUNCTION top_n_suppliers(top_count INT)
RETURNS TABLE (supplier_id INT, supplier_name VARCHAR, total_cost DECIMAL) AS $$
SELECT supplier.SupplierID, SupplierName, SUM(PurchasePrice * Quantity) AS total_cost
FROM Purchase JOIN Supplier ON Purchase.SupplierID = Supplier.SupplierID
GROUP BY supplier.SupplierID, SupplierName
ORDER BY total_cost DESC
LIMIT top_count;
$$ LANGUAGE sql;
```
