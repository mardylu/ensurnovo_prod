<%If session("key_ver")<>"ok" Then Response.Redirect "logout.asp"%>
<!-- #INCLUDE FILE="../library/parametros.asp" -->
<!-- #INCLUDE FILE="../library/conOpenAF.asp" -->
<!-- #INCLUDE FILE="../library/conOpen.asp" -->
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
<!--#include file="../fpdf.asp"-->

<%
if Session("key_sta")="ok" or Session("key_ema")="ok" or Session("key_plc")="ok" or Session("key_plp")="ok" then
	mostraSel = true
else
	mostraSel = false
end if
%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

	<title>ENSUR Inscrições</title>
	<script language="javascript">
	
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
				f.action = "gera_excel.asp";
			} else if (f.task.value==='planilhp') {
				f.action = "gera_excel.asp?p=1";
			} else {
				f.action = "alunos.asp";
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
			if (val==='mail') {
				document.getElementById('mailDados').style.display = 'block';
			} else {
				document.getElementById('mailDados').style.display = 'none';
			}
			if (val==='desconto') {
				document.getElementById('desconto').style.display = 'block';
			} else {
				document.getElementById('desconto').style.display = 'none';
			}
			if (val==='curso') {
				document.getElementById('cursoDados').style.display = 'block';
			} else {
				document.getElementById('cursoDados').style.display = 'none';
			}
		}
	</script>
