<%If Session("key_cud")<>"ok" Then Response.Redirect "logout.asp"%>
<!-- #INCLUDE FILE="../library/parametros.asp" -->
<!-- #INCLUDE FILE="../library/conOpen.asp" -->
<!-- #INCLUDE FILE="../library/fErroMsg.asp" -->
<%
cod = request("cod")
if cod="" or isNumeric(cod)=false then erroMsg("Código inválido. Favor fazer um refresh no navegador e tentar novamente")

RS.Open "SELECT COUNT(*) FROM CURSO WHERE COD_CURSO="&cod
	if RS(0)=0 then erroMsg("Curso não encontrado, faça um refresh em seu navegador e tente novamente")
RS.Close
con.execute "DELETE FROM CURSO WHERE COD_CURSO="&cod
conClose
'alerta("CURSO APAGADO COM SUCESSO")
response.redirect "cursos.asp"
%>