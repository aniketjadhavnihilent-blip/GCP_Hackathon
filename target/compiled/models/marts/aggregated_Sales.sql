-- Aggregate daily sales per store, shift, and role
WITH aggregated_sales AS (
  SELECT
    date,
    store_id,
    shift,
    role,
    SUM(sales_amount) AS total_sales,
    SUM(total_orders) AS total_orders,
    CASE
      WHEN EXTRACT(DAYOFWEEK FROM date) IN (1,7) 
           OR DATE(date) IN ('2023-12-25','2024-12-25','2025-12-25')
      THEN 1 ELSE 0 
    END AS seasonal_surge_flag
  FROM `gcp-hackathon-478810`.`roster`.`stg_sales_history`
  GROUP BY date, store_id, shift, role
)

-- Calculate staff needed based on role capacity
SELECT
  date AS timestamp,
  store_id,
  shift,
  role,
  total_sales,
  total_orders,
  seasonal_surge_flag,
  CASE role
    WHEN 'cashier' THEN CEIL(total_sales / 200)
    WHEN 'floor' THEN CEIL(total_sales / 150)
    WHEN 'manager' THEN CEIL(total_sales / 400)
    ELSE 1
  END AS staff_needed
FROM aggregated_sales
ORDER BY date, store_id, shift, role