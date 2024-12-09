using SouthNests.Phoenix.Framework;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SouthNests.Phoenix.Registers;
using Telerik.Web.UI;
using System.Data;


public partial class Registers_RegisterCourseList : System.Web.UI.Page
{

    private const string SCRIPT_DOFOCUS = @"window.setTimeout('DoFocus()', 1);
            function DoFocus()
            {
                try {
                    document.getElementById('REQUEST_LASTFOCUS').focus();
                } catch (ex) {}
            }";



    protected void Page_Load(object sender, EventArgs e)
    {

        SessionUtil.PageAccessRights(this.ViewState);
        UserAccessRights.SetUserAccess(Page.Controls, PhoenixSecurityContext.CurrentSecurityContext.UserCode, 1);
        PhoenixToolbar toolbar = new PhoenixToolbar();

        if (Request.QueryString["fldcourseid"] != null)
        {
            toolbar.AddButton("Save", "SAVE", ToolBarDirection.Right);
            ViewState["fldcourseid"] = Request.QueryString["fldcourseid"].ToString();

        }
        else
        {
            //toolbar.AddButton("New", "NEW");
            toolbar.AddButton("Save", "SAVE", ToolBarDirection.Right);
        }

        
        MenuCompanyList.AccessRights = this.ViewState;
        MenuCompanyList.MenuList = toolbar.Show();



        if (!IsPostBack)
        {
            if (Request.QueryString["fldcourseid"] != null)
            {
                CourseEdit(Int32.Parse(Request.QueryString["fldcourseid"].ToString()));
            }
            Page.ClientScript.RegisterStartupScript(
            typeof(Registers_RegisterCourseList),
            "ScriptDoFocus",
            SCRIPT_DOFOCUS.Replace("REQUEST_LASTFOCUS", Request["__LASTFOCUS"]),
            true);

        }


    }

    protected void MenuCompanyList_TabStripCommand(object sender, EventArgs e)
    {

        //string Script = "";
        //Script += "<script language='javaScript' id='BookMarkScript'>" + "\n";
        //Script += "fnReloadList('codehelp1', null, null);";
        //Script += "</script>" + "\n";

        //RadToolBarEventArgs dce = (RadToolBarEventArgs)e;
        //string CommandName = ((RadToolBarButton)dce.Item).CommandName;

        //if (CommandName.ToUpper().Equals("SavePopup"))
        //{
        //    try
        //    {
        if (ViewState["fldcourseid"] != null)
        {
            CrewCouseRegister.CourseUpdate(
                PhoenixSecurityContext.CurrentSecurityContext.UserCode,
                Int32.Parse(ViewState["fldcourseid"].ToString()),
                txtCourseName.Text.Trim(),
               txtDurationMonth.Text.Trim()
              );

            txtCourseName.Text = "";
            txtDurationMonth.Text = "";

        }
        else
        {
            CrewCouseRegister.CourseInsert(
                PhoenixSecurityContext.CurrentSecurityContext.UserCode,
                 txtCourseName.Text.Trim(),
                 txtDurationMonth.Text.Trim()

                 );
            txtCourseName.Text = "";
            txtDurationMonth.Text = "";

            //}

            //catch (Exception ex)
            //{
            //    ucError.HeaderMessage = "";
            //    ucError.ErrorMessage = ex.Message;
            //    ucError.Visible = true;
            //    return;
            //}
            //Page.ClientScript.RegisterStartupScript(typeof(Page), "BookMarkScript", Script);







        }




    }



    private void CourseEdit(int fldcourseid)
    {
        DataSet ds = CrewCouseRegister.CourseEdit(fldcourseid);

        if (ds.Tables[0].Rows.Count > 0)
        {
            DataRow dr = ds.Tables[0].Rows[0];

            txtCourseName.Text = dr["FLDCOURSENAME"].ToString();
            txtDurationMonth.Text = dr["FLDDURATIONMONTH"].ToString();


        }
    }


    private bool IsValidOtherCompany()
    {
        ucError.HeaderMessage = "Please provide the following required information";

        if (txtCourseName.Text.Equals(""))
            ucError.ErrorMessage = "Course Name is required.";

        if (txtDurationMonth.Text.Equals(""))
            ucError.ErrorMessage = "Address1 is required.";


        return (!ucError.IsError);
    }




}
