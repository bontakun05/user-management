-- +goose Up
-- SQL in this section is executed when the migration is applied.
CREATE TABLE IF NOT EXISTS public."user_info" (
  "user_uuid" uuid UNIQUE NOT NULL,
  "username" varchar (127) UNIQUE NOT NULL,
  "name" varchar(127) NOT NULL,
  "email" varchar(127) UNIQUE NOT NULL,
  "user_secret" varchar(255) NOT NULL,
  "is_active" boolean NOT NULL,
  "hierarchy_id" int8 NOT NULL DEFAULT 0,
  "created_at" timestamp NOT NULL DEFAULT current_timestamp,
  "modified_at" timestamp NOT NULL DEFAULT current_timestamp,
  "created_by" varchar(255),
  "modified_by" varchar(255),
  "PasswordExpired" timestamp,
  "CredentialID" uuid,
  PRIMARY KEY ("user_uuid", "username")
);

CREATE TABLE IF NOT EXISTS public."mst_role" (
  "role_id" serial8 PRIMARY KEY,
  "role_name" varchar(127),
  "created_at" timestamp NOT NULL DEFAULT current_timestamp,
  "modified_at" timestamp NOT NULL DEFAULT current_timestamp,
  "created_by" varchar(255),
  "modified_by" varchar(255)
);

CREATE TABLE IF NOT EXISTS public."mst_role_access" (
  "role_access_id" serial8 PRIMARY KEY,
  "role_access" varchar(127),
  "created_at" timestamp NOT NULL DEFAULT current_timestamp,
  "modified_at" timestamp NOT NULL DEFAULT current_timestamp,
  "created_by" varchar,
  "modified_by" varchar
);

CREATE TABLE IF NOT EXISTS public."mst_menu" (
  "menu_id" serial8 PRIMARY KEY,
  "menu_name" varchar(127),
  "created_at" timestamp NOT NULL DEFAULT current_timestamp,
  "modified_at" timestamp NOT NULL DEFAULT current_timestamp,
  "created_by" varchar(255),
  "modified_by" varchar(255)
);

CREATE TABLE IF NOT EXISTS public."mst_menu_object" (
  "menu_object_id" serial8 PRIMARY KEY,
  "menu_id" int8 NOT NULL DEFAULT 0,
  "role_access_id" int8 NOT NULL DEFAULT 0,
  "created_at" timestamp NOT NULL DEFAULT current_timestamp,
  "modified_at" timestamp NOT NULL DEFAULT current_timestamp,
  "created_by" varchar(255),
  "modified_by" varchar(255)
);

CREATE TABLE IF NOT EXISTS public."mst_group" (
  "group_id" serial8 PRIMARY KEY,
  "role_id" int8 NOT NULL DEFAULT 0,
  "role_access_id" int8 NOT NULL DEFAULT 0,
  "user_uuid" uuid NOT NULL,
  "created_at" timestamp NOT NULL DEFAULT current_timestamp,
  "modified_at" timestamp NOT NULL DEFAULT current_timestamp,
  "created_by" varchar(255),
  "modified_by" varchar(255)
);

ALTER TABLE public."mst_group" ADD FOREIGN KEY ("role_id") REFERENCES public."mst_role" ("role_id");

ALTER TABLE public."mst_group" ADD FOREIGN KEY ("role_access_id") REFERENCES public."mst_role_access" ("role_access_id");

ALTER TABLE public."mst_menu_object" ADD FOREIGN KEY ("menu_id") REFERENCES public."mst_menu" ("menu_id");

--ALTER TABLE public."user_info" ADD FOREIGN KEY ("user_uuid") REFERENCES public."mst_group" ("user_uuid");

--ALTER TABLE public."mst_role_access" ADD FOREIGN KEY ("role_access_id") REFERENCES public."mst_menu_object" ("role_access_id");
INSERT INTO "user_info" (user_uuid, username, name, email, user_secret, is_active) values ('cf8a699b-7dfa-4b1a-8e01-09cf3d9d9f0f','admin','Administrator','admin@bluebird.id','secret',true);

INSERT INTO "mst_menu" (menu_name, created_by, modified_by) values ('Menu User', 'cf8a699b-7dfa-4b1a-8e01-09cf3d9d9f0f', 'cf8a699b-7dfa-4b1a-8e01-09cf3d9d9f0f');

INSERT INTO "mst_role" (role_name, created_by, modified_by) values ('Administrator','cf8a699b-7dfa-4b1a-8e01-09cf3d9d9f0f','cf8a699b-7dfa-4b1a-8e01-09cf3d9d9f0f');

INSERT INTO "mst_role_access" (role_access, created_by, modified_by) values ('create','cf8a699b-7dfa-4b1a-8e01-09cf3d9d9f0f','cf8a699b-7dfa-4b1a-8e01-09cf3d9d9f0f');

INSERT INTO "mst_role_access" (role_access, created_by, modified_by) values ('edit','cf8a699b-7dfa-4b1a-8e01-09cf3d9d9f0f','cf8a699b-7dfa-4b1a-8e01-09cf3d9d9f0f');

