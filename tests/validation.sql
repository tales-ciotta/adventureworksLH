with
    validation as (
        select count (distinct salesorderid) as count_salesorderid
        from {{ ref ('fct_salesorders')}}
        where orderdate between '2012-01-01' and '2012-06-01'
    )

select * 
from validation 
where count_salesorderid != 1434