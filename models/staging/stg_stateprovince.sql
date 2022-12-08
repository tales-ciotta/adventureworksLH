with source_data as (
    select 
        stateprovinceid		
        , stateprovincecode			
        , countryregioncode			
        , isonlystateprovinceflag	
        , name as stateprovince_name		
        , territoryid		
        , rowguid			
        , modifieddate		
		
    from {{ source ('aw', 'person_stateprovince') }}
)

select * from source_data