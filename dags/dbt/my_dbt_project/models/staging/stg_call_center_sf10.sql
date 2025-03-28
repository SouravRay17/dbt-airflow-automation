{{ config(materialized='view') }}

SELECT * FROM {{ source('tpcds_small', 'call_center') }}
