## **Triggers:**

### 1. While Making a Sale 

Whenever someone tries a purchase it'll first check the inventory and see if that drug is available. If it is available then only it'll insert that data into Sales table. and After inserting into the sales table it'll also update the inventory by substracting that quantity.

- Case a) There is sufficient quantity available.
    - [Inventory Table Before](./images/trigger11.png)
    - [Inventory Table After](./images/trigger12.png)
    - [Sales Table after](./images/trigger13.png)

- Case b) There isn't sufficient quantity available.
    - [Inventory Table Before](./images/trigger12.png)
    - [Error Message](./images/trigger14.png)
    - [Inventory Table after](./images/trigger15.png)
    - [Sales Table after](./images/trigger13.png)

```sql
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
```


### 2. While Making a Purchase
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

### 3. While adding a prescription.

When we add a prescription. It'll create a sale i.e. insert into sale table. and after that it'll also update inventory table.

- Case a) When there is enough drug available.
    - [Prescription Table Before](./images/Trigger32-prescription.png)
    - [Inventory Table Before](./images/Trigger31-inventory.png)
    - [Sales Table Before](./images/Trigger33-sales.png)

    - [Prescription Table After](./images/Trigger34-prescription.png)
    - [Inventory Table After](./images/Trigger36-inventory.png)
    - [Sales Table After](./images/Trigger35-sales.png)
- Case b) When there isn't sufficient drug available.
    - [Error Message](./images/Trigger37.png)

```sql

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
```