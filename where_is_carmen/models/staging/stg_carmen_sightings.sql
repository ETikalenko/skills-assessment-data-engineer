SELECT
    date_witness,
    date_agent,
    witness,
    agent,
    latitude,
    longitude,
    city,
    country,
    region_hq AS city_agent,
    has_weapon,
    has_hat,
    has_jacket,
    behavior,
    region
FROM {{ ref("carmen_sightings_africa") }}

{% for region in ["america", "asia", "atlantic", "australia", "europe", "indian", "pacific"] %}

UNION

SELECT
    {{ dbt_utils.star(ref("carmen_sightings_" + region)) }}
FROM {{ ref("carmen_sightings_" + region) }}

{% endfor %}
