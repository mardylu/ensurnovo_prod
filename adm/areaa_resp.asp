<%If Session("key_usu")<>"ok" Then Response.Redirect "logout.asp"%>
<!-- #INCLUDE FILE="../library/parametros.asp" -->
<!-- #INCLUDE FILE="../library/conOpen.asp" -->
<!-- #INCLUDE FILE="../library/fErroMsg.asp" -->
<%
Set regExSenha = New RegExp
regExSenha.Pattern = "^[0-9a-zA-Z]+$"

Set reMail = New RegExp
reMail.Pattern = "^[\w-\.]{1,}\@([\da-zA-Z-]{1,}\.){1,}[\da-zA-Z-]{2,3}$"
%>
<%
cod = request.form("cod")
if cod="" or isNumeric(cod)=false then cod=0
cod=int(cod)

NOME=Replace(Request.Form("NOME"),"'","''")
if Len(NOME)=0 then erroMsg("Campo de nome é obrigatório")

EMAIL=Replace(Request.Form("EMAIL"),"'","''")
if not reMail.Test(EMAIL) then erroMsg("Campo de e-mail inválido, favor conferir os dados")

LOGIN=Replace(Request.Form("USERID"),"'","''")
if not regExSenha.Test(LOGIN) then erroMsg("O campo de login deve ser alfanumérico")

if cod=0 then
	SENHA=Replace(Request.Form("SENHA"),"'","''")
	if not regExSenha.Test(SENHA) then erroMsg("O campo de senha deve ser alfanumérico")
end if 

KEY_USUARIO=Replace(Request.Form("KEY_USUARIO"),"'","''")
if KEY_USUARIO="ok" then KEY_USUARIO=1 else KEY_USUARIO=0 end if
KEY_VER=Replace(Request.Form("KEY_VER"),"'","''")
if KEY_VER="ok" then KEY_VER=1 else KEY_VER=0 end if
KEY_CURSO=Replace(Request.Form("KEY_CURSO"),"'","''")
if KEY_CURSO="ok" then KEY_CURSO=1 else KEY_CURSO=0 end if
KEY_ALUNO=Replace(Request.Form("KEY_ALUNO"),"'","''")
if KEY_ALUNO="ok" then KEY_ALUNO=1 else KEY_ALUNO=0 end if
KEY_STATUS=Replace(Request.Form("KEY_STATUS"),"'","''")
if KEY_STATUS="ok" then KEY_STATUS=1 else KEY_STATUS=0 end if
KEY_EMAIL=Replace(Request.Form("KEY_EMAIL"),"'","''")
if KEY_EMAIL="ok" then KEY_EMAIL=1 else KEY_EMAIL=0 end if
KEY_PLAN_COMP=Replace(Request.Form("KEY_PLAN_COMP"),"'","''")
if KEY_PLAN_COMP="ok" then KEY_PLAN_COMP=1 else KEY_PLAN_COMP=0 end if
KEY_PLAN_PARC=Replace(Request.Form("KEY_PLAN_PARC"),"'","''")
if KEY_PLAN_PARC="ok" then KEY_PLAN_PARC=1 else KEY_PLAN_PARC=0 end if
KEY_IMPORTA=Replace(Request.Form("KEY_IMPORTA"),"'","''")
if KEY_IMPORTA="ok" then KEY_IMPORTA=1 else KEY_IMPORTA=0 end if
KEY_CURSODEL=Replace(Request.Form("KEY_CURSODEL"),"'","''")
if KEY_CURSODEL="ok" then KEY_CURSODEL=1 else KEY_CURSODEL=0 end if

if KEY_PLAN_COMP=1 then KEY_PLAN_PARC=1
if KEY_CURSO=1 or KEY_ALUNO=1 or KEY_STATUS=1 or KEY_EMAIL=1 or KEY_PLAN_COMP=1 or KEY_PLAN_PARC=1 then KEY_VER=1

RS.Open "SELECT COUNT(*) FROM USUARIO WHERE COD_USUARIO<>"&cod&" AND LOGIN='"&LOGIN&"'"
	if RS(0)>0 then erroMsg("Este login já existe no sistema favor escolher um novo login")
RS.Close

if cod>0 then
	RS.Open "SELECT KEY_USUARIO FROM USUARIO WHERE COD_USUARIO="&cod
		if RS.EOF then
			erroMsg("Usuário não encontrado, faça um refresh em seu navegador e tente novamente")
		else
			old_KEY_USUARIO = RS(0)
		end if
	RS.Close
	if KEY_USUARIO=0 and old_KEY_USUARIO then
		RS.Open "SELECT COUNT(*) FROM USUARIO WHERE KEY_USUARIO=1"
		totAdm=RS(0)
		RS.Close
		if totAdm=1 then erroMsg("É preciso manter ao menos um usuário com permissão para edição de usuários")
	end if
	con.execute "UPDATE USUARIO SET NOME='"&NOME&"',EMAIL='"&EMAIL&"',LOGIN='"&LOGIN&"',KEY_USUARIO="&KEY_USUARIO&",KEY_VER="&KEY_VER&",KEY_CURSO="&KEY_CURSO&",KEY_ALUNO="&KEY_ALUNO&",KEY_STATUS="&KEY_STATUS&",KEY_EMAIL="&KEY_EMAIL&",KEY_PLAN_COMP="&KEY_PLAN_COMP&",KEY_PLAN_PARC="&KEY_PLAN_PARC&",KEY_IMPORTA="&KEY_IMPORTA&",KEY_CURSODEL="&KEY_CURSODEL&" WHERE COD_USUARIO="&cod
else
	con.execute "INSERT INTO USUARIO (NOME,EMAIL,LOGIN,SENHA,KEY_USUARIO,KEY_VER,KEY_CURSO,KEY_ALUNO,KEY_STATUS,KEY_EMAIL,KEY_PLAN_COMP,KEY_PLAN_PARC,KEY_IMPORTA,KEY_CURSODEL) VALUES ('"&NOME&"','"&EMAIL&"','"&LOGIN&"','"&SENHA&"',"&KEY_USUARIO&","&KEY_VER&","&KEY_CURSO&","&KEY_ALUNO&","&KEY_STATUS&","&KEY_EMAIL&","&KEY_PLAN_COMP&","&KEY_PLAN_PARC&","&KEY_IMPORTA&","&KEY_CURSODEL&")"
end if
conClose
response.redirect "usuarios.asp"
%>