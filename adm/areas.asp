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
RS.Open "SELECT * FROM AREA where id_area="&cod
if not RS.EOF then
	AREA= RS("AREA")
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
			<tr><td><h1>Cadastro de Temas</h1></td><td><a href="lista_areas.asp"><img src="img/btnp_seta_invet.gif" border="0"></a></td></tr>
		</table>
		<form name="form" method="POST" action="areas_resp.asp">
		<input type="hidden" name="id_area" value="<%=cod%>">
		<fieldset>
			<legend>informações da área</legend>
			<p><label for="NOME">Área</label><input type="text" name="AREA" id="AREA" maxlength="50" size="60" value="<%=AREA%>" /></p>
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