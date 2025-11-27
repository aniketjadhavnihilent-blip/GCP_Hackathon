with raw as (
  select * from `gcp-hackathon-478810.roster.employees`
)
select
  employee_id,
  name,
  role,
  skills,
  fte,
  employment_type,
  timezone,
  date_of_joining,
  is_active
from raw
where is_active = true