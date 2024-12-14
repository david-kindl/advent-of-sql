WITH RECURSIVE
    mgr_path (
        staff_id,
        staff_name,
        manager_id,
        manager_path,
        level
    ) AS (
        SELECT 
            s.staff_id,
            s.staff_name,
            s.manager_id,
            s.staff_id::varchar,
            1
        FROM 
            public.staff s 
        WHERE
            s.manager_id IS NULL
        
        UNION ALL 
        
        SELECT 
            s.staff_id,
            s.staff_name,
            s.manager_id,
            m.manager_path || ', ' || s.staff_id,
            m.level + 1
        FROM
            mgr_path m
        INNER JOIN 
            public.staff s 
                ON m.staff_id = s.manager_id
    )
    
SELECT 
    MAX(level) AS max_level
FROM 
    mgr_path
;
