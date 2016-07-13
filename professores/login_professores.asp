<!-- #INCLUDE FILE="../library/parametros.asp" -->
<!-- #INCLUDE FILE="../library/conOpen.asp" -->
<!-- #INCLUDE FILE="../library/fErroMsg.asp" -->
<%

CPF=request("CPF")
SENHA=request("SENHA")
cod=Request.Form("cod")
if cod=0 or cod="" or isNumeric(cod)=false then cod=0

Set regEx = New RegExp
regEx.Pattern = "^[0-9]+$"
retVal = regEx.Test(CPF)
IF NOT retVal THEN CPF=0
CPF=mid(CPF,1,3)&"."&mid(CPF,4,3)&"."&mid(CPF,7,3)&"-"&mid(CPF,10,2)
if CPF="" or SENHA="" then erroMsg("CPF ou senha inválidos.")

RS.Open "SELECT ID_PROFESSOR,SENHA FROM PROFESSORES WHERE CPF='"&CPF&"' AND STATUS_PROFESSOR = 'Ativo'"
If RS.EOF Then
	erroMsg("Cadastro não encontrado, ou bloqueado. Favor conferir os dados.")
Else
	if SENHA <> RS("SENHA") then
		erroMsg("Senha Inválida.")
	else
		ID_PROFESSOR=RS("ID_PROFESSOR")
		Session("pass")="ok"
		Session("id")=ID_PROFESSOR
		RS.Close
		conClose
		Response.Redirect "area_professores.asp"
	End If
end if
Session.Timeout=240

%>