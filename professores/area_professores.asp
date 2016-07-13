<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!-- #INCLUDE FILE="../library/parametros.asp" -->
<!-- #INCLUDE FILE="../library/conOpen.asp" -->
<!-- #INCLUDE FILE="../library/conOpenSIM.asp" -->
<!-- #INCLUDE FILE="../library/fErroMsg.asp" -->
<!-- #INCLUDE FILE="../library/fFormataValor.asp" -->
<!-- #INCLUDE FILE="../library/fPagamentos.asp" -->
<!-- #INCLUDE FILE="../library/fData.asp" -->

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
    <meta http-equiv="Pragma" content="no-cache" />
    <meta http-equiv="Expires" content="0" />

	<link rel="stylesheet" type="text/css" href="../css/styles1.css" />
	<link rel="stylesheet" type="text/css" href="../css/form1.css" />

<%

    ' SIGA_PROJETO = request("SIGA_PROJETO")

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

<script type="text/javascript">
	function submitForm() {

		//document.parcForm.submit();
		return false;
	}

	tinyMCE.init({
		// General options
		mode : "exact",
		elements : "info",
		theme : "advanced",
		plugins : "autolink,lists,advlink,contextmenu,paste,directionality,fullscreen,noneditable,nonbreaking,inlinepopups",

		// Theme options
		theme_advanced_buttons1 : "bold,italic,underline,strikethrough,|,bullist,numlist,|,outdent,indent,blockquote,|,undo,redo,|,link,unlink,|,code,fullscreen",
		theme_advanced_buttons2 : "",
		theme_advanced_buttons3 : "",
		theme_advanced_buttons4 : "",
		theme_advanced_toolbar_location : "top",
		theme_advanced_toolbar_align : "left",
		theme_advanced_statusbar_location : "bottom",
		theme_advanced_resizing : true
	});
	function openWindow2(opcao) {
		if (opcao == 's') {
			myVar=open('esqueci_prof.asp','Senha','scrollbars=yes,width=300,height=140');
		}
		if (opcao == 'c') {
			myVar=open('cad_professores1.asp','Senha','scrollbars=yes,width=1324,height=800');
		}
	}

	 function newDoc1(curso) {
		curso       = document.form.curso.value;
		turma       = document.form.turma.value;
		ini_mes     = document.form.ini_mes.value;
		ini_ano     = document.form.ini_ano.value;
		fim_mes     = document.form.fim_mes.value;
		fim_ano     = document.form.fim_ano.value;
		url = 'area_professores.asp?';
        url = url + 'curso='      + curso      + '&';
        url = url + 'turma='      + turma      + '&';
        url = url + 'ini_mes='    + ini_mes    + '&';
        url = url + 'ini_ano='    + ini_ano    + '&';
        url = url + 'fim_mes='    + fim_mes    + '&';
        url = url + 'fim_ano='    + fim_ano;
        window.location=url;
	 }
	 function newDoc2(turma) {
		curso       = document.form.curso.value;
		turma       = document.form.turma.value;
		ini_mes     = document.form.ini_mes.value;
		ini_ano     = document.form.ini_ano.value;
		fim_mes     = document.form.fim_mes.value;
		fim_ano     = document.form.fim_ano.value;
		url = 'area_professores.asp?';
        url = url + 'curso='      + curso      + '&';
        url = url + 'turma='      + turma      + '&';
        url = url + 'ini_mes='    + ini_mes    + '&';
        url = url + 'ini_ano='    + ini_ano    + '&';
        url = url + 'fim_mes='    + fim_mes    + '&';
        url = url + 'fim_ano='    + fim_ano;
        window.location=url;
	 }
	 function newDoc3(ini_mes) {
		curso       = document.form.curso.value;
		turma       = document.form.turma.value;
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
		url = 'area_professores.asp?';
        url = url + 'curso='      + curso      + '&';
        url = url + 'turma='      + turma      + '&';
        url = url + 'ini_mes='    + ini_mes    + '&';
        url = url + 'ini_ano='    + ini_ano    + '&';
        url = url + 'fim_mes='    + fim_mes    + '&';
        url = url + 'fim_ano='    + fim_ano;
		window.location=url;
	 }
	 function newDoc4(ini_ano) {
// alert ("Ini Ano: " + ini_ano )
		curso       = document.form.curso.value;
		turma       = document.form.turma.value;
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
		url = 'area_professores.asp?';
        url = url + 'curso='      + curso      + '&';
        url = url + 'turma='      + turma      + '&';
        url = url + 'ini_mes='    + ini_mes    + '&';
        url = url + 'ini_ano='    + ini_ano    + '&';
        url = url + 'fim_mes='    + fim_mes    + '&';
        url = url + 'fim_ano='    + fim_ano;
		window.location=url;
	 }
	 function newDoc5(fim_mes) {
		curso       = document.form.curso.value;
		turma       = document.form.turma.value;
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
		url = 'area_professores.asp?';
        url = url + 'curso='      + curso      + '&';
        url = url + 'turma='      + turma      + '&';
        url = url + 'ini_mes='    + ini_mes    + '&';
        url = url + 'ini_ano='    + ini_ano    + '&';
        url = url + 'fim_mes='    + fim_mes    + '&';
        url = url + 'fim_ano='    + fim_ano;
		window.location=url;
	 }
	 function newDoc6(fim_ano) {
		curso       = document.form.curso.value;
		turma       = document.form.turma.value;
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
		url = 'area_professores.asp?';
        url = url + 'curso='      + curso      + '&';
        url = url + 'turma='      + turma      + '&';
        url = url + 'ini_mes='    + ini_mes    + '&';
        url = url + 'ini_ano='    + ini_ano    + '&';
        url = url + 'fim_mes='    + fim_mes    + '&';
        url = url + 'fim_ano='    + fim_ano;
		window.location=url;
	 }

	</script>

