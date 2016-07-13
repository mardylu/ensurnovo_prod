<%If session("key_ver")<>"ok" Then Response.Redirect "logout.asp"%>
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
<!--#include file="fpdf.asp"-->

<%
if Session("key_sta")="ok" or Session("key_ema")="ok" or Session("key_plc")="ok" or Session("key_plp")="ok" then
	mostraSel = true
else
	mostraSel = false
end if
%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

	<title>ENSUR Inscrições</title>

</head>
<body onLoad="checkAcao(document.formAlunos.task.value);">
<div id="pagina">

	<!-- #INCLUDE FILE="include/topo.asp" -->
	<div id="conteudo">
		<table width="100%"><tr>
		<td><h1>Estatíticas dos alunos</h1></td><td align="right"><button id="bt_menu" onClick="window.print();return false;">Imprimir</button></td></tr>
		</table>
		<table id="tabela" width="10%" align="center" border="0">
		<%
		sql1 = "SELECT COUNT(A.COD_RACA) AS QTD,R.DESCRICAO AS RACA FROM ALUNO A JOIN RACA R ON R.COD_RACA=A.COD_RACA GROUP BY A.COD_RACA,R.DESCRICAO"
		RS.open sql1
		%>
		<tr class="c1"><td colspan="2" class="header" align="center">Raça</td></tr>
		<%
		while not RS.eof
			response.write "<tr class='c0'><td>"&RS("RACA")&"</td>"
			response.write "<td>"&RS("QTD")&"</td></tr>"
			RS.movenext
		wend
		RS.Close
		response.write "</tr>"
		sql2 = "SELECT (SELECT COUNT(SEXO) FROM ALUNO WHERE SEXO=0) AS FEMININO,(SELECT COUNT(SEXO) FROM ALUNO WHERE SEXO=1) AS MASCULINO "
		RS.open sql2
		%>
		<tr class="c1"><td colspan="2" class="header" align="center">Genero</td></tr>
		<%
		response.write "<tr class='c0'><td>Feminino</td><td>"&RS("FEMININO")&"</td></tr>"
		response.write "<tr class='c0'><td>Masculino</td><td>"&RS("MASCULINO")&"</td></tr>"
		RS.close
		
		%>
		<tr class="c1"><td colspan="2" class="header" align="center">Escolaridade</td><td></td></tr>
		<%
		sql3 = "SELECT COUNT(A.COD_ESCOLARIDADE) AS QTD,R.DESCRICAO AS ESCOLARIDADE FROM ALUNO A JOIN ESCOLARIDADE R ON R.COD_ESCOLARIDADE=A.COD_ESCOLARIDADE GROUP BY A.COD_ESCOLARIDADE,R.DESCRICAO"
		RS.open sql3
		while not RS.eof
			response.write "<tr class='c0'><td>"&RS("ESCOLARIDADE")&"</td>"
			response.write "<td>"&RS("QTD")&"</td></tr>"
			RS.movenext
		wend
		RS.close
		%>
		<tr class="c1"><td colspan="2" class="header" align="center">Municipio</td></tr>
		<%
		sql4 = "SELECT COUNT(A.COD_MUNI_IBGE) AS UF,M.NOME_MUNI FROM ALUNO A JOIN WEBSIMSQL.DBO.MUNICIPIOS M ON A.COD_MUNI_IBGE=M.COD_MUNI_IBGE GROUP BY A.COD_MUNI_IBGE,M.NOME_MUNI"
		RS.open sql4
		while not RS.eof
			response.write "<tr class='c0'><td>"&RS("NOME_MUNI")&"</td>"
			response.write "<td>"&RS("UF")&"</td></tr>"
			RS.movenext
		wend
		RS.close
		%>
		<tr class="c1"><td colspan="2" class="header" align="center">Estado</td></tr>
		<%
		sql5 = "SELECT COUNT(A.COD_UF_IBGE) AS UF,M.NOME_UF FROM ALUNO A JOIN WEBSIMSQL.DBO.UF M ON A.COD_UF_IBGE=M.COD_UF_IBGE GROUP BY A.COD_UF_IBGE,M.NOME_UF ORDER BY M.NOME_UF"
		RS.open sql5
		while not RS.eof
			response.write "<tr class='c0'><td>"&RS("NOME_UF")&"</td>"
			response.write "<td>"&RS("UF")&"</td></tr>"
			RS.movenext
		wend
		RS.close
		%>
		<tr class="c1"><td colspan="2" class="header" align="center">Região</td></tr>
		<%
		sql6 = "SELECT COUNT(M.REGIAO) AS QTD,REGIAO FROM ALUNO A JOIN WEBSIMSQL.DBO.UF M ON A.COD_UF_IBGE=M.COD_UF_IBGE GROUP BY M.REGIAO"		
		RS.open sql6
		while not RS.eof
			response.write "<tr class='c0'><td>"&RS("REGIAO")&"</td>"
			response.write "<td>"&RS("QTD")&"</td></tr>"
			RS.movenext
		wend
		RS.close
		%>
		<tr class="c1"><td colspan="2" class="header" align="center">Faixa etária</td></tr>
		<%
		sql7 = "SELECT (SELECT COUNT((YEAR(GETDATE()) - LEFT(DT_NASCIMENTO,4))) AS IDADE FROM ALUNO WHERE (YEAR(GETDATE()) - LEFT(DT_NASCIMENTO,4)) >= 10 AND (YEAR(GETDATE()) - LEFT(DT_NASCIMENTO,4)) < 20) AS I10_20,(SELECT COUNT((YEAR(GETDATE()) - LEFT(DT_NASCIMENTO,4))) AS IDADE FROM ALUNO WHERE (YEAR(GETDATE()) - LEFT(DT_NASCIMENTO,4)) >= 20 AND (YEAR(GETDATE()) - LEFT(DT_NASCIMENTO,4)) < 30) AS I20_30,(SELECT COUNT((YEAR(GETDATE()) - LEFT(DT_NASCIMENTO,4))) AS IDADE FROM ALUNO WHERE (YEAR(GETDATE()) - LEFT(DT_NASCIMENTO,4)) >= 30 AND (YEAR(GETDATE()) - LEFT(DT_NASCIMENTO,4)) < 40) AS I30_40,(SELECT COUNT((YEAR(GETDATE()) - LEFT(DT_NASCIMENTO,4))) AS IDADE FROM ALUNO WHERE (YEAR(GETDATE()) - LEFT(DT_NASCIMENTO,4)) >= 40 AND (YEAR(GETDATE()) - LEFT(DT_NASCIMENTO,4)) < 50) AS I40_50,(SELECT COUNT((YEAR(GETDATE()) - LEFT(DT_NASCIMENTO,4))) AS IDADE FROM ALUNO WHERE (YEAR(GETDATE()) - LEFT(DT_NASCIMENTO,4)) >= 50 AND (YEAR(GETDATE()) - LEFT(DT_NASCIMENTO,4)) < 60) AS I50_60,(SELECT COUNT((YEAR(GETDATE()) - LEFT(DT_NASCIMENTO,4))) AS IDADE FROM ALUNO WHERE (YEAR(GETDATE()) - LEFT(DT_NASCIMENTO,4)) >= 60 AND (YEAR(GETDATE()) - LEFT(DT_NASCIMENTO,4)) < 70) AS I60_70,(SELECT COUNT((YEAR(GETDATE()) - LEFT(DT_NASCIMENTO,4))) AS IDADE FROM ALUNO WHERE (YEAR(GETDATE()) - LEFT(DT_NASCIMENTO,4)) > 70)  AS [MAIS_70]"
		RS.open sql7
		response.write "<tr class='c0'><td>De 10 à 20 Anos</td><td>"&RS("I10_20")&"</td></tr>"
		response.write "<tr class='c0'><td>De 20 à 30 Anos</td><td>"&RS("I20_30")&"</td></tr>"
		response.write "<tr class='c0'><td>De 30 à 40 Anos</td><td>"&RS("I30_40")&"</td></tr>"
		response.write "<tr class='c0'><td>De 40 à 50 Anos</td><td>"&RS("I40_50")&"</td></tr>"
		response.write "<tr class='c0'><td>De 50 à 60 Anos</td><td>"&RS("I50_60")&"</td></tr>"
		response.write "<tr class='c0'><td>De 60 à 70 Anos</td><td>"&RS("I60_70")&"</td></tr>"
		response.write "<tr class='c0'><td>Mais de 70 Anos</td><td>"&RS("MAIS_70")&"</td></tr>"
		
		RS.close
		%>
		</table>
	</div>
</div>
</body>
</html>
<%conClose%>