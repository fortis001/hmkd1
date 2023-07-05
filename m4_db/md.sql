select c.name, o.custid, c.custid, o.saleprice
from customer c, orders o
where c.custid=o.custid(+);

select *
from orders, customer;

-- ������ �ֹ��� ��� ������ �� �Ǹž��� ���ϰ�, ������ �����Ͻÿ�.
select custid, sum(saleprice) as "�հ�" 
from orders group by custid order by custid;

-- ���� �̸��� ���� �ֹ��� ������ �̸��� ���Ͻÿ�.
select c.name, b.bookname
from customer c, orders o, book b
where c.custid=o.custid and b.bookid=o.bookid;

-- ������ 20000���� ������ �ֹ��� ���� �̸��� ������ �̸��� ���Ͻÿ�.
select c.name, b.bookname 
from customer c, orders o, book b 
where c.custid =  o.custid and b.bookid = o.bookid and o.saleprice = 20000;

-- JOIN : inner join vs outer join
select c.custid, o.custid, c.name, o.saleprice
from customer c, orders o
where c.custid = o.custid;


-- '���ѹ̵��'���� ������ ������ ������ ���� �̸��� �˻��Ͻÿ�.
select name
from customer
where custid in (select custid from orders
where bookid in (select bookid from book
where publisher = '���ѹ̵��'));

-- ���ǻ纰�� ���ǻ��� ��� ���� ���ݺ��� ��� ������ �˻��Ͻÿ�.
select b1.bookname , b1.price, b1.publisher
from book b1
where b1.price > (select avg(price) 
from book b2 where b2.publisher=b1.publisher);

-- ������ �ֹ����� ���� ���� �̸��� �˻��Ͻÿ�.
select name
from customer
minus
select name
from customer
where custid in (select custid from orders);

-- �ֹ��� �ִ� ���� �̸��� �ּҸ� �˻��Ͻÿ�.
select name, address
from customer
where custid in (select custid from orders);

select name, address
from customer cs
where exists ( select * from orders od
where cs.custid = od.custid);

-- ���
select ABS(-78), ABS(+78)from dual;
select Round(4.875, 1) from dual;

-- ���� ��� �ֹ� �ݾ��� ��� ������ �ݿø��� ���� ���Ͻÿ�.
select custid, ROUND(avg(saleprice), -2) as "��� ����"
from orders
group by custid;

select c.name, round(avg(saleprice), -2) as "��� ����"
from orders o, customer c
where o.custid = c.custid
group by name;

select custid, round(avg(saleprice),-2) as "��� ����"
from orders
group by custid;

-- ���� ���� '�߱�'�� ���Ե� ������ '��'�� ������ �� ���� ���, ������ ���Ͻÿ�.
select bookid, replace(bookname, '�߱�','��') as bookname, price
from book;

-- '�½�����' ���� ������ ������ ����� ������ ���� ��, ����Ʈ ���� ���Ͻÿ�.
select bookname, length(bookname) as "���� ����", lengthb(bookname) as "����Ʈ ��", publisher
from book
where publisher = '�½�����';

-- ������ �Է�
select * from customer;
insert into customer values ( 6, '����ȣ', '���ѹα� ����', null);

-- ���缭���� �� �߿��� ���� ����  ���� ����� �� ���̳� �Ǵ��� �� �� �ο����� ���Ͻÿ�.
select substr(name, 1, 1) as ��, count(substr(name,1, 1)) as ��
from customer
group by substr(name, 1, 1);

-- ���缭���� �ֹ��Ϸκ��� 10�� �� ������ Ȯ���Ѵ�. �� �ֹ��� Ȯ�����ڸ� ���Ͻÿ�.
SELECT orderid, custid, bookid, saleprice, to_char(orderdate + 10, 'yyyy-mm-dd day') "Ȯ������"
FROM orders;

-- ���� ��¥
select sysdate from dual;
-- to_char �Լ��� ����Ͽ� sysdate ���� ���ڿ� �������� ��ȯ
select sysdate, to_char(sysdate, 'yyyy/mm/dd dy hh24:mi:ss') sysdate1 from dual;

select * from orders;
--����1_0509.���缭���� 2020�� 7�� 7�Ͽ� �ֹ����� ������ �ֹ���ȣ, �ֹ���, ����ȣ, ������ȣ�� 
--��� ���ϼ���. ��, �ֹ����� ��yyyy-mm-dd ���ϡ� ���·� ǥ���Ѵ�.
select orderid, to_char(orderdate, 'yyyy-mm-dd dy') as �ֹ���, custid, bookid
from orders
where orderdate = '20/07/07';

--����2_0509.Q.DBMS ������ ������ ���� ��¥�� �ð�, ������ Ȯ���Ͻÿ�.
select to_char(sysdate, 'yyyy/mm/dd dy hh24:mi:ss') as �ð� from dual;


