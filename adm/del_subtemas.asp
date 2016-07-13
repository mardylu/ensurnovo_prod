<%If Session("key_usu")<>"ok" Then Response.Redirect "logout.asp"%>
<!-- #INCLUDE FILE="../library/parametros.asp" -->
<!-- #INCLUDE FILE="../library/conOpen.asp" -->
<!-- #INCLUDE FILE="../library/fErroMsg.asp" -->
<%
cod = request("cod")
if cod="" or isNumeric(cod)=false then cod=0
cod=int(cod)

RS.Open "SELECT id_subtema FROM subtemas WHERE id_subtema="&cod
	if RS.EOF then
		erroMsg("Sub-tema não encontrado, faça um refresh em seu navegador e tente novamente")
	end if
RS.Close
con.execute "DELETE SUBTEMAS WHERE ID_subtema="&cod

conClose
response.redirect "lista_subtemas.asp"
%>