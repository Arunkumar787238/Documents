<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RegisterCourse.aspx.cs" Inherits="Registers_RegisterCourse" %>

<!DOCTYPE html>

<%@ Import Namespace="SouthNests.Phoenix.Registers" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<%@ Register TagPrefix="eluc" TagName="TabStrip" Src="~/UserControls/UserControlTabsTelerik.ascx" %>
<%@ Register TagPrefix="eluc" TagName="Error" Src="~/UserControls/UserControlErrorMessage.ascx" %>
<%@ Register TagPrefix="eluc" TagName="ToolTip" Src="~/UserControls/UserControlToolTip.ascx" %>




<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Other Company</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" />

    <telerik:RadCodeBlock ID="Radcodeblock1" runat="server">
        <%: Scripts.Render("~/bundles/js") %>
        <%: Styles.Render("~/bundles/css") %>
        <script type="text/javascript" language="javascript" src="<%=Session["sitepath"]%>/js/phoenixPopup.js"></script>
    </telerik:RadCodeBlock>

</head>
<body>
    <form id="frmRegistercourse" runat="server" submitdisabledcontrols="true">
        <telerik:RadScriptManager ID="RadScriptManager1" runat="server"></telerik:RadScriptManager>
        <telerik:RadFormDecorator RenderMode="Lightweight" ID="RadFormDecorator1" runat="server" DecoratedControls="All" EnableRoundedCorners="true" />
        <eluc:TabStrip ID="MenuTitle" runat="server" Title="course"></eluc:TabStrip>
        <telerik:RadAjaxPanel ID="RadAjaxPanel" runat="server" Height="80%">
            <eluc:Error ID="ucError" runat="server" Text="" Visible="false"></eluc:Error>

            <table id="tblConfigureCourse">
                <tr>
                    <td>
                        <telerik:RadLabel ID="lblCourseName" runat="server" Text="COURSE NAME"></telerik:RadLabel>
                    </td>
                    <td>
                        <telerik:RadTextBox ID="txtSerchCourse" runat="server" MaxLength="100" CssClass="input" Width="360px"></telerik:RadTextBox>
                    </td>

                </tr>
            </table>

            <br />
            <eluc:TabStrip ID="MenuRegisterCourse" runat="server" OnTabStripCommand="MenuRegisterCourse_TabStripCommand"></eluc:TabStrip>


            <telerik:RadGrid ID="dgcourse" runat="server" RenderMode="Lightweight" AllowCustomPaging="true" AllowPaging="true" AllowSorting="true"
                CellPadding="0" GridLines="None" EnableViewState="false" GroupingEnabled="false" EnableHeaderContextMenu="true" ShowFooter="false"
                OnNeedDataSource="dgcourse_NeedDataSource" OnItemDataBound="dgcourse_ItemDataBound" OnSortCommand="dgcourse_SortCommand"
                OnItemCommand="dgcourse_ItemCommand">

                <SortingSettings EnableSkinSortStyles="true"></SortingSettings>
                <MasterTableView EditMode="InPlace" InsertItemPageIndexAction="ShowItemOnCurrentPage" HeaderStyle-Font-Bold="true"
                    ShowHeadersWhenNoRecords="true" AllowNaturalSort="false" AutoGenerateColumns="false" TableLayout="Fixed"
                    ItemStyle-Wrap="false" ItemStyle-HorizontalAlign="Left" HeaderStyle-Wrap="false" HeaderStyle-HorizontalAlign="Center">
                    <NoRecordsTemplate>
                        <asp:Button runat="server" ID="cmdHiddenSave" OnClick="cmdHiddenSave_Click" />
                        <table width="100%" border="0">
                            <tr>
                                <td align="center">
                                    <telerik:RadLabel ID="noRecordfound" runat="server" Text="No Record Found " Font-Size="Large" Font-Bold="true"></telerik:RadLabel>

                                </td>
                            </tr>
                        </table>
                    </NoRecordsTemplate>

                    <Columns>
                        <telerik:GridTemplateColumn HeaderText="CourseName" HeaderStyle-Width="200px">
                            <ItemStyle Wrap="True" HorizontalAlign="Left"></ItemStyle>

                            <HeaderTemplate>
                                <telerik:RadLabel ID="lnkCourseHeader" runat="server" Text="CourseName"></telerik:RadLabel>
                            </HeaderTemplate>

                            <ItemTemplate>
                                <telerik:RadLabel ID="lblCourseId" runat="server" Visible="false" Text='<%# DataBinder.Eval(Container,"DataItem.FLDCOURSEID") %>'></telerik:RadLabel>
                                <asp:LinkButton ID="lnkCourseName" runat="server" Text='<%# DataBinder.Eval(Container,"DataItem.FLDCOURSENAME") %>'></asp:LinkButton>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>


                        <telerik:GridTemplateColumn HeaderText="CourseDuration" HeaderStyle-Width="200px">
                            <ItemStyle Wrap="True" HorizontalAlign="Center"></ItemStyle>

                            <HeaderTemplate>
                                <telerik:RadLabel ID="lnkCourseDuration" runat="server" Text="CourseDuration"></telerik:RadLabel>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <telerik:RadLabel ID="lblDuration" runat="server" Text='<%# DataBinder.Eval(Container,"DataItem.FLDDURATIONMONTH") %>'>></telerik:RadLabel>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>


                        <telerik:GridTemplateColumn HeaderText="Action" HeaderStyle-Width="200px">
                            <ItemStyle Wrap="True" HorizontalAlign="Center"></ItemStyle>

                            <HeaderTemplate>
                                <telerik:RadLabel ID="lblAction" runat="server">Action</telerik:RadLabel>
                            </HeaderTemplate>
                            <ItemStyle Wrap="false" HorizontalAlign="Center" Width="100px"></ItemStyle>
                            <ItemTemplate>
                                <asp:LinkButton runat="server" ToolTip="Edit" Width="20px" Height="20px"
                                    CommandName="EDIT" CommandArgument='<%# Container.DataSetIndex %>' ID="cmdEdit">
                        <span class="icon"><i class="fas fa-edit"></i></span>
                                </asp:LinkButton>


                                <asp:LinkButton runat="server" ID="cmdDelete" ToolTip="Delete" Width="20px" Height="20px"
                                    CommandName="DELETE" CommandArgument='<%# Container.DataSetIndex %>'>
                            <span class="icon"><i class="fas fa-trash"></i></span>
                                </asp:LinkButton>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                    </Columns>
                    <PagerStyle Mode="NextPrevNumericAndAdvanced" AlwaysVisible="true" PagerTextFormat="{4}<strong>{5}</strong> Records Found"
                        PageSizeLabelText="Records per page:" CssClass="RadGrid_Default rgPagerTextBox" />


                </MasterTableView>

                <ClientSettings EnableRowHoverStyle="true" AllowColumnsReorder="true" ReorderColumnsOnClient="true" AllowColumnHide="true" ColumnsReorderMethod="Reorder">
                    <Selecting AllowRowSelect="true" EnableDragToSelectRows="false" UseClientSelectColumnOnly="true" />
                    <Scrolling AllowScroll="true" SaveScrollPosition="true" UseStaticHeaders="true" EnableNextPrevFrozenColumns="true" FrozenColumnsCount="2" EnableColumnClientFreeze="true"
                        ScrollHeight="" />
                    <Resizing EnableRealTimeResize="true" AllowResizeToFit="true" AllowColumnResize="true" />
                </ClientSettings>


            </telerik:RadGrid>


        </telerik:RadAjaxPanel>

    </form>
</body>
</html>
