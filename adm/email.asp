
<!-- #include file="../library/parametros.asp" -->
<!-- #include file="../library/conOpen.asp" -->
<!-- #INCLUDE FILE="../library/fErroMsg.asp" -->
<!-- #INCLUDE FILE="../library/vHoje.asp" -->
<!-- #INCLUDE FILE="../library/fFormataData.asp" -->
<!-- #INCLUDE FILE="../library/fFormataHora.asp" -->
<!-- #INCLUDE FILE="../library/fFormataValor.asp" -->
<!-- #INCLUDE FILE="../library/fExtenso.asp" -->
<!-- #INCLUDE FILE="../library/fAddZero.asp" -->
<!-- #INCLUDE FILE="../library/fFormataCep.asp" -->

<HTML>
<HEAD>
<TITLE>SISTEMA FINANCEIRO  - IBAM</TITLE>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<LINK REL="STYLESHEET" TYPE="text/CSS" HREF="../css/estilo.css">
</HEAD>
<% 
Set RS = Server.CreateObject("ADODB.Recordset")
RS.CursorType = 3
RS.ActiveConnection = Con

COD_ALUNO = request("aluno")
strSQL = "SELECT * FROM ALUNO WHERE COD_ALUNO="&request("aluno")
RS.Open strSQL
EMAIL_ENVIADO = RS("EMAIL_ENVIADO")
	
If RS.EOF Then %>
	<script type="text/javascript">
		alert("Aluno inválido");
		window.Close();
	</script>
	<% RS.Close
	Set RS = Nothing
	Con.Close
	Set Con = Nothing
	Response.end
End If
%>
<form action="email.asp" method="post">
	<fieldset>
		<legend>Histórico dos e-mails</legend>

	<textarea style="width:450px" rows="16" wrap="virtual" name="notas1" readonly><% =EMAIL_ENVIADO%></textarea>
	</fieldset>
	<input type=hidden value="salva" name="acao">
	<input type=hidden value="<% =COD_ALUNO %>" name="aluno"">
	<button id="bt_menu" onClick="window.close();return false;">Fechar</button></td>

	<TR><TD></TD><TD><B></B></TD></TR>
</table>

</form>
</BODY>

