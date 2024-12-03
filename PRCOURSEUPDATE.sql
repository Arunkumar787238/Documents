


CREATE PROCEDURE PRCOURSEUPDATE
(
    @FLDCOURSEID                BIGINT
   ,@ROWUSERCODE				INT
   ,@FLDCOURSENAME				VARCHAR(MAX)
   ,@FLDDURATIONMONTH			DECIMAL(10,2)			
                       
)

AS
BEGIN

	
      UPDATE TBLCOURSE
	  SET	     
	    FLDCOURSENAME    = @FLDCOURSENAME
	   ,FLDDURATIONMONTH = @FLDDURATIONMONTH
	   ,FLDCREATEDBY     = @ROWUSERCODE
	   ,FLDCREATEDDATE   = GETUTCDATE()
	   ,FLDMODIFIEDDATE  = GETUTCDATE()
	   ,FLDMODIFIEDBY    = @ROWUSERCODE
	   
	   
	   OUTPUT 1, @ROWUSERCODE, GETUTCDATE(), OBJECT_NAME(@@PROCID), NULL,INSERTED.* INTO TBLAUDITCOURSE	   
       WHERE FLDCOURSEID     = @FLDCOURSEID


	  END







	  
	  



	  



	 
	 
	



	


