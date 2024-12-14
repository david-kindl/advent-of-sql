SELECT 
    date
FROM (
    SELECT 
        d.date,
        SUM(CASE WHEN drink_name = 'Hot Cocoa' THEN quantity ELSE 0 END) AS cocoa,
        SUM(CASE WHEN drink_name = 'Peppermint Schnapps' THEN quantity ELSE 0 END) AS schnapps,
        SUM(CASE WHEN drink_name = 'Eggnog' THEN quantity ELSE 0 END) AS eggnog
    FROM 
        drinks d
    GROUP BY
        date
)
WHERE 
    cocoa = 38
    AND schnapps = 298
    AND eggnog = 198
;

SELECT 
    d.date
FROM 
    drinks d
GROUP BY
    date
HAVING 
    SUM(CASE WHEN drink_name = 'Hot Cocoa' THEN quantity ELSE 0 END) = 38
    AND SUM(CASE WHEN drink_name = 'Peppermint Schnapps' THEN quantity ELSE 0 END) = 298
    AND SUM(CASE WHEN drink_name = 'Eggnog' THEN quantity ELSE 0 END) = 198
;