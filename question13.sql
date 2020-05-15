SELECT c.name, COUNT(g.goal_time)
FROM goals g
JOIN pairings p ON g.pairing_id = p.id
JOIN countries c ON p.my_country_id = c.id
WHERE g.pairing_id = 39 OR g.pairing_id = 103
GROUP BY c.name;