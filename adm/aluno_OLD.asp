<%If session("adm")<>"ok" Then Response.Redirect "logout.asp"%>
<!-- #INCLUDE FILE="../library/parametros.asp" -->
<!-- #INCLUDE FILE="../library/conOpen.asp" -->
<!-- #INCLUDE FILE="../library/fErroMsg.asp" -->
<!-- #INCLUDE FILE="../library/fData.asp" -->
<!-- #INCLUDE FILE="../library/fPagamentos.asp" -->
<!-- #INCLUDE FILE="../library/fCreateSel.asp" -->
<!-- #INCLUDE FILE="../library/fFormataValor.asp" -->
<!-- #INCLUDE FILE="../library/fFormataCep.asp" -->
<!-- #INCLUDE FILE="../library/fFormataCPF.asp" -->
<!-- #INCLUDE FILE="../library/vAprova.asp" -->

<%  SIGA_PROJETO=Session("siga_projeto")  %>

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
    <meta http-equiv="Pragma" content="no-cache" />
    <meta http-equiv="Expires" content="0" />

	<title>ENSUR Inscrições</title>
	<script type="text/javascript" src="../js/validacao_pb.js"></script>
	<script type="text/javascript" src="../js/mascara.js"></script>
	<script language="javascript">
		function checkForm() {
			f = document.formAlunos;
			if (f.task.selectedIndex===0) {
				alert('Selecionar uma ação');
				return false;
			}
			switch (f.task.value) {
			case 'planilha':
				f.action = "gera_excel.asp";
				break;
			case 'planilhp':
				f.action = "gera_excel.asp?p=1";
				break;
			case 'aluno':
				f.action = "altera_aluno.asp";
				break;
			case 'alunopqga':
				f.action = "altera_aluno02.asp";
				break;
			case 'vencimento':
				f.action = "aluno.asp";
				break;
			default:
				f.action = "alunos.asp";
			}
			return true
		}
		
		function checkAcao(val) {
			if (val==='mail') {
				document.getElementById('mailDados').style.display = 'block';
			} else {
				document.getElementById('mailDados').style.display = 'none';
			}
			if (val==='curso') {
				document.getElementById('cursoDados').style.display = 'block';
			} else {
				document.getElementById('cursoDados').style.display = 'none';
			}
			if (val==='vencimento') {
				document.getElementById('vencDados').style.display = 'block';
			} else {
				document.getElementById('vencDados').style.display = 'none';
			}
		}
	</script>
