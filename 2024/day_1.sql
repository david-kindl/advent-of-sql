WITH
	base AS (
		SELECT
			c.name,
			wl.wishes ->> 'first_choice'	AS primary_wish,
			wl.wishes ->> 'second_choice' 	AS backup_wish,
			wl.wishes -> 'colors'			AS colors
		FROM
			children c
		INNER JOIN
			wish_lists wl
				ON c.child_id = wl.child_id
	)
SELECT
	b.name,
	b.primary_wish,
	b.backup_wish,
	b.colors ->>0	AS favorite_color,
	json_array_length(b.colors)		AS color_count,
	CASE
		WHEN tc.difficulty_to_make = 1 THEN
			'Simple'
		WHEN tc.difficulty_to_make = 2 THEN
			'Moderate'
		ELSE
			'Difficult'
	END || ' Gift' AS gift_complexity,
	CASE
		WHEN tc.category = 'outdoor' THEN
			'Outside'
		WHEN tc.category = 'educational' THEN 
			'Learning'
		ELSE
			'General'
	END || ' Workshop' AS workshop_assignment
FROM
	base b
INNER JOIN
	toy_catalogue tc
		ON b.primary_wish = tc.toy_name
ORDER BY
	b.name
FETCH FIRST 5 ROWS ONLY
;
