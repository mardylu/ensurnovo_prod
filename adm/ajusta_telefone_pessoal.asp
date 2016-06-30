
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

' ---------------------------------------------------------------

    Response.Write ( "<br><br>Início da atualização<br><br>" )


        ' LER OS ALUNOS - AJUSTA OS NÚMEROS DE TELEFONE PESSOAL A PARTIR DO TEL_DDI, TEL_DDD e TEL_NUM

        sql = "SELECT cod_aluno, telefone_pessoal, tel_ddi, tel_ddd, tel FROM aluno where telefone_pessoal is null OR telefone_pessoal=''"

        RS.Open sql

        while not RS.EOF

            cod_aluno = RS("COD_ALUNO")
            atualiza = ""

            tel_pessoal = RS("TELEFONE_PESSOAL")
            if  isNull(tel_pessoal)   then
                tel_pessoal = ""
            end if

            tel_pessoal =  RS("TEL_DDI") & RS("TEL_DDD") & RS("TEL")

            sql = "UPDATE aluno SET telefone_pessoal='"  & tel_pessoal  & "'  WHERE cod_aluno='" & cod_aluno & "'"
            Response.Write ("SQL: " & sql & "<br>")
            Con.execute (sql)

            qtde = qtde + 1
        	RS.MoveNext
        wend
        RS.Close

response.Write ("<br>")
response.Write ("Registros lidos e atualizados....: ") & qtde  & "<br>"

%>

<br><br><br><br>
</body>
</html>

