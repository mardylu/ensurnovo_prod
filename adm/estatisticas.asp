<%If session("key_ver")<>"ok" Then Response.Redirect "logout.asp"%>
<!-- #INCLUDE FILE="../library/parametros.asp" -->
<!-- #INCLUDE FILE="../library/conOpenAF.asp" -->
<!-- #INCLUDE FILE="../library/conOpen.asp" -->
<!-- #INCLUDE FILE="../library/fErroMsg.asp" -->
<!-- #INCLUDE FILE="../library/fData.asp" -->
<!-- #INCLUDE FILE="../library/fCreateSel.asp" -->
<!-- #INCLUDE FILE="../library/fEmail.asp" -->
<!-- #INCLUDE FILE="../library/vAprova.asp" -->
<!-- #INCLUDE FILE="../library/vFormaPgt.asp" -->
<!-- #INCLUDE FILE="../library/fFormataValor.asp" -->

<%
if Session("key_sta")="ok" or Session("key_ema")="ok" or Session("key_plc")="ok" or Session("key_plp")="ok" then
	mostraSel = true
else
	mostraSel = false
end if


Set RS1 = Server.CreateObject("ADODB.Recordset")
RS1.CursorType = 0
RS1.ActiveConnection = Con

Set RS2 = Server.CreateObject("ADODB.Recordset")
RS2.CursorType = 0
RS2.ActiveConnection = Con

Set RS3 = Server.CreateObject("ADODB.Recordset")
RS3.CursorType = 0
RS3.ActiveConnection = Con

Set RS4 = Server.CreateObject("ADODB.Recordset")
RS4.CursorType = 0
RS4.ActiveConnection = Con

Set RS5 = Server.CreateObject("ADODB.Recordset")
RS5.CursorType = 0
RS5.ActiveConnection = Con

Set RS6 = Server.CreateObject("ADODB.Recordset")
RS6.CursorType = 0
RS6.ActiveConnection = Con

Set RS7 = Server.CreateObject("ADODB.Recordset")
RS7.CursorType = 0
RS7.ActiveConnection = Con

Set RS8 = Server.CreateObject("ADODB.Recordset")
RS8.CursorType = 0
RS8.ActiveConnection = Con

CONST adFldIsNullable = &H00000020
CONST adVarChar = 200
CONST adOpenDynamic = 2
CONST adUseClient = 3
 
Set FS = Server.CreateObject("ADODB.Recordset")

FS.CursorLocation = adUseClient
FS.CursorType = adOpenDynamic
FS.Fields.Append "ORDEM", adVarChar, 255, adFldIsNullable
FS.Fields.Append "FILTRO", adVarChar, 255, adFldIsNullable
FS.Fields.Append "PRIORIDADE", adVarChar, 255, adFldIsNullable
FS.Fields.Append "TABELA", adVarChar, 255, adFldIsNullable
FS.Fields.Append "CAMPO", adVarChar, 255, adFldIsNullable
FS.Fields.Append "ID_CAMPO", adVarChar, 255, adFldIsNullable
FS.Fields.Append "ALIAS_TABELA", adVarChar, 255, adFldIsNullable
FS.Fields.Append "TABELA_DEPENDENTE", adVarChar, 255, adFldIsNullable
FS.Fields.Append "CAMPO_DEPENDENTE", adVarChar, 255, adFldIsNullable
FS.open

