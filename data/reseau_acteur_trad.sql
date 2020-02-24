SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;


-- CONNECT DATABASE
-- \connect reseau_acteur;


------------
-- Schema --
------------
-- DROP SCHEMA sch_reseau_acteur_trad CASCADE;
CREATE SCHEMA sch_reseau_acteur_trad;


SET search_path = sch_reseau_acteur_trad, sch_reseau_acteur, pg_catalog, public;

SET default_with_oids = false;


-----------
-- Grant --
-----------


GRANT ALL ON SCHEMA sch_reseau_acteur_trad to crea;


------------
-- Tables --
------------

CREATE TABLE sch_reseau_acteur_trad.t_languages (
    code_language character varying(6) NOT NULL,
    name character varying(50)
);
COMMENT ON TABLE sch_reseau_acteur_trad.t_languages IS 'Enregistrement des langues disponibles.';


CREATE TABLE sch_reseau_acteur_trad.t_studies_type_translations (
    id_studies_type_translations serial NOT NULL,
    id_studies_type integer NOT NULL,
    code_language character varying(6) NOT NULL,
    label_default character varying(50)
);
COMMENT ON TABLE sch_reseau_acteur_trad.t_studies_type_translations IS 'Enregistrement des traductions pour la table t_studies_type.';


CREATE TABLE sch_reseau_acteur_trad.t_thematics_translations (
    id_thematics_translations serial NOT NULL,
    id_thematics integer NOT NULL,
    code_language character varying(6) NOT NULL,
    label_default character varying(50)
);
COMMENT ON TABLE sch_reseau_acteur_trad.t_thematics_translations IS 'Enregistrement des traductions pour la table t_thematics.';


CREATE TABLE sch_reseau_acteur_trad.t_studies_translations (
    id_studies_translations serial NOT NULL,
    id_studies integer NOT NULL,
    code_language character varying(6) NOT NULL,
    name character varying(50),
    title character varying(255),
    resume text,
    url character varying(255),
    status character varying(25),
    comments text
);
COMMENT ON TABLE sch_reseau_acteur_trad.t_studies_translations IS 'Enregistrement des traductions pour la table t_studies.';


CREATE TABLE sch_reseau_acteur_trad.t_individuals_translations (
    id_individuals_translations serial NOT NULL,
    id_individuals integer NOT NULL,
    code_language character varying(6) NOT NULL,
    position character varying(250),
    nationality character varying(50),
    comments text
);
COMMENT ON TABLE sch_reseau_acteur_trad.t_individuals_translations IS 'Enregistrement des traductions pour la table t_individuals.';


CREATE TABLE sch_reseau_acteur_trad.t_organization_type_translations (
    id_organization_type_translations serial NOT NULL,
    id_organization_type integer NOT NULL,
    code_language character varying(6) NOT NULL,
    label_default character varying(50)
);
COMMENT ON TABLE sch_reseau_acteur_trad.t_organization_type_translations IS 'Enregistrement des traductions pour la table t_organization_type.';

CREATE TABLE sch_reseau_acteur_trad.t_organizations_translations (
    id_organizations_translations serial NOT NULL,
    id_organizations integer NOT NULL,
    code_language character varying(6) NOT NULL,
    acronym character varying(25)
);
COMMENT ON TABLE sch_reseau_acteur_trad.t_organizations_translations IS 'Enregistrement des traductions pour la table t_organizations.';


CREATE TABLE sch_reseau_acteur_trad.t_equipments_translations (
    id_equipments_translations serial NOT NULL,
    id_equipments integer NOT NULL,
    code_language character varying(6) NOT NULL,
    url character varying(255),
    city character varying(50),
    site_desc text,
    comments text
);
COMMENT ON TABLE sch_reseau_acteur_trad.t_equipments_translations IS 'Enregistrement des traductions pour la table t_equipments.';


CREATE TABLE sch_reseau_acteur_trad.t_sites_translations (
    id_sites_translations serial NOT NULL,
    id_sites integer NOT NULL,
    code_language character varying(6) NOT NULL,
    description text,
    country character varying(50),
    city character varying(50)
);
COMMENT ON TABLE sch_reseau_acteur_trad.t_sites_translations IS 'Enregistrement des traductions pour la table t_sites.';


