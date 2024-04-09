--  TP1 fichier r�ponse
--  Votre nom: David Nakhle        
--  Votre DA:2374461
--  ASSUREZ VOUS DE LA BONNE LISIBILIT� DE VOS REQU�TES  /5

-- 1.   R�digez la requ�te qui affiche la description pour les trois tables. Le nom des champs et leur type. /2
DESC OUTILS_OUTIL;
desc outils_emprunt;
desc outils_usager;

-- 2.   R�digez la requ�te qui affiche la liste de tous les usagers, sous le format pr�nom � espace � nom de famille (indice : concat�nation). /2
SELECT concat(prenom, ' ', nom_famille) 
FROM outils_usager;
WHERE AS "Nom complet"
-- 3.   R�digez la requ�te qui affiche le nom des villes o� habitent les usagers, en ordre alphab�tique, le nom des villes va appara�tre seulement une seule fois. /2
SELECT DISTINCT ville 
FROM outils_usager
ORDER BY ville;

-- 4.   R�digez la requ�te qui affiche toutes les informations sur tous les outils en ordre alphab�tique sur le nom de l�outil puis sur le code. /2
SELECT *
FROM outils_outil
ORDER BY nom, code_outil;

-- 5.   R�digez la requ�te qui affiche le num�ro des emprunts qui n�ont pas �t� retourn�s. /2
SELECT num_emprunt AS "Numero d'emprunt"
FROM outils_emprunt
WHERE date_retour IS NULL;

-- 6.   R�digez la requ�te qui affiche le num�ro des emprunts faits avant 2014./3
SELECT num_emprunt  AS "Num�ro d'emprunt",
       date_emprunt AS "Date d'emprunt"
FROM outils_emprunt
WHERE date_emprunt < '1-Jan-14';        
-- 7.   R�digez la requ�te qui affiche le nom et le code des outils dont la couleur d�but par la lettre � j � (indice : utiliser UPPER() et LIKE) /3
SELECT nom              AS "Nom de l'outil",
       code_outil       AS "Num�ro de l'outil",
       caracteristiques AS "Caract�ristique"
FROM outils_outil
WHERE upper(caracteristiques) LIKE ( '%J%' );
-- 8.   R�digez la requ�te qui affiche le nom et le code des outils fabriqu�s par Stanley. /2
SELECT code_outil AS "Num�ro de l'outil",
       nom        AS "Nom de l'outil",
       fabricant  AS fabricant
FROM outils_outil
WHERE upper(fabricant) LIKE 'STANLEY';
-- 9.   R�digez la requ�te qui affiche le nom et le fabricant des outils fabriqu�s de 2006 � 2008 (ANNEE). /2
SELECT code_outil AS "Num�ro de l'outil",
       nom        AS "Nom de l'outil",
       fabricant  AS fabricant,
       annee      AS "Ann�e"
FROM outils_outil
WHERE annee BETWEEN 2006 AND 2008;
-- 10.  R�digez la requ�te qui affiche le code et le nom des outils qui ne sont pas de � 20 volts �. /3
SELECT code_outil       AS "Num�ro de l'outil",
       nom              AS "Nom de l'outil",
       caracteristiques AS "Caract�ristique"
FROM outils_outil
WHERE caracteristiques NOT LIKE ( '%20 volt%' );
-- 11.  R�digez la requ�te qui affiche le nombre d�outils qui n�ont pas �t� fabriqu�s par Makita. /2
SELECT code_outil AS "Num�ro de l'outil",
       nom        AS "Nom de l'outil",
       fabricant  AS fabricant
FROM outils_outil
WHERE fabricant NOT LIKE ( 'Makita' );
-- 12.  R�digez la requ�te qui affiche les emprunts des clients de Vancouver et Regina. Il faut afficher le nom complet de l�usager, le num�ro d�emprunt, la dur�e de l�emprunt et le prix de l�outil (indice : n�oubliez pas de traiter le NULL possible (dans les dates et le prix) et utilisez le IN). /5
SELECT concat(u.prenom, ' ', u.nom_famille) AS "Nom complet",
       u.num_usager                         AS "Num�ro d'usager",
       e.num_emprunt                        AS "Num�ro d'emprunt",
       o.prix,
       e.date_emprunt                         AS "Date d'emprunt",
       e.date_retour                          AS "Date de retour",
       u.ville
FROM outils_usager u
INNER JOIN outils_emprunt e 
ON u.num_usager = e.num_usager
INNER JOIN outils_outil o 
ON e.code_outil = o.code_outil
WHERE date_retour is not null and PRIX is not null and ville in('Vancouver');
-- 13.  R�digez la requ�te qui affiche le nom et le code des outils emprunt�s qui n�ont pas encore �t� retourn�s. /4
SELECT concat(u.prenom, ' ', u.nom_famille) AS "Nom complet",
       e.code_outil AS "Code d'outil",
       e.date_emprunt                         AS "Date d'emprunt",
       e.date_retour                          AS "Date de retour"