%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
		<title>ENSUR Inscrições</title>
	</head>
	<body onLoad="GetSelectedItem(<% =turma %>);">
		<div id="pagina">
			<!-- #INCLUDE FILE="include/topo.asp" -->
			<div id="conteudo">
				<% if request("op") = 1 then %>
					<button id="bt_menu" onClick="window.print();return false;">Imprimir</button>
				<% end if 
				ID_FILTRO1 = request("ID_FILTRO1")
				ID_FILTRO2 = request("ID_FILTRO2")
				ID_FILTRO3 = request("ID_FILTRO3")
				ID_FILTRO4 = request("ID_FILTRO4")
				ID_FILTRO5 = request("ID_FILTRO5")
				ID_FILTRO6 = request("ID_FILTRO6")
				ID_FILTRO7 = request("ID_FILTRO7")
				ID_FILTRO8 = request("ID_FILTRO8")
				EXCEL = request("EXCEL")
				
				if ID_FILTRO1="" or isNumeric(ID_FILTRO1)=false then ID_FILTRO1=0
				if ID_FILTRO2="" or isNumeric(ID_FILTRO2)=false then ID_FILTRO2=0
				if ID_FILTRO3="" or isNumeric(ID_FILTRO3)=false then ID_FILTRO3=0
				if ID_FILTRO4="" or isNumeric(ID_FILTRO4)=false then ID_FILTRO4=0
				if ID_FILTRO5="" or isNumeric(ID_FILTRO5)=false then ID_FILTRO5=0
				if ID_FILTRO6="" or isNumeric(ID_FILTRO6)=false then ID_FILTRO6=0
				if ID_FILTRO7="" or isNumeric(ID_FILTRO7)=false then ID_FILTRO7=0
				if ID_FILTRO8="" or isNumeric(ID_FILTRO8)=false then ID_FILTRO8=0
				
				%>
				<fieldset>
					<legend>Selecione os filtros desejados</legend>
					<form name="formulario" method="post" action="estatisticas.asp">
						<p><label for="ID_TURMA">Filtro 1</label>
						<select name="ID_FILTRO1" id="ID_FILTRO1">
						<option></option>
						<%
						RS.open "SELECT ID_FILTRO,FILTRO,TABELA,CAMPO,ID_CAMPO,ALIAS_TABELA FROM TABELA_FILTROS ORDER BY FILTRO" 
						while not RS.eof
							%><option value=<% =RS("ID_FILTRO") %> <% if CINT(ID_FILTRO1)=RS("ID_FILTRO") then%> Selected <% end if %>><% =RS("FILTRO") %></option>
							<%RS.movenext
						wend
						%>
						</select></p>
						
						<p><label for="ID_TURMA">Filtro 2</label>
						<select name="ID_FILTRO2" id="ID_FILTRO2">
						<option></option>
						<%
						RS.movefirst
						while not RS.eof
							%><option value=<% =RS("ID_FILTRO") %> <% if CINT(ID_FILTRO2)=RS("ID_FILTRO") then%> Selected <% end if %>><% =RS("FILTRO") %></option>
							<%RS.movenext
						wend
						%>
						</select></p>
						
						<p><label for="ID_TURMA">Filtro 3</label>
						<select name="ID_FILTRO3" id="ID_FILTRO3">
						<option></option>
						<%
						RS.movefirst
						while not RS.eof
							%><option value=<% =RS("ID_FILTRO") %> <% if CINT(ID_FILTRO3)=RS("ID_FILTRO") then%> Selected <% end if %>><% =RS("FILTRO") %></option>
							<%RS.movenext
						wend
						%>
						</select></p>
				
						<p><label for="ID_TURMA">Filtro 4</label>
						<select name="ID_FILTRO4" id="ID_FILTRO4">
						<option></option>
						<%
						RS.movefirst
						while not RS.eof
							%><option value=<% =RS("ID_FILTRO") %> <% if CINT(ID_FILTRO4)=RS("ID_FILTRO") then%> Selected <% end if %>><% =RS("FILTRO") %></option>
							<%RS.movenext
						wend
						%>
						</select></p>
						
						<p><label for="ID_TURMA">Filtro 5</label>
						<select name="ID_FILTRO5" id="ID_FILTRO5">
						<option></option>
						<%
						RS.movefirst
						while not RS.eof
							%><option value=<% =RS("ID_FILTRO") %> <% if CINT(ID_FILTRO5)=RS("ID_FILTRO") then%> Selected <% end if %>><% =RS("FILTRO") %></option>
							<%RS.movenext
						wend
						%>
						</select></p>
						
						<p><label for="ID_TURMA">Filtro 6</label>
						<select name="ID_FILTRO6" id="ID_FILTRO6">
						<option></option>
						<%
						RS.movefirst
						while not RS.eof
							%><option value=<% =RS("ID_FILTRO") %> <% if CINT(ID_FILTRO6)=RS("ID_FILTRO") then%> Selected <% end if %>><% =RS("FILTRO") %></option>
							<%RS.movenext
						wend
						%>
						</select></p>
						
						<p><label for="ID_TURMA">Filtro 7</label>
						<select name="ID_FILTRO7" id="ID_FILTRO7">
						<option></option>
						<%
						RS.movefirst
						while not RS.eof
							%><option value=<% =RS("ID_FILTRO") %> <% if CINT(ID_FILTRO7)=RS("ID_FILTRO") then%> Selected <% end if %>><% =RS("FILTRO") %></option>
							<%RS.movenext
						wend
						%>
						</select></p>
						
						<p><label for="ID_TURMA">Filtro 8</label>
						<select name="ID_FILTRO8" id="ID_FILTRO8">
						<option></option>
						<%
						RS.movefirst
						while not RS.eof
							%><option value=<% =RS("ID_FILTRO") %> <% if CINT(ID_FILTRO8)=RS("ID_FILTRO") then%> Selected <% end if %>><% =RS("FILTRO") %></option>
							<%RS.movenext
						wend
						%>
						</select></p>	
						<p><label for="EXCEL">&nbsp;</label><input type="checkbox" value="ok" name="EXCEL" id="EXCEL"> Gerar resultado em planilha</p>
						<input type="submit" name="submit" value="Executar" class="buttonF">
						<p><br></p>
					</form>
				</fieldset>
				<% 
				RS.close
				FILTROS = 0
				if ID_FILTRO1 > 0 then
					sql = "DELETE FROM ESTATISTICA WHERE USUARIO='"&Session("id")&"'"
					RS.open sql
				
					qry = "SELECT ID_FILTRO,PRIORIDADE,FILTRO,TABELA,CAMPO,ID_CAMPO,ALIAS_TABELA,TABELA_DEPENDENTE,CAMPO_DEPENDENTE FROM TABELA_FILTROS WHERE ID_FILTRO='"&ID_FILTRO1&"'"
					RS.open qry
					FILTROS = FILTROS + 1
					FS.AddNew
					FS.Fields("ORDEM") = "ORD1"
					FS.Fields("FILTRO") = RS("FILTRO")
					FS.Fields("PRIORIDADE") = RS("PRIORIDADE")
					FS.Fields("TABELA") = RS("TABELA")
					FS.Fields("CAMPO") = RS("CAMPO")
					FS.Fields("ID_CAMPO") = RS("ID_CAMPO")
					FS.Fields("ALIAS_TABELA") = RS("ALIAS_TABELA")
					FS.Fields("TABELA_DEPENDENTE") = RS("TABELA_DEPENDENTE")
					FS.Fields("CAMPO_DEPENDENTE") = RS("CAMPO_DEPENDENTE")
					FS.update
					RS.close
				end if
				if ID_FILTRO2 > 0 then
					qry = "SELECT ID_FILTRO,PRIORIDADE,FILTRO,TABELA,CAMPO,ID_CAMPO,ALIAS_TABELA,TABELA_DEPENDENTE,CAMPO_DEPENDENTE FROM TABELA_FILTROS WHERE ID_FILTRO='"&ID_FILTRO2&"'"
					RS.open qry
					FILTROS = FILTROS + 1
					FS.AddNew
					FS.Fields("ORDEM") = "ORD2"
					FS.Fields("FILTRO") = RS("FILTRO")
					FS.Fields("PRIORIDADE") = RS("PRIORIDADE")
					FS.Fields("TABELA") = RS("TABELA")
					FS.Fields("CAMPO") = RS("CAMPO")
					FS.Fields("ID_CAMPO") = RS("ID_CAMPO")
					FS.Fields("ALIAS_TABELA") = RS("ALIAS_TABELA")
					FS.Fields("TABELA_DEPENDENTE") = RS("TABELA_DEPENDENTE")
					FS.Fields("CAMPO_DEPENDENTE") = RS("CAMPO_DEPENDENTE")
					FS.update
					RS.close
				end if
				if ID_FILTRO3 > 0 then
					qry = "SELECT ID_FILTRO,PRIORIDADE,FILTRO,TABELA,CAMPO,ID_CAMPO,ALIAS_TABELA,TABELA_DEPENDENTE,CAMPO_DEPENDENTE FROM TABELA_FILTROS WHERE ID_FILTRO='"&ID_FILTRO3&"'"
					RS.open qry
					FILTROS = FILTROS + 1
					FS.AddNew
					FS.Fields("ORDEM") = "ORD3"
					FS.Fields("FILTRO") = RS("FILTRO")
					FS.Fields("PRIORIDADE") = RS("PRIORIDADE")
					FS.Fields("TABELA") = RS("TABELA")
					FS.Fields("CAMPO") = RS("CAMPO")
					FS.Fields("ID_CAMPO") = RS("ID_CAMPO")
					FS.Fields("ALIAS_TABELA") = RS("ALIAS_TABELA")
					FS.Fields("TABELA_DEPENDENTE") = RS("TABELA_DEPENDENTE")
					FS.Fields("CAMPO_DEPENDENTE") = RS("CAMPO_DEPENDENTE")
					FS.update
					RS.close
				end if
				if ID_FILTRO4 > 0 then
					qry = "SELECT ID_FILTRO,PRIORIDADE,FILTRO,TABELA,CAMPO,ID_CAMPO,ALIAS_TABELA,TABELA_DEPENDENTE,CAMPO_DEPENDENTE FROM TABELA_FILTROS WHERE ID_FILTRO='"&ID_FILTRO4&"'"
					RS.open qry
					FILTROS = FILTROS + 1
					FS.AddNew
					FS.Fields("ORDEM") = "ORD4"
					FS.Fields("FILTRO") = RS("FILTRO")
					FS.Fields("PRIORIDADE") = RS("PRIORIDADE")
					FS.Fields("TABELA") = RS("TABELA")
					FS.Fields("CAMPO") = RS("CAMPO")
					FS.Fields("ID_CAMPO") = RS("ID_CAMPO")
					FS.Fields("ALIAS_TABELA") = RS("ALIAS_TABELA")
					FS.Fields("TABELA_DEPENDENTE") = RS("TABELA_DEPENDENTE")
					FS.Fields("CAMPO_DEPENDENTE") = RS("CAMPO_DEPENDENTE")
					FS.update
					RS.close
				end if
				if ID_FILTRO5 > 0 then
					qry = "SELECT ID_FILTRO,PRIORIDADE,FILTRO,TABELA,CAMPO,ID_CAMPO,ALIAS_TABELA,TABELA_DEPENDENTE,CAMPO_DEPENDENTE FROM TABELA_FILTROS WHERE ID_FILTRO='"&ID_FILTRO5&"'"
					RS.open qry
					FILTROS = FILTROS + 1
					FS.AddNew
					FS.Fields("ORDEM") = "ORD5"
					FS.Fields("FILTRO") = RS("FILTRO")
					FS.Fields("PRIORIDADE") = RS("PRIORIDADE")
					FS.Fields("TABELA") = RS("TABELA")
					FS.Fields("CAMPO") = RS("CAMPO")
					FS.Fields("ID_CAMPO") = RS("ID_CAMPO")
					FS.Fields("ALIAS_TABELA") = RS("ALIAS_TABELA")
					FS.Fields("TABELA_DEPENDENTE") = RS("TABELA_DEPENDENTE")
					FS.Fields("CAMPO_DEPENDENTE") = RS("CAMPO_DEPENDENTE")
					FS.update
					RS.close
				end if
				if ID_FILTRO6 > 0 then
					qry = "SELECT ID_FILTRO,PRIORIDADE,FILTRO,TABELA,CAMPO,ID_CAMPO,ALIAS_TABELA,TABELA_DEPENDENTE,CAMPO_DEPENDENTE FROM TABELA_FILTROS WHERE ID_FILTRO='"&ID_FILTRO6&"'"
					RS.open qry
					FILTROS = FILTROS + 1
					FS.AddNew
					FS.Fields("ORDEM") = "ORD6"
					FS.Fields("FILTRO") = RS("FILTRO")
					FS.Fields("PRIORIDADE") = RS("PRIORIDADE")
					FS.Fields("TABELA") = RS("TABELA")
					FS.Fields("CAMPO") = RS("CAMPO")
					FS.Fields("ID_CAMPO") = RS("ID_CAMPO")
					FS.Fields("ALIAS_TABELA") = RS("ALIAS_TABELA")
					FS.Fields("TABELA_DEPENDENTE") = RS("TABELA_DEPENDENTE")
					FS.Fields("CAMPO_DEPENDENTE") = RS("CAMPO_DEPENDENTE")
					FS.update
					RS.close
				end if
				if ID_FILTRO7 > 0 then
					qry = "SELECT ID_FILTRO,PRIORIDADE,FILTRO,TABELA,CAMPO,ID_CAMPO,ALIAS_TABELA,TABELA_DEPENDENTE,CAMPO_DEPENDENTE FROM TABELA_FILTROS WHERE ID_FILTRO='"&ID_FILTRO7&"'"
					RS.open qry
					FILTROS = FILTROS + 1
					FS.AddNew
					FS.Fields("ORDEM") = "ORD7"
					FS.Fields("FILTRO") = RS("FILTRO")
					FS.Fields("PRIORIDADE") = RS("PRIORIDADE")
					FS.Fields("TABELA") = RS("TABELA")
					FS.Fields("CAMPO") = RS("CAMPO")
					FS.Fields("ID_CAMPO") = RS("ID_CAMPO")
					FS.Fields("ALIAS_TABELA") = RS("ALIAS_TABELA")
					FS.Fields("TABELA_DEPENDENTE") = RS("TABELA_DEPENDENTE")
					FS.Fields("CAMPO_DEPENDENTE") = RS("CAMPO_DEPENDENTE")
					FS.update
					RS.close
				end if
				if ID_FILTRO8 > 0 then
					qry = "SELECT ID_FILTRO,PRIORIDADE,FILTRO,TABELA,CAMPO,ID_CAMPO,ALIAS_TABELA,TABELA_DEPENDENTE,CAMPO_DEPENDENTE FROM TABELA_FILTROS WHERE ID_FILTRO='"&ID_FILTRO8&"'"
					RS.open qry
					FILTROS = FILTROS + 1
					FS.AddNew
					FS.Fields("ORDEM") = "ORD8"
					FS.Fields("FILTRO") = RS("FILTRO")
					FS.Fields("PRIORIDADE") = RS("PRIORIDADE")
					FS.Fields("TABELA") = RS("TABELA")
					FS.Fields("CAMPO") = RS("CAMPO")
					FS.Fields("ID_CAMPO") = RS("ID_CAMPO")
					FS.Fields("ALIAS_TABELA") = RS("ALIAS_TABELA")
					FS.Fields("TABELA_DEPENDENTE") = RS("TABELA_DEPENDENTE")
					FS.Fields("CAMPO_DEPENDENTE") = RS("CAMPO_DEPENDENTE")
					FS.update
					RS.close
				end if
				FS.Sort = "PRIORIDADE"
				vez1=0
				vez2=0
				vez3=0
				vez4=0
				vez5=0
				vez6=0
				vez7=0
				vez8=0
				
				FILTRO1 = ""
				FILTRO2 = ""
				FILTRO3 = ""
				FILTRO4 = ""
				FILTRO5 = ""
				FILTRO6 = ""
				FILTRO7 = ""
				FILTRO8 = ""
				CAMPO_TOTAL = 0				
				
				if ID_FILTRO1 > 0 then
					if vez1=0 then
						FS.movefirst
						FILTRO_1_FILTRO = FS.Fields("FILTRO")
						FILTRO_1_PRIORIDADE = FS.Fields("PRIORIDADE")
						FILTRO_1_TABELA = FS.Fields("TABELA")
						FILTRO_1_CAMPO = FS.Fields("CAMPO")
						FILTRO_1_ID_CAMPO = FS.Fields("ID_CAMPO")
						FILTRO_1_ALIAS_TABELA = FS.Fields("ALIAS_TABELA")
						FILTRO_1_TABELA_DEPENDENTE = FS.Fields("TABELA_DEPENDENTE")
						FILTRO_1_CAMPO_DEPENDENTE = FS.Fields("CAMPO_DEPENDENTE")
						vez1=1
					end if

					sql = "SELECT DISTINCT("&FILTRO_1_CAMPO&") AS "&FILTRO_1_CAMPO&" FROM  VIEW_ALUNOS_GERAL ORDER BY "&FILTRO_1_CAMPO
					
					RS1.open sql
					while not RS1.eof
						CAMPO_FILTRO1 = RS1(0)
						if ID_FILTRO2 > 0 then
							if vez2=0 then
								FS.movenext
								FILTRO_2_FILTRO = FS.Fields("FILTRO")
								FILTRO_2_PRIORIDADE = FS.Fields("PRIORIDADE")
								FILTRO_2_TABELA = FS.Fields("TABELA")
								FILTRO_2_CAMPO = FS.Fields("CAMPO")
								FILTRO_2_ID_CAMPO = FS.Fields("ID_CAMPO")
								FILTRO_2_ALIAS_TABELA = FS.Fields("ALIAS_TABELA")
								FILTRO_2_TABELA_DEPENDENTE = FS.Fields("TABELA_DEPENDENTE")
								FILTRO_2_CAMPO_DEPENDENTE = FS.Fields("CAMPO_DEPENDENTE")
								vez2=1
							end if
		
							sql = "SELECT DISTINCT("&FILTRO_2_CAMPO&") AS "&FILTRO_2_CAMPO&" FROM  VIEW_ALUNOS_GERAL WHERE "
							sqlwhere2 = FILTRO_1_CAMPO&"='"&replace(RS1(0),"'","''")&"'"
							sql = sql & sqlwhere2 & " ORDER BY "&FILTRO_2_CAMPO
							
							RS2.open sql
							
							while not RS2.eof
								CAMPO_FILTRO2 = RS2(0)
								if ID_FILTRO3 > 0 then
									if vez3=0 then
										FS.movenext
										FILTRO_3_FILTRO = FS.Fields("FILTRO")
										FILTRO_3_PRIORIDADE = FS.Fields("PRIORIDADE")
										FILTRO_3_TABELA = FS.Fields("TABELA")
										FILTRO_3_CAMPO = FS.Fields("CAMPO")
										FILTRO_3_ID_CAMPO = FS.Fields("ID_CAMPO")
										FILTRO_3_ALIAS_TABELA = FS.Fields("ALIAS_TABELA")
										FILTRO_3_TABELA_DEPENDENTE = FS.Fields("TABELA_DEPENDENTE")
										FILTRO_3_CAMPO_DEPENDENTE = FS.Fields("CAMPO_DEPENDENTE")
										vez3=1
									end if
									sql = "SELECT DISTINCT("&FILTRO_3_CAMPO&") AS "&FILTRO_3_CAMPO&" FROM  VIEW_ALUNOS_GERAL WHERE "
									sqlwhere3 = FILTRO_2_CAMPO&"='"&replace(RS2(0),"'","''")&"'"
									sql = sql & sqlwhere3 & " ORDER BY "&FILTRO_3_CAMPO
									'response.write sql
									RS3.open sql
									
									while not RS3.eof
										CAMPO_FILTRO3 = RS3(0)
										if ID_FILTRO4 > 0 then
											if vez4=0 then
												FS.movenext
												FILTRO_4_FILTRO = FS.Fields("FILTRO")
												FILTRO_4_PRIORIDADE = FS.Fields("PRIORIDADE")
												FILTRO_4_TABELA = FS.Fields("TABELA")
												FILTRO_4_CAMPO = FS.Fields("CAMPO")
												FILTRO_4_ID_CAMPO = FS.Fields("ID_CAMPO")
												FILTRO_4_ALIAS_TABELA = FS.Fields("ALIAS_TABELA")
												FILTRO_4_TABELA_DEPENDENTE = FS.Fields("TABELA_DEPENDENTE")
												FILTRO_4_CAMPO_DEPENDENTE = FS.Fields("CAMPO_DEPENDENTE")
												vez4=1
											end if
						
											sql = "SELECT DISTINCT("&FILTRO_4_CAMPO&") AS "&FILTRO_4_CAMPO&" FROM  VIEW_ALUNOS_GERAL WHERE "
											sqlwhere4 = FILTRO_3_CAMPO&"='"&replace(RS3(0),"'","''")&"'"
											sql = sql & sqlwhere4 & " ORDER BY "&FILTRO_4_CAMPO
											
											RS4.open sql
											
											while not RS4.eof
												CAMPO_FILTRO4 = RS4(0)
												if ID_FILTRO5 > 0 then
													if vez5=0 then
														FS.movenext
														FILTRO_5_FILTRO = FS.Fields("FILTRO")
														FILTRO_5_PRIORIDADE = FS.Fields("PRIORIDADE")
														FILTRO_5_TABELA = FS.Fields("TABELA")
														FILTRO_5_CAMPO = FS.Fields("CAMPO")
														FILTRO_5_ID_CAMPO = FS.Fields("ID_CAMPO")
														FILTRO_5_ALIAS_TABELA = FS.Fields("ALIAS_TABELA")
														FILTRO_5_TABELA_DEPENDENTE = FS.Fields("TABELA_DEPENDENTE")
														FILTRO_5_CAMPO_DEPENDENTE = FS.Fields("CAMPO_DEPENDENTE")
														vez5=1
													end if
								
													sql = "SELECT DISTINCT("&FILTRO_5_CAMPO&") AS "&FILTRO_5_CAMPO&" FROM  VIEW_ALUNOS_GERAL WHERE "
													sqlwhere5 = FILTRO_4_CAMPO&"='"&replace(RS4(0),"'","''")&"'"
													sql = sql & sqlwhere5 & " ORDER BY "&FILTRO_5_CAMPO
													
													RS5.open sql
													
													while not RS5.eof
														CAMPO_FILTRO5 = RS5(0)
														if ID_FILTRO6 > 0 then
															if vez6=0 then
																FS.movenext
																FILTRO_6_FILTRO = FS.Fields("FILTRO")
																FILTRO_6_PRIORIDADE = FS.Fields("PRIORIDADE")
																FILTRO_6_TABELA = FS.Fields("TABELA")
																FILTRO_6_CAMPO = FS.Fields("CAMPO")
																FILTRO_6_ID_CAMPO = FS.Fields("ID_CAMPO")
																FILTRO_6_ALIAS_TABELA = FS.Fields("ALIAS_TABELA")
																FILTRO_6_TABELA_DEPENDENTE = FS.Fields("TABELA_DEPENDENTE")
																FILTRO_6_CAMPO_DEPENDENTE = FS.Fields("CAMPO_DEPENDENTE")
																vez6=1
															end if
										
															sql = "SELECT DISTINCT("&FILTRO_6_CAMPO&") AS "&FILTRO_6_CAMPO&" FROM  VIEW_ALUNOS_GERAL WHERE "
															sqlwhere6 = FILTRO_5_CAMPO&"='"&replace(RS5(0),"'","''")&"'"
															sql = sql & sqlwhere6 & " ORDER BY "&FILTRO_6_CAMPO
															
															RS6.open sql
															
															while not RS6.eof
																CAMPO_FILTRO6 = RS6(0)
																if ID_FILTRO7 > 0 then
																	if vez7=0 then
																		FS.movenext
																		FILTRO_7_FILTRO = FS.Fields("FILTRO")
																		FILTRO_7_PRIORIDADE = FS.Fields("PRIORIDADE")
																		FILTRO_7_TABELA = FS.Fields("TABELA")
																		FILTRO_7_CAMPO = FS.Fields("CAMPO")
																		FILTRO_7_ID_CAMPO = FS.Fields("ID_CAMPO")
																		FILTRO_7_ALIAS_TABELA = FS.Fields("ALIAS_TABELA")
																		FILTRO_7_TABELA_DEPENDENTE = FS.Fields("TABELA_DEPENDENTE")
																		FILTRO_7_CAMPO_DEPENDENTE = FS.Fields("CAMPO_DEPENDENTE")
																		vez7=1
																	end if
												
																	sql = "SELECT DISTINCT("&FILTRO_7_CAMPO&") AS "&FILTRO_7_CAMPO&" FROM  VIEW_ALUNOS_GERAL WHERE "
																	sqlwhere7 = FILTRO_6_CAMPO&"='"&replace(RS6(0),"'","''")&"'"
																	sql = sql & sqlwhere7 & " ORDER BY "&FILTRO_7_CAMPO
																	
																	RS7.open sql
																	
																	while not RS7.eof
																		CAMPO_FILTRO7 = RS7(0)
																		if ID_FILTRO8 > 0 then
																			if vez8=0 then
																				FS.movenext
																				FILTRO_8_FILTRO = FS.Fields("FILTRO")
																				FILTRO_8_PRIORIDADE = FS.Fields("PRIORIDADE")
																				FILTRO_8_TABELA = FS.Fields("TABELA")
																				FILTRO_8_CAMPO = FS.Fields("CAMPO")
																				FILTRO_8_ID_CAMPO = FS.Fields("ID_CAMPO")
																				FILTRO_8_ALIAS_TABELA = FS.Fields("ALIAS_TABELA")
																				FILTRO_8_TABELA_DEPENDENTE = FS.Fields("TABELA_DEPENDENTE")
																				FILTRO_8_CAMPO_DEPENDENTE = FS.Fields("CAMPO_DEPENDENTE")
																				vez8=1
																			end if
														
																			sql = "SELECT DISTINCT("&FILTRO_8_CAMPO&") AS "&FILTRO_8_CAMPO&" FROM  VIEW_ALUNOS_GERAL WHERE "
																			sqlwhere8 = FILTRO_7_CAMPO&"='"&replace(RS7(0),"'","''")&"'"
																			sql = sql & sqlwhere8 & " ORDER BY "&FILTRO_8_CAMPO
																			
																			RS8.open sql
																			
																			while not RS8.eof
																				CAMPO_FILTRO8 = RS8(0)
																				sql = "SELECT COUNT("&FILTRO_8_CAMPO&") AS QTD FROM VIEW_ALUNOS_GERAL WHERE "
																				if RS1(0)="" or RS1(0)="null" then cc1=""
																				if RS2(0)="" or RS2(0)="null" then cc2=""
																				if RS3(0)="" or RS3(0)="null" then cc3=""
																				if RS4(0)="" or RS4(0)="null" then cc4=""
																				if RS5(0)="" or RS5(0)="null" then cc5=""
																				if RS6(0)="" or RS6(0)="null" then cc6=""
																				if RS7(0)="" or RS7(0)="null" then cc7=""
																				if RS8(0)="" or RS8(0)="null" then cc8=""
																				cc1 = replace(cc1,"'"," ")
																				cc2 = replace(cc2,"'"," ")
																				cc3 = replace(cc3,"'"," ")
																				cc4 = replace(cc4,"'"," ")
																				cc5 = replace(cc5,"'"," ")
																				cc6 = replace(cc6,"'"," ")
																				cc7 = replace(cc7,"'"," ")
																				cc8 = replace(cc8,"'"," ")
																				sqlwhere1 = FILTRO_1_CAMPO&"='"&cc1&"'"
																				sqlwhere2 = FILTRO_2_CAMPO&"='"&cc2&"'"
																				sqlwhere3 = FILTRO_3_CAMPO&"='"&cc3&"'"
																				sqlwhere4 = FILTRO_4_CAMPO&"='"&cc4&"'"
																				sqlwhere5 = FILTRO_5_CAMPO&"='"&cc5&"'"
																				sqlwhere6 = FILTRO_6_CAMPO&"='"&cc6&"'"
																				sqlwhere7 = FILTRO_7_CAMPO&"='"&cc7&"'"
																				sqlwhere8 = FILTRO_8_CAMPO&"='"&cc8&"'"
																				if sqlwhere1<>"" then sql = sql & sqlwhere1 & " AND "
																				if sqlwhere2<>"" then sql = sql & sqlwhere2 & " AND "
																				if sqlwhere3<>"" then sql = sql & sqlwhere3 & " AND "
																				if sqlwhere4<>"" then sql = sql & sqlwhere4 & " AND "
																				if sqlwhere5<>"" then sql = sql & sqlwhere5 & " AND "
																				if sqlwhere6<>"" then sql = sql & sqlwhere6 & " AND "
																				if sqlwhere7<>"" then sql = sql & sqlwhere7 & " AND "
																				if sqlwhere8<>"" then sql = sql & sqlwhere8
																				RS.open sql
																				CAMPO_TOTAL = RS(0)
																				RS.close
																				if CAMPO_TOTAL > 0 then
																					CAMPO_FILTRO1 = replace(CAMPO_FILTRO1,"'"," ")
																					CAMPO_FILTRO2 = replace(CAMPO_FILTRO2,"'"," ")
																					CAMPO_FILTRO3 = replace(CAMPO_FILTRO3,"'"," ")
																					CAMPO_FILTRO4 = replace(CAMPO_FILTRO4,"'"," ")
																					CAMPO_FILTRO5 = replace(CAMPO_FILTRO5,"'"," ")
																					CAMPO_FILTRO6 = replace(CAMPO_FILTRO6,"'"," ")
																					CAMPO_FILTRO7 = replace(CAMPO_FILTRO7,"'"," ")
																					CAMPO_FILTRO8 = replace(CAMPO_FILTRO8,"'"," ")
																					
																					sql = "INSERT INTO ESTATISTICA (USUARIO,FILTRO1,FILTRO2,FILTRO3,FILTRO4,FILTRO5,FILTRO6,FILTRO7,FILTRO8,TOTAL) VALUES ('"&session("id")&"','"&CAMPO_FILTRO1&"','"&CAMPO_FILTRO2&"','"&CAMPO_FILTRO3&"','"&CAMPO_FILTRO4&"','"&CAMPO_FILTRO5&"','"&CAMPO_FILTRO6&"','"&CAMPO_FILTRO7&"','"&CAMPO_FILTRO8&"','"&CAMPO_TOTAL&"')"
																					RS.open sql
																				end if
																				RS8.movenext
																			wend
																			RS8.close	
																		else
																			sql = "SELECT COUNT("&FILTRO_7_CAMPO&") AS QTD FROM VIEW_ALUNOS_GERAL WHERE "
																			if IsNull(RS1(0)) then cc1="" else cc1=RS1(0) end if
																			if IsNull(RS2(0)) then cc2="" else cc2=RS2(0) end if
																			if IsNull(RS3(0)) then cc3="" else cc3=RS3(0) end if
																			if IsNull(RS4(0)) then cc4="" else cc4=RS4(0) end if
																			if IsNull(RS5(0)) then cc5="" else cc5=RS5(0) end if
																			if IsNull(RS6(0)) then cc6="" else cc5=RS6(0) end if
																			if IsNull(RS7(0)) then cc7="" else cc5=RS7(0) end if
																			cc1 = replace(cc1,"'"," ")
																			cc2 = replace(cc2,"'"," ")
																			cc3 = replace(cc3,"'"," ")
																			cc4 = replace(cc4,"'"," ")
																			cc5 = replace(cc5,"'"," ")
																			cc6 = replace(cc6,"'"," ")
																			cc7 = replace(cc7,"'"," ")
																			sqlwhere1 = FILTRO_1_CAMPO&"='"&cc1&"'"
																			sqlwhere2 = FILTRO_2_CAMPO&"='"&cc2&"'"
																			sqlwhere3 = FILTRO_3_CAMPO&"='"&cc3&"'"
																			sqlwhere4 = FILTRO_4_CAMPO&"='"&cc4&"'"
																			sqlwhere5 = FILTRO_5_CAMPO&"='"&cc5&"'"
																			sqlwhere6 = FILTRO_6_CAMPO&"='"&cc6&"'"
																			sqlwhere7 = FILTRO_7_CAMPO&"='"&cc7&"'"
																			if sqlwhere1<>"" then sql = sql & sqlwhere1 & " AND "
																			if sqlwhere2<>"" then sql = sql & sqlwhere2 & " AND "
																			if sqlwhere3<>"" then sql = sql & sqlwhere3 & " AND "
																			if sqlwhere4<>"" then sql = sql & sqlwhere4 & " AND "
																			if sqlwhere5<>"" then sql = sql & sqlwhere5 & " AND "
																			if sqlwhere6<>"" then sql = sql & sqlwhere6 & " AND "
																			if sqlwhere7<>"" then sql = sql & sqlwhere7
																			RS.open sql
																			CAMPO_TOTAL = RS(0)
																			RS.close
																			if CAMPO_TOTAL > 0 then
																				CAMPO_FILTRO1 = replace(CAMPO_FILTRO1,"'"," ")
																				CAMPO_FILTRO2 = replace(CAMPO_FILTRO2,"'"," ")
																				CAMPO_FILTRO3 = replace(CAMPO_FILTRO3,"'"," ")
																				CAMPO_FILTRO4 = replace(CAMPO_FILTRO4,"'"," ")
																				CAMPO_FILTRO5 = replace(CAMPO_FILTRO5,"'"," ")
																				CAMPO_FILTRO6 = replace(CAMPO_FILTRO6,"'"," ")
																				CAMPO_FILTRO7 = replace(CAMPO_FILTRO7,"'"," ")
																				CAMPO_FILTRO8 = replace(CAMPO_FILTRO8,"'"," ")
																				sql = "INSERT INTO ESTATISTICA (USUARIO,FILTRO1,FILTRO2,FILTRO3,FILTRO4,FILTRO5,FILTRO6,FILTRO7,FILTRO8,TOTAL) VALUES ('"&session("id")&"','"&CAMPO_FILTRO1&"','"&CAMPO_FILTRO2&"','"&CAMPO_FILTRO3&"','"&CAMPO_FILTRO4&"','"&CAMPO_FILTRO5&"','"&CAMPO_FILTRO6&"','"&CAMPO_FILTRO7&"','"&CAMPO_FILTRO8&"','"&CAMPO_TOTAL&"')"
																				RS.open sql
																			end if
																		end if
																		RS7.movenext
																	wend
																	RS7.close	
																else
																	sql = "SELECT COUNT("&FILTRO_6_CAMPO&") AS QTD FROM VIEW_ALUNOS_GERAL WHERE "
																	if IsNull(RS1(0)) then cc1="" else cc1=RS1(0) end if
																	if IsNull(RS2(0)) then cc2="" else cc2=RS2(0) end if
																	if IsNull(RS3(0)) then cc3="" else cc3=RS3(0) end if
																	if IsNull(RS4(0)) then cc4="" else cc4=RS4(0) end if
																	if IsNull(RS5(0)) then cc5="" else cc5=RS5(0) end if
																	if IsNull(RS6(0)) then cc6="" else cc5=RS6(0) end if
																	cc1 = replace(cc1,"'"," ")
																	cc2 = replace(cc2,"'"," ")
																	cc3 = replace(cc3,"'"," ")
																	cc4 = replace(cc4,"'"," ")
																	cc5 = replace(cc5,"'"," ")
																	cc6 = replace(cc6,"'"," ")
																	sqlwhere1 = FILTRO_1_CAMPO&"='"&cc1&"'"
																	sqlwhere2 = FILTRO_2_CAMPO&"='"&cc2&"'"
																	sqlwhere3 = FILTRO_3_CAMPO&"='"&cc3&"'"
																	sqlwhere4 = FILTRO_4_CAMPO&"='"&cc4&"'"
																	sqlwhere5 = FILTRO_5_CAMPO&"='"&cc5&"'"
																	sqlwhere6 = FILTRO_6_CAMPO&"='"&cc6&"'"
																	if sqlwhere1<>"" then sql = sql & sqlwhere1 & " AND "
																	if sqlwhere2<>"" then sql = sql & sqlwhere2 & " AND "
																	if sqlwhere3<>"" then sql = sql & sqlwhere3 & " AND "
																	if sqlwhere4<>"" then sql = sql & sqlwhere4 & " AND "
																	if sqlwhere5<>"" then sql = sql & sqlwhere5 & " AND "
																	if sqlwhere6<>"" then sql = sql & sqlwhere6
																	RS.open sql
																	CAMPO_TOTAL = RS(0)
																	RS.close
																	if CAMPO_TOTAL > 0 then
																		CAMPO_FILTRO1 = replace(CAMPO_FILTRO1,"'"," ")
																		CAMPO_FILTRO2 = replace(CAMPO_FILTRO2,"'"," ")
																		CAMPO_FILTRO3 = replace(CAMPO_FILTRO3,"'"," ")
																		CAMPO_FILTRO4 = replace(CAMPO_FILTRO4,"'"," ")
																		CAMPO_FILTRO5 = replace(CAMPO_FILTRO5,"'"," ")
																		CAMPO_FILTRO6 = replace(CAMPO_FILTRO6,"'"," ")
																		CAMPO_FILTRO7 = replace(CAMPO_FILTRO7,"'"," ")
																		CAMPO_FILTRO8 = replace(CAMPO_FILTRO8,"'"," ")
																		sql = "INSERT INTO ESTATISTICA (USUARIO,FILTRO1,FILTRO2,FILTRO3,FILTRO4,FILTRO5,FILTRO6,FILTRO7,FILTRO8,TOTAL) VALUES ('"&session("id")&"','"&CAMPO_FILTRO1&"','"&CAMPO_FILTRO2&"','"&CAMPO_FILTRO3&"','"&CAMPO_FILTRO4&"','"&CAMPO_FILTRO5&"','"&CAMPO_FILTRO6&"','"&CAMPO_FILTRO7&"','"&CAMPO_FILTRO8&"','"&CAMPO_TOTAL&"')"
																		RS.open sql
																	end if
																end if
																RS6.movenext
															wend
															RS6.close	
														else
															sql = "SELECT COUNT("&FILTRO_5_CAMPO&") AS QTD FROM VIEW_ALUNOS_GERAL WHERE "
															if IsNull(RS1(0)) then cc1="" else cc1=RS1(0) end if
															if IsNull(RS2(0)) then cc2="" else cc2=RS2(0) end if
															if IsNull(RS3(0)) then cc3="" else cc3=RS3(0) end if
															if IsNull(RS4(0)) then cc4="" else cc4=RS4(0) end if
															if IsNull(RS5(0)) then cc5="" else cc5=RS5(0) end if
															cc1 = replace(cc1,"'"," ")
															cc2 = replace(cc2,"'"," ")
															cc3 = replace(cc3,"'"," ")
															cc4 = replace(cc4,"'"," ")
															cc5 = replace(cc5,"'"," ")
															sqlwhere1 = FILTRO_1_CAMPO&"='"&cc1&"'"
															sqlwhere2 = FILTRO_2_CAMPO&"='"&cc2&"'"
															sqlwhere3 = FILTRO_3_CAMPO&"='"&cc3&"'"
															sqlwhere4 = FILTRO_4_CAMPO&"='"&cc4&"'"
															sqlwhere5 = FILTRO_5_CAMPO&"='"&cc5&"'"
															if sqlwhere1<>"" then sql = sql & sqlwhere1 & " AND "
															if sqlwhere2<>"" then sql = sql & sqlwhere2 & " AND "
															if sqlwhere3<>"" then sql = sql & sqlwhere3 & " AND "
															if sqlwhere4<>"" then sql = sql & sqlwhere4 & " AND "
															if sqlwhere5<>"" then sql = sql & sqlwhere5
															RS.open sql
															CAMPO_TOTAL = RS(0)
															RS.close
															if CAMPO_TOTAL > 0 then
																CAMPO_FILTRO1 = replace(CAMPO_FILTRO1,"'"," ")
																CAMPO_FILTRO2 = replace(CAMPO_FILTRO2,"'"," ")
																CAMPO_FILTRO3 = replace(CAMPO_FILTRO3,"'"," ")
																CAMPO_FILTRO4 = replace(CAMPO_FILTRO4,"'"," ")
																CAMPO_FILTRO5 = replace(CAMPO_FILTRO5,"'"," ")
																CAMPO_FILTRO6 = replace(CAMPO_FILTRO6,"'"," ")
																CAMPO_FILTRO7 = replace(CAMPO_FILTRO7,"'"," ")
																CAMPO_FILTRO8 = replace(CAMPO_FILTRO8,"'"," ")
																sql = "INSERT INTO ESTATISTICA (USUARIO,FILTRO1,FILTRO2,FILTRO3,FILTRO4,FILTRO5,FILTRO6,FILTRO7,FILTRO8,TOTAL) VALUES ('"&session("id")&"','"&CAMPO_FILTRO1&"','"&CAMPO_FILTRO2&"','"&CAMPO_FILTRO3&"','"&CAMPO_FILTRO4&"','"&CAMPO_FILTRO5&"','"&CAMPO_FILTRO6&"','"&CAMPO_FILTRO7&"','"&CAMPO_FILTRO8&"','"&CAMPO_TOTAL&"')"
																RS.open sql
															end if
														end if
														RS5.movenext
													wend
													RS5.close	
												else
													sql = "SELECT COUNT("&FILTRO_4_CAMPO&") AS QTD FROM VIEW_ALUNOS_GERAL WHERE "
													if RS1(0)="" or RS1(0)="null" then cc1=""
													if RS2(0)="" or RS2(0)="null" then cc2=""
													if RS3(0)="" or RS3(0)="null" then cc3=""
													if RS4(0)="" or RS4(0)="null" then cc4=""
													cc1 = replace(cc1,"'"," ")
													cc2 = replace(cc2,"'"," ")
													cc3 = replace(cc3,"'"," ")
													cc4 = replace(cc4,"'"," ")
													if IsNull(RS1(0)) then cc1="" else cc1=RS1(0) end if
													if IsNull(RS2(0)) then cc2="" else cc2=RS2(0) end if
													if IsNull(RS3(0)) then cc3="" else cc3=RS3(0) end if
													if IsNull(RS4(0)) then cc4="" else cc4=RS4(0) end if
													if sqlwhere1<>"" then sql = sql & sqlwhere1 & " AND "
													if sqlwhere2<>"" then sql = sql & sqlwhere2 & " AND "
													if sqlwhere3<>"" then sql = sql & sqlwhere3 & " AND "
													if sqlwhere4<>"" then sql = sql & sqlwhere4
													RS.open sql
													CAMPO_TOTAL = RS(0)
													RS.close
													if CAMPO_TOTAL > 0 then
														CAMPO_FILTRO1 = replace(CAMPO_FILTRO1,"'"," ")
														CAMPO_FILTRO2 = replace(CAMPO_FILTRO2,"'"," ")
														CAMPO_FILTRO3 = replace(CAMPO_FILTRO3,"'"," ")
														CAMPO_FILTRO4 = replace(CAMPO_FILTRO4,"'"," ")
														CAMPO_FILTRO5 = replace(CAMPO_FILTRO5,"'"," ")
														CAMPO_FILTRO6 = replace(CAMPO_FILTRO6,"'"," ")
														CAMPO_FILTRO7 = replace(CAMPO_FILTRO7,"'"," ")
														CAMPO_FILTRO8 = replace(CAMPO_FILTRO8,"'"," ")
														sql = "INSERT INTO ESTATISTICA (USUARIO,FILTRO1,FILTRO2,FILTRO3,FILTRO4,FILTRO5,FILTRO6,FILTRO7,FILTRO8,TOTAL) VALUES ('"&session("id")&"','"&CAMPO_FILTRO1&"','"&CAMPO_FILTRO2&"','"&CAMPO_FILTRO3&"','"&CAMPO_FILTRO4&"','"&CAMPO_FILTRO5&"','"&CAMPO_FILTRO6&"','"&CAMPO_FILTRO7&"','"&CAMPO_FILTRO8&"','"&CAMPO_TOTAL&"')"
														RS.open sql
													end if
												end if
												RS4.movenext
											wend
											RS4.close	
										else
											sql = "SELECT COUNT("&FILTRO_3_CAMPO&") AS QTD FROM VIEW_ALUNOS_GERAL WHERE "
											if RS1(0)="" or RS1(0)="null" then cc1=""
											if RS2(0)="" or RS2(0)="null" then cc2=""
											if RS3(0)="" or RS3(0)="null" then cc3=""
											cc1 = replace(cc1,"'"," ")
											cc2 = replace(cc2,"'"," ")
											cc3 = replace(cc3,"'"," ")
											if IsNull(RS1(0)) then cc1="" else cc1=RS1(0) end if
											if IsNull(RS2(0)) then cc2="" else cc2=RS2(0) end if
											if IsNull(RS3(0)) then cc3="" else cc3=RS3(0) end if
											if sqlwhere1<>"" then sql = sql & sqlwhere1 & " AND "
											if sqlwhere2<>"" then sql = sql & sqlwhere2 & " AND "
											if sqlwhere3<>"" then sql = sql & sqlwhere3
											RS.open sql
											CAMPO_TOTAL = RS(0)
											RS.close
											if CAMPO_TOTAL > 0 then
												CAMPO_FILTRO1 = replace(CAMPO_FILTRO1,"'"," ")
												CAMPO_FILTRO2 = replace(CAMPO_FILTRO2,"'"," ")
												CAMPO_FILTRO3 = replace(CAMPO_FILTRO3,"'"," ")
												CAMPO_FILTRO4 = replace(CAMPO_FILTRO4,"'"," ")
												CAMPO_FILTRO5 = replace(CAMPO_FILTRO5,"'"," ")
												CAMPO_FILTRO6 = replace(CAMPO_FILTRO6,"'"," ")
												CAMPO_FILTRO7 = replace(CAMPO_FILTRO7,"'"," ")
												CAMPO_FILTRO8 = replace(CAMPO_FILTRO8,"'"," ")
												sql = "INSERT INTO ESTATISTICA (USUARIO,FILTRO1,FILTRO2,FILTRO3,FILTRO4,FILTRO5,FILTRO6,FILTRO7,FILTRO8,TOTAL) VALUES ('"&session("id")&"','"&CAMPO_FILTRO1&"','"&CAMPO_FILTRO2&"','"&CAMPO_FILTRO3&"','"&CAMPO_FILTRO4&"','"&CAMPO_FILTRO5&"','"&CAMPO_FILTRO6&"','"&CAMPO_FILTRO7&"','"&CAMPO_FILTRO8&"','"&CAMPO_TOTAL&"')"
												'response.write sql
												RS.open sql
											end if
										end if
										RS3.movenext
									wend
									RS3.close	
								else
									sql = "SELECT COUNT("&FILTRO_2_CAMPO&") AS QTD FROM VIEW_ALUNOS_GERAL WHERE "
									if IsNull(RS1(0)) then cc1="" else cc1=RS1(0) end if
									if IsNull(RS2(0)) then cc2="" else cc2=RS2(0) end if
									cc1 = replace(cc1,"'"," ")
									cc2 = replace(cc2,"'"," ")
									sqlwhere1 = FILTRO_1_CAMPO&"='"&cc1&"'"
									sqlwhere2 = FILTRO_2_CAMPO&"='"&cc2&"'"
									if sqlwhere1<>"" then sql = sql & sqlwhere1 & " AND "
									if sqlwhere2<>"" then sql = sql & sqlwhere2
									RS.open sql
									CAMPO_TOTAL = RS(0)
									RS.close
									if CAMPO_TOTAL > 0 then
										CAMPO_FILTRO1 = replace(CAMPO_FILTRO1,"'"," ")
										CAMPO_FILTRO2 = replace(CAMPO_FILTRO2,"'"," ")
										CAMPO_FILTRO3 = replace(CAMPO_FILTRO3,"'"," ")
										CAMPO_FILTRO4 = replace(CAMPO_FILTRO4,"'"," ")
										CAMPO_FILTRO5 = replace(CAMPO_FILTRO5,"'"," ")
										CAMPO_FILTRO6 = replace(CAMPO_FILTRO6,"'"," ")
										CAMPO_FILTRO7 = replace(CAMPO_FILTRO7,"'"," ")
										CAMPO_FILTRO8 = replace(CAMPO_FILTRO8,"'"," ")
										sql = "INSERT INTO ESTATISTICA (USUARIO,FILTRO1,FILTRO2,FILTRO3,FILTRO4,FILTRO5,FILTRO6,FILTRO7,FILTRO8,TOTAL) VALUES ('"&session("id")&"','"&CAMPO_FILTRO1&"','"&CAMPO_FILTRO2&"','"&CAMPO_FILTRO3&"','"&CAMPO_FILTRO4&"','"&CAMPO_FILTRO5&"','"&CAMPO_FILTRO6&"','"&CAMPO_FILTRO7&"','"&CAMPO_FILTRO8&"','"&CAMPO_TOTAL&"')"
										RS.open sql
									end if
								end if
								RS2.movenext
							wend
							RS2.close	
						else
							sql = "SELECT COUNT("&FILTRO_1_CAMPO&") AS QTD FROM VIEW_ALUNOS_GERAL WHERE "
							if IsNull(RS1(0)) then cc1="" else cc1=RS1(0) end if
							cc1 = replace(cc1,"'"," ")
							sqlwhere1 = FILTRO_1_CAMPO&"='"&cc1&"'"							
							sql = sql & sqlwhere1
							RS.open sql
							CAMPO_TOTAL = RS(0)
							RS.close
							if CAMPO_TOTAL > 0 then
								CAMPO_FILTRO1 = replace(CAMPO_FILTRO1,"'"," ")
								CAMPO_FILTRO2 = replace(CAMPO_FILTRO2,"'"," ")
								CAMPO_FILTRO3 = replace(CAMPO_FILTRO3,"'"," ")
								CAMPO_FILTRO4 = replace(CAMPO_FILTRO4,"'"," ")
								CAMPO_FILTRO5 = replace(CAMPO_FILTRO5,"'"," ")
								CAMPO_FILTRO6 = replace(CAMPO_FILTRO6,"'"," ")
								CAMPO_FILTRO7 = replace(CAMPO_FILTRO7,"'"," ")
								CAMPO_FILTRO8 = replace(CAMPO_FILTRO8,"'"," ")
								sql = "INSERT INTO ESTATISTICA (USUARIO,FILTRO1,FILTRO2,FILTRO3,FILTRO4,FILTRO5,FILTRO6,FILTRO7,FILTRO8,TOTAL) VALUES ('"&session("id")&"','"&CAMPO_FILTRO1&"','"&CAMPO_FILTRO2&"','"&CAMPO_FILTRO3&"','"&CAMPO_FILTRO4&"','"&CAMPO_FILTRO5&"','"&CAMPO_FILTRO6&"','"&CAMPO_FILTRO7&"','"&CAMPO_FILTRO8&"','"&CAMPO_TOTAL&"')"
								RS.open sql
							end if
						end if
						RS1.movenext
					wend	
					RS1.close
				end if				
				FS.Close
				Set FS = Nothing
				%>
			</div>	
		</div>
	</body>
</html>
<% 
conClose
if ID_FILTRO1 > 0 then
	response.redirect "mostra_resultado.asp?id="&Session("id")&"&fl1="&FILTRO_1_FILTRO&"&fl2="&FILTRO_2_FILTRO&"&fl3="&FILTRO_3_FILTRO&"&fl4="&FILTRO_4_FILTRO&"&fl5="&FILTRO_5_FILTRO&"&fl6="&FILTRO_6_FILTRO&"&fl7="&FILTRO_7_FILTRO&"&fl8="&FILTRO_8_FILTRO&"&excel="&EXCEL
end if
%>