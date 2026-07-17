SELECT
    *
FROM
    {{ source('source', 'items') }}

QUALIFY ROW_NUMBER() OVER (
    PARTITION BY id
    ORDER BY updateDate DESC
) = 1;