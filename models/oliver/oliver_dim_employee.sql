{{ config(
    materialized = 'table',
    schema = 'oliver_dw'
    )
}}

select
EMPLOYEE_ID as employee_key,
EMAIL,
POSITION,
HIRE_DATE,
LAST_NAME,
FIRST_NAME,
EMPLOYEE_ID,
PHONE_NUMBER
FROM {{ source('oliver_landing', 'employee') }}