--
-- Change timestamp column precision to include microseconds
--
ALTER TABLE change_event
DROP INDEX dateTime,
DROP COLUMN dateTime,
ADD COLUMN dateTime TIMESTAMP(6) GENERATED ALWAYS AS (STR_TO_DATE(json ->> '$.dateTime', '%Y-%m-%dT%T.%fZ')) NOT NULL AFTER username,
ADD INDEX (dateTime);

CREATE TABLE IF NOT EXISTS glossary_entity (
    id VARCHAR(36) GENERATED ALWAYS AS (json ->> '$.id') STORED NOT NULL,
    fullyQualifiedName VARCHAR(256) GENERATED ALWAYS AS (json ->> '$.fullyQualifiedName') NOT NULL,
    json JSON NOT NULL,
    updatedAt TIMESTAMP GENERATED ALWAYS AS (TIMESTAMP(STR_TO_DATE(json ->> '$.updatedAt', '%Y-%m-%dT%T.%fZ'))) NOT NULL,
    updatedBy VARCHAR(256) GENERATED ALWAYS AS (json ->> '$.updatedBy') NOT NULL,
    timestamp BIGINT,
    PRIMARY KEY (id),
    UNIQUE KEY unique_name(fullyQualifiedName),
    INDEX (updatedBy),
    INDEX (updatedAt)
);

