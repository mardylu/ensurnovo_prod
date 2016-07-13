<%If session("key_ver")<>"ok" Then Response.Redirect "logout.asp"%>
<!-- #INCLUDE FILE="../library/parametros.asp" -->
<!-- #INCLUDE FILE="../library/conOpenAF.asp" -->
<!-- #INCLUDE FILE="../library/conOpen.asp" -->
<!-- #INCLUDE FILE="../library/conOpenSIM.asp" -->
<!-- #INCLUDE FILE="../library/fErroMsg.asp" -->
<!-- #INCLUDE FILE="../library/fData.asp" -->
<!-- #INCLUDE FILE="../library/fCreateSel.asp" -->
<!-- #INCLUDE FILE="../library/fEmail.asp" -->
<!-- #INCLUDE FILE="../library/vAprova.asp" -->
<!-- #INCLUDE FILE="../library/vFormaPgt.asp" -->
<!-- #INCLUDE FILE="../library/fFormataValor.asp" -->
<!-- #INCLUDE FILE="../library/fFormataData.asp" -->
<!-- #INCLUDE FILE="../library/fFormataCep.asp" -->
<!-- #INCLUDE FILE="../library/fFormataCPF.asp" -->
<!-- #include file="./fpdf.asp" -->

<%
if Session("key_sta")="ok" or Session("key_ema")="ok" or Session("key_plc")="ok" or Session("key_plp")="ok" then
	mostraSel = true
else
	mostraSel = false
end if

Set RS1 = Server.CreateObject("ADODB.Recordset")
RS1.CursorType = 0
RS1.ActiveConnection = Con

Set RS2 = Server.CreateObject("ADODB.Recordset")
RS2.CursorType = 0
RS2.ActiveConnection = Con

Set RS3 = Server.CreateObject("ADODB.Recordset")
RS3.CursorType = 0
RS3.ActiveConnection = Con

Set RS4 = Server.CreateObject("ADODB.Recordset")
RS4.CursorType = 0
RS4.ActiveConnection = Con


SIGA_PROJETO=Session("siga_projeto")


%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">


	<title>ENSUR Inscrições</title>
	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
	<script>

		function checkForm() {
			f = document.formAlunos;
			if (f.task.selectedIndex===0) {
				alert('Selecionar uma ação');
				return false;
			}
			var sel = false;
			for (var i = 0; i < f.elements.length; i++ ) {
				if (f.elements[i].type == 'checkbox') {
					if (f.elements[i].checked === true) {
						sel = true;
						break;
					}
				}
			}
			if (!sel) {
				alert('Selecionar ao menos um aluno');
				return false;
			}
			if (f.task.value==='planilha') {
			    if (SIGA_PROJETO=2)  {
				    f.action = "gera_excelpqga.asp";
                } else {
				    f.action = "gera_excel.asp";
                }
			} else if (f.task.value==='planilhp') {
			            if (SIGA_PROJETO=2)  {
				            f.action = "gera_excelpqga.asp?p=1";
                        } else {
				            f.action = "gera_excel.asp?p=1";
                        }
			} else {
				f.action = "gestao_selecao.asp";
			}
			return true
		}

		function checkAll(val) {
			f = document.formAlunos;
			for (var i = 0; i < f.elements.length; i++ ) {
				if (f.elements[i].type == 'checkbox') {
					f.elements[i].checked = val;
				}
			}
		}

		function checkOne(val) {
			f = document.formAlunos;
			if (!val) {
				f.main.checked = false;
			}
		}

		function checkAcao(val) {
			if (val==='curso') {
				document.getElementById('cursoDados').style.display = 'block';
			} else {
				document.getElementById('cursoDados').style.display = 'none';
			}
		}

		function Acertatexto(id_mensagem) {
        	var destino = 'HTTP://cursos.ibam.org.br/adm/acertatexto.asp?id_msg='+id_mensagem;

		    $.ajax({
		        type: 'POST',
		        url: destino,
		        success: function (data) {
			        document.getElementById("MSG").value = data;
		        }
		    });
		}

	function newDoc1() {
		cod             = document.formAlunos.cod.value;
		ord             = document.formAlunos.ord.value;
		st              = document.formAlunos.st.value;
		tipo_enti       = document.formAlunos.tipo_enti.value;
		area_atu        = document.formAlunos.area_atu.value;
		escolaridade    = document.formAlunos.escolaridade.value;
		prioridade      = document.formAlunos.prioridade.value;
		bioma           = document.formAlunos.bioma.value;
		funciona        = document.formAlunos.funciona.value;
		termo           = document.formAlunos.termo.value;
		url = 'gestao_selecao.asp?';
        url = url + 'cod='          + cod           + '&';
        url = url + 'ord='          + ord           + '&';
        url = url + 'st='           + st            + '&';
        url = url + 'tipo_enti='    + tipo_enti     + '&';
        url = url + 'area_atu='     + area_atu      + '&';
        url = url + 'escolaridade=' + escolaridade  + '&';
        url = url + 'prioridade='   + prioridade    + '&';
        url = url + 'bioma='        + bioma         + '&';
        url = url + 'funciona='     + funciona      + '&';
        url = url + 'termo='        + termo;
        window.location=url;
	}

	</script>
</head>

<body onLoad="checkAcao(document.formAlunos.task.value);">
<div id="pagina">
	<!-- #INCLUDE FILE="include/topo.asp" -->
	<div id="conteudo">
		<%
		cod = request("cod")
		if cod="" or isNumeric(cod)=false then erroMsg("Curso não encontrado")
		cod = int(cod)
