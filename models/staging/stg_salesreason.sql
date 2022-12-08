with source_data as (
    select 
        salesreasonid
        , modifieddate				
        , name as salesreason_name			
        , reasontype			

    from {{ source ('aw', 'sales_salesreason') }}
)

select * from source_data