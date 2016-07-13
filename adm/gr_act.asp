<% Response.Expires = 0
Response.Buffer = true
IF NOT Session("key_usuario")>0 THEN
	Response.Redirect "default.asp?t=a"
	Response.End
END IF
'falta fazer os testes de permissao para cada action

%>
<!-- #INCLUDE FILE="../library/parametros.asp" -->
<!-- #include file="../library/conOpenAF.asp" -->
<!-- #include file="../library/vHoje.asp" -->
<!-- #INCLUDE file="../library/fEmail.asp" -->
<!-- #INCLUDE file="../library/fErroMsg.asp" -->
<!-- #INCLUDE file="../library/fFormataValor.asp" -->
<!-- #INCLUDE file="../library/fFormataData.asp" -->
<% task = Request.QueryString("task")


select case task
case "new":


	if not Session("key_cri") then
		erroMsg("Usuário sem permissão para criar nova GR")
	end if
	COD_PROJETO = request("codp")
	
	strSQL = "SELECT PROJETOS.COD_AREA_IBAM,AREA_IBAM FROM PROJETOS,AREAS_IBAM WHERE AREAS_IBAM.COD_AREA_IBAM = PROJETOS.COD_AREA_IBAM AND COD_PROJETO = "&COD_PROJETO
	RSAF.Open strSQL
	if RSAF.EOF then
		erroMsg("Projeto sem area definida, favor entrar em contato com a SAF")
	end if
	if not isNumeric(RSAF(0)) then
		erroMsg("Projeto sem area definida, favor entrar em contato com a SAF")
	end if
	COD_AREA_IBAM = RSAF(0)
	AREA_IBAM = RSAF(1)
	RSAF.Close
	DATA = Request("data")
	
	if inStr(DATA,"/") and len(DATA) = 10 then
		data2 = split(DATA,"/")
		DATA = data2(2)&data2(1)&data2(0)
	end if
	INTERESSADO = Replace(Request("NOME"),"'","''")
	HISTORICO = Replace(Request.Form("HISTORICO"),"'","''")
	REEMBOLSO = Replace(Request.Form("REEMBOLSO"),"'","''")
	if REEMBOLSO = "1" then
		REEMBOLSO = 1
	else
		REEMBOLSO = 0
	end if
	NV1 = "8616"
	NV2 = "8622"
	NV3 = "8639"
	
	if isNumeric(NV3) then
		COD_NATUREZA = NV3
	else
		if isNumeric(NV2) then
			COD_NATUREZA = NV2
		else
			if isNumeric(NV1) then
				COD_NATUREZA = NV1
			else
				erroMsg("Natureza inválida")
			end if
		end if
	end if
	COD_SOLICITA = Session("key_usuario")
	DATA_SOLICITA = hoje
	HORA_SOLICITA = HORA
	strSQL = "SELECT MAX(SEQUENCIAL)+1 FROM GR WHERE DATA_SOLICITA like '"&year(now)&"%'"
	
	VALOR = Replace(Replace(Request("VALOR"),",",""),"'","''")
	
	RSAF.Open strSQL
	if not RSAF.EOF then
		SEQUENCIAL = RSAF(0)
	end if
	RSAF.Close
	if not isNumeric(SEQUENCIAL) then SEQUENCIAL = 1
	NUM_GR = AREA_IBAM&"-"&SEQUENCIAL&"/"&Year(now)
	strSQL = "INSERT INTO GR (NUM_GR,COD_PROJETO,COD_AREA_IBAM,SEQUENCIAL,DATA,INTERESSADO,VALOR,HISTORICO,COD_SOLICITA,DATA_SOLICITA,HORA_SOLICITA,COD_NATUREZA,REEMBOLSO) VALUES ('"&NUM_GR&"',"&COD_PROJETO&","&COD_AREA_IBAM&","&SEQUENCIAL&","&DATA&",'"&INTERESSADO&"',"&VALOR&",'"&HISTORICO&"',"&COD_SOLICITA&","&DATA_SOLICITA&","&HORA_SOLICITA&","&COD_NATUREZA&","&REEMBOLSO&")"
	response.write strSQL
	response.end
	
	RSAF.open strSQL
	
'	ConAF.Execute(strSQL)
	
	' envia email pra saf ??
	msg = "GR Criada com sucesso"
	url = "gr_lista.asp"
case "del":
	if not Session("key_cri") then
		erroMsg("Usuário sem permissão para remover GR")
	end if
	NUM_GR = Replace(Request.QueryString("id"),"'","''")
	COD_AREA_IBAM = Session("key_area")
	if COD_AREA_IBAM = 1 or Session("key_adm") then
		strSQL = "select COD_AREA_IBAM from GR where DATA_EXPORTA=0 and CANCELADA=0 and NUM_GR='"&NUM_GR&"'"
	else
		strSQL = "select COD_AREA_IBAM from GR where DATA_EXPORTA=0 and CANCELADA=0 and NUM_GR='"&NUM_GR&"' and COD_AREA_IBAM="&COD_AREA_IBAM
	end if
	RSAF.Open strSQL
	if RSAF.RecordCount <> 1 then
		erroMsg("Nº da GR inválido,de um refresh em seu navegador")
	end if
	RSAF.Close
	strSQL = "delete from GR where NUM_GR='"&NUM_GR&"'"
	Con.Execute strSQL
	url = "gr_lista.asp"
	msg = "GR removida com sucesso"
