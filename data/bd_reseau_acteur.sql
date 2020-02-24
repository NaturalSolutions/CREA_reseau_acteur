SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;


---------------------
-- Base de données --
---------------------
-- DROP DATABASE reseau_acteur;

-- CREATE USER if not exits
/* DO
$do$
BEGIN
   IF NOT EXISTS (
      SELECT
      FROM   pg_catalog.pg_roles
      WHERE  rolname = 'MYUSER') THEN

      CREATE ROLE crea LOGIN PASSWORD 'MYPASS';
   END IF;
END
$do$; */

-- CREATE DATABASE
CREATE DATABASE reseau_acteur WITH OWNER "crea" ENCODING 'UTF8' LC_COLLATE = 'fr_FR.UTF-8' LC_CTYPE= 'fr_FR.UTF-8' TEMPLATE= "template0";

-- CONNECT DATABASE
-- \connect reseau_acteur;

-------------
-- PostGis --
-------------

CREATE EXTENSION IF NOT EXISTS postgis;

------------
-- Schema --
------------
-- DROP SCHEMA sch_reseau_acteur CASCADE;
CREATE SCHEMA sch_reseau_acteur;


SET search_path = sch_reseau_acteur, pg_catalog, public;

SET default_with_oids = false;


-----------
-- Grant --
-----------

GRANT ALL PRIVILEGES ON DATABASE reseau_acteur to crea;

-- Necessaire ?
GRANT ALL ON TABLE geometry_columns TO crea;
GRANT ALL ON TABLE spatial_ref_sys TO crea;
GRANT ALL ON SCHEMA public to crea;
GRANT ALL ON SCHEMA sch_reseau_acteur to crea;

------------
-- Tables --
------------

-- Type d'étude
CREATE TABLE t_studies_type (
    id_studies_type serial NOT NULL,
    label_default character varying(50)
);
COMMENT ON TABLE sch_reseau_acteur.t_studies_type IS 'De quel type est une étude ou une ressource.';


-- Thématique
CREATE TABLE t_thematics (
    id_thematics serial NOT NULL,
    label_default character varying(50)
);
COMMENT ON TABLE sch_reseau_acteur.t_thematics IS 'Représente une thématique pour une téudes ou une organisation.';


-- Etudes et ressources
CREATE TABLE t_studies (
    id_studies serial NOT NULL,
    name character varying(50),
    title character varying(255),
    create_date character varying(4),
    resume text,
    url character varying(255),
    status character varying(25),
    language character(3)[],
    comments text,
    id_studies_type integer
);
COMMENT ON TABLE sch_reseau_acteur.t_studies IS 'Représente une études ou une ressources';


-- Individus
CREATE TABLE t_individuals (
    id_individuals serial NOT NULL,
    lastname character varying(50),
    firstname character varying(50),
    email character varying(250),
    email_alt character varying(250),
    position character varying(250),
    nationality character varying(50),
    comments text,
    tel_mobile character varying(14),
    tel_lab character varying(14)
);
COMMENT ON TABLE sch_reseau_acteur.t_individuals IS 'Représente un individu.';


-- Type d'organisation ex : Association, Laboratoire recherche
CREATE TABLE t_organization_type (
    id_organization_type serial NOT NULL,
    label_default character varying(50)
);
COMMENT ON TABLE sch_reseau_acteur.t_studies_type IS 'De quel type est une organisation.';


-- Organisations
CREATE TABLE t_organizations (
    id_organizations serial NOT NULL,
    id_organization_type integer,
    name character varying(50),
    web_site character varying(250),
    city character varying(50),
    country character varying(50),
    comments text,
    acronym character varying(25)
);
COMMENT ON TABLE sch_reseau_acteur.t_organizations IS 'Représente une Organisation.';


-- Equipement
CREATE TABLE t_equipments (
    id_equipments serial NOT NULL,
    name character varying(50),
    description text,
    date_install date,
    url character varying(255),
    city character varying(50),
    site_desc text,
    lat_long public.geometry(Point, 4326),
    comments text,
    activate BOOLEAN
);
COMMENT ON TABLE sch_reseau_acteur.t_equipments IS 'Représente un équipement.';


-- Sites
CREATE TABLE t_sites (
    id_sites serial NOT NULL,
    lat_long public.geometry(Point,4326),
    geom public.geometry(Geometry,4326),
    description text,
    country character varying(50),
    city character varying(50)
);
COMMENT ON TABLE sch_reseau_acteur.t_sites IS 'Représente un site.';


