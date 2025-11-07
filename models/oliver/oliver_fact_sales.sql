{{ config(
    materialized = 'table',
    schema = 'oliver_dw'
) }}

select
    p.product_key,
    c.customer_key,
    e.employee_key,
    st.store_key,
    d.date_key,
    ol.quantity,
    (ol.quantity * ol.unit_price) as dollars_sold,
    ol.unit_price
from {{ source("oliver_landing", "orderline") }} ol
inner join {{ source("oliver_landing", "orders") }} o 
    on ol.order_id = o.order_id
inner join {{ ref("oliver_dim_product") }} p 
    on ol.product_id = p.product_id
inner join {{ ref("oliver_dim_customer") }} c 
    on o.customer_id = c.customer_id
inner join {{ ref("oliver_dim_employee") }} e 
    on o.employee_id = e.employee_id
inner join {{ ref("oliver_dim_store") }} st 
    on o.store_id = st.store_id
inner join {{ ref("oliver_dim_date") }} d 
    on d.date_day = cast(o.order_date as date)
