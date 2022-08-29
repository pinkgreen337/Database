
i:\java202207\database\20220829_02���տ�������.sql
///////////////////////////////////////////////////////////////////////////////


�� [���տ�������]

select * from tb_sugang;    --6��
select * from tb_student;   --9��
select * from tb_gwamok;    --14��

��1) ������ �������߿��� ������ ���� ���� �������� ������û�� ����� ��ȸ�Ͻÿ�
    (�й�, �̸�, �����ڵ�)
--�� ���
    select * from
    (select * 
    from tb_sugang SU join tb_gwamok GW
    on SU.gcode=GW.gcode where SU.gcode='d002'
    ) AA
    join tb_student ST on AA.hakno=ST.hakno ;

--����� ���
--������ �������� ���� ��ȸ�ϱ�
select * from tb_gwamok where gcode like 'd%' order by ghakjum desc;

--1) ������ �������߿��� ������ ���� ���� �������� ���� ��ȸ�ϱ�
select max(ghakjum) --5
from tb_gwamok 
where gcode like 'd%';

--2) 1)�� ������� ���� ����(5)�� ������ ������ ���� �ִ� �࿡�� �����ڵ� ����
--   ��, ������ ������ �� ������ ���� ���� �����ڵ� ��ȸ (��, �ߺ��� ������ ���ٴ� ���� �Ͽ�)
select gcode
from tb_gwamok
where ghakjum=(5)
and gcode like 'd%'; --d002

select gcode
from tb_gwamok
where ghakjum=(select max(ghakjum) from tb_gwamok where gcode like 'd%')
and gcode like 'd%'; --d002

--3) 2)���� ���� �����ڵ�(d002)�� ������û�� ����� ��ȸ
select gcode, hakno
from tb_sugang where gcode=('d002');

select gcode, hakno
from tb_sugang
where gcode=(
              select gcode
              from tb_gwamok
              where ghakjum=(select max(ghakjum) from tb_gwamok where gcode like 'd%')
              and gcode like 'd%' 
             );

--4) 3)�� ����� AA���̺�� ���� ��, �л����̺��� �����ؼ� �̸� ��������
select AA.gcode, AA.hakno, ST.uname
from (
        select gcode, hakno
        from tb_sugang
        where gcode=(
                      select gcode
                      from tb_gwamok
                      where ghakjum=(select max(ghakjum) from tb_gwamok where gcode like 'd%')
                      and gcode like 'd%' 
                     )

     ) AA join tb_student ST
on AA.hakno=ST.hakno;
////////////////////////////////////////////////////////////////////////////


��2) �й��� ������û�� �������� ���ϰ� �й��� �����ؼ� �ٹ�ȣ 4~6�� ��ȸ�Ͻÿ�
    (��, ������û���� ���� �л��� �������� 0���� ǥ��) left join
--�� ���
select AA.hakno, nvl(sum(GW.ghakjum),0)
from (select ST.hakno, SU.gcode from 
tb_student ST left join tb_sugang SU
on ST.hakno=SU.hakno) AA
left join tb_gwamok GW
on AA.gcode=GW.gcode group by AA.hakno order by AA.hakno;

--����� ���
--�л����̺� ��ȸ�ϱ�
select hakno, uname from tb_student order by hakno;

--1) ������û�� ������ ���� ��������
select SU.hakno, SU.gcode, GW.ghakjum
from tb_sugang SU join tb_gwamok GW 
on SU.gcode=GW.gcode;

--2) �й����� ������ ���ϱ�
select SU.hakno, sum(GW.ghakjum)as ������
from tb_sugang SU join tb_gwamok GW
on SU.gcode=GW.gcode
group by SU.hakno;

--3) ������û���� ���� �л��鵵 ������ �� �ֵ��� �л����̺� left join�ϰ�
--   2)�� ���(AA���̺�)�� ����
select ST.hakno, ST.uname, AA.hakno, AA.������
from tb_student ST left join (
                                select SU.hakno, sum(GW.ghakjum)as ������
                                from tb_sugang SU join tb_gwamok GW
                                on SU.gcode=GW.gcode
                                group by SU.hakno
                              ) AA
on ST.hakno=AA.hakno;

--4) �������� null�̸� 0���� �ٲٰ�, �й������� ��ȸ�ϱ�
select ST.hakno, ST.uname, nvl(AA.������,0)
from tb_student ST left join (
                                select SU.hakno, sum(GW.ghakjum)as ������
                                from tb_sugang SU join tb_gwamok GW
                                on SU.gcode=GW.gcode
                                group by SU.hakno
                              ) AA
