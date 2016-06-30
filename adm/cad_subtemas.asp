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
if cod>0 then
	RS.Open "SELECT * FROM SUBTEMAS where id_subtema="&cod
	if not RS.EOF then
		SUBTEMA= RS("SUBTEMA")
		ID_TEMA = RS("ID_TEMA")
	end if
	RS.Close
end if

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
			<tr><td width="10%"><a href="lista_subtemas.asp" title="Lista de Subtemas"><img src="img/btnp_seta_invet.gif" border="0"></a></td width="90%"><td><h1>Cadastro de Sub-áreas</h1></td></tr>
		</table>
		<form name="form" method="POST" action="salva_sub	temas.asp">
		<input type="hidden" name="id_subtema" value="<%=cod%>">
		<fieldset>
			<legend>informações do Sub-tema</legend>
			<p><label for="ID_TEMA" class="requerido">Área</label><%=createSel("ID_TEMA","SELECT * FROM TEMAS ORDER BY TEMA",ID_TEMA,1,"")%></p></p>
			<p><label for="SUBTEMA" class="requerido">Sub-área</label><input type="text" name="SUBTEMA" id="SUBTEMA" maxlength="50" size="60" value="<%=SUBTEMA%>" /></p>
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