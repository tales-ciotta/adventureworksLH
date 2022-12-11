with source_data as (
    select 
        salesorderid		
        , salesorderdetailid			
        , orderqty		
        , productid		
        , specialofferid		
        , unitprice		
        , unitpricediscount		
        , rowguid		
        , modifieddate
		
    from {{ source ('aw', 'sales_salesorderdetail') }}
)

select * from source_data