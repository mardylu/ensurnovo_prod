<%If Session("key_usu")<>"ok" Then Response.Redirect "logout.asp"%>
<!-- #INCLUDE FILE="../library/parametros.asp" -->
<!-- #INCLUDE FILE="../library/conOpen.asp" -->
<!-- #INCLUDE FILE="../library/fErroMsg.asp" -->
<%
cod = request("cod")
if cod="" or isNumeric(cod)=false then cod=0
cod=int(cod)

RS.Open "SELECT COD_CURSO FROM CURSO WHERE COD_CURSO="&cod
	if RS.EOF then
		erroMsg("Curso não encontrado, faça um refresh em seu navegador e tente novamente")
	end if
RS.Close
RS.Open "SELECT COD_CURSO FROM TURMA_ALUNO WHERE COD_CURSO="&cod
	if not RS.EOF then
		erroMsg("Este curso não pode ser excluído pois existem alunos cadastrados")
	end if
RS.Close

con.execute "DELETE CURSO WHERE COD_CURSO="&cod
con.execute "DELETE TURMAS WHERE COD_CURSO="&cod

conClose
response.redirect "lista_cursos.asp"
%>