-- For each concert, report the total value of all tickets sold and the 
-- percentage of the venue that was sold.

SET SEARCH_PATH TO concert;

DROP VIEW IF EXISTS 
    SeatPrices,
    TotalConcertSale,
    TotalConcertSaleNotNull,
    TotalTicketCount,
    TotalTicketSoldCount,
    TotalPercentageSold,
    TotalSaleAndPercentageSold
CASCADE;

-- Define views for your intermediate steps here:

-- the price of each seat sold for a concert
CREATE VIEW SeatPrices AS 
    SELECT p.concert_id, p.seat_id, sp.price FROM Purchase p 
        JOIN Seat s ON s.seat_id = p.seat_id
        JOIN SectionPrice sp ON s.section_id = sp.section_id;

-- the total ticket sale revenue of a concert
CREATE VIEW TotalConcertSale AS 
    SELECT c.concert_id, SUM(sp.price) AS "total" FROM Concert c
        LEFT JOIN SeatPrices sp ON sp.concert_id = c.concert_id
        GROUP BY c.concert_id;

-- the total ticket sale revenue of a concert replacing nulls with 0
CREATE VIEW TotalConcertSaleNotNull AS
    SELECT 
        concert_id,
        CASE WHEN total IS NULL THEN 0
        ELSE total
        END AS "total"
    FROM TotalConcertSale;

-- the total number of seats in a venue by concert
CREATE VIEW TotalTicketCount AS
    SELECT c.concert_id, count(seat_id) AS "ticket_count" FROM Concert c
        JOIN Venue v ON v.venue_id = c.venue_id
        JOIN Section sc ON sc.venue_id = v.venue_id
        JOIN Seat s ON s.section_id = sc.section_id
        GROUP BY c.concert_id;

-- the total number of seats sold by concert
CREATE VIEW TotalTicketSoldCount AS
    SELECT 
        concert_id, 
        count(purchase_id) AS "sold_count" 
    FROM Purchase
        GROUP BY concert_id;

-- the percentage of seats sold per concert
CREATE VIEW TotalPercentageSold AS 
    SELECT 
        t.concert_id,
        (CASE WHEN s.sold_count IS NULL THEN 0
        ELSE s.sold_count::FLOAT / t.ticket_count::FLOAT
        END) AS "percentage_sold"
    FROM TotalTicketCount t
        LEFT JOIN TotalTicketSoldCount s ON s.concert_id = t.concert_id;

-- the total ticket sale revenue and the percentage of seats sold per concert
CREATE VIEW TotalSaleAndPercentageSold AS
    SELECT s.concert_id, 
        s.total AS "total_sold", 
        p.percentage_sold
    FROM TotalConcertSaleNotNull s 
        JOIN TotalPercentageSold p ON s.concert_id = p.concert_id;

-- OUTPUT
SELECT c.concert_id, c.name, c.datetime, t.total_sold, t.percentage_sold FROM Concert c
    JOIN TotalSaleAndPercentageSold t ON t.concert_id = c.concert_id;