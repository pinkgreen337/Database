
i:\java202207\database\20220826_01���̺�����.sql
////////////////////////////////////////////////////////////////////////////////

�� [���̺� ����]
    - ���� ���̺��� �ϳ��� ���̺�ó�� ����ϴ� ����
    - �� �� �̻��� ���̺��� �����Ͽ� �����͸� �����ϴ� ���
    - �� ���̺��� ���밪�� �̿��Ͽ� Į���� �����ϴ� ����
    
    
    ����) 
            select Į��
            from ���̺�1 join ���̺�2
            on ������;                             -- ANSI(ǥ��) SQL��

            select Į��
            from ���̺�1, ���̺�2
            on ������;                             -- Oracle DB SQL��

            select T1.*, T2.*                     -- T1.���Į��, T2.���Į��
            from T1 join T2
            on T1.x=T2.x;                         -- ���̺��.Į����

            select T1.*, T2.*, T3.*
            from T1 join T2
            on T1.x=T2.x join T3                  -- 3�� ���̺� ����
            on T1.y=T3.y;

            select T1.*, T2.*, T3.*, T4.*         -- 4�� ���̺� ����
            from T1 join T2                       
            on T1.x=T2.x join T3               
            on T1.y=T3.y join T4
            on T1.z=T4.z;


�� ������ : where������, having������, on������


�� ������ ���̺�� ���� ���̺��� ���� ������ �����̴�
   - ������ ���̺� : ���� create table�� ���̺�
   - ���� ���̺� : SQL���� ���� ������ ���̺�
   
   select * from tb_student;
   select count(*) from tb_student;
////////////////////////////////////////////////////////////////////////


�� inner join ����

-- �й��� �������� �������̺�� �л����̺� ����
select tb_sugang.*, tb_student.*
from tb_sugang join tb_student
on tb_sugang.hakno = tb_student.hakno;

-- �� ���̺� ���� ������ ����. inner��� �ܾ�� ��������. ���� �⺻
select tb_sugang.*, tb_student.*
from tb_sugang inner join tb_student
on tb_sugang.hakno = tb_student.hakno;


-- ������û�� �л����� �й�, �����ڵ�, �̸�, �̸����� ��ȸ�Ͻÿ�
select tb_sugang.*, tb_student.uname, tb_student.email
from tb_sugang inner join tb_student
on tb_sugang.hakno = tb_student.hakno;


-- �����ڵ带 �������� �������̺�� �������̺� ����
select tb_sugang.*, tb_gwamok.gname, tb_gwamok.ghakjum
from tb_sugang inner join tb_gwamok
on tb_sugang.gcode = tb_gwamok.gcode;


-- 3�� ���̺� ���� : �������̺� + �л����̺�(�̸�) + �������̺�(�����)
select tb_sugang.*, tb_student.uname, tb_gwamok.gname
from tb_sugang join tb_student
on tb_sugang.hakno=tb_student.hakno join tb_gwamok
on tb_sugang.gcode=tb_gwamok.gcode;


-- ���̺���� alias(��Ī)�� �����ϴ�
select SU.*, ST.uname, ST.email
from tb_sugang SU join tb_student ST
on SU.hakno=ST.hakno;

select SU.*, GW.gname, GW.ghakjum
from tb_sugang SU join tb_gwamok GW
on SU.gcode=GW.gcode;

select SU.*, ST.uname, ST.email, GW.gname, GW.ghakjum
from tb_sugang SU join tb_student ST
on SU.hakno=ST.hakno join tb_gwamok GW
on SU.gcode=GW.gcode;


-- ��ȸ�� ���̺��� �ߺ����� ���� Į������ ���̺���� ������ �� �ִ�
select SU.*, uname, email, gname, ghakjum
from tb_sugang SU join tb_student ST
on SU.hakno=ST.hakno join tb_gwamok GW
on SU.gcode=GW.gcode;

-- �ߺ��Ǵ� Į������ �Ҽ� ���̺���� ��Ȯ�� ����ؾ� �Ѵ�
-- ERROR. ORA-00918: ���� ���ǰ� �ָ��մϴ�
select hakno,gcode,uname, email, gname, ghakjum
from tb_sugang SU join tb_student ST
on SU.hakno=ST.hakno join tb_gwamok GW
on SU.gcode=GW.gcode;

select SU.hakno, SU.gcode, uname, email, gname, ghakjum
from tb_sugang SU join tb_student ST
on SU.hakno=ST.hakno join tb_gwamok GW
on SU.gcode=GW.gcode;
//////////////////////////////////////////////////////////////////


