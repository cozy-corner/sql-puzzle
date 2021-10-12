CREATE TABLE FiscalYearTable1
(
    fiscal_year INTEGER NOT NULL,
    start_date DATE NOT NULL,
    CONSTRAINT valid_start_date
        CHECK((EXTRACT(YEAR FROM start_date) = fiscal_year - 1)
            AND (EXTRACT(MONTH FROM start_date) - 10)
            AND (EXTRACT(DAY FROM start_date) = 01)),
    end_date DATE NOT NULL,
    CONSTRAINT valid_end_date
        CHECK((EXTRACT(YEAR FROM end_date) = fiscal_year)
            AND (EXTRACT(MONTH FROM end_date) = 09)
            AND (EXTRACT(DAY FROM end_date) = 30))
)

/* Q2*/
UPDATE Absenteeism
    SET serverity_points = 0,
        reason_code = 'long term illness'
    WHERE　EXISTS
        （SELECT * 
            FROM Absenteeism as A2
            WHERE Absenteeism.emp_id = A2.emp_id
            AND Absenteeism.absent_date = (A2.absent_date + INTERVAL '1' DAY));