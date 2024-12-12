<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Example.aspx.cs" Inherits="JSON.Example" Async="true" %>




<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Ticket Quotation Converter</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        .input-area, .output-area {
            width: 100%;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
      

         <div class="container mt-4">
            <div class="row">
                <div class="col-3">
                    <h2>Convert Text to JSON</h2>
                    <asp:TextBox runat="server" ID="txtjsontext" TextMode="MultiLine" Rows="10" Columns="50"></asp:TextBox>
                    <div>
                        <asp:Button ID="btnConvert" runat="server" OnClick="btnConvert_Click" Text="convert"  />
                    </div>
                </div>
                <div class="col-3">
                </div>
                <div class="col-4">
                    <h3>Output JSON</h3>
                    <!-- TextBox control for output inside the form -->
                    <asp:TextBox ID="txtJsonOutput" runat="server" TextMode="MultiLine" Rows="22" Columns="60"></asp:TextBox>
                </div>
            </div>
        </div>




    </form>

 
</body>
</html>

