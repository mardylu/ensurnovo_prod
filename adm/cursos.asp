<%If session("key_ver")<>"ok" Then Response.Redirect "logout.asp"%>
<!-- #INCLUDE FILE="../library/parametros.asp" -->
<!-- #INCLUDE FILE="../library/conOpen.asp" -->
<!-- #INCLUDE FILE="../library/fErroMsg.asp" -->
<!-- #INCLUDE FILE="../library/fData.asp" -->
<!-- #INCLUDE FILE="../library/fCreateSel.asp" -->
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	
	<script type="text/javascript">
	 function newDoc1(st) {
		url = 'cursos.asp?st=';
		url = url + st;
		window.location=url;
	 }
	 function newDoc2(stt) {
		st=document.form.st.value; 
		url = 'cursos.asp?st=';
		url = url + st;
		url = url + '&stt=';
		url = url + stt;
		window.location=url;
	 }
	 function newDoc3(ano) {
		st=document.form.st.value; 
		stt=document.form.stt.value; 
		url = 'cursos.asp?st=';
		url = url + st;
		url = url + '&stt=';
		url = url + stt;
		url = url + '&ano=';
		url = url + ano;
		window.location=url;
	 }
	</script>

	<title>ENSUR Inscrições</title>
</head>
<body>
<div id="pagina">
	<!-- #INCLUDE FILE="include/topo.asp" -->
	<div id="conteudo">
		<%
		Set RS1 = Server.CreateObject("ADODB.Recordset")
		RS1.CursorType = 0
		RS1.ActiveConnection = Con
		stt=request("stt")
		st = request("st")
		
		if st="" or isNumeric(st)=false then st=0
		if stt="" or isNumeric(stt)=false then stt=0
		if st=0 then
			tit = "habilitados"
			sqlwhere = "C.COD_STATUS=1"
		elseif st=1 then
			tit = "desabilitados"
			sqlwhere = "C.COD_STATUS=2" 
		else
			tit = "cancelados"
			sqlwhere = "C.COD_STATUS=3"
		end if
		%>
		<h1>Cadastro de cursos</h1>
		<form name="form" action="cursos.asp" method="get">
		<input type="hidden" name="ord" value="<%=ord%>">

		<table id="tabela">
			<tr><td>
			<p><label for="st" class="requerido">Status do Curso</label><select name="st" onChange="newDoc1(this.value);">
			<option value="0" <% if st=0 then %> Selected  <% end if %>>HABILITADO</option>
			<option value="1" <% if st=1 then %> Selected  <% end if %>>DESABILITADO</option>
			<option value="2" <% if st=2 then %> Selected  <% end if %>>CANCELADO</option>
			</select>
			<p><label for="stt" class="requerido">Status da Turma</label><select name="stt" onChange="newDoc2(this.value);">
			<option value="0">TODOS </option>
			<%
			sql = "SELECT COD_STATUS_TURMA,STATUS_TURMA FROM TURMA_STATUS ORDER BY STATUS_TURMA"
			
			
			RS.open SQL
			while not RS.eof
				response.write "<option value="""&RS("COD_STATUS_TURMA")&""""
				if cstr(request("stt")) = cstr(RS("COD_STATUS_TURMA")) then
					response.write " selected "
				end if
				response.write ">"&RS("STATUS_TURMA")&"</option>"
				RS.movenext
			wend
			RS.close
			%>
			</select>	
			<p><label for="stt" class="requerido">Ano de Inicio da turma</label><select name="ano" onChange="newDoc3(this.value);">
			<option>SELECIONE O ANO</option>
			<%
				ano = request("ano") 
				if ano="" or isNumeric(ano)=false then ano=0

				response.write "<option value=""0"""
				if ano=0 then
					response.write " selected "
				end if
				response.write ">TODOS OS ANOS ANTERIORES</option>"
				
				response.write "<option value="&year(now())-2
				if cstr(year(now())-2)=cstr(ano) then
					response.write " selected "
				end if
				response.write ">"&year(now())-2&"</option>"
				
				response.write "<option value="&year(now())-1
				if cstr(year(now())-1)=cstr(ano) then
					response.write " selected "
				end if
				response.write ">"&year(now())-1&"</option>"
				
				response.write "<option value="&year(now())
				if cstr(year(now()))=cstr(ano) then
					response.write " selected "
				end if
				response.write ">"&year(now())&"</option>"
				
				response.write "<option value="&year(now())+1
				if cstr(year(now())+1)=cstr(ano) then
					response.write " selected "
				end if
				response.write ">"&year(now())+1&"</option>"
			%>		
			</select>
			<% if request("op") = 1 then %>
				<button id="bt_menu" onClick="window.print();return false;">Imprimir</button>
			<% end if %>
		</td></tr><tr>
		</table>		
		</form>
		<%
		ord = request("ord")
		ano = request("ano")
		if ano="" or isNumeric(ano)=false then ano=0
		if ord="" then
			sqlord = "TITULO"
		end if
		select case ord
			case "tp": sqlord = "T.DESCRICAO"
			case "tt": sqlord = "TITULO"
			case "st": sqlord = "C.COD_STATUS"
		end select
		sql1 = "SELECT COD_CURSO,T.DESCRICAO AS TDESC,S.DESCRICAO AS SDESC,TITULO FROM CURSO C JOIN CURSO_STATUS S ON C.COD_STATUS=S.COD_STATUS JOIN CURSO_TIPO T ON C.COD_TIPO=T.COD_TIPO WHERE "&sqlwhere
		if stt=0 then
			sql = " AND COD_CURSO IN (select DISTINCT COD_CURSO from TURMAS N WHERE N.COD_CURSO=C.COD_CURSO)"
			if ano=0 then
			else
				sql = " AND COD_CURSO IN (select DISTINCT COD_CURSO FROM TURMAS N WHERE N.COD_CURSO=C.COD_CURSO AND LEFT(DT_INICIO_TURMA,4)="&ano&")"
			end if				
		else
			sql = " AND COD_CURSO IN (select DISTINCT COD_CURSO FROM TURMAS N WHERE N.COD_CURSO=C.COD_CURSO AND N.COD_STATUS_TURMA='"&request("stt")&"')"
			if ano=0 then
			else
				sql = " AND COD_CURSO IN (select DISTINCT COD_CURSO FROM TURMAS N WHERE N.COD_CURSO=C.COD_CURSO AND LEFT(DT_INICIO_TURMA,4)="&ano&" AND N.COD_STATUS_TURMA='"&request("stt")&"')"
			end if				
		end if
		sql = sql1 & sql & " ORDER BY "&sqlord
		
	
		RS.Open SQL
				
		if RS.EOF then
			%><p><br>Nenhum curso cadastrado que atenda os filtros selecionados</p><%
		else
			%>
			<table id="tabela">
			<tr><td colspan =4 align=right>		
			<button id="bt_menu" onClick="window.print();return false;">Imprimir</button></td></tr>

			<tr><td class="header"><a href="cursos.asp?ord=tt&st=<%=st%>">título</a></td><td class="header"><a href="cursos.asp?ord=tp&st=<%=st%>">tipo</a></td><td class="header"><a href="cursos.asp?ord=st&st=<%=st%>">status</a></td><td></td></tr>
			<%
			c = 1
			while not RS.EOF
				%>
				<tr class="c<%=c%>"><td width="400"><%If Session("key_cur")="ok" Then%><a href="cad_cursos.asp?cod=<%=RS("COD_CURSO")%>"><%=RS("TITULO")%></a><%else%><%=RS("TITULO")%><%end if%></td><td><%=RS("TDESC")%></td><td><%=RS("SDESC")%></td><td></td></tr>
				<% 
				
				if stt=0 then
					sql = "select DISTINCT C.COD_STATUS,N.COD_STATUS_TURMA,N.ID_TURMA,N.CODIGO_TURMA,N.DT_INICIO_TURMA,N.DT_FIM_TURMA,U.STATUS_TURMA,(SELECT ALUNOS FROM VIEW_TURMAS_ALUNOS WHERE CODIGO_TURMA=N.CODIGO_TURMA) AS ALUNOS from TURMAS N LEFT JOIN TURMA_ALUNO L ON N.ID_TURMA=L.ID_TURMA JOIN TURMA_STATUS U ON N.COD_STATUS_TURMA=U.COD_STATUS_TURMA JOIN CURSO C ON C.COD_CURSO=N.COD_CURSO  WHERE N.COD_CURSO="&RS("cod_curso")&" ORDER BY CODIGO_TURMA"
					if ano=0 then
					else
						sql = "select DISTINCT C.COD_STATUS,N.COD_STATUS_TURMA,N.ID_TURMA,N.CODIGO_TURMA,N.DT_INICIO_TURMA,N.DT_FIM_TURMA,U.STATUS_TURMA,(SELECT ALUNOS FROM VIEW_TURMAS_ALUNOS WHERE CODIGO_TURMA=N.CODIGO_TURMA) AS ALUNOS from TURMAS N LEFT JOIN TURMA_ALUNO L ON N.ID_TURMA=L.ID_TURMA JOIN TURMA_STATUS U ON N.COD_STATUS_TURMA=U.COD_STATUS_TURMA JOIN CURSO C ON C.COD_CURSO=N.COD_CURSO  WHERE N.COD_CURSO="&RS("cod_curso")&" AND LEFT(DT_INICIO_TURMA,4)="&ano&" ORDER BY CODIGO_TURMA"
					end if				
				else
					sql = "select DISTINCT C.COD_STATUS,N.COD_STATUS_TURMA,N.ID_TURMA,N.CODIGO_TURMA,N.DT_INICIO_TURMA,N.DT_FIM_TURMA,U.STATUS_TURMA,(SELECT ALUNOS FROM VIEW_TURMAS_ALUNOS WHERE CODIGO_TURMA=N.CODIGO_TURMA) AS ALUNOS from TURMAS N LEFT JOIN TURMA_ALUNO L ON N.ID_TURMA=L.ID_TURMA JOIN TURMA_STATUS U ON N.COD_STATUS_TURMA=U.COD_STATUS_TURMA JOIN CURSO C ON C.COD_CURSO=N.COD_CURSO  WHERE N.COD_CURSO="&RS("cod_curso")&" AND N.COD_STATUS_TURMA='"&request("stt")&"' ORDER BY CODIGO_TURMA"
					if ano=0 then
					else
						sql = "select DISTINCT C.COD_STATUS,N.COD_STATUS_TURMA,N.ID_TURMA,N.CODIGO_TURMA,N.DT_INICIO_TURMA,N.DT_FIM_TURMA,U.STATUS_TURMA,(SELECT ALUNOS FROM VIEW_TURMAS_ALUNOS WHERE CODIGO_TURMA=N.CODIGO_TURMA) AS ALUNOS from TURMAS N LEFT JOIN TURMA_ALUNO L ON N.ID_TURMA=L.ID_TURMA JOIN TURMA_STATUS U ON N.COD_STATUS_TURMA=U.COD_STATUS_TURMA JOIN CURSO C ON C.COD_CURSO=N.COD_CURSO  WHERE N.COD_CURSO="&RS("cod_curso")&" AND LEFT(DT_INICIO_TURMA,4)="&ano&" AND N.COD_STATUS_TURMA='"&request("stt")&"' ORDER BY CODIGO_TURMA"
					end if				
				end if
				
			response.write sql
					RS1.open sql
					
					
					if RS1.EOF then 
						'<tr><td></td><td><p>Nenhuma turma cadastrada para este curso<p></td></tr>
					else 
						%><tr><td colspan=4><table align=center width="90%"><tr><td>Codigo da Turma</td><td>Data de Inicio</td><td>Data de Término</td><td>Status</td><td>Alunos</td><td></td><td>Inscrições</td><tr>
						<%while not RS1.eof%>
							<tr><td width="15%"><a href="cad_turmas.asp?tur=<%=RS1("ID_TURMA")%>"><% =RS1("CODIGO_TURMA")%></a></td><td width="15%"><% =formataData(RS1("DT_INICIO_TURMA"))%></TD><td width="15%"><% =formataData(RS1("DT_FIM_TURMA"))%></TD><td width="25%"><% =RS1("STATUS_TURMA")%></TD><td width="15%"><a href="alunos.asp?cod=<%=RS1("ID_TURMA")%>"><% =RS1("ALUNOS")%></a></TD><td><a href="http://<%=URLI%>default.asp?idc=<%=RS1("ID_TURMA")%>" target="_blank">ver</a>
							<%
							if RS1("COD_STATUS_TURMA") = 7 and RS1("COD_STATUS")=1 then
								%>
								<td width="15%"><a href="cadastro_adm.asp?cod=<%=RS1("ID_TURMA")%>" target="new" class="button2">Inscrever alunos</a></td>
								<%
							end if
							%>
							</tr>
							<% rs1.movenext
						wend
						%></table></td></tr><%
					end if
					RS1.close
'				c = 1 - c
				RS.MoveNext
			wend
		end if
		RS.Close
		%>
		</table>
	</div>	
</div>
</body>
</html>
<%

conClose
%>