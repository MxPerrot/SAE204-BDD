/*
* Path : https://github.com/MxPerrot/SAE204-BDD/blob/main/Livrables/parcoursup_db_create.sql
* Script SQL de création d'une base de données type de Parcoursup 
* IUT de Lannion
* BUT Informatique - Semestre 2
* SAÉ 2.04 : Exploitation d'une base de données
* Timéo Tribotté & Maxime Perrot, I1E1
*/

/*********************
* Création du schéma *
*********************/

drop schema if exists parcoursup cascade; 
create schema parcoursup;
set schema parcoursup;

/**********************
* Création des tables *
**********************/

create table _formation (
	cod_aff_form					varchar(6)		not null,
	filiere_libelle_detaille		varchar(335),
	coordonnees_gps					varchar(20),
	list_com						varchar(44),
	concours_communs_banque_epreuve	varchar(98),
	url_formation					varchar(91),
	tri								varchar(25),
	filiere_id						integer,
	academie_nom					varchar(30),
	etablissement_code_uai			varchar(22),
	commune_nom						varchar(20),
	session_annee					integer,

	constraint pk_formation primary key (cod_aff_form)
);

create table _type_bac (
	type_bac		varchar(20)		not null,
	cod_aff_form	varchar(6),
	session_annee	integer,

	constraint pk_type_bac primary key (type_bac)
);

create table _commune (
	commune_nom			varchar(20)	not null,
	departement_code	varchar(3)	not null,
	cod_aff_form		varchar(6),
	
	constraint pk_commune primary key (departement_code, cod_aff_form)
);

create table _departement (
	departement_code	varchar(3)	not null,
	departement_nom		varchar(23),
	commune_nom			varchar(20),
	region_nom			varchar(26),
	
	constraint pk_departement primary key (departement_code)
);

create table _region (
	region_nom varchar(26) not null,
	
	constraint pk_region primary key (region_nom)
);

create table _admissions_selon_type_neo_bac (
	effectif_candidat_neo_bac_classes	integer not null,
	cod_aff_form						varchar(6),
	type_bac							varchar(20),
	session_annee						integer,
	
	constraint pk_admissions_selon_type_neo_bac	primary key (cod_aff_form, type_bac, session_annee)
);

create table _academie (
	academie_nom	varchar(30),
	
	constraint pk_academie primary key (academie_nom)
);

create table _etablissement (
	etablissement_code_uai	varchar(22),
	etablissement_nom		varchar(8) not null,
	etablissement_statut	varchar(32),
	
	constraint pk_etablissement primary key (etablissement_code_uai)
);

create table _filiere (
	filiere_id						integer			not null,
	filiere_libelle					varchar(279),
	filiere_libelle_tres_abrege		varchar(33),
	filiere_libelle_abrege			varchar(66),
	filiere_libelle_detaille_bis	varchar(335),
	
	constraint pk_filiere primary key (filiere_id)
);

create table _session (
	session_annee			integer	   not null,
	libelle_regroupement	varchar(68),
	cod_aff_form			varchar(6),
	type_bac				varchar(20),
	libelle_mention			varchar(255),
	
	constraint pk_session primary key (session_annee)
);

create table _regroupement (
	libelle_regroupement	varchar(68) not null,
	cod_aff_form			varchar(6),
	session_annee			integer,
	
	constraint pk_regroupement primary key (libelle_regroupement)
);

create table _rang_dernier_appele_selon_regroupement (
	rang_dernier_appele		integer not null,
	cod_aff_form			varchar(6),
	session_annee			integer,
	libelle_regroupement	varchar(68),
	
	constraint pk_rang_dernier_appele_selon_regroupement primary key (cod_aff_form, session_annee, libelle_regroupement)
);

create table _effectif_selon_mention (
	effectif_admis_neo_bac_selon_mention	integer	not null,
	libelle_mention							varchar(255),
	cod_aff_form							varchar(6),
	session_annee							integer,
	
	constraint pk_effectif_admis_neo_bac_selon_mention primary key (libelle_mention, cod_aff_form, session_annee)
);