'   	sql = "SELECT T.ID_TURMA,T.DT_INICIO_TURMA,T.CODIGO_TURMA,T.DT_FIM_TURMA,T.VALOR,T.COD_STATUS_TURMA,TS.STATUS_TURMA,(SELECT TITULO FROM CURSO WHERE COD_CURSO=T.COD_CURSO) AS TITULO FROM TURMAS T JOIN TURMA_STATUS TS ON T.COD_STATUS_TURMA=TS.COD_STATUS_TURMA WHERE T.ID_TURMA="&cod
		sql =   "SELECT T.ID_TURMA,T.DT_INICIO_TURMA,T.CODIGO_TURMA,T.DT_FIM_TURMA,T.VALOR,T.COD_STATUS_TURMA, "      & _
                "TS.STATUS_TURMA,(SELECT TITULO FROM CURSO WHERE COD_CURSO=T.COD_CURSO) AS TITULO FROM TURMAS T "     & _
                "JOIN TURMA_STATUS TS ON T.COD_STATUS_TURMA=TS.COD_STATUS_TURMA WHERE T.ID_TURMA="&cod
		RS.Open sql
		if RS.EOF then erroMsg("Turma não encontrado")
		curso_tit = RS("TITULO")
		CODIGO_TURMA = RS("CODIGO_TURMA")
		DT_INICIO_TURMA = RS("DT_INICIO_TURMA")
		DT_FIM_TURMA = RS("DT_FIM_TURMA")
		VALOR = RS("VALOR")
		STATUS_TURMA = RS("STATUS_TURMA")
		RS.Close
		st = request("st")
		if st="" or isNumeric(st)=false then st=0
		' if st=0 then st = 11  end if
		st = int(st)

		ord = request("ord")
		select case ord
			case "cp": sqlord = "CPF"
			case "ti": sqlord = "TIPOENTI"                          ' tipo da instituição
			case "uf": sqlord = "COD_UF_IBGE"                       ' estado (código ibge)
			case "dc": sqlord = "DT_CADASTRO"
			case "es": sqlord = "COD_ESCOLARIDADE"
			case "mu": sqlord = "COD_UF_IBGE, COD_MUNI_IBGE"       ' municipio nome (se for ibge tem que ser uf e municipio)
			case "st": sqlord = "STATUS"                           ' status do aluno
			case "ef": sqlord = "EFETIVO"                          ' funciona efetivo sim ou não
			case else: sqlord = "A.NOME"
		end select

		task = request("task")
		if task<>"" then
			sel = request.form("sel")
			if len(sel)=0 then
				erroMsg("Selecionar ao menos um aluno")
			end if

			select case task
				case "turma":
					if Session("key_sta")="ok" then
					%>
						<script language="javascript">
							window.location = 'gestao_selecao.asp?ord=<%=ord%>&cod=<%=cod%>&st=<%=st%>&formulario=turma';
						</script>
					<%
					end if
				case "nome":
					if Session("key_sta")="ok" then
					%>
						<script language="javascript">
							window.location = 'gestao_selecao.asp?ord=<%=ord%>&cod=<%=cod%>&st=<%=st%>&formulario=nome';
						</script>
					<%
					end if
				case "lista":
					if Session("key_sta")="ok" then
					%>
						<script language="javascript">
							window.location = 'gestao_selecao.asp?ord=<%=ord%>&cod=<%=cod%>&st=<%=st%>&formulario=lista';
						</script>
					<%
					end if
				case "curso":
					if Session("key_sta")="ok" then
						ID_TURMA=Request.Form("ID_TURMA")
						if ID_TURMA="" or isNull(ID_TURMA) or isNumeric(ID_TURMA)=false then erroMsg("Selecionar o curso")
						asel = split(sel,",")

						for each item in asel
							sql = "SELECT COUNT(*) FROM TURMA_ALUNO WHERE ID_TURMA="&ID_TURMA&" AND COD_ALUNO="&item
							RS.Open sql
							if RS(0)>0 then erroMsg("O aluno já está cadastrado no curso que está sendo transferido")
							RS.Close
							con.execute "UPDATE TURMA_ALUNO SET ID_TURMA="&ID_TURMA&",COD_ALUNO="&item&" WHERE ID_TURMA="&cod&" AND COD_ALUNO="&item
						next
					end if
			end select
		end if
		%>

<%
' ====================================================================================
'   INÍCIO DA MONTAGEM DO RELATÓRIO - LISTA DE ALUNOS
' ====================================================================================

		tipo_enti       = request("tipo_enti")
		area_atu        = request("area_atu")
		escolaridade    = request("escolaridade")
		prioridade      = request("prioridade")
		bioma           = request("bioma")
		funciona        = request("funciona")
		termo           = request("termo")

		if (tipo_enti    = "") then tipo_enti     = "todas"
		if (area_atu     = "") then area_atu      = "todas"
		if (escolaridade = "") then escolaridade  = "todas"
		if (prioridade   = "") then prioridade    = "todas"
		if (bioma        = "") then bioma         = "todas"
		if (funciona     = "") then funciona      = "todas"
		if (termo        = "") then termo         = "todas"
