<%If session("key_ver")<>"ok" Then Response.Redirect "logout.asp"%>
<!-- #INCLUDE FILE="../library/parametros.asp" -->
<!-- #INCLUDE FILE="../library/conOpen.asp" -->
<!-- #INCLUDE FILE="../library/conOpenSIM.asp" -->
<!-- #INCLUDE FILE="../library/fErroMsg.asp" -->
<!-- #INCLUDE FILE="../library/fFormataData.asp" -->
<!-- #INCLUDE FILE="../library/fData.asp" -->
<!-- #INCLUDE FILE="../library/fCreateSel.asp" -->

<%

    SIGA_PROJETO=Session("siga_projeto")

    Dim strMes(13)

    strMes(0)  = ""
    strMes(1)  = "Janeiro"
    strMes(2)  = "Fevereiro"
    strMes(3)  = "Março"
    strMes(4)  = "Abril"
    strMes(5)  = "Maio"
    strMes(6)  = "Junho"
    strMes(7)  = "Julho"
    strMes(8)  = "Agosto"
    strMes(9)  = "Setembro"
    strMes(10) = "Outubro"
    strMes(11) = "Novembro"
    strMes(12) = "Dezembro"

%>

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

	<script type="text/javascript">
	 function newDoc1(ini_mes) {
		pv          = document.form.pv.value;
		ini_mes     = document.form.ini_mes.value;
		ini_ano     = document.form.ini_ano.value;
		fim_mes     = document.form.fim_mes.value;
		fim_ano     = document.form.fim_ano.value;
		curso       = document.form.curso.value;
		turma       = document.form.turma.value;
        estado      = document.form.estado.value;
		municipio   = document.form.municipio.value;
		prioridade  = document.form.prioridade.value;
		cpf_aluno   = document.form.cpf_aluno.value;
		url = 'gestao_situacao.asp?';
        url = url + 'pv='         + pv         + '&';
        url = url + 'ini_mes='    + ini_mes    + '&';
        url = url + 'ini_ano='    + ini_ano    + '&';
        url = url + 'fim_mes='    + fim_mes    + '&';
        url = url + 'fim_ano='    + fim_ano    + '&';
        url = url + 'curso='      + curso      + '&';
        url = url + 'turma='      + turma      + '&';
        url = url + 'estado='     + estado     + '&';
        url = url + 'municipio='  + municipio  + '&';
        url = url + 'prioridade=' + prioridade + '&';
        url = url + 'cpf_aluno='  + cpf_aluno;
        window.location=url;
	 }
	 function newDoc2(ini_ano) {
		pv          = document.form.pv.value;
		ini_mes     = document.form.ini_mes.value;
		ini_ano     = document.form.ini_ano.value;
		fim_mes     = document.form.fim_mes.value;
		fim_ano     = document.form.fim_ano.value;
		curso       = document.form.curso.value;
		turma       = document.form.turma.value;
        estado      = document.form.estado.value;
		municipio   = document.form.municipio.value;
		prioridade  = document.form.prioridade.value;
		cpf_aluno   = document.form.cpf_aluno.value;
		url = 'gestao_situacao.asp?';
        url = url + 'pv='         + pv         + '&';
        url = url + 'ini_mes='    + ini_mes    + '&';
        url = url + 'ini_ano='    + ini_ano    + '&';
        url = url + 'fim_mes='    + fim_mes    + '&';
        url = url + 'fim_ano='    + fim_ano    + '&';
        url = url + 'curso='      + curso      + '&';
        url = url + 'turma='      + turma      + '&';
        url = url + 'estado='     + estado     + '&';
        url = url + 'municipio='  + municipio  + '&';
        url = url + 'prioridade=' + prioridade + '&';
        url = url + 'cpf_aluno='  + cpf_aluno;
        window.location=url;
	 }
	 function newDoc3(fim_mes) {
		pv          = document.form.pv.value;
		ini_mes     = document.form.ini_mes.value;
		ini_ano     = document.form.ini_ano.value;
		fim_mes     = document.form.fim_mes.value;
		fim_ano     = document.form.fim_ano.value;
		curso       = document.form.curso.value;
		turma       = document.form.turma.value;
        estado      = document.form.estado.value;
		municipio   = document.form.municipio.value;
		prioridade  = document.form.prioridade.value;
		cpf_aluno   = document.form.cpf_aluno.value;
		url = 'gestao_situacao.asp?';
        url = url + 'pv='         + pv         + '&';
        url = url + 'ini_mes='    + ini_mes    + '&';
        url = url + 'ini_ano='    + ini_ano    + '&';
        url = url + 'fim_mes='    + fim_mes    + '&';
        url = url + 'fim_ano='    + fim_ano    + '&';
        url = url + 'curso='      + curso      + '&';
        url = url + 'turma='      + turma      + '&';
        url = url + 'estado='     + estado     + '&';
        url = url + 'municipio='  + municipio  + '&';
        url = url + 'prioridade=' + prioridade + '&';
        url = url + 'cpf_aluno='  + cpf_aluno;
        window.location=url;
	 }
	 function newDoc4(fim_ano) {
		pv          = document.form.pv.value;
		ini_mes     = document.form.ini_mes.value;
		ini_ano     = document.form.ini_ano.value;
		fim_mes     = document.form.fim_mes.value;
		fim_ano     = document.form.fim_ano.value;
		curso       = document.form.curso.value;
		turma       = document.form.turma.value;
        estado      = document.form.estado.value;
		municipio   = document.form.municipio.value;
		prioridade  = document.form.prioridade.value;
		cpf_aluno   = document.form.cpf_aluno.value;
		url = 'gestao_situacao.asp?';
        url = url + 'pv='         + pv         + '&';
        url = url + 'ini_mes='    + ini_mes    + '&';
        url = url + 'ini_ano='    + ini_ano    + '&';
        url = url + 'fim_mes='    + fim_mes    + '&';
        url = url + 'fim_ano='    + fim_ano    + '&';
        url = url + 'curso='      + curso      + '&';
        url = url + 'turma='      + turma      + '&';
        url = url + 'estado='     + estado     + '&';
        url = url + 'municipio='  + municipio  + '&';
        url = url + 'prioridade=' + prioridade + '&';
        url = url + 'cpf_aluno='  + cpf_aluno;
        window.location=url;
	 }
	 function newDoc5(curso) {
		pv          = document.form.pv.value;
		ini_mes     = document.form.ini_mes.value;
		ini_ano     = document.form.ini_ano.value;
		fim_mes     = document.form.fim_mes.value;
		fim_ano     = document.form.fim_ano.value;
		curso       = document.form.curso.value;
		turma       = document.form.turma.value;
        estado      = document.form.estado.value;
		municipio   = document.form.municipio.value;
		prioridade  = document.form.prioridade.value;
		cpf_aluno   = document.form.cpf_aluno.value;
		url = 'gestao_situacao.asp?';
        url = url + 'pv='         + pv         + '&';
        url = url + 'ini_mes='    + ini_mes    + '&';
        url = url + 'ini_ano='    + ini_ano    + '&';
        url = url + 'fim_mes='    + fim_mes    + '&';
        url = url + 'fim_ano='    + fim_ano    + '&';
        url = url + 'curso='      + curso      + '&';
        url = url + 'turma='      + turma      + '&';
        url = url + 'estado='     + estado     + '&';
        url = url + 'municipio='  + municipio  + '&';
        url = url + 'prioridade=' + prioridade + '&';
        url = url + 'cpf_aluno='  + cpf_aluno;
        window.location=url;
	 }
	 function newDoc6(turma) {
		pv          = document.form.pv.value;
		ini_mes     = document.form.ini_mes.value;
		ini_ano     = document.form.ini_ano.value;
		fim_mes     = document.form.fim_mes.value;
		fim_ano     = document.form.fim_ano.value;
		curso       = document.form.curso.value;
		turma       = document.form.turma.value;
        estado      = document.form.estado.value;
		municipio   = document.form.municipio.value;
		prioridade  = document.form.prioridade.value;
		cpf_aluno   = document.form.cpf_aluno.value;
		url = 'gestao_situacao.asp?';
        url = url + 'pv='         + pv         + '&';
        url = url + 'ini_mes='    + ini_mes    + '&';
        url = url + 'ini_ano='    + ini_ano    + '&';
        url = url + 'fim_mes='    + fim_mes    + '&';
        url = url + 'fim_ano='    + fim_ano    + '&';
        url = url + 'curso='      + curso      + '&';
        url = url + 'turma='      + turma      + '&';
        url = url + 'estado='     + estado     + '&';
        url = url + 'municipio='  + municipio  + '&';
        url = url + 'prioridade=' + prioridade + '&';
        url = url + 'cpf_aluno='  + cpf_aluno;
        window.location=url;
	 }
	 function newDoc7(estado) {
		pv          = document.form.pv.value;
		ini_mes     = document.form.ini_mes.value;
		ini_ano     = document.form.ini_ano.value;
		fim_mes     = document.form.fim_mes.value;
		fim_ano     = document.form.fim_ano.value;
		curso       = document.form.curso.value;
		turma       = document.form.turma.value;
        estado      = document.form.estado.value;
		municipio   = document.form.municipio.value;
		prioridade  = document.form.prioridade.value;
		cpf_aluno   = document.form.cpf_aluno.value;
		url = 'gestao_situacao.asp?';
        url = url + 'pv='         + pv         + '&';
        url = url + 'ini_mes='    + ini_mes    + '&';
        url = url + 'ini_ano='    + ini_ano    + '&';
        url = url + 'fim_mes='    + fim_mes    + '&';
        url = url + 'fim_ano='    + fim_ano    + '&';
        url = url + 'curso='      + curso      + '&';
        url = url + 'turma='      + turma      + '&';
        url = url + 'estado='     + estado     + '&';
        url = url + 'municipio='  + municipio  + '&';
        url = url + 'prioridade=' + prioridade + '&';
        url = url + 'cpf_aluno='  + cpf_aluno;
        window.location=url;
	 }
	 function newDoc8(municipio) {
		pv          = document.form.pv.value;
		ini_mes     = document.form.ini_mes.value;
		ini_ano     = document.form.ini_ano.value;
		fim_mes     = document.form.fim_mes.value;
		fim_ano     = document.form.fim_ano.value;
		curso       = document.form.curso.value;
		turma       = document.form.turma.value;
        estado      = document.form.estado.value;
		municipio   = document.form.municipio.value;
		prioridade  = document.form.prioridade.value;
		cpf_aluno   = document.form.cpf_aluno.value;
		url = 'gestao_situacao.asp?';
        url = url + 'pv='         + pv         + '&';
        url = url + 'ini_mes='    + ini_mes    + '&';
        url = url + 'ini_ano='    + ini_ano    + '&';
        url = url + 'fim_mes='    + fim_mes    + '&';
        url = url + 'fim_ano='    + fim_ano    + '&';
        url = url + 'curso='      + curso      + '&';
        url = url + 'turma='      + turma      + '&';
        url = url + 'estado='     + estado     + '&';
        url = url + 'municipio='  + municipio  + '&';
        url = url + 'prioridade=' + prioridade + '&';
        url = url + 'cpf_aluno='  + cpf_aluno;
        window.location=url;
	 }
	 function newDoc9(prioridade) {
		pv          = document.form.pv.value;
		ini_mes     = document.form.ini_mes.value;
		ini_ano     = document.form.ini_ano.value;
		fim_mes     = document.form.fim_mes.value;
		fim_ano     = document.form.fim_ano.value;
		curso       = document.form.curso.value;
		turma       = document.form.turma.value;
        estado      = document.form.estado.value;
		municipio   = document.form.municipio.value;
		prioridade  = document.form.prioridade.value;
		cpf_aluno   = document.form.cpf_aluno.value;
		url = 'gestao_situacao.asp?';
        url = url + 'pv='         + pv         + '&';
        url = url + 'ini_mes='    + ini_mes    + '&';
        url = url + 'ini_ano='    + ini_ano    + '&';
        url = url + 'fim_mes='    + fim_mes    + '&';
        url = url + 'fim_ano='    + fim_ano    + '&';
        url = url + 'curso='      + curso      + '&';
        url = url + 'turma='      + turma      + '&';
        url = url + 'estado='     + estado     + '&';
        url = url + 'municipio='  + municipio  + '&';
        url = url + 'prioridade=' + prioridade + '&';
        url = url + 'cpf_aluno='  + cpf_aluno;
        window.location=url;
	 }
	 function newDoc10(cpf) {
		pv          = document.form.pv.value;
		ini_mes     = document.form.ini_mes.value;
		ini_ano     = document.form.ini_ano.value;
		fim_mes     = document.form.fim_mes.value;
		fim_ano     = document.form.fim_ano.value;
		curso       = document.form.curso.value;
		turma       = document.form.turma.value;
        estado      = document.form.estado.value;
		municipio   = document.form.municipio.value;
		prioridade  = document.form.prioridade.value;
		cpf_aluno   = document.form.cpf_aluno.value;
		url = 'gestao_situacao.asp?';
        url = url + 'pv='         + pv         + '&';
        url = url + 'ini_mes='    + ini_mes    + '&';
        url = url + 'ini_ano='    + ini_ano    + '&';
        url = url + 'fim_mes='    + fim_mes    + '&';
        url = url + 'fim_ano='    + fim_ano    + '&';
        url = url + 'curso='      + curso      + '&';
        url = url + 'turma='      + turma      + '&';
        url = url + 'estado='     + estado     + '&';
        url = url + 'municipio='  + municipio  + '&';
        url = url + 'prioridade=' + prioridade + '&';
        url = url + 'cpf_aluno='  + cpf_aluno;
        window.location=url;
	 }
	 function planilha() {
		pv          = document.form.pv.value;
		ini_mes     = document.form.ini_mes.value;
		ini_ano     = document.form.ini_ano.value;
		fim_mes     = document.form.fim_mes.value;
		fim_ano     = document.form.fim_ano.value;
		curso       = document.form.curso.value;
		turma       = document.form.turma.value;
        estado      = document.form.estado.value;
		municipio   = document.form.municipio.value;
		prioridade  = document.form.prioridade.value;
		cpf_aluno   = document.form.cpf_aluno.value;
		url = 'gestao_situacao.asp?';
        url = url + 'pv='         + pv         + '&';
        url = url + 'ini_mes='    + ini_mes    + '&';
        url = url + 'ini_ano='    + ini_ano    + '&';
        url = url + 'fim_mes='    + fim_mes    + '&';
        url = url + 'fim_ano='    + fim_ano    + '&';
        url = url + 'curso='      + curso      + '&';
        url = url + 'turma='      + turma      + '&';
        url = url + 'estado='     + estado     + '&';
        url = url + 'municipio='  + municipio  + '&';
        url = url + 'prioridade=' + prioridade + '&';
        url = url + 'cpf_aluno='  + cpf_aluno  + '&';
        url = url + 'planilha=OK';
        ;
        window.location=url;
	 }
	</script>

	<title>ENSUR Inscrições</title>