--  Correspondance Etude Site : Où se situe une étude
CREATE TABLE cor_studies_sites (
     id_cor_studies_sites serial NOT NULL,
     id_studies integer NOT NULL,
     id_sites integer NOT NULL
 );
COMMENT ON TABLE sch_reseau_acteur.cor_studies_sites IS 'Où se situe un site?';


--  Correspondance Individus Etude : Quels indididus ont collaboré à une ressource ?
CREATE TABLE cor_indiv_studies (
    id_individualsiv_studies serial NOT NULL,
    id_studies integer NOT NULL,
    id_individuals integer NOT NULL
);
COMMENT ON TABLE sch_reseau_acteur.cor_indiv_studies IS 'Quels indididus ont collaboré à une ressource.';


-- Correspondance Etude thématique : Quelles thématiques peuvent qualifier une ressource ?
CREATE TABLE cor_studies_thematics (
    id_cor_studies_thematics serial NOT NULL,
    id_studies integer NOT NULL,
    id_thematics integer NOT NULL
);
COMMENT ON TABLE sch_reseau_acteur.cor_studies_thematics IS 'Quelles thématiques peuvent qualifier une ressource.';


-- Correspondance Organisation Thématique : Quelles thématiques peuvent qualifier une thématique ?
CREATE TABLE cor_organ_thematics (
    id_cor_organ_thematic serial NOT NULL,
    id_organizations integer NOT NULL,
    id_thematics integer NOT NULL
);
COMMENT ON TABLE sch_reseau_acteur.cor_organ_thematics IS 'Quelles thématiques peuvent qualifier une thématique.';

--  Correspondance Organisation Individus : A quelles organisations appartient un individu ?
CREATE TABLE cor_indiv_orga (
    id_cor_indv_orga serial NOT NULL,
    id_organizations integer NOT NULL,
    id_individuals integer NOT NULL
);
COMMENT ON TABLE sch_reseau_acteur.cor_indiv_orga IS 'A quelles organisations appartient un individu ?';


-- Correspondance Organisation Equipement : 'A quelles organisations appartient un équipement ?'
CREATE TABLE cor_orga_equipments (
    id_cor_orga_equipments serial NOT NULL,
    id_organizations integer NOT NULL,
    id_equipments integer NOT NULL
);
COMMENT ON TABLE sch_reseau_acteur.cor_orga_equipments IS 'A quelles organisations appartient un équipement ?';


---------------
--PRIMARY KEY--
---------------
ALTER TABLE ONLY t_studies
    ADD CONSTRAINT pk_id_studies PRIMARY KEY (id_studies);

ALTER TABLE ONLY t_individuals
    ADD CONSTRAINT pk_id_individuals PRIMARY KEY (id_individuals);

ALTER TABLE ONLY t_studies_type
    ADD CONSTRAINT pk_id_studies_type PRIMARY KEY (id_studies_type);

ALTER TABLE ONLY t_organizations
    ADD CONSTRAINT pk_id_organizations PRIMARY KEY (id_organizations);

ALTER TABLE ONLY t_organization_type
    ADD CONSTRAINT pk_id_organization_type PRIMARY KEY (id_organization_type);

ALTER TABLE ONLY t_equipments
    ADD CONSTRAINT pk_id_equipments PRIMARY KEY (id_equipments);

ALTER TABLE ONLY t_thematics
    ADD CONSTRAINT pk_id_thematics PRIMARY KEY (id_thematics);

ALTER TABLE ONLY t_sites
    ADD CONSTRAINT pk_id_sites PRIMARY KEY (id_sites);

ALTER TABLE ONLY cor_studies_sites
    ADD CONSTRAINT pk_id_cor_studies_sites PRIMARY KEY (id_cor_studies_sites);

ALTER TABLE ONLY cor_indiv_studies
    ADD CONSTRAINT pk_id_individualsiv_studies PRIMARY KEY (id_individualsiv_studies);

ALTER TABLE ONLY cor_studies_thematics
    ADD CONSTRAINT pk_id_cor_studies_thematics PRIMARY KEY (id_cor_studies_thematics);

ALTER TABLE ONLY cor_organ_thematics
    ADD CONSTRAINT pk_id_cor_organ_thematic PRIMARY KEY (id_cor_organ_thematic);

