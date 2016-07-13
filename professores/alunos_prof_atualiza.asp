<%If session("id")="" Then Response.Redirect "area_professores.asp"%>
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
<!-- #INCLUDE FILE="../library/fFormataData.asp" -->
<!-- #INCLUDE FILE="../library/fFormataCep.asp" -->
<!-- #INCLUDE FILE="../library/fFormataCPF.asp" -->

<%

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

ID_TURMA=request("ID_TURMA")
Set RS1 = Server.CreateObject("ADODB.Recordset")
RS1.CursorType = 0
RS1.ActiveConnection = Con
Set RS2 = Server.CreateObject("ADODB.Recordset")
RS2.CursorType = 0
RS2.ActiveConnection = Con
Set RS3 = Server.CreateObject("ADODB.Recordset")
RS3.CursorType = 0
RS3.ActiveConnection = Con

MES = request("mes")
ANO = request("ano")

mes_hoje = month(now)
ano_hoje = year(now)

if MES  ="" or isNumeric(MES)=false then MES=0  end if
if ANO  ="" or isNumeric(ANO)=false then ANO=0  end if

COD_CURSO       = request("COD_CURSO")
ID_TURMA        = request("ID_TURMA")
LANC_GERAL      = request("LANC_GERAL")
LANC_GERAL_MES  = request("LANC_GERAL_MES")
LANC_GERAL_ANO  = request("LANC_GERAL_ANO")



%>

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<link rel="stylesheet" type="text/css" href="../css/styles1.css" />
	<link rel="stylesheet" type="text/css" href="../css/form1.css" />

	<title>ENSUR - SIGA</title>

<script type="text/javascript">

	function newDoc1(lanc_geral) {

//        alert('Cod_Curso: '   + document.form.cod_curso.value);
//        alert('ID Turma: '    + document.form.id_turma.value);
//        alert('Lanc_Geral: '  + document.form.lanc_geral.value);

	    cod_curso   = document.form.cod_curso.value;
		id_turma    = document.form.id_turma.value;
		lanc_geral  = document.form.lanc_geral.value;
		url = 'alunos_prof_atualiza.asp?';
        url = url + 'cod_curso='  + cod_curso   + '&';
        url = url + 'id_turma='   + id_turma    + '&';
        url = url + 'lanc_geral=' + lanc_geral;
        window.location=url;
	}

</SCRIPT>

</head>
<body>
<div id="pagina">
	<!-- #INCLUDE FILE="../include/topo_professores.asp" -->
	<div id="conteudo">
		<h1>ÁREA DO PROFESSOR</h1>

		<%
        sql = "SELECT NOME as NOME_PROF FROM PROFESSORES WHERE ID_PROFESSOR="&session("id")
        RS.Open sql
        if not RS.EOF then  NOME_PROF = RS("NOME_PROF")  end if
        RS.Close

		sql = "SELECT T.FREQUENCIA,T.ID_TURMA,T.DT_INICIO_TURMA,T.CODIGO_TURMA,T.DT_FIM_TURMA,T.VALOR, "            & _
              "       T.COD_STATUS_TURMA,TS.STATUS_TURMA, "                                                         & _
              "       (SELECT TITULO FROM CURSO WHERE COD_CURSO=T.COD_CURSO) AS TITULO FROM TURMAS AS T "           & _
              "       LEFT JOIN TURMA_STATUS TS ON T.COD_STATUS_TURMA=TS.COD_STATUS_TURMA "                         & _
              "       WHERE T.ID_TURMA=" & ID_TURMA & " AND (T.COD_STATUS_TURMA='6' OR T.COD_STATUS_TURMA='7') "

