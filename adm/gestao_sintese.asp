<%If session("key_ver")<>"ok" Then Response.Redirect "logout.asp"%>
<!-- #INCLUDE FILE="../library/parametros.asp" -->
<!-- #INCLUDE FILE="../library/conOpen.asp" -->
<!-- #INCLUDE FILE="../library/conOpenSIM.asp" -->
<!-- #INCLUDE FILE="../library/fErroMsg.asp" -->
<!-- #INCLUDE FILE="../library/fFormataData.asp" -->
<!-- #INCLUDE FILE="../library/fData.asp" -->
<!-- #INCLUDE FILE="../library/fCreateSel.asp" -->

<%

    SIGA_PROJETO=Session("siga_projeto")

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
    <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
    <meta http-equiv="Pragma" content="no-cache" />
    <meta http-equiv="Expires" content="0" />

	<script type="text/javascript">
	 function newDoc1(curso) {
		pv          = document.form.pv.value;
		curso       = document.form.curso.value;
		turma       = document.form.turma.value;
        estado      = document.form.estado.value;
		municipio   = document.form.municipio.value;
		ini_mes     = document.form.ini_mes.value;
		ini_ano     = document.form.ini_ano.value;
		fim_mes     = document.form.fim_mes.value;
		fim_ano     = document.form.fim_ano.value;
		url = 'gestao_sintese.asp?';
        url = url + 'pv='         + pv         + '&';
        url = url + 'curso='      + curso      + '&';
        url = url + 'turma='      + turma      + '&';
        url = url + 'estado='     + estado     + '&';
        url = url + 'municipio='  + municipio  + '&';
        url = url + 'ini_mes='    + ini_mes    + '&';
        url = url + 'ini_ano='    + ini_ano    + '&';
        url = url + 'fim_mes='    + fim_mes    + '&';
        url = url + 'fim_ano='    + fim_ano;
        window.location=url;
	 }
	 function newDoc2(turma) {
		pv          = document.form.pv.value;
		curso       = document.form.curso.value;
		turma       = document.form.turma.value;
        estado      = document.form.estado.value;
		municipio   = document.form.municipio.value;
		ini_mes     = document.form.ini_mes.value;
		ini_ano     = document.form.ini_ano.value;
		fim_mes     = document.form.fim_mes.value;
		fim_ano     = document.form.fim_ano.value;
		url = 'gestao_sintese.asp?';
        url = url + 'pv='         + pv         + '&';
        url = url + 'curso='      + curso      + '&';
        url = url + 'turma='      + turma      + '&';
        url = url + 'estado='     + estado     + '&';
        url = url + 'municipio='  + municipio  + '&';
        url = url + 'ini_mes='    + ini_mes    + '&';
        url = url + 'ini_ano='    + ini_ano    + '&';
        url = url + 'fim_mes='    + fim_mes    + '&';
        url = url + 'fim_ano='    + fim_ano;
        window.location=url;
	 }
	 function newDoc3(estado) {
		pv          = document.form.pv.value;
		curso       = document.form.curso.value;
		turma       = document.form.turma.value;
        estado      = document.form.estado.value;
		municipio   = document.form.municipio.value;
		ini_mes     = document.form.ini_mes.value;
		ini_ano     = document.form.ini_ano.value;
		fim_mes     = document.form.fim_mes.value;
		fim_ano     = document.form.fim_ano.value;
		url = 'gestao_sintese.asp?';
        url = url + 'pv='         + pv         + '&';
        url = url + 'curso='      + curso      + '&';
        url = url + 'turma='      + turma      + '&';
        url = url + 'estado='     + estado     + '&';
        url = url + 'municipio='  + municipio  + '&';
        url = url + 'ini_mes='    + ini_mes    + '&';
        url = url + 'ini_ano='    + ini_ano    + '&';
        url = url + 'fim_mes='    + fim_mes    + '&';
        url = url + 'fim_ano='    + fim_ano;
        window.location=url;
	 }
	 function newDoc4(municipio) {
		pv          = document.form.pv.value;
		curso       = document.form.curso.value;
		turma       = document.form.turma.value;
        estado      = document.form.estado.value;
		municipio   = document.form.municipio.value;
		ini_mes     = document.form.ini_mes.value;
		ini_ano     = document.form.ini_ano.value;
		fim_mes     = document.form.fim_mes.value;
		fim_ano     = document.form.fim_ano.value;
		url = 'gestao_sintese.asp?';
        url = url + 'pv='         + pv         + '&';
        url = url + 'curso='      + curso      + '&';
        url = url + 'turma='      + turma      + '&';
        url = url + 'estado='     + estado     + '&';
        url = url + 'municipio='  + municipio  + '&';
        url = url + 'ini_mes='    + ini_mes    + '&';
        url = url + 'ini_ano='    + ini_ano    + '&';
        url = url + 'fim_mes='    + fim_mes    + '&';
        url = url + 'fim_ano='    + fim_ano;
        window.location=url;
	 }
	 function newDoc5(ini_mes) {
		pv          = document.form.pv.value;
		curso       = document.form.curso.value;
		turma       = document.form.turma.value;
        estado      = document.form.estado.value;
		municipio   = document.form.municipio.value;
		ini_mes     = document.form.ini_mes.value;
		ini_ano     = document.form.ini_ano.value;
		fim_mes     = document.form.fim_mes.value;
		fim_ano     = document.form.fim_ano.value;
        ini_data = ini_ano + ini_mes;
        fim_data = fim_ano + fim_mes;
        if (fim_data < ini_data) {
            window.alert ("A data final de pesquisa é menor do que a data inicial");
            fim_mes  = ini_mes
            fim_ano  = ini_ano
            fim_data = ini_data
        }
		url = 'gestao_sintese.asp?';
        url = url + 'pv='         + pv         + '&';
        url = url + 'curso='      + curso      + '&';
        url = url + 'turma='      + turma      + '&';
        url = url + 'estado='     + estado     + '&';
        url = url + 'municipio='  + municipio  + '&';
        url = url + 'ini_mes='    + ini_mes    + '&';
        url = url + 'ini_ano='    + ini_ano    + '&';
        url = url + 'fim_mes='    + fim_mes    + '&';
        url = url + 'fim_ano='    + fim_ano;
		window.location=url;
	 }
	 function newDoc6(ini_ano) {
		pv          = document.form.pv.value;
		curso       = document.form.curso.value;
		turma       = document.form.turma.value;
        estado      = document.form.estado.value;
		municipio   = document.form.municipio.value;
		ini_mes     = document.form.ini_mes.value;
		ini_ano     = document.form.ini_ano.value;
		fim_mes     = document.form.fim_mes.value;
		fim_ano     = document.form.fim_ano.value;
        ini_data = ini_ano + ini_mes;
        fim_data = fim_ano + fim_mes;
        if (fim_data < ini_data) {
            window.alert ("A data final de pesquisa é menor do que a data inicial");
            fim_mes  = ini_mes
            fim_ano  = ini_ano
            fim_data = ini_data
        }
		url = 'gestao_sintese.asp?';
        url = url + 'pv='         + pv         + '&';
        url = url + 'curso='      + curso      + '&';
        url = url + 'turma='      + turma      + '&';
        url = url + 'estado='     + estado     + '&';
        url = url + 'municipio='  + municipio  + '&';
        url = url + 'ini_mes='    + ini_mes    + '&';
        url = url + 'ini_ano='    + ini_ano    + '&';
        url = url + 'fim_mes='    + fim_mes    + '&';
        url = url + 'fim_ano='    + fim_ano;
		window.location=url;
	 }
	 function newDoc7(fim_mes) {
		pv          = document.form.pv.value;
		curso       = document.form.curso.value;
		turma       = document.form.turma.value;
        estado      = document.form.estado.value;
		municipio   = document.form.municipio.value;
		ini_mes     = document.form.ini_mes.value;
		ini_ano     = document.form.ini_ano.value;
		fim_mes     = document.form.fim_mes.value;
		fim_ano     = document.form.fim_ano.value;
        ini_data = ini_ano + ini_mes;
        fim_data = fim_ano + fim_mes;
        if (fim_data < ini_data) {
            window.alert ("A data final de pesquisa é menor do que a data inicial");
            fim_mes  = ini_mes
            fim_ano  = ini_ano
            fim_data = ini_data
        }
		url = 'gestao_sintese.asp?';
        url = url + 'pv='         + pv         + '&';
        url = url + 'curso='      + curso      + '&';
        url = url + 'turma='      + turma      + '&';
        url = url + 'estado='     + estado     + '&';
        url = url + 'municipio='  + municipio  + '&';
        url = url + 'ini_mes='    + ini_mes    + '&';
        url = url + 'ini_ano='    + ini_ano    + '&';
        url = url + 'fim_mes='    + fim_mes    + '&';
        url = url + 'fim_ano='    + fim_ano;
		window.location=url;
	 }
	 function newDoc8(fim_ano) {
		pv          = document.form.pv.value;
		curso       = document.form.curso.value;
		turma       = document.form.turma.value;
        estado      = document.form.estado.value;
		municipio   = document.form.municipio.value;
		ini_mes     = document.form.ini_mes.value;
		ini_ano     = document.form.ini_ano.value;
		fim_mes     = document.form.fim_mes.value;
		fim_ano     = document.form.fim_ano.value;
        ini_data = ini_ano + ini_mes;
        fim_data = fim_ano + fim_mes;
        if (fim_data < ini_data) {
            window.alert ("A data final de pesquisa é menor do que a data inicial");
            fim_mes  = ini_mes
            fim_ano  = ini_ano
            fim_data = ini_data
        }
		url = 'gestao_sintese.asp?';
        url = url + 'pv='         + pv         + '&';
        url = url + 'curso='      + curso      + '&';
        url = url + 'turma='      + turma      + '&';
        url = url + 'estado='     + estado     + '&';
        url = url + 'municipio='  + municipio  + '&';
        url = url + 'ini_mes='    + ini_mes    + '&';
        url = url + 'ini_ano='    + ini_ano    + '&';
        url = url + 'fim_mes='    + fim_mes    + '&';
        url = url + 'fim_ano='    + fim_ano;
		window.location=url;
	 }

	 function planilha() {
		pv          = document.form.pv.value;
		curso       = document.form.curso.value;
		turma       = document.form.turma.value;
        estado      = document.form.estado.value;
		municipio   = document.form.municipio.value;
		ini_mes     = document.form.ini_mes.value;
		ini_ano     = document.form.ini_ano.value;
		fim_mes     = document.form.fim_mes.value;
		fim_ano     = document.form.fim_ano.value;
		url = 'gera_excel_sintese.asp?';
        url = url + 'pv='         + pv         + '&';
        url = url + 'curso='      + curso      + '&';
        url = url + 'turma='      + turma      + '&';
        url = url + 'estado='     + estado     + '&';
        url = url + 'municipio='  + municipio  + '&';
        url = url + 'ini_mes='    + ini_mes    + '&';
        url = url + 'ini_ano='    + ini_ano    + '&';
        url = url + 'fim_mes='    + fim_mes    + '&';
        url = url + 'fim_ano='    + fim_ano    + '&';
        url = url + 'planilha=OK';
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

		Set RS2 = Server.CreateObject("ADODB.Recordset")
		RS2.CursorType = 0
		RS2.ActiveConnection = Con

'		stt        =request("stt")
'		st         = request("st")
'		ano        = request("ano")
'		ord        = request("ord")

		pv         = request("pv")
        planilha   = request("planilha")

		curso      = request("curso")
		turma      = request("turma")
		estado     = request("estado")
		municipio  = request("municipio")
		ini_mes    = request("ini_mes")
		ini_ano    = request("ini_ano")
		fim_mes    = request("fim_mes")
		fim_ano    = request("fim_ano")

		if pv=""            or isNumeric(pv)=false          then pv=0
		if curso=""         or isNumeric(curso)=false       then curso=0
		if turma=""         or isNumeric(turma)=false       then turma=0
		if estado=""        or isNumeric(estado)=false      then estado=0
		if municipio=""     or isNumeric(municipio)=false   then municipio=0
		if ini_mes  =""     or isNumeric(ini_mes)=false     then ini_mes=0      end if
		if ini_ano  =""     or isNumeric(ini_ano)=false     then ini_ano=2016   end if
		if fim_mes  =""     or isNumeric(fim_mes)=false     then fim_mes=0      end if
		if fim_ano  =""     or isNumeric(fim_ano)=false     then fim_ano=2016   end if

        if len(ini_mes)  = 1  then ini_mes = "0" & ini_mes   end if
        data_inicio = ini_ano & ini_mes & "00"
        if len(fim_mes)  = 1  then fim_mes = "0" & fim_mes   end if
        data_final  = fim_ano & "12" & "99"

		%>

		<h1>Relatório de Perfil do Aluno</h1>

		<form name="form" action="gestao_sintese.asp" method="get">
		<input type="hidden" name="ord" value="<%=ord%>">
        <input type="hidden" name="pv" id="pv" value="1">

		<table id="tabela">
			<%
			sql="SELECT COD_CURSO,TITULO FROM CURSO WHERE SIGA_PROJETO="&SIGA_PROJETO&" ORDER BY TITULO"
			rs.Open sql
			%>

			<tr><td>

			<p><label for="ID_CURSO">Curso</label>
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
            <select name="turma" id="turma" onchange="newDoc2(this.value);">
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


			<%
			sql_estado="SELECT SIGLA_UF, NOME_UF, COD_UF_IBGE FROM UF ORDER BY NOME_UF"
			RSSIM.Open sql_estado
			%>
			<p><label for="UF">Estado</label>
			<select name="estado" id="estado" onchange="newDoc3(this.value);">
			<option></option>
			<%while not RSSIM.eof%>
				<option value="<% =RSSIM("COD_UF_IBGE") %>" <% if int(estado)=RSSIM("COD_UF_IBGE") then %> selected <% end if %>><% =RSSIM("NOME_UF") %></option><%
				RSSIM.movenext
			wend
			RSSIM.close
			%>
			</select>
			</p>

			<p><label for="MUNICIPIO">Município</label>
   			<%

            if ( estado = "" )    then
                sql_municipio="SELECT COD_UF_IBGE, COD_MUNI_IBGE, NOME_MUNI FROM MUNICIPIOS "    & _
                          "       ORDER BY NOME_MUNI"
            else
                sql_municipio="SELECT COD_UF_IBGE, COD_MUNI_IBGE, NOME_MUNI FROM MUNICIPIOS"    & _
                          "       WHERE COD_UF_IBGE='"&estado&"' "                              & _
                          "       ORDER BY NOME_MUNI"
            end if
            RSSIM.Open sql_municipio
			%>
            <select name="municipio" id="municipio" onchange="newDoc4(this.value);">
			<option></option>
			<%
            while not RSSIM.eof
                Response.Write "<option value='" & RSSIM("COD_MUNI_IBGE") & "'"
                if ( cint(municipio) = RSSIM("COD_MUNI_IBGE") )   then Response.Write(" selected")    end if
                Response.Write ">" & RSSIM("NOME_MUNI") & "</option>"
                RSSIM.movenext
			wend
			RSSIM.close
			%>
			</select>
			</p>

            <p>
                <label for="DataInicio">Período - Início</label>
			    <select name="ini_mes" id="ini_mes" onchange="newDoc5(this.value);">
                <%
                Dim i
                For i=0 to 13
                    if i < 10   then ix="0"&i   end if
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
                <select name="ini_ano" id="ini_ano" onchange="newDoc6(this.value);">
                <%
                Do until i=2000
                    Response.Write "<option value='" & i - 1 & "'"
                    i = i - 1
                    if ( cint(ini_ano) = i ) then Response.Write (" selected ") end if
                    Response.Write "> " & i
                    Response.Write "</option>"
                Loop
                %>
                </select>
            </p>
            <p>
                <label for="DataFinal">Período - Final</label>
			    <select name="fim_mes" id="fim_mes" onchange="newDoc7(this.value);">
                <%
                For i=0 to 13
                    if i < 10   then ix="0"&i   end if
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
                <select name="fim_ano" id="fim_ano" onchange="newDoc8(this.value);">
                <%
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


			<% if request("op") = 1 then %>
				<button id="bt_menu" onClick="window.print();return false;">Imprimir</button>
			<% end if %>
		</td>


        </tr>
		</table>
		</form>



	<%
'   ========<   INICÍO DO LOOP DE ALUNOS    >========

    if ( cint(pv) = 1 ) AND ( planilha = "" )   then

        sql_alunos = "SELECT   A.COD_ALUNO, A.NOME, A.CPF, A.COD_UF_IBGE, A.COD_MUNI_IBGE, "    & _
                     "         A.EFETIVO, A.TIPOENTI, A.CARGO, "                                & _
                     "         B.PRIORIDADE, B.UF_SIGLA, B.NOME_CIDADE, "                       & _
                     "         TA.COD_CURSO, TA.ID_INSCRICAO, TA.ENTURMADO, TA.CERTIFICADO, "   & _
                     "         TA.STATUS, "                                                     & _
                     "         T.ID_TURMA, T.DT_INICIO_TURMA, T.DT_FIM_TURMA, T.CODIGO_TURMA, " & _
                     "         T.ID_PROFESSOR, "                                                & _
                     "         C.TITULO, CT.DESCRICAO "                                         & _
                     "         FROM  ALUNO as A "                                               & _
                     "         JOIN  TURMA_ALUNO as TA  ON TA.COD_ALUNO=A.COD_ALUNO"            & _
                     "         JOIN  CURSO as C         ON TA.COD_CURSO=C.COD_CURSO"            & _
                     "         JOIN  TURMAS as T        ON TA.ID_TURMA=T.ID_TURMA"              & _
                     "         JOIN  CURSO_TIPO as CT   ON T.COD_TIPO=CT.COD_TIPO"              & _
                     "         JOIN  BIOMA_CIDADE as B  ON B.COD_UF_IBGE=A.COD_UF_IBGE AND"     & _
                     "                                     B.COD_MUNI_IBGE=A.COD_MUNI_IBGE"     & _
                     "         WHERE A.COD_ALUNO>0 "

        if data_inicio <> 0 then
        	sql_alunos = sql_alunos & "AND DT_INICIO_TURMA>=" & data_inicio & " "
        end if

        if data_final <> 0 then
        	sql_alunos = sql_alunos & "AND DT_FIM_TURMA<=" & data_final & " "
        end if

        if ( curso<>0)       then sql_alunos = sql_alunos & "           AND TA.COD_CURSO='"       & curso        & "'"  end if
        if ( turma<>0)       then sql_alunos = sql_alunos & "           AND TA.ID_TURMA='"        & turma        & "'"  end if
        if ( estado<>0)      then sql_alunos = sql_alunos & "           AND A.COD_UF_IBGE='"      & estado       & "'"  end if
        if ( municipio<>0)   then sql_alunos = sql_alunos & "           AND A.COD_MUNI_IBGE='"    & municipio    & "'"  end if
        sql_alunos = sql_alunos & "         ORDER BY C.TITULO, T.CODIGO_TURMA, A.NOME"

' Response.Write sql_alunos
' Response.Write "<br><br>"

        RS.Open sql_alunos

' Response.Write "<br><br>pv: "
' Response.Write pv
' Response.Write "<br><br>"
' Response.End



		if RS.EOF then
			%><p>Nenhum aluno cadastrado que atenda aos filtros selecionados</p><%
		else
			%>
			<table id="tabela" cellspacing="5" cellpadding="5">
			<tr><td colspan =22 align=right>
			<button id="bt_menu" onClick="window.print();return false;">Imprimir</button></td></tr>
			<button id="bt_menu" onClick="planilha();">Gerar Planilha</button></td></tr>

			<tr class="c1">
        		<td class="header" rowspan="2"> Curso</td>
        		<td class="header"> Turma</td>
        		<td class="header"> Mod</td>
        		<td class="header"> Inicio</td>
        		<td class="header"> Término</td>
        		<td class="header"> Tutor</td>
        		<td class="header"> CPF</td>
        		<td class="header"> Aluno</td>
        		<td class="header"> UF</td>
        		<td class="header"> Município</td>
        		<td class="header"> Prioridade</td>
        		<td class="header"> Geocódigo</td>
			</tr>
			<tr class="c1">
        		<td class="header"> Efe</td>
        		<td class="header"> Natureza</td>
        		<td class="header"> Cargo</td>
        		<td class="header"> UF</td>
        		<td class="header"> Município</td>
        		<td class="header"> Prioridade</td>
        		<td class="header"> Geocódigo</td>
        		<td class="header"> Espera</td>
        		<td class="header"> Ent</td>
        		<td class="header"> Cert</td>
        		<td class="header"> Rep</td>
			</tr>

            <tr>
			<%
			qtde = 0
            bgtr = 0
			while not RS.EOF
                Response.Write ("<tr class='c" & bgtr & "'>")
				qtde = qtde + 1
                Response.Write ("<td rowspan='2'>" & RS("TITULO")           & "</td>")
                Response.Write ("<td>" & RS("CODIGO_TURMA")     & "</td>")
                Response.Write ("<td>" & RS("DESCRICAO") & "</td>")
                Response.Write ("<td>" & formataData(RS("DT_INICIO_TURMA")) & "</td>")
                Response.Write ("<td>" & formataData(RS("DT_FIM_TURMA")) & "</td>")
                sql_professor = "SELECT NOME_FANTASIA FROM PROFESSORES WHERE ID_PROFESSOR='" & RS("ID_PROFESSOR")  & "'"
                RS1.Open sql_professor
                if not RS1.EOF then Response.Write ("<td>" & RS1("NOME_FANTASIA") & "</td>")  end if
                if     RS1.EOF then Response.Write ("<td>" & " - " & "</td>")  end if
                RS1.Close
                Response.Write ("<td>" & RS("CPF") & "</td>")
                Response.Write ("<td>" & RS("NOME") & "</td>")
                Response.Write ("<td>" & RS("UF_SIGLA") & "</td>")
                Response.Write ("<td>" & RS("NOME_CIDADE") & "</td>")
                Response.Write ("<td>" & RS("PRIORIDADE") & "</td>")
                if ( len(RS("COD_MUNI_IBGE")) = 5 ) then geocodigo = RS("COD_MUNI_IBGE")  end if
                if ( len(RS("COD_MUNI_IBGE")) = 4 ) then geocodigo = "0"    & RS("COD_MUNI_IBGE")  end if
                if ( len(RS("COD_MUNI_IBGE")) = 3 ) then geocodigo = "00"   & RS("COD_MUNI_IBGE")  end if
                if ( len(RS("COD_MUNI_IBGE")) = 2 ) then geocodigo = "000"  & RS("COD_MUNI_IBGE")  end if
                geocodigo = RS("COD_UF_IBGE") & geocodigo
                Response.Write ("<td>" & geocodigo & "</td>")
    			Response.Write ("</tr>")

                Response.Write ("<tr class='c" & bgtr & "'>")
                Response.Write ("<td>" & RS("EFETIVO") & "</td>")
            	sql_entidade = "SELECT DESCRICAO FROM TIPO_ENTIDADE WHERE ID_TIPO_ENTIDADE='" & RS("TIPOENTI") & "'"
            	RSSIM.Open sql_entidade
            	if not RSSIM.eof then
                    natureza_enti=RSSIM("DESCRICAO")
                else
            		natureza_enti=" - "
            	end if
            	RSSIM.Close
                Response.Write ("<td>" & natureza_enti & "</td>")
                Response.Write ("<td>" & RS("CARGO") & "</td>")
                sql_cidade_enti = "SELECT COD_UF_IBGE, COD_MUNI_IBGE, GEOCODIGO, UF_SIGLA, NOME_CIDADE, PRIORIDADE "    & _
                                  "       FROM BIOMA_CIDADE "                                                           & _
                                  " WHERE COD_UF_IBGE='"   & RS("COD_UF_IBGE")   & "' "                                 & _
                                  "   AND COD_MUNI_IBGE='" & RS("COD_MUNI_IBGE") & "'"
                RS1.Open sql_cidade_enti
                if not RS1.EOF then
                        Response.Write ("<td>" & RS1("UF_SIGLA") & "</td>")
                        Response.Write ("<td>" & RS1("NOME_CIDADE") & "</td>")
                        Response.Write ("<td>" & RS1("PRIORIDADE") & "</td>")
                        Response.Write ("<td>" & RS1("GEOCODIGO") & "</td>")
                end if
                if     RS1.EOF then
                        Response.Write ("<td>" & " - " & "</td>")
                end if
                RS1.Close
                Response.Write ("<td>" & "espera" & "</td>")
                Response.Write ("<td>" & RS("ENTURMADO") & "</td>")
                Response.Write ("<td>" & RS("CERTIFICADO") & "</td>")
                reprovado = "não"
                if ( RS("STATUS") =  "REPROVADO" )   then
                    reprovado = "sim"
                else
                    reprovado = " - "
                end if
                Response.Write ("<td>" & reprovado & "</td>")
                Response.Write ("</tr>")
                if ( bgtr = 0 ) then bgtr = 1 else bgtr = 0 end if
				RS.MoveNext
			wend
		end if
		RS.Close
 Response.Write "<br><br><b>Total de alunos selecionados: "
 Response.Write qtde
 Response.Write "</b><br><br>"
		%>
		</table>

	<%
    end if
'   ========<   FINAL DO LOOP DE ALUNOS    >========
    %>


    </div>
</div>
</body>
</html>



