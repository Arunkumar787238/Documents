create database Developer122

use Developer122

create table TBLEMPLOYEE
   (
     FLDEMPID INT PRIMARY KEY IDENTITY(1,1),
	 FLDEMPNAME VARCHAR(20) NOT NULL,
	 FLDEMPAGE INT NOT NULL,
	 FLDGENDER VARCHAR(20) NOT NULL,
	 FLDEMAIL VARCHAR(30) UNIQUE,
	 FLDDOB DATE NOT NULL,
	 FLDDEPARTMENT VARCHAR(20) DEFAULT('IT'),
	 FLDMOBILE BIGINT
	 )


	 SELECT * FROM TBLEMPLOYEE

	 -- INSERT DATAS --

	 INSERT INTO TBLEMPLOYEE(FLDEMPNAME,FLDEMPAGE,FLDGENDER,FLDEMAIL,FLDDOB,FLDMOBILE)
	 VALUES('GUNA',27,'MALE','GUNA123@GMAIL.COM','1998/01/27',9800154859),
	 ('SARAN',27,'MALE','SARAN123@GMAIL.COM','1998/11/02',9563251425),
	 ('UVANESH',26,'MALE','YUVAN@GMAIL.COM','1998/08/05',7359462135),
	 ('MALAR',24,'FEMALE','MALAR123@GMAIL.COM','2000/06/08',8608882320),
	 ('GANESH',25,'MALE','GANESH123@GMAIL.COM','1999/03/13',7698532145),
	 ('SANDHIYA',24,'FEMALE','SANDHIYA123@GMAIL.COM','1998/01/27',9800154859)


	 -- UPDATE DATA --

	 UPDATE TBLEMPLOYEE SET FLDMOBILE=7358178456 WHERE FLDEMPID=7
	 UPDATE TBLEMPLOYEE SET FLDMOBILE=90800178456, FLDEMAIL='SANDHIYA@GMAIL.COM' WHERE FLDEMPID=7
	 update TBLEMPLOYEE SET FLDNETSALARY=44000 WHERE FLDEMPID IN(5)

	 SELECT * FROM TBLEMPLOYEE

	 -- DELETE DATA --

	 DELETE FROM TBLEMPLOYEE WHERE FLDEMPID=6


	 -- ADD ONE COLUMN --

	 ALTER TABLE TBLEMPLOYEE
	 ADD FLDSALARY INT

	 -- ALTER COLUMN NAME --
	 ALTER TABLE TBLEMPLOYEE	   
   	EXEC sp_rename 'TBLEMPLOYEE.FLDSALARY',  'FLDNETSALARY', 'COLUMN';


	--- TRUNCATE AND DROP --

	TRUNCATE TABLE TBLEMPLOYEE
	DROP TABLE TBLEMPLOYEE


	-- INSERT ANOTHER METHOD -- 


	--- JOINS --
	-- Customer table --

	CREATE TABLE TBLCustomers
	(
	  FLDCustomerID int Not Null ,
	  FLDCustomerName varchar(20),
	  FLDCity varchar(20)
	  CONSTRAINT PK_CURD PRIMARY KEY(FLDCustomerID)
	)


   SELECT * FROM TBLCustomers
   select * from TBLOrders


	insert into TBLCustomers values(1,'Alice','New York'),(2,'Bob','Los Angeles'),(3,'Carol','Chicago'),(4,'Dave','Houston')

	



	-- Order table --

	create table TBLOrders
	(
	 FLDOrderID int 
	 ,FLDCustomerID int 
	 ,FLDOrderAmount int 
	 ,FLDOrderDate DATE	         
	)

	
	insert into TBLOrders(FLDOrderID,FLDCustomerID,FLDOrderAmount,FLDOrderDate) values(105,5,550,'2024-03-12')
	(101,1,200,'2024-01-05'),
	(102,2,500,'2024-01-08'),
	(103,1,300,'2024-02-10'),
	(104,4,450,'2024-03-12')

	select * from TBLOrders
	SELECT * FROM TBLCustomers

	-- inner join --


	select * from TBLCustomers c1
	inner join TBLOrders o1
	on
	c1.FLDCustomerID=o1.FLDCustomerID order by FLDCustomerName

	-- left join --

	select * from TBLCustomers c1
	left join TBLOrders o1
	on
	c1.FLDCustomerID=o1.FLDCustomerID order by FLDOrderAmount

	-- Right join --

	select * from TBLCustomers c1
	right join TBLOrders o1
	on
	c1.FLDCustomerID=o1.FLDCustomerID

	-- Full outer join --

	select * from TBLCustomers c1
	full outer join TBLOrders o1
	on
	c1.FLDCustomerID=o1.FLDCustomerID



	5)
	   	select * from TBLCustomers c1
	    left join TBLOrders o1
	    on
	    c1.FLDCustomerID=o1.FLDCustomerID 		
		where FLDOrderID is null


     6) 
	    select * from TBLCustomers c1
	    right join TBLOrders o1
	    on
	    c1.FLDCustomerID=o1.FLDCustomerID where FLDCustomerName is null

    7)

    select c1.FLDCustomerName,o1.FLDOrderID from TBLCustomers c1
	left join TBLOrders o1
	on
	c1.FLDCustomerID=o1.FLDCustomerID 
	where FLDOrderID IS NOT NULL
       
	     
	 8)

	 select FLDCustomerName,o1.FLDOrderAmount from TBLCustomers c1
	inner join TBLOrders o1
	on
	c1.FLDCustomerID=o1.FLDCustomerID 
	WHERE FLDOrderAmount > 250

	9)

	 select * from TBLCustomers c1
     left join TBLOrders o1
	on
	c1.FLDCustomerID=o1.FLDCustomerID
	where FLDOrderDate = '2024-01-05'


	10)

	select c1.FLDCustomerID,SUM(o1.FLDOrderAmount) from TBLCustomers c1
     inner join TBLOrders o1
	on
	c1.FLDCustomerID=o1.FLDCustomerID
	group by c1.FLDCustomerID

	11)

	select distinct(c1.FLDCustomerID),c1.FLDCustomerName from TBLCustomers c1
	LEFT join TBLOrders o1
	on 
	c1.FLDCustomerID=o1.FLDCustomerID
	group by c1.FLDCustomerName,c1.FLDCustomerID

	12)

	select SUM(o1.FLDOrderAmount) from TBLCustomers c1
	left join TBLOrders o1
	on
	c1.FLDCustomerID=o1.FLDCustomerID
	where o1.FLDCustomerID is not null

	14) -- DOUBT --

	select * from TBLCustomers c
	full join TBLOrders o
	on
	c.FLDCustomerID = o.FLDCustomerID
	where c.FLDCustomerID < o.FLDCustomerID
	order by FLDCity

	15)

	    select * from TBLCustomers self join on TBLCustomers.FLDCustomerID
		select * from TBLOrders
		


	16)

	   select COUNT(c.FLDCustomerID) as PURCHASE_ORDER,c.FLDCustomerName from TBLCustomers as c
	   inner join TBLOrders as o
	   on
	   c.FLDCustomerID=o.FLDCustomerID
	   group by c.FLDCustomerName



     17)

	    select * from TBLCustomers C
		left join TBLOrders O
		on 
		C.FLDCustomerID=O.FLDCustomerID
		where O.FLDCustomerID is null

		( OR )

		select C.FLDCustomerID,C.FLDCustomerName,C.FLDCity from TBLCustomers C
		left join TBLOrders O
		on 
		C.FLDCustomerID=O.FLDCustomerID
		where O.FLDCustomerID is null


     18)

	   select * from TBLCustomers C
	   inner join TBLOrders O
	   on
	   C.FLDCustomerID=O.FLDCustomerID
	   where O.FLDOrderAmount < 300 and C.FLDCity='New York'


	   19)

	   select * from TBLCustomers C
	   full outer join TBLOrders O
	   on
	   C.FLDCustomerID=O.FLDCustomerID
	   where C.FLDCustomerName like 'A%' or O.FLDOrderAmount > 400





	   --____________________________________________________________________________________________________ --


	   --Audit Table --

	   create table TBLAUDITLOG
	   {
         
		 TBlAUDITID            UNIQUEIDENTIFIER
		 ,TBLAUDITRECORD       INT               NOT NULL
		 ,TBLCREATEDDATE       DATE              NOT NULL
		 ,TBLCREATEDBY			DATE			 NOT NULL
		 ,TBLMODIFYDATE		   DATE		    	 NOT NULL
		 ,TBLMODIFYBY			DATE             NOT NULL
		 
		 }


		  --____________________________________________________________________________________________________ --



		  -- INDEXING --

		  sp_tables

		  select * from TBLOrders

		 create CLUSTERED INDEX CLUINDEX ON TBLOrders(FLDCustomerID)

		 exec sp_helpindex TBLOrders

		 select * from TBLOrders

		  create NONCLUSTERED INDEX NDXCLUINDEX ON TBLOrders(FLDOrderID)

		  select * from TBLOrders

		  drop index TBLOrders.NDXCLUINDEX

		  create nonclustered index NDXClusterIndex ON TBLOrders(FLDOrderID,FLDOrderAmount)
		  select * from TBLOrders
		

		----------------------------------------------------------------------------------------

		-- SQL EXECEPTION HANDLING -- 

		BEGIN TRY
		      SELECT 1/0;
			  END TRY
			  BEGIN CATCH
			  PRINT ' AN ERROR OCCURRED:'+ Error_Message();
			  END CATCH






			  USE Developer122

			  -- if only for true condition -- 

			  DECLARE @AGE INT
			  SET @AGE=25
			  IF (@AGE>20)
			  BEGIN
			   RAISERROR('Error: Age is greater than 20',16,1)
			   END

  -- 1) --

  BEGIN TRY
    DECLARE @AGE INT
    SET @AGE = 30

    IF (@AGE > 20)
    BEGIN
        RAISERROR('Error: Age is greater than 20', 11, 1)
    END
     END TRY
   BEGIN CATCH
        SELECT ERROR_MESSAGE() AS ErrorMessage
     END CATCH



	
	-- type 2 --

	BEGIN TRY
     DECLARE @AGE INT
	 SET @AGE= 12;
	 IF(@AGE>20)
	
        	 BEGIN
	              RAISERROR('ERROR : YOU ARE ELIGIBLE',16,1)
		      END
		          ELSE
		             BEGIN
		                 RAISERROR('ERROR : YOU ARE NOT ELIGIBLE ',15,1)
		       END
			   END TRY
			   BEGIN CATCH
			              SELECT ERROR_MESSAGE() AS ErrorMessage
               END CATCH

	

	-- TYPE 3

	 DECLARE @AGE INT;
        SET @AGE = 25;

        IF @AGE >= 18
        BEGIN
           PRINT 'You are an adult.';
        END
        ELSE
        BEGIN
           PRINT 'You are not an adult.';
        END



   --- TYPE 4 

   BEGIN TRY
           DECLARE @AGE INT;
            SET @AGE = 88;

             IF @AGE < 18
             BEGIN
                  PRINT 'You are a minor.';
             END
             ELSE IF @AGE BETWEEN 18 AND 65
             BEGIN
                  PRINT 'You are an adult.';
             END
              ELSE
              BEGIN
                 PRINT 'You are a senior citizen.';
              END
   END TRY

   BEGIN CATCH 
        SELECT ERROR_MESSAGE() AS ErrorMsg
   end catch





   --  TYPE 5

   BEGIN TRY
    -- Code that might cause an error
    -- For example, division by zero
        SELECT 10 / 0;
       END TRY
       BEGIN CATCH
    -- Code to handle the error
         PRINT 'An error occurred!';
          PRINT 'Error Number: ' + CAST(ERROR_NUMBER() AS VARCHAR);
           PRINT 'Error Message: ' + ERROR_MESSAGE();
            END CATCH;


       --- USEING CASE 

		SELECT *,
        CASE 
        WHEN FLDOrderAmount > 300 THEN 'Expensive'
        ELSE 'Affordable'
        END AS price_category
        FROM TBLOrders;

SELECT * FROM TBLOrders


     select *,
	 case
	 when FLDOrderAmount < 100 then 'cheep'
	 else FLDOrderAmount > 100 and FLDOrderAmount < 300 then 'Affordable'
	 else FLDOrderAmount > 400 then 'Expensive'
	 end as price_category
	 from TBLOrders
	
	  



	  --try catch block procedure to procedure 

	  use Developer122
	  sp_helptext pro


       create procedure sp1
       as
       begin
       RAISERROR('Error: Age is greater than 20',16,1)
	   end

	   exec sp1

	   create procedure sp2
	   as
	   begin
	        begin try
	         exec sp1
			 select * from TBLEMPLOYEE
			 end try
			 begin catch
			 --select ERROR_MESSAGE() as ErrorMessage
			 exec sp1
			 end catch
			 end


			 exec sp2

			 drop procedure sp2





------------------------------------------------------------------------------


--create a custom role and grant permission at database level such as select and insert

create role my_custom_role

GRANT SELECT, INSERT ON DATABASE::developer122 TO my_custom_role;

GRANT SELECT, INSERT ON SCHEMA::dbo TO my_custom_role;

EXEC sp_addrolemember 'my_custom_role', 'my_user';



		   




	   



