'  Response.Write ("SQL: " & sql & "<br>")
'  Response.End

		RS.Open sql
		if RS.EOF then erroMsg("As notas só podem ser lançadas em turmas encerradas ou realizadas")
		curso_tit       = RS("TITULO")
		DT_INICIO_TURMA = RS("DT_INICIO_TURMA")
		DT_FIM_TURMA    = RS("DT_FIM_TURMA")
		VALOR           = RS("VALOR")
		STATUS_TURMA    = RS("STATUS_TURMA")
		CODIGO_TURMA    = RS("CODIGO_TURMA")
		FREQUENCIA      = RS("FREQUENCIA")
        MES_FIM_TURMA   = mid(DT_FIM_TURMA,5,2)
        ANO_FIM_TURMA   = mid(DT_FIM_TURMA,1,4)
		RS.Close
		%>

		<h2><%=NOME_PROF%></h2><br>

        <table border="0" >
            <tr><td align="right"><span style="font-weight: bold">Curso</span></td>            <td><span style="font-weight: bold"><%=curso_tit%></span></td></tr>
            <tr><td align="right"><span style="font-weight: bold">Data de Inicio</span></td>   <td><%=formataData(DT_INICIO_TURMA)%></td></tr>
            <tr><td align="right"><span style="font-weight: bold">Data de Término</span></td>  <td><%=formataData(DT_FIM_TURMA)%></td></tr>
            <tr><td align="right"><span style="font-weight: bold">Código da Turma</span></td>  <td><% =CODIGO_TURMA %></td></tr>
            <tr></tr>
        </table>
        <br>

		<form name="form" id="form" action="alunos_prof_atualiza.asp?op=1" method="get">
			<input type="hidden" name="id_turma"    id="id_turma"   value="<%=ID_TURMA%>">
			<input type="hidden" name="cod_curso"   id="cod_curso"  value="<%=COD_CURSO%>">
			<input type="hidden" name="op" value="1">
        <table border="0" >
            <tr>
                <td align="right"><span style="font-weight: bold">Data de lançamento Geral</span></td>
                <td>
                    <input type="radio" name="lanc_geral" id="lanc_geral" onchange="newDoc1(this.value);" value="sim"
                    <% if (lanc_geral="sim") then response.write(" checked") end if  %>
                    >Sim<br>
                </td>
                <td>
                    <input type="radio" name="lanc_geral" id="lanc_geral" onchange="newDoc1(this.value);" value="nao"
                    <% if (lanc_geral="nao") then response.write(" checked") end if  %>
                    >Não<br>
                </td>
                <td align="right"></td>
                <td align="right">
                    <%
                    if (lanc_geral="sim")   then
                        Response.Write "<select name='lanc_geral_mes' " & "id='lanc_geral_mes'>"
                        For i=1 to 12
                            if i < 10   then ix="0"&i else ix=i  end if
                            Response.Write "<option value='" & ix & "'"
                            if ( i = cint(mes_fim_turma) ) then Response.Write (" selected ") end if
                            Response.Write ">" & strMes(i)
                            Response.Write "</option>"
                        Next
                        Response.Write("</select>")
                    end if
                    %>
                </td>
                <td align="right">
                    <%
                    if (lanc_geral="sim")   then
                        i = mid(Date(),7,4) + 5
                        Response.Write "<select name='lanc_geral_ano' " & "id='lanc_geral_ano'>"
                        Do until i=2013
                            Response.Write "<option value='" & i & "'"
                            if ( i = cint(ano_fim_turma) ) then Response.Write (" selected ") end if
                            Response.Write "> " & i
                            Response.Write "</option>"
                            ' Response.Write "i: " & i & " ano: " & ano_fim_turma & "</option>"
                            i = i - 1
                        Loop
                        Response.Write("</select>")
                    end if
                    %>
                </td>
            </tr>
            <tr></tr>
        </table>

		<%
		sql = "SELECT COUNT(*) FROM TURMA_ALUNO C JOIN ALUNO A ON C.COD_ALUNO=A.COD_ALUNO WHERE ID_TURMA="&ID_TURMA
		RS.Open sql
			total_alunos = RS(0)
		RS.Close
		sql = "SELECT A.COD_ALUNO,A.NOME,C.COD_CURSO,C.ID_TURMA,C.STATUS,F.MES,F.ANO,F.NOTA,T.COD_STATUS_TURMA "    & _
              "  FROM TURMA_ALUNO C "                                                                               & _
              "  LEFT JOIN ALUNO A ON C.COD_ALUNO=A.COD_ALUNO "                                                     & _
              "  LEFT JOIN ALUNO_FREQUENCIA F ON C.COD_ALUNO=F.COD_ALUNO AND C.COD_CURSO=F.COD_CURSO "              & _
              "                                                          AND C.ID_TURMA=F.ID_TURMA "                & _
              "  LEFT JOIN TURMAS T ON T.ID_TURMA=C.ID_TURMA "                                                      & _
              " WHERE C.ID_TURMA=" & ID_TURMA                                                                       & _
              "   AND (T.COD_STATUS_TURMA='6' OR T.COD_STATUS_TURMA='7') "                                          & _
              " ORDER BY A.NOME"
