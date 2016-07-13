<%

Dim objeto, gravaArquivo, sArquivo

Set objeto = CreateObject("Scripting.FileSystemObject")
sArquivo = Server.MapPath ("teste_ajax.txt")

Set gravaArquivo = objeto.CreateTextFile(sArquivo ,True)

gravaArquivo.WriteLine("Gravaчуo de arquivo em asp")

gravaArquivo.close
set objeto =nothing
set gravaArquivo =nothing

%>