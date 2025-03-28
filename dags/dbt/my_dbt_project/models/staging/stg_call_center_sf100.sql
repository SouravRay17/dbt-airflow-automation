{{ config(materialized='view') }}

SELECT * FROM {{ source('tpcds', 'call_center') }}
