with source_data as (
    select
        salesorderid
        , purchaseordernumber	
        , shipmethodid				
        , billtoaddressid			
        , salespersonid
        , modifieddate			
        , rowguid
        , taxamt				
        , shiptoaddressid
        , onlineorderflag		
        , territoryid
        , status as status_salesorderheader
        , currencyrateid
        , orderdate
        , creditcardapprovalcode	
        , subtotal		
        , creditcardid		
        , revisionnumber			
        , freight
        , duedate			
        , totaldue			
        , customerid		
        , shipdate			
        , accountnumber
            
    from {{ source ('aw', 'sales_salesorderheader') }}
)
select * from source_data