select 
    a.category,
    b.supplier_sk,
    b.product_sk,
    sum(a.total_gross_amount) as total_gross_amount
from 
    {{ ref('silver_salesinfo') }} as a
join 
    {{ ref('bronze_product') }} as b
on a.category = b.category
group by 
    a.category,
    b.supplier_sk,
    b.product_sk
order by 
    total_gross_amount desc 