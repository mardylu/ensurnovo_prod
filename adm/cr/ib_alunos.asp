<!-- #INCLUDE FILE="../../library/parametros.asp" -->
<!-- #INCLUDE FILE="../../library/conOpen.asp" -->
<!-- #INCLUDE FILE="../../library/conOpenSIM.asp" -->

<%

 Response.AddHeader "Access-Control-Allow-Origin" , "*"
 Response.AddHeader "Access-Control-Allow-Methods" , "GET, PUT, POST, DELETE, OPTIONS"


'   response.CharSet="iso-8859-1"
    Response.CharSet="utf-8"

    Set RS1 = Server.CreateObject("ADODB.Recordset")
    RS1.CursorType = 3
    RS1.ActiveConnection = Con

    Set RS2 = Server.CreateObject("ADODB.Recordset")
    RS2.CursorType = 3
    RS2.ActiveConnection = Con

    cod_municipio = request("municipio")
    cod_estado    = request("estado")

    retorno=""
    flag = 0

' ----------------------- SQL -----------------------------------

  sql = "SELECT * FROM aluno WHERE cod_uf_ibge='" & cod_estado & "' AND cod_muni_ibge='" & cod_municipio & "' order by nome"
'   sql = "SELECT * FROM aluno WHERE cod_uf_ibge='33' AND cod_muni_ibge='4557'"
'   Response.Write sql
' =======================<  ALUNOS  >=======================

' Montar uma variável com todos os alunos. Ou seja, com todo o resultado do select formatado em html
' e dentro de uma única variável.

' No final do script ResponseWrite(retorno)

    RS1.Open sql
    if not RS1.EOF then
            DO While NOT RS1.EOF
                telefone = RS1("TEL_DDD") & RS1("TEL")
                cod_entidade = RS1("COD_ENTI")
                if (RS1("ASSOCIADO") = true) then
                    associado = "Sim"
                else
                    associado = "Não"
                end if

                sql1 = "SELECT NOME FROM ENTIDADES WHERE COD_ENTI=" & cod_entidade
' Response.Write "<br>" & sql1
                RSSIM.Open sql1
                if not RSSIM.EOF then
                    instituicao = RSSIM("NOME")
                end if
                RSSIM.Close

                ' Response.Write "<br>" & RS1("NOME")  & " - " & telefone & " - " & associado & " - " & instituicao


                if (flag = 0) then
                    retorno = retorno & "<center><br>"
                    retorno = retorno & "<table border='1' width='96%' class='espaco'>"
                    retorno = retorno & "<tr>"
                    retorno = retorno & "<td width='5%' align='center'><b>Ordem</b></td>"
                    retorno = retorno & "<td width='35%' align='center'><b>Nome</b></td>"
                    retorno = retorno & "<td width='10%' align='center'><b>CPF</b></td>"
                    retorno = retorno & "<td width='10%' align='center'><b>Telefone</b></td>"
                    retorno = retorno & "<td width='15%' align='center'><b>E-mail</b></td>"
                    retorno = retorno & "<td width='20%' align='center'><b>Instituição</b></td>"
                    retorno = retorno & "<td width='5%' align='center'><b>Associado</b></td>"
                    retorno = retorno & "</tr>"
                end if

                contador = contador + 1
                retorno = retorno & "<tr>"
                retorno = retorno & "<td width='5%' align='center'>" & contador       & "</td>"
                retorno = retorno & "<td width='35%' align='center'>" & RS1("NOME")   & "</td>"
                retorno = retorno & "<td width='10%' align='center'>" & RS1("CPF")    & "</td>"
                retorno = retorno & "<td width='10%' align='center'>" & telefone      & "</td>"
                retorno = retorno & "<td width='15%' align='center'>" & RS1("EMAIL")  & "</td>"
                retorno = retorno & "<td width='20%' align='center'>" & instituicao   & "</td>"
                retorno = retorno & "<td width='5%' align='center'>" & associado      & "</td>"
                retorno = retorno & "</tr>"

                flag = 1

                RS1.MoveNext
            LOOP
'            Response.Write "<br>Dentro do IF depois do While"
        else
    		retorno  = sql & "<br>Não existe aluno neste município.<br>"
            Response.Write retorno
    End if

    if (flag = 1) then
        retorno = retorno & "</table>"
        retorno = retorno & "<br></center>"
    end if

    RS1.Close

'    Response.End

    Response.Write retorno
%>