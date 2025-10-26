{{ config(
    materialized = 'table',
    schema = 'oliver_dw'
) }}

select
    employee_id,
    parse_json(certification_json):certification_name::string as certification_name,
    parse_json(certification_json):certification_cost::float as certification_cost,
    parse_json(certification_json):certification_awarded_date::date as certification_awarded_date
from {{ source('oliver_landing', 'employee_certifications') }}
