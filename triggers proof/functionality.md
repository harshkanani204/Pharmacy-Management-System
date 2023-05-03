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

