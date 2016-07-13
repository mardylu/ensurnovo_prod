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
ID_TURMA=request("ID_TURMA")
Set RS1 = Server.CreateObject("ADODB.Recordset")
RS1.CursorType = 0
RS1.ActiveConnection = Con
Set RS2 = Server.CreateObject("ADODB.Recordset")
RS2.CursorType = 0
RS2.ActiveConnection = Con

MES = request("mes")
ANO = request("ano")
COD_CURSO = request("COD_CURSO")
ID_TURMA = request("ID_TURMA")

if MES="" then
	MES=0
end if
if ANO="" then
	ANO=0
end if

%>

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<link rel="stylesheet" type="text/css" href="../css/styles1.css" />
	<link rel="stylesheet" type="text/css" href="../css/form1.css" />

	<script type="text/javascript">
	 function newDoc1(mes) {
		 ano=document.form.ano.value;
		 url = 'alunos_prof_resultado.asp?op=0&ID_TURMA=<% =ID_TURMA %>&mes=';
		 url = url + mes + '&ano=' + ano
		 window.location=url;
	 }
	 function newDoc2(ano) {
		 mes=document.form.mes.value;
		 url = 'alunos_prof_resultado.asp?op=0&ID_TURMA=<% =ID_TURMA %>&mes=';
		 url = url + mes + '&ano=' + ano
		 window.location=url;
	 }
	</script>

	<title>ENSUR Inscrições</title>

</head>
<body>
<div id="pagina">
	<!-- #INCLUDE FILE="../include/topo_professores.asp" -->
	<div id="conteudo">
		<%
		sql = "SELECT T.FREQUENCIA,T.ID_TURMA,T.DT_INICIO_TURMA,T.CODIGO_TURMA,T.DT_FIM_TURMA,T.VALOR,T.COD_STATUS_TURMA,TS.STATUS_TURMA,(SELECT TITULO FROM CURSO WHERE COD_CURSO=T.COD_CURSO) AS TITULO FROM TURMAS T JOIN TURMA_STATUS TS ON T.COD_STATUS_TURMA=TS.COD_STATUS_TURMA WHERE T.ID_TURMA="&ID_TURMA
		RS.Open sql
		if RS.EOF then erroMsg("Turma não encontrada")
		curso_tit = RS("TITULO")
		DT_INICIO_TURMA = RS("DT_INICIO_TURMA")
		DT_FIM_TURMA = RS("DT_FIM_TURMA")
		VALOR = RS("VALOR")
		STATUS_TURMA = RS("STATUS_TURMA")
		CODIGO_TURMA = RS("CODIGO_TURMA")
		FREQUENCIA = RS("FREQUENCIA")
		RS.Close
		%>
		<h1>Curso "<%=curso_tit%>" </h1>
		<h2>Data de Inicio <%=formataData(DT_INICIO_TURMA)%>, data de Término <%=formataData(DT_FIM_TURMA)%> - <% =CODIGO_TURMA %></h2>
		<form name="form" action="alunos_prof_resultado.asp?op=1" method="get">
		<%
		sql = "SELECT COUNT(*) FROM TURMA_ALUNO C JOIN ALUNO A ON C.COD_ALUNO=A.COD_ALUNO WHERE ID_TURMA="&ID_TURMA&" AND (C.STATUS='MATRICULADO' OR C.STATUS='REPROVADO' OR C.STATUS='APROVADO')"

		RS.Open sql
			total_alunos = RS(0)
		RS.Close
		sql = "SELECT A.COD_ALUNO,A.NOME,C.COD_CURSO,C.ID_TURMA,F.MES,F.ANO,F.RESULTADO,C.STATUS FROM TURMA_ALUNO C JOIN ALUNO A ON C.COD_ALUNO=A.COD_ALUNO LEFT JOIN ALUNO_FREQUENCIA F ON C.COD_ALUNO=F.COD_ALUNO AND C.COD_CURSO=F.COD_CURSO AND C.ID_TURMA=F.ID_TURMA AND F.MES='"&MES&"' AND F.ANO='"&ANO&"' WHERE C.ID_TURMA="&ID_TURMA&" AND (C.STATUS='MATRICULADO' OR C.STATUS='REPROVADO' OR C.STATUS='APROVADO') ORDER BY A.NOME"
		RS.Open sql

		turma="vazio"
		if RS.EOF then
			turma="vazio"
			%><br /><p>Nenhum aluno cadastrado</p><%
		else
			turma="ok"
			COD_ALUNO = RS("COD_ALUNO")
			%>
			<br /><p><%=total_alunos%> aluno(s) matriculado(s)</p>
			<input type="hidden" name="ID_TURMA" value="<%=RS("ID_TURMA")%>">
			<input type="hidden" name="COD_CURSO" value="<%=RS("COD_CURSO")%>">
			<input type="hidden" name="op" value="1">
			<table id="tabela">
			<tr><td colspan="<% =FREQUENCIA+2 %>">
			</td></tr><tr>
			<% if request("op") = 1 then %>
				<td class="header" colspan="2">nome</td>
				<td class="header">resultado</td></tr>
				<%
				c = 0
				sql = "SELECT DT_FIM_TURMA FROM TURMAS WHERE ID_TURMA="&ID_TURMA
				RS2.Open sql
				if not RS2.eof then
					DT_FIM_TURMA=RS2("DT_FIM_TURMA")
				else
					DT_FIM_TURMA="010101"
				end if
				mes = mid(DT_FIM_TURMA,5,2)
				ano = mid(DT_FIM_TURMA,1,4)
				RS2.close
				while not RS.EOF
					COD_ALUNO=RS("COD_ALUNO")
					RESULTADO = request(COD_ALUNO&"_RESULTADO")

                    if (RESULTADO = "0")  then
                        RESULTADO = RS("STATUS")
                    end if


					if request("op") = 1 then
						if MES <> "" and ANO <> "" then
								if request("Enviar") = "Salvar" then
									sql = "UPDATE TURMA_ALUNO SET STATUS='"&RESULTADO&"' WHERE COD_ALUNO='"&COD_ALUNO&"' AND COD_CURSO='"&COD_CURSO&"' AND ID_TURMA='"&ID_TURMA&"'"
									con.execute sql

