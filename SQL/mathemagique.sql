SELECT a.id, a.nom, COUNT(*) AS nbParticipation FROM athlete AS a JOIN resultat AS r USING (id)
GROUP BY a.id, a.nom
ORDER BY nbParticipation DESC
LIMIT 20;

SELECT COUNT(*) FROM resultat
WHERE annee = 1992 AND saison = 'Summer';

SELECT DISTINCT noc FROM participe
WHERE annee = 1992 AND saison = 'Summer';

