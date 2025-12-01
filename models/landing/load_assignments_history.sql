{{ config(
    materialized='table',
    pre_hook = gcs_csv_to_bq(
        table_name='gcp-hackathon-478810.roster.assignments_history',
        skip_leading_rows=1,
        uris=['gs://supermarket_roster/raw/assignments_history.csv']
    )
) }}
