-- What are the three most occuring behaviors of Ms. Sandiego?

SELECT behavior,
       COUNT(behavior) AS num
FROM {{ ref("event_sighting") }}
GROUP BY behavior
ORDER BY num DESC, behavior -- to get the same result in case of tie
LIMIT 3

-- It could be tie so better to use rank, but the task requires 3 behaviors
-- WITH cte_counts AS (
--     SELECT behavior,
--            COUNT(behavior) AS num,
--            RANK() OVER (ORDER BY COUNT(behavior) DESC) as rnk
--     FROM {{ ref("event_sighting") }}
--     GROUP BY behavior
-- )
-- SELECT behavior, num
-- FROM cte_counts
-- WHERE rnk < 4

