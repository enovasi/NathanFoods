<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="Nathan_Foods.Vistas.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <title></title>

</head>
<body>
    <form id="form1" runat="server">
        <div>
            Pedidos por Procesar - Rango de Fechas<br />
            <asp:Label ID="lblMessage" runat="server" Text="Label"></asp:Label>
            <br />
            Desde:
            <asp:TextBox ID="fechaDesde" runat="server" OnTextChanged="TextBox1_TextChanged" TextMode="Date"></asp:TextBox>
&nbsp;&nbsp; Hasta:&nbsp;
            <asp:TextBox ID="fechaHasta" runat="server" TextMode="Date"></asp:TextBox>
            <asp:Button ID="botonBusqueda" runat="server" OnClick="Button1_Click" Text="Buscar" />
            <br />
            <br />
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="MERCANSA1" OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
                <Columns>
                     <asp:TemplateField HeaderText="Check">
            <ItemTemplate>
                <asp:CheckBox ID="myCheckbox" runat="server" />
            </ItemTemplate>
        </asp:TemplateField>
                    <asp:BoundField DataField="docnum" HeaderText="#Doc" SortExpression="docnum" />
                    <asp:BoundField DataField="cardcode" HeaderText="#Cliente" SortExpression="cardcode" />
                    <asp:BoundField DataField="cardname" HeaderText="Cliente" SortExpression="cardname" />
                    <asp:BoundField DataField="docdate" HeaderText="Fecha" SortExpression="docdate" DataFormatString="{0:d}" />
                    <asp:BoundField DataField="Column1"HeaderText="Total" ReadOnly="True" SortExpression="Column1" DataFormatString="{0:N}" />
                </Columns>
            </asp:GridView>
            <asp:Button ID="CalculateButton" runat="server" OnClick="CalculateButton_Click1" Text="Calcular" />
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
