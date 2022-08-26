
i:\java202207\database\20220825_02�л����.sql
////////////////////////////////////////////////////////////////////////////////



1. ���̺� ����
---------------------- �л����̺�
create table tb_student(
   hakno    char(5)     not null         --�й�
  ,uname    varchar(20) not null         --�̸�
  ,email    varchar(20) unique           --�̸���
  ,address  varchar(20) not null         --�ּ�
  ,phone    varchar(20)                  --��ȭ��ȣ
  ,regdt    date        default sysdate  --�����
  ,primary key(hakno)                    --�⺻Ű
);

---------------------- �������̺�
create table tb_gwamok(
   gcode    char(4)      not null        --�����ڵ� (p:���α׷�������, d:�����α�����)
  ,gname    varchar(20)  not null        --�����̸�
  ,ghakjum  number(2)    default 1       --����
  ,regdt    date         default sysdate --�����
  ,primary key(gcode)                    --�⺻Ű
);

---------------------- �������̺�
create table tb_sugang(
   sno    number(3)  not null   --�Ϸù�ȣ
  ,hakno  char(5)    not null   --�й�
  ,gcode  char(4)    not null   --�����ڵ�
  ,primary key(sno)             --�⺻Ű
);



2. �������̺� ������ ����
create sequence sugang_seq;




3. �� �߰�
----------------------------------------tb_student���̺� �� �߰� �ϱ�
insert into tb_student(hakno,uname,address,phone,email)
values('g1001','ȫ�浿','����','111-5558','11@naver.com');

insert into tb_student(hakno,uname,address,phone,email)
values('g1002','ȫ�浿','����','787-8877','33@daum.net');

insert into tb_student(hakno,uname,address,phone,email)
values('g1003','������','����','554-9632','77@naver.com');
insert into tb_student(hakno,uname,address,phone,email)
values('g1004','ȫ�浿','�λ�','555-8844','88@daum.net');

insert into tb_student(hakno,uname,address,phone,email)
values('g1005','���޷�','����','544-6996','33@nate.com');

insert into tb_student(hakno,uname,address,phone,email)
values('g1006','������','����','777-1000','66@naver.com');



----------------------------------------tb_gwamok���̺� �� �߰� �ϱ�
insert into tb_gwamok(gcode,gname,ghakjum) values('p001','JAVA',3);
insert into tb_gwamok(gcode,gname,ghakjum) values('p002','Oracle',3);
insert into tb_gwamok(gcode,gname,ghakjum) values('p003','JSP',2);
insert into tb_gwamok(gcode,gname,ghakjum) values('d001','HTML',1);
insert into tb_gwamok(gcode,gname,ghakjum) values('d002','���伥',5);
insert into tb_gwamok(gcode,gname,ghakjum) values('d003','�Ϸ���Ʈ',3);
insert into tb_gwamok(gcode,gname,ghakjum) values('d004','CSS',1);
insert into tb_gwamok(gcode,gname,ghakjum) values('p004','Python',3);
insert into tb_gwamok(gcode,gname,ghakjum) values('p005','AJAX',2);



----------------------------------------tb_sugang���̺� �� �߰� �ϱ�
insert into tb_sugang(sno,hakno,gcode) values(sugang_seq.nextval,'g1001','p001');
insert into tb_sugang(sno,hakno,gcode) values(sugang_seq.nextval,'g1002','p002');
insert into tb_sugang(sno,hakno,gcode) values(sugang_seq.nextval,'g1002','p001');
insert into tb_sugang(sno,hakno,gcode) values(sugang_seq.nextval,'g1002','p003');
insert into tb_sugang(sno,hakno,gcode) values(sugang_seq.nextval,'g1001','p003');
insert into tb_sugang(sno,hakno,gcode) values(sugang_seq.nextval,'g1001','p004');
insert into tb_sugang(sno,hakno,gcode) values(sugang_seq.nextval,'g1005','p001');
insert into tb_sugang(sno,hakno,gcode) values(sugang_seq.nextval,'g1005','d001');
insert into tb_sugang(sno,hakno,gcode) values(sugang_seq.nextval,'g1005','d002');
insert into tb_sugang(sno,hakno,gcode) values(sugang_seq.nextval,'g1005','d003');
insert into tb_sugang(sno,hakno,gcode) values(sugang_seq.nextval,'g1001','d001');
insert into tb_sugang(sno,hakno,gcode) values(sugang_seq.nextval,'g1001','p002');
insert into tb_sugang(sno,hakno,gcode) values(sugang_seq.nextval,'g1006','p001');
///////////////////////////////////////////////////////////////////////////////////////////////