create table _mention_bac (
	libelle_mention	varchar(255),
	
	constraint pk_mention_bac	primary key (libelle_mention)
);

create table _admissions_generalites (
	selectivite					varchar(25) not null,
	capacite					integer,
	effectif_total_candidats	integer,
	effectif_total_candidates	integer,
	cod_aff_form				varchar(6),
	session_annee				integer,
	
	constraint pk_admissions_generalites primary key (cod_aff_form, session_annee)
);

/********************************
* Création des clefs étrangères *
********************************/

-- _formation
alter table _formation	add constraint fk_formation_filiere			foreign key (filiere_id)				REFERENCES _filiere (filiere_id);
alter table _formation	add constraint fk_formation_academie		foreign key (academie_nom)				REFERENCES _academie (academie_nom);
alter table _formation	add constraint fk_formation_etablissement	foreign key (etablissement_code_uai)	REFERENCES _etablissement (etablissement_code_uai);
alter table _formation	add constraint fk_formation_session			foreign key (session_annee)				REFERENCES _session (session_annee);

-- _departement
alter table _departement add constraint fk_departement_region foreign key (region_nom) REFERENCES _region (region_nom);

-- _admissions_selon_type_neo_bac
alter table _admissions_selon_type_neo_bac	add constraint	fk_admissions_selon_type_neo_bac_formation		foreign key (cod_aff_form)	REFERENCES	_formation (cod_aff_form);
alter table _admissions_selon_type_neo_bac	add constraint	fk_admissions_selon_type_neo_bac_type_bac		foreign key (type_bac)		REFERENCES	_type_bac (type_bac);
alter table _admissions_selon_type_neo_bac	add constraint	fk_admissions_selon_type_neo_bac_session_annee	foreign key (session_annee)	REFERENCES _session (session_annee);

-- _rang_dernier_appele_selon_regroupement
alter table _rang_dernier_appele_selon_regroupement add constraint fk_rang_dernier_appele_selon_regroupement_formation		foreign key (cod_aff_form)			REFERENCES _formation (cod_aff_form);
alter table _rang_dernier_appele_selon_regroupement add constraint fk_rang_dernier_appele_selon_regroupement_regroupement	foreign key (libelle_regroupement)	REFERENCES _regroupement (libelle_regroupement);
alter table _rang_dernier_appele_selon_regroupement add constraint fk_rang_dernier_appele_selon_regroupement_session		foreign key (session_annee)			REFERENCES _session (session_annee);

-- _effectif_selon_mention
alter table _effectif_selon_mention add constraint fk_effectif_selon_mention_formation		foreign key (cod_aff_form)		REFERENCES _formation (cod_aff_form);
alter table _effectif_selon_mention add constraint fk_effectif_selon_mention_session		foreign key (session_annee )	REFERENCES _session (session_annee);
alter table _effectif_selon_mention add constraint fk_effectif_selon_mention_mention_bac	foreign key (libelle_mention)	REFERENCES _mention_bac (libelle_mention);

-- _session
alter table _session add constraint fk_session_formation	foreign key (cod_aff_form)			REFERENCES _formation (cod_aff_form);
alter table _session add constraint fk_session_mention_bac	foreign key (libelle_mention)		REFERENCES _mention_bac (libelle_mention);
alter table _session add constraint fk_session_regroupement	foreign key (libelle_regroupement)	REFERENCES _regroupement (libelle_regroupement);
alter table _session add constraint fk_session_type_bac		foreign key (type_bac)				REFERENCES _type_bac (type_bac);

-- _type_bac
alter table _type_bac add constraint fk_type_bac_formation	foreign key (cod_aff_form)	REFERENCES _formation (cod_aff_form);
alter table _type_bac add constraint fk_type_bac_session	foreign key (session_annee)	REFERENCES _session (session_annee);

-- _regroupement
alter table _regroupement add constraint fk_regroupement_formation	foreign key (cod_aff_form)	REFERENCES _formation (cod_aff_form);
alter table _regroupement add constraint fk_regroupement_session	foreign key (session_annee)	REFERENCES _session (session_annee);
