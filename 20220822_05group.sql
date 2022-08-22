
파일→새로만들기→데이터베이스계층→데이터베이스 파일
i:￦java202207￦database￦20220822_05group.sql
//////////////////////////////////////////////////////////////////////////////////////

● [데이터 그룹화]

--sungjuk_seq 시퀀스 삭제
drop sequence sungjuk_seq;

--sungjuk 테이블에서 사용할 시퀀스 생성
create sequence sungjuk_seq;

--sungjuk 테이블 삭제
drop table sungjuk;

--sungjuk 테이블 생성
create table sungjuk (
    sno      int               primary key                  
   ,uname  varchar(50)   not null                         
   ,kor       int               check(kor between 0 and 100)                    
   ,eng      int               check(eng between 0 and 100)                    
   ,mat      int               check(mat between 0 and 100)
   ,addr     varchar(20)   check(addr in('Seoul','Jeju','Busan','Suwon'))
   ,tot       int               default 0
   ,aver     int               default 0
   ,wdate  date              default sysdate              
);

--sungjuk 테이블 입력 데이터
※ 참조 : i:￦java202207￦database￦20220822_03성적테이블.sql

commit;
select count(*) from sungjuk;   --전체 레코드 개수
select * from sungjuk;

/////////////////////////////////////////////////////////////////////////////////////

insert into sungjuk(sno, uname, kor, eng, mat, addr, wdate)
values(sungjuk_seq.nextval,'솔데스크', 90, 85, 95, 'Seoul',sysdate);

insert into sungjuk(sno,uname,kor,eng,mat,addr,wdate)
values(sungjuk_seq.nextval,'무궁화',40,50,20,'Seoul',sysdate);

insert into sungjuk(sno,uname,kor,eng,mat,addr,wdate)
values(sungjuk_seq.nextval,'진달래',90,50,90,'Jeju',sysdate);

insert into sungjuk(sno,uname,kor,eng,mat,addr,wdate)
values(sungjuk_seq.nextval,'개나리',20,50,20,'Jeju',sysdate);

insert into sungjuk(sno,uname,kor,eng,mat,addr,wdate)
values(sungjuk_seq.nextval,'봉선화',90,90,90,'Seoul',sysdate);

insert into sungjuk(sno,uname,kor,eng,mat,addr,wdate)
values(sungjuk_seq.nextval,'나팔꽃',50,50,90,'Suwon',sysdate);

insert into sungjuk(sno,uname,kor,eng,mat,addr,wdate)
values(sungjuk_seq.nextval,'선인장',70,50,20,'Seoul',sysdate);

insert into sungjuk(sno,uname,kor,eng,mat,addr,wdate)
values(sungjuk_seq.nextval,'소나무',90,60,90,'Busan',sysdate);

insert into sungjuk(sno,uname,kor,eng,mat,addr,wdate)
values(sungjuk_seq.nextval,'참나무',20,20,20,'Jeju',sysdate);

insert into sungjuk(sno,uname,kor,eng,mat,addr,wdate)
values(sungjuk_seq.nextval,'홍길동',90,90,90,'Suwon',sysdate);

insert into sungjuk(sno,uname,kor,eng,mat,addr,wdate)
values(sungjuk_seq.nextval,'무궁화',80,80,90,'Suwon',sysdate);



● [distinct]
    - 칼럼에 중복내용이 있으면 대표값 1개만 출력
    - 형식) distinct 칼럼명
    
select addr from sungjuk;                           -- asc 생략가능
select addr from sungjuk order by addr asc;         -- asc(ascending) /오름차순
select addr from sungjuk order by addr desc;  --desc(descending) / 내림차순

select distinct(addr) from sungjuk;
select distinct(uname) from sungjuk;

///////////////////////////////////////////////////////////////////////////////////


● [group by]
    - 칼럼에 동일 내용끼리 그룹화 시킴
    - 형식) group by 칼럼1, 칼럼2, 칼럼3 ~~~

-- 주소가 동일한 값을 그룹화시키고 주소를 조회
select addr
from sungjuk
group by addr;  --distinct와 결과값 동일


-- ORA-00979: GROUP BY 표현식이 아닙니다. 00979. 00000 - "not a GROUP BY expression
select addr, uname          --그룹시키고 나올 수 있는 값은 1개만 가능한 값만 조회
from sungjuk
group by addr;                -- 에러



-- 문1) 주소별 인원수를 조회하시오

select addr, count (*)
from sungjuk
group by addr;

select addr, count (*) as cnt   -- 칼럼명 임시 부여
from sungjuk
group by addr;

select addr, count (*) cnt       -- as 생략가능
from sungjuk
group by addr;


-- 주소별 오름차순 정렬해서 조회
select addr
from sungjuk
group by addr
order by addr;

-- 주소별 인원수를 내림차순으로 정렬해서 조회
select addr, count (*)
from sungjuk
group by addr
order by count(*) desc;

select addr, count (*) as cnt   -- 해석순서 3)
from sungjuk                        -- 해석순서 1)
group by addr                       -- 해석순서 2)
order by count(*) desc;          -- 해석순서 4)



● [집계함수]

-- 문2) 주소별 국어점수에 대해서 집계하시오
select addr, count(*), max(kor), min(kor), sum(kor), avg(kor)        -- 개수, 최대값, 최소값, 합계, 평균
from sungjuk
group by addr;

-- 주소순으로 정렬
select addr, count(*), max(kor), min(kor), sum(kor), avg(kor)
from sungjuk
group by addr
order by addr;

-- round(값, 0) 소수점 이하 값에서 반올림하고 소수점은 삭제
select addr, count(*), max(kor), min(kor), sum(kor), round(avg(kor), 0)
from sungjuk
group by addr
order by addr;

-- 국어평균을 소수점없이 반올림하고 내림차순으로 정렬해서 조회
select addr, count(*), max(kor), min(kor), sum(kor), round(avg(kor), 0)
from sungjuk
group by addr
order by addr;















