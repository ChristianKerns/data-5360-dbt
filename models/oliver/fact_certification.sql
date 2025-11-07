{{ config(
    materialized = 'table',
    schema = 'oliver_dw'
) }}

SELECT
    d.date_key,
    e.employee_key,
    c.certification_name,
    c.certification_cost
FROM {{ ref('stg_oliver_customer_service_interactions') }} c
INNER JOIN {{ ref('oliver_dim_employee') }} e 
    ON c.employee_id = e.employee_id
INNER JOIN {{ ref('oliver_dim_date') }} d
    ON c.certification_awarded_date = d.date_day
