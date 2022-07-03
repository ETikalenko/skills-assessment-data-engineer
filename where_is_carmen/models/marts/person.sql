WITH cte_union AS (
    SELECT DISTINCT witness   AS full_name,
                    "witness" AS person_type,
                    NULL      AS city_agent
    FROM {{ ref("stg_carmen_sightings") }}

    UNION

    SELECT DISTINCT agent      AS full_name,
                    "agent"    AS person_type,
                    city_agent
    FROM {{ ref("stg_carmen_sightings") }}
)
SELECT
    {{ dbt_utils.surrogate_key(["full_name", "person_type", "city_agent"]) }} AS person_id,
    *
FROM cte_union
