WITH FlightEvents AS (
    SELECT
        origin,
        fl_date,
        wheels_on,
        dep_time,
        taxi_out,
        LAG(wheels_on, 1) OVER(PARTITION BY origin, fl_date ORDER BY wheels_on) as prev_arrival_time
    FROM flights
    WHERE wheels_on IS NOT NULL AND dep_time IS NOT NULL
)
SELECT
    origin,
    AVG(taxi_out) as avg_taxi_out_on_quick_turnaround
FROM FlightEvents
WHERE
    -- Convert HHMM to minutes for comparison
    (FLOOR(dep_time / 100) * 60 + (dep_time % 100)) -
    (FLOOR(prev_arrival_time / 100) * 60 + (prev_arrival_time % 100))
    BETWEEN 0 AND 30
GROUP BY origin
ORDER BY avg_taxi_out_on_quick_turnaround DESC;