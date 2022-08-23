
파일→새로만들기→데이터베이스계층→데이터베이스 파일
i:￦java202207￦database￦20220823_02오라클함수.sql
//////////////////////////////////////////////////////////////////////////////////////

● [오라클 함수]

-- 가상테이블 : dual


1. 문자열 관련 함수

select lower('Hello World') from dual;              --전부 소문자로 변환
select upper('Hello World') from dual;              --전부 대문자로 변환
select length('Hello World') from dual;             --글자개수
select substr('Hello World', 1, 5) from dual;      --문자열 자르기 (첫번째 글자부터 5개)

select instr('HelloWorld','\') from dual;           --특정문자 위치 5
select lpad('SKY',5,'*') from dual;                  --5칸내에서 출력하고 왼쪽 빈칸은 *로 채움
select rpad('SKY',5,'*') from dual;                  --5칸내에서 출력하고 오른쪽 빈칸은 *로 채움
select replace('happy','p','k') from dual;          --특정문자 변환

select chr(65) from dual;       --ASCII 문자 변환 'A  '
select chr(66) from dual;
select chr(97) from dual;       --'a'
select chr(98) from dual;

--문자열 연결하기
select concat('로미오','줄리엣') from dual;       --로미오줄리엣
--concat (칼럼명, '문자열')
select concat(uname, '의 평균은'), concat(aver, '입니다') from sungjuk;



-- || 결합연산자
select uname || '의 평균은 ' || aver || '입니다' from sungjuk;
select uname || '의 평균은 ' || aver || '입니다' as str from sungjuk;
////////////////////////////////////////////////////////////////////////////////////////


2. 숫자 관련 함수

select abs(-7) from dual;                           --절대값
select mod(5,3) from dual;                        --나머지 연산자
select ceil(12.4) from dual;                        --13      올림함수
select trunc(13.56, 1) from dual;                --13.5    내림함수

select avg(kor) from sungjuk;                     --66.363636
select ceil (avg(kor)) from sungjuk;             --67
select trunc (avg(kor), 2) from sungjuk;       --66.36

--to number
select to_number('123')+1 from dual;         --124
select '100'+1 from dual;                         --101 내부적으로 to_number()가 호출됨
        
////////////////////////////////////////////////////////////////////////////////////////////


3. 날짜 관련 함수

select sysdate from dual;   --시스템의 현재 날짜와 시간정보를 리턴하는 함수

--sysdate에서 년월일 추출하기
select extract(year from sysdate) from dual;
select extract(month from sysdate) from dual;
select extract(day from sysdate) from dual;

--날짜데이터의 연산
select sysdate+100 from dual;       --오늘날짜+100일
select sysdate-100 from dual;       --오늘날짜-100일

--두개의 날짜데이터에서 개월 수 계산
select months_between('2022-08-23','2022-05-25') from dual;     --2.93
select months_between('2022-08-23','2022-12-25') from dual;     --4.06

--문자열을 날짜형으로 변환
select to_date('2022-10-25') from dual;
select to_date('2022-10-25') -to_date('2022-10-30')from dual;     -- -5

/////////////////////////////////////////////////////////////////////////////////////////



● nvl() 함수 - null 값을 다른 값으로 바꿈

문제) 주소가 'Incheon'인 행의 국어점수 최대값, 인원수를 조회하시오
select max(kor), count(*)
from sungjuk
where addr='Incheon';           --최대값(null), 인원수(0)

select count(*)+1                 --0+1
from sungjuk
where addr='Incheon';

select max(kor)+1                --null+1      →null값과 연산할 수 없다
from sungjuk
where addr='Incheon';

select nvl(max(kor), 0)          --null값이면 0으로 대체함
from sungjuk
where addr='Incheon';

select nvl(max(kor), 0)+1 
from sungjuk
where addr='Incheon';

select nvl(max(kor), 0)+1 as max_kor
from sungjuk
where addr='Incheon';

//////////////////////////////////////////////////////////////////////////////////////////


● 모조칼럼
    - rownum : 행 번호
    - rowid     : 행의 주소값
    
select sno, uname, addr, rownum, rowid
from sungjuk;


select sno, uname, addr, rownum
from sungjuk
where rownum>=1 and rownum<=5;

select sno, uname, addr, rownum
from sungjuk
where addr='Seoul';

--자신의 행번호를 포함해서 정렬됨. rownum을 추가하는 시점도 고려해야 함
select sno, uname, addr, rownum
from sungjuk
order by uname;



















