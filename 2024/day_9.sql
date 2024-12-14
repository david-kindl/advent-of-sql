WITH
    avg_speed AS (
        SELECT 
            r.reindeer_id,
            r.reindeer_name,
            ts.exercise_name,
            AVG(ts.speed_record) AS avg_speed
        FROM 
            reindeers r
        INNER JOIN
            training_sessions ts
                ON r.reindeer_id = ts.reindeer_id
        WHERE 
            r.reindeer_name != 'Rudolph'
        GROUP BY 
            r.reindeer_id,
            r.reindeer_name,
            ts.exercise_name
    ),
    
    max_avg_speed AS (
        SELECT
            reindeer_id,
            reindeer_name,
            ROUND(MAX(avg_speed), 2) AS max_avg_speed
        FROM
            avg_speed
        GROUP BY
            reindeer_id,
            reindeer_name
    )
SELECT 
    *
FROM 
    max_avg_speed
ORDER BY
    max_avg_speed DESC
;