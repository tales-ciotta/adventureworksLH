with source_data as (
    select 
        creditcardid			
        , cardtype				
        , cardnumber				
        , expmonth			
        , expyear			
        , modifieddate		

    from {{ source ('aw', 'sales_creditcard') }}
)

select * from source_data