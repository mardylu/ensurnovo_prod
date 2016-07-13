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

	<link rel="stylesheet" type="text/css" href="../css/styles1.css" />
	<link rel="stylesheet" type="text/css" href="../css/form1.css" />

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

		<table id="tabela01">
			<%
            if ( NOME = "ENSUR" )   then
                sql="SELECT COD_CURSO,TITULO FROM CURSO WHERE SIGA_PROJETO=" & SIGA_PROJETO & " ORDER BY TITULO"
            else
                sql = "SELECT c.cod_curso, c.titulo, t.codigo_turma, p.id_professor, p.nome,            " & _
                      "       t.dt_inicio_turma, t.dt_fim_turma                                         " & _
                      "  FROM curso as c                                                                " & _
                      "  JOIN turmas      as t ON t.cod_curso=c.cod_curso                               " & _
                      "  JOIN professores as p ON t.id_professor=p.id_professor                         " & _
                      " WHERE p.id_professor='" & ID_PROFESSOR  & "'"
            end if
' Response.write("SQL: " & sql & "<br>")
			RS.Open sql
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
                if ( NOME = "ENSUR" )   then
                    sql="SELECT id_turma, codigo_turma, dt_inicio_turma, dt_final_turma                     " & _
                        "  FROM turmas WHERE SIGA_PROJETO=" & SIGA_PROJETO & " ORDER BY cod_curso, codigo_turma"
                else
                    sql = "SELECT c.cod_curso, c.titulo, t.codigo_turma, p.id_professor, p.nome,            " & _
                          "       t.id_turma, t.dt_inicio_turma, t.dt_fim_turma                             " & _
                          "  FROM curso as c                                                                " & _
                          "  JOIN turmas      as t ON t.cod_curso=c.cod_curso                               " & _
                          "  JOIN professores as p ON t.id_professor=p.id_professor                         " & _
                          " WHERE p.id_professor='" & ID_PROFESSOR  & "'                                    " & _
                          " ORDER BY c.titulo ASC, dt_inicio_turma DESC"
                end if
            else
                if ( NOME = "ENSUR" )   then
                    sql="SELECT id_turma, codigo_turma, dt_inicio_turma, dt_final_turma                     " & _
                        "  FROM turmas WHERE SIGA_PROJETO=" & SIGA_PROJETO & " ORDER BY cod_curso, codigo_turma"
                else
                    sql = "SELECT c.cod_curso, c.titulo, t.codigo_turma, p.id_professor, p.nome,            " & _
                          "       t.id_turma, t.dt_inicio_turma, t.dt_fim_turma                             " & _
                          "  FROM curso as c                                                                " & _
                          "  JOIN turmas      as t ON t.cod_curso=c.cod_curso                               " & _
                          "  JOIN professores as p ON t.id_professor=p.id_professor                         " & _
                          " WHERE p.id_professor='" & ID_PROFESSOR  & "'                                    " & _
                          "   AND c.cod_curso='" & curso & "'                                               " & _
                          " ORDER BY c.titulo ASC, dt_inicio_turma DESC"
                end if
            end if
