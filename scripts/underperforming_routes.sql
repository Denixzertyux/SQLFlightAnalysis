
WITH RouteDelays AS (
    SELECT
        origin,
        AVG(late_aircraft_delay) as avg_late_aircraft_delay
    FROM flights
    WHERE late_aircraft_delay > 0
    GROUP BY origin
),
RankedRoutes AS (
    SELECT
        origin,
        avg_late_aircraft_delay,
        NTILE(10) OVER (ORDER BY avg_late_aircraft_delay DESC) as decile
    FROM RouteDelays
)
SELECT
    origin,
    avg_late_aircraft_delay
FROM RankedRoutes
WHERE decile = 1;