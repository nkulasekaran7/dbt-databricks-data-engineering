WITH sales AS 
(
    SELECT
        sales_id,
        product_sk,
        customer_sk,
        {{ multiply('quantity', 'unit_price') }} as calculated_gross_amount,
        gross_amount,
        payment_method
    FROM 
        {{ ref('bronze_sales') }}
)
, product AS 
(
    SELECT
        product_sk,
        category
    FROM 
        {{ ref('bronze_product') }}
)

, customer AS 
(
    SELECT
        customer_sk,
        gender
    FROM 
        {{ ref('bronze_customer') }}
)

, joined_data AS 
(
    SELECT
        s.sales_id,
        s.product_sk,
        s.customer_sk,
        s.calculated_gross_amount,
        s.gross_amount,
        s.payment_method,
        p.category,
        c.gender
    FROM 
        sales s
    JOIN 
        product p
    ON 
        s.product_sk = p.product_sk
    JOIN 
        customer c
    ON 
        s.customer_sk = c.customer_sk
)

select 
    category,
    gender,
    sum(gross_amount) as total_gross_amount
from 
    joined_data
group by 
    category,
    gender
order by 
    total_gross_amount desc 