with 
    source_data as (
        select *
        from {{ source ('aw', 'sales_salesorderheader') }}
    )
select * from source_data