<title>ENSUR Inscrições</title>
</head>
<body>
<div id="pagina">
	<!-- #INCLUDE FILE="../include/topo_professores.asp" -->
	<div id="conteudo">
		<h1>ÁREA DO PROFESSOR</h1>
		<%if session("pass")<>"ok" then%>
			<br>
<!----		<p>Incluir texto explicativo.</p>   ---->
			<p><a href="javascript:openWindow2('c');">Caso ainda não esteja cadastrado, e queira se cadastrar como professor do IBAM clique aqui...</a></p>

			<br>
			<form action="login_professores.asp" method="post" name="login">
			<fieldset>
				<legend>entre com seus dados</legend>
				<p><label for="CPF" class="requerido">CPF</label><input type="text" name="CPF" id="CPF" maxlength="11" size="12" onKeyPress="return ValidateKeyPressed('INT', this, event);"> somente números</p>
				<p><label for="SENHA" class="requerido">Senha</label><input type="password" name="SENHA" id="SENHA" maxlength="20" size="12"></p>
				<p><label for="ENVIAR">&nbsp;</label><input type="submit" name="submit" value="Enviar" class="buttonF">
				<p><a href="javascript:openWindow2('s');">Esqueci minha senha</a></p>
<!----				<p><a href="javascript:openWindow2('c');">Caso ainda não esteja cadastrado, e queira se cadastrar como professor do IBAM <b>clique aqui</b></a></p>  ---->
			</fieldset>
			</form>
		<%
		else
			IF session("id") <> "" then
			else
				session("id") = request("ID_PROFESSOR")
			end if

            curso = request("curso")
            turma = request("turma")
            ini_mes = request("ini_mes")
            ini_ano = request("ini_ano")
            fim_mes = request("fim_mes")
            fim_ano = request("fim_ano")

    		if curso=""         or isNumeric(curso)=false       then curso=0
    		if turma=""         or isNumeric(turma)=false       then turma=0
    		if ini_mes  =""     or isNumeric(ini_mes)=false     then ini_mes=0      end if
    		if ini_ano  =""     or isNumeric(ini_ano)=false     then ini_ano=2015   end if
    		if fim_mes  =""     or isNumeric(fim_mes)=false     then fim_mes=0      end if
    		if fim_ano  =""     or isNumeric(fim_ano)=false     then fim_ano=9999   end if

			sql = "SELECT ID_PROFESSOR, NOME,CPF FROM PROFESSORES WHERE ID_PROFESSOR="&session("id")
			RS.Open sql
				if RS.EOF then
					%><p>Seu cadastro não foi encontrado em nossa base. Faça um novo login. Caso o erro persista, favor entrar em contato com o IBAM.</p><%
				else
					ID_PROFESSOR = RS("ID_PROFESSOR")
                    NOME = RS("NOME")
					CPF = RS("CPF")
				end if
			RS.Close
			%>
			<p><br /></p>
			<h2><%=NOME%></h2>
			<p><br /></p>

		<form name="form" action="area_professores.asp" method="get">

		<table border="0" width="100%" cellpadding="0" cellspacing="0">
			<%
            if ( NOME = "ENSUR" )   then
                sql="SELECT DISTINCT(COD_CURSO),TITULO FROM CURSO WHERE SIGA_PROJETO=1 ORDER BY TITULO"
            else
                sql = "SELECT distinct(c.cod_curso), c.titulo                                           " & _
                      "  FROM curso as c                                                                " & _
                      "  JOIN turmas      as t ON t.cod_curso=c.cod_curso                               " & _
                      "  JOIN professores as p ON t.id_professor=p.id_professor                         " & _
                      " WHERE T.COD_STATUS_TURMA>1 AND T.COD_STATUS_TURMA<>4                            " & _
                      "   AND p.id_professor='" & ID_PROFESSOR  & "'"                                     & _
                      " ORDER BY c.titulo"
            end if