' Response.Write ("SQL: " & sql & "<br>")
' Response.End

		RS.Open sql

        %>

        <br>
        <table border="0" width="100%">
        <tr>
        <td valign="center" align="left">
		<%
		turma="vazio"
        if RS.EOF then
			turma="vazio"
			%>Nenhum aluno cadastrado<%
		else
			turma="ok"
			COD_ALUNO = RS("COD_ALUNO")
			%>
			<%=total_alunos%> aluno(s) na turma

        </td>
        <td valign="center" align="right">
		    <button id="bt_menu" onClick="window.print();return false;">Imprimir</button>
        </td>
        </table>

			<table id="tabela" border="0">
			<tr><td colspan="<% =FREQUENCIA+5 %>">
			</td></tr>
            <tr>
				<td class="header" colspan="2">Aluno</td>
                <%
                    if lanc_geral="nao" then
				        Response.Write "<td class='header'>Data do Lançamento</td>"
                    else
				        Response.Write "<td class='header'></td>"
                    end if
                %>
				<td class='header'>Nota</td>
				<td class='header'>Resultado</td>
            </tr>
				<%
				c = 0
' Response.Write ("Antes do while dos alunos da turma... <br>")
				while not RS.EOF
					COD_ALUNO   = RS("COD_ALUNO")
					NOTA        = request(COD_ALUNO&"_NOTA")
					RESULTADO   = request(COD_ALUNO&"_RESULTADO")
					MES         = request(COD_ALUNO&"_MES")
					ANO         = request(COD_ALUNO&"_ANO")

           			sql = "SELECT ID_FREQUENCIA,ID_PROFESSOR,COD_CURSO,ID_TURMA,ANO,MES,NOTA,RESULTADO FROM ALUNO_FREQUENCIA " & _
                          " WHERE COD_ALUNO='"&COD_ALUNO&"' AND COD_CURSO='"&COD_CURSO&"' AND ID_TURMA='"&ID_TURMA&"'"
' Response.Write ("SQL - dentro do while  dos alunos da turma: " & sql & "<br>")
' Response.Write ("Nota: " & nota & "<br>")
' Response.Write ("Resultado: " & resultado & "<br>")
                    RS2.Open sql
        			if RS2.EOF then
' Se não existir no aluno_frequencia, deve incluir com mes e ano corrente, nota=0 e resultado = a branco
        				sql = "INSERT INTO ALUNO_FREQUENCIA (ID_PROFESSOR,COD_ALUNO,COD_CURSO,ID_TURMA, "       & _
                              "                              ANO,MES,NOTA,RESULTADO) "                          & _
                              "     VALUES ('"&session("id")&"','"&COD_ALUNO&"','"&request("COD_CURSO")&"','"   & _
                                    request("ID_TURMA")&"','" & ANO & "','" & MES & "','"                       & _
                                    "0" & "','" & "" & "')"
        				con.execute sql
                    else
       				    if request("Enviar") = "Salvar" then
' Response.Write ("Ação - dentro do update dos alunos da turma: " & request("Enviar") & " - " & "Resultado: " & RESULTADO & "<br>")
                            if ( (RESULTADO<>"APROVADO") AND (RESULTADO<>"REPROVADO") AND (RESULTADO<>"EVADIDO") AND (RESULTADO<>"NUNCA ACESSOU") ) then RESULTADO = "" end if
                            if (lanc_geral="sim")   then
                                ANO=lanc_geral_ano
                                MES=lanc_geral_mes
                            end if
            			    sql =   "UPDATE ALUNO_FREQUENCIA "                                  & _
                                   "       SET MES='"&MES&"', "                                 & _
                                   "           ANO='"&ANO&"', "                                 & _
                                   "           NOTA='"&NOTA&"', "                               & _
                                   "           RESULTADO='"&RESULTADO&"' "                      & _
                                   " WHERE COD_ALUNO='"&COD_ALUNO&"' AND COD_CURSO='"&COD_CURSO&"' AND ID_TURMA='"&ID_TURMA&"'"
' Response.Write ("SQL UPDATE: " & sql & "<br>")
            			    con.execute sql

                            if ( (RESULTADO="APROVADO") OR (RESULTADO="REPROVADO") OR (RESULTADO="EVADIDO") OR (RESULTADO="NUNCA ACESSOU") )    then
                                sql_update_turma =  "UPDATE TURMA_ALUNO   "                         & _
                                                    "       SET STATUS='"&RESULTADO&"' "            & _
                                                    " WHERE COD_ALUNO='"&COD_ALUNO&"' "             & _
                                                    "   AND COD_CURSO='"&COD_CURSO&"' "             & _
                                                    "   AND ID_TURMA='"&ID_TURMA&"'"
