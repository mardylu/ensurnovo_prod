
<!-- #INCLUDE FILE="../library/parametros.asp" -->
<!-- #INCLUDE FILE="../library/conOpen.asp" -->
<!-- #INCLUDE FILE="../library/conOpenSIM.asp" -->


<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body>


<%

Set RS1 = Server.CreateObject("ADODB.Recordset")
RS1.CursorType = 0
RS1.ActiveConnection = Con

Set RSSIM2 = Server.CreateObject("ADODB.Recordset")
RSSIM2.CursorType = 0
RSSIM2.ActiveConnection = Con



'-----------------------------------------------------------------
' GRAVAÇÃO DO ARQUIVO DE ERROS

Dim objeto, gravaArquivo, sArquivo

Set objeto = CreateObject("Scripting.FileSystemObject")
sArquivo = Server.MapPath ("erros.html")

Set gravaArquivo = objeto.CreateTextFile(sArquivo ,True)





' ========================================================
' INÍCIO DO PROCESSAMENTO DE DELEÇÃO A VALIDAÇÃO DOS CAMPOS PARA INCLUSÃO NOS CURSOS
' ========================================================


Response.Write ("<br><br><center><b>Crítica e validação dos dados dos alunos para inclusão no SIGA</b></center><br>")
Response.Write ("<center><b>A planilha tem que estar no formato - CSV - separado por ponto e vírgula (*.csv) </b></center><br><br>")

dim arquivocsv,contador,linha,fso,objFile

arquivocsv = "./duplicados.csv"
' arquivocsv = "./" & request("CSV")

set fso = createobject("scripting.filesystemobject")
set objFile = fso.opentextfile(server.mappath(arquivocsv))

qtde = 0
qt_com_erro = 0
qt_sem_erro = 0


    Response.Write ("<table cellpadding='3' cellspacing='1' border='1'>")
    Response.Write ("<tr>")
    Response.Write ("<td>UF</td>")
    Response.Write ("<td>Município</td>")
    Response.Write ("<td>Vezes</td>")
    Response.Write ("</tr>")



Do Until objFile.AtEndOfStream

    Response.Write ("<tr>")
    linha = split(objFile.ReadLine,";")
    ' strimportando = strimportando & "<tr>"
    totalregistros = ubound(linha)


        estado            = linha(0)
        municipio         = linha(1)
        vezes             = linha(2)


        Response.Write ("<tr>")
        Response.Write ("<td>" & estado & "</td>")
        Response.Write ("<td>" & municipio & "</td>")
        Response.Write ("<td>" & vezes & "</td>")
        Response.Write ("</tr>")


        sql_entidades = "select * from entidades where cod_uf_ibge='" & estado & "' AND cod_muni_ibge ='" & municipio & "' AND id_tipo_entidade=1 ORDER BY cod_enti"
        RSSIM.Open sql_entidades

        if RSSIM.eof then
            Response.Write("<br><br>Entidade não encontrada<br><br>")
            Response.End
        end if

        qtde = qtde + vezes
        primeiro = 1

        if ( primeiro = 1 ) then
            cod_enti_pri = RSSIM("cod_enti")
        end if
        WHILE not RSSIM.eof
            cod_enti_aluno = RSSIM("cod_enti")
            cod_entidade   = RSSIM("cod_enti")

            if ( primeiro > 1 ) then
                sql_deleta_enti = "DELETE FROM entidades WHERE cod_enti='" & cod_entidade  & "'"
                Response.Write  sql_deleta_enti  & " - Cod_entidade: " & cod_entidade & " - cod_enti_pri: " & cod_enti_pri &  " - UF: " & estado & " - Município: " & municipio & "<br>"
                ConSIM.execute sql_deleta_enti
                sql_atualiza_aluno = "UPDATE aluno set cod_enti='" & cod_enti_pri & "' WHERE cod_enti='" & cod_entidade  & "'"
                Response.Write  sql_atualiza_aluno & "<br>"
                Con.execute sql_atualiza_aluno
            end if

            primeiro = primeiro + 1
            RSSIM.movenext
        wend
        RSSIM.Close

Loop

Response.Write ("</table>")


objFile.Close

gravaArquivo.close
set objeto =nothing
set gravaArquivo =nothing


response.Write ("<br>")
response.Write ("Registros Total......: ") & qtde & "<br>"
response.Write ("Registros com erro...: ") & qt_com_erro & "<br>"
response.Write ("Registros sem erro...: ") & qt_sem_erro & "<br>"

%>

<button onclick="window.open('erros.html','Importação de planilhas','toolbar=no,location=no,status=no,menubar=no,scrollbars=yes,resizable=no,width=1000,height=1000'); ">Abrir a lista de erros</button>
<br><br><br><br>
</body>
</html>

