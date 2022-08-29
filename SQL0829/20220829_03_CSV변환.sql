
i:\java202207\database\20220829_03_CSV변환.sql
///////////////////////////////////////////////////////////////////////////////

● [CSV 파일]
   - 모든 데이터가 , 로 구분되어 있는 파일
   
● [CSV 파일을 데이터베이스로 가져오기]
   - 공공데이터포털 https://data.go.kr/ 활용
   
   
문) 도로명 우편번호 테이블 구축하기 

--1) zipdoro.csv 준비(258,267행)

--2) zipdoro.csv 내용을 저장하는 zipdoro테이블 생성
create table zipdoro (
    zipno      char(5)          --우편번호
   ,zipaddress varchar(1000)    --주소
);

commit;
drop table zipdoro;     --테이블 삭제

--3) 가져오기와 내보내기
- zipdoro 테이블 우클릭 → 데이터 임포트 (가져오기)
- zipdoro 테이블 우클릭 → export

select count(*) from zipdoro;   --전체 행 개수 조회하기

문1) 서울특별시 강남구로 시작되는 우편번호가 몇개인지 조회하시오
select count(zipno)
from zipdoro 
where zipaddress like '서울특별시 강남구%';

//////////////////////////////////////////////////////////

문2) 한국교원대학교_초중등학교위치.csv를 변환하시오 (11872행)

학교ID,학교명,학교급구분,소재지도로명주소,생성일자,변경일자,위도,경도
create table sclocation (
        scid    varchar(1000)       --학교 ID
       ,scname  varchar(1000)       --학교명
       ,scclass varchar(1000)       --학교급구분
       ,scaddress varchar(1000)     --소재지도로명주소
       ,sdate date                  --생성일자
       ,cdate date                  --변경일자
       ,latitude varchar(1000)      --위도
       ,longitude varchar(1000)     --경도
       );

-- 비어있는 값(null)을 찾으시오
select * from sclocation where scaddress is null;









