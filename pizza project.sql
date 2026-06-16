select * from `finalproject1.pizzas`
select * from `finalproject1.orders`
select * from `finalproject1.pizza_types`
select * from `finalproject1.order_details`


#ubah nama kolom pd tabel pizza_types
ALTER TABLE `finalproject1.pizza_types`
RENAME COLUMN string_field_0 TO pizza_type_id;
ALTER TABLE `finalproject1.pizza_types`
RENAME COLUMN string_field_1 TO name;
ALTER TABLE `finalproject1.pizza_types`
RENAME COLUMN string_field_2 TO category;
ALTER TABLE `finalproject1.pizza_types`
RENAME COLUMN string_field_3 TO ingredients;

#hapus baris pertama pada pizza types
DELETE FROM `finalproject1.pizza_types`
WHERE TRUE
AND pizza_type_id IN (
  SELECT pizza_type_id FROM (
    SELECT pizza_type_id,
           ROW_NUMBER() OVER (ORDER BY pizza_type_id) AS rn
    FROM `finalproject1.pizza_types`
  )
  WHERE rn = 1
);

CREATE OR REPLACE TABLE `finalproject1.pizza_types` AS
SELECT *
FROM `finalproject1.pizza_types`
WHERE pizza_type_id != 'pizza_type_id';
# join semua #
select *
from `finalproject1.orders` as o
join `finalproject1.order_details` as od on o.order_id= od.order_id
join `finalproject1.pizzas`as p on od.pizza_id=p.pizza_id
join `finalproject1.pizza_types`as pt on p.pizza_type_id= pt.pizza_type_id


SELECT 
  o.order_id,
  o.date,
  o.time,
  o.hour_rounded,
  od.order_details_id,
  od.pizza_id,
  od.quantity,
  p.pizza_type_id,
  p.size,
  p.price,
  pt.name,
  pt.category,
  pt.ingredients
FROM `finalproject1.orders` o
JOIN `finalproject1.order_details` od 
  ON o.order_id = od.order_id
JOIN `finalproject1.pizzas` p 
  ON od.pizza_id = p.pizza_id
JOIN `finalproject1.pizza_types` pt 
  ON p.pizza_type_id = pt.pizza_type_id
----
CREATE OR REPLACE TABLE `finalproject1.orders` AS
SELECT 
  *,
  ROUND(EXTRACT(HOUR FROM time) + EXTRACT(MINUTE FROM time)/60) AS hour_rounded
FROM `finalproject1.orders`;
---
SELECT 
  EXTRACT(HOUR FROM time) AS hour_of_day,
  COUNT(DISTINCT order_id) AS no_of_orders
FROM `finalproject1.orders`
GROUP BY hour_of_day
ORDER BY no_of_orders DESC;