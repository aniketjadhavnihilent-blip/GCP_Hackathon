
  
    

    create or replace table `gcp-hackathon-478810`.`roster`.`stg_availability`
      
    
    

    
    OPTIONS()
    as (
      select * from `gcp-hackathon-478810.roster.availability`
    );
  