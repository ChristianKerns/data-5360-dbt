{{ config(
    materialized = 'table',
    schema = 'ecoessentials_dw'
) }}

SELECT
    ORDER_ID AS order_key,
    ORDER_ID,
    CUSTOMER_ID,
    ORDER_TIMESTAMP
FROM {{ source('ecoessentials_transactional', 'orders') }}


