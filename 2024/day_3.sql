WITH
	headcount AS (
		SELECT
			id,
			COALESCE(cnt1, cnt2, cnt3)::integer AS cnt
		FROM (
			SELECT
				t.id,
				UNNEST(XPATH('//total_present/text()', t.menu_data))::varchar 	AS cnt1,
				UNNEST(XPATH('//total_guests/text()', t.menu_data))::varchar  	AS cnt2,
				UNNEST(XPATH('//total_count/text()', t.menu_data))::varchar	AS cnt3
				
			FROM
				christmas_menus t
		)
	),

	menu_items AS (
		SELECT
			t.id,
			UNNEST(XPATH('//food_item_id/text()', menu_data))::varchar	AS fit
		FROM
			christmas_menus t
	)
	
SELECT
	mi.fit,
	COUNT(DISTINCT hc.id) AS cnt
FROM
	headcount hc
INNER JOIN
	menu_items mi
		ON hc.id = mi.id
WHERE
	hc.cnt > 78
GROUP BY
	mi.fit
ORDER BY
	cnt DESC
;