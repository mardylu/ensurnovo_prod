<!-- #INCLUDE FILE="../library/parametros.asp" -->
<!-- #INCLUDE FILE="../library/conOpen.asp" -->

<%

	Function Konvert(sIn)
	    Dim oIn : Set oIn = CreateObject("ADODB.Stream")
	    oIn.Open
	    oIn.CharSet = "UTF-8" 
	    oIn.WriteText sIn
	    oIn.Position = 0
	    oIn.CharSet = "ISO-8859-1"
	    Konvert = oIn.ReadText
	    oIn.Close
	End Function

	id_mensagem = request("id_msg")
	sql = "SELECT * FROM MENSAGENS WHERE ID_MENSAGEM="&id_mensagem
	RS.open sql
	if not RS.eof then
		texto = Konvert(RS("MENSAGEM"))
		response.write texto
	end if
%>