---------------------
--CONSTRAINS UNIQUE--
---------------------
ALTER TABLE ONLY sch_reseau_acteur_trad.t_languages
    ADD CONSTRAINT unique_t_languages UNIQUE ( code_language );

ALTER TABLE ONLY sch_reseau_acteur_trad.t_studies_type_translations
    ADD CONSTRAINT unique_t_studies_type_translations UNIQUE ( id_studies_type, code_language );

ALTER TABLE ONLY sch_reseau_acteur_trad.t_thematics_translations
    ADD CONSTRAINT unique_t_thematics_translations UNIQUE ( id_thematics, code_language );

ALTER TABLE ONLY sch_reseau_acteur_trad.t_studies_translations
    ADD CONSTRAINT unique_t_studies_translations UNIQUE ( id_studies, code_language );

ALTER TABLE ONLY sch_reseau_acteur_trad.t_individuals_translations
    ADD CONSTRAINT unique_t_individuals_translations UNIQUE ( id_individuals, code_language );

ALTER TABLE ONLY sch_reseau_acteur_trad.t_organization_type_translations
    ADD CONSTRAINT unique_t_organization_type_translations UNIQUE ( id_organization_type, code_language );

ALTER TABLE ONLY sch_reseau_acteur_trad.t_organizations_translations
    ADD CONSTRAINT unique_t_organizations_translations UNIQUE ( id_organizations, code_language );

ALTER TABLE ONLY sch_reseau_acteur_trad.t_equipments_translations
    ADD CONSTRAINT unique_t_equipments_translations UNIQUE ( id_equipments, code_language );

ALTER TABLE ONLY sch_reseau_acteur_trad.t_sites_translations
    ADD CONSTRAINT unique_t_sites_translations UNIQUE ( id_sites, code_language );


---------------
--PRIMARY KEY--
---------------
ALTER TABLE ONLY sch_reseau_acteur_trad.t_languages
    ADD CONSTRAINT pk_id_t_languages PRIMARY KEY (code_language);

ALTER TABLE ONLY sch_reseau_acteur_trad.t_studies_type_translations
    ADD CONSTRAINT pk_id_studies_type_translations PRIMARY KEY (id_studies_type_translations);

ALTER TABLE ONLY sch_reseau_acteur_trad.t_thematics_translations
    ADD CONSTRAINT pk_id_thematics_translations PRIMARY KEY (id_thematics_translations);

ALTER TABLE ONLY sch_reseau_acteur_trad.t_studies_translations
    ADD CONSTRAINT pk_id_studies_translations PRIMARY KEY (id_studies_translations);

ALTER TABLE ONLY sch_reseau_acteur_trad.t_individuals_translations
    ADD CONSTRAINT pk_id_individuals_translations PRIMARY KEY (id_individuals_translations);

ALTER TABLE ONLY sch_reseau_acteur_trad.t_organization_type_translations
    ADD CONSTRAINT pk_id_organization_type_translations PRIMARY KEY (id_organization_type_translations);

ALTER TABLE ONLY sch_reseau_acteur_trad.t_organizations_translations
    ADD CONSTRAINT pk_id_organizations_translations PRIMARY KEY (id_organizations_translations);

ALTER TABLE ONLY sch_reseau_acteur_trad.t_equipments_translations
    ADD CONSTRAINT pk_id_equipments_translations PRIMARY KEY (id_equipments_translations);

ALTER TABLE ONLY sch_reseau_acteur_trad.t_sites_translations
    ADD CONSTRAINT pk_id_sites_translations PRIMARY KEY (id_sites_translations);


---------------
--FOREIGN KEY--
---------------
ALTER TABLE ONLY sch_reseau_acteur_trad.t_studies_type_translations
    ADD CONSTRAINT fk_t_studies_type_translations_code_language FOREIGN KEY (code_language) REFERENCES sch_reseau_acteur_trad.t_languages (code_language);
