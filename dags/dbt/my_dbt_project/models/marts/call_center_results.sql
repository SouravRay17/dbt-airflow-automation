WITH call_center_data AS (
    SELECT * FROM {{ ref('stg_call_center_sf10') }}  -- Use staging table
),

-- Test 1: Count rows with NOT NULL values in key columns
not_null_checks AS (
    SELECT 
        COUNT(*) AS not_null_count 
    FROM call_center_data 
    WHERE cc_call_center_id IS NOT NULL
),

-- Test 2: Check for duplicate IDs
duplicate_checks AS (
    SELECT 
        cc_call_center_id, COUNT(*) AS cnt 
    FROM call_center_data 
    GROUP BY cc_call_center_id 
    HAVING COUNT(*) > 1
),

-- Test 3: Total row count
row_count AS (
    SELECT COUNT(*) AS total_rows FROM call_center_data
)

SELECT 
    (SELECT not_null_count FROM not_null_checks) AS not_null_rows,
    (SELECT COUNT(*) FROM duplicate_checks) AS duplicate_count,
    (SELECT total_rows FROM row_count) AS total_rows,
    CURRENT_TIMESTAMP AS test_run_time  -- Capture the time the test is executed
