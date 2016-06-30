<%If session("adm")<>"ok" Then Response.Redirect "logout.asp"%>
<!-- #INCLUDE FILE="../library/parametros.asp" -->
<!-- #INCLUDE FILE="../library/conOpen.asp" -->
<!-- #INCLUDE FILE="../library/conOpenSIM.asp" -->
<!-- #INCLUDE FILE="../library/fErroMsg.asp" -->
<!-- #INCLUDE FILE="../library/fData.asp" -->
<!-- #INCLUDE FILE="../library/fPagamentos.asp" -->
<!-- #INCLUDE FILE="../library/fCreateSel.asp" -->
<!-- #INCLUDE FILE="../library/fFormataValor.asp" -->
<!-- #INCLUDE FILE="../library/fFormataCep.asp" -->
<!-- #INCLUDE FILE="../library/fFormataCPF.asp" -->
<!-- #INCLUDE FILE="../library/vAprova.asp" -->
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

	<title>ENSUR Inscrições</title>
	<script type="text/javascript" src="../js/validacao_pb.js"></script>
	<script type="text/javascript" src="../js/mascara.js"></script>
</head>
<body>


<%
    CONTADOR=0

    sqla="SELECT COUNT(COD_ALUNO) AS QTD FROM ALUNO"
    RS.Open sqla
    Response.Write sqla&"<BR>"
    Response.Write("Quantidade: "&RS("QTD")&"<BR>")
    RS.Close

    sql = "SELECT COD_ALUNO, tipoEnti, COD_ENTI FROM ALUNO"
Response.Write sql&"<BR>"

        RS.Open sql

        while not RS.eof

            CONTADOR=CONTADOR+1

            Response.Write("COD_ALUNO: "&RS("COD_ALUNO")&"<BR>")
            Response.Write("tipoEnti: "&RS("tipoEnti")&"<BR>")
            Response.Write("COD_ENTI: "&RS("COD_ENTI")&"<BR>")
' Response.End
            COD_ENTI=RS("COD_ENTI")
            if isNull(COD_ENTI) then COD_ENTI=11896
            if (COD_ENTI=0) then COD_ENTI=11896

            COD_ALUNO_UPDATE=RS("COD_ALUNO")

            sql_enti = "SELECT * FROM ENTIDADES WHERE COD_ENTI="&COD_ENTI
Response.Write sql_enti&"<BR>"
            RSSIM.Open sql_enti
            TIPO_ENTI_SIM=RSSIM("ID_TIPO_ENTIDADE")
            Response.Write("ID_TIPO_ENTIDADE: "&TIPO_ENTI_SIM&"<BR><BR><BR>")
            RSSIM.Close

            sqlU = "UPDATE ALUNO SET tipoEnti="&TIPO_ENTI_SIM&" WHERE COD_ALUNO="&COD_ALUNO_UPDATE
Response.Write sqlU&"<BR>"
            con.execute sqlU

            RS.movenext
        wend

        RS.Close

Response.Write(CONTADOR)

%>
</body>
</html>

<%conClose%>