case "edit"
	if not Session("key_cri") then
		erroMsg("Usuário sem permissão para editar GR")
	end if
	DATA = Request.Form("DATA")
	if inStr(DATA,"/") and len(DATA) = 10 then
		data2 = split(DATA,"/")
		DATA = data2(2)&data2(1)&data2(0)
	end if
	INTERESSADO = Replace(Request.Form("INTERESSADO"),"'","''")
	HISTORICO = Replace(Request.Form("HISTORICO"),"'","''")
	REEMBOLSO = Replace(Request.Form("REEMBOLSO"),"'","''")
	if REEMBOLSO = "1" then
		REEMBOLSO = 1
	else
		REEMBOLSO = 0
	end if
	NV1 = Replace(Request.Form("NV1"),"'","''")
	NV2 = Replace(Request.Form("NV2"),"'","''")
	NV3 = Replace(Request.Form("NV3"),"'","''")
	if isNumeric(NV3) then
		COD_NATUREZA = NV3
	else
		if isNumeric(NV2) then
			COD_NATUREZA = NV2
		else
			if isNumeric(NV1) then
				COD_NATUREZA = NV1
			else
				erroMsg("Natureza inválida")
			end if
		end if
	end if
	VALOR = Replace(Replace(Request.Form("VALOR"),",",""),"'","''")
	NUM_GR = Replace(Request.Form("NUM_GR"),"'","''")
	strSQL = "select NUM_GR from GR where NUM_GR='"& NUM_GR &"' and DATA_EXPORTA=0"
	RSAF.Open strSQL
	if RSAF.EOF then
		erroMsg("GR inválida, de um refresh em seu navegado")
	end if
	RSAF.Close
	strSQL = "update GR set DATA="& DATA &",INTERESSADO='"& INTERESSADO &"',VALOR="& VALOR &",HISTORICO='"& HISTORICO &"',COD_NATUREZA="& COD_NATUREZA &",REEMBOLSO="& REEMBOLSO &" where NUM_GR='"& NUM_GR &"'"
	Con.Execute(strSQL)
	' envia email pra saf ??
	msg = "GR modificada com sucesso"
	url = "gr_lista.asp"
Case "pgt":
	NUM_GR = Replace(Request.Form("NUM_GR"),"'","''")
	COD_BANCO = Request.Form("COD_BANCO")
	If COD_BANCO = "" Or Not IsNumeric(COD_BANCO) Then
		erroMsg("Banco inválido, de um refresh em seu navegado")
	End If
	strSQL = "select COD_BANCO,COD_PROJETO from GR where NUM_GR='"& NUM_GR &"' and CANCELADA=0 and DATA_EXPORTA=0"
	RSAF.Open strSQL
	If RSAF.RecordCount <> 1 Then
		erroMsg("GR inválida, de um refresh em seu navegador")
	End If
	COD_BANCO_OLD = RS("COD_BANCO")
	COD_PROJETO = cStr(RS("COD_PROJETO"))
	DATA_PGT = Request.Form("DATA_PGT")
	if inStr(DATA_PGT,"/") and len(DATA_PGT) = 10 then
		data2 = split(DATA_PGT,"/")
		DATA_PGT = data2(2)&data2(1)&data2(0)
	end if
	RSAF.Close
	if COD_PROJETO = "1130" or COD_PROJETO = "1146" or COD_PROJETO = "1152" or COD_PROJETO = "1169" then
		strSQL = "update GR set COD_BANCO="& COD_BANCO &",DATA_EXPORTA="& hoje &",DATA_PGT="& DATA_PGT &" where NUM_GR='"& NUM_GR &"'"
	else
		strSQL = "update GR set COD_BANCO="& COD_BANCO &",DATA_PGT="& DATA_PGT &" where NUM_GR='"& NUM_GR &"'"
	end if
	Con.Execute(strSQL)
	url = "gr_lista_pg.asp"
	If COD_BANCO_OLD = "0" then
		msg = "Recebimento cadastrado com sucesso"
	Else
		msg = "Recebimento modificado com sucesso"
	End If
