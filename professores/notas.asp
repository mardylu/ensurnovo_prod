
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
<body>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<script type="text/javascript">
	tinyMCE.init({
		// General options
		mode : "exact",
		elements : "info",
		theme : "advanced",
		plugins : "autolink,lists,advlink,contextmenu,paste,directionality,fullscreen,noneditable,nonbreaking,inlinepopups",

		// Theme options
		theme_advanced_buttons1 : "bold,italic,underline,strikethrough,|,bullist,numlist,|,outdent,indent,blockquote,|,undo,redo,|,link,unlink,|,code,fullscreen",
		theme_advanced_buttons2 : "",
		theme_advanced_buttons3 : "",
		theme_advanced_buttons4 : "",
		theme_advanced_toolbar_location : "top",
		theme_advanced_toolbar_align : "left",
		theme_advanced_statusbar_location : "bottom",
		theme_advanced_resizing : true
	});
</script>
<title>ENSUR Inscrições</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<link rel="stylesheet" type="text/css" href="css/estilo1.css" />

</HEAD>
<% 
Set RS = Server.CreateObject("ADODB.Recordset")
RS.CursorType = 3
RS.ActiveConnection = Con

COD_ALUNO = request("aluno")
strSQL = "SELECT * FROM ALUNO WHERE COD_ALUNO="&request("aluno")
RS.Open strSQL
NOTAS = RS("NOTA")

	
if request("acao") = "salva" then
	if trim(request("notas"))="" then
		%>
		<script type="text/javascript">
			alert("A Mensagem deve ser preenchida");
			window.Close();
		</script>
		<%
	end if
	RS.Close
	if request("notas") <> "" then
		NOTAS = NOTAS & CHR(10) & CHR(10) & "====< INICIO >===="
		NOTAS = NOTAS & CHR(10) & CHR(10) & Session("nome") & " " & formatadata2(hoje) & " " & formatahora(hora) & CHR(10)
		NOTAS = NOTAS & request("notas")
		sql = "UPDATE ALUNO SET NOTA='"&NOTAS&"' WHERE COD_ALUNO="&COD_ALUNO
		RS.OPEN sql
		%><script type="text/javascript">
			alert("Nota Atualizada");
			self.Close();
		</script><%
		strSQL = "SELECT * FROM ALUNO WHERE COD_ALUNO="&request("aluno")
		RS.Open strSQL
		NOTAS = RS("NOTA")
	end if
else
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
end if
%>
<form action="notas.asp" name="form" method="post">
	<fieldset>
		<legend>Histórico</legend>
		<p><textarea style="width:430px" rows="7" wrap="virtual" name="notas1" readonly><% =NOTAS%></textarea></p>
	</fieldset>
	<p><br></p>
	<fieldset>
		<legend>Novas informações</legend>
		<p><textarea style="width:430px" rows="7" wrap="virtual" name="notas"></textarea></p>
	</fieldset>
	<input type=hidden value="salva" name="acao">
	<input type=hidden value="<% =COD_ALUNO %>" name="aluno"">
	<button id="bt_menu" onClick="window.close();return false;">Fechar</button>
	<button id="bt_menu" onClick="document.getElementById('form').submit();">Enviar</button>
</form>

</html>
</body>
