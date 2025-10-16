# Flight Delay & Cancellation SQL Analysis ✈️

## 📝 Overview

This repository contains a comprehensive SQL analysis of the **Flight Delay and Cancellation Data for 2024**. The primary goal of this project is to practice and demonstrate a variety of SQL skills—from basic data retrieval to advanced analytical queries using window functions and Common Table Expressions (CTEs).

The analysis explores various aspects of flight performance, including cancellation rates, delay causes, airport traffic, and performance trends over time.

---

## 💾 Dataset

The data used in this project is the "Flight Delay and Cancellation Data - 1 Million+ 2024" dataset from Kaggle. It features over a million records of domestic flights in the USA for the year 2024.

* **Source:** [Kaggle Dataset Link](https://www.kaggle.com/datasets/nalisha/flight-delay-and-cancellation-data-1-million-2024)
* **Format:** CSV

---

## 🛠️ Tools Used

* **Database:** PostgreSQL
* **IDE/Client:** DBeaver (or any SQL client)
* **Data Source:** Kaggle

---

## 🚀 Getting Started

To replicate this analysis, follow these steps:

### 1. Prerequisites
* A running instance of PostgreSQL.
* A SQL client to interact with the database.

### 2. Setup
1.  **Clone the repository:**
    ```sh
    git clone [https://github.com/your-username/your-repo-name.git](https://github.com/your-username/your-repo-name.git)
    ```
2.  **Download the Dataset:**
    Download the CSV file from the [Kaggle link](https://www.kaggle.com/datasets/nalisha/flight-delay-and-cancellation-data-1-million-2024) and place it in a known directory.

3.  **Create the Database Table:**
    Use the `schema.sql` file in this repository to create the `flights` table with the correct structure.
    ```sql
    -- schema.sql
    CREATE TABLE flights (
        year INT,
        month INT,
        day_of_month INT,
        day_of_week INT,
        fl_date DATE,
        origin VARCHAR(5),
        origin_city_name VARCHAR(255),
        origin_state_nm VARCHAR(255),
        dep_time INT,
        taxi_out INT,
        wheels_off INT,
        wheels_on INT,
        taxi_in INT,
        cancelled INT,
        arr_time INT,
        distance INT,
        weather_delay INT,
        late_aircraft_delay INT
    );
    ```

4.  **Load the Data:**
    Use the PostgreSQL `COPY` command to efficiently load the data from the CSV file into your table. **Remember to update the path to your CSV file.**
    ```sql
    COPY flights
    FROM 'C:/path/to/your/flight_data_2024.csv'
    WITH (FORMAT CSV, HEADER);
    ```

---

## 📊 SQL Analysis & Queries

This project includes a collection of SQL queries organized by difficulty to answer various analytical questions.

### Example Advanced Query: 7-Day Rolling Average of Cancellations

This query calculates the rolling average of flight cancellations over a 7-day window to identify trends and smooth out daily noise.

```sql
WITH DailyCancellations AS (
    SELECT
        fl_date,
        SUM(cancelled) as total_cancellations
    FROM flights
    GROUP BY fl_date
)
SELECT
    fl_date,
    total_cancellations,
    AVG(total_cancellations) OVER (ORDER BY fl_date ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) as seven_day_rolling_avg
FROM DailyCancellations;
