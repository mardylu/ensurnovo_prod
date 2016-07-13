<!-- #INCLUDE FILE="../includes/parametros.asp" -->
<!-- #INCLUDE FILE="../includes/conOpen.asp" -->

<%

    cod_aluno = request("cod_aluno")
    id_turma  = request("id_turma")
    guid      = request("guid")
    sql = "SELECT NOME FROM ALUNO WHERE COD_ALUNO='" & cod_aluno & "'"
    RS.Open sql

    NOME_ALUNO = RS("NOME")

    RS.close

' ================< INÍCIO DA CARGA DO TERMO DE COMPROMISSO >====================

dim fs,f,t,x
set fs=Server.CreateObject("Scripting.FileSystemObject")

set t=fs.OpenTextFile("C:\inetpub\wwwroot\ensurnovo\pqga\termo\TermoCompromisso.html",1,false)
MSG=t.ReadAll
t.close

MSG = Replace(MSG, "XX_NOME_XX ", NOME_ALUNO)
MSG = Replace(MSG, "XX_COD_ALUNO_XX", cod_aluno)
MSG = Replace(MSG, "XX_ID_TURMA_XX", id_turma)

' Response.Write("Termo de Compromisso: " & MSG)
' Response.End

' ================< FINAL DA CARGA DO TERMO DE COMPROMISSO >====================



' ====< INÍCIO - GRAVAR ARQUIVO COM O TERMO DE COMPROMISSO

    Dim objeto, gravaArquivo, sArquivo, nome_arquivo

    nome_arquivo = "xtermo_" & guid & ".html"

    Set objeto = CreateObject("Scripting.FileSystemObject")
    sArquivo = Server.MapPath (nome_arquivo)

	If objeto.FileExists(sArquivo) = false Then
        Set gravaArquivo = objeto.CreateTextFile(sArquivo ,True)
    else
        Set gravaArquivo = objeto.OpenTextFile(sArquivo, 8, true)
    end if

    gravaArquivo.WriteLine(MSG)

    gravaArquivo.close
    set objeto =nothing
    set gravaArquivo =nothing
' ====< FINAL - GRAVAR ARQUIVO DE LOG DAS INSCRIÇÕES

%>
<%conClose%>