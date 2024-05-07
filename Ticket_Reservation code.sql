Drop Database IF EXISTS TicketReservation;
CREATE DATABASE TicketReservation;
USE TicketReservation;

CREATE TABLE Venues (
    V_id INT AUTO_INCREMENT PRIMARY KEY,
    Vname VARCHAR(255) NOT NULL,
    Vlocation VARCHAR(255) NOT NULL,
    Capacity INT NOT NULL,
    CONSTRAINT CHK_Capacity_Venues CHECK (Capacity > 0)
);

INSERT INTO Venues (Vname, Vlocation, Capacity) VALUES
('Concert Hall', 'New York', 1000),
('Stadium', 'Los Angeles', 5000),
('Conference Center', 'Chicago', 200);

DROP TABLE IF EXISTS Events;
CREATE TABLE Events (
ev_id INT AUTO_INCREMENT PRIMARY KEY,
Event_name Varchar(255) NOT NULL,
Ev_date Date NOT NULL,
Ev_time TIME,
Ev_location Varchar(255) NOT NULL,
Ticketprice Decimal (10, 2) NOT NULL,
Ev_type ENUM('Concert', 'Sports', 'Conference', 'Theater', 'Other') NOT NULL,
Capacity INT NOT NULL,
Availability INT NOT NULL,
V_id INT,
CONSTRAINT CHK_Capacity CHECK (Capacity > 0),
CONSTRAINT CHK_Availability CHECK (Availability >= 0),
Foreign Key (V_id) References Venues(V_id)
);

INSERT INTO Events (Event_name, Ev_date, Ev_time, Ev_location, Ticketprice, Ev_type, Capacity, Availability, V_id)
VALUES
('Brent Faizy', '2024-05-15', '20:00:00', 'Concert Hall', 50.00, 'Concert', 1000, 500, 1),
('Japan vs. Brazil world cup', '2024-06-20', '15:00:00', 'Stadium', 30.00, 'Sports', 5000, 3000, 2),
('Tech Summit Central', '2024-09-10', '09:00:00', 'Conference Center', 100.00, 'Conference', 200, 200, 3),
('Imagine Dragons', '2024-07-20', '18:30:00', 'Music Arena', 60.00, 'Concert', 1500, 1000, 1),
('La Perle', '2024-08-15', '19:30:00', 'City Theater', 80.00, 'Theater', 800, 600, 3),
('Medical Forum Exchange', '2024-11-05', '10:00:00', 'Expo Center', 120.00, 'Conference', 500, 400, 2),
('Bulgaria vs. Romania karate match', '2024-10-25', '14:00:00', 'Outdoor Stadium', 40.00, 'Sports', 7000, 5000, 2),
('One Republic', '2024-09-05', '21:00:00', 'Amphitheater', 70.00, 'Concert', 2000, 1500, 3),
('Hamlet', '2024-07-30', '20:00:00', 'Community Theater', 90.00, 'Theater', 600, 450, 1),
('Fitness Symposium Solution', '2024-12-15', '11:00:00', 'Convention Center', 150.00, 'Conference', 800, 700, 3),
('Teo', '2024-08-10', '19:00:00', 'Park Pavilion', 55.00, 'Concert', 1200, 800, 2),
('Volleyball match between Crows and Eagles', '2024-09-28', '16:30:00', 'Indoor Arena', 35.00, 'Sports', 3000, 2500, 1),
('les miserables', '2024-10-12', '18:45:00', 'Black Box Theater', 75.00, 'Theater', 400, 300, 2),
('Teacher Expo Specialists', '2024-11-20', '08:30:00', 'Hotel Conference Room', 110.00, 'Conference', 300, 250, 1),
('Gathering', '2024-12-05', '17:00:00', 'Event Center', 50.00, 'Other', 1000, 800, 3);


CREATE TABLE Tickets (
ticket_id INT AUTO_INCREMENT PRIMARY KEY,
Ev_id INT,
Tickettype Varchar(50) NOT NULL,
Availability Boolean NOT NULL,
Price Decimal (10, 2) NOT NULL,
Foreign Key (Ev_id) References Events(Ev_id)
);

