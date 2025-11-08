{{ config(materialized='table', schema='ecoessentials_dw') }}

SELECT
    p.product_key,
    c.customer_key,
    cm.campaign_key,
    d.date_key,
    o.order_key,
    ol.quantity,
    (ol.quantity * ol.price_after_discount) AS total_sales
FROM {{ source('ecoessentials_transactional', 'order_line') }} ol
INNER JOIN {{ ref('dim_order') }} o 
    ON ol.ORDER_ID = o.ORDER_ID
INNER JOIN {{ ref('dim_product') }} p 
    ON ol.PRODUCT_ID = p.PRODUCT_ID
INNER JOIN {{ ref('dim_customers') }} c 
    ON o.CUSTOMER_ID = c.CUSTOMER_ID
LEFT JOIN {{ ref('dim_campaign') }} cm 
    ON ol.CAMPAIGN_ID = cm.CAMPAIGN_ID
INNER JOIN {{ ref('dim_dates') }} d 
    ON d.date_key = CAST(o.ORDER_TIMESTAMP AS DATE)
