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
		 url = 'alunos_prof_notas.asp?op=0&ID_TURMA=<% =ID_TURMA %>&mes=';
		 url = url + mes + '&ano=' + ano
		 window.location=url;
	 }
	 function newDoc2(ano) {
		 mes=document.form.mes.value;
		 url = 'alunos_prof_notas.asp?op=0&ID_TURMA=<% =ID_TURMA %>&mes=';
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
		<form name="form" action="alunos_prof_notas.asp?op=1" method="get">
		<%
		sql = "SELECT COUNT(*) FROM TURMA_ALUNO C JOIN ALUNO A ON C.COD_ALUNO=A.COD_ALUNO WHERE ID_TURMA="&ID_TURMA
		
		RS.Open sql
			total_alunos = RS(0)
		RS.Close
		sql = "SELECT A.COD_ALUNO,A.NOME,C.COD_CURSO,C.ID_TURMA,F.MES,F.ANO,F.NOTA FROM TURMA_ALUNO C JOIN ALUNO A ON C.COD_ALUNO=A.COD_ALUNO LEFT JOIN ALUNO_FREQUENCIA F ON C.COD_ALUNO=F.COD_ALUNO AND C.COD_CURSO=F.COD_CURSO AND C.ID_TURMA=F.ID_TURMA AND F.MES='"&MES&"' AND F.ANO='"&ANO&"' WHERE C.ID_TURMA="&ID_TURMA&" ORDER BY A.NOME"
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
			<select name="mes" onChange="newDoc1(this.value);">
			<option value="0"><-Selecione o Mês-></option>
			<option value="1" <% if MES=1 then %> Selected  <% end if %>>Janeiro</option>
			<option value="2" <% if MES=2 then %> Selected  <% end if %>>Fevereiro</option>
			<option value="3" <% if MES=3 then %> Selected  <% end if %>>Março</option>
			<option value="4" <% if MES=4 then %> Selected  <% end if %>>Abril</option>
			<option value="5" <% if MES=5 then %> Selected  <% end if %>>Maio</option>
			<option value="6" <% if MES=6 then %> Selected  <% end if %>>Junho</option>
			<option value="7" <% if MES=7 then %> Selected  <% end if %>>Julho</option>
			<option value="8" <% if MES=8 then %> Selected  <% end if %>>Agosto</option>
			<option value="9" <% if MES=9 then %> Selected  <% end if %>>Setembro</option>
			<option value="10" <% if MES=10 then %> Selected  <% end if %>>Outubro</option>
			<option value="11" <% if MES=11 then %> Selected  <% end if %>>Novembro</option>
			<option value="12" <% if MES=12 then %> Selected  <% end if %>>Dezembro</option>
			</select>
			<select name="ano" onChange="newDoc2(this.value);">
			<option value="0"><-Selecione o Ano-></option>
			<option value="<% =year(now)-1 %>" <% if cint(ANO)=year(now)-1 then %> Selected  <% end if %>><% =year(now)-1 %></option>
			<option value="<% =year(now) %>" <% if cint(ANO)=year(now) then %> Selected  <% end if %>><% =year(now) %></option>
			<option value="<% =year(now)+1 %>" <% if cint(ANO)=year(now)+1 then %> Selected  <% end if %>><% =year(now)+1 %></option>
			</select>
			<% if request("op") = 1 then %>
				<button id="bt_menu" onClick="window.print();return false;">Imprimir</button>
			<% end if %>
			</td></tr><tr>
			<% if request("op") = 1 then %>
				<td class="header" colspan="2">nome</td>				
				<td class='header'>Nota</td></tr>
				<%
				c = 0
				while not RS.EOF
					COD_ALUNO=RS("COD_ALUNO")

					NOTA = request(COD_ALUNO&"_NOTA")

					if request("op") = 1 then
						if MES <> "" and ANO <> "" then
							sql = "SELECT ID_FREQUENCIA,ID_PROFESSOR,COD_CURSO,ID_TURMA,ANO,MES,NOTA FROM ALUNO_FREQUENCIA WHERE COD_ALUNO='"&COD_ALUNO&"' AND COD_CURSO='"&COD_CURSO&"' AND ID_TURMA='"&ID_TURMA&"' AND MES='"&MES&"' AND ANO='"&ANO&"'"
							RS2.open sql
							if RS2.eof then
								RS2.close
								
								sql = "INSERT INTO ALUNO_FREQUENCIA (ID_PROFESSOR,COD_ALUNO,COD_CURSO,ID_TURMA,ANO,MES,NOTA) VALUES ('"&session("id")&"','"&COD_ALUNO&"','"&request("COD_CURSO")&"','"&request("ID_TURMA")&"','"&request("ANO")&"','"&request("MES")&"','"&NOTA&"')"
								con.execute sql
								sql = "SELECT ID_FREQUENCIA,ID_PROFESSOR,COD_ALUNO,COD_CURSO,ID_TURMA,ANO,MES,NOTA FROM ALUNO_FREQUENCIA WHERE COD_ALUNO='"&COD_ALUNO&"' AND COD_CURSO='"&COD_CURSO&"' AND ID_TURMA='"&ID_TURMA&"' AND MES='"&MES&"' AND ANO='"&ANO&"'"
								RS2.open sql

								NOTA = RS2("NOTA")
							else
								RS2.close
								if request("Enviar") = "Salvar" then
									sql = "UPDATE ALUNO_FREQUENCIA SET NOTA='"&NOTA&"' WHERE COD_ALUNO='"&COD_ALUNO&"' AND COD_CURSO='"&COD_CURSO&"' AND ID_TURMA='"&ID_TURMA&"' AND MES='"&MES&"' AND ANO='"&ANO&"'"
									con.execute sql
								end if
								sql = "SELECT ID_FREQUENCIA,ID_PROFESSOR,COD_ALUNO,COD_CURSO,ID_TURMA,ANO,MES,NOTA FROM ALUNO_FREQUENCIA WHERE COD_ALUNO='"&COD_ALUNO&"' AND COD_CURSO='"&COD_CURSO&"' AND ID_TURMA='"&ID_TURMA&"' AND MES='"&MES&"' AND ANO='"&ANO&"'"
								RS2.open sql
								NOTA = RS2("NOTA")
							end if			 
						end if
					end if
					%>
					<tr class="c<%=c%>">
					<td colspan="2"><%=RS("NOME")%></td>
					<% 
'						response.write "<td><input type='text' name='"&RS("COD_ALUNO")&"_NOTA"&i&"' value='"&RS("NOTA")&"' maxlength='5' size='6'"
						response.write "<td><input type='text' name='"&RS("COD_ALUNO")&"_NOTA"&i&"' value='"&NOTA&"' maxlength='5' size='6'"
						response.write "></td>"
					%>
					</tr>
					<%
					NOTA = 0
					c = 1 - c
					RS.MoveNext
					if request("op") = 1 then
						RS2.close
					end if
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

		<button class="hover" id="bt_menu" onClick="window.location.assign('area_professores.asp');return false;">Voltar</button><br /><br /></td></tr>
		</form>
		<p><br /></p>
	</div>
</div>
</body>
</html>
<%conClose%>