INSERT INTO Tickets (Ev_id, Tickettype, Availability, Price)
VALUES
(1, 'Regular', TRUE, 50.00),
(1, 'VIP', TRUE, 100.00),
(2, 'General Admission', TRUE, 30.00),
(3, 'Early Bird', TRUE, 80.00),
(3, 'Standard', TRUE, 100.00),
(4, 'Regular', TRUE, 60.00),
(5, 'Standard', TRUE, 120.00),
(6, 'Premium', TRUE, 150.00),
(7, 'Student', TRUE, 20.00),
(8, 'General Admission', TRUE, 40.00),
(9, 'Regular', TRUE, 70.00),
(10, 'VIP', TRUE, 90.00),
(11, 'General Admission', TRUE, 55.00),
(12, 'Standard', TRUE, 35.00),
(13, 'Early Bird', TRUE, 110.00),
(14, 'Regular', TRUE, 75.00),
(15, 'General Admission', TRUE, 50.00);


CREATE TABLE Users (
user_id INT AUTO_INCREMENT PRIMARY KEY,
user_name Varchar(100) NOT NULL,
Email Varchar(255) NOT NULL,
Password Varchar(255) NOT NULL,
phone_number int
);

INSERT INTO Users (user_name, Email, Password, phone_number)
VALUES
('Michael Johnson', 'michael@example.com', 'mypass123', 1112223333),
('Sarah Wilson', 'sarah@example.com', 'sarahpass', 444555666),
('David Brown', 'david@example.com', 'david1234', 777888999),
('Jennifer Lee', 'jennifer@example.com', 'jenniferpass', 13131234),
('Matthew Clark', 'matthew@example.com', 'mattpass', 45645667),
('Jessica Martinez', 'jessica@example.com', 'jessicapass', 7897890),
('Andrew Taylor', 'andrew@example.com', 'andrew123', 32132110),
('Emma Anderson', 'emma@example.com', 'emmapass', 65465443),
('James Thomas', 'james@example.com', 'jamespass', 987989876),
('Olivia White', 'olivia@example.com', 'oliviapass', 13351351),
('Daniel Hall', 'daniel@example.com', 'danielpass', 24662462),
('Sophia Garcia', 'sophia@example.com', 'sophiapass', 33693693),
('Alexander Wilson', 'alexander@example.com', 'alexander123', 48144814),
('Ava Rodriguez', 'ava@example.com', 'avapass', 57995795),
('William Martinez', 'william@example.com', 'williampass', 68468446);

CREATE TABLE Reservations (
res_id INT AUTO_INCREMENT PRIMARY KEY,
res_date Timestamp Default current_timestamp,
user_id INT,
ticket_id INT,
STATUS ENUM ('confirmed', 'Pending', 'Canceled'),
Foreign Key (user_id) References users(user_id),
Foreign Key (ticket_id) References Tickets(ticket_id)
);

DELIMITER //

CREATE PROCEDURE MakeReservation(
    IN eventId INT,
    IN username VARCHAR(100),
    IN numTickets INT
)
BEGIN
    DECLARE availableTickets INT;

    
    SELECT AvailableTickets INTO availableTickets FROM Events WHERE EventID = eventId;
    IF availableTickets >= numTickets THEN
        
        INSERT INTO Reservations (EventID, Username, NumTickets) VALUES (eventId, username, numTickets);
        
        UPDATE Events SET AvailableTickets = AvailableTickets - numTickets WHERE EventID = eventId;
        SELECT 'Reservation successful' AS Message;
    ELSE
        SELECT 'Not enough tickets available' AS Message;
    END IF;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE ViewAvailableTickets()
BEGIN
    SELECT EventID, EventName, AvailableTickets FROM Events;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE AddVenue(
    IN vname VARCHAR(255),
    IN vlocation VARCHAR(255),
    IN capacity INT
)
BEGIN
    INSERT INTO Venues (Vname, Vlocation, Capacity) VALUES (vname, vlocation, capacity);
END //

DELIMITER ;


DELIMITER //

CREATE PROCEDURE ViewVenueDetails(
    IN venueId INT
)
BEGIN
    SELECT * FROM Venues WHERE VenueID = venueId;
END //

DELIMITER ;

