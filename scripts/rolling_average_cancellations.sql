WITH DailyCancellations AS(
	SELECT
		fl_date,
		SUM(cancelled) as total_cancellations
	FROM flights
	GROUP BY fl_date
)
SELECT 
	fl_date,
	total_cancellations,
	AVG(total_cancellations) OVER (ORDER BY fl_date ROWS BETWEEN 6 PRECEDING AND CURRENT ROW)AS seven_day_rolling_avg
FROM DailyCancellations;	