' Response.write("SQL: " & sql & "<br>")

            RS.Open sql
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
            <p>
                <label for="DataInicio">Período - Início</label>
			    <select name="ini_mes" id="ini_mes" >
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
                <%  i = mid(Date(),7,4) + 1  %>
                <select name="ini_ano" id="ini_ano" >
                <%
                Do until i=2000
                    Response.Write "<option value='" & i - 1 & "'"
                    i = i - 1
                    if ( i = 2015 ) then Response.Write (" selected ") end if
                    Response.Write "> " & i
                    Response.Write "</option>"
                Loop
                %>
                </select>
            </p>
            <p>
                <label for="DataFinal">Período - Final</label>
			    <select name="fim_mes" id="fim_mes" >
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
                <%  i = mid(Date(),7,4) + 1  %>
                <select name="fim_ano" id="fim_ano" >
                <%
                i = 2021
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

        </tr>
		</table>
		</form>





			<%
		    sql = "SELECT TU.CODIGO_TURMA,TU.ID_TURMA,C.COD_CURSO,T.DESCRICAO AS TDESC,S.DESCRICAO AS SDESC,        " & _
                  "       C.TITULO, TU.DT_INICIO_TURMA,TU.DT_FIM_TURMA,TU.VALOR,TU.LUGAR,TU.HORARIO,                " & _
                  "       C.COD_STATUS,TU.EMENTA FROM TURMAS TU                                                     " & _
                  "  JOIN CURSO C           ON TU.COD_CURSO=C.COD_CURSO                                             " & _
                  "  JOIN CURSO_STATUS S    ON C.COD_STATUS=S.COD_STATUS                                            " & _
                  "  JOIN CURSO_TIPO T      ON C.COD_TIPO=T.COD_TIPO                                                " & _
                  " WHERE TU.COD_STATUS_TURMA>1 AND TU.COD_STATUS_TURMA<>4                                          " & _
                  "                             AND C.COD_STATUS=1                                                  " & _
                  "                             AND TU.ID_PROFESSOR='" & session("id") & "'                         " & _
                  " ORDER BY TU.DT_INICIO_TURMA DESC"

            if (NOME="ENSUR")  then
			    sql =   "SELECT TU.CODIGO_TURMA,TU.ID_TURMA,C.COD_CURSO,T.DESCRICAO AS TDESC,S.DESCRICAO AS SDESC,  " & _
                        "       C.TITULO,TU.DT_INICIO_TURMA,TU.DT_FIM_TURMA,TU.VALOR,TU.LUGAR,TU.HORARIO,           " & _
                        "       C.COD_STATUS,TU.EMENTA                                                              " & _
                        " FROM TURMAS TU    JOIN CURSO C        ON TU.COD_CURSO=C.COD_CURSO                         " & _
                                           "JOIN CURSO_STATUS S ON C.COD_STATUS=S.COD_STATUS                        " & _
                                           "JOIN CURSO_TIPO T   ON C.COD_TIPO=T.COD_TIPO                            " & _
                        " WHERE TU.COD_STATUS_TURMA>1 AND TU.COD_STATUS_TURMA<>4                                    " & _
                                                    " AND C.COD_STATUS=1                                            " & _
                        " ORDER BY C.TITULO ASC, TU.DT_INICIO_TURMA DESC"
            else
			    sql =   "SELECT TU.CODIGO_TURMA,TU.ID_TURMA,C.COD_CURSO,T.DESCRICAO AS TDESC,S.DESCRICAO AS SDESC,  " & _
                        "       C.TITULO,TU.DT_INICIO_TURMA,TU.DT_FIM_TURMA,TU.VALOR,TU.LUGAR,TU.HORARIO,           " & _
                        "       C.COD_STATUS,TU.EMENTA                                                              " & _
                        " FROM TURMAS TU    JOIN CURSO C ON TU.COD_CURSO=C.COD_CURSO                                " & _
                                           "JOIN CURSO_STATUS S ON C.COD_STATUS=S.COD_STATUS                        " & _
                                           "JOIN CURSO_TIPO T ON C.COD_TIPO=T.COD_TIPO                              " & _
                        " WHERE TU.COD_STATUS_TURMA>1 AND TU.COD_STATUS_TURMA<>4                                    " & _
                                                    " AND C.COD_STATUS=1                                            " & _
                                                    " AND TU.ID_PROFESSOR='" & session("id") & "'                   " & _
                        " ORDER BY C.TITULO ASC, TU.DT_INICIO_TURMA DESC"
            end if

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
							|<a href="alunos_prof_notas.asp?id_turma=<% =ID_TURMA %>"> Notas </a>
							|<a href="alunos_prof_resultado.asp?id_turma=<% =ID_TURMA %>&op=1"> Resultado Final</a> 
							|<a href="alunos_prof.asp?cod=<% =ID_TURMA %>"> Alunos</a>
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



