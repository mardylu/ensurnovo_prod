<%
Session.Abandon
Session("pass")=""
Session("id")=""
Response.Redirect "default.asp"
%>