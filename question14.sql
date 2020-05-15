SELECT kickoff, mc.name as `my_country`, ec.name as `enemy_country`, mc.ranking as `my_ranking`, ec.ranking as `enemy_ranking`, COUNT(g.id) as `my_goals`
FROM pairings p
LEFT JOIN countries mc ON p.my_country_id = mc.id
LEFT JOIN countries ec ON p.enemy_country_id = ec.id
LEFT JOIN goals g ON p.id = g.pairing_id
WHERE mc.group_name = 'C' AND ec.group_name = 'C'
GROUP BY kickoff, mc.name, ec.name, mc.ranking, ec.ranking
ORDER BY kickoff, `my_ranking`;