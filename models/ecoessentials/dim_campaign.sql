{{ config(materialized = 'table', schema = 'ecoessentials_dw') }}

SELECT
    CAMPAIGN_ID AS campaign_key,
    CAMPAIGN_ID,
    CAMPAIGN_NAME,
    CAMPAIGN_DISCOUNT
FROM {{ source('ecoessentials_transactional', 'promotional_campaign') }}