
<%

    Dim objeto, gravaArquivo, sArquivo

    Set objeto = CreateObject("Scripting.FileSystemObject")
    sArquivo = Server.MapPath ("TermoCompromisso.html")

	If objeto.FileExists(sArquivo) = false Then
        Set gravaArquivo = objeto.CreateTextFile(sArquivo ,True)
    else
        Set gravaArquivo = objeto.OpenTextFile(sArquivo, 8, true)
    end if

    Linha = objeto.StreamReader.ReadToEnd()

'    objeto.StreamReader As StreamReader
'    Dim Linha As String

    ' Read body of email from a file

'   objStreamReader = File.OpenText(Server.MapPath("TermoCompromisso.html"))
'   Linha = objeto.StreamReader.ReadToEnd()
'   objStreamReader.Close()

    Response.Write(Linha)

%>


' objStreamReader = File.OpenText(Server.MapPath("~/EmailTemplates/your_html_file.htm"))
' strMessageBody = objStreamReader.ReadToEnd()
' objStreamReader.Close()













