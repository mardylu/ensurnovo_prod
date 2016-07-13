<%If Session("key_usu")<>"ok" Then Response.Redirect "logout.asp"%>
<!-- #INCLUDE FILE="../library/parametros.asp" -->
<!-- #INCLUDE FILE="../library/conOpen.asp" -->
<!-- #INCLUDE FILE="../library/fErroMsg.asp" -->
<%
cod = request("cod")
if cod="" or isNumeric(cod)=false then cod=0
cod=int(cod)

RS.Open "SELECT id_disciplina FROM disciplinas WHERE id_disciplina="&cod
	if RS.EOF then
		erroMsg("Disciplina não encontrada, faça um refresh em seu navegador e tente novamente")
	end if
RS.Close
con.execute "DELETE disciplinaS WHERE ID_disciplina="&cod

conClose
response.redirect "lista_disciplinas.asp"
%>