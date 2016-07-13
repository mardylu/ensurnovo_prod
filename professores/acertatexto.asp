<!-- #INCLUDE FILE="../library/parametros.asp" -->
<!-- #INCLUDE FILE="../library/conOpen.asp" -->

<%
	id_mensagem = request("id_msg")
	sql = "SELECT * FROM MENSAGENS WHERE ID_MENSAGEM="&id_mensagem
	RS.open sql
	if not RS.eof then
		response.write RS("MENSAGEM")
	end if
%>