' Response.write("SQL: " & sql & "<br>")
			RS.Open sql
			%>
			<tr>
            <td width="15%" align="right"><span style="font-weight: bold">Curso</span></td>
            <td width="85%">
            <select name="curso" id="curso" onchange="newDoc1(this.value);">
			<option></option>
			<%while not RS.eof%>
				<option value="<% =RS("COD_CURSO") %>" <% if int(curso)=RS("COD_CURSO") then %> selected <% end if %>><% =RS("TITULO") %></option><%
				RS.movenext
			wend
			RS.close
			%>
			</select>
            </td>
            </tr>

			<tr>
			<td width="15%" align="right"><span style="font-weight: bold">Turma</span></td>
            <td width="85%">
   			<%

            if ( curso = 0 )    then
                if ( NOME = "ENSUR" )   then
                    sql="SELECT id_turma, codigo_turma, dt_inicio_turma, dt_fim_turma                       " & _
                       "  FROM turmas WHERE SIGA_PROJETO=1 ORDER BY codigo_turma"
                else
                    sql = "SELECT c.cod_curso, c.titulo, t.codigo_turma, p.id_professor, p.nome,            " & _
                          "       t.id_turma, t.dt_inicio_turma, t.dt_fim_turma                             " & _
                          "  FROM curso as c                                                                " & _
                          "  JOIN turmas      as t ON t.cod_curso=c.cod_curso                               " & _
                          "  JOIN professores as p ON t.id_professor=p.id_professor                         " & _
                          " WHERE T.COD_STATUS_TURMA>1 AND T.COD_STATUS_TURMA<>4                            " & _
                          "   AND p.id_professor='" & ID_PROFESSOR  & "'                                    " & _
                          " ORDER BY t.codigo_turma"
                end if
            else
                if ( NOME = "ENSUR" )   then
                    sql="SELECT id_turma, codigo_turma, dt_inicio_turma, dt_fim_turma                       " & _
                        "  FROM turmas WHERE SIGA_PROJETO=1 ORDER BY codigo_turma"
                else
                    sql = "SELECT c.cod_curso, c.titulo, t.codigo_turma, p.id_professor, p.nome,            " & _
                          "       t.id_turma, t.dt_inicio_turma, t.dt_fim_turma                             " & _
                          "  FROM curso as c                                                                " & _
                          "  JOIN turmas      as t ON t.cod_curso=c.cod_curso                               " & _
                          "  JOIN professores as p ON t.id_professor=p.id_professor                         " & _
                          " WHERE p.id_professor='" & ID_PROFESSOR  & "'                                    " & _
                          "   AND c.cod_curso='" & curso & "'                                               " & _
                          " ORDER BY  t.codigo_turma"
                end if
            end if