</head>
<body onLoad="checkAcao(document.formAlunos.task.value);">
<div id="pagina">
	<!-- #INCLUDE FILE="include/topo.asp" -->
	<div id="conteudo">
		<h1>Detalhe de aluno</h1>
		<form name="formAlunos" action="alunos.asp" method="post" onSubmit="return checkForm();">
		<%
		cod = request("cod")
		if cod="" or isNumeric(cod)=false then erroMsg("Curso não encontrado")
		cod = int(cod)		
		st = request("st")
		ord = request("ord")
		coda = int(request("coda"))

		task = request("task")
		'Alteração de venciemento
		if task="vencimento" then
			NUM_PARCELA = int(Request.Form("NUM_PARCELA"))
			DT_VENC=validaData(Request.Form("DT_VENC"))
			con.execute "UPDATE PAGAMENTO SET DT_VENC="&DT_VENC&" WHERE COD_CURSO="&cod&" AND COD_ALUNO="&coda&" AND NUM_PARCELA="&NUM_PARCELA
			Response.Redirect "aluno.asp?ord="&ord&"&cod="&cod&"&st="&st&"&coda="&coda&""
		end if


		RS.Open "SELECT T.VALOR,C.COD_PROJETO FROM TURMAS T JOIN CURSO C ON T.COD_CURSO=C.COD_CURSO WHERE T.ID_TURMA="&cod
		if RS.EOF then
			erroMsg("Curso não encontrado. Faça um refresh no seu navegador e tente novamente.")
		else
			VALOR 			= RS("VALOR")
		end if
		COD_PROJETO = RS(1)
		
		RS.Close
		sql = "Recuperar_Aluno_SP "&request("coda")
		RS.Open sql
		
		if RS.EOF then
			erroMsg("Aluno não encontrado. Faça um refresh no seu navegador e tente novamente.")
		else
			CPF 			= RS("CPF")
			ID_TIPO		 	= RS("ID_TIPO")
			ID_NUM		 	= RS("ID_NUM")
			NOME 			= RS("NOME")
			PASSWORD		= RS("PASSWORD")
			DT_NASCIMENTO 	= RS("DT_NASCIMENTO")
			SEXO 			= RS("SEXO")
			if SEXO then SEXO="Masculino" else SEXO="Feminino" end if
			COD_RACA 		= RS("COD_RACA")
			COD_PAIS	 	= RS("COD_PAIS")
			EMAIL 			= RS("EMAIL")
			ENDERECO 		= RS("ENDERECO")
			CEP 			= RS("CEP")
			FORMACAO 		= RS("FORMACAO")
			COD_MUNI_ENTI	= RS("COD_MUNI_ENTI")
			COD_UF_ENTI		= RS("COD_UF_ENTI")
			tipoEnti		= RS("tipoEnti")
			COD_ENTI		= RS("COD_ENTI")
			ASSOCIADO		= RS("ASSOCIADO")
			SETOR			= RS("SETOR")
			CARGO			= RS("CARGO")

            if ( SIGA_PROJETO = 2 )  then
    			EMAIL_ENTI		= RS("E_EMAIL")
    			ENDERECO_ENTI	= RS("E_ENDERECO")
    			CEP_ENTI		= RS("E_CEP")
    			TEL_DDI_ENTI	= mid(RS("TELEFONE_ENTIDADE"),1,2)
    			TEL_DDD_ENTI	= mid(RS("TELEFONE_ENTIDADE"),3,2)
    			TEL_ENTI	    = mid(RS("TELEFONE_ENTIDADE"),5,10)
    			TEL_DDD 		= mid(RS("TELEFONE_PESSOAL"),3,2)
    			TEL 			= mid(RS("TELEFONE_PESSOAL"),5,10)
            else
    			EMAIL_ENTI		= RS("EMAIL_ENTI")
    			ENDERECO_ENTI	= RS("ENDERECO_ENTI")
    			CEP_ENTI		= RS("CEP_ENTI")
    			TEL_DDI_ENTI	= RS("TEL_DDI_ENTI")
    			TEL_DDD_ENTI	= RS("TEL_DDD_ENTI")
    			TEL_ENTI		= RS("TEL_ENTI")
    			TEL_DDD 		= RS("TEL_DDD")
    			TEL 			= RS("TEL")
            end if
			FAX_DDI 		= RS("FAX_DDI")
			FAX_DDD 		= RS("FAX_DDD")
			FAX 			= RS("FAX")
			COD_UF_IBGE 	= RS("COD_UF_IBGE")
			COD_MUNI_IBGE 	= RS("COD_MUNI_IBGE")
			CPF 			= RS("CPF")
			COD_POS 		= RS("COD_POS")
			POS 			= RS("POS")
			COD_ESCOLARIDADE = RS("COD_ESCOLARIDADE")
		end if
		RS.Close

		RS.Open "SELECT NOME FROM PAIS WHERE COD_PAIS="&COD_PAIS
		if not RS.EOF then NOME_PAIS=RS(0)
		RS.Close

		if not isNull(COD_RACA) then
			RS.Open "SELECT DESCRICAO FROM RACA WHERE COD_RACA="&COD_RACA
			if not RS.EOF then RACA=RS(0)
			RS.Close
		end if
		
		if not isNull(COD_UF_IBGE) then
			RS.Open "SELECT NOME_MUNI,SiGLA_UF FROM MUNICIPIOS M JOIN UF ON M.COD_UF_IBGE=UF.COD_UF_IBGE WHERE M.COD_UF_IBGE="&COD_UF_IBGE&" AND COD_MUNI_IBGE="&COD_MUNI_IBGE
			if not RS.EOF then
				NOME_MUNI = RS(0)
				SiGLA_UF = RS(1)
			end if
			RS.Close
		end if

		if not isNull(COD_ESCOLARIDADE) then
			RS.Open "SELECT DESCRICAO FROM ESCOLARIDADE WHERE COD_ESCOLARIDADE="&COD_ESCOLARIDADE
			if not RS.EOF then ESCOLARIDADE=RS(0)
			RS.Close
		end if

		if not isNull(COD_POS) then
			RS.Open "SELECT DESCRICAO FROM POS WHERE COD_POS="&COD_POS
			if not RS.EOF then TPOS=RS(0)
			RS.Close
		end if

