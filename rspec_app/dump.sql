PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "schema_migrations" ("version" varchar NOT NULL PRIMARY KEY);
INSERT INTO schema_migrations VALUES('20210226054410');
INSERT INTO schema_migrations VALUES('20210226054441');
INSERT INTO schema_migrations VALUES('20210227193335');
CREATE TABLE IF NOT EXISTS "ar_internal_metadata" ("key" varchar NOT NULL PRIMARY KEY, "value" varchar, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL);
INSERT INTO ar_internal_metadata VALUES('environment','development','2021-02-26 05:45:22.046396','2021-02-26 05:45:22.046396');
CREATE TABLE IF NOT EXISTS "characters" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar, "strength" integer, "dexterity" integer, "intelligence" integer, "charisma" integer, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL, "references" Player);
CREATE TABLE IF NOT EXISTS "players" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "user_name" varchar, "display_name" varchar, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL);
DELETE FROM sqlite_sequence;
COMMIT;
