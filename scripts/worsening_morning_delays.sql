WITH DelayPeriods AS(
	SELECT
		origin,
		CASE
			WHEN dep_time >= 500 AND dep_time < 1000 THEN 'Morning'
			ELSE 'Other'
		END as time_period,
		weather_delay
	FROM flights
	WHERE weather_delay IS NOT NULL
)
SELECT
    origin,
    AVG(CASE WHEN time_period = 'Morning' THEN weather_delay END) as avg_morning_delay,
    AVG(CASE WHEN time_period = 'Other' THEN weather_delay END) as avg_other_delay
FROM DelayPeriods
GROUP BY origin
HAVING AVG(CASE WHEN time_period = 'Morning' THEN weather_delay END) >
       2 * AVG(CASE WHEN time_period = 'Other' THEN weather_delay END);