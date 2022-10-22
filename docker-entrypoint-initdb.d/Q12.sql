CREATE SCHEMA Q12;
SET search_path to Q12;

-- 訴訟
CREATE TABLE Claims
(
    claim_id     INTEGER,
    patient_name VARCHAR(64),
    PRIMARY KEY (claim_id)
);

-- 被告
CREATE TABLE Defendants
(
    claim_id       INTEGER,
    defendant_name VARCHAR(64),
    PRIMARY KEY (claim_id, defendant_name)
);

-- 訴訟の進行状態
CREATE TABLE LegalEvents
(
    claim_id       INTEGER,
    defendant_name VARCHAR(64),
    claim_status   CHAR(2),
    change_date    DATE,
    PRIMARY KEY (claim_id, defendant_name, claim_status)
);

-- 訴訟の順序
CREATE TABLE ClaimStatusCodes
(
    claim_status      CHAR(2) PRIMARY KEY,
    claim_status_desc VARCHAR(64),
    claim_seq         INTEGER
);

INSERT INTO Claims
VALUES (10, 'Smith');
INSERT INTO Claims
VALUES (20, 'Jones');
INSERT INTO Claims
VALUES (30, 'Brown');

INSERT INTO Defendants
VALUES (10, 'Johnson');
INSERT INTO Defendants
VALUES (10, 'Meyer');
INSERT INTO Defendants
VALUES (10, 'Dow');
INSERT INTO Defendants
VALUES (20, 'Baker');
INSERT INTO Defendants
VALUES (20, 'Meyer');
INSERT INTO Defendants
VALUES (30, 'Johnson');

INSERT INTO LegalEvents
VALUES (10, 'Johnson', 'AP', '1994-01-01');
INSERT INTO LegalEvents
VALUES (10, 'Johnson', 'OR', '1994-02-01');
INSERT INTO LegalEvents
VALUES (10, 'Johnson', 'SF', '1994-03-01');
INSERT INTO LegalEvents
VALUES (10, 'Johnson', 'CL', '1994-04-01');
INSERT INTO LegalEvents
VALUES (10, 'Meyer', 'AP', '1994-01-01');
INSERT INTO LegalEvents
VALUES (10, 'Meyer', 'OR', '1994-02-01');
INSERT INTO LegalEvents
VALUES (10, 'Meyer', 'SF', '1994-03-01');
INSERT INTO LegalEvents
VALUES (10, 'Dow', 'AP', '1994-01-01');
INSERT INTO LegalEvents
VALUES (10, 'Dow', 'OR', '1994-02-01');
INSERT INTO LegalEvents
VALUES (20, 'Meyer', 'AP', '1994-01-01');
INSERT INTO LegalEvents
VALUES (20, 'Meyer', 'OR', '1994-02-01');
INSERT INTO LegalEvents
VALUES (20, 'Baker', 'AP', '1994-01-01');
INSERT INTO LegalEvents
VALUES (30, 'Johnson', 'AP', '1994-01-01');

INSERT INTO ClaimStatusCodes
VALUES ('AP', 'Awaiting review panel', 1);
INSERT INTO ClaimStatusCodes
VALUES ('OR', 'Panel opinion rendered', 2);
INSERT INTO ClaimStatusCodes
VALUES ('SF', 'Suit filed', 3);
INSERT INTO ClaimStatusCodes
VALUES ('CL', 'closed', 4);
