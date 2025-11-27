
  
    

    create or replace table `gcp-hackathon-478810`.`roster`.`demand_forecast`
      
    
    

    
    OPTIONS()
    as (
      select * from `gcp-hackathon-478810`.`roster`.`stg_demand` where date = '2025-11-24'
    );
  