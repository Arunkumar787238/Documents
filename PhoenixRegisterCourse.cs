using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using SouthNests.Phoenix.Framework;

/// <summary>
/// Summary description for CrewCouseRegister
/// </summary>
public class CrewCouseRegister
{
    public CrewCouseRegister()
    {
        //
        // TODO: Add constructor logic here
        //
    }


    public static DataSet CourseSearch(
              string fldcoursename
            , string strSortby
            , int? iSortDirection
            , int iPageNumber
            , int iPageSize
            , ref int iRowCount
            , ref int iTotalPageCount

        )

    {
        DataSet ds = new DataSet();

        List<SqlParameter> ParameterList = new List<SqlParameter>();
        ParameterList.Add(DataAccess.GetDBParameter("@FLDCOURSENAME", SqlDbType.NVarChar, 128, ParameterDirection.Input, fldcoursename));
        ParameterList.Add(DataAccess.GetDBParameter("@SORTBY",SqlDbType.VarChar,100,ParameterDirection.Input,strSortby));
        ParameterList.Add(DataAccess.GetDBParameter("@SORTDIRECTION", SqlDbType.TinyInt, 2, ParameterDirection.Input, iSortDirection));
        ParameterList.Add(DataAccess.GetDBParameter("@PAGENUMBER",SqlDbType.Int,4,ParameterDirection.Input,iPageNumber));
        ParameterList.Add(DataAccess.GetDBParameter("@PAGESIZE",SqlDbType.Int,4,ParameterDirection.Input,iPageSize));
        ParameterList.Add(DataAccess.GetDBParameter("@RESULTCOUNT",SqlDbType.Int,4,ParameterDirection.Output,iRowCount));
        ParameterList.Add(DataAccess.GetDBParameter("@TOTALPAGECOUNT",SqlDbType.Int,4,ParameterDirection.Output,iTotalPageCount));



        ds = DataAccess.ExecSPReturnDataSet("PRCOURSESEARCH",ParameterList);

        foreach  (SqlParameter sp in ParameterList)
        {
            if (sp.Direction == ParameterDirection.Output)
            {
                if (sp.ParameterName == "@RESULTCOUNT")
                    iRowCount = (int)sp.Value;

                if (sp.ParameterName == "@TOTALPAGECOUNT")
                    iTotalPageCount = (int)sp.Value;
                         

            }

        }

        return ds;

    }




    public static DataSet CourseList(int? fldcourseid,String fldcoursename, Decimal flddurationmonth)
    {
        DataSet ds = new DataSet();

        List<SqlParameter> ParameterList = new List<SqlParameter>();

        ParameterList.Add(DataAccess.GetDBParameter("@ROWUSERCODE", SqlDbType.Int, 4, ParameterDirection.Input, 0));
        ParameterList.Add(DataAccess.GetDBParameter("@FLDCOURSEID", SqlDbType.TinyInt, 2, ParameterDirection.Input, fldcourseid));
        ParameterList.Add(DataAccess.GetDBParameter("@FLDDURATIONMONTH", SqlDbType.Int, 2, ParameterDirection.Input, flddurationmonth));

        ds = DataAccess.ExecSPReturnDataSet("PRCOURSELIST", ParameterList);

        return ds;
    }



    public static DataSet CourseUpdate(int rowusercode,int fldcourseid, String fldcoursename, Decimal flddurationmonth)
    {
        DataSet ds = new DataSet();
        List<SqlParameter> ParameterList = new List<SqlParameter>();
        ParameterList.Add(DataAccess.GetDBParameter("@ROWUSERCODE", SqlDbType.Int, 4, ParameterDirection.Input, rowusercode));
        ParameterList.Add(DataAccess.GetDBParameter("@FLDCOURSEID", SqlDbType.Int, 4, ParameterDirection.Input, fldcourseid));
        ParameterList.Add(DataAccess.GetDBParameter("@FLDCOURSENAME", SqlDbType.NVarChar, 128, ParameterDirection.Input, fldcoursename));
        ParameterList.Add(DataAccess.GetDBParameter("@FLDDURATIONMONTH", SqlDbType.Int, 2, ParameterDirection.Input, flddurationmonth));

        ds = DataAccess.ExecSPReturnDataSet("PRCOURSEUPDATE", ParameterList);
        return ds;
    }



    public static void CourseInsert(int rowusercode, String fldcoursename, Decimal flddurationmonth)
    {
        DataSet ds = new DataSet();
        List<SqlParameter> ParameterList = new List<SqlParameter>();
        ParameterList.Add(DataAccess.GetDBParameter("@ROWUSERCODE", SqlDbType.Int, 4, ParameterDirection.Input, rowusercode));
        ParameterList.Add(DataAccess.GetDBParameter("@FLDCOURSENAME",SqlDbType.NVarChar,128,ParameterDirection.Input, fldcoursename));
        ParameterList.Add(DataAccess.GetDBParameter("@FLDDURATIONMONTH", SqlDbType.Int, 2, ParameterDirection.Input, flddurationmonth));

        int n = DataAccess.ExecSPReturnInt("PRCOURSEINSERT", ParameterList);


    }



    public static void CourseDelete(int rowusercode, int? fldcourseid)
    {
        List<SqlParameter> ParameterList = new List<SqlParameter>();
        ParameterList.Add(DataAccess.GetDBParameter("@ROWUSERCODE", SqlDbType.Int, 4, ParameterDirection.Input, rowusercode));
        ParameterList.Add(DataAccess.GetDBParameter("@FLDCOURSEID", SqlDbType.Int, 4, ParameterDirection.Input, fldcourseid));
        int n = DataAccess.ExecSPReturnInt("PRCOURSEDELETE", ParameterList);
    }


    public static DataSet CourseEdit(int fldcourseid)
    { 
        DataSet ds = new DataSet();
        List<SqlParameter> ParameterList = new List<SqlParameter>();
        ParameterList.Add(DataAccess.GetDBParameter("@ROWUSERCODE", SqlDbType.Int, 10, ParameterDirection.Input, 0));
        ParameterList.Add(DataAccess.GetDBParameter("@FLDCOURSEID", SqlDbType.Int, 4, ParameterDirection.Input, fldcourseid));
        ds = DataAccess.ExecSPReturnDataSet("PRCOURSEEDIT", ParameterList);
        return ds;
    }


}