with stg_customer as (
    select *		
    from {{ ref('stg_customer') }}
)

, stg_person as (
    select 
    businessentityid
    , concat(ifnull(firstname,' '),' ',ifnull(middlename,' '),' ',ifnull(lastname,' ')) as person_name

    from {{ ref('stg_person') }}
)

/*Joining stg_customer and stg_person to get the dim_customer with the names of customers*/
, transformed as (
    select
        row_number() over (order by stg_customer.customerid) as customer_sk -- auto-incremental surrogate key
        , stg_customer.customerid
        , stg_person.person_name

    from stg_customer
    left join stg_person on stg_customer.personid = stg_person.businessentityid
)

select * from transformed