%>


		<h1>Seleção de Pré-Inscritos - lista de alunos</h1>
		<h2>Curso: <%=curso_tit%></h2>
		<h3>Código da Turma: <%=CODIGO_TURMA%></h3>
		<h3><b>Inicio:</b> <%=formataData(DT_INICIO_TURMA)%> <b>Término:</b> <%=formataData(DT_FIM_TURMA)%></h3>
		<h3>Situação da turma: <%=STATUS_TURMA%></h3>

	    <div align="right"> <button id="bt_menu" onClick="window.print();return false;">Imprimir</button>    </div>

		<form name="formAlunos" id="formAlunos" action="gestao_selecao.asp" method="post" onSubmit="return checkForm();">
		<input type="hidden" name="ord" value="<%=ord%>">
		<input type="hidden" name="cod" value="<%=cod%>">
		<input type="hidden" name="st" value="<%=st%>">

        <table border="0"  cellpadding="5" cellspacing="5">
            <tr>
                <td width="25%" align="right"><span style="font-weight: bold">Tipo de Instituição</span></td>
                <td width="75%">
                    <select name="tipo_enti" id="tipo_enti" onchange="newDoc1(this.value);">
        			<option value="todas"
                    <% if tipo_enti="todas" then Response.Write " selected" end if %>
                    >Todas</option>
                    <%
                    sql_tipo_entidade = "SELECT ID_TIPO_ENTIDADE, DESCRICAO FROM TIPO_ENTIDADE"
                    RSSIM.Open  (sql_tipo_entidade)
        			while not RSSIM.eof
        				Response.Write "<option value='" & RSSIM("ID_TIPO_ENTIDADE") & "' "
                        if (tipo_enti <> "todas")   then
                            if cint(tipo_enti)=RSSIM("ID_TIPO_ENTIDADE") then Response.Write " selected" end if
                        end if
                        Response.Write ">" & RSSIM("DESCRICAO") & "</option>"
        				RSSIM.movenext
        			wend
        			RSSIM.Close
        			%>
        			</select>
                </td>
            </tr>
            <tr>
                <td width="25%" align="right"><span style="font-weight: bold">Área de atuação</span></td>
                <td width="75%">
                    <select name="area_atu" id="area_atu" onchange="newDoc1(this.value);">
        			<option value="todas"
                    <% if area_atu="todas" then Response.Write " selected" end if %>
                    >Todas</option>
                    <%
                    sql_area_atuacao = "SELECT ID_ATUACAO, ATUACAO FROM AREA_ATUACAO"
                    RS.Open  (sql_area_atuacao)
        			while not RS.eof
        				Response.Write "<option value='" & RS("ID_ATUACAO") & "' "
                        if (area_atu <> "todas")   then
                            if cint(area_atu)=RS("ID_ATUACAO") then Response.Write " selected" end if
                        end if
                        Response.Write ">" & RS("ATUACAO") & "</option>"
        				RS.movenext
        			wend
        			RS.Close
        			%>
        			</select>
                </td>
            </tr>
            <tr>
                <td width="25%" align="right"><span style="font-weight: bold">Escolaridade</span></td>
                <td width="75%">
                    <select name="escolaridade" id="escolaridade" onchange="newDoc1(this.value);">
        			<option value="todas"
                    <% if escolaridade="todas" then Response.Write " selected" end if %>
                    >Todas</option>
                    <%
                    sql_escolaridade = "SELECT COD_ESCOLARIDADE, DESCRICAO FROM ESCOLARIDADE"
                    RS.Open  (sql_escolaridade)
        			while not RS.eof
        				Response.Write "<option value=" & RS("COD_ESCOLARIDADE")
                        if (escolaridade <> "todas")   then
                            if cint(escolaridade)=RS("COD_ESCOLARIDADE") then Response.Write " selected" end if
                        end if
                        Response.Write ">" & RS("DESCRICAO") & "</option>"
        				RS.movenext
        			wend
        			RS.Close
        			%>
        			</select>
                </td>
            </tr>
            <tr>
                <td width="25%" align="right"><span style="font-weight: bold">Prioridade</span></td>
                <td width="75%">
                    <select name="prioridade" id="prioridade" onchange="newDoc1(this.value);">
                        <option value="todas"       <% if prioridade="todas"        then response.write(" selected") end if %>>Todas</option>";
                        <option value="Baixa"       <% if prioridade="Baixa"        then response.write(" selected") end if %>>Baixa</option>";
                        <option value="Média"       <% if prioridade="Média"        then response.write(" selected") end if %>>Média</option>";
                        <option value="Alta"        <% if prioridade="Alta"         then response.write(" selected") end if %>>Alta</option>";
                        <option value="Prioritária" <% if prioridade="Prioritária"  then response.write(" selected") end if %>>Prioritária</option>";
                    </select>
                </td>
            </tr>
            <tr>
                <td width="25%" align="right"><span style="font-weight: bold">Bioma</span></td>
                <td width="75%">
                    <select name="bioma" id="bioma" onchange="newDoc1(this.value);">
                        <option value="todas">Todos</option>";
                        <option value="Sim" <% if bioma="Sim" then response.write(" selected") end if %>>Sim</option>";
                        <option value="Não" <% if bioma="Não" then response.write(" selected") end if %>>Não</option>";
                    </select>
                </td>
            </tr>
            <tr>
                <td width="25%" align="right"><span style="font-weight: bold">Servidor</span></td>
                <td width="75%">
                    <select name="funciona" id="funciona" onchange="newDoc1(this.value);">
                        <option value="todas">Todos</option>";
                        if (funciona)
                        <option value="sim" <% if funciona="sim" then response.write(" selected") end if %>>Sim</option>";
                        <option value="nao" <% if funciona="nao" then response.write(" selected") end if %>>Não</option>";
                    </select>
                </td>
            </tr>
            <tr>
                <td width="25%" align="right"><span style="font-weight: bold">Termo de Compromisso</span></td>
                <td width="75%">
                    <select name="termo" id="termo" onchange="newDoc1(this.value);">
                        <option value="todas">Todos</option>";
                        <option value="1" <% if termo="1" then response.write(" selected") end if %>>Sim</option>";
                        <option value="0" <% if termo="0" then response.write(" selected") end if %>>Não</option>";
                    </select>
                </td>
            </tr>
        </table>

        <br>

		<%msql = "ID_TURMA="&cod&" ORDER BY "&sqlord%>
		<input type="hidden" name="msql" value="<%=msql%>">
		<%
		sql = "SELECT COUNT(*) FROM TURMA_ALUNO C JOIN ALUNO A ON C.COD_ALUNO=A.COD_ALUNO WHERE ID_TURMA="&cod
		RS.Open sql
			total_alunos = RS(0)
		RS.Close


