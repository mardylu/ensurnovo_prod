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

    sql = "SELECT DISTINCT(a.cod_curso), c.nome_fantasia, c.dt_inicio_turma FROM turma_aluno as a "     _
          &      "JOIN aluno  as b on a.cod_aluno=b.cod_aluno  "     _
          &      "JOIN turmas as c on a.cod_curso=c.cod_curso  "     _
          &      "WHERE cod_uf_ibge='" & cod_estado & "' AND cod_muni_ibge='" & cod_municipio & "' order by a.cod_curso DESC"

    Response.Write sql
'   Response.End
' =======================<  CURSOS  >=======================

' Montar uma variável com todos os cursos. Ou seja, com todo o resultado do select formatado em html
' e dentro de uma única variável.

' No final do script ResponseWrite(retorno)

    RS1.Open sql
    if not RS1.EOF then
            DO While NOT RS1.EOF
//                telefone = RS1("TEL_DDD") & RS1("TEL")
//                cod_entidade = RS1("COD_ENTI")
//                if (RS1("ASSOCIADO") = true) then
//                    associado = "Sim"
//                else
//                    associado = "Não"
//                end if

                if (flag = 0) then
                    retorno = retorno & "<center><br>"
                    retorno = retorno & "<table border='1' width='96%' class='espaco'>"
                    retorno = retorno & "<tr>"
                    retorno = retorno & "<td width='5%' align='center'><b>Ordem</b></td>"
                    retorno = retorno & "<td width='35%' align='center'><b>Curso</b></td>"
                    retorno = retorno & "<td width='10%' align='center'><b>Data</b></td>"
                    retorno = retorno & "</tr>"
                end if

                contador = contador + 1
                retorno = retorno & "<tr>"
                retorno = retorno & "<td width='5%' align='center'>" & contador       & "</td>"
                retorno = retorno & "<td width='35%' align='center'>" & RS1("NOME_FANTASIA")   & "</td>"
                retorno = retorno & "<td width='10%' align='center'>" & RS1("DT_INICIO_TURMA")    & "</td>"
                retorno = retorno & "</tr>"

                flag = 1

                RS1.MoveNext
            LOOP
'            Response.Write "<br>Dentro do IF depois do While"
        else
    		retorno  = sql & "<br>Não existe curso neste município.<br>"
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