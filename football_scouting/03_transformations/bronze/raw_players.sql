CREATE OR REFRESH STREAMING TABLE football_scouting.bronze.raw_players (
  CONSTRAINT has_raw_json EXPECT (raw_json IS NOT NULL)
)
--Raw players with season statistics from API-Football - bronze layer
   AS
SELECT
  * EXCEPT (ingested_at),
  CAST(ingested_at AS TIMESTAMP) AS ingested_at,
  _metadata.file_path AS source_file
FROM
  STREAM read_files(
    "/Volumes/football_scouting/default/raw/players",
    format => "json",
    schema => "entity STRING, league_id BIGINT, season INT, ingested_at STRING, raw_json STRING"
  )