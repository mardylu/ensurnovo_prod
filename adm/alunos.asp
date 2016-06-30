<%If session("key_ver")<>"ok" Then Response.Redirect "logout.asp"%>
<!-- #INCLUDE FILE="../library/parametros.asp" -->
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


	<title>ENSUR - SIGA</title>
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
                    var siga_excel = <%=SIGA_PROJETO%>;
			    if (siga_excel==2)  {
			        // alert('PQGA');
				    f.action = "http://cursos.ibam.org.br/adm/gera_excelpqga.asp";
                } else {
		            f.action = "http://cursos.ibam.org.br/adm/gera_excel.asp";
                }
			} else if (f.task.value==='planilhp') {
                        var siga_excel = <%=SIGA_PROJETO%>;
			            if (siga_excel==2)  {
				            f.action = "http://cursos.ibam.org.br/adm/gera_excelpqga.asp?p=1";
                        } else {
				            f.action = "http://cursos.ibam.org.br/adm/gera_excel.asp?p=1";
                        }
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
            // var username = '?username=56255498182';
			var firstname = '&firstname='+res[1];
			var lastname = '&lastname='+res[2];
			// var lastname = '&lastname=XXXX';
			var password = '&password='+res[3];
			var e_mail = '&email='+res[4];
			var turma = '&shortname='+res[5];
			var projeto = '&projeto='+res[6];

//        	var destino = 'http://200.196.54.5/enturmacao/enturmacao.php';

            var destino = 'http://200.196.54.5/enturmacao/enturmacao.php'+username+firstname+lastname+password+e_mail+turma+projeto;
// alert(destino);
// alert(turma);
            var destino = encodeURI(destino);
// alert(destino);
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
		sql = "SELECT T.ID_TURMA,T.DT_INICIO_TURMA,T.CODIGO_TURMA,T.DT_FIM_TURMA,T.VALOR,T.COD_CURSO,T.COD_STATUS_TURMA,TS.STATUS_TURMA,(SELECT TITULO FROM CURSO WHERE COD_CURSO=T.COD_CURSO) AS TITULO FROM TURMAS T JOIN TURMA_STATUS TS ON T.COD_STATUS_TURMA=TS.COD_STATUS_TURMA WHERE T.ID_TURMA="&cod
		RS.Open sql
		if RS.EOF then erroMsg("Turma não encontrado")
		curso_tit = RS("TITULO")
		COD_CURSO_fpboleto = RS("COD_CURSO")
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
				sqlwhere = " AND (COD_DEFICIENCIA>1) AND (COD_DEFICIENCIA<8)"
			case 23:
				tit = " Aprovados"
				sqlwhere = " AND STATUS='APROVADO'"
   			case 24:
				tit = " Reprovados"
				sqlwhere = " AND STATUS='REPROVADO'"
			case 25:
				tit = " Evadidos"
				sqlwhere = " AND STATUS='EVADIDO'"
			case 24:
				tit = " Nunca Acessaram"
				sqlwhere = " AND STATUS='NUNCA ACESSOU'"
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
                        'Rotina para cálculo do valor do boleto
            			if CUSTO_ENTI and ASSOCIADO then
            				VALOR_1 = Round(VALOR * .8)
            				dataVal=DT_INICIO_TURMA
            				txt = "O VALOR DO BOLETO INCLUI OS 20% DE DESCONTO AOS ASSOCIADOS DO IBAM COM PAGAMENTO À VISTA ATÉ A DATA DE VENCIMENTO DESTE BOLETO"
            			else
            				if DT_INICIO_TURMA>=hoje then
            					VALOR_1 = Round(VALOR * .9)
            					dataVal=DT_INICIO_TURMA
            					txt = "O VALOR DO BOLETO INCLUI OS 10% DE DESCONTO PARA PAGAMENTO À VISTA ATÉ A DATA DE VENCIMENTO DESTE BOLETO"
            				else
            					VALOR_1 = VALOR
            					dataVal=addDate("m",1,hoje)
            					txt = "VALOR PARA PAGAMENTO À VISTA ATÉ A DATA DE VENCIMENTO DESTE BOLETO"
            				end if
            			end if
                        sql4 = "SELECT * FROM PAGAMENTO WHERE COD_ALUNO='" & sel & "' AND ID_TURMA='" & cod & "'"
                        ' Response.Write ("SQL4: "&sql4&"<br>")
                        RS4.open sql4
					    if RS4.eof   then
                            ' Response.Write ("COD_ALUNO: "&sel&"<br>")
                            ' Response.Write ("COD_CURSO: "&COD_CURSO_fpboleto&"<br>")
                            ' Response.Write ("ID_TURMA: "&cod&"<br>")
                            ' Response.Write ("DT_VENC: "&DT_INICIO_TURMA&"<br>")
                            ' Response.Write ("VALOR: "&VALOR_1&"<br>")
                            ' Response.Write ("SQL4: "&sql4&"<br>")
                            sql41 = "INSERT INTO PAGAMENTO (COD_CURSO,COD_ALUNO,NUM_PARCELA,ID_TURMA,DT_VENC,VALOR) " & _
                                                 "VALUES ('"&COD_CURSO_fpboleto&"','"&sel&"',1,'"&cod&"',"&DT_INICIO_TURMA&",'"&VALOR_1&"')"
                			con.execute sql41
                            ' Response.Write ("SQL41: "&sql41&"<br>")
                            ' Response.End
                            ' GERAR BOLETO - incluir o registro na tabela PAGAMENTO - checar se existe o registro, se não existir gerar, caso contrário '
                        end if
                        RS4.close
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
					sql = "SELECT NOME_BREVE,ID_PROJETO,NOME_FANTASIA,DT_INICIO_TURMA,DT_FIM_TURMA FROM TURMAS WHERE ID_TURMA = "&cod
					RS.open sql
					turma = RS("NOME_BREVE")
					ID_PROJETO = RS("ID_PROJETO")
                    MAIL_NOME_FANTASIA =  RS("NOME_FANTASIA")
                    MAIL_DATA_INICIO   =  RS("DT_INICIO_TURMA")
                    MAIL_DATA_INICIO   =  formatadata(MAIL_DATA_INICIO)
                    MAIL_DATA_FINAL    =  RS("DT_FIM_TURMA")
                    MAIL_DATA_FINAL    =  formatadata(MAIL_DATA_FINAL)

					RS.close
                    if (ID_PROJETO=3)   then ID_PROJETO=1   end if      ' Redireciona para o Moodle Ensur
					sql = "SELECT PROJETO_DBNAME FROM PROJETOS WHERE ID_PROJETO="&ID_PROJETO
					RS.open sql
					PROJETO_DBNAME = RS("PROJETO_DBNAME")
					RS.close
					sql = "SELECT A.CPF,A.PASSWORD,A.EMAIL,A.NOME,A.COD_ALUNO,A.COD_ENTI,A.TIPOENTI FROM ALUNO A "  & _
                          "JOIN TURMA_ALUNO TA ON A.COD_ALUNO=TA.COD_ALUNO "    & _
                          "WHERE TA.ID_TURMA=" & cod & " AND A.COD_ALUNO IN ("&sel&")"
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

                        if (SIGA_PROJETO <> 2)   then
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
                        end if

'   Response.Write(data_de_hoje)
'   Response.Write(TITULO)
'   Response.Write(MSG)
'   Response.End

						projeto		= Trim(PROJETO_DBNAME)

						sql = "UPDATE TURMA_ALUNO SET ENTURMADO='E' WHERE ID_TURMA='" &cod & "' AND COD_ALUNO='"& RS("COD_ALUNO") &"'"
						RS1.open sql


' Response.Write("Cod_Turma: "&cod&"Nome Breve: "&turma)
' Response.End
                        firstname = Replace(firstname, "'", "''")
                        lastname  = Replace(lastname, "'", "\'")
							%>
							<script language="javascript">
								envia_moodle('<% =username %>,<% =firstname %>,<% =lastname %>,<% =password %>,<% =e_mail %>,<% =turma %>,<% =projeto %>');
							</script>
							<%

                    ' Gerar email de confirmação da enturmação do PQGA


                        if (SIGA_PROJETO = 2) then
                            MSG="<html> " & _
                                "<head> " & _
                                "<style> " & _
                                "p { " & _
                                "    font-family: Arial, Helvetica, sans-serif; " & _
                                "    font-size: 12px; " & _
                                "} " & _
                                "</style> " & _
                                "</head> " & _
                                "<body lang=PT-BR link=blue vlink=purple style='tab-interval:35.4pt'> " & _
                                "<div class=WordSection1> " & _
                                "<p ></p> " & _
                                "<table border=1 cellpadding=8 width='90%'> " & _
                                " <tr> " & _
                                "  <td width=573 valign=top> " & _
                                "  <p> " & _
                                "    <table width='100%'> " & _
                                "        <tr> " & _
                                "            <td align='left'  width='50%'><img width=269 height=108 src='http://cursos.ibam.org.br/pqga/images/Email_PQGA_logo01.png'></td> " & _
                                "            <td align='right' width='50%'><img width=164 height=90 src='http://cursos.ibam.org.br/pqga/images/Email_PQGA_logo02.jpg'></td> " & _
                                "        </tr> " & _
                                "    </table> " & _
                                "  </p> " & _
                                "  </td> " & _
                                " </tr> " & _
                                " <tr> " & _
                                "  <td width=573 valign=top> " & _
                                "  <p><br>Caro(a) participante,</p> " &  _
                                "  <p>Bem-vindo(a) ao nosso Curso!</p> " & _
                                "  <p>Você está participando do curso " & MAIL_NOME_FANTASIA & ", que será iniciado no dia " & MAIL_DATA_INICIO & " </p> " & _
                                "  <p>Terá a duração de até 45 dias. </p>" & _
                                "  <p>A data-limite para a sua conclusão é " & MAIL_DATA_FINAL & ".</p> "
                         MSG1 = "  <p>                     A partir de agora você pode entrar na página pública do Ambiente Virtual de Aprendizagem (AVA). "  & _
                                "  Lá você encontrará o GUIA DE NAVEGAÇÃO e o GUIA DO CURSO, na parte inferior esquerda da página, " & _
                                "  sob o título ""Guias e Termo de Compromisso"".</p>"  & _
                                "  Conheça os guias, na página pública do AVA, acessando: <br>" & _
                                "  <a href=""http://www.pqga.ibam.org.br/capacitacao""><b>http://www.pqga.ibam.org.br/capacitacao</b></a></p>"  & _
                                "  <p>Para efetivamente participar no ambiente da sua turma, entre com seus dados personalizados, "  & _
                                "  clicando em ""Entrar"" no canto superior direito da página pública do AVA, ou acesse diretamente o endereço abaixo: <br>" & _
                                "  <a href=""http://www.pqga.ibam.org.br/capacitacao/login""><b>http://www.pqga.ibam.org.br/capacitacao/login</b></a></p>"  & _
                                "  <p>Siga então os seguintes passos:</p>"  & _
                                "  <ul> "  &  _
                                "      <li>digite o seu nome de usuário: composto apenas pelos números do seu CPF (não utilize pontos, espaços ou traços)"  &  _
                                "      <li>digite sua senha: é a senha que você cadastrou na Ficha de Inscrição"  &  _
                                "      <li>caso tenha esquecido a senha que foi criada, recupere essa informação no link a seguir: <br>"  &  _
                                "  <a href=""http://cursos.ibam.org.br/esqueci.asp""><b>http://cursos.ibam.org.br/esqueci.asp</b></a></ul></p>"  & _
                                "  <p>Ao entrar no AVA você será direcionado à sua página inicial e nela encontrará a lista das turmas das quais participa.</p>"  &  _
                                " <p>Além do aprimoramento pessoal e dos novos conhecimentos, o curso proporciona oportunidade de interação e troca " & _
                                " de experiências entre os participantes no Ambiente Virtual de Aprendizagem (AVA), moderadas por um(a) profissional " & _
                                " especializado(a) na condição de Tutor(a) da turma. Aproveite! </p>" & _
                                "  <p></p> " & _
                                "  <p>Se houver alguma dúvida, não hesite em entrar em contato pelo e­mail pqga&#45;ead@ibam.org.br ou pelos telefones (21) 2536&#45;9774 ou 2536&#45;9737, sms ou whatsapp (21) 99755&#45;1445. </p> " & _
                                "  <p><br>Bom estudo!</p> " & _
                                "  <p>Att,<br>Gestão Acadêmica PQGA/IBAM</p> " & _
                                "  </td> " & _
                                " </tr> " & _
                                " <tr> " & _
                                "  <td width=573 valign=top> " & _
                                "  <p>Mais informações <a href='http://amazonia-ibam.org.br' target='_blank' title='Este link externo irá abrir em nova janela'><b>clique " & _
                                "  aqui</b></a> ou pelo email <a href='mailto:pqga-ead@ibam.org.br' target='_blank' title='Este link externo irá abrir em nova janela'> " & _
                                "  <b>pqga-ead@ibam.org.br</b></a> | (21) 2536-9774 </p> " & _
                                "  </td> " & _
                                " </tr> " & _
                                "</table> " & _
                                "<p></p> " & _
                                "</div> " & _
                                "</body> " & _
                                "</html>"

                                MSG_TOTAL = MSG & MSG1
                                EMAIL_DESTINO = e_mail
                                TITULO = "Capacitação em Gestão Ambiental - Confirmação da Enturmação"
                				mailErr=emailhtml(EMAIL_DESTINO,"pqga-ead@ibam.org.br",MSG_TOTAL,TITULO)
                            end if
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
						sql = "SELECT B.FIC_APRESENTACAO,B.ID_TURMA,C.COD_CURSO,A.COD_ALUNO,B.FIC_VERSO,A.EMAIL,A.CPF,A.COD_ALUNO,A.NOTA,"      & _
                                     "A.EMAIL_ENVIADO,D.DESCRICAO,A.NOME,S.TITULO,B.NOME_FANTASIA,B.VALOR,B.DT_INICIO_TURMA,B.DT_FIM_TURMA,"    & _
                                     "B.CARGA_HORARIA_HORAS,B.CARGA_HORARIA_TIPO,TA.[STATUS],TA.PAGO FROM TURMA_ALUNO C "                       & _
                                     "JOIN ALUNO A ON C.COD_ALUNO=A.COD_ALUNO "         & _
                                     "JOIN TURMAS B ON B.ID_TURMA=C.ID_TURMA "          & _
                                     "JOIN CURSO_TIPO D ON D.COD_TIPO = B.COD_TIPO "    & _
                                     "JOIN CURSO S ON S.COD_CURSO=C.COD_CURSO "         & _
                                     "JOIN TURMA_ALUNO TA ON A.COD_ALUNO=TA.COD_ALUNO AND TA.COD_CURSO=B.COD_CURSO AND B.ID_TURMA=TA.ID_TURMA "  & _
                                     "WHERE C.ID_TURMA="&cod&" AND TA.[STATUS] = 'APROVADO' "                           & _
						             "      AND ( ( TA.PAGO=1 AND B.VALOR<>0  )  OR  ( TA.PAGO=0 AND B.VALOR=0 )   )  " & _
                                     "      AND A.COD_ALUNO IN ("&sel&")"
' Response.Write(sql)
' Response.End
						RS.Open sql
						enviados=0
						while not RS.EOF
							enviados=enviados+1

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

//							CARGA_HORARIA=RS("CARGA_HORARIA_HORAS")&" "&RS("CARGA_HORARIA_TIPO")
							CARGA_HORARIA=RS("CARGA_HORARIA_HORAS")

'							DATA="Rio de Janeiro, "&dataextenso(hoje)
'							DATA="Rio de Janeiro, "&data_de_hoje
                            dia_cert=day(now)
                            if (len(dia_cert)=1)  then dia_cert="0"&dia_cert  end if
                            mes_cert=month(now)
                            if (mes_cert=01)   then mes_txt="Janeiro"  end if
                            if (mes_cert=02)   then mes_txt="Fevereiro"  end if
                            if (mes_cert=03)   then mes_txt="Março"  end if
                            if (mes_cert=04)   then mes_txt="Abril"  end if
                            if (mes_cert=05)   then mes_txt="Maio"  end if
                            if (mes_cert=06)   then mes_txt="Junho"  end if
                            if (mes_cert=07)   then mes_txt="Julho"  end if
                            if (mes_cert=08)   then mes_txt="Agosto"  end if
                            if (mes_cert=09)   then mes_txt="Setembro"  end if
                            if (mes_cert=10)   then mes_txt="Outubro"  end if
                            if (mes_cert=11)   then mes_txt="Novembro"  end if
                            if (mes_cert=12)   then mes_txt="Dezembro"  end if
                            ano_cert=year(now)
							DATA="Rio de Janeiro, "& dia_cert &" de "& mes_txt &" de "& ano_cert
 ' Response.Write("Dia: " & dia_cert & "<br>")
'  Response.Write("Mes: " & mes_cert & "<br>")
'  Response.Write("Ano: " & ano_cert & "<br>")
'  Response.Write("Data: " & DATA & "<br>")
'  Response.Write(month(now))
'  Response.Write(year(now))
'  Response.Write(day(now))
'  Response.Write(month(now))
'  Response.Write(year(now))
'  Response.End

' ================================================================================================================================================

' ====================< INÍCIO DA PREPARAÇÃO DA FRENTE DO CERTIFICADO  >=============================

            Set Pdf = Server.CreateObject("Persits.Pdf")

            Set Doc = Pdf.CreateDocument

            Set Page = Doc.Pages.Add(595.3, 841.9)
            Set Font = Doc.Fonts("Helvetica")

            Page.Rotate = 90
            Page.Canvas.SaveState
            Page.Canvas.SetCTM 0, 1, -1, 0, Page.Width, 0

            Set Image = Doc.OpenImage( Server.MapPath( "./certificados/certificadofrente.jpg") )
            Set Param = Pdf.CreateParam

            Param("x") = 0
            Param("y") = 0
            Param("ScaleX") = 1.24
            Param("ScaleY") = 1.24

            Page.Canvas.DrawImage Image, Param

' ====================< INÍCIO DA MONTAGEM DO TEXTO DA FRENTE DO CERTIFICADO  >=============================
			if isnull(RS("NOME_FANTASIA")) then
			else
				TITULO=replace(RS("NOME_FANTASIA"),"Curso","")
			end if
            TITULO=UCase(TITULO)
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

			CARGA_HORARIA=RS("CARGA_HORARIA_HORAS")
'			DATA="Rio de Janeiro, "&dataextenso(hoje)

			texto="Certificamos que "&RS("NOME")& " concluiu com aproveitamento o curso "&TITULO&", realizado no período de "
			texto=texto&INICIO& " a " &FIM&" na modalidade "&MODALIDADE&" com carga horária equivalente a "& CARGA_HORARIA
			texto=texto&" horas de estudo, ministrado pela Escola Nacional de Serviços Urbanos - ENSUR do Instituto Brasileiro de Administração Municipal - IBAM."

            if (MODALIDADE="presencial ")  then
                texto = texto&" Na cidade do(e) "& RS("LUGAR") & "."
            end if

            Page.Canvas.DrawText texto, "x=120, y=350, size=12; width=600; alignment=left; spacing=1.5; ", Doc.Fonts("Verdana")
            Page.Canvas.DrawText DATA,  "x=120, y=220, size=12; width=600; alignment=left; ", Doc.Fonts("Verdana")
' ====================< FINAL DA MONTAGEM DO TEXTO DA FRENTE DO CERTIFICADO  >==============================


' ====================< INÍCIO DA PREPARAÇÃO DO VERSO DO CERTIFICADO  >=============================

            Set Page = Doc.Pages.Add(595.3, 841.9)
            Set Font = Doc.Fonts("Helvetica")

            Set Image2 = Doc.OpenImage( Server.MapPath( "./certificados/certificadoverso.jpg") )
            Set Param = Pdf.CreateParam

            Page.Rotate = 90
            Page.Canvas.SaveState
            Page.Canvas.SetCTM 0, 1, -1, 0, Page.Width, 0

            Param("x") = 0
            Param("y") = 0
            Param("ScaleX") = .94
            Param("ScaleY") = .94

            Page.Canvas.DrawImage Image2, Param

            Page.Canvas.DrawText FIC_VERSO, "x=120, y=590, size=12; width=600; alignment=left; spacing=1.5; html=true; ", Doc.Fonts("Verdana")

            pdf_nome_arquivo ="./certificados/Certificado_"&RS("COD_ALUNO")&"_"&RS("COD_CURSO")&"_"&RS("ID_TURMA")&".pdf"

            Filename = Doc.Save( Server.MapPath(pdf_nome_arquivo), True )

            con.execute ("update turma_aluno set certificado='C' where id_turma='" & RS("ID_TURMA") & "' and cod_aluno='" & RS("COD_ALUNO") & "'" )

            Qtde = Doc.Pages.Count
            ' Response.Write("Foram geradas " & Qtde & " páginas.<br>")
            ' Response.Write("Verso Texto: " & FIC_VERSO & "<br>")
            ' Response.End




' =====================================================================================================================================================
' pdf_verso  ="C:\inetpub\wwwroot\ensurnovo\adm\certificados\Certificado_"&RS("COD_ALUNO")&"_"&RS("COD_CURSO")&"_"&RS("ID_TURMA")&"B.pdf"
' pdf_arquivo=pdf_frente&"+"&pdf_verso
' Response.Write(pdf_arquivo)
' Response.End
' dim fs
' set fs=Server.CreateObject("Scripting.FileSystemObject")
' fs.CopyFile pdf_frente,"C:\inetpub\wwwroot\ensurnovo\adm\certificados\zzz.pdf"
' set fs=nothing

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
<% Response.Write(SIGA_PROJETO) %>
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
			<option value="23"<%if st=23 then response.write " SELECTED"%>>Aprovados</option>
			<option value="24"<%if st=24 then response.write " SELECTED"%>>Reprovados</option>
			<option value="25"<%if st=25 then response.write " SELECTED"%>>Evadidos</option>
			<option value="26"<%if st=26 then response.write " SELECTED"%>>Nunca acessaram</option>



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
'		response.write sql
		sql = "SELECT C.CERTIFICADO,C.ENTURMADO,A.COD_ALUNO,A.COD_ENTI,A.TIPOENTI,A.COD_UF_IBGE,A.COD_MUNI_IBGE,    "       & _
              "       T.COD_STATUS_TURMA,EMAIL_ENVIADO,STATUS,NOTA,TEL,TEL_DDD,NOME,CPF,APROVADO,DT_CADASTRO,       "       & _
              "       PAGO,FORMA_PGT,A.EMAIL,A.E_NOME,A.CARGO,C.ID_TURMA, "                                                 & _
              "       (SELECT SUM(VALOR) FROM PAGAMENTO WHERE COD_ALUNO=A.COD_ALUNO "                                       & _
              "                        AND ID_TURMA=C.ID_TURMA AND DT_PGT IS NOT NULL) AS VALOR "                           & _
              "  FROM TURMA_ALUNO C "                                                                                       & _
              "  JOIN ALUNO A ON C.COD_ALUNO=A.COD_ALUNO "                                                                  & _
              "  JOIN TURMAS T ON T.ID_TURMA=C.ID_TURMA "                                                                   & _
              " WHERE C.ID_TURMA="&cod&sqlwhere&" ORDER BY "&sqlord

		' response.write sql

		RS.Open sql

' response.write(sql)

		if RS.EOF then
			%><br /><p>Nenhum aluno cadastrado</p><%
		else
			COD_ALUNO           = RS("COD_ALUNO")
			COD_STATUS_TURMA    = RS("COD_STATUS_TURMA")
            COD_ENTI_ALUNO      = RS("COD_ENTI")
            TIPO_ENTI_ALUNO     = RS("TIPOENTI")
            COD_UF_IBGE_ALUNO   = RS("COD_UF_IBGE")
            COD_MUNI_IBGE_ALUNO = RS("COD_MUNI_IBGE")
            ENTURMADO_ALUNO     = RS("ENTURMADO")
			%>
			<br /><p><%=total_alunos%> aluno(s) listado(s)</p>
			<% if task="receita" then %>
				<br /><p>Receita da turma R$ <%=formatavalor(total_receita)%> </p>
			<% end if %>
			<% if request("formulario")="" then%>
				<table id="tabela" cellpadding="4">
				<tr><td class="header">
				<%if mostraSel then%><input type="checkbox" name="main" value="1" onClick="checkAll(this.checked);"><%end if%></td>

            <%  if (SIGA_PROJETO<>2)  then  %>
    				<td class="header"><a href="alunos.asp?ord=nm&cod=<%=cod%>&st=<%=st%>">nome</a></td>
    				<td class="header"><a href="alunos.asp?ord=cp&cod=<%=cod%>&st=<%=st%>">cpf</a></td>
    				<td class="header"><a href="alunos.asp?ord=cp&cod=<%=cod%>&st=<%=st%>">Telefone</a></td>
    				<td class="header"><a href="alunos.asp?ord=fp&cod=<%=cod%>&st=<%=st%>">forma pgt.</a></td>
    				<%if valor>0 then%><td class="header"><a href="alunos.asp?ord=pg&cod=<%=cod%>&st=<%=st%>">pago</a>
    				<%end if%><td class="header"><a href="alunos.asp?ord=ap&cod=<%=cod%>&st=<%=st%>">Status.</a></td>
    				<td class="header">Ent</td>
					<td class="header">Cer</td>
				    <td class="header"><a href="alunos.asp?ord=dc&cod=<%=cod%>&st=<%=st%>">dt. inscrição</a></td>
            <%  end if  %>

            <%  if (SIGA_PROJETO=2)  then    %>
    				<td class="header"><a href="alunos.asp?ord=nm&cod=<%=cod%>&st=<%=st%>">nome</a></td>
    				<td class="header"><a href="alunos.asp?ord=cp&cod=<%=cod%>&st=<%=st%>">cpf</a></td>
    				<td class="header"><a href="alunos.asp?ord=cp&cod=<%=cod%>&st=<%=st%>"> Tipo Instituição</a></td>
<!----				<td class="header"><a href="alunos.asp?ord=cp&cod=<%=cod%>&st=<%=st%>">Nome Instituição</a></td> ---->
    				<td class="header"><a href="alunos.asp?ord=fp&cod=<%=cod%>&st=<%=st%>">UF</a></td>
    				<td class="header"><a href="alunos.asp?ord=ap&cod=<%=cod%>&st=<%=st%>">Município </a></td>
    				<td class="header"><a href="alunos.asp?ord=ap&cod=<%=cod%>&st=<%=st%>">Qt&nbsp;</a></td>
    				<td class="header"><a href="alunos.asp?ord=ap&cod=<%=cod%>&st=<%=st%>">Bio&nbsp;</a></td>
    				<td class="header"><a href="alunos.asp?ord=ap&cod=<%=cod%>&st=<%=st%>">Ads&nbsp;</a></td>
    				<td class="header"><a href="alunos.asp?ord=ap&cod=<%=cod%>&st=<%=st%>"> Status</a></td>
    				<td class="header"> Ent </td>
				    <td class="header"><a href="alunos.asp?ord=dc&cod=<%=cod%>&st=<%=st%>">dt. inscrição</a></td>
            <%  end if    %>


				<% if task="receita" then %>
					<td class="header">Valor</td>
				<% else %>
					<td class="header"><a href="alunos.asp?ord=dc&cod=<%=cod%>&st=<%=st%>">Obs</a></td>
					<td class="header"><a href="alunos.asp?ord=dc&cod=<%=cod%>&st=<%=st%>">email</a></td>
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
						<td><a href="aluno.asp?ord=<%=ord%>&cod=<%=cod%>&st=<%=st%>&coda=<%=RS("COD_ALUNO")%>"><%=RS("NOME")&" "%></a></td>
						<td><%=FormataCPF(RS("CPF"))%>&nbsp;</td>

                        <%
                            COD_ENTI_ALUNO      = RS("COD_ENTI")
                            TIPO_ENTI_ALUNO     = RS("TIPOENTI")
                            COD_UF_IBGE_ALUNO   = RS("COD_UF_IBGE")
                            COD_MUNI_IBGE_ALUNO = RS("COD_MUNI_IBGE")
                            ENTURMADO_ALUNO     = RS("ENTURMADO")
                        %>



                        <%  if (SIGA_PROJETO<>2)  then    %>
            				<td>(<%=RS("TEL_DDD")%>)<%=formatatel(RS("TEL"))
                                %></td>
            				<td><%=aFormaPgt(RS("FORMA_PGT"))%></td>
            				<%if valor>0 then%><td><%=pago%></td>



            				<%end if%><td><%=RS("STATUS")%> </td>



            				<td><% =RS("ENTURMADO") %></td>
            				<td><% =RS("CERTIFICADO") %></td>
            				<td><%=formataData(RS("DT_CADASTRO"))%></td>
                        <% end if  %>

                        <%  if (SIGA_PROJETO=2)  then    %>
            				<td><%
                                    if isNull (COD_ENTI_ALUNO)  then
                                        COD_ENTI_ALUNO=0
                                    end if
                                	sql = "SELECT NOME, ID_TIPO_ENTIDADE FROM ENTIDADES WHERE COD_ENTI="&COD_ENTI_ALUNO
                                	RSSIM.Open sql
                                	if not RSSIM.eof then
                                        NOME_ENTI_ALUNO=RSSIM("NOME")
                                        TIPO_ENTI_ALUNO=RSSIM("ID_TIPO_ENTIDADE")
                                    else
                                		NOME_ENTI_ALUNO=""
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

                                 %></td>
<!----            				<td><%
                                    ' Response.Write(NOME_ENTI_ALUNO)
                                 %></td>
---->
            				<td><%
                                	sql = "SELECT SIGLA_UF FROM UF WHERE COD_UF_IBGE="&COD_UF_IBGE_ALUNO
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
                                	sql = "SELECT NOME_MUNI FROM MUNICIPIOS WHERE COD_UF_IBGE="&COD_UF_IBGE_ALUNO&" AND COD_MUNI_IBGE="&COD_MUNI_IBGE_ALUNO
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


            				<td><%
                                	sql = "SELECT ADESAO FROM BIOMA_CIDADE WHERE COD_UF_IBGE="&COD_UF_IBGE_ALUNO&" AND COD_MUNI_IBGE="&COD_MUNI_IBGE_ALUNO
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

            				<td>
                                <% Response.Write(ADESAO_MUNICIPIO)&" " %>
                            </td>

                            <%
                            sql_status = "SELECT RESULTADO FROM ALUNO_FREQUENCIA "                  & _
                                         " WHERE COD_ALUNO='" & RS("COD_ALUNO") & "'"               & _
                                         "   AND ID_TURMA='"  & cod & "'"
                            RS4.Open (sql_status)
                            %>
                            <td> <%
                            status_aluno = RS("STATUS")
' Response.Write("SQL: " &sql_status & " - ")
' Response.Write(" - " & RS("STATUS") & " - ")
                            if not RS4.EOF then
                                if RS4("RESULTADO") = "" then
                                    status_aluno = RS("STATUS")
                                else
                                    status_aluno = RS4("RESULTADO")
                                end if
                            end if
                            Response.Write(status_aluno)
                            %> </td>
                            <% RS4.Close %>

            				<td align="center"><% =ENTURMADO_ALUNO %></td>
            				<td><%=formataData(RS("DT_CADASTRO"))%></td>
                        <% end if  %>


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
						<%if (COD_STATUS_TURMA=6) OR (COD_STATUS_TURMA=7) then%>
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