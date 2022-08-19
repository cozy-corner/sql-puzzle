begin;
set schema 'q11';
-- auto-generated definition
select *
from projects;
-- worker_id,step_nbr,step_status
-- AA100,1,W
-- AA100,2,W
-- AA200,0,W
-- AA200,1,W
-- AA300,0,C
-- AA300,1,C

-- 課題
-- step_nprが0 かつ、step_statusが C(完了）かつ、その作業の 0 番以外が全て W　である依頼を抽出する

-- 愚直な方法
SELECT *
FROM projects p1
WHERE step_nbr = 0
  AND step_status = 'C'
  AND EXISTS(SELECT *
             FROM projects p2
             WHERE p1.workorder_id = p2.workorder_id
               AND p2.step_nbr != 0
               AND p2.step_status = 'W');


-- 自己結合を使った方法
-- distinctは省略
SELECT *
FROM projects p1
         INNER JOIN
     projects p2
     ON p1.workorder_id = p2.workorder_id AND p2.step_nbr != 0 AND
        p2.step_status = 'W'
WHERE p1.step_nbr = 0
  AND p1.step_status = 'C';

-- HAVING
-- statusを絞りきれていない
SELECT *
FROM projects p1
WHERE step_nbr = 0
  AND step_status = 'C'
  AND EXISTS(SELECT p2.workorder_id
             FROM projects p2
             WHERE p1.workorder_id = p2.workorder_id
             GROUP BY p2.workorder_id
             HAVING MAX(p2.step_nbr) > 1
                AND COUNT(p2.step_status) > 1);


-- 回答例 ALLを使用
--
SELECT *
FROM projects p1
WHERE step_nbr = 0
  AND step_status = 'C'
  AND 'W' = ALL(SELECT p2.step_status
                 FROM projects p2
                 WHERE p1.workorder_id = p2.workorder_id
                   AND p2.step_nbr != 0);


-- 回答例　NOT NULL と　CHECK制約を利用したもの
-- SQLはDDLとDMLの組み合わせ
SELECT workorder_id
FROM projects
WHERE step_status = 'C'
GROUP BY workorder_id
HAVING SUM(step_nbr) = 0;


END;
