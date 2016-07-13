<!-- #INCLUDE FILE="library/parametros.asp" -->
<!-- #INCLUDE FILE="library/conOpen.asp" -->
<!-- #INCLUDE FILE="library/fErroMsg.asp" -->
<%
CPF=Request.Form("CPF")
cod=Request.Form("cod")
if cod=0 or cod="" or isNumeric(cod)=false then cod=0

Set regEx = New RegExp
regEx.Pattern = "^[0-9]+$"
retVal = regEx.Test(CPF)
IF NOT retVal THEN CPF=0

if CPF=0 then erroMsg("Cadastro não encontrado. Favor conferir os dados.")

RS.Open "SELECT COD_ALUNO FROM ALUNO WHERE CPF='"&CPF&"'"
If RS.EOF Then
	erroMsg("Cadastro não encontrado. Favor conferir os dados.")
Else
	COD_ALUNO=RS("COD_ALUNO")
End If
RS.Close
Session("pass")="ok"
Session("id")=COD_ALUNO

conClose

Session.Timeout=240

if cod=0 then
	Response.Redirect "area_pessoal.asp"
else
	Response.Redirect "cadastro.asp?cod="&cod
end if
%>