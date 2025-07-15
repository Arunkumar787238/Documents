use Developer

create table TBLCustomer1
(
     FLDCUSTOMERID INT 
	,FLDCUSTOMERNAME VARCHAR(20)
	,FLDCITY VARCHAR(20)
	)

	INSERT INTO TBLCustomer1 
	VALUES 
	(1,'Alice','New York'),
	(2,'Bob','Los Angeles'),
	(3,'Carol','Chicago'),
	(4,'Dave','Houston'),
	(5,'Emma','Miami')

	select * from TBLCustomer1



Create table TBLORDERS1
(
   FLDORDERID INT
   ,FLDCUSTOMERID INT
   ,FLDORDERAMOUNT INT
   ,FLDORDERDATE DATE

)


   INSERT INTO TBLORDERS1 VALUES
   (101,1,200,'2024-01-05'),
    (102,2,500,'2024-01-08'),
	 (103,1,300,'2024-02-10'),
	  (104,5,450,'2024-03-12'),
	   (105,'',350,'2024-04-15')


	   SELECT * FROM TBLORDERS1
	   DELETE FROM TBLORDERS1 WHERE FLDORDERID=105
	   INSERT INTO TBLORDERS1 VALUES (105,NULL,350,'2024-04-15')



CREATE TABLE TBLPRODUCTS
(
   FLDPRODUCTID INT 
   ,FLDPRODUCTNAME VARCHAR(20)
   ,FLDPRICE INT
)

      INSERT INTO TBLPRODUCTS
	  VALUES 
	  (1,'Laptop',1000),
	  (2,'Smartphone',700),
	  (3,'Tablet',500)

select * from TBLPRODUCTS



create table TBLORDERDETAILS
(
  FLDORDERID INT
  ,FLDPRODUCTID INT
  ,FLDQUANTITY INT
)


INSERT INTO TBLORDERDETAILS
VALUES
      (101,1,2),
	  (101,2,1),
	  (102,3,1),
	  (103,1,1),
	  (104,2,3),
	  (105,3,2)

	  TRUNCATE TABLE TBLORDERDETAILS


---------------------------------------------------------------------------------------------------------------------

--1)  jOIN WITH SUBQUERY

       SELECT * FROM TBLCustomer1
	   SELECT * FROM TBLORDERS1

       SELECT * FROM TBLCustomer1 C1
	   INNER JOIN TBLORDERS1 O1
	   ON
	   C1.FLDCUSTOMERID=O1.FLDCUSTOMERID
	   WHERE O1.FLDORDERAMOUNT > (SELECT AVG(FLDORDERAMOUNT) FROM TBLORDERS1)    
	   
	   (or)
	   

	  SELECT C1.FLDCUSTOMERNAME,SUM(O1.FLDORDERAMOUNT) FROM TBLCustomer1 C1
	   INNER JOIN TBLORDERS1 O1
	   ON
	   C1.FLDCUSTOMERID=O1.FLDCUSTOMERID
	   GROUP BY C1.FLDCUSTOMERNAME
	   HAVING SUM(O1.FLDORDERAMOUNT) > (SELECT AVG(FLDORDERAMOUNT) FROM TBLORDERS1)    
						


	   		 
	   SELECT AVG(FLDORDERAMOUNT) FROM TBLORDERS1  --360


--2) Self join to find duplicate orders

        	--Write a query using a Self Join on the Orders table to find any duplicate orders based on OrderAmount and OrderDate.

			select * from TBLORDERS1
			select * from TBLCustomer1

			select * from TBLORDERS1 o1
			inner join TBLORDERS1 o2
			on o1.FLDCUSTOMERID != o2.FLDCUSTOMERID
			where not in (select FLDCUSTOMERID from TBLORDERS1)

			INSERT INTO TBLORDERS1 VALUES(102,2,700,'2024-01-08')



			SELECT DISTINCT(o1.FLDCUSTOMERID) , o2.FLDCUSTOMERID , o1.FLDORDERAMOUNT, o1.FLDORDERDATE FROM TBLORDERS1 o1
            INNER JOIN TBLORDERS1 o2 
            ON o1.FLDORDERAMOUNT = o2.FLDORDERAMOUNT
                AND o1.FLDORDERDATE = o2.FLDORDERDATE
                AND o1.FLDCUSTOMERID > o2.FLDCUSTOMERID
            ORDER BY o1.FLDORDERAMOUNT, o1.FLDORDERDATE;

			SELECT DISTINCT(FLDCUSTOMERID) FROM TBLORDERS1


----------------------------------------------------------------------------------------------------------------------------------


