/*
* Path : https://github.com/MxPerrot/SAE204-BDD/blob/main/Livrables/parcoursup_db_create.sql
* Description : Script SQL de création d'une base de données type de Parcoursup 
* IUT de Lannion
* BUT Informatique - Semestre 2
* SAÉ 2.04 : Exploitation d'une base de données
* Timéo Tribotté & Maxime Perrot, I1E1
*/



/********
* Notes *
********/

/*
* On évite de mettre les mdp dans des gits publics !
* Mail du prof : hamzaamara@univ-rennes1.fr       
*/



/*********************
* Création du schéma *
*********************/

drop schema if exists parcoursup; -- A verifier, la syntaxe est peut-être mauvaise
create schema parcoursup;



/**********************
* Création des tables *
**********************/

create table _formation (
    cod_aff_form 					varchar(6)		not null,
    filiere_libelle_detaille 		varchar(335),
    coordonnees_gps 				varchar(20),
    list_com 						varchar(44),
    concours_communs_banque_epreuve varchar(98),
    url_formation 					varchar(91),
    tri 							varchar(25),
	
    constraint pk_formation primary key (cod_aff_form)
);



create table _type_bac (
    type_bac	varchar 	not null(20),			-- Spécifier taille varchar
	
    constraint pk_type_bac primary key (type_bac)
);



create table _commune (
    commune_nom 		varchar(20)	not null,
    departement_code 	varchar(3) 	not null,
	
    constraint pk_commune primary key (commune_nom, departement_code)
);



create table _departement (
    departement_code 	varchar(3) 	not null,
    departement_nom 	varchar(23),
	
    constraint pk_departement primary key (departement_code)
);



create table _region (
    region_nom varchar not null(26), 				-- Spécifier taille varchar
	
    constraint pk_region primary key (region_nom)
);



create table _admissions_selon_type_neo_bac (
    effectif_candidat_neo_bac_classes	integer,
	
    constraint pk_admissions_selon_type_neo_bac	primary key (effectif_candidat_neo_bac_classes)
);



create table _academie (
    academie_nom	varchar(30)
	
    constraint pk_academie primary key (academie_nom)
);



create table _etablissement (
    etablissement_code_uai 	varchar(22),
    etablissement_nom 		varchar(8),
    etablissement_statut 	varchar(32),
	
    constraint pk_etablissement 
);



create table _filiere (
    filiere_id 						integer 		not null,
    filiere_libelle 				varchar(), 					-- Spécifier taille varchar
    filiere_libelle_tres_abrege 	varchar(), 					-- Spécifier taille varchar
    filiere_libelle_abrege 			varchar(), 					-- Spécifier taille varchar
    filiere_libelle_detaille_bis 	varchar(335),
    constraint pk_filiere primary key (filiere_id)
);

