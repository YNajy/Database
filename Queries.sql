SELECT * FROM events
WHERE Ev_type = 'Sports';

SELECT tickets.Tickettype, venues.Vlocation
FROM tickets
JOIN
Events ON tickets.Ev_id = events.ev_id
JOIN 
venues ON Events.V_id = venues.V_id;

SELECT u.user_name, COUNT(r.res_id) AS num_reservations
FROM Users u
LEFT JOIN Reservations r ON u.user_id = r.user_id
GROUP BY u.user_name;

SELECT e.Event_name, SUM(t.Price) AS total_revenue
FROM Events e
JOIN Tickets t ON e.ev_id = t.Ev_id
GROUP BY e.Event_name;

SELECT e.Event_name, COUNT(r.res_id) AS total_tickets_sold
FROM Events e
LEFT JOIN Reservations r ON e.ev_id = r.ticket_id
GROUP BY e.Event_name;

SELECT e.Event_name, t.Tickettype, t.Price
FROM Events e
JOIN Tickets t ON e.ev_id = t.Ev_id
JOIN (
    SELECT Ev_id, MIN(Price) AS min_price
    FROM Tickets
    GROUP BY Ev_id
) AS min_prices ON t.Ev_id = min_prices.Ev_id AND t.Price = min_prices.min_price;

Select distinct Ev_location
FROM Events;

SELECT e.Event_name, t.Tickettype, t.Price
FROM Events e
JOIN Tickets t ON e.ev_id = t.Ev_id
JOIN (
    SELECT Ev_id, MAX(Price) AS max_price
    FROM Tickets
    GROUP BY Ev_id
) AS max_prices ON t.Ev_id = max_prices.Ev_id AND t.Price = max_prices.max_price;

INSERT INTO Venues (Vname, Vlocation, Capacity) 
VALUES ('Stadium', 'Vasil Levski Stadium', 15000);

SELECT * FROM Venues WHERE Vname = 'Stadium' AND Vlocation = 'Vasil Levski Stadium';

SELECT Capacity FROM Venues;

SELECT v.* 
FROM Venues v
JOIN Events e ON v.V_id = e.V_id
WHERE v.Capacity >= 0 AND v.Capacity <= 1000;

SELECT E.Event_name, V.Vname
FROM Events E
JOIN Venues V ON E.V_id = V.V_id
ORDER BY E.Event_name ASC, V.Vname ASC;

SELECT E.Event_name, V.Vname
FROM Events E
JOIN Venues V ON E.V_id = V.V_id
ORDER BY E.Event_name DESC, V.Vname DESC;
 
SELECT *
FROM Users
WHERE user_name = 'Ava Rodriguez';

SELECT 
    Users.*,
    Tickets.*,
    Events.*,
    Venues.*
FROM 
    Users
LEFT JOIN 
    Reservations ON Users.user_id = Reservations.user_id
LEFT JOIN 
    Tickets ON Reservations.ticket_id = Tickets.ticket_id
LEFT JOIN 
    Events ON Tickets.Ev_id = Events.ev_id
LEFT JOIN 
    Venues ON Events.V_id = Venues.V_id
WHERE 
    Users.user_name = 'Ava Rodriguez';

SELECT *
FROM Venues
LEFT JOIN Events ON Venues.V_id = Events.V_id
WHERE Venues.Vname = 'Stadium';

SELECT e.Event_name, e.Availability
FROM Events e
WHERE e.Availability < 0;

SELECT u.user_name, r.res_id, r.STATUS, t.Tickettype
FROM Users u
JOIN Reservations r ON u.user_id = r.user_id
JOIN Tickets t ON r.ticket_id = t.ticket_id;

SELECT Event_name, Ev_date
FROM Events
WHERE Ev_date BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 1 MONTH);

SELECT e.Event_name, e.Ev_date, e.Availability
FROM Events e
WHERE e.Availability > 0
ORDER BY e.Ev_date;

SELECT u.user_name, COUNT(r.res_id) AS total_reservations
FROM Users u
LEFT JOIN Reservations r ON u.user_id = r.user_id
GROUP BY u.user_name
ORDER BY total_reservations DESC
LIMIT 1;

SELECT DISTINCT u.user_name
FROM Users u
JOIN Reservations r ON u.user_id = r.user_id
JOIN Tickets t ON r.ticket_id = t.ticket_id
JOIN Events e ON t.Ev_id = e.ev_id
JOIN Venues v ON e.V_id = v.V_id
WHERE v.Vlocation = 'New York';

SELECT DISTINCT u.user_name
FROM Users u
JOIN Reservations r ON u.user_id = r.user_id
JOIN Tickets t ON r.ticket_id = t.ticket_id
JOIN Events e ON t.Ev_id = e.ev_id
JOIN Venues v ON e.V_id = v.V_id
WHERE v.Vlocation IN ('Los Angeles', 'New York');

SELECT Ev_type, AVG(Price) AS AverageTicketPrice
FROM Events e
JOIN Tickets t ON e.ev_id = t.Ev_id
GROUP BY Ev_type;

SELECT u.user_id, u.user_name, COUNT(r.res_id) AS TotalReservations
FROM Users u
JOIN Reservations r ON u.user_id = r.user_id
GROUP BY u.user_id, u.user_name
ORDER BY TotalReservations DESC
LIMIT 5;

SELECT e.ev_id, e.Event_name
FROM Events e
JOIN Tickets t ON e.ev_id = t.Ev_id
GROUP BY e.ev_id, e.Event_name
HAVING SUM(t.Availability) / e.Capacity > 0.8;

SELECT e.ev_id, e.Event_name, (SUM(t.Availability) / e.Capacity) * 100 AS TicketAvailabilityPercentage
FROM Events e
JOIN Tickets t ON e.ev_id = t.Ev_id
GROUP BY e.ev_id, e.Event_name
ORDER BY TicketAvailabilityPercentage DESC;

