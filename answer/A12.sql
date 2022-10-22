select *
from claims;
select *
from defendants;
select *
from legalevents;

-- 訴訟状態は最新のもの = claim_seqの最大値
-- ただし訴訟に関与している被告ごとのステータスの最小


-- 被告単位の最大値
select defendant_name, max(claim_seq)
from claims c inner join legalevents le on c.claim_id = le.claim_id
         inner join claimstatuscodes cs on le.claim_status = cs.claim_status
group by defendant_name;

select claim_id, patient_name, claim_status, claim_seq
from claims cross join claimstatuscodes;

select claim_id, patient_name, claim_status, claim_seq
from claims c1 cross join claimstatuscodes
where claim_seq IN
      -- 訴訟単位の最小値
      (select min(claim_seq)
       from claimStatusCodes
       where claim_seq in
             -- 訴訟単位の被告ごとの最大値
             (select max(claim_seq)
              from legalevents as le
                       inner join claimstatuscodes cs on le.claim_status = cs.claim_status
              where le.claim_id = c1.claim_id
              group by defendant_name));