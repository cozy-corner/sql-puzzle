CREATE SCHEMA Q11;
SET search_path to Q11;

CREATE TABLE Projects
(workorder_id CHAR(5) NOT NULL,
 step_nbr INTEGER NOT NULL
    CHECK (step_nbr BETWEEN 0 AND 1000),
 step_status CHAR(1) NOT NULL
    CHECK (step_status IN ('C', 'W')), -- Cは完了、Wは待機
    PRIMARY KEY (workorder_id, step_nbr));

INSERT INTO Projects VALUES('AA100', 0, 'C' );
INSERT INTO Projects VALUES('AA100', 1, 'W' );
INSERT INTO Projects VALUES('AA100', 2, 'W' );
INSERT INTO Projects VALUES('AA200', 0, 'W' );
INSERT INTO Projects VALUES('AA200', 1, 'W' );
INSERT INTO Projects VALUES('AA300', 0, 'C' );
INSERT INTO Projects VALUES('AA300', 1, 'C' );