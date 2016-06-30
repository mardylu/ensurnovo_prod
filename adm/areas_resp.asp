<%If Session("key_usu")<>"ok" Then Response.Redirect "logout.asp"%>
<!-- #INCLUDE FILE="../library/parametros.asp" -->
<!-- #INCLUDE FILE="../library/conOpen.asp" -->
<!-- #INCLUDE FILE="../library/fErroMsg.asp" -->
<%

if request.form("id_area")>0 then
	sql = "SELECT ID_AREA FROM AREA WHERE ID_AREA="&request.form("id_area")
	RS.Open sql
	if RS.EOF then
		erroMsg("Área não encontrada, faça um refresh em seu navegador e tente novamente")
	else
		con.execute "UPDATE AREA SET AREA='"&request.form("area")&"' WHERE ID_AREA="&request.form("id_area")
		old_id_area = RS(0)
	end if
	RS.Close
else
	con.execute "INSERT INTO AREA (AREA) VALUES ('"&request.form("area")&"')"
end if
conClose
response.redirect "areas.asp"
%>