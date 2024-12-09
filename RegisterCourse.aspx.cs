using SouthNests.Phoenix.Framework;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;


public partial class Registers_RegisterCourse : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            SessionUtil.PageAccessRights(this.ViewState);
            UserAccessRights.SetUserAccess(Page.Controls, PhoenixSecurityContext.CurrentSecurityContext.UserCode, 1);
            PhoenixToolbar toolbar = new PhoenixToolbar();
            toolbar.AddFontAwesomeButton("../Registers/RegisterCourse.aspx", "Export to Excel", "<i class=\"fas fa-file-excel\"></i>", "Excel");
            toolbar.AddFontAwesomeButton("javascript:CallPrint('gvCompany')", "Print Grid", "<i class=\"fas fa-print\"></i>", "PRINT");
            toolbar.AddFontAwesomeButton("../Registers/RegisterCourse.aspx", "Find", "<i class=\"fas fa-search\"></i>", "FIND");
            toolbar.AddFontAwesomeButton("javascript:openNewWindow('codehelp1','','" + Session["sitepath"] + "/Registers/RegisterCourseList.aspx'); return false;", "Add", "<i class=\"fa fa-plus-circle\"></i>", "ADDCOMPANY");

            MenuRegisterCourse.AccessRights = this.ViewState;
            MenuRegisterCourse.MenuList = toolbar.Show();
            toolbar = new PhoenixToolbar();
            MenuTitle.AccessRights = this.ViewState;
            MenuTitle.MenuList = toolbar.Show();


            if (!IsPostBack)
            {

                dgcourse.PageSize = int.Parse(PhoenixGeneralSettings.CurrentGeneralSetting.Records);
                ViewState["PAGENUMBER"] = 1;
                ViewState["SORTEXPRESSION"] = null;
                ViewState["SORTDIRECTION"] = null;
                ViewState["CURRENTINDEX"] = 1;


            }

        }
        catch (Exception ex)
        {
            ucError.ErrorMessage = ex.Message;
            ucError.Visible = true;
        }
    }



    private void BindData()
    {
        int iRowCount = 0;
        int iTotalPageCount = 0;
        string sortexpression = (ViewState["SORTEXPRESSION"] == null) ? null : (ViewState["SORTEXPRESSION"].ToString());
        int? sortdirection = null;
        if (ViewState["SORTDIRECTION"] != null)
            sortdirection = Int32.Parse(ViewState["SORTDIRECTION"].ToString());

        string strCourseSearch = (txtSerchCourse.Text == null) ? "" : txtSerchCourse.Text;

        DataSet ds = CrewCouseRegister.CourseSearch(
                strCourseSearch
               , sortexpression
               , sortdirection
               , int.Parse(ViewState["PAGENUMBER"].ToString())
               , dgcourse.PageSize
               , ref iRowCount
               , ref iTotalPageCount
            );

        string[] alColumns = { "FLDCOURSENAME", "FLDDURATIONMONTH" };
        string[] alCaptions = { "Course Name", "Course Duration" };


        General.SetPrintOptions("gvCompany", "Company", alCaptions, alColumns, ds);

        if (ds.Tables[0].Rows.Count > 0)
        {
            dgcourse.DataSource = ds;
            dgcourse.VirtualItemCount = iRowCount;
        }
        else
        {
            dgcourse.DataSource = "";
        }



    }





    protected void dgcourse_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        ViewState["PAGENUMBER"] = ViewState["PAGENUMBER"] != null ? ViewState["PAGENUMBER"] : dgcourse.CurrentPageIndex + 1;
        BindData();
    }

    protected void MenuRegisterCourse_TabStripCommand(object sender, EventArgs e)
    {
        RadToolBarEventArgs dce = (RadToolBarEventArgs)e;
        string CommandName = ((RadToolBarButton)dce.Item).CommandName;
        if (CommandName.ToUpper().Equals("FIND"))
        {
            ViewState["PAGENUMBER"] = 1;
            BindData();
            dgcourse.Rebind();
        }
        if (CommandName.ToUpper().Equals("EXCEL"))
        {
            ShowExcel();
        }
    }

    //protected void cmdHiddenSubmit1_Click(object sender, EventArgs e)
    //{
    //    DataBind();
    //    dgcourse.Rebind();
    //}

    protected void dgcourse_ItemDataBound(object sender, GridItemEventArgs e)
    {

        if (e.Item is GridEditableItem)
        {
            LinkButton edit = (LinkButton)e.Item.FindControl("cmdEdit");
            RadLabel l = (RadLabel)e.Item.FindControl("lblCourseId");
            if (edit != null)
            {
                edit.Visible = SessionUtil.CanAccess(this.ViewState, edit.CommandName);
                edit.Attributes.Add("onclick", "javascript:openNewWindow('codehelp1', '', '" + Session["sitepath"] + "/Registers/RegisterCourseList.aspx?fldcourseid=" + l.Text + "');return false;");
            }
            //LinkButton del = (LinkButton)e.Item.FindControl("cmdDelete");
            //if (del != null)
            //{
            //    del.Visible = SessionUtil.CanAccess(this.ViewState, del.CommandName);
            //    del.Attributes.Add("onclick", "return fnConfirmDelete(event)");
            //}
            LinkButton lb = (LinkButton)e.Item.FindControl("lnkCourseName");
            if (lb != null)
                lb.Attributes.Add("onclick", "javascript:openNewWindow('codehelp1', '', '" + Session["sitepath"] + "/Registers/RegisterCourseList.aspx?fldcourseid=" + l.Text + "');return false;");
        }

    }

    protected void cmdHiddenSave_Click(object sender, EventArgs e)
    {
        BindData();
        dgcourse.Rebind();
    }

    protected void dgcourse_SortCommand(object sender, GridSortCommandEventArgs e)
    {
        ViewState["SORTEXPRESSION"] = e.SortExpression;
        switch (e.NewSortOrder)
        {
            case GridSortOrder.Ascending:
                ViewState["SORTDIRECTION"] = "0";
                break;
            case GridSortOrder.Descending:
                ViewState["SORTDIRECTION"] = "1";
                break;
        }



    }


    protected void dgcourse_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName.ToUpper().Equals("DELETE"))
        {
            RadLabel lblcourseid = (RadLabel)e.Item.FindControl("lblCourseId");
            CrewCouseRegister.CourseDelete(1, General.GetNullableInteger(lblcourseid.Text));
            ucError.ErrorMessage = "deleted Sucessfully";
            ucError.Visible = true;
        }
    }



    protected void ShowExcel()
    {
        int iRowCount = 0;
        int iTotalPageCount = 0;
        DataSet ds = new DataSet();
        string[] alColumns = { "FLDCOURSENAME", "FLDDURATIONMONTH" };
        string[] alCaptions = { "Course Name", "Course Duration" };
        string sortexpression;
        int? sortdirection = null;
        sortexpression = (ViewState["SORTEXPRESSION"] == null) ? null : (ViewState["SORTEXPRESSION"].ToString());
        if (ViewState["SORTDIRECTION"] != null)
            sortdirection = Int32.Parse(ViewState["SORTDIRECTION"].ToString());

        if (ViewState["ROWCOUNT"] == null || Int32.Parse(ViewState["SORTDIRECTION"].ToString()) == 0)
            iRowCount = 10;
        else

            iRowCount = Int32.Parse(ViewState["ROWCOUNT"].ToString());

        string strCourseSearch = (txtSerchCourse.Text == null) ? "" : txtSerchCourse.Text;


        ds = CrewCouseRegister.CourseSearch(
            strCourseSearch
           , sortexpression
           , sortdirection
           , int.Parse(ViewState["PAGENUMBER"].ToString())
           , dgcourse.PageSize
           , ref iRowCount
           , ref iTotalPageCount
        );


        Response.AddHeader("Content-Disposition", "attachment; filename=Arun.xls");
        Response.ContentType = "application/vnd.msexcel";
        Response.Write("<TABLE BORDER='0' CELLPADDING='2' CELLSPACING='0' width='100%'> ");
        Response.Write("<tr>");
        Response.Write("<td><img src='http://" + Request.Url.Authority + Session["image"] + "/esmlogo4_small.png" + "' /> </td>");
        Response.Write("<td><h3>Other Company</h3></td>");
        Response.Write("<td colspan='" + (alColumns.Length - 2).ToString() + "' > &nbsp;</td>");
        Response.Write("</tr>");
        Response.Write("</TABLE>");
        Response.Write("<br/>");
        Response.Write("<TABLE BORDER='1' CELLPADDING='2' CELLSPACING='2' width='100%'>");
        Response.Write("<tr>");
        for (int i = 0; i < alCaptions.Length; i++)
        {
            Response.Write("<td width='20%'>");
            Response.Write("<br>" + alCaptions[i] + "</br>");
            Response.Write("</td>");
        }

        Response.Write("</tr>");
        foreach (DataRow dr in ds.Tables[0].Rows)
        {
            Response.Write("<tr>");
            for (int i = 0; i < alColumns.Length; i++)
            {
                Response.Write("<td>");
                Response.Write(dr[alColumns[i]]);
                Response.Write("</td>");
            }
            Response.Write("</tr>");
        }
        Response.Write("</TABLE>");
        Response.End();

        {

        }

    }






}