�� [���̺� ���� ����]

-- ��ü �� ����
select count(*) from tb_student;    -- 6��
select count(*) from tb_gwamok;     -- 9��
select count(*) from tb_sugang;     -- 13��
/////////////////////////////////////////////////////////////////////

��1)������û�� �� �л��� �߿��� '����'�� ��� �л��鸸 �й�, �̸�, �ּҸ� ��ȸ�Ͻÿ�
-- ������û�� �л��� ��� ��ȸ
select * from tb_sugang;

select SU.hakno, SU.gcode, ST.uname, ST.address
from tb_sugang SU join tb_student ST
on SU.hakno=ST.hakno
where ST.address='����';

-- ������ ���� ���̺��� �̸��� AA��� �����ϰ�, �ٽ� �簡�� �� �� �ִ�
select AA.hakno, AA.gcode, AA.uname, AA.address
from (
       select SU.hakno, SU.gcode, uname, address
       from tb_sugang SU join tb_student ST
       on SU.hakno=ST.hakno
) AA
where AA.address='����';


-- AA��Ī ���� ����
select AA.hakno, AA.gcode, AA.uname, AA.address
from (
       select SU.hakno, SU.gcode, uname, address
       from tb_sugang SU join tb_student ST
       on SU.hakno=ST.hakno
)
where AA.address='����';



��2) �������� ������û �ο���, ������ ��ȸ�Ͻÿ�
     ���� 2��
     ���� 1��
-- ����� ���     
--1) �������̺� ��ȸ
select * from tb_sugang;

--2) ������û�� �л����� ��� ��ȸ(�й�)
select hakno from tb_sugang order by hakno;
select distinct(hakno) from tb_sugang order by hakno;
select hakno from tb_sugang group by hakno;  --group by���� ���������� ������ ������ ����

--3) ������û�� �й�(AA)���� �ּҸ� �л����̺��� ��������
select AA.hakno, ST.address
from (
       select hakno from tb_sugang group by hakno
) AA join tb_student ST 
on AA.hakno=ST.hakno;

--4) 3)�� ����� BB���̺�� ���� �� �ּҺ��� �׷�ȭ�ϰ� �� ���� ���ϱ�
select BB.address, count(*) || '��' as cnt
from (
      select AA.hakno, ST.address
      from (
       select hakno from tb_sugang group by hakno
      ) AA join tb_student ST 
    on AA.hakno=ST.hakno
      ) BB
group by BB.address;

-- �� ���
select ST.address, count(distinct(ST.hakno))
from tb_sugang SU join tb_student ST
on SU.hakno=ST.hakno
group by address;


��3) ���� ���� ��û �ο���, �����ڵ�, ������� ��ȸ�Ͻÿ� 
     d001 HTML    2�� 
     d002 ���伥   1��
     p001 OOP     2��
     
--1) �������̺��� �����ڵ� �����ؼ� ��ȸ�ϱ�
select * from tb_sugang order by gcode;

--2) �������̺��� �����ڵ尡 ������ ���� �׷�
select gcode, count(*)
from tb_sugang
group by gcode;

--3) 2)�� ����� AA���̺�� �����ϰ� �������̺��� join
select AA.gcode, GW.gname, concat(AA.cnt,'��')
from (
        select gcode, count(*)as cnt
        from tb_sugang
        group by gcode
      ) AA join tb_gwamok GW
on AA.gcode=GW.gcode
order by AA.gcode;

--�� ���
select GW.gcode, gname, count(*) || '��'
from (select SU.gcode, SU.hakno
from tb_sugang SU join tb_student ST
on SU.hakno=ST.hakno ) BB
join tb_gwamok GW
on BB.gcode=GW.gcode group by GW.gcode, gname;
//////////////////////////////////////////////////////////////////////////


��4) �й��� ������û������ �������� �й��������� ��ȸ�Ͻÿ�
     g1001  ȫ�浿  9����
     g1002  ȫ�浿  6����
     g1005  ���޷�  9����
-- ����� ���
--1) �������̺��� �й����� ��ȸ
select hakno, gcode from tb_sugang order by hakno;

--2) �������̺� �����ڵ尡 ��ġ�ϴ� ������ �������̺��� �����ͼ� ���̱�
select SU.hakno, SU.gcode, GW.ghakjum
from tb_sugang SU join tb_gwamok GW
on SU.gcode=GW.gcode;

  --3) 2)�� ����� AA���̺�� ����� �й����� �׷�ȭ�� ��, ������ �հ踦 ���ϱ� 
  select AA.hakno, sum(AA.ghakjum), as hap
  from (
  select SU.hakno, SU.gcode, GW.ghakjum
  from tb_sugang SU join tb_gwamok GW
  on SU.gcode=GW.gcode
  ) AA
  group by AA.hakno
  