</head>
<body>
<div id="pagina">
	<div id="conteudo">
		<%
		Set RS1 = Server.CreateObject("ADODB.Recordset")
		RS1.CursorType = 0
		RS1.ActiveConnection = Con

		Set RS2 = Server.CreateObject("ADODB.Recordset")
		RS2.CursorType = 0
		RS2.ActiveConnection = Con

		Set RS3 = Server.CreateObject("ADODB.Recordset")
		RS3.CursorType = 0
		RS3.ActiveConnection = Con

'		stt        =request("stt")
'		st         = request("st")
'		ano        = request("ano")
'		ord        = request("ord")

		pv         = request("pv")
        planilha   = request("planilha")

		ini_mes    = request("ini_mes")
		ini_ano    = request("ini_ano")
		fim_mes    = request("fim_mes")
		fim_ano    = request("fim_ano")
		curso      = request("curso")
		turma      = request("turma")
		estado     = request("estado")
		municipio  = request("municipio")
		prioridade = request("prioridade")
		cpf_aluno  = request("cpf_aluno")

        if (len(ini_mes) = 0 ) then ini_mes = "00"          end if
        if (len(ini_mes) = 1 ) then ini_mes = "0" & ini_mes end if
        if (len(fim_mes) = 0 ) then fim_mes = "13"          end if
        if (len(fim_mes) = 1 ) then fim_mes = "0" & fim_mes end if
		if pv=""            or isNumeric(pv)=false          then pv=0
		if ini_mes=""       or isNumeric(ini_mes)=false     then ini_mes=0
		if ini_ano=""       or isNumeric(ini_ano)=false     then ini_ano=2016
		if fim_mes=""       or isNumeric(fim_mes)=false     then fim_mes=0
		if fim_ano=""       or isNumeric(fim_ano)=false     then fim_ano=2016
		if curso=""         or isNumeric(curso)=false       then curso=0
		if turma=""         or isNumeric(turma)=false       then turma=0
		if estado=""        or isNumeric(estado)=false      then estado=0
		if municipio=""     or isNumeric(municipio)=false   then municipio=0