' Response.write("SQL: " & sql & "<br>")
            RS.Open sql
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
            </td>
            </tr>

			<tr>
                <td width="15%" align="right"><span style="font-weight: bold">Período - Início</span></td>
			    <td width="85%"><select name="ini_mes" id="ini_mes" onchange="newDoc3(this.value);">
                <%
                Dim i
                For i=0 to 13
                    if i < 10   then ix="0"&i else ix=i  end if
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
                <%  i = mid(Date(),7,4)  %>
                <select name="ini_ano" id="ini_ano" onchange="newDoc4(this.value);">
                <%
                if ( ini_ano = 0 )  then ini_ano=i  end if
                Do until i=2000
                    Response.Write "<option value='" & i & "'"
                    if ( i = cint(ini_ano) ) then Response.Write (" selected ") end if
                    Response.Write "> " & i
                    Response.Write "</option>"
                    i = i - 1
                Loop
                %>
                </select>
                </td>
			</tr>


			<tr>
                <td width="15%" align="right"><span style="font-weight: bold">Período - Final</span></td>
			    <td width="85%"><select name="fim_mes" id="fim_mes" onchange="newDoc5(this.value);">
                <%
                For i=0 to 13
                    if i < 10   then ix="0"&i  else ix=i end if
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
                <%  i = mid(Date(),7,4)  %>
                <select name="fim_ano" id="fim_ano"  onchange="newDoc6(this.value);">
                <%
                i = 2021
                Do until i=2000
                    Response.Write "<option value=" & i
                    if ( cint(fim_ano) = i ) then Response.Write (" selected ") end if
                    Response.Write "> " & i
                    Response.Write "</option>"
                    i = i - 1
                Loop
                %>
                </select>
            </td>
        </tr>
		</table>
		</form>

        <br>



			<%
            sql_where = ""
            if ( curso <> 0 )   then
                sql_where = " AND C.COD_CURSO='" & curso & "' "
            end if
            if ( turma <> 0 )   then
                sql_where = sql_where & " AND TU.ID_TURMA='" & turma & "' "
            end if

            sql_datas   = ""
            if len(ini_mes) = 1 then ini_mes = "0" & ini_mes    end if
            if len(fim_mes) = 1 then fim_mes = "0" & fim_mes    end if
            data_inicio = ini_ano & ini_mes & "00"
            data_final  = fim_ano & fim_mes & "99"
            sql_datas   = " AND TU.DT_INICIO_TURMA > " & data_inicio & " AND TU.DT_FIM_TURMA < " & data_final

		    sql = "SELECT TU.CODIGO_TURMA,TU.ID_TURMA,C.COD_CURSO,T.DESCRICAO AS TDESC,S.DESCRICAO AS SDESC,        " & _
                  "       C.TITULO, TU.DT_INICIO_TURMA,TU.DT_FIM_TURMA,TU.VALOR,TU.LUGAR,TU.HORARIO,                " & _
                  "       C.COD_STATUS,TU.EMENTA FROM TURMAS TU                                                     " & _
                  "  JOIN CURSO C           ON TU.COD_CURSO=C.COD_CURSO                                             " & _
                  "  JOIN CURSO_STATUS S    ON C.COD_STATUS=S.COD_STATUS                                            " & _
                  "  JOIN CURSO_TIPO T      ON C.COD_TIPO=T.COD_TIPO                                                " & _
                  " WHERE TU.COD_STATUS_TURMA>1 AND TU.COD_STATUS_TURMA<>4                                          " & _
                  "                             AND C.COD_STATUS=1                                                  " & _
                  "                             AND TU.ID_PROFESSOR='" & session("id") & "'                         " & _
                  "                             AND TU.DT_INICIO_TURMA > " & data_inicio & "                        " & _
                  "                             AND TU.DT_FIM_TURMA < " & data_final
            if ( ( curso <> 0 ) OR ( turma <> 0) )then sql = sql & sql_where
