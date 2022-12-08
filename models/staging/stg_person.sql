with source_data as (
    select 
        businessentityid
        , emailpromotion
        , firstname
        , middlename
        , lastname
        , modifieddate
        , persontype
        , namestyle
        , rowguid	
        , suffix
        , title

    from {{ source ('aw', 'person_person') }}
)

select * from source_data