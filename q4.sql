-- Report the username of the person who has purchased the most tickets. 
-- If there is a tie, report them all.

SET SEARCH_PATH TO concert;

DROP VIEW IF EXISTS 
    PurchaseCount
CASCADE;

-- the number of purchases a user has made
CREATE VIEW PurchaseCount AS 
    SELECT username, COUNT(purchase_id) AS "purchase_count" FROM Purchase
        GROUP BY username;

-- OUTPUT
SELECT username FROM PurchaseCount
    WHERE purchase_count >= ALL (
        SELECT purchase_count FROM PurchaseCount
    );