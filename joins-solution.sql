## Tasks
1. Get all customers and their addresses.
SELECT * FROM "customers"
JOIN "addresses" ON "customers"."id" = "addresses"."customer_id";

2. Get all orders and their line items (orders, quantity and product).
SELECT * FROM "orders"
JOIN "line_items" ON "orders"."id" = "line_items"."order_id"
JOIN "products" ON "products"."id" = "line_items"."product_id";

3. Which warehouses have cheetos?
SELECT * FROM "products"
JOIN "warehouse_product" ON "products"."id" = "warehouse_product"."product_id"
JOIN "warehouse" ON "warehouse"."id" = "warehouse_product"."warehouse_id"
WHERE "products"."description" = 'cheetos';

4. Which warehouses have diet pepsi?
SELECT * FROM "products"
JOIN "warehouse_product" ON "products"."id" = "warehouse_product"."product_id"
JOIN "warehouse" ON "warehouse"."id" = "warehouse_product"."warehouse_id"
WHERE "products"."description" = 'diet pepsi';

5. Get the number of orders for each customer. NOTE: It is OK if those without orders are not included in results.
SELECT "customers"."first_name", count("orders"."order_date") FROM "customers"
JOIN "addresses" ON "customers"."id" = "addresses"."customer_id"
JOIN "orders" ON "orders"."address_id" = "addresses"."id"
GROUP BY "customers"."first_name";

6. How many customers do we have?
SELECT COUNT("customers"."first_name")
FROM "customers";

7. How many products do we carry?
SELECT COUNT("description")
FROM "products";

8. What is the total available on-hand quantity of diet pepsi?
SELECT "products"."description", SUM("warehouse_product"."on_hand")
FROM "products"
JOIN "warehouse_product" ON "products"."id" = "warehouse_product"."product_id"
WHERE "products"."description" = 'diet pepsi'
GROUP BY "products"."description";

## Stretch
9. How much was the total cost for each order?
SELECT "orders"."id", (SUM("line_items"."quantity" * "products"."unit_price")) AS "total"
FROM "orders"
JOIN "line_items" ON "orders"."id" = "line_items"."order_id"
JOIN "products" ON "products"."id" = "line_items"."product_id"
GROUP BY "orders"."id";

10. How much has each customer spent in total?
SELECT "customers"."first_name", (SUM("line_items"."quantity" * "products"."unit_price")) AS "total"
FROM "customers"
JOIN "addresses" ON "customers"."id" = "addresses"."customer_id"
JOIN "orders" ON "orders"."address_id" = "addresses"."id"
JOIN "line_items" ON "orders"."id" = "line_items"."order_id"
JOIN "products" ON "products"."id" = "line_items"."product_id"
GROUP BY "customers"."first_name";

11. How much has each customer spent in total? Customers who have spent $0 should still show up in the table. It should say 0, not NULL (research coalesce).
SELECT "customers"."first_name", 
COALESCE((SUM("line_items"."quantity" * "products"."unit_price")), 0) AS "total"
FROM "customers"
LEFT JOIN "addresses" ON "customers"."id" = "addresses"."customer_id"
LEFT JOIN "orders" ON "orders"."address_id" = "addresses"."id"
LEFT JOIN "line_items" ON "orders"."id" = "line_items"."order_id"
LEFT JOIN "products" ON "products"."id" = "line_items"."product_id"
GROUP BY "customers"."first_name";