' Response.Write(" - Resultado no Update: "&RESULTADO&" - ")

' request(COD_ALUNO&"_RESULTADO")

								else
									RESULTADO = RS("STATUS")
								end if
						end if
					end if

' Response.Write("<br>Depois do Loop")
' Response.End


					%>
					<tr class="c<%=c%>">
					<td colspan="2"><%=RS("NOME")%>

<% ' Response.Write(" - Resultado: "&RESULTADO&" - ") %>


                    </td>
					<%
						response.write "<td><select name='"&RS("COD_ALUNO")&"_RESULTADO"&i&"'>"
					%>
					<option value="0"><-Selecione o Resultado-></option>
					<option value="APROVADO" <% if RESULTADO="APROVADO" then %> Selected  <% end if %>>Aprovado</option>
					<option value="REPROVADO" <% if RESULTADO="REPROVADO" then %> Selected  <% end if %>>Reprovado</option>
					</select>
					</td></tr>
					<%
					RESULTADO = 0
					c = 1 - c
					RS.MoveNext
				wend
			end if
			RS.Close
		end if
		%>
		</table>
		<BR>
		<% if request("op")="0" then
			if turma="ok" then%>
				<input type="submit" name="Enviar" value="Enviar" class="buttonF">
			<% end if
		 else
			if turma="ok" then%>
				<input type="submit" name="Enviar" value="Salvar" class="buttonF">
			<% end if
		end if %>
		<button class="hover" id="bt_menu" onClick="window.location.assign('area_professores.asp');return false;">Voltar</button>
		<% if request("op") = 1 then %>
			<button id="bt_menu" onClick="window.print();return false;">Imprimir</button><br /><br /></td></tr>
		<% end if %>

		</form>
		<p><br /></p>
	</div>	
</div>
</body>
</html>
<%conClose%>