FROM outils_usager u
INNER JOIN outils_emprunt e 
ON u.num_usager = e.num_usager
WHERE date_retour IS NULL ;
-- 14.  R�digez la requ�te qui affiche le nom et le courriel des usagers qui n�ont jamais fait d�emprunts. (indice : IN avec sous-requ�te) /3
SELECT DISTINCT concat(u.prenom, ' ', u.nom_famille) AS "Nom complet",
                u.courriel
FROM outils_usager u
LEFT JOIN outils_emprunt e
ON u.num_usager = e.num_usager
WHERE u.num_usager NOT IN (SELECT num_usager
                           FROM outils_emprunt);
-- 15.  R�digez la requ�te qui affiche le code et la valeur des outils qui n�ont pas �t� emprunt�s. (indice : utiliser une jointure externe � LEFT OUTER, aucun NULL dans les nombres) /4
SELECT DISTINCT o.code_outil,
                o.prix
FROM outils_outil o
LEFT OUTER JOIN outils_emprunt e
ON o.code_outil=e.code_outil
WHERE o.code_outil NOT IN(SELECT code_outil FROM outils_emprunt) AND prix IS NOT NULL;
-- 16.  R�digez la requ�te qui affiche la liste des outils (nom et prix) qui sont de marque Makita et dont le prix est sup�rieur � la moyenne des prix de tous les outils. Remplacer les valeurs absentes par la moyenne de tous les autres outils. /4
SELECT o.nom ,
       o.prix
FROM outils_outil o
GROUP BY nom,prix,fabricant
HAVING upper(fabricant) LIKE 'MAKITA' AND prix>(SELECT AVG(NVL(prix, AVG(prix)))
FROM outils_outil o
GROUP BY o.prix);
-- 17.  R�digez la requ�te qui affiche le nom, le pr�nom et l�adresse des usagers et le nom et le code des outils qu�ils ont emprunt�s apr�s 2014. Tri�s par nom de famille. /4
SELECT u.nom_famille AS "Nom de famille",
       u.prenom AS Prenom,
       u.adresse,
       o.code_outil,
       o.nom AS "Nom de l'outil"
FROM outils_usager u
Join outils_emprunt e
ON u.num_usager=e.num_usager
JOIN outils_outil o
ON e.code_outil=o.code_outil
WHERE e.date_emprunt>'31-DEC-14'
ORDER BY u.nom_famille;
-- 18.  R�digez la requ�te qui affiche le nom et le prix des outils qui ont �t� emprunt�s plus qu�une fois. /4
SELECT o.nom AS "Nom de l'outil",
       o.prix
FROM outils_outil o
JOIN outils_emprunt e
ON o.code_outil=e.code_outil
GROUP BY e.code_outil,o.nom,o.prix
HAVING COUNT(e.code_outil)>=2
;
-- 19.  R�digez la requ�te qui affiche le nom, l�adresse et la ville de tous les usagers qui ont fait des emprunts en utilisant : /6

--  Une jointure
SELECT DISTINCT concat(prenom, ' ',nom_famille) AS "Nom complet",
       adresse,
       ville
FROM outils_usager u
INNER JOIN outils_emprunt e
ON u.num_usager=e.num_usager;
--  IN
SELECT concat(prenom, ' ',nom_famille) AS "Nom complet",
       adresse,
       ville
FROM outils_usager u
Where u.num_usager IN(SELECT e.num_usager FROM outils_emprunt e);
--  EXISTS
SELECT concat(prenom, ' ',nom_famille) AS "Nom complet",
       adresse,
       ville
FROM outils_usager u
WHERE EXISTS(SELECT e.num_usager FROM outils_emprunt e WHERE e.num_usager=u.num_usager);
-- 20.  R�digez la requ�te qui affiche la moyenne du prix des outils par marque. /3
SELECT fabricant AS "Marque",
       AVG(prix) AS "Moyenne de prix"
FROM outils_outil
GROUP BY fabricant;
-- 21.  R�digez la requ�te qui affiche la somme des prix des outils emprunt�s par ville, en ordre d�croissant de valeur. /4
SELECT ville,
       SUM(o.prix) AS "Somme des prix"
FROM outils_outil o
JOIN outils_emprunt e
ON o.code_outil=e.code_outil
JOIN outils_usager u
ON e.num_usager=u.num_usager
GROUP BY u.ville
ORDER BY SUM(o.prix) DESC;
-- 22.  R�digez la requ�te pour ins�rer un nouvel outil en donnant une valeur pour chacun des attributs. /2
INSERT INTO outils_outil
VALUES('12G35','Regle','Milwauke','30cm,metal,durable','2019','24.99');
-- 23.  R�digez la requ�te pour ins�rer un nouvel outil en indiquant seulement son nom, son code et son ann�e. /2
INSERT INTO outils_outil (code_outil,nom,annee)
VALUES('32J90','Carton','2019');
-- 24.  R�digez la requ�te pour effacer les deux outils que vous venez d�ins�rer dans la table. /2
DELETE FROM outils_outil WHERE annee=2019;
-- 25.  R�digez la requ�te pour modifier le nom de famille des usagers afin qu�ils soient tous en majuscules. /2
UPDATE outils_usager
SET nom_famille=UPPER(nom_famille);
