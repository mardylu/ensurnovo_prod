
<%

dim fs,f,t,x
set fs=Server.CreateObject("Scripting.FileSystemObject")

set t=fs.OpenTextFile("C:\inetpub\wwwroot\ensurnovo\pqga\TermoCompromisso.html",1,false)
x=t.ReadAll
t.close

Response.Write("The text in the file is: " & x)

%>

