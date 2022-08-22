
���ϡ���θ����浥���ͺ��̽������浥���ͺ��̽� ����
i:��java202207��database��20220822_05group.sql
//////////////////////////////////////////////////////////////////////////////////////

�� [������ �׷�ȭ]

--sungjuk_seq ������ ����
drop sequence sungjuk_seq;

--sungjuk ���̺��� ����� ������ ����
create sequence sungjuk_seq;

--sungjuk ���̺� ����
drop table sungjuk;

--sungjuk ���̺� ����
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

--sungjuk ���̺� �Է� ������
�� ���� : i:��java202207��database��20220822_03�������̺�.sql

commit;
select count(*) from sungjuk;   --��ü ���ڵ� ����
select * from sungjuk;

/////////////////////////////////////////////////////////////////////////////////////

insert into sungjuk(sno, uname, kor, eng, mat, addr, wdate)
values(sungjuk_seq.nextval,'�ֵ���ũ', 90, 85, 95, 'Seoul',sysdate);

insert into sungjuk(sno,uname,kor,eng,mat,addr,wdate)
values(sungjuk_seq.nextval,'����ȭ',40,50,20,'Seoul',sysdate);

insert into sungjuk(sno,uname,kor,eng,mat,addr,wdate)
values(sungjuk_seq.nextval,'���޷�',90,50,90,'Jeju',sysdate);

insert into sungjuk(sno,uname,kor,eng,mat,addr,wdate)
values(sungjuk_seq.nextval,'������',20,50,20,'Jeju',sysdate);

insert into sungjuk(sno,uname,kor,eng,mat,addr,wdate)
values(sungjuk_seq.nextval,'����ȭ',90,90,90,'Seoul',sysdate);

insert into sungjuk(sno,uname,kor,eng,mat,addr,wdate)
values(sungjuk_seq.nextval,'���Ȳ�',50,50,90,'Suwon',sysdate);

insert into sungjuk(sno,uname,kor,eng,mat,addr,wdate)
values(sungjuk_seq.nextval,'������',70,50,20,'Seoul',sysdate);

insert into sungjuk(sno,uname,kor,eng,mat,addr,wdate)
values(sungjuk_seq.nextval,'�ҳ���',90,60,90,'Busan',sysdate);

insert into sungjuk(sno,uname,kor,eng,mat,addr,wdate)
values(sungjuk_seq.nextval,'������',20,20,20,'Jeju',sysdate);

insert into sungjuk(sno,uname,kor,eng,mat,addr,wdate)
values(sungjuk_seq.nextval,'ȫ�浿',90,90,90,'Suwon',sysdate);

insert into sungjuk(sno,uname,kor,eng,mat,addr,wdate)
values(sungjuk_seq.nextval,'����ȭ',80,80,90,'Suwon',sysdate);



�� [distinct]
    - Į���� �ߺ������� ������ ��ǥ�� 1���� ���
    - ����) distinct Į����
    
select addr from sungjuk;                           -- asc ��������
select addr from sungjuk order by addr asc;         -- asc(ascending) /��������
select addr from sungjuk order by addr desc;  --desc(descending) / ��������

select distinct(addr) from sungjuk;
select distinct(uname) from sungjuk;

///////////////////////////////////////////////////////////////////////////////////


�� [group by]
    - Į���� ���� ���볢�� �׷�ȭ ��Ŵ
    - ����) group by Į��1, Į��2, Į��3 ~~~

-- �ּҰ� ������ ���� �׷�ȭ��Ű�� �ּҸ� ��ȸ
select addr
from sungjuk
group by addr;  --distinct�� ����� ����


-- ORA-00979: GROUP BY ǥ������ �ƴմϴ�. 00979. 00000 - "not a GROUP BY expression
select addr, uname          --�׷��Ű�� ���� �� �ִ� ���� 1���� ������ ���� ��ȸ
from sungjuk
group by addr;                -- ����



-- ��1) �ּҺ� �ο����� ��ȸ�Ͻÿ�

select addr, count (*)
from sungjuk
group by addr;

select addr, count (*) as cnt   -- Į���� �ӽ� �ο�
from sungjuk
group by addr;

select addr, count (*) cnt       -- as ��������
from sungjuk
group by addr;


-- �ּҺ� �������� �����ؼ� ��ȸ
select addr
from sungjuk
group by addr
order by addr;

-- �ּҺ� �ο����� ������������ �����ؼ� ��ȸ
select addr, count (*)
from sungjuk
group by addr
order by count(*) desc;

select addr, count (*) as cnt   -- �ؼ����� 3)
from sungjuk                        -- �ؼ����� 1)
group by addr                       -- �ؼ����� 2)
order by count(*) desc;          -- �ؼ����� 4)



�� [�����Լ�]

-- ��2) �ּҺ� ���������� ���ؼ� �����Ͻÿ�
select addr, count(*), max(kor), min(kor), sum(kor), avg(kor)        -- ����, �ִ밪, �ּҰ�, �հ�, ���
from sungjuk
group by addr;

-- �ּҼ����� ����
select addr, count(*), max(kor), min(kor), sum(kor), avg(kor)
from sungjuk
group by addr
order by addr;

-- round(��, 0) �Ҽ��� ���� ������ �ݿø��ϰ� �Ҽ����� ����
select addr, count(*), max(kor), min(kor), sum(kor), round(avg(kor), 0)
from sungjuk
group by addr
order by addr;

-- ��������� �Ҽ������� �ݿø��ϰ� ������������ �����ؼ� ��ȸ
select addr, count(*), max(kor), min(kor), sum(kor), round(avg(kor), 0)
from sungjuk
group by addr
order by addr;















