{# 
   Strategy options:
   - append: insert-only, no unique_key needed, not idempotent
   - merge : upsert on unique_key = 'order_id', idempotent
   - insert_overwrite: overwrite partitions in target table, idempotent
#}

{{ config(
    materialized='incremental',
    incremental_strategy='insert_overwrite',
    partition_by="load_dts",
    schema='bronze'
) }}

SELECT
    order_id,
    customer_id,
    order_amount,
    load_dts,
    current_timestamp() AS ingested_ts
FROM {{ source('source', 'fact_orders') }}

{% if is_incremental() %}
{# WHERE load_dts > (SELECT COALESCE(MAX(load_dts), '1900-01-01'::timestamp) FROM {{ this }}) #}
WHERE load_dts >= '2026-10-12'
{% endif %}