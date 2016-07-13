<% 
Const adStateOpenSIM = &H00000001
Set ConSIM = Server.CreateObject("ADODB.Connection")
if tipobanco = "EXPRESS" then
	ConSIM.open "Provider=SQLOLEDB; SERVER="&servidor&"; Database=websimSQL; Uid="&loginbanco&"; Pwd="&senhabanco&""
else
	ConSIM.Open "Provider=SQLOLEDB;Data Source="&servidor&";Initial Catalog=websimSQL;Network=DBMSSOCN;User Id=sqlibam;Password=sql"
end if

Set RSSIM = Server.CreateObject("ADODB.Recordset")
RSSIM.CursorType = 0
RSSIM.ActiveConnection = ConSIM

function conCloseSIM()
	if RSSIM.State = adStateOpenSIM then RSSIM.Close
	set RSSIM = nothing
	ConSIM.Close
	Set ConSIM = Nothing
end function
%>