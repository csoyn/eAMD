/* 시력 테이블 만드는 sql */

/*경로, 테이블 명 & 시력 concept id 변경 필요*/
create table G65829.eamd_va_csy as
select * from cdm_2019_view.measurement
where person_id in (select person_id from g65829.eamd_tx_both_csy)
and measurement_source_concept_id in (
 '21491741', '2061000005', '2061000011', '21491747', '2061000008', '21491745', 
 '21491742', '2061000004', '2061000010', '21491746', '2061000007', '21491744'
);


/*경로 테이블 명 변경 필요*/
create table G65829.eamd_va_index_csy as
select a.measurement_date, a.measurement_source_value, a.measurement_concept_id, a.value_as_number, a.value_source_value, a.person_id, b.ROUTE_CONCEPT_ID,
(b.drug_exposure_start_date-a.measurement_date) as diff
from G65829.eamd_va_csy a 
inner join g65829.eamd_tx_both_csy b
on a.person_id = b.person_id;

select count(*) from G65829.eamd_va_index_csy;


/*날짜 계산*/
create table G65829.eamd_va_index_gp_csy2 as
select a.*, case when a.diff >=-31 and  a.diff <=0 then 0
     when a.diff >=90 and a.diff<=180 then 90
     when a.diff >=275 and a.diff<=455 then 365
     when a.diff >=640 and a.diff<=820 then 730
     else 9999 end as diff_gp
from G65829.eamd_va_index_csy a
where diff !=9999;


select count(distinct person_id) from G65829.eamd_va_index_gp_csy2 where diff_gp != 9999; 