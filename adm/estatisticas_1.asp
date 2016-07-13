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
						<input type="submit" name="submit" value="Executar" class="buttonF">
						<p><br></p>
					</form>
				</fieldset>
				<% 
				RS.close
				FILTROS = 0
				if ID_FILTRO1 > 0 then
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
				response.write "<fieldset>"
				response.write "<legend>RESULTADO</legend>"
				response.write "<table border=1 width='100%'>"
				vez1=0
				vez2=0
				vez3=0
				vez4=0
				vez5=0
				vez6=0
				vez7=0
				vez8=0
				
				if ID_FILTRO1 > 0 then
					if vez1=0 then
						FS.movefirst
						vez1=1
					end if
					FILTRO_1_FILTRO = FS.Fields("FILTRO")
					FILTRO_1_PRIORIDADE = FS.Fields("PRIORIDADE")
					FILTRO_1_TABELA = FS.Fields("TABELA")
					FILTRO_1_CAMPO = FS.Fields("CAMPO")
					FILTRO_1_ID_CAMPO = FS.Fields("ID_CAMPO")
					FILTRO_1_ALIAS_TABELA = FS.Fields("ALIAS_TABELA")
					FILTRO_1_TABELA_DEPENDENTE = FS.Fields("TABELA_DEPENDENTE")
					FILTRO_1_CAMPO_DEPENDENTE = FS.Fields("CAMPO_DEPENDENTE")
					
					CAMPOS1 = 1
					if FILTRO_1_CAMPO<>FILTRO_1_ID_CAMPO then
						CAMPOS1 = 2
					end if
					if CAMPOS1 > 1 then
						sql = "SELECT "&FILTRO_1_CAMPO&","&FILTRO_1_ID_CAMPO&" FROM "&FILTRO_1_TABELA & " " & FILTRO_1_ALIAS_TABELA
					else
						sql = "SELECT "&FILTRO_1_CAMPO&" FROM "&FILTRO_1_TABELA & " " & FILTRO_1_ALIAS_TABELA
					end if
					sql = sql & " ORDER BY "&FILTRO_1_ALIAS_TABELA&"."&FILTRO_1_CAMPO
					RS1.open sql
					while not RS1.eof
						response.write "<tr><td>"
						response.write RS1(0)
						response.write "</td>"
						if ID_FILTRO2>0 then
							if vez2=0 then
								FS.movenext
								vez2=1
							end if
							
							FILTRO_2_FILTRO = FS.Fields("FILTRO")
							FILTRO_2_PRIORIDADE = FS.Fields("PRIORIDADE")
							FILTRO_2_TABELA = FS.Fields("TABELA")
							FILTRO_2_CAMPO = FS.Fields("CAMPO")
							FILTRO_2_ID_CAMPO = FS.Fields("ID_CAMPO")
							FILTRO_2_ALIAS_TABELA = FS.Fields("ALIAS_TABELA")
							FILTRO_2_TABELA_DEPENDENTE = FS.Fields("TABELA_DEPENDENTE")
							FILTRO_2_CAMPO_DEPENDENTE = FS.Fields("CAMPO_DEPENDENTE")
						
							CAMPOS2 = 1
							if FILTRO_2_CAMPO<>FILTRO_2_ID_CAMPO then
								CAMPOS2 = 2
							end if
							if CAMPOS2 > 1 then
								sql = "SELECT "&FILTRO_2_CAMPO&","&FILTRO_2_ID_CAMPO&" FROM "&FILTRO_2_TABELA 
							else
								sql = "SELECT "&FILTRO_2_CAMPO&" FROM "&FILTRO_2_TABELA 
							end if
							if FILTRO_2_TABELA_DEPENDENTE<>"" then
								sqlwhere2 = " WHERE " &FILTRO_2_CAMPO_DEPENDENTE&"='"
								if CAMPOS1 >1 then
									sqlwhere2 = sqlwhere2 & RS1(1)&"'"
								else
									sqlwhere2 = sqlwhere2 & RS1(0)&"'"
								end if
								sql = sql & sqlwhere2
							end if
							sql = sql & " ORDER BY "&FILTRO_2_CAMPO
							RS2.open sql
							while not RS2.eof
								response.write "<tr><td></td><td>"
								response.write RS2(0)
								response.write "</td>"
								if ID_FILTRO3>0 then
									if not FS.eof then
						
									
									end if
								else
									sql = "SELECT COUNT(DISTINCT(COD_ALUNO)) AS QTD FROM VIEW_ALUNOS_GERAL "
									sql = sql & sqlwhere2 &" AND "&FILTRO_2_ID_CAMPO&"='"
									if FILTRO_2_ID_CAMPO=FILTRO_2_CAMPO then
										sql = sql&RS2(0)&"'"						
									else
										sql = sql&RS2(1)&"'"						
									end if
									RS.open sql
									if not RS.eof then
										response.write "<td>"&RS(0)&"</td></tr>"
									else
										response.write "<td>VAZIO</td></tr>"
									end if
									RS.close
								end if
								RS2.movenext
							Wend
							RS2.close
						else
							sql = "SELECT COUNT(DISTINCT(COD_ALUNO)) AS QTD FROM VIEW_ALUNOS_GERAL WHERE "&FILTRO_1_ID_CAMPO&"='"
							if FILTRO_1_ID_CAMPO=FILTRO_1_CAMPO then
								sql = sql&RS1(0)&"'"						
							else
								sql = sql&RS1(1)&"'"						
							end if
							RS.open sql
							if not RS.eof then
								response.write "<td>"&RS(0)&"</td></tr>"
							else
								response.write "<td>0</td></tr>"
							end if
							RS.close
						end if
						RS1.movenext
					Wend
					RS1.close
				end if				
				response.write "</table>"
				response.write "</fieldset>"
						
				FS.Close
				Set FS = Nothing
				%>
			</div>	
		</div>
	</body>
</html>
<%conClose%>