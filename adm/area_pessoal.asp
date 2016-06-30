<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!-- #INCLUDE FILE="library/parametros.asp" -->
<!-- #INCLUDE FILE="library/conOpen.asp" -->
<!-- #INCLUDE FILE="library/conOpenSIM.asp" -->
<!-- #INCLUDE FILE="library/fErroMsg.asp" -->
<!-- #INCLUDE FILE="library/fFormataValor.asp" -->
<!-- #INCLUDE FILE="library/fPagamentos.asp" -->
<!-- #INCLUDE FILE="library/fData.asp" -->

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

	<link rel="stylesheet" type="text/css" href="css/styles.css" />
	<link rel="stylesheet" type="text/css" href="css/form.css" />
	<script type="text/javascript">
	function submitForm() {
		
		//document.parcForm.submit();
		return false;
	}
	function openWindow2() {
		myVar=open('esqueci.asp','Senha','scrollbars=yes,width=300,height=140');
	}
	function openWindow36() {
		myVar=open('carta_certificado.htm','Certificado','scrollbars=no,resize=no,width=800,height=500');
	}
	</script>
	<title>ENSUR Inscrições</title>
</head>
<body>
<div id="pagina">
	<!-- #INCLUDE FILE="include/topo.asp" -->
	<div id="conteudo">
		<h1>ÁREA PESSOAL</h1>
		<%if session("pass")<>"ok" then%>
			<form action="login.asp" method="post" name="login">
			<fieldset>
				<legend>entre com seus dados</legend>
				<p><label for="CPF" class="requerido">CPF</label><input type="text" name="CPF" id="CPF" maxlength="11" size="12" onKeyPress="return ValidateKeyPressed('INT', this, event);"> somente números</p>
				<p><label for="PASSWORD" class="requerido">SENHA</label><input type="password" name="PASSWORD" id="PASSWORD" maxlength="15" size="15"></p>
				<p><label for="ENVIAR">&nbsp;</label><input type="submit" name="submit" value="Enviar" class="buttonF"></p>
				<p><a href="javascript:openWindow2();">Esqueci minha senha</a></p>
			</fieldset>
			</form>
		<%
		else
			if len(session("id")) > 0 then
			else
				session("id") = request("cod_aluno")
			end if
			sql = "SELECT NOME,CPF,PASSWORD FROM ALUNO WHERE COD_ALUNO="&session("id")
			RS.Open sql
	
			if RS.EOF then
				%><p>Seu cadastro não foi encontrado em nossa base. Faça um novo login. Caso o erro persista, favor entrar em contato com o IBAM.</p><%
			else
				NOME = RS("NOME")
				CPF = RS("CPF")
				PASSWORD = RS("PASSWORD")

			end if
			RS.Close
			%>
			<h2><%=NOME%></h2>
			<p><br /></p>
			<h2>Você está inscrito nos seguintes cursos</h2>
			<%
			'sql = "SELECT CA.COD_ALUNO,TU.ID_TURMA,CUSTO_ENTI,CA.ID_INSCRICAO,C.COD_CURSO,T.DESCRICAO AS TDESC,S.DESCRICAO AS SDESC,C.TITULO,TU.DT_INICIO_TURMA,TU.DT_FIM_TURMA,TU.VALOR,TU.LUGAR,TU.HORARIO,C.COD_STATUS,CA.PAGO,C.PARCELAS AS CURSO_PARCELAS,CA.PARCELAS AS ALUNO_PARCELAS,CUSTO_ENTI,TU.EMENTA FROM TURMAS TU JOIN CURSO C ON TU.COD_CURSO=C.COD_CURSO JOIN CURSO_STATUS S ON C.COD_STATUS=S.COD_STATUS JOIN CURSO_TIPO T ON C.COD_TIPO=T.COD_TIPO JOIN TURMA_ALUNO CA ON C.COD_CURSO=CA.COD_CURSO WHERE TU.COD_STATUS_TURMA>1 AND TU.COD_STATUS_TURMA<>4 AND C.COD_STATUS=1 AND CA.COD_ALUNO="&session("id")&" ORDER BY TU.DT_INICIO_TURMA DESC"