ALTER TABLE ONLY cor_indiv_orga
    ADD CONSTRAINT pk_id_cor_indv_orga PRIMARY KEY (id_cor_indv_orga);

ALTER TABLE ONLY cor_orga_equipments
    ADD CONSTRAINT pk_id_cor_orga_equipments PRIMARY KEY (id_cor_orga_equipments);


---------------
--FOREIGN KEY--
---------------

ALTER TABLE ONLY t_studies
  ADD CONSTRAINT  fk_t_studies_id_studies_type FOREIGN KEY (id_studies_type) REFERENCES sch_reseau_acteur.t_studies_type (id_studies_type);

ALTER TABLE ONLY t_organizations
  ADD CONSTRAINT  fk_id_organization_type FOREIGN KEY (id_organization_type) REFERENCES sch_reseau_acteur.t_organization_type (id_organization_type);

ALTER TABLE ONLY cor_studies_sites
  ADD CONSTRAINT  fk_id_studies FOREIGN KEY (id_studies) REFERENCES sch_reseau_acteur.t_studies (id_studies);

ALTER TABLE ONLY cor_studies_sites
  ADD CONSTRAINT  fk_id_sites FOREIGN KEY (id_sites) REFERENCES sch_reseau_acteur.t_sites (id_sites);

ALTER TABLE ONLY cor_indiv_studies
  ADD CONSTRAINT  fk_id_studies FOREIGN KEY (id_studies) REFERENCES sch_reseau_acteur.t_studies (id_studies);

ALTER TABLE ONLY cor_indiv_studies
  ADD CONSTRAINT  fk_id_individuals FOREIGN KEY (id_individuals) REFERENCES sch_reseau_acteur.t_individuals (id_individuals);

ALTER TABLE ONLY cor_studies_thematics
  ADD CONSTRAINT  fk_id_studies FOREIGN KEY (id_studies) REFERENCES sch_reseau_acteur.t_studies (id_studies);

ALTER TABLE ONLY cor_studies_thematics
  ADD CONSTRAINT  fk_id_thematics FOREIGN KEY (id_thematics) REFERENCES sch_reseau_acteur.t_thematics (id_thematics);

ALTER TABLE ONLY cor_organ_thematics
  ADD CONSTRAINT  fk_id_thematics FOREIGN KEY (id_thematics) REFERENCES sch_reseau_acteur.t_thematics (id_thematics);

ALTER TABLE ONLY cor_organ_thematics
  ADD CONSTRAINT  fk_id_organizations FOREIGN KEY (id_organizations) REFERENCES sch_reseau_acteur.t_organizations (id_organizations);

ALTER TABLE ONLY cor_indiv_orga
  ADD CONSTRAINT  fk_id_organizations FOREIGN KEY (id_organizations) REFERENCES sch_reseau_acteur.t_organizations (id_organizations);

ALTER TABLE ONLY cor_indiv_orga
  ADD CONSTRAINT  fk_id_individuals FOREIGN KEY (id_individuals) REFERENCES sch_reseau_acteur.t_individuals (id_individuals);

ALTER TABLE ONLY cor_orga_equipments
  ADD CONSTRAINT  fk_id_organizations FOREIGN KEY (id_organizations) REFERENCES sch_reseau_acteur.t_organizations (id_organizations);

ALTER TABLE ONLY cor_orga_equipments
  ADD CONSTRAINT  fk_id_equipments FOREIGN KEY (id_equipments) REFERENCES sch_reseau_acteur.t_equipments (id_equipments);


--------------
--CONSTRAINS--
--------------
ALTER TABLE ONLY cor_studies_sites
    ADD CONSTRAINT unique_cor_studies_sites UNIQUE ( id_studies, id_sites );

ALTER TABLE ONLY cor_indiv_studies
    ADD CONSTRAINT unique_cor_indiv_studies UNIQUE ( id_studies, id_individuals );

ALTER TABLE ONLY cor_studies_thematics
    ADD CONSTRAINT unique_cor_studies_thematics UNIQUE ( id_studies, id_thematics );

ALTER TABLE ONLY cor_organ_thematics
    ADD CONSTRAINT unique_cor_organ_thematics UNIQUE ( id_organizations, id_thematics );

ALTER TABLE ONLY cor_orga_equipments
    ADD CONSTRAINT unique_cor_orga_equipments UNIQUE ( id_organizations, id_equipments );


---------
--INDEX--
---------