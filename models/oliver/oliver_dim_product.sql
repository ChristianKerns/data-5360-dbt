{{ config(
    materialized = 'table',
    schema = 'oliver_dw'
    )
}}

select
PRODUCT_ID as PRODUCT_key,
PRODUCT_ID,
UNIT_PRICE,
DESCRIPTION,
PRODUCT_NAME
FROM {{ source('oliver_landing', 'product') }}