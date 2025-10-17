{{ config(
    materialized = 'table',
    schema = 'oliver_dw'
) }}

select
    cu.first_name as customer_first_name,
    cu.last_name as customer_last_name,
    p.product_key,
    e.first_name as employee_first_name,
    e.last_name as employee_last_name
from {{ ref('fact_sales') }} f

left join {{ ref('oliver_dim_product') }} p
    on f.product_key = p.product_key

left join {{ ref('oliver_dim_customer') }} cu
    on f.customer_key = cu.customer_key

left join {{ ref('oliver_dim_employee') }} e
    on f.employee_key = e.employee_key

left join {{ ref('oliver_dim_store') }} st
    on f.store_key = st.store_key

left join {{ ref('oliver_dim_date') }} d
    on f.date_key = d.date_key
