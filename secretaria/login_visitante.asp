<!-- #INCLUDE FILE="../library/parametros.asp" -->
<!-- #INCLUDE FILE="../library/conOpen.asp" -->
<!-- #INCLUDE FILE="../library/fErroMsg.asp" -->
<%
CPF=Request.Form("CPF")
PASSWORD=request.Form("PASSWORD")
cod=Request.Form("cod")
if cod=0 or cod="" or isNumeric(cod)=false then cod=0

Set regEx = New RegExp
regEx.Pattern = "^[0-9]+$"
retVal = regEx.Test(CPF)
IF NOT retVal THEN CPF=0
sql = "SELECT COD_ALUNO,PASSWORD FROM ALUNO WHERE CPF='"&CPF&"'"

CPF=mid(CPF,1,3)&"."&mid(CPF,4,3)&"."&mid(CPF,7,3)&"-"&mid(CPF,10,2)
if CPF="" or PASSWORD="" then erroMsg("CPF ou senha inválidos.")

RS.Open sql


If RS.EOF Then
	erroMsg("Cadastro não encontrado. Favor conferir os dados.")
Else
	if PASSWORD <> RS("PASSWORD") then
		erroMsg("Senha Inválida.")
	else
		COD_ALUNO=RS("COD_ALUNO")
		Session("pass")="ok"
		Session("id")=COD_ALUNO
		RS.Close
		conClose
		Response.Redirect "default.asp"
	End If
end if
Session.Timeout=240

%>