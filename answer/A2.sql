set schema 'q2';

begin;

select *
from personnel;
select *
from absenteeism
order by emp_id, absent_date;
select *
from excuselist;


-- 罰点を~P貯めると首（personnelから削除)
-- 2日以上、連続で休んだ場合、2日目以降は罰点がつかない

-- 休んだ日の次の休み
SELECT emp_id,
       absent_date,
       LEAD(absent_date) OVER (
           PARTITION BY emp_id
           ORDER BY absent_date
           ) AS next_day,
       reason_code,
       severity_points
FROM absenteeism;

-- 休んだ日の翌日
SELECT emp_id,
       absent_date,
       absent_date + INTERVAL '1' DAY AS next_day,
       reason_code,
       severity_points
FROM absenteeism;

UPDATE absenteeism
SET severity_points = 0
WHERE EXISTS(
              SELECT *
              FROM (SELECT emp_id,
                           absent_date,
                           absent_date + INTERVAL '1' DAY AS next_day
                    FROM absenteeism) AS A2
              WHERE absenteeism.emp_id = A2.emp_id
                AND absenteeism.absent_date = A2.next_day
          );

select *
from absenteeism
order by emp_id, absent_date;

SELECT emp_id, SUM(severity_points)
FROM absenteeism
GROUP BY emp_id
HAVING SUM(severity_points) >= 6;

DELETE
FROM personnel
WHERE personnel.emp_id = (SELECT emp_id
                            FROM absenteeism
                            GROUP BY emp_id
                            HAVING SUM(severity_points) >= 6);

select *
from personnel;

-- 休日の考慮
-- カレンダーテーブルを作成する

rollback;
end;
