set schema 'q21';
begin;

select *
from hangar;
select *
from pilotskills;

-- 待機中の飛行機全てを操縦できるパイロットを全員選択する
-- Smith と Wilson

select pilot
from pilotskills
         inner join hangar h on pilotskills.plane = h.plane
group by pilot
having count(h.plane) = (select count(*) from hangar);

end;