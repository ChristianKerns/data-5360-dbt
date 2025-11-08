{{ config(materialized = 'table', schema = 'ecoessentials_dw') }}

SELECT
    CUSTOMER_ID AS customer_key,
    CUSTOMER_ID,
    CUSTOMER_FIRST_NAME AS first_name,
    CUSTOMER_LAST_NAME AS last_name,
    CUSTOMER_ADDRESS AS address,
    CUSTOMER_CITY AS city,
    CUSTOMER_STATE AS state,
    CUSTOMER_ZIP AS zip,
    CUSTOMER_COUNTRY AS country,
    CUSTOMER_PHONE AS phone
FROM {{ source('ecoessentials_transactional', 'customer') }}
