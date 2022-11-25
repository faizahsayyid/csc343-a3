-- For each owner, report how many venues they own.

SET SEARCH_PATH TO concert;

-- OUTPUT
SELECT o.owner_id, COUNT(v.venue_id) AS "venues_owned" FROM Owner o
    JOIN Venue v ON o.owner_id = v.owner_id
    GROUP BY o.owner_id;