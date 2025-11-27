
  
    

    create or replace table `gcp-hackathon-478810`.`roster`.`stg_sales_history`
      
    
    

    
    OPTIONS()
    as (
      select * from `gcp-hackathon-478810.roster.sales_history`
    );
  