commit;

-- tb_student ���̺� ��ü ���ڵ� ����
select count(*) from tb_student;     --6

-- tb_gwamok ���̺� ��ü ���ڵ� ����
select count(*) from tb_gwamok;    --9

-- tb_sugang ���̺� ��ü ���ڵ� ����
select count(*) from tb_sugang;     --13
////////////////////////////////////////////////////////////////////////////////////////////////


�� [���� ���Ἲ ��������]
- foreign key ��������
- ������ ���̺� �Ǵ� �ٸ� ���̺��� �⺻Ű �Ǵ� ����Ű�� �����ϴ� ���� ����
- on delete cascade  �θ����̺��� ���� �����Ǵ� ��� �ڽ����̺��� �������� ����
- on delete set null �θ����̺��� ���� �����Ǵ� ��� ���� �ܷ�Ű ���� null�� ��ȯ
- �θ� : Primary Key �⺻Ű <---> �ڽ� : Foreign Key �ܷ�Ű

��) �������̺� ��������
    create table tb_sugang(
       sno    number(3)  not null
      ,hakno  char(5)    not null
      ,gcode  char(4)    not null
      ,primary key(sno)                                                 --snoĮ�� �⺻Ű
      ,foreign key(hakno) references tb_student(hakno)       --haknoĮ���� �θ����̺�(�л�)�� hakno ����
      ,foreign key(gcode) references tb_gwamok(gcode)     --gcodeĮ���� �θ����̺�(����)�� gcode ����
       on update cascade                                             --�θ����̺��� ���� �����Ǹ� �ڽ����̺� ���� ���� ����
       on delete no action                                              --�θ����̺��� ���� �����Ǵ��� �ڽ����̺��� �������� ����
    );

////////////////////////////////////////////////////////////////////////////////////////////
��1)�л����̺��� ������ �ο����� �ο��������� ��ȸ�Ͻÿ�
select * from tb_student;
select address, count(*) from tb_student group by address;
select distinct(address), count(*) from tb_student group by address; --distinct ���


��2)�л����̺��� ���������� �� ������� ��ȸ�Ͻÿ�
select * from tb_student;
select distinct(uname), count(*) from tb_student group by uname;



��3)�л����̺��� �й�, �̸�, �ּҸ� ��ȸ�Ͻÿ� (�ּҴ� �������� ���)
select * from tb_student;
select hakno, uname, address from tb_student;
select hakno, uname, case when address='����' then 'Seoul'
                              when address='����' then 'Jeju'
                              when address='�λ�' then 'Busan'
                              end address
                              from tb_student;
                                                 
                                                 

��4)�л����̺��� �ּҺ� �ο����� 3��̸� ���� ��ȸ�Ͻÿ�
select address, count(*) from tb_student group by address having count(*)<3 ;



��5)�������̺��� ���α׷� ������ ��ȸ�Ͻÿ�
select * from tb_gwamok;
select * from tb_gwamok where gcode like 'p%';



��6)�������̺��� ������ �������߿��� 3������ ��ȸ�Ͻÿ�x
select * from tb_gwamok;
select gcode, gname, ghakjum from tb_gwamok where gcode like 'd%'and  ghakjum=3;



��7)�������̺��� ���α׷� �������� ���� ��պ��� ���� ���α׷� �������� ��ȸ�Ͻÿ�
select * from tb_gwamok;

--���α׷� ������ ���� ��� ���ϱ�
select avg(ghakjum) from tb_gwamok where gcode like 'p%';

-- ���α׷� �������� ���� ��պ��� ���� ���α׷� ������ ��ȸ
select gname, ghakjum from tb_gwamok 
where ghakjum<(select avg(ghakjum) from tb_gwamok where gcode like 'p%');


commit;






















