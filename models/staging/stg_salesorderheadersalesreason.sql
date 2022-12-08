with source_data as (
    select 
        salesorderid
        , modifieddate			
        , salesreasonid		
		
    from {{ source ('aw', 'sales_salesorderheadersalesreason') }}
)

select * from source_data