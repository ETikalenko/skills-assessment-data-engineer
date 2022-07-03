-- For each month, what is the probability Ms. Sandiego exhibits one of her three most occurring behaviors?
WITH cte_probability AS (
    SELECT EXTRACT(MONTH FROM date_witnessed) AS month_witnessed,
           ROUND(
                       CAST(SUM(CASE
                                    WHEN behavior IN (SELECT behavior from {{ ref("most_occuring_behavior") }}) THEN 1
                                    ELSE 0
                           END) AS NUMERIC) / CAST(COUNT(date_witnessed) AS NUMERIC), 2
               )                              AS probability
    FROM {{ ref("event_sighting") }}
    GROUP BY month_witnessed
)
SELECT TO_CHAR(
               TO_DATE(CAST(month_witnessed AS TEXT), 'MM'), 'Month'
           ) AS month_name,
       probability
FROM cte_probability
ORDER BY month_witnessed