' Response.Write ("SQL UPDATE: " & sql_update_turma & "<br>")
' Response.Write ("Resultado dentro do if para atualizar turma_aluno: " & RESULTADO & "<br>" )
' Response.End
            			        con.execute sql_update_turma
                            end if
            			end if
                    end if
				    sql = "SELECT ID_FREQUENCIA,ID_PROFESSOR,COD_ALUNO,COD_CURSO,ID_TURMA,ANO,MES,      "           & _
                          "       NOTA, RESULTADO FROM ALUNO_FREQUENCIA "                                           & _
                          " WHERE COD_ALUNO='"&COD_ALUNO&"' AND COD_CURSO='"&COD_CURSO&"' AND ID_TURMA='"&ID_TURMA&"'"
    				RS3.open sql
    				NOTA        = RS3("NOTA")
    				RESULTADO   = RS3("RESULTADO")
    				ANO         = RS3("ANO")
    				MES         = RS3("MES")
                    RS3.Close
                    RS2.Close

					%>
					<tr class="c<%=c%>">
					<td colspan="2"><%=RS("NOME")%></td>

					<td>
                        <%

                        if lanc_geral="nao" then
                            Response.Write "<select name='" & RS("COD_ALUNO") & "_MES' " & "id='" & RS("COD_ALUNO") & "_MES'>"
                            Dim i
                            For i=1 to 12
                                if i < 10   then ix="0"&i else ix=i  end if
                                Response.Write "<option value='" & ix & "'"
                                if ( MES = 0 )  then
                                    if ( i = mes_hoje ) then Response.Write (" selected ") end if
                                else
                                    if ( cint(MES) = i ) then Response.Write (" selected ") end if
                                end if
                                Response.Write ">" & strMes(i)
                                Response.Write "</option>"
                            Next
                            %>
                            </select>
                            <%  i = mid(Date(),7,4) + 1  %>
                            <%
                            Response.Write "<select name='" & RS("COD_ALUNO") & "_ANO' " & "id='" & RS("COD_ALUNO") & "_ANO'>"
                            Do until i=2000
                                Response.Write "<option value='" & i - 1 & "'"
                                i = i - 1
                                if ( ANO = 0 )  then
                                    if ( i = ano_hoje ) then Response.Write (" selected ") end if
                                else
                                    if ( cint(ANO) = i ) then Response.Write (" selected ") end if
                                end if
                                Response.Write "> " & i
                                Response.Write "</option>"
                            Loop
                            Response.Write "</select>"
                        end if
                        %>
                    </td>

					<%
' NOTA
					response.write "<td><input type='text' name='"&RS("COD_ALUNO")&"_NOTA' value='"&NOTA&"' maxlength='5' size='6'"
					response.write "></td>"
					%>

                    <td>
					<%
' RESULTADO
					response.write "<select name='"&RS("COD_ALUNO")&"_RESULTADO"&"'>"
					%>
					<option value="0">Selecione o Resultado</option>
					<option value="APROVADO"        <% if RESULTADO="APROVADO"       then %> Selected  <% end if %>>Aprovado</option>
					<option value="REPROVADO"       <% if RESULTADO="REPROVADO"      then %> Selected  <% end if %>>Reprovado</option>
					<option value="EVADIDO"         <% if RESULTADO="EVADIDO"        then %> Selected  <% end if %>>Evadido</option>
					<option value="NUNCA ACESSOU"   <% if RESULTADO="NUNCA ACESSOU"  then %> Selected  <% end if %>>Nunca Acessou</option>
					</select>
                    </td>

					</tr>
					<%
					NOTA = 0
					c = 1 - c
					RS.MoveNext
					' RS2.close
				wend
			RS.Close
		end if
		%>
		</table>
		<BR>

		<input type="submit" name="Enviar" value="Salvar" class="buttonF">

		<button class="hover" id="bt_menu" onClick="window.location.assign('area_professores.asp');return false;">Voltar</button><br /><br /></td></tr>
		</form>
		<p><br /></p>
	</div>
</div>
</body>
</html>
<%conClose%>