'		if not isNull(TEL_DDI) then telPrint = telPrint & TEL_DDI & "-"
'		telPrint = telPrint & TEL_DDD & ") " & TEL
		telPrint = "("
        telPrint = telPrint & TEL_DDD & ") " & formatatel(TEL)


		if Len(FAX)>0 then
			faxPrint = FAX
			if not isNull(FAX_DDI) and not isNull(FAX_DDD) then
				faxPrint = "(" & FAX_DDI & "-" & FAX_DDD & ") " & faxPrint
			elseif not isNull(FAX_DDD) then
				faxPrint = "(" & FAX_DDD & ") " & faxPrint
			end if
		end if

'		xxx = "SELECT COD_ENTI FROM ALUNO WHERE COD_ALUNO="&request("coda")
'        Response.Write(xxx)
		RS.Open "SELECT COD_ENTI FROM ALUNO WHERE COD_ALUNO="&request("coda")
		if RS.EOF then
			erroMsg("Aluno não cadastrado no sistema. Faça um refresh no seu navegador e tente novamente.")
        else
            COD_ENTI_ALUNO = RS("COD_ENTI")
        end if
        RS.Close

		RS.Open "SELECT * FROM TURMA_ALUNO WHERE COD_ALUNO="&request("coda")&" AND ID_TURMA="&cod
		if RS.EOF then
			erroMsg("Aluno não cadastrado neste curso. Faça um refresh no seu navegador e tente novamente.")
		else
'			CARGO 			= RS("CARGO")
'			COD_ENTI 		= COD_ENTI_ALUNO
'			COD_ENTI 		= RS("COD_ENTI")
			CUSTO_ENTI 		= RS("CUSTO_ENTI")
			if CUSTO_ENTI then CUSTO_ENTI=1 else CUSTO_ENTI=0 end if
'			SETOR 			= RS("SETOR")
			APROVADO 		= RS("APROVADO")
			DT_CADASTRO 	= RS("DT_CADASTRO")
			PARCELAS	 	= RS("PARCELAS")
			PAGO		 	= RS("PAGO")
			STATUS			= RS("STATUS")
			ID_TURMA		= RS("ID_TURMA")
			COD_ALUNO		= RS("COD_ALUNO")


            telPrintenti =  "(" & mid(tel_enti,1,2) & ")" & " (" & mid(tel_enti,3,2) & ") " & mid(tel_enti,5,10)
            telPrintenti =  "(" & tel_ddi_enti & ")" & " (" & tel_ddd_enti & ") " & tel_enti

' 			if Len(TEL_ENTI)>0 then
' 				telPrintEnti = TEL_ENTI
' 				if TEL_DDI_ENTI<>"" and TEL_DDD_ENTI<>"" then
' 					telPrintEnti = "(" & TEL_DDI_ENTI & "-" & TEL_DDD_ENTI & ") " & telPrintEnti
' 				elseif TEL_DDD_ENTI<>"" then
' 					telPrintEnti = "(" & TEL_DDD_ENTI & ") " & telPrintEnti
' 				end if
' 			end if
		end if
		RS.Close

		%>
		<fieldset>
		<legend>dados da instituição</legend>
		<%
		if COD_ENTI>0 then
