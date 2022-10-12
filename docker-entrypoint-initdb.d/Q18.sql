CREATE SCHEMA Q18;
SET search_path to Q18;

-- ダイレクトメールを一世帯に一通送りたい
-- 同世帯のうち 世帯主でない（fam列がnull）を削除する
-- ボブとジョーが削除対象
CREATE TABLE Consumers
(conname VARCHAR(64),
 address VARCHAR(64),
 con_id  INTEGER,
 fam     INTEGER);

INSERT INTO Consumers VALUES('ボブ',        'A', 1, NULL );
INSERT INTO Consumers VALUES('ジョー',      'B', 3, NULL );
INSERT INTO Consumers VALUES('マーク' ,     'C', 5, NULL );
INSERT INTO Consumers VALUES('メアリー',    'A', 2,    1 );
INSERT INTO Consumers VALUES('ヴィッキー',  'B', 4,    3 );
INSERT INTO Consumers VALUES('ウェイン',    'D', 6, NULL );