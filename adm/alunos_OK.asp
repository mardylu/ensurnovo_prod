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

Set RS1 = Server.CreateObject("ADODB.Recordset")
RS1.CursorType = 0
RS1.ActiveConnection = Con

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
			
		function envia_moodle(a) {
			var str = a;
			var res = str.split(","); 
			var username = '?username='+res[0];
			var firstname = '&firstname='+res[1];
			var lastname = '&lastname='+res[2];
			var password = '&password='+res[3];
			var e_mail = '&email='+res[4];
			var turma = '&shortname='+res[5];
			var projeto = '&projeto='+res[6];

        	var destino = 'http://carvalho.eng.br/rogerio/php/hog_dropdown_pais.php';
        	var destino = 'http://200.196.54.5/enturmacao/enturmacao.php';

            var destino = 'http://200.196.54.5/enturmacao/enturmacao.php'+username+firstname+lastname+password+e_mail+turma+projeto;
// alert(destino);
// alert(turma);
            var destino = encodeURI(destino);
		    $.ajax({
		        type:'GET',
		        url:destino,
		        success: function (data) {
		            alert(data);
		        }
		    });
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
			case 16:
				tit = " Deficência Auditiva"
				sqlwhere = " AND (COD_DEFICIENCIA=2)"
			case 17:
				tit = " Deficência Motora"
				sqlwhere = " AND (COD_DEFICIENCIA=3)"
			case 18:
				tit = " Deficência Visual"
				sqlwhere = " AND (COD_DEFICIENCIA=4)"
			case 19:
				tit = " Deficência Intelectual"
				sqlwhere = " AND (COD_DEFICIENCIA=5)"
			case 20:
				tit = " Deficência Múltipla"
				sqlwhere = " AND (COD_DEFICIENCIA=6)"
			case 21:
				tit = " Deficência Outra"
				sqlwhere = " AND (COD_DEFICIENCIA=7)"
			case 22:
				tit = " Todas as deficências"
				sqlwhere = " AND (COD_DEFICIENCIA<>1)"
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
						con.execute "UPDATE TURMA_ALUNO SET STATUS='APROVADO' WHERE COD_CURSO="&cod&" AND COD_ALUNO IN ("&sel&")"
					end if
				case "naprova":
					if Session("key_sta")="ok" then
						con.execute "UPDATE TURMA_ALUNO SET STATUS='REPROVADO' WHERE ID_TURMA="&cod&" AND COD_ALUNO IN ("&sel&")"
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
						con.execute "UPDATE TURMA_ALUNO SET PAGO=0,STATUS='INSCRITO' WHERE ID_TURMA="&cod&" AND COD_ALUNO IN ("&sel&")"
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
							window.location = 'alunos.asp?ord=<%=ord%>&cod=<%=cod%>&st=<%=st%>&formulario=turma';
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
							window.open('alunos_frequencia.asp?ord=<%=ord%>&cod=<%=cod%>&st=<%=st%>&formulario=frequencia');
						</script>
					<%
					end if
				case "enturmar":
					sql = "SELECT NOME_BREVE,ID_PROJETO FROM TURMAS WHERE ID_TURMA = "&cod
					RS.open sql
					turma = RS("NOME_BREVE")
					ID_PROJETO = RS("ID_PROJETO")
					RS.close
					
					sql = "SELECT PROJETO_DBNAME FROM PROJETOS WHERE ID_PROJETO="&ID_PROJETO
					RS.open sql
					PROJETO_DBNAME = RS("PROJETO_DBNAME")
					RS.close
					
					sql = "SELECT A.CPF,A.PASSWORD,A.EMAIL,A.NOME,A.COD_ALUNO FROM ALUNO A JOIN TURMA_ALUNO TA ON A.COD_ALUNO=TA.COD_ALUNO WHERE A.COD_ALUNO IN ("&sel&")"
					RS.open sql
					while not RS.eof
						a = Split(RS("NOME"))
						i=0
                        lastname = ""
						for each x in a
     						if i=0 then
     							firstname = x
                                lastname = ""
     						else
     							lastname = lastname & " " & x
     						end if
     						i=i+1
 						next
						username 	= RS("CPF")
						password	= RS("PASSWORD")
						e_mail		= RS("EMAIL")
						' e_mail		= "ronaldo@rc9.net.br"

'   ================    gerar email

'	Comando original	mailErr=email(RS(0),"webensur@ibam.org.br",MSG,TITULO)
    data_de_hoje =  day(now) & "/" & month(now) & "/" & year(now)

MSG="Prezado(a) Participante," &  chr(13) & chr(13) & _
"É com satisfação que confirmamos sua inscrição e lhe damos boas vindas ao Curso: " & curso_tit & "." & chr(13) & chr(13) &  _
"O Ambiente Virtual de Aprendizagem do IBAM (AVA-IBAM) está sendo disponibilizado hoje, dia " & data_de_hoje & "." & chr(13) & chr(13) & _
"Primeiramente você deverá ler o Manual do Curso e o Guia do Participante, documentos que visam auxiliá-lo na navegação e uso das funcionalidades do AVA." & chr(13) & chr(13) & _
"Para acessar o Ambiente Virtual de Aprendizagem - AVA você deverá:" & chr(13) & chr(13) & _
"	. acessar a homepage do IBAM no endereço eletrônico www.ibam.org.br " & chr(13) & _
"	. clicar na aba  " & chr(34) & "cursos" & chr(34) & " e em seguida no botão " & chr(34) & "ambiente de ensino" & chr(34) & " e clicar em " & chr(34) & "acessar" & chr(34) & ";" & chr(13) & _
"	. inserir no campo de acesso ao curso o seguinte:" & chr(13) & chr(13) & _
"		. nome do Usuário -  digitar seu CPF  (somente os onze algarismos sem traço e ponto);" & chr(13) & _
"		. senha padrão – a mesma senha que o aluno se inscreveu no site do IBAM ." & chr(13) & chr(13) & _
"	. Localize na coluna central em " & chr(34) & "Cursos Disponíveis" & chr(34) & " o curso no qual você está inscrito;" & chr(13) & _
"	. Clique no link do curso: Ex: O Município e a Gestão Pública do Turismo." & chr(13) & chr(13) & _
"Seguindo os passos acima, você já estará na sua " & chr(34) & "sala de aula" & chr(34) & ". Em caso de dúvidas entre em contato com a equipe EAD-IBAM pelo e-mail ead@ibam.org.br." & chr(13) & chr(13) & _
"Bom curso!!!" & chr(13) & chr(13) & _
"Suporte EAD-IBAM"
                        TITULO = "ENSUR - EAD-IBAM"
						mailErr=email(e_mail,"webensur@ibam.org.br",MSG,TITULO)

'   Response.Write(data_de_hoje)
'   Response.Write(TITULO)
'   Response.Write(MSG)
'   Response.End

						projeto		= Trim(PROJETO_DBNAME)

						sql = "UPDATE TURMA_ALUNO SET ENTURMADO='E' WHERE ID_TURMA='" &cod & "' AND COD_ALUNO='"& RS("COD_ALUNO") &"'"
						RS1.open sql


' Response.Write("Cod_Turma: "&cod&"Nome Breve: "&turma)
' Response.End

							%>
							<script language="javascript">
								envia_moodle('<% =username %>,<% =firstname %>,<% =lastname %>,<% =password %>,<% =e_mail %>,<% =turma %>,<% =projeto %>');
							</script>
							<%
						RS.movenext
					wend
					RS.close

'						<script language="javascript">
'							alert('Enturmação realizada com sucesso');
'						</script>
'					<%

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
				case "receita":
					if Session("key_sta")="ok" then
					
					end if
				case "certificado":
						sql = "SELECT B.FIC_APRESENTACAO,B.ID_TURMA,C.COD_CURSO,A.COD_ALUNO,B.FIC_VERSO,A.EMAIL,A.CPF,A.COD_ALUNO,A.NOTA,A.EMAIL_ENVIADO,D.DESCRICAO,A.NOME,S.TITULO,B.NOME_FANTASIA,B.DT_INICIO_TURMA,B.DT_FIM_TURMA,B.CARGA_HORARIA_HORAS,B.CARGA_HORARIA_TIPO,TA.[STATUS],TA.PAGO FROM TURMA_ALUNO C JOIN ALUNO A ON C.COD_ALUNO=A.COD_ALUNO JOIN TURMAS B ON B.ID_TURMA=C.ID_TURMA JOIN CURSO_TIPO D ON D.COD_TIPO = B.COD_TIPO JOIN CURSO S ON S.COD_CURSO=C.COD_CURSO JOIN TURMA_ALUNO TA ON A.COD_ALUNO=TA.COD_ALUNO AND TA.COD_CURSO=B.COD_CURSO AND B.ID_TURMA=TA.ID_TURMA WHERE C.ID_TURMA="&cod&" AND TA.PAGO=1 AND TA.[STATUS] = 'APROVADO' AND A.COD_ALUNO IN ("&sel&")"
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
							
							if isnull(FIC_VERSO) then FIC_VERSO=""
							
							CARGA_HORARIA=RS("CARGA_HORARIA_HORAS")&" "&RS("CARGA_HORARIA_TIPO")
							DATA="Rio de Janeiro, "&dataextenso(hoje)
							'FIC_VERSO = Server.HTMLEncode(FIC_APRESENTACAO)
							
							texto="Certificamos que "&RS("NOME")& " concluiu com aproveitamento o curso "&TITULO&", realizado no período de "
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
							alert('<%=enviados%> Certificados emitidos. Somente são emitidos certificados para os alunos que estiverem Aprovados com o curso pago');
							window.location = 'alunos.asp?ord=<%=ord%>&cod=<%=cod%>&st=<%=st%>';
						</script>
						<%

				case "mail":
				
					if Session("key_ema")="ok" then
						TITULO = Request("TITULO")
						ASSUNTO = Request("ASSUNTO")
						IF ISNULL(ASSUNTO) OR LEN(ASSUNTO)=0 THEN ASSUNTO=0
						if Len(TITULO)=0 and ASSUNTO=0 then erroMsg("O título da mensagem deve ser preenchido")
						MSG=Replace(Request.Form("MSG"),"'","''")
						if Len(MSG)=0 then erroMsg("A mensagem deve ser preenchida")
						enviados = 0
						IF ASSUNTO>0 THEN
							sql = "SELECT ID_MENSAGEM,[SUBJECT],MENSAGEM FROM MENSAGENS WHERE ID_MENSAGEM='"&ASSUNTO&"'"
							RS.open sql
							TITULO=RS("SUBJECT")
							RS.close
						ELSE
							sql = "INSERT INTO MENSAGENS ([SUBJECT],MENSAGEM) VALUES ('"&TITULO&"','"&MSG&"')"
							RS.open sql
						END IF
						sql = "SELECT A.EMAIL,A.CPF,A.COD_ALUNO,A.NOTA,A.EMAIL_ENVIADO,D.DESCRICAO FROM TURMA_ALUNO C JOIN ALUNO A ON C.COD_ALUNO=A.COD_ALUNO JOIN TURMAS B ON B.ID_TURMA=C.ID_TURMA JOIN CURSO_TIPO D ON D.COD_TIPO = B.COD_TIPO WHERE C.ID_TURMA="&cod&" AND A.COD_ALUNO IN ("&sel&")"
						RS.Open sql
						while not RS.EOF
							NOTAS=""
							EMAIL_ENVIADO=""
							data=formatadataG(hoje)						
							mailErr=email(RS(0),"webensur@ibam.org.br",MSG,TITULO)
							enviados = enviados + 1
							sql = "INSERT INTO EMAIL (CPF,ASSUNTO,MENSAGEM,DATA_ENVIO,COD_ALUNO) VALUES ('"&RS("CPF")&"','"&TITULO&"','"&MSG&"','"&data&"','"&RS("COD_ALUNO")&"')"
							con.execute SQL
							NOTAS = RS("NOTA")
							NOTAS = NOTAS & CHR(10) & CHR(10) & "====< INICIO >====" & CHR(10) & CHR(10) & Session("nome") & " " & formatadata(data) & " " & formatahora(hora) & CHR(10)
							NOTAS = NOTAS & "EMAIL ENVIADO EM "&formatadata(data)&" "&chr(10)&chr(10)&TITULO&chr(10)&chr(10)&MSG
							sql = "UPDATE ALUNO SET NOTA='"&NOTAS&"' WHERE COD_ALUNO='"&RS("COD_ALUNO")&"'"
							con.execute sql
							EMAIL_ENVIADO = RS("EMAIL_ENVIADO")
							EMAIL_ENVIADO = EMAIL_ENVIADO & CHR(10) & CHR(10) & "====< INICIO >====" & CHR(10) & CHR(10) & Session("nome") & " " & formatadata(data) & " " & formatahora(hora) & CHR(10)
							EMAIL_ENVIADO = EMAIL_ENVIADO & "EMAIL ENVIADO EM "&formatadata(data)&" "&chr(10)&chr(10)&TITULO&chr(10)&chr(10)&MSG
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
		<h1>Curso "<%=curso_tit%>"</h1>
		<h1>Data de Inicio <%=formataData(DT_INICIO_TURMA)%>, data de Término <%=formataData(DT_FIM_TURMA)%></h1>
		<h1>Valor R$ <%=formataValor(VALOR)%>, Situação da turma: <%=STATUS_TURMA%></h1>
		
		<div align="right">
		<form name="form" action="alunos.asp" method="get">
		<input type="hidden" name="ord" value="<%=ord%>">
		<input type="hidden" name="cod" value="<%=cod%>">
		<select name="st" onChange="document.form.submit();">
			<option value="10"<%if st=10 then response.write " SELECTED"%>>Todos</option>
			<option value="1"<%if st=1 then response.write " SELECTED"%>>Inscritos</option>
			<option value="14"<%if st=14 then response.write " SELECTED"%>>Inscritos com Obs.</option>
			<option value="2"<%if st=2 then response.write " SELECTED"%>>Matriculados</option>
			<option value="12"<%if st=12 then response.write " SELECTED"%>>Matriculados sem isentos</option>
			<option value="3"<%if st=3 then response.write " SELECTED"%>>Com Anotações</option>
			<option value="12"<%if st=12 then response.write " SELECTED"%>>Com e-mails enviados</option>
			<option value="15"<%if st=15 then response.write " SELECTED"%>>A Enturmar</option>
			<%if valor>0 then%>
			<option value="4"<%if st=4 then response.write " SELECTED"%>>Alunos com pagamento quitado</option>
			<option value="5"<%if st=5 then response.write " SELECTED"%>>Alunos com pagamento pendente</option>
			<option value="6"<%if st=6 then response.write " SELECTED"%>>Pagamento por Boleto</option>
			<option value="7"<%if st=7 then response.write " SELECTED"%>>Pagamento por Pag-seguro</option>
			<option value="8"<%if st=8 then response.write " SELECTED"%>>Pagamento por Empenho</option>
			<option value="9"<%if st=9 then response.write " SELECTED"%>>Pagamento por Depósito</option>
			<option value="11"<%if st=11 then response.write " SELECTED"%>>Gratuítos</option>
			<%end if%>

			<option value="16"<%if st=16 then response.write " SELECTED"%>>Deficiência auditiva</option>
			<option value="17"<%if st=17 then response.write " SELECTED"%>>Deficiência motora</option>
			<option value="18"<%if st=18 then response.write " SELECTED"%>>Deficiência visual</option>
			<option value="19"<%if st=19 then response.write " SELECTED"%>>Deficiência intelectual</option>
			<option value="20"<%if st=20 then response.write " SELECTED"%>>Deficiência múltipla</option>
			<option value="21"<%if st=21 then response.write " SELECTED"%>>Outras deficiências</option>
			<option value="22"<%if st=22 then response.write " SELECTED"%>>Todas as deficiências</option>



		</select>
		<br />
		<button id="bt_menu" onClick="window.print();return false;">Imprimir</button>
		</form>
		</div>
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
'		sql = "SELECT C.ENTURMADO,A.COD_ALUNO,T.COD_STATUS_TURMA,EMAIL_ENVIADO,STATUS,NOTA,TEL,TEL_DDD,TEL_DDD_ENTI,TEL_ENTI,NOME,CPF,APROVADO,DT_CADASTRO,PAGO,FORMA_PGT,A.EMAIL,A.E_NOME,A.CARGO,C.ID_TURMA,(SELECT SUM(VALOR) FROM PAGAMENTO WHERE COD_ALUNO=A.COD_ALUNO AND ID_TURMA=C.ID_TURMA AND DT_PGT IS NOT NULL) AS VALOR FROM TURMA_ALUNO C JOIN ALUNO A ON C.COD_ALUNO=A.COD_ALUNO JOIN TURMAS T ON T.ID_TURMA=C.ID_TURMA WHERE C.ID_TURMA="&cod&sqlwhere&" ORDER BY "&sqlord
		sql = "SELECT C.ENTURMADO,A.COD_ALUNO,T.COD_STATUS_TURMA,EMAIL_ENVIADO,STATUS,NOTA,TEL,TEL_DDD,NOME,CPF,APROVADO,DT_CADASTRO,PAGO,FORMA_PGT,A.EMAIL,A.E_NOME,A.CARGO,C.ID_TURMA,(SELECT SUM(VALOR) FROM PAGAMENTO WHERE COD_ALUNO=A.COD_ALUNO AND ID_TURMA=C.ID_TURMA AND DT_PGT IS NOT NULL) AS VALOR FROM TURMA_ALUNO C JOIN ALUNO A ON C.COD_ALUNO=A.COD_ALUNO JOIN TURMAS T ON T.ID_TURMA=C.ID_TURMA WHERE C.ID_TURMA="&cod&sqlwhere&" ORDER BY "&sqlord
		'response.write sql
		RS.Open sql
		if RS.EOF then
			%><br /><p>Nenhum aluno cadastrado</p><%
		else
			COD_ALUNO = RS("COD_ALUNO")
			COD_STATUS_TURMA = RS("COD_STATUS_TURMA")
			%>
			<br /><p><%=total_alunos%> aluno(s) listado(s)</p>
			<% if task="receita" then %>
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
				<td class="header">Ent.</td>
				<td class="header"><a href="alunos.asp?ord=dc&cod=<%=cod%>&st=<%=st%>">dt. inscrição</a></td>
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
						<td><% =RS("ENTURMADO") %></td>
						<td><%=formataData(RS("DT_CADASTRO"))%></td>
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
					<%if Session("key_ema")="ok" then%>
						<option value="mail">Enviar e-mail</option>
					<%end if%>
					<%if Session("key_sta")="ok" then%>
						<%if valor>0 then%>
							<option value="pago">Marcar como pago</option>
							<option value="npago">Marcar como não pago</option>
							<option value="fgratuito">Marcar como Gratuítos</option>
							<option value="fpboleto">Forma Pgt. Boleto</option>
							<option value="fpempenho">Forma Pgt. Empenho</option>
							<option value="fppagseguro">Forma Pgt. PagSeguro</option>
							<option value="fpdeposito">Forma Pgt. Depósito</option>
							<option value="desconto">Conceder Descontos</option>
						<%end if%>
						<option value="nome">Nome dos Alunos</option>
						<option value="lista">Lista de participantes</option>
						<option value="frequencia">Lista de frequência</option>
						<option value="receita">Receita da Turma</option>
						<option value="enturmar">Enturmar</option>
						<option value="curso">Mudar de turma</option>
					<%end if%>
					<%if Session("key_plc")="ok" then%>
						<option value="planilhp">Gerar planilha parcial</option>
					<%end if%>
					<%if Session("key_plc")="ok" then%>
						<option value="planilha">Gerar planilha completa</option>
						<%if COD_STATUS_TURMA=6 then%>
							<option value="certificado">Emitir Certificado</option>
						<%end if%>
						<option value="fpgr">Emitir GR</option>
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
			
			<fieldset id="desconto" style="display:block">
				<legend>enviar e-mail para os alunos selecionados</legend>
				<p><label for="DESCONTO">Desconto</label><input type="text" name="DESCONTO" id="DESCONTO" maxlength="5" size="5">%</p>
				<p><label for="JUSTIFICATIVA">Justificativa</label><textarea cols=60 rows=6 name="JUSTIFICATIVA" id="JUSTIFICATIVA"></textarea></p>
			</fieldset>
		<%end if%>
		</form>
		<p><br /></p>
	</div>	
</div>
</body>
</html>
<%conClose%>