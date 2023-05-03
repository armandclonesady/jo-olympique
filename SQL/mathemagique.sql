SELECT a.id, a.nom, COUNT(*) AS nbParticipation FROM athlete AS a JOIN resultat AS r USING (id)
GROUP BY a.id, a.nom
ORDER BY nbParticipation DESC
LIMIT 20;

SELECT COUNT(*) FROM resultat
WHERE annee = 1992 AND saison = 'Summer';

SELECT DISTINCT p.noc, AVG(p.age), COUNT(DISTINCT id), MIN(p.age), MAX(p.age) FROM participe AS p
WHERE annee = 1992 AND saison = 'Summer'
GROUP BY p.noc;