</head>
<body onLoad="checkAcao(document.formAlunos.task.value);">
<div id="pagina">
	<!-- #INCLUDE FILE="include/topo_frequencia.asp" -->
	<div id="conteudo">
		<%
		cod = request("cod")
		if cod="" or isNumeric(cod)=false then erroMsg("Curso não encontrado")
		cod = int(cod)
		sql = "SELECT T.ID_TURMA,T.DT_INICIO_TURMA,T.CODIGO_TURMA,T.DT_FIM_TURMA,T.VALOR,T.COD_STATUS_TURMA,TS.STATUS_TURMA,(SELECT TITULO FROM CURSO WHERE COD_CURSO=T.COD_CURSO) AS TITULO FROM TURMAS T JOIN TURMA_STATUS TS ON T.COD_STATUS_TURMA=TS.COD_STATUS_TURMA WHERE T.ID_TURMA="&cod
		RS.Open sql
		if RS.EOF then erroMsg("Turma não encontrado")
		curso_tit = RS("TITULO")
		DT_INICIO_TURMA = RS("DT_INICIO_TURMA")
		DT_FIM_TURMA = RS("DT_FIM_TURMA")
		VALOR = RS("VALOR")
		STATUS_TURMA = RS("STATUS_TURMA")
		RS.Close
		st = request("st")
		if st=0 then
			st = 10
		end if
		if st="" or isNumeric(st)=false then st=0
		st = int(st)
		select case st
			case 1:
				tit = "inscritos"
				sqlwhere = " AND STATUS='INSCRITO'"
			case 2:
				tit = "matriculado"
				sqlwhere = " AND STATUS='MATRICULADO'"
			case 3:
				tit = "com anotações"
				sqlwhere = " AND NOTA is not null"
			case 4:
				tit = "com pagamento quitado"
				sqlwhere = " AND PAGO=1"
			case 5:
				tit = "com pagamento pendente"
				sqlwhere = " AND PAGO=0"
			case 6:
				tit = "pago por Boleto"
				sqlwhere = " AND FORMA_PGT=1"
			case 7:
				tit = "pago por Pag-seguro"
				sqlwhere = " AND FORMA_PGT=3"
			case 8:
				tit = "pago por Empenho"
				sqlwhere = " AND FORMA_PGT=2"
			case 9:
				tit = "pago por Depósito"
				sqlwhere = " AND FORMA_PGT=4"
			case 10:
				tit = "TODOS"
				sqlwhere = ""
			case 11:
				tit = " gratuítos"
				sqlwhere = " AND PAGO=2"
			case 12:
				tit = " e-mails enviados"
				sqlwhere = " AND EMAIL_ENVIADO is not null"
			case 13:
				tit = " Matriculados sem Isentos"
				sqlwhere = " AND STATUS='MATRICULADO' AND PAGO<>2"
			case 14:
				tit = " Inscrito com Obs"
				sqlwhere = " AND STATUS='INSCRITO' AND NOTA is not null"
			case 15:
				tit = " Enturmação"
				sqlwhere = " AND (STATUS='MATRICULADO' OR PAGO=2)"
		end select
		ord = request("ord")
		select case ord
			case "cp": sqlord = "CPF"
			case "pg": sqlord = "PAGO"
			case "ap": sqlord = "APROVADO"
			case "dc": sqlord = "DT_CADASTRO"
			case "fp": sqlord = "FORMA_PGT"
			case else: sqlord = "A.NOME"
		end select
		
		task = request("task")
		if task<>"" then
			sel = request.form("sel")
			if len(sel)=0 then 
				erroMsg("Selecionar ao menos um aluno")
			end if

			select case task
				case "aprova":
					if Session("key_sta")="ok" then
						con.execute "UPDATE TURMA_ALUNO SET APROVADO=1 WHERE COD_CURSO="&cod&" AND COD_ALUNO IN ("&sel&")"
					end if
				case "naprova":
					if Session("key_sta")="ok" then
						con.execute "UPDATE TURMA_ALUNO SET APROVADO=2 WHERE ID_TURMA="&cod&" AND COD_ALUNO IN ("&sel&")"
					end if
				case "pendente":
					if Session("key_sta")="ok" then
						con.execute "UPDATE TURMA_ALUNO SET APROVADO=0 WHERE ID_TURMA="&cod&" AND COD_ALUNO IN ("&sel&")"
					end if
				case "pago":
					if Session("key_sta")="ok" then
						con.execute "UPDATE TURMA_ALUNO SET PAGO=1,STATUS='MATRICULADO' WHERE ID_TURMA="&cod&" AND COD_ALUNO IN ("&sel&")"
					end if
				case "fpgr":
					if Session("key_sta")="ok" then
						response.redirect "../af/ar/gr_cria.asp?task=new&codp="&request("codp")&"&coda="&request("coda")&"&cod="&request("cod")&"&data="&request("data")&"&nome="&request("nome")&"&valor="&request("valor")&"&titulo="&request("titulo")&"&turma="&request("turma")&"&datainicio="&request("datainicio")&"&datafinal="&request("datafinal")&"&lugar="&request("local")&"&email="&request("email")
					end if
				case "npago":
					if Session("key_sta")="ok" then
						con.execute "UPDATE TURMA_ALUNO SET PAGO=0 WHERE ID_TURMA="&cod&" AND COD_ALUNO IN ("&sel&")"
					end if
				case "fpvazia":
					if Session("key_sta")="ok" then
						con.execute "UPDATE TURMA_ALUNO SET FORMA_PGT=0 WHERE ID_TURMA="&cod&" AND COD_ALUNO IN ("&sel&")"
					end if
				case "fpboleto":
					if Session("key_sta")="ok" then
						con.execute "UPDATE TURMA_ALUNO SET FORMA_PGT=1 WHERE ID_TURMA="&cod&" AND COD_ALUNO IN ("&sel&")"
					end if
				case "fpempenho":
					if Session("key_sta")="ok" then
						con.execute "UPDATE TURMA_ALUNO SET FORMA_PGT=2 WHERE ID_TURMA="&cod&" AND COD_ALUNO IN ("&sel&")"
					end if
				case "fppagseguro":
					if Session("key_sta")="ok" then
						con.execute "UPDATE TURMA_ALUNO SET FORMA_PGT=3 WHERE ID_TURMA="&cod&" AND COD_ALUNO IN ("&sel&")"
					end if
				case "fpdeposito":
					if Session("key_sta")="ok" then
						con.execute "UPDATE TURMA_ALUNO SET FORMA_PGT=4 WHERE ID_TURMA="&cod&" AND COD_ALUNO IN ("&sel&")"
					end if
				case "fgratuito":
					if Session("key_sta")="ok" then
						con.execute "UPDATE TURMA_ALUNO SET PAGO=2,STATUS='MATRICULADO' WHERE ID_TURMA="&cod&" AND COD_ALUNO IN ("&sel&")"
					end if
				case "turma":
					if Session("key_sta")="ok" then
					%>
						<script language="javascript">
							window.location = 'alunos.asp?ord=<%=ord%>&cod=<%=cod%>&st=<%=st%>';
						</script>
					<%
					end if
				case "nome":
					if Session("key_sta")="ok" then
					%>
						<script language="javascript">
							window.location = 'alunos.asp?ord=<%=ord%>&cod=<%=cod%>&st=<%=st%>&formulario=nome';
						</script>
					<%
					end if
				case "lista":
					if Session("key_sta")="ok" then
					%>
						<script language="javascript">
							window.location = 'alunos.asp?ord=<%=ord%>&cod=<%=cod%>&st=<%=st%>&formulario=lista';
						</script>
					<%
					end if
				case "frequencia":
					if Session("key_sta")="ok" then
					%>
						<script language="javascript">
							window.location = 'alunos.asp?ord=<%=ord%>&cod=<%=cod%>&st=<%=st%>&formulario=frequencia';
						</script>
					<%
					end if
				case "enturmar":
					%>
					<script language="javascript">
						alert('Este módulo ainda não foi implementado');
					</script>
					<%
					conClose
					Response.end
				case "curso":
					if Session("key_sta")="ok" then
						ID_TURMA=Request.Form("ID_TURMA")
						if ID_TURMA="" or isNull(ID_TURMA) or isNumeric(ID_TURMA)=false then erroMsg("Selecionar o curso")
						asel = split(sel,",")
						for each item in asel
							RS.Open "SELECT COUNT(*) FROM TURMA_ALUNO WHERE ID_TURMA="&ID_TURMA&" AND COD_ALUNO IN ("&sel&")"
							if RS(0)>0 then erroMsg("O aluno já está cadastrado no curso que está sendo transferido")
							RS.Close
							con.execute "UPDATE TURMA_ALUNO SET ID_TURMA="&ID_TURMA&",COD_ALUNO="&item&" WHERE ID_TURMA="&cod&" AND COD_ALUNO="&item
						next
					end if
				case "receita":
					if Session("key_sta")="ok" then
					
					end if
				case "certificado":
						sql = "SELECT B.ID_TURMA,C.COD_CURSO,A.COD_ALUNO,B.FIC_VERSO,A.EMAIL,A.CPF,A.COD_ALUNO,A.NOTA,A.EMAIL_ENVIADO,D.DESCRICAO,A.NOME,S.TITULO,B.NOME_FANTASIA,B.DT_INICIO_TURMA,B.DT_FIM_TURMA,B.CARGA_HORARIA_HORAS,B.CARGA_HORARIA_TIPO,TA.[STATUS],TA.PAGO FROM TURMA_ALUNO C JOIN ALUNO A ON C.COD_ALUNO=A.COD_ALUNO JOIN TURMAS B ON B.ID_TURMA=C.ID_TURMA JOIN CURSO_TIPO D ON D.COD_TIPO = B.COD_TIPO JOIN CURSO S ON S.COD_CURSO=C.COD_CURSO JOIN TURMA_ALUNO TA ON A.COD_ALUNO=TA.COD_ALUNO AND TA.COD_CURSO=B.COD_CURSO AND B.ID_TURMA=TA.ID_TURMA WHERE C.ID_TURMA="&cod&" AND TA.PAGO=1 AND TA.[STATUS] = 'APROVADO' AND A.COD_ALUNO IN ("&sel&")"
						RS.Open sql
						enviados=0
						while not RS.EOF
							enviados=enviados+1
							Set pdf=CreateJsObject("FPDF")
							pdf.CreatePDF "L","mm","A4"
							pdf.SetPath("./fpdf/")
							pdf.Open()
							pdf.AddPage()
							
							pdf.Image "img/certificado_frente.jpg",0,0,300,210,"JPG"
							if isnull(RS("NOME_FANTASIA")) then
							else
								TITULO=replace(RS("NOME_FANTASIA"),"Curso","")
							end if						
							m=RS("DESCRICAO")
							select case m
								case "EAD":
									MODALIDADE="a distância, via internet, "
								case "Presencial":
									MODALIDADE="presencial "
								case "misto":
									MODALIDADE="semi-presencial "
								case "In Company":
									MODALIDADE="in Company"
							end select
							INICIO=dataextenso(replace(RS("DT_INICIO_TURMA"),"-",""))
							FIM=dataextenso(replace(RS("DT_FIM_TURMA"),"-",""))
							FIC_VERSO = RS("FIC_VERSO")
							
							CARGA_HORARIA=RS("CARGA_HORARIA_HORAS")&" "&RS("CARGA_HORARIA_TIPO")
							DATA="Rio de Janeiro, "&dataextenso(hoje)
							
							texto="Certificamos que "&RS("NOME")& " concluiu com aproveitamento o Curso "&TITULO&", realizado no período de "
							texto=texto&INICIO& " a " &FIM&" na modalidade "&MODALIDADE&" com carga horária equivalente à "&CARGA_HORARIA
							texto=texto&" horas de estudo, ministrado pela Escola Nacional de Serviços Urbanos - ENSUR do Instituto Brasileiro de Administração Municipal - IBAM."
							
							pdf.SetLeftMargin 40
							pdf.SetRightMargin 30
							pdf.SetFont "Arial","",11
							pdf.SetY(90)
							pdf.SetX(40)
							pdf.MultiCell 0,8,texto,0,0,"J"
							
							pdf.SetY(130)
							pdf.SetX(40)
							pdf.MultiCell 0,8,DATA,0,0,"J"

							pdf.AddPage()
							'pdf.Image "img/certificado_verso.jpg",0,0,300,210,"JPG"
							pdf.SetFont "Arial","",11
							pdf.SetY(20)
							pdf.SetX(40)
							pdf.MultiCell 0,8,FIC_VERSO,0,0,"J"
							
							
							pdf.Close()
							arquivo=replace(RS("NOME")," ","_")
							pdf.Output(path_certificado&"Certificado_"&RS("COD_ALUNO")&"_"&RS("COD_CURSO")&"_"&RS("ID_TURMA")&".pdf")
							RS.MoveNext
						wend
						RS.Close
						%>
						<script language="javascript">
							alert('<%=enviados%> Certificados emitidos. Somente não emitidos certificados para os alunos que estiverem Aprovados com o curso pago');
							window.location = 'alunos.asp?ord=<%=ord%>&cod=<%=cod%>&st=<%=st%>';
						</script>
						<%
					
				case "mail":
				
					if Session("key_ema")="ok" then
						ASSUNTO = TRIM(Replace(Request.Form("ASSUNTO"),"'","''"))
						
						if ASSUNTO <> "0" then
							TITULO=ASSUNTO
						else
							TITULO=Replace(Request.Form("TITULO"),"'","''")
						end if
						
						if Len(TITULO)=0 then erroMsg("O título da mensagem deve ser preenchido")
						MSG=Replace(Request.Form("MSG"),"'","''")
						if Len(MSG)=0 then erroMsg("A mensagem deve ser preenchida")
						enviados = 0
						sql = "SELECT ID_MENSAGEM,[SUBJECT],MENSAGEM FROM MENSAGENS WHERE ID_MENSAGEM='"&TITULO&"'"
						RS.open sql
						TITULO=RS("SUBJECT")
						RS.close
						sql = "SELECT A.EMAIL,A.CPF,A.COD_ALUNO,A.NOTA,A.EMAIL_ENVIADO,D.DESCRICAO FROM TURMA_ALUNO C JOIN ALUNO A ON C.COD_ALUNO=A.COD_ALUNO JOIN TURMAS B ON B.ID_TURMA=C.ID_TURMA JOIN CURSO_TIPO D ON D.COD_TIPO = B.COD_TIPO WHERE C.ID_TURMA="&cod&" AND A.COD_ALUNO IN ("&sel&")"
						RS.Open sql
						while not RS.EOF
							NOTAS=""
							EMAIL_ENVIADO=""
							data=formatadata(hoje)						
							mailErr=email(RS(0),"webensur@ibam.org.br",MSG,TITULO)
							enviados = enviados + 1
							sql = "INSERT INTO EMAIL (CPF,ASSUNTO,MENSAGEM,DATA_ENVIO,COD_ALUNO) VALUES ('"&RS("CPF")&"','"&TITULO&"','"&MSG&"','"&data&"','"&RS("COD_ALUNO")&"')"
							con.execute SQL
							NOTAS = RS("NOTA")
							NOTAS = NOTAS & CHR(10) & CHR(10) & "====< INICIO >====" & CHR(10) & CHR(10) & Session("nome") & " " & data & " " & formatahora(hora) & CHR(10)
							NOTAS = NOTAS & "EMAIL ENVIADO EM "&data&" "&chr(10)&chr(10)&TITULO&chr(10)&chr(10)&MSG
							sql = "UPDATE ALUNO SET NOTA='"&NOTAS&"' WHERE COD_ALUNO='"&RS("COD_ALUNO")&"'"
							con.execute sql
							EMAIL_ENVIADO = RS("EMAIL_ENVIADO")
							EMAIL_ENVIADO = EMAIL_ENVIADO & CHR(10) & CHR(10) & "====< INICIO >====" & CHR(10) & CHR(10) & Session("nome") & " " & data & " " & formatahora(hora) & CHR(10)
							EMAIL_ENVIADO = EMAIL_ENVIADO & "EMAIL ENVIADO EM "&data&" "&chr(10)&chr(10)&TITULO&chr(10)&chr(10)&MSG
							sql = "UPDATE ALUNO SET EMAIL_ENVIADO='"&EMAIL_ENVIADO&"' WHERE COD_ALUNO='"&RS("COD_ALUNO")&"'"
							con.execute sql
							RS.MoveNext
						wend
						RS.Close
						%>
						<script language="javascript">
							alert('<%=enviados%> mensagens enviadas');
							window.location = 'alunos.asp?ord=<%=ord%>&cod=<%=cod%>&st=<%=st%>';
						</script>
						<%
						conClose
						Response.end
					end if
				case "desconto":
					if Session("key_ema")="ok" then
						Set RS1 = Server.CreateObject("ADODB.Recordset")
						RS1.CursorType = 0
						RS1.ActiveConnection = Con

						if Len(request("JUSTIFICATIVA"))=0 then erroMsg("Uma justificativa para o desconto deve ser preenchida")
						if Len(request("DESCONTO"))=0 then erroMsg("Digite um percentual de desconto")
						
						enviados = 0
						RS.Open "SELECT C.ID_TURMA,A.EMAIL,A.CPF,A.COD_ALUNO,A.NOTA FROM TURMA_ALUNO C JOIN ALUNO A ON C.COD_ALUNO=A.COD_ALUNO WHERE C.ID_TURMA="&cod&" AND A.COD_ALUNO IN ("&sel&")"
						ASSUNTO = "CONCESSÃO DE DESCONTO CEDIDO POR "&Session("nome")&" EM "&formatadata(hoje)&CHR(10)&CHR(10)&request("JUSTIFICATIVA")
						ASSUNTO = RS("NOTA")&CHR(10)&CHR(10)&"CONCESSÃO DE DESCONTO CEDIDO POR "&Session("nome")&" EM "&formatadata(hoje)&CHR(10)&CHR(10)&request("JUSTIFICATIVA")
						while not RS.EOF
							sql = "SELECT * FROM PAGAMENTO WHERE COD_ALUNO='"&RS("COD_ALUNO")&"' AND ID_TURMA='"&RS("ID_TURMA")&"'"
							RS1.open sql
							if not RS1.eof then
								enviados = enviados + 1
								sql = "UPDATE ALUNO SET NOTA='"&ASSUNTO&"' WHERE COD_ALUNO='"&RS("COD_ALUNO")&"'"
								con.execute sql
								VALOR = RS1("VALOR")-(RS1("VALOR") * (request("DESCONTO")/100))
								VALOR = INT(VALOR)
								con.execute "UPDATE PAGAMENTO SET VALOR='"&VALOR&"' WHERE COD_ALUNO='"&RS("COD_ALUNO")&"' AND DT_PGT IS NULL"								
							end if
							RS1.Close
							RS.MoveNext
						wend
						RS.Close
						%>
						<script language="javascript">
							alert('<%=enviados%> Descontos concedidos');
							window.location = 'alunos.asp?ord=<%=ord%>&cod=<%=cod%>&st=<%=st%>';
						</script>
						<%
						conClose
						Response.end
					end if
			end select
		end if
		%>
		<h1>Lista de Frequência do Curso</h1>
		<h1>Curso: <%=curso_tit%>"</h1>
		<h1>Data de Inicio: <%=formatadata(DT_INICIO_TURMA)%>,         data de Término: <%=formatadata(DT_FIM_TURMA)%></h1>
		
		<div align="right">
		<form name="formAlunos" action="alunos.asp" method="post" onSubmit="return checkForm();">
		<input type="hidden" name="ord" value="<%=ord%>">
		<input type="hidden" name="cod" value="<%=cod%>">
		<input type="hidden" name="st" value="<%=st%>">
		<%msql = "ID_TURMA="&cod&sqlwhere&" ORDER BY "&sqlord%>
		<input type="hidden" name="msql" value="<%=msql%>">
		<%
		sql = "SELECT COUNT(*) FROM TURMA_ALUNO C JOIN ALUNO A ON C.COD_ALUNO=A.COD_ALUNO WHERE ID_TURMA="&cod&sqlwhere
		RS.Open sql
			total_alunos = RS(0)
		RS.Close
		sql = "SELECT SUM(VALOR) FROM PAGAMENTO P JOIN ALUNO A ON P.COD_ALUNO = A.COD_ALUNO JOIN TURMA_ALUNO T ON A.COD_ALUNO=T.COD_ALUNO WHERE DT_PGT IS NOT NULL AND T.ID_TURMA="&cod&sqlwhere
	
		RS.Open sql
			total_receita = RS(0)
		RS.Close
		sql = "SELECT A.COD_ALUNO,T.COD_STATUS_TURMA,EMAIL_ENVIADO,STATUS,NOTA,TEL,TEL_DDD,TEL_DDD_ENTI,TEL_ENTI,NOME,CPF,APROVADO,DT_CADASTRO,PAGO,FORMA_PGT,A.EMAIL,A.E_NOME,A.CARGO,C.ID_TURMA,(SELECT SUM(VALOR) FROM PAGAMENTO WHERE COD_ALUNO=A.COD_ALUNO AND ID_TURMA=C.ID_TURMA AND DT_PGT IS NOT NULL) AS VALOR FROM TURMA_ALUNO C JOIN ALUNO A ON C.COD_ALUNO=A.COD_ALUNO JOIN TURMAS T ON T.ID_TURMA=C.ID_TURMA WHERE C.ID_TURMA="&cod&sqlwhere&" ORDER BY "&sqlord
		'response.write sql
		RS.Open sql
		if RS.EOF then
			%><br /><p>Nenhum aluno cadastrado</p><%
		else
			COD_ALUNO = RS("COD_ALUNO")
			COD_STATUS_TURMA = RS("COD_STATUS_TURMA")
			if request("formulario")<>"frequencia" then
				%>
				<br /><p><%=total_alunos%> aluno(s) listado(s)</p>
				<%
			end if
			if task="receita" then %>
				<br /><p>Receita da turma R$ <%=formatavalor(total_receita)%> </p>
			<% end if %>		
			<% if request("formulario")="" then%>
				<table id="tabela">
				<tr><td class="header">
				<%if mostraSel then%><input type="checkbox" name="main" value="1" onClick="checkAll(this.checked);"><%end if%></td>
				<td class="header"><a href="alunos.asp?ord=nm&cod=<%=cod%>&st=<%=st%>">nome</a></td>
				<td class="header"><a href="alunos.asp?ord=cp&cod=<%=cod%>&st=<%=st%>">cpf</a></td>
				<td class="header"><a href="alunos.asp?ord=cp&cod=<%=cod%>&st=<%=st%>">Telefone</a></td>
				<td class="header"><a href="alunos.asp?ord=fp&cod=<%=cod%>&st=<%=st%>">forma pgt.</a></td>
				<%if valor>0 then%><td class="header"><a href="alunos.asp?ord=pg&cod=<%=cod%>&st=<%=st%>">pago</a>
				<%end if%><td class="header"><a href="alunos.asp?ord=ap&cod=<%=cod%>&st=<%=st%>">Status.</a></td>
				<td class="header"><a href="alunos.asp?ord=dc&cod=<%=cod%>&st=<%=st%>">dt. cadastro</a></td>
				<% if task="receita" then %>
					<td class="header">Valor</td>
				<% else %>
					<td class="header"><a href="alunos.asp?ord=dc&cod=<%=cod%>&st=<%=st%>">Obs.</a></td>
					<td class="header"><a href="alunos.asp?ord=dc&cod=<%=cod%>&st=<%=st%>">e-mail.</a></td>
				<% end if %>
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
						<td><a href="aluno.asp?ord=<%=ord%>&cod=<%=cod%>&st=<%=st%>&coda=<%=RS("COD_ALUNO")%>"><%=RS("NOME")%></a></td>
						<td><%=FormataCPF(RS("CPF"))%></td>
						<td>(<%=RS("TEL_DDD")%>)<%=formatatel(RS("TEL"))%></td>
						<td><%=aFormaPgt(RS("FORMA_PGT"))%></td>
						<%if valor>0 then%><td><%=pago%></td>
						<%end if%><td><%=RS("STATUS")%></td>
						<td><%=formataData1(RS("DT_CADASTRO"))%></td>
						<% if task="receita" then %>
							<td><%=formatavalor(RS("VALOR"))%></td>
						<% else %>
						<td><a href="javascript:window.open('notas.asp?aluno=<%=RS("COD_ALUNO")%>','','scrollbars=yes,width=500,height=400');void(0);"" title=""Obs. do Aluno">
							<%if nota<>"" then%>
								<img src="../img/notas_com.jpg" border="0">
							<%else%>
								<img src="../img/notas_sem.jpg" border="0">
							<%end if%></a></td>
						<td><a href="javascript:window.open('email.asp?aluno=<%=RS("COD_ALUNO")%>','','scrollbars=yes,width=500,height=400');void(0);"" title=""Obs. do Aluno">
							<%if email_enviado<>"" then%>
								<img src="../img/notas_com.jpg" border="0">
							<%else%>
								<img src="../img/notas_sem.jpg" border="0">
							<%end if%></a></td>
							<% end if %>
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
				<table width="25%" align="right"><tr><td>Data: _____/_____/_____ </td></tr></table>
				<p><br></p>
				<p><br></p>
				<table id="tabela" border="1" cellspacing="25" cellpadding="25">
				<tr>
				<td class="header" width="45%" align="center"><a href="alunos.asp?ord=nm&cod=<%=cod%>&st=<%=st%>">Nome</a></td>
				<td class="header" width="15%" align="center"><a href="alunos.asp?ord=cp&cod=<%=cod%>&st=<%=st%>">CPF</a></td>
				<td class="header" width="20%" align="center"><a href="alunos.asp?ord=fp&cod=<%=cod%>&st=<%=st%>">Manhã</a></td>
				<td class="header" width="20%" align="center"><a href="alunos.asp?ord=dc&cod=<%=cod%>&st=<%=st%>">Tarde</a></td>
				</tr>
				<%
				c = 0
				while not RS.EOF
					%><tr class="c<%=c%>" height="50">
						<td><%=RS("NOME")%></td>
						<td align="center"><%=formatacpf(RS("CPF"))%></td>
						<td></td>
						<td></td>
						</tr><%
					RS.MoveNext
				wend
				RS.Close
				%>
				</table>
			<% end if 		
			end if %>
		</form>
		<p><br /></p>
	</div>	
</div>
<button id="bt_menu" onClick="window.print();return false;">Imprimir</button>
</body>
</html>
<%conClose%>