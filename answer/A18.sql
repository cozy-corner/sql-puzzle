
select *
from consumers;

-- 同じ住所が存在し、世帯主でない人
select *
from consumers con1
         inner join consumers con2 on con1.con_id = con2.fam
where con1.fam is null;

delete
from consumers
where con_id in (select con1.con_id
                 from consumers con1
                          inner join consumers con2 on con1.con_id = con2.fam
                 where con1.fam is null);


-- 模範回答

-- count(*) がNULL行も含むことを利用する
delete
from consumers
where fam is null
  and (select count(*) from consumers con1 where consumers.address = con1.address) > 1;

delete
from consumers
where fam is null
  AND EXISTS(select * from consumers as c1 where c1.fam = consumers.con_id);

rollback;
end;
