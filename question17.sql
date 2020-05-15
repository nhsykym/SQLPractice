SELECT 
	kickoff, 
   (SELECT mc.name FROM countries mc WHERE mc.id = p1.my_country_id) as `my_country`,
   (SELECT ec.name FROM countries ec WHERE ec.id = p1.enemy_country_id) as `enemy_country`,
   (SELECT mc.ranking FROM countries mc WHERE mc.id = p1.my_country_id) as `my_ranking`,
   (SELECT ec.ranking FROM countries ec WHERE ec.id = p1.enemy_country_id) as `enemy_ranking`,
   (SELECT COUNT(g1.id) FROM goals g1 WHERE g1.pairing_id = p1.id) as `my_goals`,
   (
       SELECT COUNT(g2.id)
       FROM goals g2
       LEFT JOIN pairings p2 ON p2.id = g2.pairing_id
       WHERE p2.my_country_id = p1.enemy_country_id AND p2.enemy_country_id = p1.my_country_id
   ) as `enemy_goals`,
   (SELECT COUNT(g1.id) FROM goals g1 WHERE g1.pairing_id = p1.id) - (
       SELECT COUNT(g2.id)
       FROM goals g2
       LEFT JOIN pairings p2 ON p2.id = g2.pairing_id
       WHERE p2.my_country_id = p1.enemy_country_id AND p2.enemy_country_id = p1.my_country_id
   )  as `goal_diff`
FROM pairings p1
WHERE 
	p1.my_country_id IN (SELECT id FROM countries WHERE group_name = 'C') AND
   p1.enemy_country_id IN (SELECT id FROM countries WHERE group_name = 'C')
ORDER BY kickoff, `my_ranking`;
   