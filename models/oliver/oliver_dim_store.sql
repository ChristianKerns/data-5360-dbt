{{ config(
    materialized = 'table',
    schema = 'oliver_dw'
    )
}}

select
STORE_ID as STORE_key,
CITY,
STATE,
STREET,
STORE_ID,
STORE_NAME
FROM {{ source('oliver_landing', 'store') }}