' ====================================================================================
'   SELECT PARA LISTAR OS ALUNOS DA TURMA UTILIZANDO OS FILTROS SELECIONADOS
' ====================================================================================

        sql_where = ""
		if (tipo_enti    <> "todas") then   sql_where = sql_where & " AND A.TIPOENTI='"             & tipo_enti     & "' "
		if (area_atu     <> "todas") then   sql_where = sql_where & " AND A.AREA_ATUACAO='"         & area_atu      & "' "
		if (escolaridade <> "todas") then   sql_where = sql_where & " AND A.COD_ESCOLARIDADE='"     & escolaridade  & "' "
		if (prioridade   <> "todas") then   sql_where = sql_where & " AND BC.PRIORIDADE='"          & prioridade    & "' "
		if (bioma        <> "todas") then   sql_where = sql_where & " AND BC.ADESAO='"              & bioma         & "' "
		if (funciona     <> "todas") then   sql_where = sql_where & " AND A.EFETIVO='"              & funciona      & "' "
		if (termo        <> "todas") then   sql_where = sql_where & " AND C.TERMO_COMPROMISSO='"    & termo         & "' "

        sql =   "SELECT C.ENTURMADO,A.COD_ALUNO,A.COD_ESCOLARIDADE,A.EFETIVO,A.COD_ENTI,A.TIPOENTI, "               & _
                "       A.COD_UF_IBGE,A.COD_MUNI_IBGE,T.COD_STATUS_TURMA,C.TERMO_COMPROMISSO, "                     & _

                "       A.COD_UF_ENTI,A.COD_MUNI_ENTI, "                                                            & _

                "       EMAIL_ENVIADO,STATUS,NOTA,TEL,TEL_DDD,NOME,A.CPF,APROVADO,DT_CADASTRO,PAGO, "               & _
                "       FORMA_PGT,A.EMAIL,A.E_NOME,A.CARGO,C.ID_TURMA,A.AREA_ATUACAO, "                             & _
                "       BC.PRIORIDADE,BC.ADESAO, "                                                                  & _
                "       (SELECT SUM(VALOR) FROM PAGAMENTO WHERE COD_ALUNO=A.COD_ALUNO "                             & _
                "                                           AND ID_TURMA=C.ID_TURMA "                               & _
                "                                           AND DT_PGT IS NOT NULL) AS VALOR FROM TURMA_ALUNO C "   & _
                "  JOIN ALUNO        as A  ON C.COD_ALUNO=A.COD_ALUNO "                                             & _
                "  JOIN TURMAS       as T  ON T.ID_TURMA=C.ID_TURMA "                                               & _
                "  LEFT JOIN BIOMA_CIDADE as BC ON A.COD_UF_IBGE=BC.COD_UF_IBGE AND A.COD_MUNI_IBGE=BC.COD_MUNI_IBGE "   & _
                " WHERE C.ID_TURMA=" & cod & " " & sql_where                                                        & _
                " ORDER BY " & sqlord
' Response.Write(sql)
' Response.End
		RS.Open sql
		if RS.EOF then
			%><br /><p>Nenhum aluno cadastrado</p><%
		else
			COD_ALUNO           = RS("COD_ALUNO")
			COD_STATUS_TURMA    = RS("COD_STATUS_TURMA")
            COD_ENTI_ALUNO      = RS("COD_ENTI")
            TIPO_ENTI_ALUNO     = RS("TIPOENTI")
            COD_UF_IBGE_ALUNO   = RS("COD_UF_IBGE")
            COD_MUNI_IBGE_ALUNO = RS("COD_MUNI_IBGE")
            COD_UF_ENTI_ALUNO   = RS("COD_UF_ENTI")
            COD_MUNI_ENTI_ALUNO = RS("COD_MUNI_ENTI")
            CARGO_ALUNO         = RS("CARGO")
            ENTURMADO_ALUNO     = RS("ENTURMADO")
            TERMO_COMPROMISSO   = RS("TERMO_COMPROMISSO")
            EFETIVO             = RS("EFETIVO")
            PRIORIDADE          = RS("PRIORIDADE")
            BIOMA_CIDADE        = RS("ADESAO")
			%>
			<p><%=total_alunos%> aluno(s) listado(s)</p>
			<% if request("formulario")="" then%>
				<table id="tabela" cellpadding="4">
				<tr><td class="header">
				<%if mostraSel then%><input type="checkbox" name="main" value="1" onClick="checkAll(this.checked);"><%end if%></td>

            <%  if (SIGA_PROJETO=2)  then    %>
    				<td class="header"><a href="gestao_selecao.asp?ord=nm&cod=<%=cod%>&st=<%=st%>">nome</a></td>
