with creditcard as (
    select 
        creditcard_sk
        , creditcardid
    from {{ ref('dim_creditcard') }}
)

, customer as (
    select 
        customer_sk
        , customerid
    from {{ ref('dim_customer') }}
)

, location as (
    select 
        location_sk
        , addressid
    from {{ ref('dim_location') }}
)

, product as (
    select 
        product_sk
        , productid
    from {{ ref('dim_product') }}
)

, first_join as (
    select
        salesorderheader.salesorderid
        , customer.customer_sk as customer_fk
        , creditcard.creditcard_sk as creditcard_fk
        , location.location_sk as location_fk        
        , salesorderheader.status_salesorderheader
        , salesorderheader.orderdate
        , salesorderheader.duedate
        , salesorderheader.shipdate
        , salesorderheader.subtotal
        , salesorderheader.totaldue

    from {{ ref('stg_salesorderheader') }} salesorderheader
    left join customer on salesorderheader.customerid = customer.customerid
    left join location on salesorderheader.billtoaddressid = location.addressid and salesorderheader.shiptoaddressid = location.addressid
    left join creditcard on salesorderheader.creditcardid = creditcard.creditcardid
)

, second_join as (
    select
        salesorderdetail.salesorderid
        , product.product_sk as product_fk
        , salesorderdetail.orderqty as orderqty
        , salesorderdetail.unitprice as unitprice
        , salesorderdetail.unitpricediscount

    from {{ ref('stg_salesorderdetail') }} salesorderdetail
    left join product on salesorderdetail.productid = product.productid
)

, final_join as (
    select 
        row_number() over (order by 
            salesorderheader.salesorderid
            , salesorderheader.location_fk
            , salesorderheader.customer_fk
            , salesorderheader.creditcard_fk
            , salesorderdetail.product_fk
        ) as salesorder_sk -- auto-incremental surrogate key
        , salesorderheader.salesorderid
        , salesorderheader.location_fk
        , salesorderheader.customer_fk
        , salesorderheader.creditcard_fk
        , salesorderdetail.product_fk
        , salesorderheader.orderdate			
        , salesorderheader.duedate			
        , salesorderheader.shipdate
        , salesorderheader.status_salesorderheader	
        , salesorderheader.subtotal
        , salesorderheader.totaldue
        , salesorderdetail.orderqty
        , salesorderdetail.unitprice
        , salesorderdetail.unitprice * salesorderdetail.orderqty as total_price
    from first_join as salesorderheader
    left join second_join as salesorderdetail on salesorderheader.salesorderid = salesorderdetail.salesorderid
)

select * from final_join