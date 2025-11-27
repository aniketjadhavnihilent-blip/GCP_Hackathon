{{ config(
    materialized='table',
    pre_hook = gcs_csv_to_bq(
        this=this,
        table_name='`gcp-hackathon-478810.roster.demand`',
        skip_leading_rows=1,
        uris='["gs://supermarket_roster/raw/demand.csv"]'
    )
) }}

-- You can select from the loaded table or transform here
-- SELECT * FROM `gcp-hackathon-478810.roster.employees`;