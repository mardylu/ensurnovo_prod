<%If Session("key_usu")<>"ok" Then Response.Redirect "logout.asp"%>
<!-- #INCLUDE FILE="../library/parametros.asp" -->
<!-- #INCLUDE FILE="../library/conOpen.asp" -->
<!-- #INCLUDE FILE="../library/fErroMsg.asp" -->
<%
cod = request("cod")
if cod="" or isNumeric(cod)=false then cod=0
cod=int(cod)

RS.Open "SELECT id_professor FROM professores WHERE id_professor="&cod
	if RS.EOF then
		erroMsg("Professor não encontrada, faça um refresh em seu navegador e tente novamente")
	end if
RS.Close
con.execute "DELETE PROFESSORES WHERE ID_PROFESSOR="&cod

conClose
response.redirect "lista_professores.asp"
%>