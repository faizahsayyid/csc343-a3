-- For each concert, report the total value of all tickets sold and the 
-- percentage of the venue that was sold.

SET SEARCH_PATH TO concert;

DROP VIEW IF EXISTS 
    SeatPrices,
    TotalConcertSale
CASCADE;


-- Define views for your intermediate steps here:
CREATE VIEW SeatPrices AS 
    SELECT p.concert_id, p.seat_id, sp.price FROM Purchase p 
        JOIN Seat s ON s.seat_id = p.seat_id
        JOIN SectionPrice sp ON s.section_id = sp.section_id;

CREATE VIEW TotalConcertSale AS 
    SELECT c.concert_id, SUM(sp.price) AS "total" FROM Concert c
        LEFT JOIN SeatPrices sp ON sp.concert_id = c.concert_id
        GROUP BY c.concert_id;

CREATE VIEW TotalConcertSaleNotNull AS
    SELECT 
        concert_id,
        CASE WHEN total IS NULL THEN 0
        ELSE total
        END AS "total"
    FROM TotalConcertSale;

-- OUTPUT
SELECT * FROM TotalConcertSaleNotNull;