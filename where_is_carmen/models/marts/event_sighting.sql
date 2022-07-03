WITH cte_person_types AS (
    SELECT
        date_witness,
        date_agent,
        witness,
        "witness" AS witness_person_type,
        NULL AS city_witness,
        agent,
        "agent" AS agent_person_type,
        latitude,
        longitude,
        city,
        country,
        city_agent,
        has_weapon,
        has_hat,
        has_jacket,
        behavior,
        region
    FROM {{ ref("stg_carmen_sightings") }}
)

SELECT
    date_witness AS date_witnessed,
    date_agent AS date_reported,
    {{ dbt_utils.surrogate_key(["region", "country", "city", "latitude", "longitude"]) }} AS location_id,
    {{ dbt_utils.surrogate_key(["witness", "witness_person_type", "city_witness"]) }} AS witness_person_id,
    {{ dbt_utils.surrogate_key(["agent", "agent_person_type", "city_agent"]) }} AS agent_person_id,
    behavior,
    has_weapon,
    has_hat,
    has_jacket
FROM cte_person_types
