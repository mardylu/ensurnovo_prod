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
		 url = 'alunos_prof_frequencia.asp?op=0&ID_TURMA=<% =ID_TURMA %>&mes=';
		 url = url + mes + '&ano=' + ano
		 window.location=url;
	 }
	 function newDoc2(ano) {
		 mes=document.form.mes.value;
		 url = 'alunos_prof_frequencia.asp?op=0&ID_TURMA=<% =ID_TURMA %>&mes=';
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
		<form name="form" action="alunos_prof_frequencia.asp?op=1" method="get">
		<%
		sql = "SELECT COUNT(*) FROM TURMA_ALUNO C JOIN ALUNO A ON C.COD_ALUNO=A.COD_ALUNO WHERE ID_TURMA="&ID_TURMA
		
		RS.Open sql
			total_alunos = RS(0)
		RS.Close
		sql = "SELECT A.COD_ALUNO,A.NOME,C.COD_CURSO,C.ID_TURMA,F.MES,F.ANO,F.DIA1,F.DIA2,F.DIA3,F.DIA4,F.DIA5,F.DIA6,F.DIA7,F.DIA8,F.DIA9,F.DIA9,F.DIA10,F.DIA11,F.DIA12,F.DIA13,F.DIA14,F.DIA15,F.DIA16,F.DIA17,F.DIA18,F.DIA19,F.DIA20,F.DIA21,F.DIA22,F.DIA23,F.DIA24,F.DIA25,F.DIA26,F.DIA27,F.DIA28,F.DIA29,F.DIA30,F.DIA31 FROM TURMA_ALUNO C JOIN ALUNO A ON C.COD_ALUNO=A.COD_ALUNO LEFT JOIN ALUNO_FREQUENCIA F ON C.COD_ALUNO=F.COD_ALUNO AND C.COD_CURSO=F.COD_CURSO AND C.ID_TURMA=F.ID_TURMA AND F.MES='"&MES&"' AND F.ANO='"&ANO&"' WHERE C.ID_TURMA="&ID_TURMA&" ORDER BY A.NOME"
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
				<% 
				if FREQUENCIA > 0 then
				else
					 erroMsg("A frequencia não foi definida, atualize esta informação no cadastro da turma.")
				end if
				for i = 1 to FREQUENCIA
					response.write "<td class='header'>"&i&"</td>"
				next
				%>
				</tr>
				<%
				c = 0
				while not RS.EOF
					COD_ALUNO=RS("COD_ALUNO")

					DIA1 = request(COD_ALUNO&"_DIA1")
					DIA2 = request(COD_ALUNO&"_DIA2")
					DIA3 = request(COD_ALUNO&"_DIA3")
					DIA4 = request(COD_ALUNO&"_DIA4")
					DIA5 = request(COD_ALUNO&"_DIA5")
					DIA6 = request(COD_ALUNO&"_DIA6")
					DIA7 = request(COD_ALUNO&"_DIA7")
					DIA8 = request(COD_ALUNO&"_DIA8")
					DIA9 = request(COD_ALUNO&"_DIA9")
					DIA10 = request(COD_ALUNO&"_DIA10")
					DIA11 = request(COD_ALUNO&"_DIA11")
					DIA12 = request(COD_ALUNO&"_DIA12")
					DIA13 = request(COD_ALUNO&"_DIA13")
					DIA14 = request(COD_ALUNO&"_DIA14")
					DIA15 = request(COD_ALUNO&"_DIA15")
					DIA16 = request(COD_ALUNO&"_DIA16")
					DIA17 = request(COD_ALUNO&"_DIA17")
					DIA18 = request(COD_ALUNO&"_DIA18")
					DIA19 = request(COD_ALUNO&"_DIA19")
					DIA20 = request(COD_ALUNO&"_DIA20")
					DIA21 = request(COD_ALUNO&"_DIA21")
					DIA22 = request(COD_ALUNO&"_DIA22")
					DIA23 = request(COD_ALUNO&"_DIA23")
					DIA24 = request(COD_ALUNO&"_DIA24")
					DIA25 = request(COD_ALUNO&"_DIA25")
					DIA26 = request(COD_ALUNO&"_DIA26")
					DIA27 = request(COD_ALUNO&"_DIA27")
					DIA28 = request(COD_ALUNO&"_DIA28")
					DIA29 = request(COD_ALUNO&"_DIA29")
					DIA30 = request(COD_ALUNO&"_DIA30")
					DIA31 = request(COD_ALUNO&"_DIA31")

					if request("op") = 1 then
						if MES <> "" and ANO <> "" then
							sql = "SELECT ID_FREQUENCIA,ID_PROFESSOR,COD_CURSO,ID_TURMA,ANO,MES,DIA1,DIA2,DIA3,DIA4,DIA5,DIA6,DIA7,DIA8,DIA9,DIA10,DIA11,DIA12,DIA13,DIA14,DIA15,DIA16,DIA17,DIA18,DIA19,DIA20,DIA21,DIA22,DIA23,DIA24,DIA25,DIA26,DIA27,DIA28,DIA29,DIA30,DIA31 FROM ALUNO_FREQUENCIA WHERE COD_ALUNO='"&COD_ALUNO&"' AND COD_CURSO='"&COD_CURSO&"' AND ID_TURMA='"&ID_TURMA&"' AND MES='"&MES&"' AND ANO='"&ANO&"'"
							RS2.open sql
							if RS2.eof then
								RS2.close
								
								sql = "INSERT INTO ALUNO_FREQUENCIA (ID_PROFESSOR,COD_ALUNO,COD_CURSO,ID_TURMA,ANO,MES,DIA1,DIA2,DIA3,DIA4,DIA5,DIA6,DIA7,DIA8,DIA9,DIA10,DIA11,DIA12,DIA13,DIA14,DIA15,DIA16,DIA17,DIA18,DIA19,DIA20,DIA21,DIA22,DIA23,DIA24,DIA25,DIA26,DIA27,DIA28,DIA29,DIA30,DIA31) VALUES ('"&session("id")&"','"&COD_ALUNO&"','"&request("COD_CURSO")&"','"&request("ID_TURMA")&"','"&request("ANO")&"','"&request("MES")&"','"&DIA1&"','"&DIA2&"','"&DIA3&"','"&DIA4&"','"&DIA5&"','"&DIA6&"','"&DIA7&"','"&DIA8&"','"&DIA9&"','"&DIA10&"','"&DIA11&"','"&DIA12&"','"&DIA13&"','"&DIA14&"','"&DIA15&"','"&DIA16&"','"&DIA17&"','"&DIA18&"','"&DIA19&"','"&DIA20&"','"&DIA21&"','"&DIA22&"','"&DIA23&"','"&DIA24&"','"&DIA25&"','"&DIA26&"','"&DIA27&"','"&DIA28&"','"&DIA29&"','"&DIA30&"','"&DIA31&"')"
								con.execute sql
								sql = "SELECT ID_FREQUENCIA,ID_PROFESSOR,COD_ALUNO,COD_CURSO,ID_TURMA,ANO,MES,DIA1,DIA2,DIA3,DIA4,DIA5,DIA6,DIA7,DIA8,DIA9,DIA10,DIA11,DIA12,DIA13,DIA14,DIA15,DIA16,DIA17,DIA18,DIA19,DIA20,DIA21,DIA22,DIA23,DIA24,DIA25,DIA26,DIA27,DIA28,DIA29,DIA30,DIA31 FROM ALUNO_FREQUENCIA WHERE COD_ALUNO='"&COD_ALUNO&"' AND COD_CURSO='"&COD_CURSO&"' AND ID_TURMA='"&ID_TURMA&"' AND MES='"&MES&"' AND ANO='"&ANO&"'"
								RS2.open sql

								DIA1 = RS2("DIA1")
								DIA2 = RS2("DIA2")
								DIA3 = RS2("DIA3")
								DIA4 = RS2("DIA4")
								DIA5 = RS2("DIA5")
								DIA6 = RS2("DIA6")
								DIA7 = RS2("DIA7")
								DIA8 = RS2("DIA8")
								DIA9 = RS2("DIA9")
								DIA10 = RS2("DIA10")
								DIA11 = RS2("DIA11")
								DIA12 = RS2("DIA12")
								DIA13 = RS2("DIA13")
								DIA14 = RS2("DIA14")
								DIA15 = RS2("DIA15")
								DIA16 = RS2("DIA16")
								DIA17 = RS2("DIA17")
								DIA18 = RS2("DIA18")
								DIA19 = RS2("DIA19")
								DIA20 = RS2("DIA20")
								DIA21 = RS2("DIA21")
								DIA22 = RS2("DIA22")
								DIA23 = RS2("DIA23")
								DIA24 = RS2("DIA24")
								DIA25 = RS2("DIA25")
								DIA26 = RS2("DIA26")
								DIA27 = RS2("DIA27")
								DIA28 = RS2("DIA28")
								DIA29 = RS2("DIA29")
								DIA30 = RS2("DIA30")
								DIA31 = RS2("DIA31")
							else
								RS2.close
								if request("Enviar") = "Salvar" then
									sql = "UPDATE ALUNO_FREQUENCIA SET DIA1='"&DIA1&"',DIA2='"&DIA2&"',DIA3='"&DIA3&"',DIA4='"&DIA4&"',DIA5='"&DIA5&"',DIA6='"&DIA6&"',DIA7='"&DIA7&"',DIA8='"&DIA8&"',DIA9='"&DIA9&"',DIA10='"&DIA10&"',DIA11='"&DIA11&"',DIA12='"&DIA12&"',DIA13='"&DIA13&"',DIA14='"&DIA14&"',DIA15='"&DIA15&"',DIA16='"&DIA16&"',DIA17='"&DIA17&"',DIA18='"&DIA18&"',DIA19='"&DIA19&"',DIA20='"&DIA20&"',DIA21='"&DIA21&"',DIA22='"&DIA22&"',DIA23='"&DIA23&"',DIA24='"&DIA24&"',DIA25='"&DIA25&"',DIA26='"&DIA26&"',DIA27='"&DIA27&"',DIA28='"&DIA28&"',DIA29='"&DIA29&"',DIA30='"&DIA30&"',DIA31='"&DIA31&"' WHERE COD_ALUNO='"&COD_ALUNO&"' AND COD_CURSO='"&COD_CURSO&"' AND ID_TURMA='"&ID_TURMA&"' AND MES='"&MES&"' AND ANO='"&ANO&"'"
									con.execute sql
								end if
								sql = "SELECT ID_FREQUENCIA,ID_PROFESSOR,COD_ALUNO,COD_CURSO,ID_TURMA,ANO,MES,DIA1,DIA2,DIA3,DIA4,DIA5,DIA6,DIA7,DIA8,DIA9,DIA10,DIA11,DIA12,DIA13,DIA14,DIA15,DIA16,DIA17,DIA18,DIA19,DIA20,DIA21,DIA22,DIA23,DIA24,DIA25,DIA26,DIA27,DIA28,DIA29,DIA30,DIA31 FROM ALUNO_FREQUENCIA WHERE COD_ALUNO='"&COD_ALUNO&"' AND COD_CURSO='"&COD_CURSO&"' AND ID_TURMA='"&ID_TURMA&"' AND MES='"&MES&"' AND ANO='"&ANO&"'"
								RS2.open sql
								DIA1 = RS2("DIA1")
								DIA2 = RS2("DIA2")
								DIA3 = RS2("DIA3")
								DIA4 = RS2("DIA4")
								DIA5 = RS2("DIA5")
								DIA6 = RS2("DIA6")
								DIA7 = RS2("DIA7")
								DIA8 = RS2("DIA8")
								DIA9 = RS2("DIA9")
								DIA10 = RS2("DIA10")
								DIA11 = RS2("DIA11")
								DIA12 = RS2("DIA12")
								DIA13 = RS2("DIA13")
								DIA14 = RS2("DIA14")
								DIA15 = RS2("DIA15")
								DIA16 = RS2("DIA16")
								DIA17 = RS2("DIA17")
								DIA18 = RS2("DIA18")
								DIA19 = RS2("DIA19")
								DIA20 = RS2("DIA20")
								DIA21 = RS2("DIA21")
								DIA22 = RS2("DIA22")
								DIA23 = RS2("DIA23")
								DIA24 = RS2("DIA24")
								DIA25 = RS2("DIA25")
								DIA26 = RS2("DIA26")
								DIA27 = RS2("DIA27")
								DIA28 = RS2("DIA28")
								DIA29 = RS2("DIA29")
								DIA30 = RS2("DIA30")
								DIA31 = RS2("DIA31")
							end if			 
						end if
					end if
					%>
					<tr class="c<%=c%>">
					<td colspan="2"><%=RS("NOME")%></td>
					<% for i = 1 to FREQUENCIA
						response.write "<td><input type='checkbox' name='"&RS("COD_ALUNO")&"_DIA"&i&"' value='1'"
						if request("op") = 1 then
							if not RS2.eof then 
								if RS2("DIA"&i)=1 then
									response.write " checked"
								end if
							end if
						end if
						response.write "></td>"
					NEXT %>
					</tr>
					<%
					DIA1 = 0
					DIA2 = 0
					DIA3 = 0
					DIA4 = 0
					DIA5 = 0
					DIA6 = 0
					DIA7 = 0
					DIA8 = 0
					DIA9 = 0
					DIA10 = 0
					DIA11 = 0
					DIA12 = 0
					DIA13 = 0
					DIA14 = 0
					DIA15 = 0
					DIA16 = 0
					DIA17 = 0
					DIA18 = 0
					DIA19 = 0
					DIA20 = 0
					DIA21 = 0
					DIA22 = 0
					DIA23 = 0
					DIA24 = 0
					DIA25 = 0
					DIA26 = 0
					DIA27 = 0
					DIA28 = 0
					DIA29 = 0
					DIA30 = 0
					DIA31 = 0
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
			<%end if
		   else %>
			<input type="submit" name="Enviar" value="Salvar" class="buttonF">
		<% end if %>
		
		<button class="hover" id="bt_menu" onClick="window.location.assign('area_professores.asp');return false;">Voltar</button><br /><br /></td></tr>
		</form>
		<p><br /></p>
	</div>	
</div>
</body>
</html>
<%conClose%>  