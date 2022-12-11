with source_data as (
    select 
        addressid			
        , addressline1				
        , addressline2				
        , city
        , modifieddate			
        , postalcode
        , rowguid			
        , stateprovinceid			
        , spatiallocation	
        									
    from {{ source ('aw', 'person_address') }}
)

select * from source_data