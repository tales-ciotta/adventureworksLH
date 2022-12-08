with source_data as (
    select 
        customerid	
        , modifieddate
        , personid
        , rowguid				
        , storeid			
        , territoryid					

    from {{ source ('aw', 'sales_customer') }}
)

select * from source_data