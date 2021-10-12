/* 開始と終了に変換*/
WITH Events AS(
 SELECT  p1.proc_id, p2.proc_id AS comparison_proc, p1.anest_name, p2.start_time AS event_time, +1 AS event_type
 	FROM Procs AS p1 CROSS JOIN Procs AS p2
    WHERE p1.anest_name = p2.anest_name
    AND NOT(p2.end_time <= p1.start_time OR p2.start_time >= p1.end_time)
 UNION 
  SELECT p1.proc_id, p2.proc_id AS comparison_proc, p1.anest_name, p2.end_time AS event_time, -1 AS event_type
 	FROM Procs AS p1 CROSS JOIN  Procs AS p2
    WHERE p1.anest_name = p2.anest_name
    AND NOT(p2.end_time <= p1.start_time OR p2.start_time >= p1.end_time)
 ),
 /* それ以前に始まったイベントの合計*/
ConcurrentProcs AS (
   SELECT e1.proc_id, 
   				 e1.event_time,
   		(SELECT SUM(e2.event_type)
         FROM Events AS e2
         WHERE e2.proc_id = e1.proc_id
         	AND e2.event_time < e1.event_time)
   		AS instantaneous_count
   FROM Events AS e1
   ORDER BY e1.proc_id, e1.event_time
)
/* 最大瞬間掛け持ち数*/
SELECT proc_id, MAX(instantaneous_count) AS max_inst
FROM ConcurrentProcs
GROUP BY proc_id
ORDER BY proc_id;