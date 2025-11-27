-- macros/gcs_csv_to_bq.sql
{% macro gcs_csv_to_bq(this, table_name, skip_leading_rows, uris) %}
{{ log("Running Load Data from GCS CSV " ~ uris ~ " to table " ~ table_name, info=true) }}

LOAD DATA OVERWRITE {{ table_name }}
FROM FILES (
    skip_leading_rows = {{ skip_leading_rows }},
    format = 'CSV',
    field_delimiter = ',',
    uris = {{ uris }}
);

{% endmacro %}
