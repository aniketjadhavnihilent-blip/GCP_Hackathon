with emp as (select * from `gcp-hackathon-478810`.`roster`.`stg_employees`)
select * from emp
-- avail as (
--   select employee_id, date,
--          min(timeslot_start) as first_start,
--          max(timeslot_end) as last_end
--   from `gcp-hackathon-478810`.`roster`.`stg_availability`
--   where availability_status = 'available'
--   group by employee_id, date
-- )

-- select * from avail