WITH 
	prev AS (
		SELECT
			toy_id,
			toy_name,
			UNNEST(previous_tags)::varchar AS tag
		FROM
			toy_production
	),

	curr AS (
		SELECT
			toy_id,
			toy_name,
			UNNEST(new_tags)::varchar AS tag
		FROM
			toy_production
	),

	compare AS (
		SELECT
			COALESCE(prev.toy_id, curr.toy_id) 					AS toy_id,
			COALESCE(prev.toy_name, curr.toy_name)					AS toy_name,
			ARRAY_AGG(curr.tag) FILTER (WHERE prev.tag IS NULL) 	AS added_tags,
			ARRAY_AGG(curr.tag) FILTER (WHERE curr.tag = prev.tag)	AS unchanged_tags,
			ARRAY_AGG(prev.tag) FILTER (WHERE curr.tag IS NULL) 	AS removed_tags
		FROM
			prev
		FULL OUTER JOIN
			curr
			ON (
				prev.toy_id = curr.toy_id
				AND prev.tag= curr.tag
			)
		GROUP BY
			COALESCE(prev.toy_id, curr.toy_id),
			COALESCE(prev.toy_name, curr.toy_name)
	)

SELECT
	toy_id,
	--toy_name,
	COALESCE(ARRAY_LENGTH(added_tags, 1), 0)		AS len_added,
	COALESCE(ARRAY_LENGTH(unchanged_tags, 1), 0)	AS len_unchanged,
	COALESCE(ARRAY_LENGTH(removed_tags, 1), 0)		AS len_removed
FROM
	compare
ORDER BY
	ARRAY_LENGTH(added_tags, 1) DESC NULLS LAST
;