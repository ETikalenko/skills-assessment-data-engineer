SELECT DISTINCT
    {{ dbt_utils.surrogate_key(["region", "country", "city", "latitude", "longitude"]) }} AS location_id,
    region,
    country,
    city,
    latitude,
    longitude
FROM {{ ref("stg_carmen_sightings") }}
