WITH
	charset AS (
		SELECT
			value,
			CHR(value)::varchar AS letter
		FROM (
			SELECT 32 AS value
			UNION ALL
			select 33
			UNION ALL
			SELECT 44
			UNION ALL
			SELECT 46
			UNION ALL
			SELECT
				*
			FROM
				generate_series(65, 90)
			UNION ALL
			SELECT
				*
			FROM
				generate_series(97, 122)
		)
	)
SELECT
	STRING_AGG(letter, '' ORDER BY t.ord, t.id) AS asd
FROM (
	SELECT
		1 AS ord,
		id,
		value
	FROM letters_a
	UNION ALL
	SELECT
		2 AS ord,
		id,
		value
	FROM letters_b
) t
INNER JOIN
	charset c
		ON t.value = c.value
