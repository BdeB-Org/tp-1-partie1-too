-- 1. Affiche la description des champs et leurs types pour les trois tables
SHOW COLUMNS FROM OUTILS_OUTIL;
SHOW COLUMNS FROM OUTILS_EMPRUNT;
SHOW COLUMNS FROM OUTILS_USAGER;

-- 2. Liste tous les usagers sous format prénom + espace + nom de famille
SELECT CONCAT(prenom, ' ', nom_famille) AS "Nom complet"
FROM OUTILS_USAGER;

-- 3. Affiche le nom des villes où habitent les usagers, sans répétition, triées alphabétiquement
SELECT DISTINCT ville 
FROM OUTILS_USAGER
ORDER BY ville;

-- 4. Affiche toutes les informations sur tous les outils, triées alphabétiquement par nom de l’outil puis par code
SELECT *
FROM OUTILS_OUTIL
ORDER BY nom, code_outil;

-- 5. Affiche le numéro des emprunts qui n’ont pas été retournés
SELECT num_emprunt AS "Numéro d'emprunt"
FROM OUTILS_EMPRUNT
WHERE date_retour IS NULL;

-- 6. Affiche le numéro des emprunts faits avant 2014
SELECT num_emprunt AS "Numéro d'emprunt",
       date_emprunt AS "Date d'emprunt"
FROM OUTILS_EMPRUNT
WHERE date_emprunt < '2014-01-01';        

-- 7. Affiche le nom et le code des outils dont la couleur commence par la lettre ‘j’
SELECT nom AS "Nom de l'outil",
       code_outil AS "Numéro de l'outil",
       caracteristiques AS "Caractéristique"
FROM OUTILS_OUTIL
WHERE UPPER(caracteristiques) LIKE 'J%';

-- 8. Affiche le nom et le code des outils fabriqués par Stanley
SELECT code_outil AS "Numéro de l'outil",
       nom AS "Nom de l'outil",
       fabricant
FROM OUTILS_OUTIL
WHERE UPPER(fabricant) = 'STANLEY';

-- 9. Affiche le nom et le fabricant des outils fabriqués de 2006 à 2008 (ANNEE)
SELECT code_outil AS "Numéro de l'outil",
       nom AS "Nom de l'outil",
       fabricant,
       annee AS "Année"
FROM OUTILS_OUTIL
WHERE annee BETWEEN 2006 AND 2008;

-- 10. Affiche le code et le nom des outils qui ne sont pas de ‘20 volts’
SELECT code_outil AS "Numéro de l'outil",
       nom AS "Nom de l'outil",
       caracteristiques AS "Caractéristique"
FROM OUTILS_OUTIL
WHERE caracteristiques NOT LIKE '%20 volt%';

-- 11. Affiche le nombre d’outils qui n’ont pas été fabriqués par Makita
SELECT COUNT(*) AS "Nombre d'outils"
FROM OUTILS_OUTIL
WHERE UPPER(fabricant) != 'MAKITA';

-- 12. Affiche les emprunts des clients de Vancouver et Regina faits après 2014
SELECT CONCAT(u.prenom, ' ', u.nom_famille) AS "Nom complet",
       u.num_usager AS "Numéro d'usager",
       e.num_emprunt AS "Numéro d'emprunt",
       o.prix,
       e.date_emprunt AS "Date d'emprunt",
       e.date_retour AS "Date de retour",
       u.ville
FROM OUTILS_USAGER u
INNER JOIN OUTILS_EMPRUNT e 
ON u.num_usager = e.num_usager
INNER JOIN OUTILS_OUTIL o 
ON e.code_outil = o.code_outil
WHERE e.date_emprunt > '2014-01-01' AND u.ville IN ('Vancouver', 'Regina');

-- 13. Affiche le nom et le code des outils empruntés qui n’ont pas encore été retournés
SELECT CONCAT(u.prenom, ' ', u.nom_famille) AS "Nom complet",
       e.code_outil AS "Code d'outil",
       e.date_emprunt AS "Date d'emprunt",
       e.date_retour AS "Date de retour"
FROM OUTILS_USAGER u
INNER JOIN OUTILS_EMPRUNT e 
ON u.num_usager = e.num_usager
WHERE e.date_retour IS NULL;

-- 14. Affiche le nom et le courriel des usagers qui n’ont jamais fait d’emprunts
SELECT CONCAT(u.prenom, ' ', u.nom_famille) AS "Nom complet",
       u.courriel
FROM OUTILS_USAGER u
LEFT JOIN OUTILS_EMPRUNT e
ON u.num_usager = e.num_usager
WHERE e.num_usager IS NULL;

-- 15. Affiche le code et la valeur des outils qui n’ont pas été empruntés
SELECT o.code_outil AS "Code de l'outil",
       o.prix AS "Prix de l'outil"
FROM OUTILS_OUTIL o
LEFT JOIN OUTILS_EMPRUNT e
ON o.code_outil = e.code_outil
WHERE e.num_emprunt IS NULL;

-- 16. Affiche la liste des outils (nom et prix) de marque Makita dont le prix est supérieur à la moyenne des prix de tous les outils
SELECT o.nom AS "Nom de l'outil",
       o.prix AS "Prix de l'outil"
FROM OUTILS_OUTIL o
WHERE UPPER(o.fabricant) = 'MAKITA'
AND o.prix > (SELECT AVG(prix) FROM OUTILS_OUTIL);

-- 17. Affiche le nom, le prénom et l’adresse des usagers et le nom
