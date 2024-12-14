WITH 
    years AS (
        SELECT
            primary_skill,
            MAX(years_experience) AS max_years,
            MIN(years_experience) AS min_years
        FROM 
            workshop_elves we 
        GROUP BY
            primary_skill 
    )
    
SELECT 
    MIN(mx.elf_id) AS elf_1_id,
    MIN(mn.elf_id) AS elf_2_id,
    y.primary_skill
FROM 
    years y
INNER JOIN
    public.workshop_elves mx
        ON (
            y.primary_skill  = mx.primary_skill
            AND y.max_years = mx.years_experience 
        )
INNER JOIN
    public.workshop_elves mn
        ON (
            y.primary_skill = mn.primary_skill
            AND y.min_years = mn.years_experience 
        )
GROUP BY 
    y.primary_skill
;