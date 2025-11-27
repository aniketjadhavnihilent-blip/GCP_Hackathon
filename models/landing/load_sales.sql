{{ config(
    materialized='table',
    pre_hook = gcs_csv_to_bq(
        this=this,
        table_name='`gcp-hackathon-478810.roster.sales_history`',
        skip_leading_rows=1,
        uris='["gs://supermarket_roster/raw/sales_data_3years.csv"]'
    )
) }}