'		if prioridade=""    or isNumeric(prioridade)=false  then prioridade=0
		if cpf_aluno=""     or isNumeric(cpf_aluno)=false   then cpf_aluno=0


		%>


    <%
' ======================================================================================================
'       GERAR PLANILHA
' ======================================================================================================
    if ( planilha = "OK" )    then
        data_inicio = ini_ano & ini_mes & "01"
        data_final  = fim_ano & fim_mes & "31"

        sql_alunos = "SELECT   A.COD_ALUNO, A.NOME, A.CPF, A.COD_UF_IBGE, A.COD_MUNI_IBGE, "    & _
                     "         A.EFETIVO, A.TIPOENTI, A.CARGO, "                                & _
                     "         B.PRIORIDADE, B.UF_SIGLA, B.NOME_CIDADE, "                       & _
                     "         TA.COD_CURSO, TA.ID_INSCRICAO, TA.ENTURMADO, TA.CERTIFICADO, "   & _
                     "         TA.STATUS, "                                                     & _
                     "         T.ID_TURMA, T.DT_INICIO_TURMA, T.DT_FIM_TURMA, T.CODIGO_TURMA, " & _
                     "         T.ID_PROFESSOR, "                                                & _
                     "         C.TITULO, CT.DESCRICAO "                                         & _
                     "         FROM  ALUNO as A "                                               & _
                     "         JOIN  TURMA_ALUNO as TA  ON TA.COD_ALUNO=A.COD_ALUNO"            & _
                     "         JOIN  CURSO as C         ON TA.COD_CURSO=C.COD_CURSO"            & _
                     "         JOIN  TURMAS as T        ON TA.ID_TURMA=T.ID_TURMA"              & _
                     "         JOIN  CURSO_TIPO as CT   ON T.COD_TIPO=CT.COD_TIPO"              & _
                     "         LEFT JOIN  BIOMA_CIDADE as B  ON B.COD_UF_IBGE=A.COD_UF_IBGE AND"     & _
                     "                                     B.COD_MUNI_IBGE=A.COD_MUNI_IBGE"     & _
                     "         WHERE A.COD_ALUNO>0 "

        if ( data_inicio>1)  then sql_alunos = sql_alunos & "           AND T.DT_INICIO_TURMA>='" & data_inicio  & "'"  end if
        if ( data_final>31)  then sql_alunos = sql_alunos & "           AND T.DT_FIM_TURMA<='"    & data_final   & "'"  end if
        if ( curso<>0)       then sql_alunos = sql_alunos & "           AND TA.COD_CURSO='"       & curso        & "'"  end if
        if ( turma<>0)       then sql_alunos = sql_alunos & "           AND TA.ID_TURMA='"        & turma        & "'"  end if
        if ( estado<>0)      then sql_alunos = sql_alunos & "           AND A.COD_UF_IBGE='"      & estado       & "'"  end if
        if ( municipio<>0)   then sql_alunos = sql_alunos & "           AND A.COD_MUNI_IBGE='"    & municipio    & "'"  end if
        if ( prioridade<>"") then sql_alunos = sql_alunos & "           AND B.PRIORIDADE='"       & prioridade   & "'"  end if
        if ( cpf_aluno<>0)   then sql_alunos = sql_alunos & "           AND A.CPF='"              & cpf_aluno    & "'"  end if
        sql_alunos = sql_alunos & "         ORDER BY C.TITULO, TA.ID_TURMA, A.NOME"

