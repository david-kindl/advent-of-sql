WITH
    seasons (
        season_id,
        season
    ) AS (
        SELECT 1, 'Spring'
        UNION ALL
        SELECT 2, 'Summer'
        UNION ALL
        SELECT 3, 'Fall'
        UNION ALL
        SELECT 4, 'Winter'
    )
SELECT 
    t.field_name,
    t.harvest_year,
    t.season,
    ROUND(
        AVG(t.trees_harvested) OVER (
            PARTITION BY
                t.field_name,
                t.harvest_year
            ORDER BY 
                s.season_id
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW 
        ), 2
    ) AS three_season_moving_avg
FROM 
    treeharvests t
INNER JOIN
    seasons s
        ON t.season = s.season
ORDER BY
    three_season_moving_avg DESC
;

