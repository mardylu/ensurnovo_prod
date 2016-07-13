<%
Const adStateOpen = &H00000001
Set Con = Server.CreateObject("ADODB.Connection")
if tipobanco = "EXPRESS" then
	con.open "Provider=SQLOLEDB; SERVER="&servidor&"; Database=ensur-desenv; Uid="&loginbanco&"; Pwd="&senhabanco&""
else
	Con.Open "Provider=SQLOLEDB;Data Source="&servidor&";Initial Catalog="&banco&";Network=DBMSSOCN;User Id="&loginbanco&";Password="&senhabanco&""
end if

Set RS = Server.CreateObject("ADODB.Recordset")
RS.CursorType = 0
RS.ActiveConnection = Con

function conClose()
	if RS.State = adStateOpen then RS.Close
	set RS = nothing
	Con.Close
	Set Con = Nothing
end function
%>