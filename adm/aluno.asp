<%If session("adm")<>"ok" Then Response.Redirect "logout.asp"%>
<!-- #INCLUDE FILE="../library/parametros.asp" -->
<!-- #INCLUDE FILE="../library/conOpen.asp" -->
<!-- #INCLUDE FILE="../library/fErroMsg.asp" -->
<!-- #INCLUDE FILE="../library/fData.asp" -->
<!-- #INCLUDE FILE="../library/fFormataValor.asp" -->
<!-- #INCLUDE FILE="../library/vAprova.asp" -->
<!-- #INCLUDE FILE="../library/fCreateSel.asp" -->
<!-- #INCLUDE FILE="../library/fEmail.asp" -->

<%  SIGA_PROJETO=Session("siga_projeto")  %>
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
	<meta http-equiv="Pragma" content="no-cache" />
	<meta http-equiv="Expires" content="0" />
	<title>ENSUR Inscrições</title>
	<script src="scripts/jquery-1.11.3.min.js" type="text/javascript"></script>
	<script type="text/javascript" src="../js/validacao_pb.js"></script>
	<script type="text/javascript" src="../js/mascara.js"></script>
	<link href="content/css/main.css" rel="stylesheet">
	<link rel="stylesheet" type="text/css" href="content/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="content/css/font-awesome.min.css">
	<link rel="stylesheet" type="text/css" href="css/jquery-ui.css">
	<script src="content/js/bootstrap-modal.js"></script>
	<script src="App/aluno.js" ></script>
	<script >
	
	  $(document).ready(function() {
		
		recupere_meus_dados();
		ListaDeCursos();
		
		})
	

		function checkForm() {
			f = document.formAlunos;
			if (f.task.selectedIndex==0) {
				 waitingDialog.show('Selecionar uma ação');
				  setTimeout(function () { waitingDialog.hide(); }, 3000);
				return false;
			}else{
			switch (f.task.value) {
			case 'planilha':
				f.action = "gera_excel.asp";
				break;
			case 'planilhp':
				f.action = "gera_excel.asp?p=1";
				break;
			case 'aluno':
				f.action = "altera_aluno02.asp?coda=" + $("#cod_aluno").val();
				break;
			case 'alunopqga':
				f.action = "altera_aluno02.asp?coda=" + $("#cod_aluno").val();
				break;
			case 'vencimento':
				f.action = "aluno.asp";
				break;
			default:
				f.action = "alunos.asp";
			}
			return true
			}
		}
		
		function checkAcao(val) {
			
				
			
			if (val==='mail') {
				
					$("#myModal").modal();
				
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
	<body >
<style >
span{
	font-size:12px;
	font-family:Arial, Helvetica, sans-serif;
	} 
label{
	margin-left:20px;
	font-size:12px;
	font-family:Arial, Helvetica, sans-serif;
	font-weight:bold;
	min-width:130px;
	}
.panel-info .row{
	max-width:98%;
	}
</style>
<div id="ckmt"> 
      <!-- #INCLUDE FILE="include/topo.asp" -->
      
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
		
		RS.Open "SELECT COD_ENTI FROM ALUNO WHERE COD_ALUNO="&request("coda")
		if RS.EOF then
			erroMsg("Aluno não cadastrado no sistema. Faça um refresh no seu navegador e tente novamente.")
        else
            COD_ENTI = RS("COD_ENTI")
        end if
        RS.Close

		RS.Open "SELECT * FROM TURMA_ALUNO WHERE COD_ALUNO="&request("coda")&" AND ID_TURMA="&cod
		if RS.EOF then
			erroMsg("Aluno não cadastrado neste curso. Faça um refresh no seu navegador e tente novamente.")
		else
			CUSTO_ENTI 		= RS("CUSTO_ENTI")
			if CUSTO_ENTI then CUSTO_ENTI=1 else CUSTO_ENTI=0 end if
			APROVADO 		= RS("APROVADO")
			DT_CADASTRO 	= RS("DT_CADASTRO")
			PARCELAS	 	= RS("PARCELAS")
			PAGO		 	= RS("PAGO")
			STATUS			= RS("STATUS")
			ID_TURMA		= RS("ID_TURMA")
			COD_ALUNO		= RS("COD_ALUNO")


		end if
		RS.Close

		%>
      <div id="conteudo">
    <h1>Detalhe de aluno</h1>
    <input type="hidden" name="cod_aluno" id="cod_aluno" value="<%=Request.QueryString("coda")%>">
    <input type="hidden" name="ja_cadastrado" id="ja_cadastrado" value="">
    <input type="hidden" name="ja_na_turma" id="ja_na_turma" value="">
    <form name="formAlunos" action="alunos.asp" method="post" onSubmit="return checkForm();">
          <div class="panel widget uib_w_9 panel-info ">
        <div class="panel-heading">Dados da instituição</div>
        <p class="row">
              <%
		if COD_ENTI>0 then
'			xxx = "SELECT NOME,isNull(SIGLA_UF,'') AS SIGLA_UF,isNull(NOME_MUNI,'') AS NOME_MUNI FROM ENTIDADES E LEFT JOIN MUNICIPIOS M ON E.COD_MUNI_IBGE=M.COD_MUNI_IBGE AND E.COD_UF_IBGE=M.COD_UF_IBGE LEFT JOIN UF ON E.COD_UF_IBGE=UF.COD_UF_IBGE WHERE COD_ENTI="&COD_ENTI
' Response.Write(xxx)

			sql_enti = "SELECT * FROM VIEW_ALUNO_INSTITUICAO WHERE COD_ALUNO="&coda
'			sql_enti = "SELECT NOME,isNull(SIGLA_UF,'') AS SIGLA_UF,isNull(NOME_MUNI,'') AS NOME_MUNI FROM ENTIDADES E LEFT JOIN MUNICIPIOS M ON E.COD_MUNI_IBGE=M.COD_MUNI_IBGE AND E.COD_UF_IBGE=M.COD_UF_IBGE LEFT JOIN UF ON E.COD_UF_IBGE=UF.COD_UF_IBGE WHERE COD_ENTI="&COD_ENTI

    		if (COD_ENTI <> 21)	then
                RS.Open sql_enti
' Response.Write(COD_ENTI)
' Response.Write(sql_enti)
' Response.Write(RS("NOME"))
    			if RS.EOF then
    				%>
            <p class="row">
              <label for="NOME_ENTI">Instituição não encontrada na base de dados!</label>
            </p>
        <%
    			else
    				%>
        <p class="row">
              <label for="NOME_ENTI">Nome:</label>
              <%=RS("NOME")%>&nbsp;(
              <%if Len(RS("SIGLA_UF"))>0 and Len(RS("NOME_MUNI"))>0 then%>
              <%=RS("NOME_MUNI")%>/<%=RS("SIGLA_UF")%>
              <%else%>
              Estrangeiro
              <%end if%>
              )</p>
        <%
    			end if
			    RS.Close
            else
                RS.Open sql_enti
   				%>
        <p class="row">
              <label for="NOME_ENTI">Tipo:</label>
              Pessoa Física</p>
        <%
  				%>
        <p class="row">
              <label for="NOME_ENTI">Nome:</label>
              <%=RS("NOME")%>&nbsp;(
              <%if Len(RS("SIGLA_UF"))>0 and Len(RS("NOME_MUNI"))>0 then%>
              <%=RS("NOME_MUNI")%>/<%=RS("SIGLA_UF")%>
              <%else%>
              Estrangeiro
              <%end if%>
              )</p>
        <%
			    RS.Close
            end if
		else
            if isNull(tipoEnti) then tipoEnti=0
			IF tipoEnti=0 THEN
				%>
        <p class="row">
              <label for="NOME_ENTI">&nbsp;</label>
              Cadastro de autônomo</p>
        <%
			ELSE
				SQL = "SELECT DESCRICAO FROM TIPO_ENTIDADE WHERE ID_TIPO_ENTIDADE="&tipoEnti
				RS.Open SQL
				if not RS.eof then
					%>
        <p class="row">
              <label for="NOME_ENTI">Instituição:</label>
              <% =RS("DESCRICAO") %>
            </p>
        <%
				else
					%>
        <p class="row">
              <label for="NOME_ENTI">Instituição:</label>
              Não cadastrado</p>
        <%
				end if
				RS.Close
                if (tipoEnti<>21) then
    				SQL = "SELECT SIGLA_UF FROM UF WHERE COD_UF_IBGE="&COD_UF_ENTI
    				RS.Open SQL
    				if not RS.eof then
    					%>
        <p class="row">
              <label for="NOME_ENTI">UF:</label>
              <% =RS("SIGLA_UF") %>
            </p>
        <%
    				else
    					%>
        <p class="row">
              <label for="NOME_ENTI">UF:</label>
              Não cadastrado</p>
        <%
    				end if
    				RS.Close
    				SQL = "SELECT NOME_MUNI FROM MUNICIPIOS WHERE COD_UF_IBGE="&COD_UF_ENTI&" AND COD_MUNI_IBGE="&COD_MUNI_ENTI
    				RS.Open SQL
    				if not RS.eof then
    					%>
        <p class="row">
              <label for="NOME_ENTI">Municipio:</label>
              <% =RS("NOME_MUNI") %>
            </p>
        <%
    				else
    					%>
        <p class="row">
              <label for="NOME_ENTI">Municipio:</label>
              Não cadastrado</p>
        <%
    				end if
                end if
			END IF
		end if
		%>
        <%
		if VALOR>0 then
			%>
        <p class="row">
              <label for="NOME_ENTI">&nbsp;</label>
              <%if CUSTO_ENTI=0 then%>
              Pagamento por conta do participante
              <%else%>
              Pagamento por conta da instituição empregadora
              <%end if%>
            </p>
        <%
		end if
		%>
        </p>
      </div>
          <div class="panel widget uib_w_9 panel-info ">
        <div class="panel-heading">Dados Pessoais</div>
        <p class="row">
              <label> None: </label>
              <span ID="NOME"></span> </p>
        <p class="row">
              <label> CPF:</label>
              <span ID="CPF"></span> &nbsp;</p>
        <p class="row">
              <label> Senha: </label>
              <span ID="SENHA"></span> </p>
        <p class="row">
              <label> Nascimento: </label>
              <span ID="NASCIMENTO"></span> </p>
        <p class="row">
              <label> Sexo: </label>
              <span ID="SEXO"></span> </p>
        <p class="row">
              <label> Raça ou Cor: </label>
              <span ID="RACA"></span> </p>
               <p class="row">
              <label> Deficiência: </label>
              <span ID="DEFICIENCIA"></span> </p>
        <p class="row">
              <label> Nacionalidade: </label>
              <span ID="NACIONALIDADE"></span> &nbsp;</p>
        <p class="row">
              <label> E-MAIL: </label>
              <span ID="EMAIL"></span> </p>
        <p class="row">
              <label> Endereço: </label>
              <span ID="ENDERECO"></span> </p>
        <p class="row">
              <label> Cep: </label>
              <span ID="CEP">CEP</span> </p>
        <p class="row">
              <label> UF: </label>
              <span id="UF_PESSOAL"></span></p>
        <p class="row">
              <label> Município: </label>
              <span id="MUNICIPIO"></span> </p>
        <p class="row">
              <label> Telefone </label>
              <span ID="TEL">Telefone</span> </p>
        <p class="row">
              <label> Fax </label>
              <span ID="FAX"></span></p>
        </br>
        </br>
      </div>
          <div class="panel widget uib_w_9 panel-info ">
        <div class="panel-heading">Dados Profissionais</div>
        <p class="row">
              <label> Setor </label>
              <span id="SETOR"></span> &nbsp;</p>
        <p class="row">
              <label> Cargo: </label>
              <span id="CARGO"></span> &nbsp;</p>
        <p class="row">
              <label> E-mail: </label>
              <span id="EMAIL_ENTI"></span> </p>
        <p class="row">
              <label> Endereço: </label>
              <span id="ENDERECO_ENTI"></span> </p>
        <p class="row">
              <label> CEP: </label>
              <span id="CEP_ENTI"></span> &nbsp;</p>
        <p class="row">
              <label> Telefone: </label>
              <span id="TEL_ENTI"></span> </p>
              
                <p class="row">
              <label> Fax: </label>
              <span id="FAX_ENTI"></span> </p>
              
               <p class="row">
              <label> UF: </label>
              <span id="UF_ENTI"></span> </p>

               <p class="row">
              <label> MUNICIPIO: </label>
              <span id="MUNI_ENTI"></span> </p>
              
        </br>
        </br>
      </div>
          <div class="panel widget uib_w_9 panel-info ">
        <div class="panel-heading">Formação Acadêmica / Titulação</div>
        <p class="row">
              <label> Escolaridade </label>
              <span id="ESCOLARIDADE"></span> &nbsp;</p>
        <p class="row">
              <label> Nome do curso: </label>
              <span ID="FORMACAO"></span> &nbsp;</p>
        <p class="row">
              <label> Pós-graduação: </label>
              <span id="POS"></span> </p>
        <p class="row">
              <label> Área: </label>
              <span ID="AREA"></span> </p>
        <p class="row">
              <label> Instituição de Ensino: </label>
              <span ID="NOME_INSTITUICAO_ENSINO"></span> </p>
        <p class="row">
              <label> UF: </label>
              <span ID="UF_INSTITUICAO_ENSINO"></span> </p>
        <p class="row">
              <label> Município: </label>
              <span ID="MUNI_INSTITUICAO_ENSINO"></span> </p>
        <p class="row">
              <label> CNPJ: </label>
              <span ID="CNPJ_INSTITUICAO_ENSINO"></span> </p>
        <p class="row">
              <label> Previsão Conclusão: </label>
              <span ID="PREVISAO_INSTITUICAO_ENSINO"></span> </p>
      </div>
          <div class="panel widget uib_w_9 panel-info ">
        <div class="panel-heading">Participou das turmas</div>
        <div id="Grid" class="tabela"> </div>
      </div>
          <div class="panel widget uib_w_9 panel-info ">
        <div class="panel-heading">Cadastro no Curso</div>
        <p class="row">
              <label ID="">Data cadastro</label>
              <%=formataData(DT_CADASTRO)%>&nbsp;</p>
        <p class="row">
              <label ID="APROVADO">Inscrição</label>
              <%=STATUS%><br />
              <br />
            </p>
      </div>
          <%if VALOR>0 then%>
          <%

			RS.Open "SELECT isNull(SUM(VALOR),0) FROM PAGAMENTO WHERE ID_TURMA="&cod&" AND COD_ALUNO=" &coda

			total_pago = RS(0)
			RS.Close
			%>
          <div class="panel widget uib_w_9 panel-info ">
        <div class="panel-heading">Dados de Pagamento</div>
        <p class="row">
              <label>Valor a ser pago</label>
              R$ <%=formataValor(VALOR)%></p>
        <p class="row">
              <label>Total pago</label>
              R$ <%=formataValor(total_pago)%>
              <%if PAGO then%>
              [ pagamento regularizado ]
              <%else%>
              [ pagamento pendente ]
              <%end if%>
            </p>
        <%
				if PARCELAS=0 then
					%>
        <p class="row">
              <label>&nbsp;</label>
              Número de parcelas não definida.&nbsp;</p>
        <%
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
							%>
        <p class="row">
              <label>Parcela <%=i%></label>
              <%=txt%>&nbsp;</p>
        <%
						end if
						RS.Close
					next
				end if
				%>
        <p class="row">
              <label>Código do Projeto&nbsp;</label>
              <% =COD_PROJETO %>
            </p>
      </div>
          <%if CUSTO_ENTI=1 then%>
          <div class="panel widget uib_w_9 panel-info ">
        <div class="panel-heading">arquivos de empenho</div>
        <p class="row">
            <ul>
              <%
					cnt = 0
					nome_base = cod&"_"&coda&"_"
					Set fso = CreateObject("Scripting.FileSystemObject")
					Set folder = fso.getfolder(Server.MapPath("../empenhos"))
					For Each File in Folder.Files
						If mid(File.name,1,Len(nome_base))=nome_base Then
							aNome = Split(Mid(File.name,Len(nome_base)+1,InStr(File.name,".")-1-Len(nome_base)),"_")
							%>
              <li><a href="../empenhos/<%=File.name%>" target="_new">Arquivo <%=aNome(1)%> da parcela <%=aNome(0)%></a></li>
              <%
							cnt=cnt+1
						End If
					Next
					if cnt=0 then
						%>
            </ul>
        <p class="row">Nenhum arquivo de empenho enviado até o momento</p>
        <%
					else
						%>
        </ul>
        </p>
        <%
					end if
					%>
      </div>
          <%end if%>
          <%end if%>
          <p></p>
          <%if Session("key_alu")="ok" or Session("key_sta")="ok" or Session("key_ema")="ok" or Session("key_plc")="ok" or Session("key_plp")="ok" then%>
          <p><br />
      </p>
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
     
          <%msql = "COD_CURSO="&cod%>
          <input type="hidden" name="msql" value="<%=msql%>">
          <p class="row">
        <select name="task" class="dropdown form-control-static " onChange="checkAcao(this.value);" >
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
        <span>
            <input type="submit" name="submit" class="btn btn-default" value="Executar" >
            </span><span style="float:right"><a href="alunos.asp?ord=<%=ord%>&cod=<%=cod%>&st=<%=st%>" class="btn btn-success" ><i class="fa fa-backward"></i> voltar</a></span> </p>
          <fieldset id="vencDados" style="display:none">
        <legend>alterar vencimento de boleto</legend>
        <p class="row">
              <label for="NUM_PARCELA">Núm. da parcela</label>
              <select name="NUM_PARCELA">
            <%
						for i = 1 to PARCELAS
							%>
            <option value="<%=i%>">Parcela <%=i%></option>
            <%
						next
						%>
          </select>
            </p>
        <p class="row">
              <label for="DT_VENC">Vencimento</label>
              <input type="text" name="DT_VENC" id="DT_VENC" maxlength="10" size="11" onKeyPress="return ValidateKeyPressed('DATE', this, event);" onChange="valida_campo(4,this);">
              (deixar em branco para voltar ao padrão)</p>
      </fieldset>
          <%end if%>
        </form>
    <p class="row"> </p>
    <br />
    <br />
    <br />
    <br />
  </div>
    </div>
<fieldset id="cursoDados" style="display:none">
      <legend>mudar o aluno de curso</legend>
      <p class="row">
    <label for="COD_CURSO">Curso</label>
    <%=createSel("COD_CURSO","SELECT COD_CURSO,TITULO FROM CURSO WHERE COD_CURSO<>"&cod&" ORDER BY TITULO",0,0,"")%></p>
    </fieldset>
<div id="myModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
      <div class="modal-dialog">
    <div class="modal-content">
          <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span> <span class="sr-only">Close</span></button>
        <h2>Enviar E-mail</h2>
        <span class="row col-lg-12" id="totAlunos"></span> <span class="row col-lg-12 collapsed alert-success" id="totAlunosTranferidos"></span> </div>
          <div id="mailDados" class="modal-body ">
        <div class="col-sm-12 col-md-12">
              <div class="single-blog single-column">
            <p class="row">
                  <label for="ASSUNTO">Assuntos</label>
                  <select name="ASSUNTO" class="dropdown form-control-static " onChange="Acertatexto(this.value);">
                <option></option>
                <% sql = "SELECT ID_MENSAGEM,[SUBJECT],MENSAGEM FROM MENSAGENS"
                        RS.open sql
                        while not RS.eof
                            response.write "<option value='"&RS("ID_MENSAGEM")&"'>"&RS("SUBJECT")&"</OPTION>"
                            RS.movenext
                        wend
                        RS.Close
                        %>
              </select>
                </p>
          </div>
            </div>
     
        <div class="col-sm-12 col-md-12">
              <div class="single-blog single-column">
            <p class="row">
                  <label for="MSG">Mensagem</label>
                  <textarea cols=60 rows=6 name="MSG" id="MSG"></textarea>
                </p>
          </div>
            </div>
        <a href="#" id="EnviaEmail" class="btn btn-success"><i class="glyphicon glyphicon-send"></i> Evniar</a> </div>
          <div class=" modal-footer panel-footer"> pressione ESC para cancelar </div>
        </div>
  </div>
    </div>
</body>


<script type="text/javascript">

$("#EnviaEmail").click(function(){
	
	
	var para = $("#EMAIL").html();
	var mensagem = $("#MSG").val();
	var titulo = $("#ASSUNTO").val();
	
   email(para,"pqga-ead@ibam.org.br",mensagem,titulo);
})
</script>
</html>
