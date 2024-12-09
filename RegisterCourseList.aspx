<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RegisterCourseList.aspx.cs" Inherits="Registers_RegisterCourseList" %>

<!DOCTYPE html>

<%@ Import Namespace="SouthNests.Phoenix.Registers" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<%@ Register TagPrefix="eluc" TagName="TabStrip" Src="~/UserControls/UserControlTabsTelerik.ascx" %>
<%@ Register TagPrefix="eluc" TagName="Error" Src="~/UserControls/UserControlErrorMessage.ascx" %>
<%@ Register TagPrefix="eluc" TagName="Date" Src="../UserControls/UserControlDate.ascx" %>
<%@ Register TagPrefix="eluc" TagName="Address" Src="../UserControls/UserControlCommonAddress.ascx" %>
<%@ Register TagPrefix="eluc" TagName="OtherCompany" Src="../UserControls/UserControlOtherCompany.ascx" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <%: Scripts.Render("~/bundles/js") %>
        <%: Styles.Render("~/bundles/css") %>
        <script type="text/javascript" language="javascript" src="<%=Session["sitepath"]%>/js/phoenixPopup.js"></script>
    </telerik:RadCodeBlock>
</head>
<body>
     <form id="frmcourse" runat="server">
        <telerik:RadScriptManager runat="server" ID="RadScriptManager2" />
        <telerik:RadFormDecorator RenderMode="Lightweight" ID="RadFormDecorator1" runat="server" DecoratedControls="All" EnableRoundedCorners="true" />
        <eluc:TabStrip ID="MenuCompanyList" runat="server" OnTabStripCommand="MenuCompanyList_TabStripCommand" ></eluc:TabStrip>
        <telerik:RadAjaxPanel ID="RadAjaxPanel" runat="server" Height="80%">
            <eluc:Error ID="ucError" runat="server" Text="" Visible="false"></eluc:Error>
            <table cellpadding="1" cellspacing="5" width="75%">
                <tr>
                    <td>
                        <asp:Label ID="lblCourseName" runat="server" Text="CourseName"></asp:Label>
                    </td>
                    <td>
                        <telerik:RadTextBox ID="txtCourseName" runat="server"></telerik:RadTextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblMonth" runat="server" Text="DurationMonth" ></asp:Label>
                    </td>
                    <td>
                        <telerik:RadTextBox ID="txtDurationMonth" runat="server"></telerik:RadTextBox>
                    </td>
                </tr>
                </table>
            </telerik:RadAjaxPanel>
    </form>
</body>
</html>