'			xxx = "SELECT NOME,isNull(SIGLA_UF,'') AS SIGLA_UF,isNull(NOME_MUNI,'') AS NOME_MUNI FROM ENTIDADES E LEFT JOIN MUNICIPIOS M ON E.COD_MUNI_IBGE=M.COD_MUNI_IBGE AND E.COD_UF_IBGE=M.COD_UF_IBGE LEFT JOIN UF ON E.COD_UF_IBGE=UF.COD_UF_IBGE WHERE COD_ENTI="&COD_ENTI
' Response.Write(xxx)

			sql_enti = "SELECT NOME,isNull(SIGLA_UF,'') AS SIGLA_UF,isNull(NOME_MUNI,'') AS NOME_MUNI FROM ENTIDADES E LEFT JOIN MUNICIPIOS M ON E.COD_MUNI_IBGE=M.COD_MUNI_IBGE AND E.COD_UF_IBGE=M.COD_UF_IBGE LEFT JOIN UF ON E.COD_UF_IBGE=UF.COD_UF_IBGE WHERE COD_ENTI="&COD_ENTI

    		if (COD_ENTI <> 21)	then
                RS.Open sql_enti
' Response.Write(COD_ENTI)
' Response.Write(sql_enti)
' Response.Write(RS("NOME"))
    			if RS.EOF then
    				%><p><label for="NOME_ENTI">Nome</label>Instituição não encontrada na base de dados!</p><%
    			else
    				%><p><label for="NOME_ENTI">Nome</label><%=RS("NOME")%>&nbsp;(<%if Len(RS("SIGLA_UF"))>0 and Len(RS("NOME_MUNI"))>0 then%><%=RS("NOME_MUNI")%>/<%=RS("SIGLA_UF")%><%else%>Estrangeiro<%end if%>)</p><%
    			end if
			    RS.Close
            else
                RS.Open sql_enti
   				%><p><label for="NOME_ENTI">Tipo</label>Pessoa Física</p><%
  				%><p><label for="NOME_ENTI">Nome</label><%=RS("NOME")%>&nbsp;(<%if Len(RS("SIGLA_UF"))>0 and Len(RS("NOME_MUNI"))>0 then%><%=RS("NOME_MUNI")%>/<%=RS("SIGLA_UF")%><%else%>Estrangeiro<%end if%>)</p><%
			    RS.Close
            end if
		else
            if isNull(tipoEnti) then tipoEnti=0
			IF tipoEnti=0 THEN
				%><p><label for="NOME_ENTI">&nbsp;</label>Cadastro de autônomo</p><%
			ELSE
				SQL = "SELECT DESCRICAO FROM TIPO_ENTIDADE WHERE ID_TIPO_ENTIDADE="&tipoEnti
				RS.Open SQL
				if not RS.eof then
					%><p><label for="NOME_ENTI">Instituição</label><% =RS("DESCRICAO") %></p><%
				else
					%><p><label for="NOME_ENTI">Instituição</label>Não cadastrado</p><%
				end if
				RS.Close
                if (tipoEnti<>21) then
    				SQL = "SELECT SIGLA_UF FROM UF WHERE COD_UF_IBGE="&COD_UF_ENTI
    				RS.Open SQL
    				if not RS.eof then
    					%><p><label for="NOME_ENTI">UF</label><% =RS("SIGLA_UF") %></p><%
    				else
    					%><p><label for="NOME_ENTI">UF</label>Não cadastrado</p><%
    				end if
    				RS.Close
    				SQL = "SELECT NOME_MUNI FROM MUNICIPIOS WHERE COD_UF_IBGE="&COD_UF_ENTI&" AND COD_MUNI_IBGE="&COD_MUNI_ENTI
    				RS.Open SQL
    				if not RS.eof then
    					%><p><label for="NOME_ENTI">Municipio</label><% =RS("NOME_MUNI") %></p><%
    				else
    					%><p><label for="NOME_ENTI">Municipio</label>Não cadastrado</p><%
    				end if
                end if
			END IF
		end if
		%>
		<%
		if VALOR>0 then
			%><p><label for="NOME_ENTI">&nbsp;</label><%if CUSTO_ENTI=0 then%>Pagamento por conta do participante<%else%>Pagamento por conta da instituição empregadora<%end if%></p><%
		end if
		%>
		</fieldset>
		<fieldset>
			<legend>dados pessoais</legend>
			<p><label for="NOME">Nome</label><%=NOME%>&nbsp;</p>
			<%if COD_PAIS=0 then%>
				<p><label for="CPF">CPF</label><%=formataCPF(CPF)%>&nbsp;</p>
			<%else%>
				<p><label for="CPF">ID tipo</label><%=ID_TIPO%>&nbsp;</p>
				<p><label for="CPF">ID número</label><%=ID_NUM%>&nbsp;</p>
			<%end if%>
			<p><label for="PASSWORD">Senha</label><%=PASSWORD%>&nbsp;</p>
			<p><label for="DT_NASCIMENTO">Nascimento</label><%=formataData(DT_NASCIMENTO)%>&nbsp;</p>
			<p><label for="SEXO">Sexo</label><%=SEXO%>&nbsp;</p>
			<p><label for="COD_RACA">Raça ou Cor</label><%=RACA%>&nbsp;</p>
			<p><label for="NACIONALIDADE">Nacionalidade</label><%=NOME_PAIS%>&nbsp;</p>
			<p><label for="EMAIL">E-mail</label><%=EMAIL%>&nbsp;</p>
			<p><label for="ENDERECO">Endereço</label><%=ENDERECO%>&nbsp;</p>
			<%if COD_PAIS=0 then%>
				<p><label for="CEP">CEP</label><%=formataCep(CEP)%>&nbsp;</p>
				<p><label for="COD_UF_IBGE">UF</label><%=SIGLA_UF%>&nbsp;</p>
				<p><label for="COD_MUNI_IBGE">Município</label><%=NOME_MUNI%>&nbsp;</p>
			<%end if%>
			<p><label for="TEL">Telefone</label><%=telPrint%>&nbsp;</p>
			<p><label for="FAX">Fax</label><%=faxPrint%>&nbsp;</p>
		</fieldset>
			<%
			sql = "SELECT * FROM VIEW_ALUNOS_TURMAS WHERE COD_ALUNO="&coda
			RS.open sql
			if not RS.eof then%>
				<fieldset>
					<legend>Participou das turmas</legend>
					<% while not RS.eof %>
						<p><label for="DT_NASCIMENTO">Código Turma</label><% =RS("CODIGO_TURMA") %></p>
						<p><label for="DT_NASCIMENTO">Titulo</label><% =RS("TITULO") %></p>
						<p><label for="DT_NASCIMENTO">Inicio da Turma</label><% =formataData(RS("DT_INICIO_TURMA")) %></p>
						<p><label for="DT_NASCIMENTO">Fim da Turma</label><% =formataData(RS("DT_FIM_TURMA")) %></p>
						<p><label for="DT_NASCIMENTO">Resultado</label><% =RS("STATUS") %></p>
						<b><br></p>
						<b><br></p>
						<% RS.movenext
					wend
					%>
				</fieldset>
			<% end if 
			RS.close%>
		<fieldset>
			<legend>dados profissionais</legend>
            <% if (CEP_ENTI = "0") then CEP_ENTI = "" end if %>
			<p><label for="SETOR">Setor</label><%=SETOR%>&nbsp;</p>
			<p><label for="CARGO">Cargo</label><%=CARGO%>&nbsp;</p>
			<p><label for="EMAIL_ENTI">E-mail</label><%=EMAIL_ENTI%>&nbsp;</p>
			<p><label for="ENDERECO_ENTI">Endereço</label><%=ENDERECO_ENTI%>&nbsp;</p>
			<p><label for="CEP_ENTI">CEP</label><% if (CEP_ENTI<>"") then Response.Write(CEP_ENTI) end if%>&nbsp;</p>
			<p><label for="TEL_ENTI">Telefone</label><%=telPrintEnti%>&nbsp;</p>
		</fieldset>
		<fieldset>
			<legend>formação acadêmica / titulação</legend>
			<p><label for="COD_ESCOLARIDADE">Escolaridade</label><%=ESCOLARIDADE%>&nbsp;</p>
			<p><label for="FORMACAO">Nome do curso</label><%=FORMACAO%>&nbsp;</p>
			<p><label for="COD_POS">Pós-graduação</label><%=TPOS%>&nbsp;</p>
			<p><label for="POS">Área</label><%=POS%>&nbsp;</p>
		</fieldset>
		<fieldset>
			<legend>cadastro no curso</legend>
			<p><label for="DT_CADASTRO">Data cadastro</label><%=formataData(DT_CADASTRO)%>&nbsp;</p>
			<p><label for="APROVADO">Inscrição</label><%=STATUS%><br /><br /></p>
		</fieldset>
		<%if VALOR>0 then%>
			<%
			RS.Open "SELECT isNull(SUM(VALOR),0) FROM PAGAMENTO WHERE ID_TURMA="&cod&" AND COD_ALUNO="&coda
			total_pago = RS(0)
			RS.Close
			%>
			<fieldset>
				<legend>dados de pagamento</legend>
				<p><label>Valor a ser pago</label>R$ <%=formataValor(VALOR)%></p>
				<p><label>Total pago</label>R$ <%=formataValor(total_pago)%><%if PAGO then%> [ pagamento regularizado ]<%else%> [ pagamento pendente ]<%end if%></p>
				<%
				if PARCELAS=0 then
					%><p><label>&nbsp;</label>Número de parcelas não definida.&nbsp;</p><%
				else
					for i = 1 to PARCELAS
						RS.Open "SELECT P.VALOR,DT_PGT,DT_VENC,P.ID_TURMA,C.TITULO,T.CODIGO_TURMA,T.DT_INICIO_TURMA,T.DT_FIM_TURMA,T.LUGAR FROM PAGAMENTO P join TURMAS T ON T.ID_TURMA=P.ID_TURMA JOIN CURSO C ON C.COD_CURSO=T.COD_CURSO WHERE T.ID_TURMA="&cod&" AND P.COD_ALUNO="&coda&"  AND P.NUM_PARCELA="&i
						if not RS.eof then
							TITULO = RS("TITULO")
							TURMA = RS("CODIGO_TURMA")
							DATA_INICIO_TURMA = RS("DT_INICIO_TURMA")
							DATA_FINAL_TURMA = RS("DT_FIM_TURMA")
							LOCAL = RS("LUGAR")
							DT_PAGTO = RS("DT_PGT")
							txt = "Pendente"
							if not RS.EOF then
								if RS("DT_VENC")<>"" then
									txt = txt & " (venc. especial: " & formataData(RS("DT_VENC")) & ")"
								end if
								if RS("VALOR")>0 then
									valorpago = RS("VALOR")
									txt = "R$ "&formataValor(RS("VALOR"))&" em "&formataData(RS("DT_PGT"))
								end if
							end if
							%><p><label>Parcela <%=i%></label><%=txt%>&nbsp;</p><%
						end if
						RS.Close
					next
				end if
				%>
				<p><label>Código do Projeto&nbsp;</label> <% =COD_PROJETO %></p>
			</fieldset>
			<%if CUSTO_ENTI=1 then%>
				<fieldset>
					<legend>arquivos de empenho</legend>
					<p><ul>
					<%
					cnt = 0
					nome_base = cod&"_"&coda&"_"
					Set fso = CreateObject("Scripting.FileSystemObject")
					Set folder = fso.getfolder(Server.MapPath("../empenhos"))
					For Each File in Folder.Files
						If mid(File.name,1,Len(nome_base))=nome_base Then
							aNome = Split(Mid(File.name,Len(nome_base)+1,InStr(File.name,".")-1-Len(nome_base)),"_")
							%><li><a href="../empenhos/<%=File.name%>" target="_new">Arquivo <%=aNome(1)%> da parcela <%=aNome(0)%></a></li><%
							cnt=cnt+1
						End If
					Next
					if cnt=0 then
						%></ul><p>Nenhum arquivo de empenho enviado até o momento</p><%
					else
						%></ul></p><%
					end if
					%>
				</fieldset>
			<%end if%>

		<%end if%>

		<p><a href="alunos.asp?ord=<%=ord%>&cod=<%=cod%>&st=<%=st%>">« voltar</a></p>

		<%if Session("key_alu")="ok" or Session("key_sta")="ok" or Session("key_ema")="ok" or Session("key_plc")="ok" or Session("key_plp")="ok" then%>
			<p><br /></p>
			<input type="hidden" name="ord" value="<%=ord%>">
			<input type="hidden" name="cod" value="<%=cod%>">
			<input type="hidden" name="st" value="<%=st%>">
			<input type="hidden" name="sel" value="<%=coda%>">
			<input type="hidden" name="coda" value="<%=coda%>">
			<input type="hidden" name="codp" value="<%=COD_PROJETO%>">
				
			<input type="hidden" name="data" value="<%=DT_PAGTO%>">
			<input type="hidden" name="nome" value="<%=NOME%>">
			<input type="hidden" name="valor" value="<%=valorpago%>">
			<input type="hidden" name="titulo" value="<%=TITULO%>">
			<input type="hidden" name="turma" value="<%=TURMA%>">
			<input type="hidden" name="datainicio" value="<%=DATA_INICIO_TURMA%>">
			<input type="hidden" name="datafinal" value="<%=DATA_FINAL_TURMA%>">
			<input type="hidden" name="local" value="<%=LOCAL%>">
			<input type="hidden" name="EMAIL" value="<%=EMAIL%>">
			

			<%msql = "COD_CURSO="&cod%>
			<input type="hidden" name="msql" value="<%=msql%>">
			<p>
				<select name="task" onChange="checkAcao(this.value);">
					<option value="">Selecione a ação para este aluno...</option>
					<%if Session("key_ema")="ok" then%>
						<option value="mail">Enviar e-mail</option>
                        <% if (Session("siga_projeto")=2)   then  %>
						    <option value="alunopqga">Editar os dados do aluno</option>
                        <% else  %>
						    <option value="aluno">Editar os dados do aluno</option>
                        <% end if   %>
					<%end if%>
				</select>
				<input type="submit" name="submit" value="Executar" class="buttonF">
			</p>
			<fieldset id="cursoDados" style="display:none">
				<legend>mudar o aluno de curso</legend>
				<p><label for="COD_CURSO">Curso</label><%=createSel("COD_CURSO","SELECT COD_CURSO,TITULO FROM CURSO WHERE COD_CURSO<>"&cod&" ORDER BY TITULO",0,0,"")%></p>
			</fieldset>
			<fieldset id="mailDados" style="display:block">
				<legend>enviar e-mail para os alunos selecionados</legend>
				<p><label for="ASSUNTO">Assuntos</label>
				<select name="ASSUNTO" onChange="Acertatexto(this.value);">
				<option></option>
				<% sql = "SELECT ID_MENSAGEM,[SUBJECT],MENSAGEM FROM MENSAGENS"
				RS.open sql
				while not RS.eof
					response.write "<option value='"&RS("ID_MENSAGEM")&"'>"&RS("SUBJECT")&"</OPTION>"
					RS.movenext
				wend
				RS.Close
				%>	
				</select></p>	
				<p><label for="TITULO">Assunto</label><input type="text" name="TITULO" id="TITULO" maxlength="250" size="60"></p>
					
				<p><label for="MSG">Mensagem</label><textarea cols=60 rows=6 name="MSG" id="MSG"></textarea></p>
				
			</fieldset>
			
			<fieldset id="vencDados" style="display:none">
				<legend>alterar vencimento de boleto</legend>
				<p>
					<label for="NUM_PARCELA">Núm. da parcela</label>
					<select name="NUM_PARCELA">
						<%
						for i = 1 to PARCELAS
							%><option value="<%=i%>">Parcela <%=i%></option><%
						next
						%>
					</select>
				</p>
				<p><label for="DT_VENC">Vencimento</label><input type="text" name="DT_VENC" id="DT_VENC" maxlength="10" size="11" onKeyPress="return ValidateKeyPressed('DATE', this, event);" onChange="valida_campo(4,this);"> (deixar em branco para voltar ao padrão)</p>
			</fieldset>
		<%end if%>
		</form>
		<p><br /></p>
	</div>	
</div>
</body>
</html>
<%conClose%>