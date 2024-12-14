WITH 
	daily_compare_base AS (
		SELECT
			production_date,
			toys_produced,
			LAG(toys_produced) OVER (
				ORDER BY
					production_date
			) AS previous_day_production
		FROM
			toy_production
	)

SELECT
	production_date,
	toys_produced,
	previous_day_production,
	toys_produced - previous_day_production AS production_change,
	toys_produced / previous_day_production - 1 AS production_change_percentage
FROM
	daily_compare_base
ORDER BY
	production_change_percentage DESC NULLS LAST
;