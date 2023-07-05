select c.name, o.custid, c.custid, o.saleprice
from customer c, orders o
where c.custid=o.custid(+);

select *
from orders, customer;

-- 고객별로 주문한 모든 도서의 총 판매액을 구하고, 고객별로 정렬하시오.
select custid, sum(saleprice) as "합계" 
from orders group by custid order by custid;

-- 고객의 이름과 고객이 주문한 도서의 이름을 구하시오.
select c.name, b.bookname
from customer c, orders o, book b
where c.custid=o.custid and b.bookid=o.bookid;

-- 가격이 20000원인 도서를 주문한 고객의 이름과 도서의 이름을 구하시오.
select c.name, b.bookname 
from customer c, orders o, book b 
where c.custid =  o.custid and b.bookid = o.bookid and o.saleprice = 20000;

-- JOIN : inner join vs outer join
select c.custid, o.custid, c.name, o.saleprice
from customer c, orders o
where c.custid = o.custid;


-- '대한미디어'에서 출판한 도서를 구매한 고객의 이름을 검색하시오.
select name
from customer
where custid in (select custid from orders
where bookid in (select bookid from book
where publisher = '대한미디어'));

-- 출판사별로 출판사의 평균 도서 가격보다 비싼 도서를 검색하시오.
select b1.bookname , b1.price, b1.publisher
from book b1
where b1.price > (select avg(price) 
from book b2 where b2.publisher=b1.publisher);

-- 도서를 주문하지 않은 고객의 이름을 검색하시오.
select name
from customer
minus
select name
from customer
where custid in (select custid from orders);

-- 주문이 있는 고객의 이름과 주소를 검색하시오.
select name, address
from customer
where custid in (select custid from orders);

select name, address
from customer cs
where exists ( select * from orders od
where cs.custid = od.custid);

-- 계산
select ABS(-78), ABS(+78)from dual;
select Round(4.875, 1) from dual;

-- 고객별 평균 주문 금액을 백원 단위로 반올림한 값을 구하시오.
select custid, ROUND(avg(saleprice), -2) as "평균 가격"
from orders
group by custid;

select c.name, round(avg(saleprice), -2) as "평균 가격"
from orders o, customer c
where o.custid = c.custid
group by name;

select custid, round(avg(saleprice),-2) as "평균 가격"
from orders
group by custid;

-- 도서 제목에 '야구'가 포함된 도서를 '농구'로 변경한 후 도서 목록, 가격을 구하시오.
select bookid, replace(bookname, '야구','농구') as bookname, price
from book;

-- '굿스포츠' 에서 출판한 도서의 제목과 제목의 글자 수, 바이트 수를 구하시오.
select bookname, length(bookname) as "제목 길이", lengthb(bookname) as "바이트 수", publisher
from book
where publisher = '굿스포츠';

-- 데이터 입력
select * from customer;
insert into customer values ( 6, '박찬호', '대한민국 공주', null);

-- 마당서점의 고객 중에서 같은 성을  가진 사람이 몇 명이나 되는지 성 별 인원수를 구하시오.
select substr(name, 1, 1) as 성, count(substr(name,1, 1)) as 수
from customer
group by substr(name, 1, 1);

-- 마당서점은 주문일로부터 10일 후 매출을 확정한다. 각 주문의 확정일자를 구하시오.
SELECT orderid, custid, bookid, saleprice, to_char(orderdate + 10, 'yyyy-mm-dd day') "확정일자"
FROM orders;

-- 현재 날짜
select sysdate from dual;
-- to_char 함수를 사용하여 sysdate 값을 문자열 형식으로 변환
select sysdate, to_char(sysdate, 'yyyy/mm/dd dy hh24:mi:ss') sysdate1 from dual;

select * from orders;
--과제1_0509.마당서점이 2020년 7월 7일에 주문받은 도서의 주문번호, 주문일, 고객번호, 도서번호를 
--모두 구하세요. 단, 주문일은 ‘yyyy-mm-dd 요일’ 형태로 표시한다.
select orderid, to_char(orderdate, 'yyyy-mm-dd dy') as 주문일, custid, bookid
from orders
where orderdate = '20/07/07';

--과제2_0509.Q.DBMS 서버에 설정된 현재 날짜와 시간, 요일을 확인하시오.
select to_char(sysdate, 'yyyy/mm/dd dy hh24:mi:ss') as 시각 from dual;


