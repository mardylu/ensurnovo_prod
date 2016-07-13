<%If session("key_ver")<>"ok" Then Response.Redirect "logout.asp"%>
<!-- #INCLUDE FILE="../library/parametros.asp" -->
<!-- #INCLUDE FILE="../library/conOpen.asp" -->
<!-- #INCLUDE FILE="../library/conOpenSIM.asp" -->
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
		st           = document.form.st.value;
		stt          = document.form.stt.value;
		curso        = document.form.curso.value;
		tipo_enti    = document.form.tipo_enti.value;
		escolar      = document.form.escolar.value;
		termo        = document.form.termo.value;
		bioma        = document.form.bioma.value;
		servico      = document.form.servico.value;
		ini_mes      = document.form.ini_mes.value;
		ini_ano      = document.form.ini_ano.value;
		fim_mes      = document.form.fim_mes.value;
		fim_ano      = document.form.fim_ano.value;
		url = 'gestao_turmas_pqga.asp?';
		url = url + 'st='         + st         + '&';
		url = url + 'stt='        + stt        + '&';
        url = url + 'curso='      + curso      + '&';
        url = url + 'tipo_enti='  + tipo_enti  + '&';
        url = url + 'escolar='    + escolar    + '&';
        url = url + 'termo='      + termo      + '&';
        url = url + 'bioma='      + bioma      + '&';
        url = url + 'servico='    + servico    + '&';
        url = url + 'ini_mes='    + ini_mes    + '&';
        url = url + 'ini_ano='    + ini_ano    + '&';
        url = url + 'fim_mes='    + fim_mes    + '&';
        url = url + 'fim_ano='    + fim_ano;
		window.location=url;
	 }
	 function newDoc2(st) {
		st           = document.form.st.value;
		stt          = document.form.stt.value;
		curso        = document.form.curso.value;
		tipo_enti    = document.form.tipo_enti.value;
		escolar      = document.form.escolar.value;
		termo        = document.form.termo.value;
		bioma        = document.form.bioma.value;
		servico      = document.form.servico.value;
		ini_mes      = document.form.ini_mes.value;
		ini_ano      = document.form.ini_ano.value;
		fim_mes      = document.form.fim_mes.value;
		fim_ano      = document.form.fim_ano.value;
		url = 'gestao_turmas_pqga.asp?';
		url = url + 'st='         + st         + '&';
		url = url + 'stt='        + stt        + '&';
        url = url + 'curso='      + curso      + '&';
        url = url + 'tipo_enti='  + tipo_enti  + '&';
        url = url + 'escolar='    + escolar    + '&';
        url = url + 'termo='      + termo      + '&';
        url = url + 'bioma='      + bioma      + '&';
        url = url + 'servico='    + servico    + '&';
        url = url + 'ini_mes='    + ini_mes    + '&';
        url = url + 'ini_ano='    + ini_ano    + '&';
        url = url + 'fim_mes='    + fim_mes    + '&';
        url = url + 'fim_ano='    + fim_ano;
		window.location=url;
	 }
	 function newDoc3(stt) {
		st           = document.form.st.value;
		stt          = document.form.stt.value;
		curso        = document.form.curso.value;
		tipo_enti    = document.form.tipo_enti.value;
		escolar      = document.form.escolar.value;
		termo        = document.form.termo.value;
		bioma        = document.form.bioma.value;
		servico      = document.form.servico.value;
		ini_mes      = document.form.ini_mes.value;
		ini_ano      = document.form.ini_ano.value;
		fim_mes      = document.form.fim_mes.value;
		fim_ano      = document.form.fim_ano.value;
		url = 'gestao_turmas_pqga.asp?';
		url = url + 'st='         + st         + '&';
		url = url + 'stt='        + stt        + '&';
        url = url + 'curso='      + curso      + '&';
        url = url + 'tipo_enti='  + tipo_enti  + '&';
        url = url + 'escolar='    + escolar    + '&';
        url = url + 'termo='      + termo      + '&';
        url = url + 'bioma='      + bioma      + '&';
        url = url + 'servico='    + servico    + '&';
        url = url + 'ini_mes='    + ini_mes    + '&';
        url = url + 'ini_ano='    + ini_ano    + '&';
        url = url + 'fim_mes='    + fim_mes    + '&';
        url = url + 'fim_ano='    + fim_ano;
		window.location=url;
	 }
	 function newDoc4(ini_mes) {
		st           = document.form.st.value;
		stt          = document.form.stt.value;
		curso        = document.form.curso.value;
		tipo_enti    = document.form.tipo_enti.value;
		escolar      = document.form.escolar.value;
		termo        = document.form.termo.value;
		bioma        = document.form.bioma.value;
		servico      = document.form.servico.value;
		ini_mes      = document.form.ini_mes.value;
		ini_ano      = document.form.ini_ano.value;
		fim_mes      = document.form.fim_mes.value;
		fim_ano      = document.form.fim_ano.value;
		url = 'gestao_turmas_pqga.asp?';
		url = url + 'st='         + st         + '&';
		url = url + 'stt='        + stt        + '&';
        url = url + 'curso='      + curso      + '&';
        url = url + 'tipo_enti='  + tipo_enti  + '&';
        url = url + 'escolar='    + escolar    + '&';
        url = url + 'termo='      + termo      + '&';
        url = url + 'bioma='      + bioma      + '&';
        url = url + 'servico='    + servico    + '&';
        url = url + 'ini_mes='    + ini_mes    + '&';
        url = url + 'ini_ano='    + ini_ano    + '&';
        url = url + 'fim_mes='    + fim_mes    + '&';
        url = url + 'fim_ano='    + fim_ano;
        ini_data = ini_ano + ini_mes;
        fim_data = fim_ano + fim_mes;
        if (fim_data < ini_data) {
            window.alert ("A data final de pesquisa é menor do que a data inicial");
        }
		window.location=url;
	 }

	 function newDoc5(ini_ano) {
		st           = document.form.st.value;
		stt          = document.form.stt.value;
		curso        = document.form.curso.value;
		tipo_enti    = document.form.tipo_enti.value;
		escolar      = document.form.escolar.value;
		termo        = document.form.termo.value;
		bioma        = document.form.bioma.value;
		servico      = document.form.servico.value;
		ini_mes      = document.form.ini_mes.value;
		ini_ano      = document.form.ini_ano.value;
		fim_mes      = document.form.fim_mes.value;
		fim_ano      = document.form.fim_ano.value;
		url = 'gestao_turmas_pqga.asp?';
		url = url + 'st='         + st         + '&';
		url = url + 'stt='        + stt        + '&';
        url = url + 'curso='      + curso      + '&';
        url = url + 'tipo_enti='  + tipo_enti  + '&';
        url = url + 'escolar='    + escolar    + '&';
        url = url + 'termo='      + termo      + '&';
        url = url + 'bioma='      + bioma      + '&';
        url = url + 'servico='    + servico    + '&';
        url = url + 'ini_mes='    + ini_mes    + '&';
        url = url + 'ini_ano='    + ini_ano    + '&';
        url = url + 'fim_mes='    + fim_mes    + '&';
        url = url + 'fim_ano='    + fim_ano;
        ini_data = ini_ano + ini_mes;
        fim_data = fim_ano + fim_mes;
        if (fim_data < ini_data) {
            window.alert ("A data final de pesquisa é menor do que a data inicial");
        }
		window.location=url;
	 }
	 function newDoc6(fim_mes) {
		st           = document.form.st.value;
		stt          = document.form.stt.value;
		curso        = document.form.curso.value;
		tipo_enti    = document.form.tipo_enti.value;
		escolar      = document.form.escolar.value;
		termo        = document.form.termo.value;
		bioma        = document.form.bioma.value;
		servico      = document.form.servico.value;
		ini_mes      = document.form.ini_mes.value;
		ini_ano      = document.form.ini_ano.value;
		fim_mes      = document.form.fim_mes.value;
		fim_ano      = document.form.fim_ano.value;
		url = 'gestao_turmas_pqga.asp?';
		url = url + 'st='         + st         + '&';
		url = url + 'stt='        + stt        + '&';
        url = url + 'curso='      + curso      + '&';
        url = url + 'tipo_enti='  + tipo_enti  + '&';
        url = url + 'escolar='    + escolar    + '&';
        url = url + 'termo='      + termo      + '&';
        url = url + 'bioma='      + bioma      + '&';
        url = url + 'servico='    + servico    + '&';
        url = url + 'ini_mes='    + ini_mes    + '&';
        url = url + 'ini_ano='    + ini_ano    + '&';
        url = url + 'fim_mes='    + fim_mes    + '&';
        url = url + 'fim_ano='    + fim_ano;
        ini_data = ini_ano + ini_mes;
        fim_data = fim_ano + fim_mes;
        if (fim_data < ini_data) {
            window.alert ("A data final de pesquisa é menor do que a data inicial");
        }
		window.location=url;
	 }
	 function newDoc7(fim_ano) {
		st           = document.form.st.value;
		stt          = document.form.stt.value;
		curso        = document.form.curso.value;
		tipo_enti    = document.form.tipo_enti.value;
		escolar      = document.form.escolar.value;
		termo        = document.form.termo.value;
		bioma        = document.form.bioma.value;
		servico      = document.form.servico.value;
		ini_mes      = document.form.ini_mes.value;
		ini_ano      = document.form.ini_ano.value;
		fim_mes      = document.form.fim_mes.value;
		fim_ano      = document.form.fim_ano.value;
		url = 'gestao_turmas_pqga.asp?';
		url = url + 'st='         + st         + '&';
		url = url + 'stt='        + stt        + '&';
        url = url + 'curso='      + curso      + '&';
        url = url + 'tipo_enti='  + tipo_enti  + '&';
        url = url + 'escolar='    + escolar    + '&';
        url = url + 'termo='      + termo      + '&';
        url = url + 'bioma='      + bioma      + '&';
        url = url + 'servico='    + servico    + '&';
        url = url + 'ini_mes='    + ini_mes    + '&';
        url = url + 'ini_ano='    + ini_ano    + '&';
        url = url + 'fim_mes='    + fim_mes    + '&';
        url = url + 'fim_ano='    + fim_ano;
        ini_data = ini_ano + ini_mes;
        fim_data = fim_ano + fim_mes;
        if (fim_data < ini_data) {
            window.alert ("A data final de pesquisa é menor do que a data inicial");
        }
		window.location=url;
	 }
	 function newDoc8(escolar) {
		st           = document.form.st.value;
		stt          = document.form.stt.value;
		curso        = document.form.curso.value;
		tipo_enti    = document.form.tipo_enti.value;
		escolar      = document.form.escolar.value;
		termo        = document.form.termo.value;
		bioma        = document.form.bioma.value;
		servico      = document.form.servico.value;
		ini_mes      = document.form.ini_mes.value;
		ini_ano      = document.form.ini_ano.value;
		fim_mes      = document.form.fim_mes.value;
		fim_ano      = document.form.fim_ano.value;
		url = 'gestao_turmas_pqga.asp?';
		url = url + 'st='         + st         + '&';
		url = url + 'stt='        + stt        + '&';
        url = url + 'curso='      + curso      + '&';
        url = url + 'tipo_enti='  + tipo_enti  + '&';
        url = url + 'escolar='    + escolar    + '&';
        url = url + 'termo='      + termo      + '&';
        url = url + 'bioma='      + bioma      + '&';
        url = url + 'servico='    + servico    + '&';
        url = url + 'ini_mes='    + ini_mes    + '&';
        url = url + 'ini_ano='    + ini_ano    + '&';
        url = url + 'fim_mes='    + fim_mes    + '&';
        url = url + 'fim_ano='    + fim_ano;
		window.location=url;
	 }
	 function newDoc9(tipo_enti) {
		st           = document.form.st.value;
		stt          = document.form.stt.value;
		curso        = document.form.curso.value;
		tipo_enti    = document.form.tipo_enti.value;
		escolar      = document.form.escolar.value;
		termo        = document.form.termo.value;
		bioma        = document.form.bioma.value;
		servico      = document.form.servico.value;
		ini_mes      = document.form.ini_mes.value;
		ini_ano      = document.form.ini_ano.value;
		fim_mes      = document.form.fim_mes.value;
		fim_ano      = document.form.fim_ano.value;
		url = 'gestao_turmas_pqga.asp?';
		url = url + 'st='         + st         + '&';
		url = url + 'stt='        + stt        + '&';
        url = url + 'curso='      + curso      + '&';
        url = url + 'tipo_enti='  + tipo_enti  + '&';
        url = url + 'escolar='    + escolar    + '&';
        url = url + 'termo='      + termo      + '&';
        url = url + 'bioma='      + bioma      + '&';
        url = url + 'servico='    + servico    + '&';
        url = url + 'ini_mes='    + ini_mes    + '&';
        url = url + 'ini_ano='    + ini_ano    + '&';
        url = url + 'fim_mes='    + fim_mes    + '&';
        url = url + 'fim_ano='    + fim_ano;
		window.location=url;
	 }
	 function newDoc10(termo) {
		st           = document.form.st.value;
		stt          = document.form.stt.value;
		curso        = document.form.curso.value;
		tipo_enti    = document.form.tipo_enti.value;
		escolar      = document.form.escolar.value;
		termo        = document.form.termo.value;
		bioma        = document.form.bioma.value;
		servico      = document.form.servico.value;
		ini_mes      = document.form.ini_mes.value;
		ini_ano      = document.form.ini_ano.value;
		fim_mes      = document.form.fim_mes.value;
		fim_ano      = document.form.fim_ano.value;
		url = 'gestao_turmas_pqga.asp?';
		url = url + 'st='         + st         + '&';
		url = url + 'stt='        + stt        + '&';
        url = url + 'curso='      + curso      + '&';
        url = url + 'tipo_enti='  + tipo_enti  + '&';
        url = url + 'escolar='    + escolar    + '&';
        url = url + 'termo='      + termo      + '&';
        url = url + 'bioma='      + bioma      + '&';
        url = url + 'servico='    + servico    + '&';
        url = url + 'ini_mes='    + ini_mes    + '&';
        url = url + 'ini_ano='    + ini_ano    + '&';
        url = url + 'fim_mes='    + fim_mes    + '&';
        url = url + 'fim_ano='    + fim_ano;
		window.location=url;
	 }
	 function newDoc11(bioma) {
		st           = document.form.st.value;
		stt          = document.form.stt.value;
		curso        = document.form.curso.value;
		tipo_enti    = document.form.tipo_enti.value;
		escolar      = document.form.escolar.value;
		termo        = document.form.termo.value;
		bioma        = document.form.bioma.value;
		servico      = document.form.servico.value;
		ini_mes      = document.form.ini_mes.value;
		ini_ano      = document.form.ini_ano.value;
		fim_mes      = document.form.fim_mes.value;
		fim_ano      = document.form.fim_ano.value;
		url = 'gestao_turmas_pqga.asp?';
		url = url + 'st='         + st         + '&';
		url = url + 'stt='        + stt        + '&';
        url = url + 'curso='      + curso      + '&';
        url = url + 'tipo_enti='  + tipo_enti  + '&';
        url = url + 'escolar='    + escolar    + '&';
        url = url + 'termo='      + termo      + '&';
        url = url + 'bioma='      + bioma      + '&';
        url = url + 'servico='    + servico    + '&';
        url = url + 'ini_mes='    + ini_mes    + '&';
        url = url + 'ini_ano='    + ini_ano    + '&';
        url = url + 'fim_mes='    + fim_mes    + '&';
        url = url + 'fim_ano='    + fim_ano;
		window.location=url;
	 }
	 function newDoc12(servico) {
		st           = document.form.st.value;
		stt          = document.form.stt.value;
		curso        = document.form.curso.value;
		tipo_enti    = document.form.tipo_enti.value;
		escolar      = document.form.escolar.value;
		termo        = document.form.termo.value;
		bioma        = document.form.bioma.value;
		servico      = document.form.servico.value;
		ini_mes      = document.form.ini_mes.value;
		ini_ano      = document.form.ini_ano.value;
		fim_mes      = document.form.fim_mes.value;
		fim_ano      = document.form.fim_ano.value;
		url = 'gestao_turmas_pqga.asp?';
		url = url + 'st='         + st         + '&';
		url = url + 'stt='        + stt        + '&';
        url = url + 'curso='      + curso      + '&';
        url = url + 'tipo_enti='  + tipo_enti  + '&';
        url = url + 'escolar='    + escolar    + '&';
        url = url + 'termo='      + termo      + '&';
        url = url + 'bioma='      + bioma      + '&';
        url = url + 'servico='    + servico    + '&';
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
	<!-- #INCLUDE FILE="include/topo.asp" -->
	<div id="conteudo">
		<%
		Set RS1 = Server.CreateObject("ADODB.Recordset")
		RS1.CursorType = 0
		RS1.ActiveConnection = Con

		curso       = request("curso")
		stt         = request("stt")
		st          = request("st")
		ini_mes     = request("ini_mes")
		ini_ano     = request("ini_ano")
		fim_mes     = request("fim_mes")
		fim_ano     = request("fim_ano")
		tipo_enti   = request("tipo_enti")
		escolar     = request("escolar")
		termo       = request("termo")
		bioma       = request("bioma")
		servico     = request("servico")
		ord         = request("ord")


		if stt      ="" or isNumeric(stt)=false     then stt=0          end if
		if st       ="" or isNumeric(st)=false      then st=0           end if
		if curso    ="" or isNumeric(curso)=false   then curso=0        end if
		if ini_mes  ="" or isNumeric(ini_mes)=false then ini_mes=0      end if
		if ini_ano  ="" or isNumeric(ini_ano)=false then ini_ano=2016   end if
		if fim_mes  ="" or isNumeric(fim_mes)=false then fim_mes=0      end if
		if fim_ano  ="" or isNumeric(fim_ano)=false then fim_ano=2016   end if
		if termo    ="" or isNumeric(termo)=false   then termo=9        end if
		if bioma    ="" or isNumeric(bioma)=false   then bioma=9        end if
		if servico  =""                             then servico="xxx"  end if

'================================
' Montagem da seleção dos cursos
'================================

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

        if len(ini_mes)  = 1  then ini_mes = "0" & ini_mes   end if
        data_inicio = ini_ano & ini_mes & "00"
'        if ini_mes <> ""    then
'            sqlwhere = sqlwhere + " AND TU.DT_INICIO_TURMA >=" & data_inicio
'        end if
        if len(fim_mes)  = 1  then fim_mes = "0" & fim_mes   end if
        data_final  = fim_ano & "12" & "99"
'        if fim_mes <> ""    then
'            sqlwhere = sqlwhere + " AND TU.DT_FIM_TURMA <=" & data_final
'        end if




		%>
		<h1>Seleção de Pré-Inscritos</h1>                                    <%  ' Response.Write(Session("siga_projeto")) %>
		<form name="form" action="gestao_turmas_pqga.asp" method="get">
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

			<p><label for="st">Status do curso</label><select name="st" onChange="newDoc2(this.value);">
			<option value="0" <% if st=0 then %> Selected  <% end if %>>HABILITADO</option>
			<option value="1" <% if st=1 then %> Selected  <% end if %>>DESABILITADO</option>
			<option value="2" <% if st=2 then %> Selected  <% end if %>>CANCELADO</option>
			</select>
            </p>

			<p><label for="stt">Status da turma</label><select name="stt" onChange="newDoc3(this.value);">
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
            </p>
            <p>
                <label for="DataInicio">Período - Início</label>
			    <select name="ini_mes" id="ini_mes" onchange="newDoc4(this.value);">
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
                <select name="ini_ano" id="ini_ano" onchange="newDoc5(this.value);">
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
			    <select name="fim_mes" id="fim_mes" onchange="newDoc6(this.value);">
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
                <select name="fim_ano" id="fim_ano" onchange="newDoc7(this.value);">
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
			<p><label for="escolar">Escolaridade</label><select name="escolar" onChange="newDoc8(this.value);">
			<option value="0">TODOS</option>
			<%
			sql = "SELECT COD_ESCOLARIDADE, DESCRICAO FROM ESCOLARIDADE ORDER BY COD_ESCOLARIDADE"
			RS.open SQL
			while not RS.eof
				response.write "<option value="""&RS("COD_ESCOLARIDADE")&""""
				if cstr(request("escolar")) = cstr(RS("COD_ESCOLARIDADE")) then
					response.write " selected "
				end if
				response.write ">"&RS("DESCRICAO")&"</option>"
				RS.movenext
			wend
			RS.close
			%>
			</select>
            </p>
			<p><label for="tipo_enti">Entidade</label><select name="tipo_enti" onChange="newDoc9(this.value);">
			<option value="0">TODOS</option>
			<%
			sql = "SELECT ID_TIPO_ENTIDADE, DESCRICAO FROM TIPO_ENTIDADE ORDER BY ID_TIPO_ENTIDADE"
			RSSIM.open SQL
			while not RSSIM.eof
				response.write "<option value="""&RSSIM("ID_TIPO_ENTIDADE")&""""
				if cstr(request("tipo_enti")) = cstr(RSSIM("ID_TIPO_ENTIDADE")) then
					response.write " selected "
				end if
				response.write ">"&RSSIM("DESCRICAO")&"</option>"
				RSSIM.movenext
			wend
			RSSIM.close
			%>
			</select>
            </p>
			<p><label for="termo">Termo</label><select name="termo" onChange="newDoc10(this.value);">
			<option value="9" <% if termo=9 then %> Selected  <% end if %>>Todos</option>
			<option value="1" <% if termo=0 then %> Selected  <% end if %>>Sim</option>
			<option value="0" <% if termo=1 then %> Selected  <% end if %>>Não</option>
			</select>
            </p>
			<p><label for="bioma">Bioma</label><select name="bioma" onChange="newDoc11(this.value);">
			<option value="9" <% if bioma=9 then %> Selected  <% end if %>>Todos</option>
			<option value="0" <% if bioma=0 then %> Selected  <% end if %>>Sim</option>
			<option value="1" <% if bioma=1 then %> Selected  <% end if %>>Não</option>
			</select>
            </p>
			<p><label for="servico">Servidor</label><select name="servico" onChange="newDoc12(this.value);">
			<option value="xxx" <% if servico="xxx" then %> Selected  <% end if %>>Todos</option>
			<option value="sim" <% if servico="sim" then %> Selected  <% end if %>>Sim</option>
			<option value="nao" <% if servico="nao" then %> Selected  <% end if %>>Não</option>
			</select>
            </p>

			<% if request("op") = 1 then %>
				<button id="bt_menu" onClick="window.print();return false;">Imprimir</button>
			<% end if %>
		</td></tr><tr>
		</table>
		</form>
		<%

		if ord="" then
			sqlord = "TITULO"
		end if
		select case ord
			case "tp": sqlord = "T.DESCRICAO"
			case "tt": sqlord = "TITULO"
			case "st": sqlord = "C.COD_STATUS"
		end select
                                                                                                                  ' ????????????????
		SQL = "SELECT C.COD_CURSO,T.DESCRICAO AS TDESC,S.DESCRICAO AS SDESC,TITULO FROM CURSO C "       & _
              "  JOIN CURSO_STATUS S ON C.COD_STATUS=S.COD_STATUS                             "         & _
              "  JOIN CURSO_TIPO T ON C.COD_TIPO=T.COD_TIPO                                   "         & _
              " WHERE C.SIGA_PROJETO=" & SIGA_PROJETO & " AND " & sqlwhere                              & _
              " ORDER BY " & sqlord

        ' Response.Write ("SQL Cursos: " & SQL & "<br>")

		RS.Open SQL
		if RS.EOF then
			%><p>Nenhuma turma cadastrada que atenda aos filtros selecionados</p><%
		else
			%>
			<table id="tabela">
			<tr><td colspan =4 align=right>
			<button id="bt_menu" onClick="window.print();return false;">Imprimir</button></td></tr>

			<tr><td class="header"><a href="gestao_turmas_pqga.asp?ord=tt&st=<%=st%>">curso</a></td><td class="header"><a href="gestao_turmas_pqga.asp?ord=tp&st=<%=st%>">tipo</a></td><td class="header"><a href="gestao_turmas.asp?ord=st&st=<%=st%>">status</a></td><td></td></tr>
			<%
			c = 1
			while not RS.EOF
				sql1 = "select  DISTINCT CT.DESCRICAO AS TDESC,N.NOME_BREVE,C.COD_STATUS,N.COD_STATUS_TURMA,N.ID_TURMA,N.CODIGO_TURMA,"  & _
                       "        N.DT_INICIO_TURMA,N.DT_FIM_TURMA,U.STATUS_TURMA,"                                                        & _
                       "        (SELECT ALUNOS FROM VIEW_TURMAS_ALUNOS WHERE CODIGO_TURMA=N.CODIGO_TURMA) AS ALUNOS from TURMAS N "      & _
                       "        LEFT JOIN TURMA_ALUNO L ON N.ID_TURMA=L.ID_TURMA "                                                       & _
                       "        JOIN TURMA_STATUS U ON N.COD_STATUS_TURMA=U.COD_STATUS_TURMA "                                           & _
                       "        JOIN CURSO C ON C.COD_CURSO=N.COD_CURSO "                                                                & _
                       "        JOIN CURSO_TIPO CT ON CT.COD_TIPO=N.COD_TIPO WHERE "                                                     & _
                       "        N.SIGA_PROJETO=" & SIGA_PROJETO & " "

				if stt=0 then
					sql1 = sql1 & "AND N.COD_CURSO="&RS("cod_curso")&" AND N.COD_CURSO IN (select DISTINCT COD_CURSO from TURMAS N WHERE N.COD_CURSO=C.COD_CURSO)"
                else
					sql1 = sql1 & "AND N.COD_CURSO="&RS("cod_curso")&" AND N.COD_STATUS_TURMA='"&request("stt")&"' AND N.COD_CURSO IN (select DISTINCT COD_CURSO FROM TURMAS N WHERE N.COD_CURSO=C.COD_CURSO AND N.COD_STATUS_TURMA='"&request("stt")&"')"
                end if

				if data_inicio <> 0 then
					sql1 = sql1 & "AND DT_INICIO_TURMA>=" & data_inicio & " "
                end if

				if data_final <> 0 then
					sql1 = sql1 & "AND DT_FIM_TURMA<=" & data_final & " "
                end if


				sql1 = sql1 & " ORDER BY CODIGO_TURMA"
					RS1.open sql1
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
						<%
                        while not RS1.eof
                        %>
							<tr>
								<td width="15%"><a href="cad_turmas.asp?tur=<%=RS1("ID_TURMA")%>"><% =RS1("CODIGO_TURMA")%></a></td>
								<td width="15%"><% =formataData(RS1("DT_INICIO_TURMA"))%></TD>
								<td width="15%"><% =formataData(RS1("DT_FIM_TURMA"))%></TD>
								<td width="15%"><% =RS1("STATUS_TURMA")%></TD>
								<td width="25%"><% =left(RS1("NOME_BREVE"),20)%></TD>
								<td width="10%"><% =RS1("TDESC")%></TD>
<!----  Entrar com os filtros selecionados     ---->
                                <%
                            	    filtros = ""
                                    filtros = filtros & "&tipo_enti=" & tipo_enti
                                    filtros = filtros & "&escolar="   & escolar
                                    filtros = filtros & "&termo="     & termo
                                    filtros = filtros & "&bioma="     & bioma
                                    filtros = filtros & "&servico="   & servico
                                %>
								<td width="10%"><a href="gestao_selecao_pqga.asp?cod=<%=RS1("ID_TURMA")&filtros%>"><% =RS1("ALUNOS")%></a></TD>
								<td> </td>
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