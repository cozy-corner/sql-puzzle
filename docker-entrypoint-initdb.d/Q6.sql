CREATE SCHEMA Q6;
SET search_path to Q6;

CREATE TABLE Hotel
(room_nbr INTEGER NOT NULL,
 arrival_date DATE NOT NULL,
 departure_date DATE NOT NULL,
 guest_name CHAR(30) NOT NULL,
    PRIMARY KEY (room_nbr, arrival_date),
    CHECK (departure_date >= arrival_date));