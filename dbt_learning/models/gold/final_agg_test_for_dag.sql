select
    a.*,
    b.total_gross_amount as product_total_gross_amount
from 
    {{ ref('category_aggregation') }} as a
join 
    {{ ref('product_sales') }} as b
on 
    a.product_sk = b.product_sk