<!----    			<td class="header"><a href="gestao_selecao.asp?ord=cp&cod=<%=cod%>&st=<%=st%>">cpf</a></td> ---->
    				<td class="header"><a href="gestao_selecao.asp?ord=ti&cod=<%=cod%>&st=<%=st%>"> Tipo Instituição</a></td>
				    <td class="header"><a href="gestao_selecao.asp?ord=ni&cod=<%=cod%>&st=<%=st%>"> Nome Instituição</a></td>
				    <td class="header"><a href="gestao_selecao.asp?ord=cg&cod=<%=cod%>&st=<%=st%>"> Cargo</a></td>
				    <td class="header"><a href="gestao_selecao.asp?ord=cg&cod=<%=cod%>&st=<%=st%>"> Área Atuação</a></td>
    				<td class="header"><a href="gestao_selecao.asp?ord=uf&cod=<%=cod%>&st=<%=st%>">UF</a></td>
    				<td class="header"><a href="gestao_selecao.asp?ord=mu&cod=<%=cod%>&st=<%=st%>">Município </a></td>
    				<td class="header"><a href="gestao_selecao.asp?ord=mu&cod=<%=cod%>&st=<%=st%>">Prioridade </a></td>
    				<td class="header"><a href="gestao_selecao.asp?ord=es&cod=<%=cod%>&st=<%=st%>">Escolaridade</a></td>

    	   		    <td class="header"><a href="gestao_selecao.asp?ord=ef&cod=<%=cod%>&st=<%=st%>" title="Servidor Efetivo sim não">SRV&nbsp;</a></td>
    	   		    <td class="header"><a href="gestao_selecao.asp?ord=tc&cod=<%=cod%>&st=<%=st%>" title="Aceite do Termo de Compromisso 1=sim 0=não">TC&nbsp;</a></td>
    	   			<td class="header"><a href="gestao_selecao.asp?ord=qt&cod=<%=cod%>&st=<%=st%>" title="Turma Finalizada">TF&nbsp;</a></td>
    	   			<td class="header"><a href="gestao_selecao.asp?ord=qt&cod=<%=cod%>&st=<%=st%>" title="Turma em Andamento">TN&nbsp;</a></td>
    	   			<td class="header"><a href="gestao_selecao.asp?ord=qt&cod=<%=cod%>&st=<%=st%>" title="Total Enturmação">TE&nbsp;</a></td>
    	   			<td class="header"><a href="gestao_selecao.asp?ord=qt&cod=<%=cod%>&st=<%=st%>" title="Total de Aprovações">TA&nbsp;</a></td>
    	   			<td class="header"><a href="gestao_selecao.asp?ord=qt&cod=<%=cod%>&st=<%=st%>" title="Total de Evasões">TV&nbsp;</a></td>
    	   			<td class="header"><a href="gestao_selecao.asp?ord=qt&cod=<%=cod%>&st=<%=st%>" title="Total de Reprovações">TR&nbsp;</a></td>
    	   			<td class="header"><a href="gestao_selecao.asp?ord=qt&cod=<%=cod%>&st=<%=st%>" title="Total de Nunca Acessou">TS&nbsp;</a></td>

    			    <td class="header"><a href="gestao_selecao.asp?ord=bi&cod=<%=cod%>&st=<%=st%>">Bio&nbsp;</a></td>
				    <td class="header"><a href="gestao_selecao.asp?ord=dc&cod=<%=cod%>&st=<%=st%>"> &nbsp;Inscrição</a></td>
            <%  end if    %>
				</tr>
				<%
				c = 0
				while not RS.EOF
					if RS("PAGO")=1 then
						pago="sim"
					elseif RS("PAGO")=2 then
						pago="gratuíto"
					else
						pago="não"
					end if
					nota = rs("NOTA")
					email_enviado = rs("EMAIL_ENVIADO")
					%><tr class="c<%=c%>">
						<td><%if mostraSel then%><input type="checkbox" name="sel" onClick="checkOne(this.checked);" value="<%=RS("COD_ALUNO")%>"><%end if%></td>
						<td><a href="aluno.asp?ord=<%=ord%>&cod=<%=cod%>&st=<%=st%>&coda=<%=RS("COD_ALUNO")%>"><%=RS("NOME")&" "%></a></td>

<!----  				<td><%=FormataCPF(RS("CPF"))%>&nbsp;</td>     ---->

                        <%
                            COD_ENTI_ALUNO      = RS("COD_ENTI")
                            TIPO_ENTI_ALUNO     = RS("TIPOENTI")
                            CARGO_ALUNO         = RS("CARGO")
                            COD_UF_IBGE_ALUNO   = RS("COD_UF_IBGE")
                            COD_MUNI_IBGE_ALUNO = RS("COD_MUNI_IBGE")
                            COD_UF_ENTI_ALUNO   = RS("COD_UF_ENTI")
                            COD_MUNI_ENTI_ALUNO = RS("COD_MUNI_ENTI")
                            ENTURMADO_ALUNO     = RS("ENTURMADO")
                            ATUACAO_ALUNO       = RS("AREA_ATUACAO")
                        %>

                        <%  if (SIGA_PROJETO=2)  then    %>
            				<td><%
                                    if isNull (COD_ENTI_ALUNO)  then
                                        COD_ENTI_ALUNO=0
                                    end if
                                	sql = "SELECT NOME, ID_TIPO_ENTIDADE, COD_UF_IBGE, COD_MUNI_IBGE "      & _
                                          " FROM ENTIDADES  "                                               & _
                                          " WHERE COD_ENTI="&COD_ENTI_ALUNO
                                	RSSIM.Open sql
                                	if not RSSIM.eof then
                                        NOME_ENTI_ALUNO=RSSIM("NOME")
                                        TIPO_ENTI_ALUNO=RSSIM("ID_TIPO_ENTIDADE")
                                        codigo_uf_entidade   = RSSIM("COD_UF_IBGE")
                                        codigo_muni_entidade = RSSIM("COD_MUNI_IBGE")
                                    else
                                		NOME_ENTI_ALUNO=""
                                        codigo_uf_entidade   = COD_UF_IBGE_ALUNO
                                        codigo_muni_entidade = COD_MUNI_IBGE_ALUNO
                                	end if
                                	RSSIM.Close
                                	sql = "SELECT DESCRICAO FROM TIPO_ENTIDADE WHERE ID_TIPO_ENTIDADE="&TIPO_ENTI_ALUNO
                                	RSSIM.Open sql
                                	if not RSSIM.eof then
                                        DESCRICAO_ENTI_ALUNO=mid(RSSIM("DESCRICAO"),1,20)
                                    else
                                		DESCRICAO_ENTI_ALUNO=""
                                	end if
                                	RSSIM.Close

                                    if (TIPO_ENTI_ALUNO=21)   then
                                        Response.Write("Pessoa Física")
                                    else %>
                                        <a href="" title="<% Response.Write(NOME_ENTI_ALUNO)  %>"><% Response.Write(DESCRICAO_ENTI_ALUNO)  %>  </a>
                                    <%
                                    end if

                                 %>
                            </td>
            				<td><%
                                     Response.Write(NOME_ENTI_ALUNO)
                                %>
                            </td>
            				<td><%
                                     Response.Write(CARGO_ALUNO & " ")
                                 %>
                            </td>

            				<td><%
                                    if isNull(ATUACAO_ALUNO)    then    ATUACAO_ALUNO = 0  end if
                                	sql = "SELECT ID_ATUACAO, ATUACAO FROM AREA_ATUACAO WHERE ID_ATUACAO=" & ATUACAO_ALUNO
                                	RS4.Open sql
                                	if not RS4.eof then
                                        area_atuacao_aluno = RS4("ATUACAO")
                                    else
                                		area_atuacao_aluno = ""
                                	end if
                                	RS4.Close
                                    Response.Write(area_atuacao_aluno)&"&nbsp;"
                                %></td>


            				<td><%
