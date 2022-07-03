-- For each month, which agency region is Carmen Sandiego most likely to be found?

-- Calculate visits percentage for each region for each month and take max for each month

WITH cte_regions_visits AS (
    SELECT EXTRACT(MONTH FROM es.date_witnessed) AS month_witnessed,
           loc.region
    FROM {{ ref("event_sighting") }} es
    INNER JOIN {{ ref("location") }} loc
        ON es.location_id = loc.location_id
),
cte_region_visits_by_month AS (
    SELECT month_witnessed,
           region,
           COUNT(region) AS region_visits_num
    FROM cte_regions_visits
    GROUP BY month_witnessed, region
),
cte_region_visits_total AS (
    SELECT month_witnessed,
           COUNT(region) AS total_visits
    FROM cte_regions_visits
    GROUP BY month_witnessed
),
cte_ranked AS (
    SELECT vis.month_witnessed,
           vis.region,
           ROUND(CAST(vis.region_visits_num AS NUMERIC) /
                 CAST(tot_vis.total_visits AS NUMERIC), 2) AS region_visit_perc,
           RANK() OVER (
               PARTITION BY vis.month_witnessed ORDER BY CAST(vis.region_visits_num AS NUMERIC) /
                                                         CAST(tot_vis.total_visits AS NUMERIC) DESC
               )  AS rn
    FROM cte_region_visits_by_month vis
    INNER JOIN cte_region_visits_total tot_vis
        ON vis.month_witnessed = tot_vis.month_witnessed
)
SELECT TO_CHAR(
               TO_DATE(CAST(month_witnessed AS TEXT), 'MM'), 'Month'
           ) AS month_name,
       region
FROM cte_ranked
WHERE rn = 1
ORDER BY month_witnessed