Response.Write(session("id"))
Response.End

			sql = "SELECT CA.COD_ALUNO,TU.ID_TURMA,TU.COD_CURSO,CUSTO_ENTI,CA.ID_INSCRICAO,C.COD_CURSO,T.DESCRICAO AS TDESC,S.DESCRICAO AS SDESC,C.TITULO,TU.DT_INICIO_TURMA,TU.DT_FIM_TURMA,TU.VALOR,TU.LUGAR,TU.HORARIO,C.COD_STATUS,CA.PAGO,C.PARCELAS AS CURSO_PARCELAS,CA.PARCELAS AS ALUNO_PARCELAS,CUSTO_ENTI,TU.EMENTA FROM TURMA_ALUNO CA JOIN CURSO C ON CA.COD_CURSO=C.COD_CURSO JOIN CURSO_STATUS S ON C.COD_STATUS=S.COD_STATUS JOIN CURSO_TIPO T ON C.COD_TIPO=T.COD_TIPO JOIN TURMAS TU ON TU.COD_CURSO=C.COD_CURSO AND TU.ID_TURMA=CA.ID_TURMA WHERE TU.COD_STATUS_TURMA>1 AND TU.COD_STATUS_TURMA<>4 AND C.COD_STATUS=1 AND CA.COD_ALUNO="&session("id")&" ORDER BY TU.DT_INICIO_TURMA DESC"
			RS.Open sql

			if RS.EOF then
				%><p>Você não está inscrito em nenhum curso no momento. Cursos já iniciados não constam nesta listagem.</p><%
			else
				while not RS.EOF
					CUSTO_ENTI=RS("CUSTO_ENTI")
					ID_TURMA=RS("ID_TURMA")
					%>
					<table id="tab_curso">
						<thead>
							<tr><th></th><th><h2><%=RS("TITULO")%></h2></th></tr>
						</thead>
						<tbody>
							<tr><td class="clabel"></td><td><%=RS("SDESC")%></td></tr>
							<%
							if RS("DT_INICIO_TURMA")<>"" then
								if RS("DT_FIM_TURMA")<>"" then
									%><tr><td class="clabel">período</td><td class="data">de <%=formataData(RS("DT_INICIO_TURMA"))%> até <%=formataData(RS("DT_FIM_TURMA"))%></td></tr><%
								else
									%><tr><td class="clabel">período</td><td class="data"><%=formataData(RS("DT_INICIO_TURMA"))%></td></tr><%
								end if
							end if
							%>
							<tr><td class="clabel">modalidade</td><td><%=RS("TDESC")%></td></tr>
							<%if lcase(RS("TDESC"))<>"ead" then%>
								<%if Len(RS("LUGAR"))>0 then%><tr><td class="clabel">local de realização</td><td><%=RS("LUGAR")%></td></tr><%end if%>
							<%end if%>
							<%if Len(RS("HORARIO"))>0 then%><tr><td class="clabel">carga horária</td><td><%=RS("HORARIO")%></td></tr><%end if%>
							<tr><td class="clabel">Certificado </td><td>
							<%
							   'Option Explicit
							   On Error Resume Next

							   ' Declara as variáveis
							   Dim objFSO, objFolder
							   Dim objCollection, objItem

							   Dim strPhysicalPath, strTitle, strServerName
							   Dim strPath, strTemp
							   Dim strName, strFile, strExt, strAttr
							   Dim intSizeB, intSizeK, intAttr, dtmDate

							   ' Declara as constantes
							   Const vbReadOnly = 1
							   Const vbHidden = 2
							   Const vbSystem = 4
							   Const vbVolume = 8
							   Const vbDirectory = 16
							   Const vbArchive = 32
							   Const vbAlias = 64
							   Const vbCompressed = 128

							   ' Não armazenar em cache
							   Response.AddHeader "Pragma", "No-Cache"
							   Response.CacheControl = "Private"

							   ' obter o caminho URL da atual pasta
							   strTemp = Mid(Request.ServerVariables("URL"),2)
							   strPath = ""

							   Do While Instr(strTemp,"/")
							      strPath = strPath & Left(strTemp,Instr(strTemp,"/"))
							      strTemp = Mid(strTemp,Instr(strTemp,"/")+1)
							   Loop

							   'strPath = "/sistemas/ronaldo/adm/certificados/"
							   strPath = "/adm/certificados/"
							   ' Configura o título da página
							   strServerName = UCase(Request.ServerVariables("SERVER_NAME"))

							   ' cria os objetos do sistema de arquivos
							   strPhysicalPath = Server.MapPath(strPath)
							   Set objFSO = Server.CreateObject("Scripting.FileSystemObject")
							   Set objFolder = objFSO.GetFolder(strPhysicalPath)
							   ''''''''''''''''''''''''''''''''''''''''
							   ' imprimir a lista de pastas
							   ''''''''''''''''''''''''''''''''''''''''

							   Set objCollection = objFolder.SubFolders

							   For Each objItem in objCollection
							      strName = objItem.Name
							      strAttr = MakeAttr(objItem.Attributes)
							      dtmDate = CDate(objItem.DateLastModified)
								Next

							   ''''''''''''''''''''''''''''''''''''''''
							   ' imprimir a lista de arquivos
							   ''''''''''''''''''''''''''''''''''''''''

							   Set objCollection = objFolder.Files
						       arq1="Certificado_"&RS("COD_ALUNO")&"_"&RS("COD_CURSO")&"_"&RS("ID_TURMA")&".pdf"