'                                    if ( COD_ENTI_ALUNO = "" ) then
'                                    if ( EFETIVO = "nao" ) then
'                                        codigo_uf_entidade   = COD_UF_IBGE_ALUNO
'                                        codigo_muni_entidade = COD_MUNI_IBGE_ALUNO
'                                    else
'                                        codigo_uf_entidade   = COD_UF_ENTI_ALUNO
'                                        codigo_muni_entidade = COD_MUNI_ENTI_ALUNO
'                                    end if
                                    sql = "SELECT SIGLA_UF FROM UF WHERE COD_UF_IBGE=" & codigo_uf_entidade

' Response.Write("Cod_enti_aluno......: " & cod_enti_aluno & "<br>")
' Response.Write("Cod_uf_ibge.........: " & cod_uf_ibge_ALUNO & "<br>")
' Response.Write("Cod_muni_ibge.......: " & cod_muni_ibge_ALUNO & "<br>")
' Response.Write("Codigo_uf_entidade..: " & codigo_uf_entidade & "<br>")
' Response.Write(sql)


                                	RSSIM.Open sql
                                	if not RSSIM.eof then
                                        SIGLA_UF_ALUNO=RSSIM("SIGLA_UF")
                                    else
                                		SIGLA_UF_ALUNO=""
                                	end if
                                	RSSIM.Close
                                    Response.Write(SIGLA_UF_ALUNO)&"&nbsp;"
                                %></td>

            				<td><%
                                	sql = "SELECT NOME_MUNI FROM MUNICIPIOS "                       & _
                                          " WHERE COD_UF_IBGE='"   & codigo_uf_entidade   & "'"     & _
                                          "   AND COD_MUNI_IBGE='" & codigo_muni_entidade & "'"
                                	RSSIM.Open sql
                                	if not RSSIM.eof then
                                        NOME_MUNI_ALUNO=RSSIM("NOME_MUNI")
                                    else
                                		NOME_MUNI_ALUNO=""
                                	end if
                                	RSSIM.Close
                                    Response.Write(NOME_MUNI_ALUNO)&" "
                            %></td>


            				<td><%
                                	sql = "SELECT PRIORIDADE FROM BIOMA_CIDADE WHERE COD_UF_IBGE="&COD_UF_IBGE_ALUNO&" AND COD_MUNI_IBGE="&COD_MUNI_IBGE_ALUNO
                                	RS4.Open sql
                                	if not RS4.eof then
                                        PRIORIDADE_MUNICIPIO=RS4("PRIORIDADE")
                                    else
                                		PRIORIDADE_MUNICIPIO=""
                                	end if
                                	RS4.Close
                                    Response.Write(PRIORIDADE_MUNICIPIO)&" "
                            %></td>





            				<td><%
                                    sql = "SELECT b.nome,a.descricao FROM ESCOLARIDADE AS a "  _
                                          &     "JOIN ALUNO AS b ON a.cod_escolaridade=b.cod_escolaridade  "  _
                                          &     "WHERE b.cod_aluno='" & RS("COD_ALUNO") & "'"
                                	RS3.Open sql
                                	if not RS3.eof then
                                        ESCOLARIDADE=RS3("DESCRICAO")
                                    else
                                		DESCRICAO=""
                                	end if
                                	RS3.Close
                                    Response.Write(ESCOLARIDADE)&" "
                            %></td>

            				<td><%
                                    Response.Write(RS("EFETIVO"))
                            %></td>

<!----  TC   Termo de Compromisso - aceite   ---->
            				<td><%
                                    Response.Write(RS("TERMO_COMPROMISSO"))
                            %></td>

<!----  TF   Total de participação do aluno em turmas finalizadas   ---->
            				<td><%
                                	sql = "SELECT COUNT (a.COD_ALUNO) AS QTDE FROM TURMA_ALUNO  as a"   _
                                        & " LEFT JOIN CURSO as b ON a.cod_curso=b.cod_curso "           _
                                        & " LEFT JOIN TURMAS as c ON a.id_turma=c.id_turma  "           _
                                        & " WHERE b.SIGA_PROJETO=2 AND a.COD_ALUNO="&RS("COD_ALUNO")    _
                                        & " AND a.enturmado='E'    AND c.cod_status_turma='6' "
' Response.Write(sql)
' Response.End
                                	RS3.Open sql
                                	if not RS3.eof then
                                        Response.Write(RS3("QTDE"))
                                    else
                                        Response.Write(" ")
                                	end if
                                	RS3.Close
                            %></td>


<!----  TN  Total de turmas em andamento do aluno    ---->
            				<td><%
                                	sql = "SELECT COUNT (a.COD_ALUNO) AS QTDE FROM TURMA_ALUNO  as a"   _
                                        & " LEFT JOIN CURSO as b ON a.cod_curso=b.cod_curso "   _
                                        & " WHERE b.SIGA_PROJETO=2 AND a.COD_ALUNO="&RS("COD_ALUNO")    _
                                        & " AND a.enturmado='E'    AND a.status='REPROVADO' "

                                    sql = "SELECT COUNT (TA.COD_ALUNO) AS QTDE FROM TURMA_ALUNO AS TA "     & _
                                          "  LEFT JOIN CURSO AS C ON C.cod_curso=TA.cod_curso "             & _
                                          "  LEFT JOIN TURMAS AS T ON  T.id_turma=TA.id_turma "             & _
                                          " WHERE C.SIGA_PROJETO=2 AND TA.COD_ALUNO=" & RS("COD_ALUNO")     & _
                                          "                        AND T.COD_STATUS_TURMA=7"
