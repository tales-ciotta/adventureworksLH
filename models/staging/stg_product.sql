with source_data as (
    select 
        productid		
        , class	
        , color		
        , daystomanufacture		
        , finishedgoodsflag	
        , listprice	  
        , makeflag
        , modifieddate		                          
        , name as product_name
        , productline
        , productmodelid				
        , productnumber	
        , productsubcategoryid
        , reorderpoint	
        , rowguid				
        , safetystocklevel				
        , sellenddate
        , sellstartdate								
        , size as product_size
        , standardcost
        , style						
        , sizeunitmeasurecode	
        , weight as product_weight				
        , weightunitmeasurecode				
        
    from {{ source ('aw', 'production_product') }}
)

select * from source_data