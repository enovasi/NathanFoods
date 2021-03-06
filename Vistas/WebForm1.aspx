﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="Nathan_Foods.Vistas.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>

    <link  href="https://cdnjs.cloudflare.com/ajax/libs/material-design-lite/1.1.0/material.min.css" rel="stylesheet"/>
	<link  href="https://cdn.datatables.net/1.10.16/css/dataTables.material.min.css" rel="stylesheet"/>
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://cdn.datatables.net/1.10.16/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.10.16/js/dataTables.material.min.js"></script>
     <script>
         $(function () {
             $("#GridView1").prepend($("<thead></thead>").append($(this).find("tr:first"))).DataTable({
                 columnDefs: [
                     {
                         targets: [0, 1, 2],
                         className: 'mdl-data-table__cell--non-numeric'
                     }
                 ]

             });
         });

      
    </script>
 <title></title>

</head>
<body>
    <form id="form1" runat="server">
        <div>
            Pedidos por Procesar - Rango de Fechas<br />
            Cant. Ordenes:
            <asp:Label ID="lblMessage" runat="server" Text="Label"></asp:Label>
            <br />
            Peso:
            <asp:Label ID="lblMessage2" runat="server" Text="Label"></asp:Label>
            <br />
            Desde:
            <asp:TextBox ID="fechaDesde" runat="server" OnTextChanged="TextBox1_TextChanged" TextMode="Date"></asp:TextBox>
&nbsp;&nbsp; Hasta:&nbsp;
            <asp:TextBox ID="fechaHasta" runat="server" TextMode="Date"></asp:TextBox>
            <asp:Button ID="botonBusqueda" runat="server" OnClick="Button1_Click" Text="Buscar" />
            <br />
            <br />
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="MERCANSA1" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" class="mdl-data-table">
                <Columns>
                     <asp:TemplateField HeaderText="Check">
            <ItemTemplate>
                <asp:CheckBox ID="myCheckbox" runat="server" AutoPostBack="true"  OnCheckedChanged="SelectCheckBox_OnCheckedChanged"/>
            </ItemTemplate>
        </asp:TemplateField>
                    <asp:BoundField DataField="docnum" HeaderText="#Doc" SortExpression="docnum" />
                    <asp:BoundField DataField="cardcode" HeaderText="#Cliente" SortExpression="cardcode" />
                    <asp:BoundField DataField="cardname" HeaderText="Cliente" SortExpression="cardname" />
                    <asp:BoundField DataField="docdate" HeaderText="Fecha" SortExpression="docdate" DataFormatString="{0:d}" />
                     <asp:TemplateField HeaderText="Total" SortExpression="Column1">
                         <EditItemTemplate>
                             <asp:Label ID="Label1" runat="server" Text='<%# Eval("Total") %>'></asp:Label>
                         </EditItemTemplate>
                         <ItemTemplate>
                             <asp:Label ID="Label1" runat="server" Text='<%# Bind("Total") %>'></asp:Label>
                         </ItemTemplate>
                     </asp:TemplateField>
                </Columns>
            </asp:GridView>
            
            <br />
            <asp:TextBox ID="textComentario" runat="server" TextMode="MultiLine" Width="280px"></asp:TextBox>
            <br />
            <asp:SqlDataSource ID="MERCANSA1" runat="server" ConnectionString="<%$ ConnectionStrings:MERCANSA2013V1ConnectionString %>" SelectCommand="select t0.docnum, t0.cardcode, t0.cardname, t0.docdate, SUM(t1.linetotal) as Total FROM ORDR t0
INNER JOIN RDR1 t1 on t0.docentry = t1.docentry
WHERE t0.docdate between @desde and @hasta
AND  t0.canceled = 'N'
GROUP BY t0.docnum, t0.cardcode, t0.cardname, t0.docdate
 ">
                <SelectParameters>
                    <asp:ControlParameter ControlID="fechaDesde" Name="desde" PropertyName="Text" />
                    <asp:ControlParameter ControlID="fechaHasta" Name="hasta" PropertyName="Text" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:Button ID="botonProcesar" runat="server" OnClick="Button1_Click1" Text="Confirmar" />
            <br />
        </div>
    </form>
</body>
</html>