ALTER TABLE ONLY sch_reseau_acteur_trad.t_studies_type_translations
  ADD CONSTRAINT  fk_t_studies_type_translations_id_studies_type FOREIGN KEY (id_studies_type) REFERENCES sch_reseau_acteur.t_studies_type (id_studies_type);

ALTER TABLE ONLY sch_reseau_acteur_trad.t_thematics_translations
    ADD CONSTRAINT fk_t_thematics_translations_code_language FOREIGN KEY (code_language) REFERENCES sch_reseau_acteur_trad.t_languages (code_language);
ALTER TABLE ONLY sch_reseau_acteur_trad.t_thematics_translations
  ADD CONSTRAINT  fk_t_thematics_translations_id_thematics FOREIGN KEY (id_thematics) REFERENCES sch_reseau_acteur.t_thematics (id_thematics);

ALTER TABLE ONLY sch_reseau_acteur_trad.t_studies_translations
    ADD CONSTRAINT fk_t_studies_translations_code_language FOREIGN KEY (code_language) REFERENCES sch_reseau_acteur_trad.t_languages (code_language);
ALTER TABLE ONLY sch_reseau_acteur_trad.t_studies_translations
  ADD CONSTRAINT  fk_t_studies_translations_id_studies FOREIGN KEY (id_studies) REFERENCES sch_reseau_acteur.t_studies (id_studies);

ALTER TABLE ONLY sch_reseau_acteur_trad.t_individuals_translations
    ADD CONSTRAINT fk_t_individuals_translations_code_language FOREIGN KEY (code_language) REFERENCES sch_reseau_acteur_trad.t_languages (code_language);
ALTER TABLE ONLY sch_reseau_acteur_trad.t_individuals_translations
  ADD CONSTRAINT  fk_t_individuals_translations_id_individuals FOREIGN KEY (id_individuals) REFERENCES sch_reseau_acteur.t_individuals (id_individuals);

ALTER TABLE ONLY sch_reseau_acteur_trad.t_organization_type_translations
    ADD CONSTRAINT fk_t_organization_type_translations_code_language FOREIGN KEY (code_language) REFERENCES sch_reseau_acteur_trad.t_languages (code_language);
ALTER TABLE ONLY sch_reseau_acteur_trad.t_organization_type_translations
  ADD CONSTRAINT  fk_t_organization_type_translations_id_organization_type FOREIGN KEY (id_organization_type) REFERENCES sch_reseau_acteur.t_organization_type (id_organization_type);

ALTER TABLE ONLY sch_reseau_acteur_trad.t_organizations_translations
    ADD CONSTRAINT fk_t_organizations_translations_code_language FOREIGN KEY (code_language) REFERENCES sch_reseau_acteur_trad.t_languages (code_language);
ALTER TABLE ONLY sch_reseau_acteur_trad.t_organizations_translations
  ADD CONSTRAINT  fk_t_organizations_translations_id_organizations FOREIGN KEY (id_organizations) REFERENCES sch_reseau_acteur.t_organizations (id_organizations);

ALTER TABLE ONLY sch_reseau_acteur_trad.t_equipments_translations
    ADD CONSTRAINT fk_t_equipments_translations_code_language FOREIGN KEY (code_language) REFERENCES sch_reseau_acteur_trad.t_languages (code_language);
ALTER TABLE ONLY sch_reseau_acteur_trad.t_equipments_translations
  ADD CONSTRAINT  fk_t_equipments_translations_id_equipments FOREIGN KEY (id_equipments) REFERENCES sch_reseau_acteur.t_equipments (id_equipments);

ALTER TABLE ONLY sch_reseau_acteur_trad.t_sites_translations
    ADD CONSTRAINT fk_t_sites_translations_code_language FOREIGN KEY (code_language) REFERENCES sch_reseau_acteur_trad.t_languages (code_language);
ALTER TABLE ONLY sch_reseau_acteur_trad.t_sites_translations
  ADD CONSTRAINT  fk_t_sites_translations_id_sites FOREIGN KEY (id_sites) REFERENCES sch_reseau_acteur.t_sites (id_sites);



-----------
-- Grant --
-----------

GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA sch_reseau_acteur_trad to crea;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA sch_reseau_acteur to crea;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA sch_reseau_acteur_trad to crea;