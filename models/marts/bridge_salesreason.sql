with salesreasonheader as (
    select *
    from {{ ref('stg_salesorderheadersalesreason') }}
)

, reason as (
    select 
         reason_sk
        , salesreasonid
    from {{ ref('dim_reason') }}
)

, transformed as (
    select
        row_number() over (order by salesreasonheader.salesorderid, reason.salesreasonid) as salesreason_sk -- auto-incremental surrogate key
        , salesreasonheader.salesorderid
        , reason.reason_sk
    from salesreasonheader
    left join reason on salesreasonheader.salesreasonid = reason.salesreasonid
)

select * from transformed