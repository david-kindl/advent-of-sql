WITH
    emails AS (
        SELECT DISTINCT
            UNNEST(email_addresses) AS email
        FROM 
            contact_list
    )
SELECT
    REGEXP_REPLACE(email, '^(.*@)', '') AS domain,
    COUNT(email) AS cnt,
    ARRAY_AGG(email) AS emails
FROM 
    emails
GROUP BY
    domain
ORDER BY
    cnt DESC,
    domain
;