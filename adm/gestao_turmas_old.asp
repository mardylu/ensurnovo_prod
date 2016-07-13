<%If session("key_ver")<>"ok" Then Response.Redirect "logout.asp"%>
<!-- #INCLUDE FILE="../library/parametros.asp" -->
<!-- #INCLUDE FILE="../library/conOpen.asp" -->
<!-- #INCLUDE FILE="../library/fErroMsg.asp" -->
<!-- #INCLUDE FILE="../library/fData.asp" -->
<!-- #INCLUDE FILE="../library/fCreateSel.asp" -->

<% SIGA_PROJETO=Session("siga_projeto")

    Dim strMes(13)

    strMes(0)  = ""
    strMes(1)  = "Janeiro"
    strMes(2)  = "Fevereiro"
    strMes(3)  = "Março"
    strMes(4)  = "Abril"
    strMes(5)  = "Maio"
    strMes(6)  = "Junho"
    strMes(7)  = "Julho"
    strMes(8)  = "Agosto"
    strMes(9)  = "Setembro"
    strMes(10) = "Outubro"
    strMes(11) = "Novembro"
    strMes(12) = "Dezembro"
%>

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

	<script type="text/javascript">

	function newDoc1(curso) {
		st          = document.form.st.value;
		stt         = document.form.stt.value;
		curso       = document.form.curso.value;
		turma       = document.form.turma.value;
		ini_mes     = document.form.ini_mes.value;
		ini_ano     = document.form.ini_ano.value;
		fim_mes     = document.form.fim_mes.value;
		fim_ano     = document.form.fim_ano.value;
		url = 'gestao_turmas.asp?';
		url = url + 'st='         + st         + '&';
		url = url + 'stt='        + stt        + '&';
        url = url + 'curso='      + curso      + '&';
        url = url + 'turma='      + turma      + '&';
        url = url + 'ini_mes='    + ini_mes    + '&';
        url = url + 'ini_ano='    + ini_ano    + '&';
        url = url + 'fim_mes='    + fim_mes    + '&';
        url = url + 'fim_ano='    + fim_ano;
		window.location=url;
    }

	function gerar_relatorio() {
	    st          = document.form.st.value;
		stt         = document.form.stt.value;
		curso       = document.form.curso.value;
		turma       = document.form.turma.value;
		ini_mes     = document.form.ini_mes.value;
		ini_ano     = document.form.ini_ano.value;
		fim_mes     = document.form.fim_mes.value;
		fim_ano     = document.form.fim_ano.value;
		relatorio   = 1;
		url = 'gestao_turmas.asp?';
		url = url + 'st='         + st         + '&';
		url = url + 'stt='        + stt        + '&';
        url = url + 'curso='      + curso      + '&';
        url = url + 'turma='      + turma      + '&';
        url = url + 'ini_mes='    + ini_mes    + '&';
        url = url + 'ini_ano='    + ini_ano    + '&';
        url = url + 'fim_mes='    + fim_mes    + '&';
        url = url + 'fim_ano='    + fim_ano    + '&';
        url = url + 'relatorio='  + relatorio;
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

		stt         = request("stt")
		st          = request("st")
		curso       = request("curso")
		ini_mes     = request("ini_mes")
		ini_ano     = request("ini_ano")
		fim_mes     = request("fim_mes")
		fim_ano     = request("fim_ano")
		ord         = request("ord")

		if stt      ="" or isNumeric(stt)=false     then stt=0          end if
		if st       ="" or isNumeric(st)=false      then st=0           end if
		if curso    ="" or isNumeric(curso)=false   then curso=0        end if
		if ini_mes  ="" or isNumeric(ini_mes)=false then ini_mes=0      end if
		if ini_ano  ="" or isNumeric(ini_ano)=false then ini_ano="2011" end if
		if fim_mes  ="" or isNumeric(fim_mes)=false then fim_mes=99     end if
		if fim_ano  ="" or isNumeric(fim_ano)=false then fim_ano=9999   end if

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

		if curso>0 then
			sqlwhere = sqlwhere & " AND COD_CURSO="&curso
		else
		end if

        ' DT_INICIO_TURMA'
        ' DT_FIM_TURMA'

        if len(ini_mes)  = 1  then ini_mes = "0"  & ini_mes   end if
        data_inicio = ini_ano & ini_mes & "00"
        if len(fim_mes)  = 1  then fim_mes = "0"  & fim_mes   end if
        data_final  = fim_ano & "12" & "99"

        ' Response.Write ("DT início: " & data_inicio & "<br>")
        ' Response.Write ("DT final:  " & data_final  & "<br>")

		%>
		<h1>Seleção de Pré-Inscritos - lista de turmas</h1>                                    <%  ' Response.Write(Session("siga_projeto")) %>
		<form name="form" action="gestao_turmas.asp" method="get">
		<input type="hidden" name="ord" value="<%=ord%>">

		<table id="tabela">
			<%
			sql="SELECT COD_CURSO,TITULO FROM CURSO WHERE SIGA_PROJETO="&SIGA_PROJETO&" ORDER BY TITULO"
			rs.Open sql
			%>
			<tr><td>
			<p><label for="ID_TURMA">Escolha o Curso</label>
			<select name="curso" id="curso" onchange="newDoc1(this.value);">
			<option></option>
			<%while not RS.eof%>
				<option value="<% =RS("COD_CURSO") %>" <% if int(curso)=RS("COD_CURSO") then %> selected <% end if %>><% =RS("TITULO") %></option><%
				RS.movenext
			wend
			RS.close
			%>
			</select>
			</p>

			<p><label for="ID_TURMA">Turma</label>
   			<%

            if ( curso = 0 )    then
                sql_turma="SELECT ID_TURMA,CODIGO_TURMA FROM TURMAS "           & _
                          "       WHERE SIGA_PROJETO='"&SIGA_PROJETO&"' "       & _
                          "       ORDER BY ID_TURMA"
            else
                sql_turma="SELECT ID_TURMA,CODIGO_TURMA FROM TURMAS "           & _
                          "       WHERE SIGA_PROJETO='"&SIGA_PROJETO&"' "       & _
                          "         AND COD_CURSO='"&curso&"' "                 & _
                          "       ORDER BY ID_TURMA"
                end if
            RS.Open sql_turma
			%>
            <select name="turma" id="turma">
			<option></option>
			<%
            while not RS.eof
                Response.Write "<option value='" & RS("ID_TURMA") & "'"
                if ( cint(turma) = RS("ID_TURMA") )   then Response.Write(" selected")    end if
                Response.Write ">" & RS("CODIGO_TURMA") & "</option>"
                RS.movenext
			wend
			RS.close
			%>
			</select>
			</p>

			<p><label for="st">Status do curso</label><select name="st" onChange="newDoc1(this.value);">
			<option value="0" <% if st=0 then %> Selected  <% end if %>>HABILITADO</option>
			<option value="1" <% if st=1 then %> Selected  <% end if %>>DESABILITADO</option>
			<option value="2" <% if st=2 then %> Selected  <% end if %>>CANCELADO</option>
			</select>
			<p><label for="stt">Status da turma</label><select name="stt" onChange="newDoc2(this.value);">
			<option value="0">TODOS</option>
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

            <p>
                <label for="DataInicio">Período - Início</label>
			    <select name="ini_mes" id="ini_mes"  onChange="newDoc5(this.value);">
                <%
                Dim i
                For i=0 to 13
                    if i < 10   then ix="0"&i else ix=i end if
                    Response.Write "<option value='" & ix & "'"
                    if ( cint(ini_mes) = 0 )  then
                        if ( i = 0 ) then Response.Write (" selected ") end if
                    else
                        if ( cint(ini_mes) = i ) then Response.Write (" selected ") end if
                    end if
                    Response.Write ">" & strMes(i)
                    Response.Write "</option>"
                Next
                %>
                </select>
                <%  i = mid(Date(),7,4) + 1  %>
                <select name="ini_ano" id="ini_ano"  onChange="newDoc6(this.value);">
                <%
                    if (data_inicio = "00000000")   then
                        Response.Write ("<option value='20110000' selected></option>")
                    end if
                    Do until i=2000
                        Response.Write "<option value='" & i - 1 & "'"
                        if ( cint(ini_ano) = i ) then Response.Write (" selected ") end if
                        i = i - 1
                        Response.Write "> " & i
                        Response.Write "</option>"
                    Loop
                %>
                </select>
            </p>
            <p>
                <label for="DataFinal">Período - Final</label>
			    <select name="fim_mes" id="fim_mes"  onChange="newDoc7(this.value);">
                <%
                For i=0 to 13
                    if i < 10   then ix="0"&i else ix=i  end if
                    Response.Write "<option value='" & ix & "'"
                    if ( cint(fim_mes) = 0 )  then
                        if ( i = 0 ) then Response.Write (" selected ") end if
                    else
                        if ( cint(fim_mes) = i ) then Response.Write (" selected ") end if
                    end if
                    Response.Write ">" & strMes(i)
                    Response.Write "</option>"
                Next
                %>
                </select>
                <%  i = mid(Date(),7,4) + 1  %>
                <select name="fim_ano" id="fim_ano"  onChange="newDoc8(this.value);">
                <%
                i = i + 5
                Do until i=2000
                    Response.Write "<option value=" & i - 1
                    i = i - 1
                    if ( cint(fim_ano) = i ) then Response.Write (" selected ") end if
                    Response.Write "> " & i
                    Response.Write "</option>"
                Loop
                %>
                </select>
            </p>
			</select>

		</td></tr>
		</table>
		</form>

        <table id="tabela" cellspacing="5" cellpadding="5">
        <tr>
            <td colspan =21 align=left>
    			<button id="bt_menu" onClick="gerar_relatorio();">Gerar Relatório</button>
            </td>
            <td colspan =1 align=right>
    			<button id="bt_menu" onClick="window.print();return false;">Imprimir</button>
            </td>
        </tr>
        </table>

        <br>

		<%

		if ord="" then
			sqlord = "TITULO"
		end if
		select case ord
			case "tp": sqlord = "T.DESCRICAO"
			case "tt": sqlord = "TITULO"
			case "st": sqlord = "C.COD_STATUS"
		end select
		SQL = "SELECT COD_CURSO,T.DESCRICAO AS TDESC,S.DESCRICAO AS SDESC,TITULO FROM CURSO C "         & _
              "  JOIN CURSO_STATUS S ON C.COD_STATUS=S.COD_STATUS "                                     & _
              "  JOIN CURSO_TIPO   T ON C.COD_TIPO=T.COD_TIPO "                                         & _
              " WHERE " & sqlwhere & " "                                                                & _
              " ORDER BY " & sqlord
		RS.Open SQL

		if RS.EOF then
			%><p>Nenhuma turma cadastrada que atenda aos filtros selecionados</p><%
		else
			%>
			<table id="tabela">

			<tr><td class="header"><a href="gestao_turmas.asp?ord=tt&st=<%=st%>">curso</a></td><td class="header"><a href="gestao_turmas.asp?ord=tp&st=<%=st%>">tipo</a></td><td class="header"><a href="gestao_turmas.asp?ord=st&st=<%=st%>">status</a></td><td></td></tr>
			<%
			c = 1
			while not RS.EOF
				sql1 =  "SELECT DISTINCT CT.DESCRICAO AS TDESC,N.NOME_BREVE,C.COD_STATUS,N.COD_STATUS_TURMA, "          & _
                        "       N.ID_TURMA,N.CODIGO_TURMA,N.DT_INICIO_TURMA,N.DT_FIM_TURMA,U.STATUS_TURMA, "            & _
                        "       (SELECT ALUNOS FROM VIEW_TURMAS_ALUNOS WHERE CODIGO_TURMA=N.CODIGO_TURMA) AS ALUNOS FROM TURMAS N "     & _
                        "  LEFT JOIN TURMA_ALUNO  AS L  ON N.ID_TURMA=L.ID_TURMA "                                      & _
                        "       JOIN TURMA_STATUS AS U  ON N.COD_STATUS_TURMA=U.COD_STATUS_TURMA "                      & _
                        "       JOIN CURSO        AS C  ON C.COD_CURSO=N.COD_CURSO "                                    & _
                        "       JOIN CURSO_TIPO   AS CT ON CT.COD_TIPO=N.COD_TIPO "                                     & _
                        " WHERE "
                sql1 = sql1 & " N.SIGA_PROJETO="&SIGA_PROJETO&" "
				if stt=0 then
					sql =  " AND N.COD_CURSO="&RS("cod_curso")&" "                                                      & _
                           " AND N.COD_CURSO IN (select DISTINCT COD_CURSO from TURMAS N WHERE N.COD_CURSO=C.COD_CURSO) "
					if data_inicio=0 then
					else
						sql = "AND N.COD_CURSO="&RS("cod_curso")&" AND DT_INICIO_TURMA>="&data_inicio&" AND DT_FIM_TURMA<="&data_final&" AND N.COD_CURSO IN (select DISTINCT COD_CURSO FROM TURMAS N WHERE N.COD_CURSO=C.COD_CURSO "
                        if ( data_inicio <> 0 ) then sql_data_inicio = " AND DT_INICIO_TURMA>=" & data_inicio & " " end if
                        if ( data_final <> 0  ) then sql_data_final  = " AND DT_FIM_TURMA<="    & data_final  & " " end if
                        sql = sql & sql_data_inicio & sql_data_final & ")"
                        ' " AND LEFT(DT_INICIO_TURMA,4)="&ano&")"
					end if
				else
					sql = " AND N.COD_CURSO="&RS("cod_curso")&" AND N.COD_STATUS_TURMA='"&request("stt")&"' AND N.COD_CURSO IN (select DISTINCT COD_CURSO FROM TURMAS N WHERE N.COD_CURSO=C.COD_CURSO AND N.COD_STATUS_TURMA='"&request("stt")&"')"
					if data_final=0 then
					else
						sql = " AND N.COD_CURSO="&RS("cod_curso")&" "                       & _
                              " AND DT_INICIO_TURMA>="&data_inicio&" "                      & _
                              " AND DT_FIM_TURMA<="&data_final&" "                          & _
                              " AND N.COD_STATUS_TURMA='"&request("stt")&"' "               & _
                              " AND N.COD_CURSO IN (select DISTINCT COD_CURSO FROM TURMAS N WHERE N.COD_CURSO=C.COD_CURSO AND DT_INICIO_TURMA>="&data_inicio&" "    & _
                              " AND DT_FIM_TURMA<="&data_final&" "                          & _
                              " AND N.COD_STATUS_TURMA='"&request("stt")&"')"
                        if ( data_inicio <> 0 ) then sql_data_inicio = " AND DT_INICIO_TURMA>=" & data_inicio & " " end if
                        if ( data_final <> 0  ) then sql_data_final  = " AND DT_FIM_TURMA<="    & data_final  & " " end if
                        sql = sql & sql_data_inicio & sql_data_final & " "
                        ' " AND LEFT(DT_INICIO_TURMA,4)="&ano&")"
					end if
				end if

				sql = sql1 & sql & " ORDER BY CODIGO_TURMA"
					' Response.write ("SQL linha 352: " & sql  & "<br><br>")
					RS1.open sql
					if RS1.EOF then
					else
						%>
						<tr class="c<%=c%>"><td width="400"><%If Session("key_cur")="ok" Then%><a href="cad_turmas.asp?cod=<%=RS("COD_CURSO")%>"><%=RS("TITULO")%></a><%else%><%=RS("TITULO")%><%end if%></td><td><%=RS("TDESC")%></td><td><%=RS("SDESC")%></td><Td></td></tr>
						<tr>
							<td colspan=4>
								<table align=center width="90%">
									<tr>
										<td>Codigo da Turma</td>
										<td>Data de Inicio</td>
										<td>Data de Término</td>
										<td>Status</td>
										<td>Nome Breve</td>
										<td>Modalidade</td>
										<td>Alunos</td>
										<td></td>
										<td></td>
										<tr>
						<%while not RS1.eof%>
							<tr>
								<td width="15%"><a href="cad_turmas.asp?tur=<%=RS1("ID_TURMA")%>"><% =RS1("CODIGO_TURMA")%></a></td>
								<td width="15%"><% =formataData(RS1("DT_INICIO_TURMA"))%></TD>
								<td width="15%"><% =formataData(RS1("DT_FIM_TURMA"))%></TD>
								<td width="15%"><% =RS1("STATUS_TURMA")%></TD>
								<td width="25%"><% =left(RS1("NOME_BREVE"),20)%></TD>
								<td width="10%"><% =RS1("TDESC")%></TD>
								<td width="10%"><a href="gestao_selecao.asp?cod=<%=RS1("ID_TURMA")%>"><% =RS1("ALUNOS")%></a></TD>
								<td> <!---- <a href="http://<%=URLI%>default.asp?idc=<%=RS1("ID_TURMA")%>" target="_blank">ver</a> ----></td>
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