--����3_0509. �̸�, ��ȭ��ȣ�� ���Ե� ������� ���̽ÿ�. ��, ��ȭ��ȣ�� ���� ���� ������ó���������� 
--ǥ���ϼ���.(NVL �Լ��� ���� NULL�� ��� �������� ����ϰ�, NULL�� �ƴϸ� ���� ���� �״�� ����Ѵ�.
--�Լ�  :  NVL("��", "������") 
select name as �̸�, nvl(phone, '����ó����') as ����ó
from customer;

-- nvl �Լ��� �� ���� �μ��� ���ϰ� coalesce �Լ��� ���� �μ��� ���ϰ� ù ��° null�� �ƴ� ����
-- ù ��° �μ��� ��ȯ
select name as �̸�, phone, coalesce(phone,'����ó����') as ��ȭ��ȣ
from customer;

--����4_0509. ����Ͽ��� ����ȣ, �̸�, ��ȭ��ȣ�� ���� �� �� ���̼���.
select custid, name, phone
from customer
FETCH FIRST 2 ROWS ONLY;

select rownum, custid, name, phone
from customer
where rownum <= 2;

--����5_0509. ��� �ֹ��ݾ� ������ �ֹ��� ���ؼ� �ֹ���ȣ�� �ݾ��� ���̼���.
select orderid, saleprice
from orders
where saleprice < (select avg(saleprice) from orders);

--����6_0509. �� ���� ��� �ֹ��ݾ׺��� ū �ݾ��� �ֹ� ������ ���ؼ� �ֹ���ȣ, ����ȣ, 
--�ݾ��� ���̽ÿ�.
select orderid, custid, saleprice
from orders
WHERE saleprice > (
  SELECT AVG(saleprice) AS avg_saleprice
  FROM orders o2
  WHERE o2.custid = orders.custid
  GROUP BY custid
);

--����7_0509.�����ѹα����� �����ϴ� ������ �Ǹ��� ������ �� �Ǹž��� ���ϼ���.
select custid, sum(saleprice)
from orders
where orders.custid in 
(select custid
from customer
where address like '%���ѹα�%')
group by orders.custid;


select * from orders;
-- ���� 8_0509. 3�� ���� �ֹ��� ������ �ְ� �ݾ׺��� �� ��� ������ ������ �ֹ��� �ֹ� ��ȣ�� �ݾ��� ���Ͻÿ�.
select orderid, saleprice
from orders
where saleprice > (select max(saleprice) from orders where custid = 3);

-- ���� 9_0509. Exists �����ڸ� ����Ͽ� '���ѹα�'�� �����ϴ� ������ �Ǹ��� ������ �� �Ǹž��� ���Ͻÿ�.
SELECT orders.custid, SUM(orders.saleprice) as "�� �Ǹž�"
FROM orders
WHERE EXISTS (
  SELECT custid
  FROM customer
  WHERE address LIKE '%���ѹα�%'
    AND orders.custid = customer.custid
)
GROUP BY orders.custid;




-- ���� 10_0509. ���缭���� ���� �Ǹž��� ���̽ÿ�. (�� �̸��� ���� �Ǹž� ���)
select custid, sum(saleprice)
from orders
group by custid;



select c.name as ���̸�, nvl(sum(o.saleprice) , 0) as "�� �� �Ǹž�"
from customer c, orders o
where c.custid = o.custid(+)
group by c.name;

--update set
update customer
set phone = '010-1234-5678'
where custid = 1;
select * from customer;

-- ���� 11_0509. ����ȣ�� 2 ������ ���� �Ǹž��� ���̽ÿ�.(�� �̸��� �� �� �Ǹž� ���)
select custid, sum(saleprice)
from orders
where custid <= 2
group by custid;


-- View�� ������ ���̺��̶�� �ߴµ�, ���״�� �����ʹ� ����, SQL�� ����Ǿ��ִ� object
--������� ���� �⺻ ���̺��� �⺻Ű(�Ӽ�)�� �����Ͽ� �並 �����ϸ� ����, ����, ����, ������ ���� �մϴ�. 
--���� �ѹ� ���ǰ� �� ���� ��� �ٸ� ���� �⺻ �����Ͱ� �� �� ������, �信 ���ǵǾ� �ִ� �⺻ ���̺��̳� �並 ���� �ϰ� �Ǹ� 
--�ش� �����͸� ���ʷ��� �ٸ� ����� �ڵ����� ������ �˴ϴ�.�信���� ALTER ��ɾ ��� �� �� �����ϴ�.

-- �ּҿ� '���ѹα�'�� �����ϴ� ����� ������ �並 ����� ��ȸ�Ͻÿ�. ���� �̸��� vw_customer�� �����Ͻÿ�.
create view vw_customer
as select *
from customer
where address like '%���ѹα�%';

select * from vw_customer;
