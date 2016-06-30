<%If Session("key_usu")<>"ok" Then Response.Redirect "logout.asp"%>
<!-- #INCLUDE FILE="../library/parametros.asp" -->
<!-- #INCLUDE FILE="../library/conOpen.asp" -->
<!-- #INCLUDE FILE="../library/fErroMsg.asp" -->
<!-- #INCLUDE FILE="../library/fCreateSel.asp" -->
<!-- #INCLUDE FILE="../library/fAddZero.asp" -->
<!-- #INCLUDE FILE="../library/fData.asp" -->
<%
cod = request("cod")
if cod=0 or cod="" or isNumeric(cod)=false then cod=0
RS.Open "SELECT * FROM TEMAS where id_tema="&cod
if not RS.EOF then
	TEMA= RS("TEMA")
end if
RS.Close
%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<title>ENSUR Inscrições</title>
</head>
<body>
<div id="pagina">
	<!-- #INCLUDE FILE="include/topo.asp" -->
	<div id="conteudo">
		<table border = 0 width=100%>
			<tr><td WIDTH="10%"><a href="lista_temas.asp" title="Lista de Temas"><img src="img/btnp_seta_invet.gif" border="0"></a></td><td WIDTH="90%"><h1>Cadastro de Áreas</h1></td></tr>
		</table>
		<form name="form" method="POST" action="salva_temas.asp">
		<input type="hidden" name="id_tema" value="<%=cod%>">
		<fieldset>
			<legend>informações da área</legend>
			<p><label for="TEMA" class="requerido">Área</label><input type="text" name="TEMA" id="TEMA" maxlength="50" size="60" value="<%=TEMA%>" /></p>
			<p><br /><label for="submit">&nbsp;</label><input type="submit" name="submit" value="Enviar" class="buttonF"><br /><br /></p>
		</fieldset>
		</form>
		<br />
		<ul>
			<li>Todos os campos são obrigatórios</li>
		</ul>
	</div>	
</div>
</body>
</html>
<%conClose%>