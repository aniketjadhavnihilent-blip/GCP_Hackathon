
  
    

    create or replace table `gcp-hackathon-478810`.`roster`.`roster_features`
      
    
    

    
    OPTIONS()
    as (
      with emp as (select * from `gcp-hackathon-478810`.`roster`.`stg_employees`),
avail as (
  select employee_id, date,
         min(timeslot_start) as first_start,
         max(timeslot_end) as last_end
  from `gcp-hackathon-478810`.`roster`.`stg_availability`
  where availability_status = 'available'
  group by employee_id, date
),
hist as (
  select employee_id, avg(workload_hours) as avg_work_hours_90d
  from `gcp-hackathon-478810`.`roster`.`stg_assignments_history`
  where date >= date_sub(current_date(), interval 90 day)
  group by employee_id
)

select
  e.employee_id,
  e.role,
  e.skills,
  coalesce(h.avg_work_hours_90d,0) as avg_work_hours_90d,
  COUNTIF(av.date BETWEEN CURRENT_DATE() 
                AND DATE_ADD(CURRENT_DATE(), INTERVAL 7 DAY)) AS available_days_next_7
from emp e
left join avail av on av.employee_id = e.employee_id
left join hist h on h.employee_id = e.employee_id
group by e.employee_id,e.role,e.skills,h.avg_work_hours_90d
    );
  