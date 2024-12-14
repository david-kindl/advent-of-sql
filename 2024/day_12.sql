WITH
    gift_ranked AS (
        SELECT
            g.gift_name,
            COUNT(*) AS cnt,
            
            ROUND(
                PERCENT_RANK() OVER (
                    ORDER BY
                        COUNT(*)
                )::numeric, 2
            ) AS pct_rank,
            
            DENSE_RANK() OVER (
                ORDER BY 
                    COUNT(*) DESC
            ) AS grp_rnk,
            
            ROW_NUMBER() OVER (
                PARTITION BY 
                    COUNT(*)
                ORDER BY 
                    gift_name
            ) AS grp_ord
        FROM
            gifts g
        INNER JOIN
            gift_requests gr
                ON g.gift_id = gr.gift_id
        GROUP BY 
            g.gift_id,
            g.gift_name
    )
    
SELECT 
    gift_name,
    pct_rank
FROM
    gift_ranked
WHERE 
    grp_rnk = 2
    AND grp_ord = 1
;