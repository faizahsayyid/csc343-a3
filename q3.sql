-- For each venue, report the percentage of seats that are accessible.

SET SEARCH_PATH TO concert;

DROP VIEW IF EXISTS 
    AccessibleSeats,
    TotalSeats
CASCADE;

-- the number of seats that are accessible by venue
CREATE VIEW AccessibleSeats AS 
    SELECT 
        v.venue_id, 
        count(s.seat_id) AS "accessible_count"
    FROM Venue v
        JOIN Section sc ON sc.venue_id = v.venue_id
        JOIN Seat s ON s.section_id = sc.section_id
        WHERE s.is_accessible
        GROUP BY v.venue_id;

-- the number of seats by venue
CREATE VIEW TotalSeats AS 
    SELECT v.venue_id, v.name, count(s.seat_id) AS "total_count" FROM Venue v
        JOIN Section sc ON sc.venue_id = v.venue_id
        JOIN Seat s ON s.section_id = sc.section_id
        GROUP BY v.venue_id;

-- OUTPUT
SELECT 
    t.venue_id,
    t.name,
    CASE WHEN a.accessible_count IS NULL THEN 0
    ELSE a.accessible_count::FLOAT / t.total_count::FLOAT
    END AS "accessible_percentage"
FROM TotalSeats t
    LEFT JOIN AccessibleSeats a ON t.venue_id = a.venue_id;