<%If session("key_ver")<>"ok" Then Response.Redirect "logout.asp"%>
<!-- #INCLUDE FILE="../library/parametros.asp" -->
<!-- #INCLUDE FILE="../library/conOpen.asp" -->
<!-- #INCLUDE FILE="../library/fErroMsg.asp" -->
<!-- #INCLUDE FILE="../library/fData.asp" -->
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

	<title>ENSUR Inscrições</title>
</head>
<body>
<div id="pagina">
	<!-- #INCLUDE FILE="include/topo.asp" -->
	<div id="conteudo">
		<%
		st = request("st")
		if st="" or isNumeric(st)=false then st=0
		if st=0 then
			tit = "em andamento"
			sqlwhere = "C.COD_STATUS<6"
		else
			tit = "finalizados"
			sqlwhere = "C.COD_STATUS>5"
		end if
		%>
		<h1>Cadastro de cursos <%=tit%></h1>
		<%
		ord = request("ord")
		select case ord
			case "tp": sqlord = "T.DESCRICAO"
			case "tt": sqlord = "TITULO"
			'case "di": sqlord = "DT_INICIO"
			'case "df": sqlord = "DT_FIM"
			case "cd": sqlord = "ALUNOS"
			case "st": sqlord = "C.COD_STATUS"
			'case else: sqlord = "DT_INICIO"
		end select
		RS.Open "SELECT COD_CURSO,T.DESCRICAO AS TDESC,S.DESCRICAO AS SDESC,TITULO,(SELECT COUNT(*) FROM CURSO_ALUNO A WHERE A.COD_CURSO=C.COD_CURSO) AS ALUNOS FROM CURSO C JOIN CURSO_STATUS S ON C.COD_STATUS=S.COD_STATUS JOIN CURSO_TIPO T ON C.COD_TIPO=T.COD_TIPO WHERE "&sqlwhere'&" ORDER BY "&sqlord
		if RS.EOF then
			%><p>Nenhum curso cadastrado</p><%
		else
			%>
			<table id="tabela">
			<tr><td class="header"><a href="cursos.asp?ord=tt">título</a></td><td class="header"><a href="cursos.asp?ord=tp">tipo</a></td><td class="header"><a href="cursos.asp?ord=st">status</a></td><td class="header"><a href="cursos.asp?ord=di">dt. início</a></td><td class="header"><a href="cursos.asp?ord=df">dt. fim</a></td><td class="header"><a href="cursos.asp?ord=cd">cad.</a></td></tr>
			<%
			c = 0
			while not RS.EOF
				%><tr class="c<%=c%>"><td width="300"><%If Session("key_cur")="ok" Then%><a href="curso.asp?cod=<%=RS("COD_CURSO")%>"><%=RS("TITULO")%></a><%else%><%=RS("TITULO")%><%end if%></td><td><%=RS("TDESC")%></td><td><%=RS("SDESC")%></td><td></td><td></td><td><a href="alunos.asp?cod=<%=RS("COD_CURSO")%>"><%=RS("ALUNOS")%></a></td></tr><%
				c = 1 - c
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
<%conClose
'<%=formataData(RS("DT_INICIO"))%>
'<%=formataData(RS("DT_FIM"))%>
%>