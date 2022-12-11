
with stg_salesreason as (
    select *
    from {{ ref('stg_salesreason') }}
)

, transformed as (
    select
        row_number() over (order by salesreasonid) as reason_sk -- auto-incremental surrogate key
        , salesreasonid
        , salesreason_name
        , reasontype

    from stg_salesreason
)
select * from transformed