'           sql = sql & sql_datas
            sql = sql & " ORDER BY C.TITULO ASC, TU.DT_INICIO_TURMA ASC"

            if (NOME="ENSUR")  then
			    sql =   "SELECT TU.CODIGO_TURMA,TU.ID_TURMA,C.COD_CURSO,T.DESCRICAO AS TDESC,S.DESCRICAO AS SDESC,  " & _
                        "       C.TITULO,TU.DT_INICIO_TURMA,TU.DT_FIM_TURMA,TU.VALOR,TU.LUGAR,TU.HORARIO,           " & _
                        "       C.COD_STATUS,TU.EMENTA                                                              " & _
                        " FROM TURMAS TU    JOIN CURSO C        ON TU.COD_CURSO=C.COD_CURSO                         " & _
                                           "JOIN CURSO_STATUS S ON C.COD_STATUS=S.COD_STATUS                        " & _
                                           "JOIN CURSO_TIPO T   ON C.COD_TIPO=T.COD_TIPO                            " & _
                        " WHERE TU.COD_STATUS_TURMA>1 AND TU.COD_STATUS_TURMA<>4                                    " & _
                        "                             AND TU.SIGA_PROJETO=1                                         " & _
                        "                             AND C.COD_STATUS=1                                            " & _
                        "                             AND TU.DT_INICIO_TURMA > " & data_inicio & "                  " & _
                        "                             AND TU.DT_FIM_TURMA < " & data_final
                if ( ( curso <> 0 ) OR ( turma <> 0) )then sql = sql & sql_where
                sql = sql & " ORDER BY C.TITULO ASC, TU.DT_INICIO_TURMA ASC"
            else
			    sql =   "SELECT TU.CODIGO_TURMA,TU.ID_TURMA,C.COD_CURSO,T.DESCRICAO AS TDESC,S.DESCRICAO AS SDESC,  " & _
                        "       C.TITULO,TU.DT_INICIO_TURMA,TU.DT_FIM_TURMA,TU.VALOR,TU.LUGAR,TU.HORARIO,           " & _
                        "       C.COD_STATUS,TU.EMENTA, TU.SIGA_PROJETO                                             " & _
                        " FROM TURMAS TU    JOIN CURSO C ON TU.COD_CURSO=C.COD_CURSO                                " & _
                                           "JOIN CURSO_STATUS S ON C.COD_STATUS=S.COD_STATUS                        " & _
                                           "JOIN CURSO_TIPO T ON C.COD_TIPO=T.COD_TIPO                              " & _
                        " WHERE TU.COD_STATUS_TURMA>1 AND TU.COD_STATUS_TURMA<>4                                    " & _
                                                    " AND TU.SIGA_PROJETO<>1                                        " & _
                                                    " AND C.COD_STATUS=1                                            " & _
                                                    " AND TU.ID_PROFESSOR='" & session("id") & "'                   " & _
                                                    " AND TU.DT_INICIO_TURMA > " & data_inicio & "                  " & _
                                                    " AND TU.DT_FIM_TURMA < " & data_final
                if ( ( curso <> 0 ) OR ( turma <> 0) )then sql = sql & sql_where
                sql = sql & " ORDER BY C.TITULO ASC, TU.DT_INICIO_TURMA ASC"
            end if

' Response.write("SQL: " & sql & "<br>")


			RS.Open sql

			if RS.EOF then
				%><p>Você não está ministrando nenhum curso no momento.</p><%
			else
				%>
				<p>Você está ministrando os seguintes cursos</p>
				<%
				while not RS.EOF
					ID_TURMA=RS("ID_TURMA")
					%>
					<table id="tab_curso">
						<tbody>
							<tr><td class="clabel">Curso</td><td class="data"><%=RS("TITULO")%></td></tr>
							<tr><td class="clabel">Turma</td><td class="data"><%=RS("CODIGO_TURMA")%></td></tr>
							<tr><td class="clabel">Status</td><td class="data"><%=RS("SDESC")%></td></tr>
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
							<tr><td> </td><td></td></tr>
							<tr><td class="clabel">Ações: </td>
							<td>
							|<a href="alunos_prof_frequencia.asp?id_turma=<% =ID_TURMA %>&op=0"> Frequência</a>
							|<a href="alunos_prof_atualiza.asp?id_turma=<% =ID_TURMA %>&cod_curso=<% =RS("COD_CURSO") %>&lanc_geral=sim"> Notas e Resultado Final</a>
							|<a href="alunos_prof.asp?cod_curso=<% =RS("COD_CURSO") %>&cod=<% =ID_TURMA %>"> Alunos</a>
							|</td></tr>
						</tbody>
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
		<p><br></p>
	</div>
	<!-- #INCLUDE FILE="../include/footer.asp" -->
</div>
</body>
</html>
<%conClose%>



