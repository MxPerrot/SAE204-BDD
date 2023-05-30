# SAE204-BDD

SAÉ 2.04 Exploitation d'une base de données

L’objectif de ce projet est d'implanter, peupler puis exploiter une base de données réaliste

## Collaborateurs

[Maxime Perrot](https://github.com/mxPerrot)

[Timéo Tribotté](https://github.com/Huntshi)

## Planning

Date | Evenement | Fait
-|-|-
2023-05-03 16:45 | Début de la SAE | ✔️
2023-05-19 18:00 | Implémentation BDD dans schéma `parcoursup` (à créer) sur la base `pg_sae204_e13` | ✔️
2023-05-19 18:00 | Fichier `parcoursub_db_create.sql` à rendre sur l'ENT<br> | ✔️
2023-06-02 18:00 | Peuplement de la base `parcoursup2` | ❌
2023-06-02 18:00 | Fichier `populate_parcoursup2_db.sql` à rendre sur l'ENT | ❌

## Notes

* Utiliser `MAX(NBCAR(C2:C13665))` *par exemple* pour trouver le nombre de caractères maximum d'une colonne (ici C)
* Mettre les contraintes juste après le `create table`
* Pour le peuplement `insert into _filiere (filiere_libelle, ..., ...bis) select distinct filiere_libelle, ...., ...bis) from import_date;`
* Optimiser les select import de types en une ligne avec des virgules si possible.
