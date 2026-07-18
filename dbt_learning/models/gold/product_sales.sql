SELECT
    product_sk,
    sum(gross_amount) as total_gross_amount
FROM 
    {{ ref('bronze_sales') }}
GROUP BY 
    product_sk