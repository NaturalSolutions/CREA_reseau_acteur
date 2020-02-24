# CREA reseau_acteur

## CREATE DATABASE AND SCHEMA
1- Copy sql file in tmp folder
```
cp data/bd_reseau_acteur.sql /tmp/bd_resaeu_acteur.sql
```
2- Connexion with postgres user
```
sudo -i -u postgres
```
3- Run psql
```
psql
```
4- Run sql script
```
\i /tmp/bd_resaeu_acteur.sql
```