--과제3_0509. 이름, 전화번호가 포함된 고객목록을 보이시오. 단, 전화번호가 없는 고객은 ‘연락처없음’으로 
--표시하세요.(NVL 함수는 값이 NULL인 경우 지정값을 출력하고, NULL이 아니면 원래 값을 그대로 출력한다.
--함수  :  NVL("값", "지정값") 
select name as 이름, nvl(phone, '연락처없음') as 연락처
from customer;

-- nvl 함수는 두 개의 인수만 비교하고 coalesce 함수는 여러 인수를 비교하고 첫 번째 null이 아닌 수의
-- 첫 번째 인수가 반환
select name as 이름, phone, coalesce(phone,'연락처없음') as 전화번호
from customer;

--과제4_0509. 고객목록에서 고객번호, 이름, 전화번호를 앞의 두 명만 보이세요.
select custid, name, phone
from customer
FETCH FIRST 2 ROWS ONLY;

select rownum, custid, name, phone
from customer
where rownum <= 2;

--과제5_0509. 평균 주문금액 이하의 주문에 대해서 주문번호와 금액을 보이세요.
select orderid, saleprice
from orders
where saleprice < (select avg(saleprice) from orders);

--과제6_0509. 각 고객의 평균 주문금액보다 큰 금액의 주문 내역에 대해서 주문번호, 고객번호, 
--금액을 보이시오.
select orderid, custid, saleprice
from orders
WHERE saleprice > (
  SELECT AVG(saleprice) AS avg_saleprice
  FROM orders o2
  WHERE o2.custid = orders.custid
  GROUP BY custid
);

--과제7_0509.‘대한민국’에 거주하는 고객에게 판매한 도서의 총 판매액을 구하세요.
select custid, sum(saleprice)
from orders
where orders.custid in 
(select custid
from customer
where address like '%대한민국%')
group by orders.custid;


select * from orders;
-- 과제 8_0509. 3번 고객이 주문한 도서의 최고 금액보다 더 비싼 도서를 구입한 주문의 주문 번호와 금액을 구하시오.
select orderid, saleprice
from orders
where saleprice > (select max(saleprice) from orders where custid = 3);

-- 과제 9_0509. Exists 연산자를 사용하여 '대한민국'에 거주하는 고객에게 판매한 도서의 총 판매액을 구하시오.
SELECT orders.custid, SUM(orders.saleprice) as "총 판매액"
FROM orders
WHERE EXISTS (
  SELECT custid
  FROM customer
  WHERE address LIKE '%대한민국%'
    AND orders.custid = customer.custid
)
GROUP BY orders.custid;




-- 과제 10_0509. 마당서점의 고객별 판매액을 보이시오. (고객 이름과 고객별 판매액 출력)
select custid, sum(saleprice)
from orders
group by custid;



select c.name as 고객이름, nvl(sum(o.saleprice) , 0) as "고객 별 판매액"
from customer c, orders o
where c.custid = o.custid(+)
group by c.name;

--update set
update customer
set phone = '010-1234-5678'
where custid = 1;
select * from customer;

-- 과제 11_0509. 고객번호가 2 이하인 고객의 판매액을 보이시오.(고객 이름과 고객 별 판매액 출력)
select custid, sum(saleprice)
from orders
where custid <= 2
group by custid;


-- View는 가상의 테이블이라고 했는데, 말그대로 데이터는 없고, SQL만 저장되어있는 object
--만들어진 뷰의 기본 테이블의 기본키(속성)을 포함하여 뷰를 생성하면 삽입, 삭제, 갱신, 연산이 가능 합니다. 
--또한 한번 정의가 된 뷰의 경우 다른 뷰의 기본 데이터가 될 수 있으며, 뷰에 정의되어 있는 기본 테이블이나 뷰를 삭제 하게 되면 
--해당 데이터를 기초로한 다른 뷰들이 자동으로 삭제가 됩니다.뷰에서는 ALTER 명령어를 사용 할 수 없습니다.

-- 주소에 '대한민국'을 포함하는 고객들로 구성된 뷰를 만들고 조회하시오. 뷰의 이름은 vw_customer로 설정하시오.
create view vw_customer
as select *
from customer
where address like '%대한민국%';

select * from vw_customer;
