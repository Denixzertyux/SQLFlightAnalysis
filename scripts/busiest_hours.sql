WITH TopAirports AS (
    SELECT origin
    FROM flights
    GROUP BY origin
    ORDER BY COUNT(*) DESC
    LIMIT 5
),
HourlyDepartures AS (
    SELECT
        origin,
        FLOOR(dep_time / 100) as departure_hour,
        COUNT(*) as num_flights,
        ROW_NUMBER() OVER(PARTITION BY origin ORDER BY COUNT(*) DESC) as rn
    FROM flights
    WHERE dep_time IS NOT NULL AND origin IN (SELECT origin FROM TopAirports)
    GROUP BY origin, departure_hour
)
SELECT
    origin,
    departure_hour,
    num_flights
FROM HourlyDepartures
WHERE rn = 1;