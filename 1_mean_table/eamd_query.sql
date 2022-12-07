
/* all_year_cohort 
변경
0. table 명
1. schema (cdm_2019_view) & 
2. drug_concept_id 4개(bevacizumab, ranibizumab, aflibercept, verteporfin) &
3. cohort_definition_id &
4. specialty_concept_id '38004463'처방의-안과의사
*/
create table eAMD_TX_allyear_csy AS -- table 명
select a.drug_exposure_id as drug_exposure_id
  , a.person_id as person_id
  , a.drug_conecpt_id as drug_conecpt_id
  , a.drug_exposure_start_date as drug_exposure_start_date
  , a.drug_exposure_end_date as drug_exposure_end_date
from cdm_2019_view.drug_exposure a, cdm_2019_view.COHORT b -- schema
where a.drug_concept_id in ('1397141','43286611','35606176', '1593778') -- drug_concept_id
and b.cohort_definition_id = '2208' -- cohort id (all)
and b.cohort_start_date > TO_DATE('2007-12-31', 'YYYY-MM-DD')
and a.person_id = b.subject_id
and (select count(g.provider_id)
  from cdm_2019_view.provider g -- schema
  where a.provider_id = g.provider_id
  and g.specialty_concept_id = '38004463')<>0;-- 처방의-안과의사
  
  


/* F/U First year_cohort 
변경
0. table 명
1. schema (cdm_2019_view) & 
2. drug_concept_id 4개(bevacizumab, ranibizumab, aflibercept, verteporfin) &
3. cohort_definition_id &
4. specialty_concept_id '38004463'처방의-안과의사
*/  
create table eAMD_TX_1year_csy AS -- table 명
select a.drug_exposure_id as drug_exposure_id
  , a.person_id as person_id
  , a.drug_conecpt_id as drug_conecpt_id
  , a.drug_exposure_start_date as drug_exposure_start_date
  , a.drug_exposure_end_date as drug_exposure_end_date
from cdm_2019_view.drug_exposure a, cdm_2019_view.COHORT b -- schema
where a.drug_concept_id in ('1397141','43286611','35606176', '1593778') -- drug_concept_id
and b.cohort_definition_id = '2214' -- cohort id (1year)
and b.cohort_start_date > TO_DATE('2007-12-31', 'YYYY-MM-DD')
and a.person_id = b.subject_id
and (select count(g.provider_id)
  from cdm_2019_view.provider g -- schema
  where a.provider_id = g.provider_id
  and g.specialty_concept_id = '38004463')<>0;-- 처방의-안과의사
  
  

/* F/U Second year_cohort 
변경
0. table 명
1. schema (cdm_2019_view) & 
2. drug_concept_id 4개(bevacizumab, ranibizumab, aflibercept, verteporfin) &
3. cohort_definition_id &
4. specialty_concept_id '38004463'처방의-안과의사
*/  
create table eAMD_TX_2year_csy AS -- table 명
select a.drug_exposure_id as drug_exposure_id
  , a.person_id as person_id
  , a.drug_conecpt_id as drug_conecpt_id
  , a.drug_exposure_start_date as drug_exposure_start_date
  , a.drug_exposure_end_date as drug_exposure_end_date
from cdm_2019_view.drug_exposure a, cdm_2019_view.COHORT b -- schema
where a.drug_concept_id in ('1397141','43286611','35606176', '1593778') -- drug_concept_id
and b.cohort_definition_id = '2215' -- cohort id (2year)
and b.cohort_start_date > TO_DATE('2007-12-31', 'YYYY-MM-DD')
and a.person_id = b.subject_id
and (select count(g.provider_id)
  from cdm_2019_view.provider g -- schema
  where a.provider_id = g.provider_id
  and g.specialty_concept_id = '38004463')<>0;-- 처방의-안과의사  
  
  
  

/* F/U Third year_cohort 
변경
0. table 명
1. schema (cdm_2019_view) & 
2. drug_concept_id 4개(bevacizumab, ranibizumab, aflibercept, verteporfin) &
3. cohort_definition_id &
4. specialty_concept_id '38004463'처방의-안과의사
*/  
create table eAMD_TX_3year_csy AS -- table 명
select a.drug_exposure_id as drug_exposure_id
  , a.person_id as person_id
  , a.drug_conecpt_id as drug_conecpt_id
  , a.drug_exposure_start_date as drug_exposure_start_date
  , a.drug_exposure_end_date as drug_exposure_end_date
from cdm_2019_view.drug_exposure a, cdm_2019_view.COHORT b -- schema
where a.drug_concept_id in ('1397141','43286611','35606176', '1593778') -- drug_concept_id
and b.cohort_definition_id = '2216' -- cohort id (3year)
and b.cohort_start_date > TO_DATE('2007-12-31', 'YYYY-MM-DD')
and a.person_id = b.subject_id
and (select count(g.provider_id)
  from cdm_2019_view.provider g -- schema
  where a.provider_id = g.provider_id
  and g.specialty_concept_id = '38004463')<>0;-- 처방의-안과의사  



/* Route Right, left 있는 data 
변경
0. table 명
1. schema (cdm_2019_view) & 
2. drug_concept_id 4개(bevacizumab, ranibizumab, aflibercept, verteporfin) &
3. cohort_definition_id &
4. specialty_concept_id '38004463'처방의-안과의사
*/  
create table eAMD_TX_both_csy AS -- table 명
select a.drug_exposure_id as drug_exposure_id
  , a.person_id as person_id
  , a.drug_conecpt_id as drug_conecpt_id
  , a.drug_exposure_start_date as drug_exposure_start_date
  , a.drug_exposure_end_date as drug_exposure_end_date
  , a.route_concept_id as route_concept_id
from cdm_2019_view.drug_exposure a, cdm_2019_view.COHORT b -- schema
where a.drug_concept_id in ('1397141','43286611','35606176', '1593778') -- drug_concept_id
and b.cohort_definition_id = '3707' -- cohort id (route)
and b.cohort_start_date > TO_DATE('2007-12-31', 'YYYY-MM-DD')
and a.person_id = b.subject_id
and (select count(g.provider_id)
  from cdm_2019_view.provider g -- schema
  where a.provider_id = g.provider_id
  and g.specialty_concept_id = '38004463')<>0;-- 처방의-안과의사  

























  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
