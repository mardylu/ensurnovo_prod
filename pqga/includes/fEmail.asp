<%
FUNCTION envia_email(para,de,mensagem,titulo) '####Envia e-mail####
	Dim regEx
	Set regEx = New RegExp
	regEx.Pattern = "^[\w-\.]{1,}\@([\da-zA-Z-]{1,}\.){1,}[\da-zA-Z-]{2,3}$"
	retValde = regEx.Test(de)
	retValPara = regEx.Test(para)

	Set objMessage = CreateObject("CDO.Message")
	objMessage.Subject = titulo
	objMessage.Sender = de
	objMessage.To = para
	objMessage.TextBody = mensagem

	objMessage.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2
	objMessage.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpserver") = "200.196.54.23"
	objMessage.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = 25
	objMessage.Configuration.Fields.Update

	if retValde And retValPara then
		If Not InStr(Request.ServerVariables("HTTP_HOST"),"192.168.1.5") > 0 Then
			objMessage.Send
		Else %>
			<script language="JavaScript">
				<!--
				alert("<%=para%>")
				alert('<%=replace(replace(replace(mensagem,vbcrlf,"\n"),"'","''"),"'","\'")%>')
				//-->
			</script>
		<% End If
	End if
END Function

FUNCTION envia_emailhtml(para,de,mensagem,titulo) '####Envia e-mail####
	Dim regEx
	Set regEx = New RegExp
	regEx.Pattern = "^[\w-\.]{1,}\@([\da-zA-Z-]{1,}\.){1,}[\da-zA-Z-]{2,3}$"
	retValde = regEx.Test(de)
	retValPara = regEx.Test(para)

	Set objMessage = CreateObject("CDO.Message")
	objMessage.Subject = titulo
	objMessage.Sender = de
	objMessage.To = para
	objMessage.HTMLBody = mensagem

	objMessage.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2
	objMessage.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpserver") = "200.196.54.23"
	objMessage.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = 25
	objMessage.Configuration.Fields.Update

	if retValde And retValPara then
		If Not InStr(Request.ServerVariables("HTTP_HOST"),"192.168.1.5") > 0 Then
			objMessage.Send
		Else %>
			<script language="JavaScript">
				<!--
				alert("<%=para%>")
				alert('<%=replace(replace(replace(mensagem,vbcrlf,"\n"),"'","''"),"'","\'")%>')
				//-->
			</script>
		<% End If
	End if
END FUNCTION
%>