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
    filiere_id                      integer,
    academie_nom                    varchar(30),
    etablissement_code_uai          varchar(22),
    commune_nom                     varchar(20),
    session_annee                   varchar(4),

    constraint pk_formation primary key (cod_aff_form)
);



create table _type_bac (
    type_bac	varchar(20) 	not null,
	
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
    commune_nom 		varchar(20),
    region_nom          varchar(26),
	
    constraint pk_departement primary key (departement_code)
);



create table _region (
    region_nom varchar(26) not null, 				
	
    constraint pk_region primary key (region_nom)
);



create table _admissions_selon_type_neo_bac (
    effectif_candidat_neo_bac_classes	integer not null,
    cod_aff_form                        varchar(6),
    type_bac                            varchar(20),
    session_annee                       varchar(4),
	
    constraint pk_admissions_selon_type_neo_bac	primary key (cod_aff_form, type_bac, session_annee)
);

create table 




create table _academie (
    academie_nom	varchar(30),
	
    constraint pk_academie primary key (academie_nom)
);



create table _etablissement (
    etablissement_code_uai 	varchar(22),
    etablissement_nom 		varchar(8) not null,
    etablissement_statut 	varchar(32),
	
    constraint pk_etablissement primary key (etablissement_code_uai)
);



create table _filiere (
    filiere_id 						integer 		not null,
    filiere_libelle 				varchar(279), 					
    filiere_libelle_tres_abrege 	varchar(33), 					
    filiere_libelle_abrege 			varchar(66), 					
    filiere_libelle_detaille_bis 	varchar(335),
    constraint pk_filiere primary key (filiere_id)
);


create table _session (
    session_annee   varchar(4)    not null          
    constraint pk_session primary key (session_annee)
);

create table _regroupement (
    libelle_regroupement    varchar(68) not null,

    constraint pk_regroupement primary key (libelle_regroupement);
)

create table _rang_dernier_appele_selon_regroupement (
    rang_dernier_appele     integer not null,
    cod_aff_form            varchar(6),
    session_annee           integer,
    libelle_regroupement    varchar(68),
    constraint pk_rang_dernier_appele_selon_regroupement primary key (cod_aff_form, session_annee, libelle_regroupement)
);

create table _effectif_selon_mention (
    effectif_admis_neo_bac_selon_mention   integer,
    libelle_mention                        varchar(),
    
);

create table _mention_bac (
    libelle_mention     varchar(),
    constraint pk_mention_bac   primary key (libelle_mention)
);


/**********************
* Création des clefs étrangères *
**********************/

/*
Clefs étrangères de -formation 
*/

constraint fk_formation  foreign key _formation (filiere_id)  REFERENCES _filiere (filiere_id);
constraint fk2_formation foreign key _formation (academie_nom) REFERENCES _academie (academie_nom);
constraint fk3_formation foreign key _formation (etablissement_code_uai) REFERENCES _etablissement (etablissement_code_uai);
constraint fk4_formation foreign key _formation (commune_nom) REFERENCES _commune (commune_nom);
constraint fk5_formation foreign key _formation (session_annee) REFERENCES _session (session_annee);
/*
+ associations vers un losange
*/

/*
Clefs étrangères de _departement 
*/

constraint fk_departement foreign key _departement (commune_nom) REFERENCES _commune (commune_nom);
constraint fk2_departement foreign key _departement (region_nom) REFERENCES _region (region_nom);

/*
Clefs étrangères de _admissions_selon_type_neo_bac
*/

constraint fk1_admissions_selon_type_neo_bac foreign key _admissions_selon_type_neo_bac (cod_aff_form) REFERENCES _formation (cod_aff_form);
constraint fk1_admissions_selon_type_neo_bac foreign key _admissions_selon_type_neo_bac (type_bac) REFERENCES _type_bac (type_bac);
constraint fk1_admissions_selon_type_neo_bac foreign key _admissions_selon_type_neo_bac (session_annee) REFERENCES _session (session_annee);

/*
Clefs étrangères de _rang-dernier_appele-selon_regroupement
*/

constraint fk_rang_dernier_appele_selon_regroupement foreign key _rang_dernier_appele_selon_regroupement (cod_aff_form) REFERENCES _formation (cod_aff_form);
constraint fk_rang_dernier_appele_selon_regroupement foreign key _rang_dernier_appele_selon_regroupement (libelle_regroupement) REFERENCES _regroupement (libelle_regroupement);
constraint fk_rang_dernier_appele_selon_regroupement foreign key _rang_dernier_appele_selon_regroupement (session_annee) REFERENCES _session (session_annee)