--   3) Retrieve a list of customers along with the total quantity of products ordered by each customer, using 
--      Inner Join across Customers, Orders, and OrderDetails.

   SELECT * FROM TBLCustomer1
   SELECT * FROM TBLORDERS1
   SELECT * FROM TBLORDERDETAILS

   
      select C.FLDCUSTOMERNAME,SUM(FLDQUANTITY) AS QUANTITY from TBLORDERS1 o
        inner join TBLCustomer1 C
        on 
        o.FLDCUSTOMERID=C.FLDCUSTOMERID
        INNER JOIN TBLORDERDETAILS OD
        ON
        O.FLDORDERID=OD.FLDORDERID
        GROUP BY C.FLDCUSTOMERNAME


------------------------------------------------------------------------------------------------------------

--4) Left Join with Non-Matching Rows Filter
--	List all products that have never been ordered, using a Left Join between Products and OrderDetails.

  --1--
     select * from  TBLPRODUCTS p1
	 left join TBLORDERDETAILS o1
	 on
	 p1.FLDPRODUCTID=o1.FLDPRODUCTID

	 --2--
	  SELECT p.FLDPRODUCTID, p.FLDPRODUCTNAME, *
      FROM TBLPRODUCTS p
      LEFT JOIN TBLORDERDETAILS od ON p.FLDPRODUCTID = od.FLDPRODUCTID
      WHERE od.FLDPRODUCTID IS  NULL;


------------------------------------------------------------------------------------------------------------

	--5) List all orders that include products costing more than $500 and where the order amount is above $200. 
	--   Use a Join between Orders, OrderDetails, and Products tables.
	
	   select * from TBLORDERS1
	   select * from TBLORDERDETAILS
	   select * from TBLPRODUCTS

	   SELECT o.FLDCUSTOMERID, o.FLDORDERDATE, od.FLDPRODUCTID, p.FLDPRODUCTNAME, p.FLDPRICE, od.FLDQUANTITY, (p.FLDPRICE * od.FLDQUANTITY) AS TotalPricePerProduct, o.FLDORDERAMOUNT
       FROM TBLORDERS1 o
       JOIN TBLORDERDETAILS od ON o.FLDORDERID = od.FLDORDERID
       JOIN TBLPRODUCTS p ON od.FLDPRODUCTID = p.FLDPRODUCTID
       WHERE p.FLDPRICE > 500
       AND (p.FLDPRICE * od.FLDQUANTITY) > 200;


    select * from TBLORDERS1 o
	  join TBLORDERDETAILS od on o.FLDORDERID=od.FLDORDERID
	  join TBLPRODUCTS p on od.FLDPRODUCTID=p.FLDPRODUCTID



-------------------------------------------------------------------------------------------------------------------

--6)	Retrieve all customer names and order details. For customers from "New York,"
--   only include orders above $250; for other customers, include all orders.


select * from TBLCustomer1 c
full outer join TBLORDERDETAILS od 
on c.FLDCUSTOMERID=od.FLDORDERID
full outer join TBLORDERS1 O 
on od.FLDORDERID=O.FLDORDERID
where c.FLDCITY='New York'


   ---- or-- its correct


SELECT c.FLDCUSTOMERNAME, o.FLDORDERID, o.FLDORDERDATE, od.FLDPRODUCTID, p.FLDPRODUCTNAME, p.FLDPRICE,
     od.FLDQUANTITY, (p.FLDPRICE * od.FLDQUANTITY) AS TotalPricePerProduct
FROM TBLCustomer1 c
JOIN TBLORDERS1 o ON c.FLDCUSTOMERID = o.FLDCUSTOMERID
JOIN TBLORDERDETAILS od ON o.FLDORDERID = od.FLDORDERID
JOIN TBLPRODUCTS p ON od.FLDPRODUCTID = p.FLDPRODUCTID
WHERE (c.FLDCITY = 'New York' AND (p.FLDPRICE * od.FLDQUANTITY) > 250)
   OR (c.FLDCITY != 'New York');

   

   
SELECT c.FLDCUSTOMERNAME, o.FLDORDERID, o.FLDORDERDATE, od.FLDPRODUCTID, p.FLDPRODUCTNAME, p.FLDPRICE,
     od.FLDQUANTITY, (p.FLDPRICE * od.FLDQUANTITY) AS TotalPricePerProduct
FROM TBLCustomer1 c
JOIN TBLORDERS1 o ON c.FLDCUSTOMERID = o.FLDCUSTOMERID
JOIN TBLORDERDETAILS od ON o.FLDORDERID = od.FLDORDERID
JOIN TBLPRODUCTS p ON od.FLDPRODUCTID = p.FLDPRODUCTID
WHERE (c.FLDCITY = 'New York' AND (p.FLDPRICE * od.FLDQUANTITY) > 250)
   OR (c.FLDCITY != 'New York');





	 