Response.Write(arq1)
Response.End
							   For Each objItem in objCollection
							      strName = objItem.Name
							      strFile = Server.HTMLEncode(Lcase(strName))

							      intSizeB = objItem.Size
							      intSizeK = Int((intSizeB/1024) + .5)
							      If intSizeK = 0 Then intSizeK = 1

							      strAttr = MakeAttr(objItem.Attributes)
							      'strName = Ucase(objItem.ShortName)
							      If Instr(strName,".") Then strExt = Right(strName,Len(strName)-Instr(strName,".")) Else strExt = ""
							      dtmDate = CDate(objItem.DateLastModified)

									if strName=arq1 then
										str_certificado = "<a href="&strPath&strFile&" target=new>"&strName&"</a> "
                                        str_certificado = str_certificado & "&nbsp;&nbsp;&nbsp;&nbsp;"
                                        str_certificado = str_certificado & "<a href='javascript:openWindow36();'>Informações para a impressão...</a>"
									end if
								Next
							   	Set objFSO = Nothing
							   	Set objFolder = Nothing
								%>
								<% if str_certificado="" then %>Seu certificado para este curso ainda não foi emitido»<%else%><%=str_certificado%><%end if %></td></tr><br><br>
														
							<tr><td class="clabel">pagamentos</td><td>
							<%
							if RS("VALOR")=0 then
								%>Curso gratuito<%
							elseif RS("CURSO_PARCELAS")=0 then
								%>Curso sem pagamento pela internet<%
							else
								if RS("PAGO") then
									%>Pagamento recebido.<%
								else
									if RS("ALUNO_PARCELAS")=0 then
										if RS("CURSO_PARCELAS")=1 then
											response.redirect "setParcelas.asp?cod="&RS("ID_TURMA")&"&PARCELAS=1"
										else
										end if
									else
										%>
										<p class="laranja">Verifique abaixo o seu histórico de pagamento (Para PagSeguro aguarde a baixa)</p><%
										Set RS2 = Server.CreateObject("ADODB.Recordset")
										RS2.CursorType = 0
										RS2.ActiveConnection = Con
										
										sql = "SELECT * FROM PAGAMENTO WHERE ID_TURMA='"&ID_TURMA&"' AND COD_ALUNO='"&session("id")&"'"
										response.write sql
										'response.end
										
										RS2.open sql
										while not RS2.eof
											txt = "<a href=""gera_boleto.asp?cod="&ID_TURMA&"&parc="&RS2("NUM_PARCELA")&"&cod_aluno="&session("id")&""" target=""_new"">Pagamento pendente, clique aqui para gerar boleto de pagamento</a>"
											if HOJE - RS2("DT_PGT")>0 then 
												txt = "Recebemos R$ "&formataValor(RS2("VALOR"))&" em "&formataData(RS2("DT_PGT"))
											end if
											if RS2("NUM_PARCELA")>=1 then
												%><p>Parcela <%=RS2("NUM_PARCELA")%>: <%=txt%></p><%
											else
												%><p><%=txt%></p><%
											end if
											if not RS2.eof then
												RS2.movenext
											end if
										wend
										
										Set RS2 = Nothing
									end if
								end if
							end if
							%>
							<br />
							</td></tr>
							<%
							if RS("VALOR")>0 and not RS("PAGO") and RS("CUSTO_ENTI") then
							end if
							
							%>
						</tbody>
						<tfoot>
							<tr><td class="clabel"></td><td></td></tr>
						</tfoot>
					</table>
					<p><br /></p>
					<%
					RS.MoveNext
				wend
			end if
			RS.Close
			%>
			<%
		end if
		%>	
	</div>	
	<!-- #INCLUDE FILE="include/footer.asp" -->
</div>
</body>
</html>
<%conClose%>