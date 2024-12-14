SELECT 
    child_name,
    gift_name,
    gift_price
FROM (
    SELECT 
        c.name  AS child_name,
        g.name  AS gift_name,
        g.price AS gift_price,
        AVG(price) OVER () AS avg_price
    FROM
        children c
    INNER JOIN
        gifts g
            ON c.child_id= g.child_id 
)
WHERE 
    gift_price > avg_price
ORDER BY 
    gift_price 
;