on ST.hakno=AA.hakno
order by ST.hakno;

--5) �ٹ�ȣ �߰� (�ٹ�ȣ�� �ִ� ���¿��� ���ĵ�)
select ST.hakno, ST.uname, nvl(AA.������,0), rownum
from tb_student ST left join (
                                select SU.hakno, sum(GW.ghakjum)as ������
                                from tb_sugang SU join tb_gwamok GW
                                on SU.gcode=GW.gcode
                                group by SU.hakno
                              ) AA
on ST.hakno=AA.hakno
order by ST.hakno;

--6) 5)�� ����� ���������ϰ���, �ٹ�ȣ �߰��ϱ�
select BB.hakno, BB.uname, BB.������2, rownum as rnum
from (
       select ST.hakno, ST.uname, nvl(AA.������,0) as ������2
       from tb_student ST left join (
                                     select SU.hakno, sum(GW.ghakjum)as ������
                                     from tb_sugang SU join tb_gwamok GW
                                     on SU.gcode=GW.gcode
                                     group by SU.hakno
                                     ) AA
       on ST.hakno=AA.hakno
       order by ST.hakno
      ) BB;

--7) 6)�� ����� ��������(CC���̺�)�ϰ� �ٹ�ȣ(rnum) 4��~6�� ��ȸ�ϱ�
select CC.hakno, CC.������2, rnum
from (
       select BB.hakno, BB.uname, BB.������2, rownum as rnum
from (
       select ST.hakno, ST.uname, nvl(AA.������,0) as ������2
       from tb_student ST left join (
                                     select SU.hakno, sum(GW.ghakjum)as ������
                                     from tb_sugang SU join tb_gwamok GW
                                     on SU.gcode=GW.gcode
                                     group by SU.hakno
                                     ) AA
       on ST.hakno=AA.hakno
       order by ST.hakno
      ) BB
) CC 
where rnum>=4 and rnum<=6;
//////////////////////////////////////////////////////////////////////////////

��3) �й����� ������û �������� ���ϰ�, ������������ �������� ������
     ������ ���� 1�Ǹ� ��ȸ�Ͻÿ� (�й�, �̸�, ������)
-- �������̺� ���߰� ���ּ���
-- (�������� �� ���� ���̿��� ���Ȯ���ϱⰡ ���� �ָ� �մϴ�)
insert into tb_sugang(sno,hakno,gcode) 
values(sugang_seq.nextval,'g1001','p005');
commit;
--�� ���
select hakno, uname, SS, rownum 
from (
      select AA.hakno, AA.uname, sum(GW.ghakjum) SS
       from (
              select ST.hakno, ST.uname, SU.gcode
              from tb_student ST left join tb_sugang SU
              on ST.hakno=SU.hakno
             ) AA
       join tb_gwamok GW
     on AA.gcode=GW.gcode group by AA.hakno, AA.uname 
order by (sum(GW.ghakjum)) desc) BB where rownum=1;

--����� ���
--1) �����ڵ尡 ��ġ�ϴ� ���� ��������
select SU.hakno, SU.gcode, GW.ghakjum
from tb_sugang SU join tb_gwamok GW
on SU.gcode=GW.gcode;

--2) �й����� ������ ���ϰ�, ������������ �������� �����ϱ�
select SU.hakno, sum(GW.ghakjum) as ������
from tb_sugang SU join tb_gwamok GW
on SU.gcode=GW.gcode
group by SU.hakno
order by sum(GW.ghakjum) desc;

--3) 2)�� ����� AA���̺�� �����, �л����̺� �����ؼ� �̸� ��������
select ST.uname, AA.hakno, AA.������, rownum as rnum
from (
       select SU.hakno, sum(GW.ghakjum) as ������
       from tb_sugang SU join tb_gwamok GW
       on SU.gcode=GW.gcode
       group by SU.hakno
       order by sum(GW.ghakjum) desc
       ) AA
     join tb_student ST 
on AA.hakno=ST.hakno;

--4) 3)�� ����� ���������ϰ� �ٹ�ȣ�� �̿��ؼ� ���������� 1�Ǹ� ��ȸ�ϱ�
select BB.uname, BB.hakno, BB.������, rnum
from( 
      select ST.uname, AA.hakno, AA.������, rownum as rnum
      from (
             select SU.hakno, sum(GW.ghakjum) as ������
             from tb_sugang SU join tb_gwamok GW
             on SU.gcode=GW.gcode
             group by SU.hakno
             order by sum(GW.ghakjum) desc
            ) AA
     join tb_student ST 
     on AA.hakno=ST.hakno) BB where rnum=1;