' Response.Write sql_alunos
' Response.Write "<br><br>"

        RS.Open sql_alunos

' Response.Write "<br><br>pv: "
' Response.Write pv
' Response.Write "<br><br>"
' Response.End



		if RS.EOF then
			%><p>Nenhum aluno cadastrado que atenda aos filtros selecionados</p><%
		else
            Response.ContentType = "application/vnd.ms-excel"
            Response.AddHeader "Content-Disposition","attachment;filename=planilha.xls" & fn
			%>

			<table>
			<tr>
        		<td> Curso</td>
        		<td> Turma</td>
        		<td> Modalidade</td>
        		<td> Inicio</td>
        		<td> Término</td>
        		<td> Tutor</td>
        		<td> CPF</td>
        		<td> Aluno</td>
        		<td> UF</td>
        		<td> Município</td>
        		<td> Prioridade</td>
        		<td> Geocódigo</td>
        		<td> UF Entidade</td>
        		<td> Município Entidade</td>
        		<td> Prioridade Entidade</td>
        		<td> Geocódigo Entidade</td>
        		<td> Efetivo</td>
        		<td> Natureza</td>
        		<td> Cargo</td>
        		<td> Espera</td>
        		<td> Enturmado</td>
        		<td> Certificado</td>
        		<td> Aprovado</td>
        		<td> Reprovado</td>
			</tr>

            <tr>
			<%
			qtde = 0
            bgtr = 0
			while not RS.EOF
                uf_aluno    = RS("UF_SIGLA")
                muni_aluno  = RS("NOME_CIDADE")
                Response.Write ("<tr>")
				qtde = qtde + 1
                Response.Write ("<td>" & RS("TITULO")           & "</td>")
                Response.Write ("<td>" & RS("CODIGO_TURMA")     & "</td>")
                Response.Write ("<td>" & RS("DESCRICAO") & "</td>")
                Response.Write ("<td>" & formataData(RS("DT_INICIO_TURMA")) & "</td>")
                Response.Write ("<td>" & formataData(RS("DT_FIM_TURMA")) & "</td>")
                sql_professor = "SELECT NOME_FANTASIA FROM PROFESSORES WHERE ID_PROFESSOR='" & RS("ID_PROFESSOR")  & "'"
                RS1.Open sql_professor
                if not RS1.EOF then Response.Write ("<td>" & RS1("NOME_FANTASIA") & "</td>")  end if
                if     RS1.EOF then Response.Write ("<td>" & " - " & "</td>")  end if
                RS1.Close
                Response.Write ("<td>" & mid(RS("CPF"),1,2) & "."   & _
                                         mid(RS("CPF"),3,3) & "."   & _
                                         mid(RS("CPF"),6,3) & "-"   & _
                                         mid(RS("CPF"),9,2) & "</td>")
