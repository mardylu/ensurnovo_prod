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

set t=fs.OpenTextFile("C:\inetpub\wwwroot\ensurnovo\pqga\TermoCompromisso.html",1,false)
MSG=t.ReadAll
t.close

Response.Write("Termo de Compromisso: " & MSG)
Response.End

' ================< FINAL DA CARGA DO TERMO DE COMPROMISSO >====================






    MSG="<html> " & _
        "<head> " & _
        "<style> " & _
        "p { " & _
        "    font-family: Arial, Helvetica, sans-serif; " & _
        "    font-size: 12px; " & _
        "} " & _
        "</style> " & _
        "</head> " & _
        "<body lang=PT-BR link=blue vlink=purple style='tab-interval:35.4pt'> " & _
        "<div class=WordSection1> " & _
        "<p ></p> " & _
        "<table border=1 cellpadding=8 width='90%'> " & _
        " <tr> " & _
        "  <td width=573 valign=top> " & _
        "  <p> " & _
        "    <table width='100%'> " & _
        "        <tr> " & _
        "            <td align='left'  width='50%'><img width=269 height=108 src='http://cursos.ibam.org.br/pqga/images/Email_PQGA_logo01.png'></td> " & _
        "            <td align='right' width='50%'><img width=164 height=90 src='http://cursos.ibam.org.br/pqga/images/Email_PQGA_logo02.jpg'></td> " & _
        "        </tr> " & _
        "    </table> " & _
        "  </p> " & _
        "  </td> " & _
        " </tr> " & _
        " <tr> " & _
        "  <td width=573 valign=top> " & _
        "  <p><br>Prezado, " & NOME_ALUNO & ",</p> " & _


        " Obrigada por seu interesse em participar da capacitação oferecida pelo PQGA/IBAM. <br><br>"  & _
        " As turmas são formadas em função da demanda pelos cursos e conforme a ordem de pré-inscrição.  <br><br>"  & _
        " É importante ler atentamente o TERMO DE COMPROMISSO e, estando de acordo, aceitá-lo. Só a partir daí sua participação será possível. <br><br>"  & _
        " <p><br><a href='http://cursos.ibam.org.br/pqga/termo/termo_atualiza.asp?cod_aluno=" & cod_aluno & "&id_turma=" & id_turma & "'>" & _
        " Clique aqui para aceitar o TERMO DE COMPROMISSO</a></p> " & _
        " Quando a turma estiver disponível, serão informados os próximos passos necessários à sua participação. <br><br>"  & _
        " Se houver alguma dúvida, não hesite e entre em contato pelo e-mail pqga-ead@ibam.org.br ou pelo telefone (21) 2536-9774 ou 2536-9737. " & _
        " A equipe do Programa está permanentemente pronta para orientá-lo(a).  <br><br>"  & _
        "Att, <br><br>"  & _
        "Gestão Acadêmica PQGA/IBAM <br><br>"  & _
        "<a href=www.amazonia-ibam.org.br>www.amazonia-ibam.org.br</a><br>"  & _
        "<a href=www.facebook.com/pqgaibam>www.facebook.com/pqgaibam</a> <br><br><br><br>"   & _
        "  </td> " & _
        " </tr> " & _
        "</table> " & _
        "<p></p> " & _
        "</div> " & _
        "</body> " & _
        "</html>"

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