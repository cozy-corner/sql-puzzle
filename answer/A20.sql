begin;

set schema 'q20';

select *
from testresults;

-- 追加データ
-- 最大が null
insert into testresults values('歴史', 1, '2006-04-01');
insert into testresults values('歴史', 2, '2006-04-02');
insert into testresults values('歴史', 3, null);

-- 全てのステップが完了しているテストを見つけ出す
-- max が null だった場合に、除けない
select test_name
from testresults
where comp_date is not null
group by test_name
having count(test_name) = max(test_step);


-- 回答例
-- count が NULLを数えないことを利用する
select test_name
from testresults
group by test_name
having count(test_name) = count(comp_date);

end;