'               Response.Write ("<td>" & RS("CPF") & "</td>")
                Response.Write ("<td>" & RS("NOME") & "</td>")


                ' ALUNO - UF, Município, Prioridade, Geocódigo
            	sql_muni_aluno = "SELECT M.COD_UF_IBGE, M.COD_MUNI_IBGE, M.NOME_MUNI, U.SIGLA_UF        " & _
                                 "  FROM MUNICIPIOS AS M                                                " & _
                                 "  JOIN UF         AS U  ON U.COD_UF_IBGE = M.COD_UF_IBGE              " & _
                                 " WHERE M.COD_UF_IBGE='"   & RS("COD_UF_IBGE")     & "'"                 & _
                                 "   AND M.COD_MUNI_IBGE='" & RS("COD_MUNI_IBGE")   & "'"
                RSSIM.Open sql_muni_aluno
            	if not RSSIM.eof then
                    uf_aluno   = RSSIM("SIGLA_UF")
                    muni_aluno = RSSIM("NOME_MUNI")
                end if
                RSSIM.Close
                Response.Write ("<td>" & uf_aluno & "</td>")
                Response.Write ("<td>" & muni_aluno & "</td>")
'                Response.Write ("<td>" & RS("UF_SIGLA") & "</td>")
'                Response.Write ("<td>" & RS("NOME_CIDADE") & "</td>")
                Response.Write ("<td>" & RS("PRIORIDADE") & "</td>")
                if ( len(RS("COD_MUNI_IBGE")) = 5 ) then geocodigo = RS("COD_MUNI_IBGE")  end if
                if ( len(RS("COD_MUNI_IBGE")) = 4 ) then geocodigo = "0"    & RS("COD_MUNI_IBGE")  end if
                if ( len(RS("COD_MUNI_IBGE")) = 3 ) then geocodigo = "00"   & RS("COD_MUNI_IBGE")  end if
                if ( len(RS("COD_MUNI_IBGE")) = 2 ) then geocodigo = "000"  & RS("COD_MUNI_IBGE")  end if
                geocodigo = RS("COD_UF_IBGE") & geocodigo
                Response.Write ("<td>" & geocodigo & "</td>")


                ' ENTIDADE - UF, Município, Prioridade, Geocódigo
            	sql_muni_enti  = "SELECT M.COD_UF_IBGE, M.COD_MUNI_IBGE, M.NOME_MUNI, U.SIGLA_UF        " & _
                                 "  FROM MUNICIPIOS AS M                                                " & _
                                 "  JOIN UF         AS U  ON U.COD_UF_IBGE = M.COD_UF_IBGE              " & _
                                 " WHERE M.COD_UF_IBGE='"   & RS("COD_UF_IBGE")     & "'"                 & _
                                 "   AND M.COD_MUNI_IBGE='" & RS("COD_MUNI_IBGE")   & "'"
                RSSIM.Open sql_muni_enti
            	if not RSSIM.eof then
                    uf_enti   = RSSIM("SIGLA_UF")
                    muni_enti = RSSIM("NOME_MUNI")
                end if
                if ( len(RSSIM("COD_MUNI_IBGE")) = 5 ) then geo_enti = RSSIM("COD_MUNI_IBGE")  end if
                if ( len(RSSIM("COD_MUNI_IBGE")) = 4 ) then geo_enti = "0"    & RSSIM("COD_MUNI_IBGE")  end if
                if ( len(RSSIM("COD_MUNI_IBGE")) = 3 ) then geo_enti = "00"   & RSSIM("COD_MUNI_IBGE")  end if
                if ( len(RSSIM("COD_MUNI_IBGE")) = 2 ) then geo_enti = "000"  & RSSIM("COD_MUNI_IBGE")  end if
                geo_enti = RSSIM("COD_UF_IBGE") & geo_enti
                RSSIM.Close
                sql_cidade_enti = "SELECT COD_UF_IBGE, COD_MUNI_IBGE, GEOCODIGO, UF_SIGLA, NOME_CIDADE, PRIORIDADE "    & _
                                  "       FROM BIOMA_CIDADE "                                                           & _
                                  " WHERE COD_UF_IBGE='"   & RS("COD_UF_IBGE")   & "' "                                 & _
                                  "   AND COD_MUNI_IBGE='" & RS("COD_MUNI_IBGE") & "'"
                RS1.Open sql_cidade_enti
                if not RS1.EOF then
                        Response.Write ("<td>" & uf_enti & "</td>")
                        Response.Write ("<td>" & muni_enti & "</td>")
                        Response.Write ("<td>" & RS1("PRIORIDADE") & "</td>")
                        Response.Write ("<td>" & geo_enti & "</td>")
                end if
                if     RS1.EOF then
                        Response.Write ("<td>" & uf_enti & "</td>")
                        Response.Write ("<td>" & muni_enti & "</td>")
                        Response.Write ("<td>" & " - " & "</td>")
                        Response.Write ("<td>" & geo_enti & "</td>")
                end if
                RS1.Close















                Response.Write ("<td>" & RS("EFETIVO") & "</td>")
            	sql_entidade = "SELECT DESCRICAO FROM TIPO_ENTIDADE WHERE ID_TIPO_ENTIDADE='" & RS("TIPOENTI") & "'"
            	RSSIM.Open sql_entidade
            	if not RSSIM.eof then
                    natureza_enti=RSSIM("DESCRICAO")
                else
            		natureza_enti=" - "
            	end if
            	RSSIM.Close
                Response.Write ("<td>" & natureza_enti & "</td>")
                Response.Write ("<td>" & RS("CARGO") & "</td>")

            	sql = "SELECT COUNT (A.COD_ALUNO) AS QTDE FROM TURMA_ALUNO  AS A "  _
                    & " LEFT JOIN TURMAS AS T ON A.id_turma=T.id_turma "            _
                    & " WHERE T.SIGA_PROJETO=2 AND A.COD_ALUNO="&RS("COD_ALUNO")    _
                    & "   AND T.COD_STATUS_TURMA=2"
            	RS3.Open sql
                Response.Write ("<td align='center'>")
            	if not RS3.eof then
                    Response.Write(RS3("QTDE"))
                else
                    Response.Write(" ")
            	end if
            	RS3.Close
                Response.Write ("</td>")


                Response.Write ("<td align='center'>" & RS("ENTURMADO") & "</td>")
                Response.Write ("<td align='center'>" & RS("CERTIFICADO") & "</td>")

                aprovado = "não"
                if ( RS("STATUS") =  "APROVADO" )   then
                    aprovado = "sim"
                else
                    aprovado = " - "
                end if
                Response.Write ("<td align='center'>" & aprovado & "</td>")

                reprovado = "não"
                if ( RS("STATUS") =  "REPROVADO" )   then
                    reprovado = "sim"
                else
                    reprovado = " - "
                end if
                Response.Write ("<td align='center'>" & reprovado & "</td>")

                Response.Write ("</tr>")
                if ( bgtr = 0 ) then bgtr = 1 else bgtr = 0 end if
				RS.MoveNext
			wend
		end if
		RS.Close
 	%>
		</table>

	<%
    end if
'   ========<   FINAL DO LOOP DE ALUNOS    >========

' ======================================================================================================
' ======================================================================================================
    %>






    </div>
</div>
</body>
</html>