--4) 3)�� ����� BB���̺�� �����, �й��� �������� �л����̺��� �̸� �����ͼ� ���̱�
select BB.hakno, concat(BB.hap, '����'), ST.uname
from (
        select AA.hakno, sum(AA.ghakjum) as hap
  from (
        select SU.hakno, SU.gcode, GW.ghakjum
        from tb_sugang SU join tb_gwamok GW
        on SU.gcode=GW.gcode
         ) AA
  group by AA.hakno
  ) BB join tb_student ST
  on BB.hakno=ST.hakno;
-----------------------------------------------------------------

��4)�� �� �ٸ� ���
--1) �������̺� + �л����̺� + �������̺� 3�� ���̺� �Ѳ����� ����
select SU.hakno, SU.gcode, ST.uname, GW.ghakjum
from tb_sugang SU join tb_student ST
on SU.hakno=ST.hakno join tb_gwamok GW
on SU.gcode=GW.gcode
order by SU.hakno;

--2) 1�� �׷�(�й�), 2�� �׷�(�̸�)
select SU.hakno, ST.uname, sum(GW.ghakjum)
from tb_sugang SU join tb_student ST
on SU.hakno=ST.hakno join tb_gwamok GW
on SU.gcode=GW.gcode
group by SU.hakno, ST.uname;



-- �� ���
select AA.hakno, uname, ������
from (select SU.hakno, sum(ghakjum)|| '����' ������
      from tb_sugang SU join tb_gwamok GW
      on SU.gcode=GW.gcode
      group by SU.hakno) AA join tb_student ST
on AA.hakno=ST.hakno;



��5) �й� g1001�� ������û�� ������ �����ڵ庰�� ��ȸ�Ͻÿ�
     g1001  p001  OOP
     g1001  p003  JSP  
     g1001  d001  HTML
select ST.hakno, GW.gcode, gname
from tb_student ST join tb_sugang SU
on ST.hakno=SU.hakno join tb_gwamok GW
on SU.gcode=GW.gcode where ST.hakno='g1001';    --���� �ڹ��ڵ忡�� �й��� ����ó���Ѵ�
////////////////////////////////////////////////////////////////////
     
     
��6)������û�� �� �л����� �й�, �̸� ��ȸ
--�� �亯
select distinct(ST.hakno), uname
from tb_student ST join tb_sugang SU
on ST.hakno=SU.hakno order by ST.hakno;

--����� �亯
--1) ������û�� �� �л����� �й� ��ȸ
select hakno from tb_sugang;
select distinct(hakno) from tb_sugang;
select hakno from tb_sugang order by hakno;

--2)
select hakno, uname
from tb_student
where hakno='g1001' or hakno='g1002' or hakno='g1005' or hakno='g1006';

select hakno, uname
from tb_student
where hakno in ('g1001', 'g1002', 'g1005', 'g1006');

--3)
select hakno, uname
from tb_student
where hakno in (select hakno from tb_sugang group by hakno);
//////////////////////////////////////////////////////////////////////

��7)������û�� ���� ���� �л����� �й�, �̸� ��ȸ
--�� �亯
select hakno,uname from tb_student
where hakno not in (select distinct(ST.hakno)
from tb_student ST join tb_sugang SU
on ST.hakno=SU.hakno) order by hakno;

--����� �亯
select hakno, uname
from tb_student
where hakno not in (select hakno from tb_sugang group by hakno);


��8) ���� �̸����� ���� �л��� ������ ������ ������
select * from tb_sugang;
select * from tb_gwamok;
select * from tb_student;

select AA.hakno, AA.uname, AA.email, sum(ghakjum)as ������
from (select ST.hakno, ST.uname, SU.gcode, ST.email, ga
from tb_student ST join tb_sugang SU
on ST.hakno=SU.hakno where ST.email like '%daum%') AA join tb_gwamok GW
on AA.gcode=GW.gcode;


��9) ���������� �ϰ� �ִ� �л����� ����
select uname, AA.hakno, GW.gname
(select uname, ST.hakno
from tb_student ST join tb_sugang SU
on ST.hakno=SU.hakno) AA
join tb_gwamok GW on AA.gcode=GW.gcode













