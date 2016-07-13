<%If Session("key_cur")<>"ok" Then Response.Redirect "logout.asp"%>
<!-- #INCLUDE FILE="../library/parametros.asp" -->
<!-- #INCLUDE FILE="../library/conOpen.asp" -->
<!-- #INCLUDE FILE="../library/conOpenAF.asp" -->
<!-- #INCLUDE FILE="../library/conOpenSIM.asp" -->
<!-- #INCLUDE FILE="../library/fAddZero.asp" -->
<!-- #INCLUDE FILE="../library/fErroMsg.asp" -->
<!-- #INCLUDE FILE="../library/fData.asp" -->
<!-- #INCLUDE FILE="../library/vHoje.asp" -->
<%
Dim regExSenha
Set regExSenha = New RegExp
regExSenha.Pattern = "^[0-9a-zA-Z]+$"
%>
<%
cod = request.form("cod")
if cod="" or isNumeric(cod)=false then erroMsg("Código inválido. Favor fazer um refresh no navegador e tentar novamente")

TITULO=Replace(Request.Form("TITULO"),"'","''")
if Len(TITULO)=0 then erroMsg("Campo de título é obrigatório")

DESABILITADO=Int(Request.Form("DESABILITADO"))
if DESABILITADO<>1 then DESABILITADO=0

URL=Replace(Request.Form("URL"),"'","''")
if Len(URL)>0 and not regExSenha.Test(URL) then erroMsg("O endereço deve conter somente caracteres alfanuméricos")

COD_TIPO = int(Request("COD_TIPO"))
if COD_TIPO=0 then erroMsg("Selecionar o tipo de curso")

COD_STATUS = int(Request("COD_STATUS"))

EMENTA=Replace(Request.Form("EMENTA"),"'","''")

VALOR=Replace(Request.Form("VALOR"),"'","''")
if inStr(VALOR,",")>0 then
	aVALOR = split(VALOR,",")
	VALOR = int("0"&aVALOR(0)) & addZero(Mid(aVALOR(1)&"0",1,2),2)
else
	if VALOR="" or isNumeric(VALOR)=false then erroMsg("Campo de valor inválido")
	VALOR = int(VALOR)&"00"
end if

VALOR_TXT=Replace(Request.Form("VALOR_TXT"),"'","''")

PARCELAS = Request("PARCELAS")
if PARCELAS="" or isNumeric(PARCELAS)=false or isNull(PARCELAS) then PARCELAS=0

if VALOR=0 and PARCELAS>0 then erroMsg("O campo de parcelas só pode ser definido quando o curso é pago.")
if PARCELAS<0 or PARCELAS>12 then erroMsg("O número máximo de parcelas é 12.")

LUGAR=Replace(Request.Form("LUGAR"),"'","''")

HORARIO=Replace(Request.Form("HORARIO"),"'","''")

DT_INICIO=validaData(Request.Form("DT_INICIO"))
DT_FIM=validaData(Request.Form("DT_FIM"))

DATA_TXT=Replace(Request.Form("DATA_TXT"),"'","''")

VAGAS=Replace(Request.Form("VAGAS"),"'","''")
if VAGAS="" or isNumeric(VAGAS)=false then VAGAS=0

DESTAQUE = Replace(Request.Form("DESTAQUE"),"'","''")

SENHA = Request.Form("SENHA")
if SENHA<>"" then
	if not regExSenha.Test(SENHA) then erroMsg("A senha deve conter somente caracteres alfanuméricos")
end if

COD_PROJETO = Request.Form("COD_PROJETO")
if COD_PROJETO<>"" then
	if isNumeric(COD_PROJETO)=false then erroMsg("Código de projeto inválido. O código deve ser numérico")
	RSAF.Open "select P.COD_AREA_IBAM from PROJETOS P where TIPO <> 'T' and (FECHADO=0 or FECHADO>"&Hoje&") and COD_PROJETO="&COD_PROJETO
	if RSAF.EOF then erroMsg("Código de projeto inválido")
	RSAF.Close
else
	COD_PROJETO=0
end if



if cod>0 then
	RS.Open "SELECT COUNT(*) FROM CURSO WHERE COD_CURSO="&cod
		if RS(0)=0 then erroMsg("Curso não encontrado, faça um refresh em seu navegador e tente novamente")
	RS.Close
	con.execute "UPDATE CURSO SET TITULO='"&TITULO&"',DESABILITADO="&DESABILITADO&",URL='"&URL&"',COD_TIPO="&COD_TIPO&",COD_STATUS="&COD_STATUS&",PARCELAS="&PARCELAS&",EMENTA='"&EMENTA&"',VALOR="&VALOR&",VALOR_TXT='"&VALOR_TXT&"',DATA_TXT='"&DATA_TXT&"',LUGAR='"&LUGAR&"',HORARIO='"&HORARIO&"',DT_INICIO="&DT_INICIO&",DT_FIM="&DT_FIM&",VAGAS="&VAGAS&",DESTAQUE='"&DESTAQUE&"',SENHA='"&SENHA&"',COD_PROJETO="&COD_PROJETO&" WHERE COD_CURSO="&cod
	if COD_STATUS=6 then
		if DT_FIM=0 then DT_FIM=hoje
		conSIM.Execute "DELETE FROM ENSUR WHERE COD_CURSO="&cod
		RS.Open "SELECT A.COD_ALUNO,isNull(COD_ENTI,0) AS COD_ENTI FROM CURSO_ALUNO CA JOIN ALUNO A ON CA.COD_ALUNO=A.COD_ALUNO WHERE APROVADO=1 AND COD_CURSO="&cod
		while not RS.EOF
			if RS(1)>0 then
				conSIM.Execute "INSERT INTO ENSUR (COD_ENTI,DATA,COD_CURSO,COD_ALUNO) VALUES ("&RS(1)&","&DT_FIM&","&cod&","&RS(0)&")"
			end if
			RS.MoveNext
		wend
		RS.Close
	elseif COD_STATUS=7 then
		conSIM.Execute "DELETE FROM ENSUR WHERE COD_CURSO="&cod
	end if
else
	con.execute "INSERT INTO CURSO (TITULO,DESABILITADO,URL,COD_TIPO,COD_STATUS,PARCELAS,EMENTA,VALOR,VALOR_TXT,DATA_TXT,LUGAR,HORARIO,DT_INICIO,DT_FIM,VAGAS,DESTAQUE,SENHA,COD_PROJETO) VALUES ('"&TITULO&"',"&DESABILITADO&",'"&URL&"',"&COD_TIPO&","&COD_STATUS&","&PARCELAS&",'"&EMENTA&"',"&VALOR&",'"&VALOR_TXT&"','"&DATA_TXT&"','"&LUGAR&"','"&HORARIO&"',"&DT_INICIO&","&DT_FIM&","&VAGAS&",'"&DESTAQUE&"','"&SENHA&"',"&COD_PROJETO&")"
end if
conClose
conCloseSIM
conCloseAF
if COD_STATUS>5 then st="1" else st="0" end if
response.redirect "cursos.asp?st="&st
%>