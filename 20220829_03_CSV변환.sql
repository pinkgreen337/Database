
i:\java202207\database\20220829_03_CSV��ȯ.sql
///////////////////////////////////////////////////////////////////////////////

�� [CSV ����]
   - ��� �����Ͱ� , �� ���еǾ� �ִ� ����
   
�� [CSV ������ �����ͺ��̽��� ��������]
   - �������������� https://data.go.kr/ Ȱ��
   
   
��) ���θ� �����ȣ ���̺� �����ϱ� 

--1) zipdoro.csv �غ�(258,267��)

--2) zipdoro.csv ������ �����ϴ� zipdoro���̺� ����
create table zipdoro (
    zipno      char(5)          --�����ȣ
   ,zipaddress varchar(1000)    --�ּ�
);

commit;
drop table zipdoro;     --���̺� ����

--3) ��������� ��������
- zipdoro ���̺� ��Ŭ�� �� ������ ����Ʈ (��������)
- zipdoro ���̺� ��Ŭ�� �� export

select count(*) from zipdoro;   --��ü �� ���� ��ȸ�ϱ�

��1) ����Ư���� �������� ���۵Ǵ� �����ȣ�� ����� ��ȸ�Ͻÿ�
select count(zipno)
from zipdoro 
where zipaddress like '����Ư���� ������%';

//////////////////////////////////////////////////////////

��2) �ѱ��������б�_���ߵ��б���ġ.csv�� ��ȯ�Ͻÿ� (11872��)

�б�ID,�б���,�б��ޱ���,���������θ��ּ�,��������,��������,����,�浵
create table sclocation (
        scid    varchar(1000)       --�б� ID
       ,scname  varchar(1000)       --�б���
       ,scclass varchar(1000)       --�б��ޱ���
       ,scaddress varchar(1000)     --���������θ��ּ�
       ,sdate date                  --��������
       ,cdate date                  --��������
       ,latitude varchar(1000)      --����
       ,longitude varchar(1000)     --�浵
       );

-- ����ִ� ��(null)�� ã���ÿ�
select * from sclocation where scaddress is null;