case "exporta"
	if not Session("key_adm") then
		erroMsg("Usuário sem permissão para exportar fatura")
	end if
	strSQL = "select NUM_GR,DATA,COD_BANCO,VALOR,HISTORICO,COD_NATUREZA,COD_PROJETO,INTERESSADO,COD_NATUREZA,REEMBOLSO,DATA_PGT from GR where COD_BANCO>0 and DATA_EXPORTA=0"
	RSAF.Open strSQL
	if RSAF.RecordCount = 0 then
		erroMsg("Nenhuma GR para ser exportada")
	end if
	total = 0
	nomeArquivo="gr"&MID(hoje,3)&".txt"

	Set fs = Server.CreateObject ("Scripting.FileSystemObject")
	caminho = Server.MapPath("../saida")
	arqNum=1
	DO UNTIL fs.FileExists (caminho&"\"&nomeArquivo)=FALSE
		nomeArquivo=MID(nomeArquivo,1,8)&arqNum&".txt"
		arqNum=arqNum+1
	LOOP
	Set bolFile = fs.CreateTextFile(caminho&"\"&nomeArquivo, TRUE)
	total = 0
	while not RSAF.EOF
		if Request.Form(RS(0)) = "1" then
			COD_NATUREZA = RS("COD_NATUREZA")
			REEMBOLSO = RS("REEMBOLSO")
			if REEMBOLSO then
				strSQL = "select CLASSIFICACAO from NATUREZA_DESPESA where COD_NATUREZA_DESPESA=" & RS("COD_NATUREZA")
			else
				strSQL = "select CLASSIFICACAO from NATUREZA_RECEITA where COD_NATUREZA_RECEITA=" & RS("COD_NATUREZA")
			end if
			Set RS2 = Server.CreateObject("ADODB.Recordset")
			RS2.CursorType = 3
			RS2.ActiveConnection = Con
			RS2.Open strSQL
			CLASSIFICACAO = RS2("CLASSIFICACAO")
			RS2.Close
			Set RS2 = Nothing
			DATA_PGT = RS("DATA_PGT")
			DATA = RS("DATA")
			if DATA_PGT <> "0" then
				DATA = DATA_PGT
			end if
			DATA = formataData2(DATA)
			COD_BANCO = RS("COD_BANCO")
			VALOR = formataValorUS(RS("VALOR"))
			HISTORICO = Replace(RS("HISTORICO"),VbCrLf,"")
			COD_NATUREZA = RS("COD_NATUREZA")
			COD_PROJETO = RS("COD_PROJETO")
			NUM_GR = RS("NUM_GR")
			INTERESSADO = RS("INTERESSADO")
			DESCRICAO = UCase("""GR-" & NUM_GR & "-" & left(INTERESSADO,100) & "-" & left(HISTORICO,250) & """")
			strExportaL1 = "TOutras Entradas|1|3|"& DATA &"|"& COD_BANCO &"|1|"& VALOR &"|"&  DESCRICAO &"|"& DATA &"|"& DATA &"|TES005"
			strExportaL2 = "C"& COD_NATUREZA &"|"& VALOR &"||"& DESCRICAO

			IF INT(MID(CLASSIFICACAO,1,1))=3 THEN
				strExportaL3 = "G"& COD_PROJETO &"|"& VALOR
			ELSE
				strExportaL3 = ""
			END IF
			bolFile.WriteLine(strExportaL1)
			bolFile.WriteLine(strExportaL2)
			if strExportaL3 <> "" then
				bolFile.WriteLine(strExportaL3)
			end if
			total = total + 1
			strSQL = "update GR set COD_EXPORTA=" & Session("key_usuario") & ",DATA_EXPORTA=" & hoje & " where NUM_GR='" & NUM_GR & "'"
			Con.Execute(strSQL)
		end if
		RSAF.MoveNext
	wend
	RSAF.Close
	if total > 0 then
		msg = total & " GR(s) exportada(s) para o arquivo"
		url = "gr_exporta.asp?file="&nomeArquivo&"&total="&total
	else
		msg = "Nenhuma GR para ser exportada"
		url = "gr_exporta.asp"
	end if
case "cancela"
	if not Session("key_adm") or Session("key_area") <> 1 then
		erroMsg("Usuário sem permissão para cancelar gr")
	end if
	NUM_GR = Replace(Request.form("NUM_GR"),"'","''")
	CANC_DESCR = Replace(Request.form("TEXTO"),"'","''")
	strSQL = "SELECT NUM_GR FROM GR WHERE NUM_GR='"& NUM_GR &"'"
	RSAF.Open strSQL
	if RSAF.EOF then
		erroMsg("Nº da gr inválido,de um refresh em seu navegador")
	end if
	RSAF.Close
	strSQL = "UPDATE GR SET CANCELADA=1,CANC_DESCR='"& CANC_DESCR &"',NUM_GR='"& NUM_GR & "-C" & "' WHERE NUM_GR='" & NUM_GR & "'"
	url = "gr_relatorio.asp"
	Con.Execute strSQL
	msg = "GR CANCELADA"
case else:
	conCloseAF()
	Response.End()
end select
conCloseAF()
%><script language="javascript" type="text/javascript">
	alert('<%=msg%>');
	window.location = "<%=url%>";
</script>
<% response.redirect "alunos.asp"%>
