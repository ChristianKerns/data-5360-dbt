{{ config(materialized = 'table', schema = 'ecoessentials_dw') }}

WITH marketing_base AS (
    SELECT
        e.emaileventid AS email_event_key,
        e.emailid,
        e.campaignid,
        e.subscriberid AS customer_id,
        e.eventtype,
        e.eventtimestamp,
        CASE 
            WHEN LOWER(e.eventtype) LIKE '%open%' THEN 1 ELSE 0 
        END AS email_open_flag,
        CASE 
            WHEN LOWER(e.eventtype) LIKE '%sent%' THEN 1 ELSE 0 
        END AS email_sent_flag
    FROM {{ source('ecoessentials_marketing', 'marketing_emails') }} e
),

customer_conversion AS (
    SELECT
        c.customer_key,
        CASE 
            WHEN COUNT(o.order_id) > 0 THEN 1
            ELSE 0
        END AS conversion_flag
    FROM {{ ref('dim_customer') }} c
    LEFT JOIN {{ source('ecoessentials_transactional', 'orders') }} o
        ON o.customer_id = c.customer_key
    GROUP BY c.customer_key
)

SELECT
    f.email_event_key,
    f.emailid,
    f.campaignid,
    f.customer_id,
    d.date_key,
    d.date_day,
    d.month_of_year,
    d.year_number,
    f.email_open_flag,
    f.email_sent_flag,
    cc.conversion_flag
FROM marketing_base f
LEFT JOIN {{ ref('dim_customer') }} c
    ON f.customer_id = c.customer_key
LEFT JOIN {{ ref('dim_date') }} d
    ON DATE(f.eventtimestamp) = d.date_day
LEFT JOIN customer_conversion cc
    ON f.customer_id = cc.customer_key
