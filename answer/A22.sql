-- RentPaymentsのうち、payment_dateがある期間内に含まれている行と、部屋と借主の組み合わせを結合する（空行)レポートを取得する

-- 不変のテーブルを外部表にする

select *
from (units as u left outer join tenants t on u.unit_nbr = t.unit_nbr and t.vacated_date is null and u.complex_id = 32)
         left outer join rentpayments r on
             (t.tenant_id = r.tenant_id and u.unit_nbr = r.unit_nbr) -- 一人の借主が一つの部屋の家賃を払っている
where r.payment_date between :start_date and :end_date
   or r.payment_date is null
