{{ config(
    materialized = 'table',
    schema = 'oliver_dw'
    )
}}


select
customer_id as customer_key,
customer_id,
FIRST_NAME,
LAST_NAME,
EMAIL,
PHONE_NUMBER,
STATE
FROM {{ source('oliver_landing', 'customer') }}