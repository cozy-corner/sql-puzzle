CREATE SCHEMA Q22;
SET search_path to Q22;

-- 借主
CREATE TABLE Tenants
(
    tenant_id    INTEGER,
    unit_nbr     INTEGER,
    vacated_date DATE, -- 退去日
    PRIMARY KEY (tenant_id, unit_nbr)
);

-- 部屋
CREATE TABLE Units
(
    complex_id INTEGER, -- マンションid
    unit_nbr   INTEGER, -- 部屋番号
    PRIMARY KEY (complex_id, unit_nbr)
);

-- 家賃支払い
CREATE TABLE RentPayments
(
    tenant_id    INTEGER,
    unit_nbr     INTEGER,
    payment_date DATE, -- 家賃が支払われた日
    PRIMARY KEY (tenant_id, unit_nbr)
);

--サンプルデータ
INSERT INTO Tenants
VALUES (1, 1, NULL);
INSERT INTO Tenants
VALUES (1, 2, NULL);
INSERT INTO Tenants
VALUES (1, 3, '2007-01-01');

INSERT INTO Units
VALUES (32, 1);
INSERT INTO Units
VALUES (32, 2);
INSERT INTO Units
VALUES (32, 3);

/* ユニット１は家賃を払っている。２は払っていない */
INSERT INTO RentPayments
VALUES (1, 1, '2007-03-01');
