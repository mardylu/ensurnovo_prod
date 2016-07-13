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
		<td><h1>Estatíticas dos professores</h1></td><td align="right"><button id="bt_menu" onClick="window.print();return false;">Imprimir</button></td></tr>
		</table>
		<table id="tabela" width="10%" align="center" border="0">
		<%
		sql1 = "SELECT COUNT(P.COD_MUNI_IBGE) AS QTD,M.NOME_MUNI FROM PROFESSORES P JOIN WEBSIMSQL.DBO.MUNICIPIOS M ON P.COD_MUNI_IBGE=M.COD_MUNI_IBGE AND M.COD_UF_IBGE=P.COD_UF_IBGE GROUP BY P.COD_MUNI_IBGE,M.NOME_MUNI,P.COD_UF_IBGE"
		RS.open sql1
		%>
		<tr class="c1"><td colspan="2" class="header" align="center">Municipio</td></tr>
		<%
		while not RS.eof
			response.write "<tr class='c0'><td>"&RS("NOME_MUNI")&"</td>"
			response.write "<td>"&RS("QTD")&"</td></tr>"
			RS.movenext
		wend
		RS.Close
		response.write "</tr>"
		sql2 = "SELECT COUNT(P.COD_UF_IBGE) AS QTD,M.NOME_UF FROM PROFESSORES P JOIN WEBSIMSQL.DBO.UF M ON P.COD_UF_IBGE=M.COD_UF_IBGE GROUP BY P.COD_UF_IBGE,M.NOME_UF"
		RS.open sql2
		%>
		<tr class="c1"><td colspan="2" class="header" align="center">Estado</td></tr>
		<%
		while not RS.eof
			response.write "<tr class='c0'><td>"&RS("NOME_UF")&"</td>"
			response.write "<td>"&RS("QTD")&"</td></tr>"
			RS.movenext
		wend
		RS.Close
		%>
		<tr class="c1"><td colspan="2" class="header" align="center">Região</td><td></td></tr>
		<%
		sql3 = "SELECT COUNT(M.REGIAO) AS QTD,M.REGIAO FROM PROFESSORES P JOIN WEBSIMSQL.DBO.UF M ON P.COD_UF_IBGE=M.COD_UF_IBGE GROUP BY P.COD_UF_IBGE,M.REGIAO"
		RS.open sql3
		while not RS.eof
			response.write "<tr class='c0'><td>"&RS("REGIAO")&"</td>"
			response.write "<td>"&RS("QTD")&"</td></tr>"
			RS.movenext
		wend
		RS.close
		%>
		<tr class="c1"><td colspan="2" class="header" align="center">Escolaridade</td></tr>
		<%
		sql4 = "SELECT COUNT(P.COD_ESCOLARIDADE) AS QTD,E.DESCRICAO FROM PROFESSORES P JOIN ESCOLARIDADE E ON P.COD_ESCOLARIDADE=E.COD_ESCOLARIDADE GROUP BY P.COD_ESCOLARIDADE,E.DESCRICAO"
		RS.open sql4
		while not RS.eof
			response.write "<tr class='c0'><td>"&RS("DESCRICAO")&"</td>"
			response.write "<td>"&RS("QTD")&"</td></tr>"
			RS.movenext
		wend
		RS.close
		%>
		<tr class="c1"><td colspan="2" class="header" align="center">Pós</td></tr>
		<%
		sql5 = "SELECT COUNT(P.COD_POS) AS QTD,E.DESCRICAO FROM PROFESSORES P JOIN POS E ON P.COD_POS=E.COD_POS GROUP BY P.COD_POS,E.DESCRICAO"
		RS.open sql5
		while not RS.eof
			response.write "<tr class='c0'><td>"&RS("DESCRICAO")&"</td>"
			response.write "<td>"&RS("QTD")&"</td></tr>"
			RS.movenext
		wend
		RS.close
		%>
		</table>
	</div>
</div>
</body>
</html>
<%conClose%>