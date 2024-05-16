use resturant_reservation;
CREATE TABLE Customers (
    customerId INT NOT NULL AUTO_INCREMENT,
    customerName VARCHAR(45) NOT NULL,
    contactInfo VARCHAR(200),
    PRIMARY KEY (customerId)
);
INSERT INTO Customers (customer_id, customer_name) VALUES
(1, 'Diore'),
(2, 'Alvin'),
(3, 'Evan');
CREATE TABLE Reservations (
    reservationId INT NOT NULL AUTO_INCREMENT,
    customerId INT NOT NULL,
    reservationTime DATETIME NOT NULL,
    numberOfGuests INT NOT NULL,
    specialRequests VARCHAR(200),
    PRIMARY KEY (reservationId),
    FOREIGN KEY (customerId) REFERENCES Customers(customerId)
);
INSERT INTO Reservations (reservation_id, name, customer_id) VALUES
(1, 'Diore', 1),
(2, 'Alvin', 2),
(3, 'Evan', 3);
CREATE TABLE DiningPreferences (
    preferenceId INT NOT NULL AUTO_INCREMENT,
    customerId INT NOT NULL,
    favoriteTable VARCHAR(45),
    dietaryRestrictions VARCHAR(200),
    PRIMARY KEY (preferenceId),
    FOREIGN KEY (customerId) REFERENCES Customers(customerId)
);
SELECT *
FROM reservations
WHERE customerId = customerId;
DELIMITER //
CREATE PROCEDURE findReservations(IN customer_id INT)
BEGIN
    SELECT *
    FROM reservations
    WHERE customerId = customer_id;
END //
DELIMITER ;
CALL findReservations(123);
UPDATE reservations
SET specialRequests = 'Extra Sides'
WHERE reservationId = 1;
DELIMITER $$

CREATE PROCEDURE addReservation(
    IN p_customer_id INT,
    IN p_name VARCHAR(255),
    IN p_email VARCHAR(255),
    IN p_reservation_date DATE
)
BEGIN
    -- Check if the customer exists
    DECLARE customer_exists INT;
    SET customer_exists = (SELECT COUNT(*) FROM Customers WHERE customer_id = p_customer_id);

    -- If the customer does not exist, insert the customer
    IF customer_exists = 0 THEN
        INSERT INTO Customers (customer_id, name, email)
        VALUES (p_customer_id, p_name, p_email);
    END IF;

    -- Add the reservation
    INSERT INTO Reservations (customer_id, reservation_date)
    VALUES (p_customer_id, p_reservation_date);
END$$
DELIMITER ;
CALL addReservation(1, 'Diore', 'diore.lemond@lc.cuny.edu', '2024-05-16');

