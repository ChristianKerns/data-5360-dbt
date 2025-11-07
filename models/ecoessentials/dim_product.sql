{{ config(materialized = 'table', schema = 'ecoessentials_dw') }}

SELECT
    PRODUCT_ID AS product_key,
    PRODUCT_ID,
    PRODUCT_NAME,
    PRODUCT_TYPE,
    PRICE
FROM {{ source('ecoessentials_transactional', 'product') }}

