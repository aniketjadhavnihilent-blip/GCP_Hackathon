-- created_at: 2025-11-27T05:21:49.114124300+00:00
-- finished_at: 2025-11-27T05:22:02.924682300+00:00
-- elapsed: 13.8s
-- outcome: success
-- dialect: bigquery
-- node_id: not available
-- query_id: fHWcusyAXFfWmNC8aWCSKrFfscb
-- desc: execute adapter call
/* {"app":"dbt","dbt_version":"2.0.0","profile_name":"roster","target_name":"Prod","connection_name":""} */

    select distinct schema_name from `gcp-hackathon-478810`.INFORMATION_SCHEMA.SCHEMATA;
  ;
-- created_at: 2025-11-27T05:22:02.977174600+00:00
-- finished_at: 2025-11-27T05:22:06.593618200+00:00
-- elapsed: 3.6s
-- outcome: success
-- dialect: bigquery
-- node_id: model.GCP-Hackathon.aggregated_Sales
-- query_id: oSeOaSw9sTDXCSArUvzPrSDIJOn
-- desc: get_relation > list_relations call
SELECT
    table_catalog,
    table_schema,
    table_name,
    table_type
FROM 
    `gcp-hackathon-478810`.`roster`.INFORMATION_SCHEMA.TABLES;
-- created_at: 2025-11-27T05:22:06.977964800+00:00
-- finished_at: 2025-11-27T05:22:11.665606800+00:00
-- elapsed: 4.7s
-- outcome: success
-- dialect: bigquery
-- node_id: model.GCP-Hackathon.aggregated_Sales
-- query_id: 7cttdOJ4W2XgHagunJ8tkRQQkN5
-- desc: execute adapter call
/* {"app":"dbt","dbt_version":"2.0.0","profile_name":"roster","target_name":"Prod","node_id":"model.GCP-Hackathon.aggregated_Sales"} */

  
    

    create or replace table `gcp-hackathon-478810`.`roster`.`aggregated_Sales`
      
    
    

    
    OPTIONS()
    as (
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
    );
  ;
