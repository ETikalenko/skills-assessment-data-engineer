-- what is the probability that Ms. Sandiego is armed AND wearing a jacket, but NOT a hat
WITH cte_probability AS (
    SELECT EXTRACT(MONTH FROM date_witnessed) AS month_witnessed,
           ROUND(
                       CAST(SUM(CASE
                                    WHEN has_weapon AND has_jacket AND NOT has_hat THEN 1
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
