with stg_address as (
    select *		
    from {{ ref('stg_address') }}
)

, stg_countryregion as (
    select *		
    from {{ ref('stg_countryregion') }}
)

, stg_stateprovince as (
    select *
    from {{ ref('stg_stateprovince') }}
)

, first_join as (
    select
        stg_stateprovince.stateprovinceid
        , stg_countryregion.country_name
        , stg_stateprovince.state_name

    from stg_stateprovince
    left join stg_countryregion on stg_stateprovince.countryregioncode = stg_countryregion.countryregioncode
)

, transformed as (
    select
        row_number() over (order by addressid) as location_sk -- auto-incremental surrogate key
        , stg_address.addressid 
        , first_join.country_name
        , first_join.state_name
        , stg_address.city

    from stg_address
    left join first_join on stg_address.stateprovinceid= first_join.stateprovinceid
)

select * from transformed