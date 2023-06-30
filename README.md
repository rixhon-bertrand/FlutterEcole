
# RestoMag
> Projet d’examen 2022-2023

RestoMag est une application développée dans le cadre d'un projet scolaire pour le cours de développement mobile.

## :iphone: Description de l'application
L'objectif de l'application répond à un besoin réel. Un restaurant aimerait gérer des fiches clients et les réservations de ces derniers afin de pouvoir calculer leur panier moyen et( à terme ) envoyer des mails promotionnels en fonction des habitudes de ces derniers.
Cette application permettra l'encodage et la recherche des fiches clients ainsi que leurs réservations.
## :telescope: Analyse de l'existant
L'existant belge pour ce genre de chose n'est pas mince.
### Zenchef
<img src="https://user-images.githubusercontent.com/60699212/210029260-e98064f9-3d29-448c-aa16-b51b8e6a9de3.png" width="300" height="120">\
:link: https://www.zenchef.com/ \
Zenchef permet de gérer les réservations de ses clients et indirectement leurs fiches mais il ne permet pas d'ajouter de personnalier ses fiches clients. S'il nous manque une colonne alors on doit ajouter les informations dans un champ "note" et c'est un pêle-mêle difficile à utiliser. Il est également difficile de gérer le principe de panier moyen sur cette application.
### Odoo
<img src="https://user-images.githubusercontent.com/60699212/210029261-8d01b545-b2f7-44b1-8a2c-48b8da0e21fb.png" width="300" height="120">\
:link: https://www.odoo.com/fr_FR \
Odoo est un outil très puissant qui permet quasiment tout. Il est très paramétrable pour celui qui sait coder mais pas pour monsieur tout le monde. Il devra alors obligatoirement passer par un assistant Odoo.Cette plateforme commence vraiment à s'intéresser aux petites entreprises et aux restaurants maintenant.\
Dans notre cas, le restaurant veut être indépendant de toute plateforme mais veut s'inspirer de ces dernières.

## :world_map: Site Map

## :wrench: Fonctionnalité de l'application
**En tant qu'employé** du restaurant, je dois me connecter pour accéder à l'application.\
<img src="https://user-images.githubusercontent.com/60699212/210028341-34ae8765-32a3-486c-bdc1-93e37bc2297d.gif" width="300">\
**En tant qu'employé** du restaurant, je peux créer et compléter la fiche client.\
<img src="https://user-images.githubusercontent.com/60699212/210028337-eba81275-0930-488c-bff9-0cc31837ac60.gif" width="300">\
**En tant qu'employé** du restaurant, je peux créer et compléter la réservation d'un client.\
<img src="https://user-images.githubusercontent.com/60699212/210028338-4fb5eb96-fafe-463a-9711-c2b911f4b9b4.gif" width="300">\
**En tant qu'employé** du restaurant, je peux récupérer toutes les informations d'un client.\
<img src="https://user-images.githubusercontent.com/60699212/210028343-ee2776f4-8f9b-4e0f-90d1-af02c6dbb83f.gif" width="300">
## :file_folder: Les fichiers
Pour la base de donnée, nous avons opté pour le système de Google nommé Firebase et Firestore.\
<img src="https://user-images.githubusercontent.com/60699212/210029259-4a09d896-dc80-4cfc-9ad4-479512fad195.png" width="150" height="120">\
Nous avons 2 types de documents qui peuvent être vu comme des tables : \
Une collection de documents clients :\
<img src="https://user-images.githubusercontent.com/60699212/210029264-3efd0257-9995-4ede-b2f1-6f91bf971f12.png" width="300" height="120">\
Une collection de documents réservations :\
<img src="https://user-images.githubusercontent.com/60699212/210029265-09b493a3-0a52-40c6-a86a-f2a578d435a8.png" width="300" height="120">\
Les réservations sont liés au client par une relation 1-N et c'est pour ça que le numéro de téléphone du client se retrouve également dans le document de la réservation.
