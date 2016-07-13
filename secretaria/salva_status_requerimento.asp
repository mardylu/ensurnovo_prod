<!-- #INCLUDE FILE="../library/parametros.asp" -->
<!-- #INCLUDE FILE="../library/conOpen.asp" -->
<!-- #INCLUDE FILE="../library/fAddZero.asp" -->
<!-- #INCLUDE FILE="../library/fErroMsg.asp" -->
<!-- #INCLUDE FILE="../library/fData.asp" -->
<!-- #INCLUDE FILE="../library/fFormataData.asp" -->
<!-- #INCLUDE FILE="../library/vHoje.asp" -->
<!-- #INCLUDE FILE="../library/fEmail.asp" -->
<!-- #INCLUDE FILE="../library/fFormataCPF.asp" -->

<%
sql = "UPDATE REQUERIMENTO SET STATUS='"&request("STATUS_REQUERIMENTO")&"' WHERE ID_REQUERIMENTO='"&request("ID_REQUERIMENTO")&"'"
con.execute sql
response.redirect "branca.asp"

%>