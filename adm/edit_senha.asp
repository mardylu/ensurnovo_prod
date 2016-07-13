<%If session("adm")<>"ok" Then Response.Redirect "logout.asp"%>
<!-- #INCLUDE FILE="../library/parametros.asp" -->
<!-- #INCLUDE FILE="../library/conOpen.asp" -->
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

	<title>IBAM Pareceres</title>
	<script language="javascript">
		<!--
		//-->
	</script>
</head>
<body>
<div id="pagina">
	<!-- #INCLUDE FILE="include/topo.asp" -->
	<div id="conteudo">
		<h1>Alterar Senha</h1>
		<form action="resp_senha.asp" method="post">
		<p>senha atual<br><input name="SENHA_ATUAL" type="password" size=20 maxlength=20></p>
		<p>nova senha<br><input name="SENHA_NOVA" type="password" size=20 maxlength=20></p>
		<p>confirmar nova senha<br><input name="SENHA_CONFIRMA" type="password" size=20 maxlength=20></p>
	
		<input type="submit" value="enviar" class="buttonF">
		</form>
	</div>
</div>

</body>
</html>
<%
conClose
%>