' Response.Write(sql)
' Response.End
                                	RS3.Open sql
                                	if not RS3.eof then
                                        Response.Write(RS3("QTDE"))
                                    else
                                        Response.Write(" ")
                                	end if
                                	RS3.Close
                            %></td>


<!----  TE  Total de turmas em que o aluno está enturmado    ---->

            				<td><%
                                	sql = "SELECT COUNT (a.COD_ALUNO) AS QTDE FROM TURMA_ALUNO  as a"   _
                                        & " LEFT JOIN CURSO as b ON a.cod_curso=b.cod_curso "   _
                                        & " WHERE b.SIGA_PROJETO=2 AND a.COD_ALUNO="&RS("COD_ALUNO")    _
                                        & " AND a.enturmado='E'"
' Response.Write(sql)
' Response.End
                                	RS3.Open sql
                                	if not RS3.eof then
                                        Response.Write(RS3("QTDE"))
                                    else
                                        Response.Write(" ")
                                	end if
                                	RS3.Close
                            %></td>

<!----  TA  Total de aprovações do aluno    ---->
            				<td><%
                                	sql = "SELECT COUNT (a.COD_ALUNO) AS QTDE FROM TURMA_ALUNO  as a "  _
                                        & " LEFT JOIN CURSO  as b ON a.cod_curso=b.cod_curso "          _
                                        & " LEFT JOIN TURMAS AS T ON a.id_turma=t.id_turma "            _
                                        & " WHERE b.SIGA_PROJETO=2 AND a.COD_ALUNO="&RS("COD_ALUNO")    _
                                        & "   AND  (t.cod_status_turma=6 OR t.cod_status_turma=7)    "  _
                                        & "   AND a.status='APROVADO' "
' Response.Write(sql)
' Response.End
                                	RS3.Open sql
                                	if not RS3.eof then
                                        Response.Write(RS3("QTDE"))
                                    else
                                        Response.Write(" ")
                                	end if
                                	RS3.Close
                            %></td>

<!----  TV  Total de evadido do aluno    ---->
            				<td><%
                                	sql = "SELECT COUNT (a.COD_ALUNO) AS QTDE FROM TURMA_ALUNO  as a "  _
                                        & " LEFT JOIN CURSO  as b ON a.cod_curso=b.cod_curso "          _
                                        & " LEFT JOIN TURMAS AS T ON a.id_turma=t.id_turma "            _
                                        & " WHERE b.SIGA_PROJETO=2 AND a.COD_ALUNO="&RS("COD_ALUNO")    _
                                        & "   AND  (t.cod_status_turma=6 OR t.cod_status_turma=7)    "  _
                                        & "   AND a.status='EVADIDO' "
' Response.Write(sql)
' Response.End
                                	RS3.Open sql
                                	if not RS3.eof then
                                        Response.Write(RS3("QTDE"))
                                    else
                                        Response.Write(" ")
                                	end if
                                	RS3.Close
                            %></td>


<!----  TR  Total de reprovações do aluno    ---->
            				<td><%
                                	sql = "SELECT COUNT (a.COD_ALUNO) AS QTDE FROM TURMA_ALUNO  as a "  _
                                        & " LEFT JOIN CURSO  as b ON a.cod_curso=b.cod_curso "          _
                                        & " LEFT JOIN TURMAS AS T ON a.id_turma=t.id_turma "            _
                                        & " WHERE b.SIGA_PROJETO=2 AND a.COD_ALUNO="&RS("COD_ALUNO")    _
                                        & "   AND  (t.cod_status_turma=6 OR t.cod_status_turma=7)    "  _
                                        & "   AND a.status='REPROVADO' "
' Response.Write(sql)
' Response.End
                                	RS3.Open sql
                                	if not RS3.eof then
                                        Response.Write(RS3("QTDE"))
                                    else
                                        Response.Write(" ")
                                	end if
                                	RS3.Close
                            %></td>

<!----  TS  Total de nunca acessou do aluno    ---->
            				<td><%
                                	sql = "SELECT COUNT (a.COD_ALUNO) AS QTDE FROM TURMA_ALUNO  as a "  _
                                        & " LEFT JOIN CURSO  as b ON a.cod_curso=b.cod_curso "          _
                                        & " LEFT JOIN TURMAS AS T ON a.id_turma=t.id_turma "            _
                                        & " WHERE b.SIGA_PROJETO=2 AND a.COD_ALUNO="&RS("COD_ALUNO")    _
                                        & "   AND  (t.cod_status_turma=6 OR t.cod_status_turma=7)    "  _
                                        & "   AND a.status='NUNCA ACESSOU' "
' Response.Write(sql)
' Response.End
                                	RS3.Open sql
                                	if not RS3.eof then
                                        Response.Write(RS3("QTDE"))
                                    else
                                        Response.Write(" ")
                                	end if
                                	RS3.Close
                            %></td>


            				<td><%
                                	sql = "SELECT ADESAO FROM BIOMA_CIDADE "                            & _
                                          " WHERE COD_UF_IBGE='"    & codigo_uf_entidade    & "'"       & _
                                          "   AND COD_MUNI_IBGE='"  & codigo_muni_entidade  & "'"
