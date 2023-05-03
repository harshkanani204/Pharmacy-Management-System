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

### 2. While Making a Purchase
Whenever we make a purchase we add that thing into the inventory. with the relevant values.

- [Purchase Table Before](./images/Trigger22-purchase.png)
- [Purchase Table After](./images/Trigger23-purchase.png)
- [Inventory Table Before](./images/Trigger21-inventory.png)
- [Inventory Table After](./images/Trigger24-inventory.png)



