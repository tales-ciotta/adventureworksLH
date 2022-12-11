with stg_product as (
    select *		
    from {{ ref('stg_product') }}
)

, transformed as (
    select
        row_number() over (order by stg_product.productid) as product_sk -- auto-incremental surrogate key
        , stg_product.productid
        , stg_product.product_name	
        , stg_product.standardcost
        , stg_product.listprice

    from stg_product
)

select * from transformed