' Response.Write(sql)
                                	RS2.Open sql
                                	if not RS2.eof then
                                        BIOMA_MUNI_ALUNO="S"
                                        if (RS2("ADESAO")="Sim") then ADESAO_MUNICIPIO="S"
                                    else
                                		BIOMA_MUNI_ALUNO="N"
                                        ADESAO_MUNICIPIO="N"
                                	end if
                                	RS2.Close
                                    Response.Write(BIOMA_MUNI_ALUNO)&" "
                                %></td>


            				<td>&nbsp;<%=formataData(RS("DT_CADASTRO"))%></td>
                        <% end if  %>

						<td><%=" "%></td>

                        </tr><%
					c = 1 - c
					RS.MoveNext
				wend
				RS.Close
				%>
				</table>
			<% elseif request("formulario")="nome" then%>
				<table id="tabela">
				<tr><td class="header">
				<%if mostraSel then%><input type="checkbox" name="main" value="1" onClick="checkAll(this.checked);"><%end if%></td>
				<td class="header"><a href="alunos.asp?ord=nm&cod=<%=cod%>&st=<%=st%>">Nome</a></td>
				</tr>
				<%
				c = 0
				while not RS.EOF
					%><tr class="c<%=c%>">
						<td><%if mostraSel then%><input type="checkbox" name="sel" onClick="checkOne(this.checked);" value="<%=RS("COD_ALUNO")%>"><%end if%></td>
						<td><%=RS("NOME")%></td>
						</tr><%
					c = 1 - c
					RS.MoveNext
				wend
				RS.Close
				%>
				</table>
			<% elseif request("formulario")="lista" then%>
				<table id="tabela">
				<tr>
				<td class="header"><a href="alunos.asp?ord=nm&cod=<%=cod%>&st=<%=st%>">Nome</a></td>
				<td class="header"><a href="alunos.asp?ord=cp&cod=<%=cod%>&st=<%=st%>">Telefone</a></td>
				<td class="header"><a href="alunos.asp?ord=fp&cod=<%=cod%>&st=<%=st%>">E-mail</a></td>
				<td class="header"><a href="alunos.asp?ord=dc&cod=<%=cod%>&st=<%=st%>">Entidade</a></td>
				<td class="header"><a href="alunos.asp?ord=dc&cod=<%=cod%>&st=<%=st%>">Função</a></td>
				</tr>
				<%
				c = 0
				while not RS.EOF
					%><tr class="c<%=c%>">
						<td><%=RS("NOME")%></td>
						<td>(<%=RS("TEL_DDD")%>)<%=formatatel(RS("TEL"))%></td>
						<td><%=RS("EMAIL")%></td>
						<td><%=RS("E_NOME")%></td>
						<td><%=RS("CARGO")%></td>
						</tr><%
					c = 1 - c
					RS.MoveNext
				wend
				RS.Close
				%>
				</table>
			<% elseif request("formulario")="frequencia" then%>
				<table id="tabela">
				<tr>
				<td class="header"><a href="alunos.asp?ord=nm&cod=<%=cod%>&st=<%=st%>">Nome</a></td>
				<td class="header"><a href="alunos.asp?ord=cp&cod=<%=cod%>&st=<%=st%>">CPF</a></td>
				<td class="header"><a href="alunos.asp?ord=fp&cod=<%=cod%>&st=<%=st%>">Manhã</a></td>
				<td class="header"><a href="alunos.asp?ord=fp&cod=<%=cod%>&st=<%=st%>"><br></a></td>
				<td class="header"><a href="alunos.asp?ord=dc&cod=<%=cod%>&st=<%=st%>">Tarde</a></td>
				</tr>
				<%
				c = 0
				while not RS.EOF
					%><tr class="c<%=c%>">
						<td><%=RS("NOME")%></td>
						<td><%=formatacpf(RS("CPF"))%></td>
						<td>__________________________</td>
						<td><br></td>
						<td>__________________________</td>
						</tr><%
					c = 1 - c
					RS.MoveNext
				wend
				RS.Close
				%>
				</table>
			<% end if
			end if
			if total_alunos>0 and mostraSel then%>
			<p>
				<select name="task" onChange="checkAcao(this.value);">
					<option value="">Selecione a ação para os alunos selecionados...</option>
					<%if Session("key_sta")="ok" then%>
						<option value="nome">Nome dos Alunos</option>
						<option value="lista">Lista de participantes</option>
						<option value="curso">Mudar de turma</option>
					<%end if%>
					<%if Session("key_plc")="ok" then%>
						<option value="planilhp">Gerar planilha parcial</option>
					<%end if%>
					<%if Session("key_plc")="ok" then%>
						<option value="planilha">Gerar planilha completa</option>
					<%end if%>
				</select>
				<input type="submit" name="submit" value="Executar" class="buttonF">
			</p>
			<fieldset id="cursoDados" style="display:none">
				<legend>mudar alunos selecionados de turma</legend>
				<p><label for="ID_TURMA">Curso</label>
				<%
					sql = "SELECT T.ID_TURMA,C.TITULO,T.CODIGO_TURMA,T.COD_STATUS_TURMA,C.COD_STATUS FROM TURMAS T JOIN CURSO C ON T.COD_CURSO=C.COD_CURSO WHERE T.ID_TURMA<>'"&cod&"' AND (T.COD_STATUS_TURMA=1 OR T.COD_STATUS_TURMA=2 OR T.COD_STATUS_TURMA=3 OR T.COD_STATUS_TURMA=7) AND C.COD_STATUS=1"
				RS.open sql
				%>
				<select name="ID_TURMA">
					<option value=""></option>
					<%
					while not RS.eof
						response.write "<option value="&RS("ID_TURMA")&">"&RS("CODIGO_TURMA")&" - "&RS("TITULO")&"</option>"
						RS.movenext
					wend
					RS.close
					%>
				</select>

				</p>
			</fieldset>


		<%end if%>
		</form>
		<p><br /></p>
	</div>
</div>
</body>
</html>
<%conClose%>