INSERT INTO "mst_role_access" (role_access, created_by, modified_by) values ('delete','cf8a699b-7dfa-4b1a-8e01-09cf3d9d9f0f','cf8a699b-7dfa-4b1a-8e01-09cf3d9d9f0f');

INSERT INTO "mst_role_access" (role_access, created_by, modified_by) values ('list','cf8a699b-7dfa-4b1a-8e01-09cf3d9d9f0f','cf8a699b-7dfa-4b1a-8e01-09cf3d9d9f0f');

INSERT INTO "mst_role_access" (role_access, created_by, modified_by) values ('reset','cf8a699b-7dfa-4b1a-8e01-09cf3d9d9f0f','cf8a699b-7dfa-4b1a-8e01-09cf3d9d9f0f');

INSERT INTO "mst_role_access" (role_access, created_by, modified_by) values ('change password','cf8a699b-7dfa-4b1a-8e01-09cf3d9d9f0f','cf8a699b-7dfa-4b1a-8e01-09cf3d9d9f0f');

INSERT INTO "mst_menu_object" (menu_id, role_access_id, created_by, modified_by) values (1,1,'cf8a699b-7dfa-4b1a-8e01-09cf3d9d9f0f','cf8a699b-7dfa-4b1a-8e01-09cf3d9d9f0f');

INSERT INTO "mst_menu_object" (menu_id, role_access_id, created_by, modified_by) values (1,2,'cf8a699b-7dfa-4b1a-8e01-09cf3d9d9f0f','cf8a699b-7dfa-4b1a-8e01-09cf3d9d9f0f');

INSERT INTO "mst_menu_object" (menu_id, role_access_id, created_by, modified_by) values (1,3,'cf8a699b-7dfa-4b1a-8e01-09cf3d9d9f0f','cf8a699b-7dfa-4b1a-8e01-09cf3d9d9f0f');

INSERT INTO "mst_menu_object" (menu_id, role_access_id, created_by, modified_by) values (1,4,'cf8a699b-7dfa-4b1a-8e01-09cf3d9d9f0f','cf8a699b-7dfa-4b1a-8e01-09cf3d9d9f0f');

INSERT INTO "mst_menu_object" (menu_id, role_access_id, created_by, modified_by) values (1,5,'cf8a699b-7dfa-4b1a-8e01-09cf3d9d9f0f','cf8a699b-7dfa-4b1a-8e01-09cf3d9d9f0f');

INSERT INTO "mst_menu_object" (menu_id, role_access_id, created_by, modified_by) values (1,6,'cf8a699b-7dfa-4b1a-8e01-09cf3d9d9f0f','cf8a699b-7dfa-4b1a-8e01-09cf3d9d9f0f');

INSERT INTO "mst_group" (role_id, role_access_id, user_uuid, created_by, modified_by) values (1,1,'cf8a699b-7dfa-4b1a-8e01-09cf3d9d9f0f','cf8a699b-7dfa-4b1a-8e01-09cf3d9d9f0f','cf8a699b-7dfa-4b1a-8e01-09cf3d9d9f0f');

INSERT INTO "mst_group" (role_id, role_access_id, user_uuid, created_by, modified_by) values (1,2,'cf8a699b-7dfa-4b1a-8e01-09cf3d9d9f0f','cf8a699b-7dfa-4b1a-8e01-09cf3d9d9f0f','cf8a699b-7dfa-4b1a-8e01-09cf3d9d9f0f');

INSERT INTO "mst_group" (role_id, role_access_id, user_uuid, created_by, modified_by) values (1,3,'cf8a699b-7dfa-4b1a-8e01-09cf3d9d9f0f','cf8a699b-7dfa-4b1a-8e01-09cf3d9d9f0f','cf8a699b-7dfa-4b1a-8e01-09cf3d9d9f0f');

INSERT INTO "mst_group" (role_id, role_access_id, user_uuid, created_by, modified_by) values (1,4,'cf8a699b-7dfa-4b1a-8e01-09cf3d9d9f0f','cf8a699b-7dfa-4b1a-8e01-09cf3d9d9f0f','cf8a699b-7dfa-4b1a-8e01-09cf3d9d9f0f');

INSERT INTO "mst_group" (role_id, role_access_id, user_uuid, created_by, modified_by) values (1,5,'cf8a699b-7dfa-4b1a-8e01-09cf3d9d9f0f','cf8a699b-7dfa-4b1a-8e01-09cf3d9d9f0f','cf8a699b-7dfa-4b1a-8e01-09cf3d9d9f0f');

INSERT INTO "mst_group" (role_id, role_access_id, user_uuid, created_by, modified_by) values (1,6,'cf8a699b-7dfa-4b1a-8e01-09cf3d9d9f0f','cf8a699b-7dfa-4b1a-8e01-09cf3d9d9f0f','cf8a699b-7dfa-4b1a-8e01-09cf3d9d9f0f');


-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
DROP TABLE IF EXISTS public."mst_group" ;
DROP TABLE IF EXISTS public."mst_menu" CASCADE;
DROP TABLE IF EXISTS public."mst_menu_object" CASCADE;
DROP TABLE IF EXISTS public."mst_role";
DROP TABLE IF EXISTS public."mst_role_access";
DROP TABLE IF EXISTS public."user_info"