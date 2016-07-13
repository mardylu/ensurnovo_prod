<!-- #INCLUDE FILE="../library/parametros.asp" -->
<!-- #INCLUDE FILE="../library/conOpen.asp" -->

<%


Response.Expires = 0
Response.CacheControl = "no-cache"
Response.AddHeader "Pragma", "no-cache"

ID_TURMA = request("id_turma")

sql = "select t.COD_STATUS_TURMA, * from turmas  t "
sql = sql & "   inner join [TURMA_STATUS] ts on ts.COD_STATUS_TURMA = t.COD_STATUS_TURMA"
sql = sql & "	 where id_turma='"&ID_TURMA&"'"
RS.open sql
'Response.Write(sql)
if RS.eof then
else
	NOME_FANTASIA = RS("NOME_FANTASIA")
	STATUS_TURMA  = RS("COD_STATUS_TURMA")
end if
 ' Response.Write(STATUS_TURMA)

if  STATUS_TURMA <> 2  then
  ' Response.Write("xxx")
   Response.Redirect "insc_encerrada.asp?id_turma=" & id_turma
end if

%>

<!DOCTYPE html>
<html>
    <head>
    <link rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="css/pg_cadastro_main.less.css" class="main-less">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
    <!----	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">  ---->
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
    <meta http-equiv="Pragma" content="no-cache" />
    <meta http-equiv="Expires" content="0" />
    <script src="js/app.js" charset="UTF-8"></script>
    <script type="application/javascript" src="lib/jquery.min.js"></script>
    <script type="application/javascript" src="marginal/marginal-position.min.js"></script>
    <script type="application/javascript" src="js/pg_fullinfo_user_scripts.js"></script>
    <script type="application/javascript" src="bootstrap/js/bootstrap.min.js"></script>
    <script type="application/javascript" src="js/bootstrap-modal.js"></script>


    <link rel="stylesheet" type="text/css" href="../adm/content/css/font-awesome.min.css">
    <script>
        $(document).ready(function() {
            $(document).ready(function() {
				
				$("#previsao").mask("99/9999");
				$("#e_cnpj").mask("99.999.999/9999-99");
				$("#CNPJ_instituicao_Ensino").mask("99.999.999/9999-99");				
				
				
                $('#cpf').bind("cut copy paste", function(e) {
                    var msg ='Não é possível Copiar/Colar. Digite a informação.';
					 waitingDialog.show(msg);
					  setTimeout(function () { waitingDialog.hide(); }, 3000);
                    e.preventDefault();
                });

                $('#cpf_cadastrado').bind("cut copy paste", function(e) {
                    var msg = 'Não é possível Copiar/Colar. Digite a informação.';
					  waitingDialog.show(msg);
					  setTimeout(function () { waitingDialog.hide(); }, 3000);
                    e.preventDefault();
                });

                $('#dt_nascimento').bind("cut copy paste", function(e) {
                    var msg = 'Não é possível Copiar/Colar. Digite a informação.';
					 waitingDialog.show(msg);
					  setTimeout(function () { waitingDialog.hide(); }, 3000);
                    e.preventDefault();
                });

                $('#cep').bind("cut copy paste", function(e) {
                    var msg = 'Não é possível Copiar/Colar. Digite a informação.';
					 waitingDialog.show(msg);
					  setTimeout(function () { waitingDialog.hide(); }, 3000);
                    e.preventDefault();
                });

                $('#e_cnpj').bind("cut copy paste", function(e) {
                    var msg = 'Não é possível Copiar/Colar. Digite a informação.';
					 waitingDialog.show(msg);
					  setTimeout(function () { waitingDialog.hide(); }, 3000);
                    e.preventDefault();
                });

                $('#telefone_pessoal').bind("cut copy paste", function(e) {
                    var msg = 'Não é possível Copiar/Colar. Digite a informação.';
					 waitingDialog.show(msg);
					 setTimeout(function () { waitingDialog.hide(); }, 3000);
                    e.preventDefault();
                });

                $('#e_cep').bind("cut copy paste", function(e) {
                    var msg = 'Não é possível Copiar/Colar. Digite a informação.';
                    e.preventDefault();
                });

                $('#telefone_entidade').bind("cut copy paste", function(e) {
                    var msg='Não é possível Copiar/Colar. Digite a informação.';
					 waitingDialog.show(msg);
					  setTimeout(function () { waitingDialog.hide(); }, 3000);
                    e.preventDefault();
                });
				
				$('#limparDadosDaPRofissionais').click(function(e) {
                   
                    e.preventDefault();
                });
				$('#EstudaSim').change(function(e){
					
					if($('#EstudaSim').is(':checked')){
						$("#formulario_instituicao").show();						
					}else{
						$("#formulario_instituicao").hide();
						$("#cod_uf_Intituicao").val(0);						
						$("#Nome_instituicao_Ensino").val("");
						$("#cod_muni_Instituicao").val(0);
						$("#CNPJ_instituicao_Ensino").val("");
						$("#previsao").val("");
					}

					e.preventDefault();
				});
			
		
            });
        });
    </script>
    </head>

    <body onload="inicio()">
    <input type="hidden" name="ID_USUARIO_LOG" id="ID_USUARIO_LOG" value="<% =Session("id") %>">
<input type="hidden" name="id_turma" id="id_turma" value="<% =ID_TURMA %>">
<input type="hidden" name="cod_aluno" id="cod_aluno" value="">
<input type="hidden" name="ja_cadastrado" id="ja_cadastrado" value="">
<input type="hidden" name="ja_na_turma" id="ja_na_turma" value="">
<div class="upage" id="mainpage">
      <div id="topo">
    <div id="logo"></div>
  </div>
      <div class="upage-outer">
    <div class="upage-content ac0 content-area vertical-col" id="page_67_73"> <br>
          <div class="panel-heading">
        <h4 class="panel-title-page">
              <p>
            <center>
                  <strong><font face="arial" size="6" color="#668130">PRÉ-INSCRIÇÃO</font></strong>
                </center>
          </p>
            </h4>
        <h2 class="panel-title">
              <p>
            <center>
                  <font face="arial" size="6" color="#668130">Curso:
              <% =NOME_FANTASIA %>
              </font>
                </center>
          </p>
            </h2>
      </div>
          <div id="painel_2" class="panel-collapse collapse in">
        <div class="panel-body">
              <div class="col uib_col_2 single-col" data-uib="layout/col" data-ver="0">
            <div class="widget-container content-area vertical-col">
                  <div class="panel widget uib_w_9 panel-success" data-uib="twitter%20bootstrap/collapsible" data-ver="1" id="painel_dadospessoais">
                <div class="panel-heading">
                      <h4 class="panel-title"> </h4>
                    </div>
                <div id="bs-accordion-group-2" class="panel-collapse collapse in">
                      <div class="panel-body">
                    <div class="col uib_col_3 single-col" data-uib="layout/col" data-ver="0">
                          <div class="widget-container content-area vertical-col"> Caso tenha participado anteriormente de curso do IBAM, você já tem SENHA no nosso banco de dados.
                        Para fazer sua pré-inscrição, preencha os campos a seguir com CPF e SENHA. Aproveite para verificar se os seus dados estão
                        atualizados.
                        <table border="0">
                              <tr>
                            <td width="15%"><div class="table-thing widget uib_w_61 d-margins" data-uib="twitter%20bootstrap/input" data-ver="1" id="texto_cpfnunca">
                                <label class="narrow-control" for="cpf">CPF </label>
                              </div></td>
                            <td width="25%"><input class="wide-control form-control default" type="tel" id="cpf" onkeyup="formata_cpf_digitado('cpf',this.value,'senha',event)"></td>
                            <td width="2%"></td>
                            <td width="15%"><div class="table-thing widget uib_w_11 d-margins" data-uib="twitter%20bootstrap/input" data-ver="1" id="texto_senhanunca">
                                <label class="narrow-control left" for="senha">Senha </label>
                              </div></td>
                            <td width="25%"><input class="wide-control form-control default input-sm" type="password" id="senha"></td>
                            <td width="5%"><center>
                                <button class="btn widget uib_w_57 d-margins btn-success" onclick="recupere_meus_dados(<% =ID_TURMA %>);">Ok</button>
                              </center></td>
                          </tr>
                              <tr>
                            <td colspan="5"> Não se lembra da senha, clique aqui:
                                  <button class="btn widget uib_w_57 d-margins btn-success" data-uib="twitter%20bootstrap/button" data-ver="1" id="btn_confirma_inscricao" onclick="esqueci_senha();"><i class="glyphicon glyphicon-pencil button-icon-left" data-position="left"></i>esqueci minha senha</button>
                                  <span class="uib_shim"></span>
                                  <center>
                                Caso NÃO tenha participado anteriormente de nenhum curso, preencha os campos a seguir para registrar seus dados.
                              </center></td>
                          </tr>
                            </table>
                      </div>
                        </div>
                  </div>
                    </div>
              </div>
                  <!------            <center>Caso NÃO tenha participado anteriormente de nenhum curso, preencha os campos abaixo para registrar seus dados:</center>    --------> 
                  <br>
                  <div id="legenda">
                <label id="nome_legenda">
                <h6>* Campos obrigatórios</h6>
                </label>
              </div>
                  <div class="panel widget uib_w_9 panel-success" data-uib="twitter%20bootstrap/collapsible" data-ver="1" id="painel_dadospessoais">
                <div class="panel-heading">
                      <h4 class="panel-title"> DADOS PESSOAIS </h4>
                    </div>
                <div id="bs-accordion-group-2" class="panel-collapse collapse in">
                      <div class="panel-body">
                    <div class="col uib_col_3 single-col" data-uib="layout/col" data-ver="0">
                          <div class="widget-container content-area vertical-col">
                        <table border="0">
                              
                              <!----
				                    <tr>
		                              	<td width="15%">
											<div class="table-thing widget uib_w_11 d-margins" data-uib="twitter%20bootstrap/input" data-ver="1" id="texto_senhanunca">
												<label class="narrow-control left" for="senha">Crie uma senha* </label>
											</div>
				                        </td>
				                        <td width="25%">
				                        	<input class="wide-control form-control default input-sm" type="password" id="password">
				                        </td>
				                       <td width="2%">   </td>
		                              	<td width="15%">
											<div class="table-thing widget uib_w_11 d-margins" data-uib="twitter%20bootstrap/input" data-ver="1" id="texto_senhanunca">
												<label class="narrow-control left" for="senha">Confirme sua senha* </label>
											</div>
				                        </td>
				                        <td width="25%">
				                        	<input class="wide-control form-control default input-sm" type="password" id="confirme_password" onblur="dados_iguais('password','confirme_password','nome','Senha');">
				                        </td>
	                              	</tr>
---->
                              
                              <tr>
                            <td width="15%"><div class="table-thing widget uib_w_10 d-margins" data-uib="twitter%20bootstrap/input" data-ver="1" id="texto_nomenunca">
                                <label class="narrow-control left" for="nome">Nome Completo*</label>
                              </div></td>
                            <td colspan="4" width="65%"><input class="wide-control form-control default input-sm" type="text" id="nome"></td>
                          </tr>
                              <tr>
                            <td width="15%"><div class="table-thing widget uib_w_10 d-margins" data-uib="twitter%20bootstrap/input" data-ver="1" id="texto_nomesocial">
                                <label class="narrow-control left" for="nome">Nome social</label>
                              </div></td>
                            <td colspan="3" width="35%"><input class="wide-control form-control default input-sm" type="text" id="nome_social"></td>
                            <td width="30%"><h6>&nbsp;Caso atenda por um nome diferente do registro</h6></td>
                          </tr>
                              <tr>
                            <td width="15%"><div class="table-thing widget uib_w_61 d-margins" data-uib="twitter%20bootstrap/input" data-ver="1" id="texto_cpfnunca">
                                <label class="narrow-control" for="cpf">CPF* </label>
                              </div></td>
                            <td width="25%"><input class="wide-control form-control default" type="tel" id="cpf_cadastrado" onblur="procura_cpf()" onkeyup="formata_cpf_digitado('cpf_cadastrado',this.value,'dt_nascimento',event)"></td>
                          </tr>
                              <tr>
                            <td width="15%"><div class="table-thing widget uib_w_15 d-margins" data-uib="twitter%20bootstrap/input" data-ver="1" id="texto_nascimentonunca">
                                <label class="narrow-control left" for="nascimento"> Data de Nascimento*</label>
                              </div></td>
                            <td width="25%"><input class="wide-control form-control default input-sm" type="text" id="dt_nascimento" onkeyup="formata_data('dt_nascimento',this.value,'cod_raca',event)"></td>
                            <td width="2%"></td>
                            <td width="15%"><div class="table-thing widget uib_w_19 d-margins" data-uib="twitter%20bootstrap/select" data-ver="1">
                                <label class="narrow-control label-top-left">Raça/Cor ou Etnia</label>
                              </div></td>
                            <td width="25%" colspan="2"><select class="wide-control form-control default input-sm" id="cod_raca">
                              </select></td>
                          </tr>
                              <tr>
                            <td width="15%"><div class="table-thing widget uib_w_20 d-margins" data-uib="twitter%20bootstrap/select" data-ver="1" id="texto_sexo">
                                <label class="narrow-control label-top-left">Sexo</label>
                              </div></td>
                            <td width="25%"><select class="wide-control form-control default input-sm" id="sexo">
                                <option></option>
                                <option value="0">Feminino</option>
                                <option value="1">Masculino</option>
                              </select></td>
                            <td width="2%"></td>
                            <td width="15%"><div class="table-thing widget uib_w_24 d-margins" data-uib="twitter%20bootstrap/input" data-ver="1" id="texto_telefonenunca">
                                <label class="narrow-control label-top-left" for="telefone">DDD/Telefone*</label>
                              </div></td>
                            <td width="25%" colspan="2"><input class="wide-control form-control default" type="tel" id="telefone_pessoal" onkeyup="formata_telefone('telefone_pessoal',this.value,event);" onblur="corrige_traco('telefone_pessoal',this.value,event);"></td>
                          </tr>
                              <tr>
                            <td width="15%"><div class="table-thing widget uib_w_21 d-margins" data-uib="twitter%20bootstrap/input"  data-ver="1" id="texto_emailnunca">
                                <label class="narrow-control label-top-left" for="email">Email pessoal*</label>
                              </div></td>
                            <td width="25%"><input class="wide-control form-control default input-sm" type="email" id="email" onBlur="ValidaEmail(this.value);" ></td>
                            <td width="2%"></td>
                            <td width="15%"><div class="table-thing widget uib_w_22 d-margins" data-uib="twitter%20bootstrap/input" data-ver="1" id="texto_confirmenunca">
                                <label class="narrow-control label-top-left" for="confirme">Confirme e-mail*</label>
                              </div></td>
                            <td width="25%" colspan="2"><input class="wide-control form-control default input-sm" type="email" id="confirme_email" onblur="dados_iguais('email','confirme_email','endereco','e-mail');"></td>
                          </tr>
                              <tr>
                            <td width="15%"><div class="table-thing widget uib_w_23 d-margins" data-uib="twitter%20bootstrap/input" data-ver="1" id="texto_endereconunca">
                                <label class="narrow-control label-top-left" for="endereco">Endereço*</label>
                              </div></td>
                            <td width="65%" colspan="4"><input class="wide-control form-control default input-sm" type="text" id="endereco"></td>
                          </tr>
                              <tr>
                            <td width="15%"><div class="table-thing widget uib_w_20 d-margins" data-uib="twitter%20bootstrap/select" data-ver="1" id="texto_pais">
                                <label class="narrow-control label-top-left">País</label>
                              </div></td>
                            <td width="25%"><select class="wide-control form-control default input-sm" id="cod_pais" onchange="popula_uf(this.value);">
                              </select></td>
                            <td width="2%"></td>
                            <td width="15%"><div class="table-thing widget uib_w_20 d-margins" data-uib="twitter%20bootstrap/select" data-ver="1" id="texto_estado">
                                <label class="narrow-control label-top-left">Estado*</label>
                              </div></td>
                            <td width="25%" colspan="2"><select class="wide-control form-control default input-sm" id="cod_uf_ibge" onchange="popula_municipio(this.value,document.getElementById('cod_muni_ibge').value);">
                              </select></td>
                          </tr>
                              <tr>
                            <td width="15%"><div class="table-thing widget uib_w_20 d-margins" data-uib="twitter%20bootstrap/select" data-ver="1" id="texto_municipio">
                                <label class="narrow-control label-top-left">Municipio*</label>
                              </div></td>
                            <td width="25%"><select class="wide-control form-control default input-sm" id="cod_muni_ibge">
                              </select></td>
                            <td width="2%"></td>
                            <td width="15%"><div class="table-thing widget uib_w_20 d-margins" data-uib="twitter%20bootstrap/select" data-ver="1" id="texto_cep">
                                <label class="narrow-control label-top-left">CEP*</label>
                              </div></td>
                            <td width="25%" colspan="2"><input class="wide-control form-control default" type="tel" id="cep" onkeyup="formata_cep('cep',this.value,event);"></td>
                          </tr>
                            </table>
                      </div>
                        </div>
                  </div>
                    </div>
              </div>
                  <div class="panel widget uib_w_26 panel-success" data-uib="twitter%20bootstrap/collapsible" data-ver="1">
                <div class="panel-heading">
                      <h4 class="panel-title"> FORMAÇÃO ACADÊMICA </h4>
                    </div>
                <div id="bs-accordion-group-3" class="panel-collapse collapse in">
                      <div class="panel-body">
                    <div class="col uib_col_4 single-col" data-uib="layout/col" data-ver="0">
                          <div class="widget-container content-area vertical-col">
                        <table border=0>
                              <tr>
                            <td width="15%"><div class="table-thing widget uib_w_27 d-margins" data-uib="twitter%20bootstrap/select" data-ver="1">
                                <label class="narrow-control label-top-left">Escolaridade*</label>
                              </div></td>
                            <td width="25%"><select class="wide-control form-control default input-sm" id="cod_escolaridade" onclick="Mudarestadonomecurso(this.value);">
                              </select></td>
                            <td width="2%"></td>
                            <td width="15%"><div id="nomecurso1" style="display: none;">
                                <div class="table-thing widget uib_w_62 d-margins" data-uib="twitter%20bootstrap/input" data-ver="1">
                                  <label class="narrow-control label-top-left">Nome do Curso</label>
                                </div>
                              </div></td>
                            <td width="25%"><div id="nomecurso2" style="display: none;">
                                <input class="wide-control form-control default" type="text" id="formacao">
                              </div></td>
                              </tr>
                          <tr>
                            <td width="15%"><div class="table-thing widget uib_w_28 d-margins" data-uib="twitter%20bootstrap/select" data-ver="1">
                                <label class="narrow-control label-top-left" id="cod_pos_label"  >Pós-graduação</label>
                              </div></td>
                            <td width="25%"><select class="wide-control form-control default input-sm" id="cod_pos"  onchange="Mudarestadopos(this.value);">
                              </select></td>
                            <td width="2%"></td>
                            <td width="15%"><div id="especifica_pos1" style="display: none;">
                                <div class="table-thing widget uib_w_63 d-margins" data-uib="twitter%20bootstrap/input" data-ver="1">
                                  <label class="narrow-control label-top-left" for="especificarpos">Área (especificar)</label>
                                </div>
                              </div></td>
                            <td width="25%"><div id="especifica_pos2" style="display: none;">
                                <input class="wide-control form-control default input-sm" type="text" id="pos">
                              </div></td>
                          </tr>
                                
                              
                              <tr id="EstudaAtualmente"  style="display: none;" >
                            <td colspan="3" ><label class="narrow-control label-top-left">Estuda atualmente? *</label></td>
                           
                            <td colspan="2"><input type="checkbox" id="EstudaSim" /></td>

                          </tr>
                         <tr>
                              
                            <td colspan="5" id="formulario_instituicao"><div class="col-md-12 col-sm-12">
                               <div class="panel widget uib_w_26 panel-success" data-uib="twitter%20bootstrap/collapsible" data-ver="1">
                             <div class="panel-heading">
                              <h4 class="panel-title"> INSTITUIÇÃO DE ENSINO </h4>
                            </div>
                             <div id="bs-accordion-group-3" class="panel-collapse collapse in">
                      <div class="panel-body">
                                <div class="row">
                                  <div class="col-md-12 col-sm-12">
                                    <div class="row">
                                      <div class="col-sm-12 col-md-12">
                                        <div class="single-blog ">
                                          <label class="narrow-control label-top-left" for="Nome_instituicao_Ensino">Instituição de Ensino*</label>
                                          <input type="text" id="Nome_instituicao_Ensino" data-toggle="text"  class="wide-control form-control default input-sm" aria-haspopup="true" aria-expanded="false" />
                                        </div>
                                      </div>
                                      <div class="col-sm-12 col-md-4">
                                        <div class="single-blog ">
                                          <label class="narrow-control label-top-left" for="cod_uf_Intituicao">UF*</label>
                                          <select class="wide-control form-control default input-sm" id="cod_uf_Intituicao" onchange="popula_municipio_instituicao_nova(this.value,document.getElementById('cod_muni_Instituicao').value);">
                                          </select>
                                        </div>
                                      </div>
                                      <div class="col-sm-12 col-md-8">
                                        <div class="single-blog ">
                                          <label class="narrow-control label-top-left" for="cod_muni_Instituicao">Municipio*</label>
                                          <select class="wide-control form-control default input-sm" id="cod_muni_Instituicao">
                                          </select>
                                        </div>
                                      </div>
                                    </div>
                                  </div>
                                  <div class="col-sm-12 col-md-6">
                                    <div class="single-blog ">
                                      <label class="narrow-control label-top-left" for="CNPJ_instituicao_Ensino">CNPJ</label>
                                      <input type="text" id="CNPJ_instituicao_Ensino" data-toggle="text" onkeypress='return SomenteNumero(event);' onKeyUp="formata_cnpj_digitado('CNPJ_instituicao',this.value,'previsao',event)" class="wide-control form-control default input-sm" aria-haspopup="true" aria-expanded="true" />
                                    </div>
                                  </div>
                                  <div class="col-sm-12 col-md-4">
                                    <div class="single-blog ">
                                      <label class="narrow-control label-top-left" for="previsao">Previsão de Conclusão</label>
                                      <input type="text" id="previsao" data-toggle="text"  class="wide-control form-control default input-sm"  aria-haspopup="true" aria-expanded="false"  />
                                    </div>
                                  </div>
                                </div></div>
                                  </div></div>
                                
                              </div>
                            <td>
                          </tr>
                            </table>
                      </div>
                        </div>
                  </div>
                    </div>
              </div>
                  <div class="panel widget uib_w_34 panel-success" data-uib="twitter%20bootstrap/collapsible" data-ver="1" id="painel_dadosdainstituicao">
                <div class="panel-heading">
                      <h4 class="panel-title"> DADOS INSTITUCIONAIS </h4>
                    </div>
                <div id="bs-accordion-group-5" class="panel-collapse collapse in">
                      <div class="panel-body">
                    <div class="col uib_col_6 single-col" data-uib="layout/col" data-ver="0">
                          <div class="widget-container content-area vertical-col">
                        <label class="radio radio-padding-left widget uib_w_56 d-margins" data-uib="twitter%20bootstrap/radio_button" data-ver="1"> *Caso seja vinculado(a) a alguma instituição, todos os campos deverão ser preenchidos obrigatoriamente! </label>
                        <table>
                              <tr>
                            <td width="40%" colspan="2"><div class="table-thing widget uib_w_27 d-margins" data-uib="twitter%20bootstrap/select" data-ver="1">
                                <label class="narrow-control label-top-left">Trabalha ou atua em alguma instituição?</label>
                              </div></td>
                            <td width="10%" colspan="1"><label class="radio radio-padding-left widget uib_w_56 d-margins" data-uib="twitter%20bootstrap/radio_button" data-ver="1">
                                <input type="radio" name="vinculo" id="vinculo" onclick="Mudarestado('m');">
                                Sim</label></td>
                            <td width="30%" colspan="1"><label class="radio radio-padding-left widget uib_w_56 d-margins" data-uib="twitter%20bootstrap/radio_button" data-ver="1">
                                <input type="radio" name="vinculo" id="vinculo" onclick="Mudarestado('o');">
                                Não</label></td>

                                
                          </tr>
                            </table>
                        <div id="instituicao">
                        <input type="hidden" id="cod_entidade"/>
                              <table width="100%" border="0">
                            <tr>
                                  <td width="24%"><div class="table-thing widget uib_w_35 d-margins" data-uib="twitter%20bootstrap/select" data-ver="1" id="texto_tipoinstituicaonunca">
                                      <label class="narrow-control label-top-left">Natureza da Instituição*</label>
                                    </div></td>
                                  <td width="24%"><select class="wide-control form-control default input-sm" id="tipoenti"  onchange="Mudarefetivo('m');">
                                    </select></td>
                                  <td width="2%"></td>
                                  <td width="24%"  colspan="1"><div class="table-thing widget uib_w_35 d-margins" data-uib="twitter%20bootstrap/select" data-ver="1" id="texto_tipoinstituicaonunca">
                                      <label class="narrow-control label-top-left">Área de atuação*</label>
                                    </div></td>
                                  <td width="33%" colspan="1"><select class="wide-control form-control default input-sm" id="area_atuacao">
                                      <option value=0></option>
                                    </select></td>
                                </tr>
                            <tr>
                                  <td width="24%"><div class="table-thing widget uib_w_36 d-margins" data-uib="twitter%20bootstrap/select" data-ver="1" id="texto_ufinstituicaonunca">
                                      <label class="narrow-control label-top-left">UF*</label>
                                    </div></td>
                                  <td width="24%"><select class="wide-control form-control default input-sm" id="cod_uf_enti" onchange="popula_municipio_instituicao(this.value,document.getElementById('cod_muni_enti').value);">
                                    </select></td>
                                  <td></td>
                                  <td  width="12%" colspan="1"><div id="efetivo_tipo1"  style="display: none;">
                                      <div class="table-thing widget uib_w_70 d-margins" data-uib="twitter%20bootstrap/select" data-ver="1">
                                      <label class="narrow-control label-top-left">Servidor efetivo? *</label>
                                    </div>
                                    </div></td>
                                  <td width="33%"><table border="0"  width="100%" cellpadding="10" cellspacing="10">
                                      <tr>
                                      <td width="2%"></td>
                                      <td width="50%"><div id="efetivo_tipo2"  style="display: none;">
                                          <label class="radio radio-padding-left widget uib_w_71 d-margins" data-uib="twitter%20bootstrap/radio_button" data-ver="1">
                                          <input type="radio" name="efetivo" id="efetivo" value="sim" onchange="Efetivo_Check('0');">
                                          Sim</label>
                                        </div></td>
                                      <td width="40%"><div id="efetivo_tipo3"  style="display: none;">
                                          <label class="radio radio-padding-left widget uib_w_72 d-margins" data-uib="twitter%20bootstrap/radio_button" data-ver="1">
                                          <input type="radio" name="efetivo" id="efetivo" value="nao" onchange="Efetivo_Check('1');">
                                          Não</label>
                                        </div></td>
                                        <td></td>
                                    </tr>
                                    </table></td>
                                </tr>
                            <tr>
                                  <td width="24%"><div class="table-thing widget uib_w_37 d-margins" data-uib="twitter%20bootstrap/select" data-ver="1" id="texto_municipioinstituicaonunca">
                                      <label class="narrow-control label-top-left">Municipio*</label>
                                    </div></td>
                                  <td width="24%"><select class="wide-control form-control default input-sm" id="cod_muni_enti">
                                    </select></td>
                                  <td width="2%"></td>
                                  <td width="25%"><div class="table-thing widget uib_w_38 d-margins" data-uib="twitter%20bootstrap/input" data-ver="1" id="texto_cnpjinstituicaonunca">
                                      <label class="narrow-control label-top-left" for="e_cnpj">CNPJ*</label>
                                    </div></td>
                                  <td width="33%"><input class="wide-control form-control default input-sm" type="text" id="e_cnpj"  onkeyup="formata_cnpj_digitado('e_cnpj',this.value,'e_nome',event)" onBlur="pesquisa_por_cnpj();"></td>
                                </tr>
                            <tr>
                                  <td width="24%"><div class="table-thing widget uib_w_64 d-margins" data-uib="twitter%20bootstrap/input" data-ver="1" id="texto_nomeinstituicaonunca">
                                      <label class="narrow-control label-top-left" for="nome_instituicao">Nome Instituição*</label>

                                    </div></td>
                                    
                               <td colspan="3">
                                <input class="wide-control form-control default input-sm" onKeyPress="Carrega_Entidade_AutoComplete();" type="text" id="e_nome">
                                  <div class=" collapsed" id="complete"></div></td>
                                   <td  width="5%" align="center"> <a href="#" id="limparDadosDaPRofissionais" class="btn btn-success" onclick="LimpaCampos('false');" tooltip="Limpar dados da instituição"> <i class="fa fa-eraser"></i> Limpar </a>  </td>
                                </tr>
                            <tr>
                                  <td width="24%"><div class="table-thing widget uib_w_30 d-margins" data-uib="twitter%20bootstrap/input" data-ver="1">
                                      <label class="narrow-control label-top-left" for="setor">Setor*</label>
                                    </div></td>
                                  <td width="24%"><input class="wide-control form-control default input-sm" type="text" id="setor" name="setor"></td>
                                  <td></td>
                                  <td width="12%"><div class="table-thing widget uib_w_33 d-margins" data-uib="twitter%20bootstrap/input" data-ver="1">
                                      <label class="narrow-control label-top-left" for="cargo">Cargo/Função*</label>
                                    </div></td>
                                  <td width="33%" colspan="4"><input class="wide-control form-control default input-sm" type="text" id="cargo" name="cargo"></td>
                                </tr>
                            <tr>
                                  <td width="24%" colspan="1"></td>
                                </tr>
                            <tr>
                                  <td width="24%"><div class="table-thing widget uib_w_30 d-margins" data-uib="twitter%20bootstrap/input" data-ver="1">
                                      <label class="narrow-control label-top-left" for="e_mail_profissional">E-mail profissional *</label>
                                    </div></td>
                                  <td width="24%"><input class="wide-control form-control default input-sm" type="email" id="e_email" onBlur="ValidaEmail(this.value);" ></td>
                                  <td></td>
                                  <td width="12%"><div class="table-thing widget uib_w_33 d-margins" data-uib="twitter%20bootstrap/input" data-ver="1">
                                      <label class="narrow-control label-top-left" for="telefone_profissional*">DDD/Telefone*</label>
                                    </div></td>
                                  <td width="33%"><input class="wide-control form-control default input-sm" type="tel" id="telefone_entidade" onkeyup="formata_telefone('telefone_entidade',this.value,event);" onblur="corrige_traco('telefone_entidade',this.value,event);"></td>
                                </tr>
                            
                                  <td width="24%"><div class="table-thing widget uib_w_39 d-margins" data-uib="twitter%20bootstrap/input" data-ver="1" id="texto_enderecoinstituicaonunca">
                                      <label class="narrow-control label-top-left" for="endereco_instituicao">Endereço*</label>
                                    </div></td>
                                  <td colspan="4"><input class="wide-control form-control default input-sm" type="text" id="e_endereco"></td>
                                </tr>
                            <tr>
                                  <td width="24%"><div class="table-thing widget uib_w_40 d-margins" data-uib="twitter%20bootstrap/input" data-ver="1" id="texto_cepinstituicaonunca">
                                      <label class="narrow-control label-top-left" for="cep_instituicao">CEP*</label>
                                    </div></td>
                                  <td width="24%"><input class="wide-control form-control default input-sm" type="tel" id="e_cep" onkeyup="formata_cep('e_cep',this.value,event);"></td>
                                  <td></td>
                                  <td width="12%"><div class="table-thing widget uib_w_42 d-margins" data-uib="twitter%20bootstrap/input" data-ver="1">
                                      <label class="narrow-control label-top-left" for="site_instituicao">Site</label>
                                    </div></td>
                                  <td width="33%"><input class="wide-control form-control default input-sm" type="url" id="e_www"></td>
                                </tr>
                          </table>
                            </div>
                      </div>
                        </div>
                  </div>
                    </div>
              </div>
                </div>
            <div class="panel widget uib_w_26 panel-success" data-uib="twitter%20bootstrap/collapsible" data-ver="1">
                  <div class="panel-heading">
                <h4 class="panel-title"> DESEJAMOS SABER MAIS SOBRE VOCÊ </h4>
              </div>
                  <div id="bs-accordion-group-3" class="panel-collapse collapse in">
                <div class="panel-body">
                      <div class="col uib_col_4 single-col" data-uib="layout/col" data-ver="0">
                    <div class="widget-container content-area vertical-col">
                          <table>
                        <tr>
                              <td width="80%" colspan="4"><div class="table-thing widget uib_w_27 d-margins" data-uib="twitter%20bootstrap/select" data-ver="1">
                                  <label class="narrow-control label-top-left">Quais são suas expectativas para participar do curso? *</label>
                                </div></td>
                            </tr>
                        <tr>
                              <td width="80%" colspan="4"><input class="wide-control form-control default" type="text" id="expectativas"></td>
                            </tr>
                        <tr>
                              <td width="40%" colspan="2"><div class="table-thing widget uib_w_27 d-margins" data-uib="twitter%20bootstrap/select" data-ver="1">
                                  <label class="narrow-control label-top-left">Como ficou sabendo do curso? *</label>
                                </div></td>
                              <td width="40%" colspan="2"><div class="table-thing widget uib_w_27 d-margins" data-uib="twitter%20bootstrap/select" data-ver="1">
                                  <label class="narrow-control label-top-left">Outros/especificar</label>
                                </div></td>
                            </tr>
                        <tr>
                              <td width="35%" colspan="1"><select class="wide-control form-control default input-sm" id="selecao_como_soube" name="selecao_como_soube">
                                  <option></option>
                                  <option value="0">E-Mail</option>
                                  <option value="1">Marketing</option>
                                  <option value="2">Facebook</option>
                                  <option value="3">Folder</option>
                                  <option value="4">Indicação</option>
                                  <option value="5">Newsletter de parceiros</option>
                                  <option value="6">Outros</option>
                                  <option value="7"></option>
                                  <option value="8"></option>
                                </select></td>
                              <td width="5%" colspan="1"></td>
                              <td width="20%" colspan="2"><input class="wide-control form-control default" type="text" id="como_soube"></td>
                            </tr>
                        <tr>
                              <td width="40%" colspan="2"><div class="table-thing widget uib_w_27 d-margins" data-uib="twitter%20bootstrap/select" data-ver="1">
                                  <label class="narrow-control label-top-left">Tem alguma atuação no Bioma Amazônia? *</label>
                                </div></td>
                              <td width="10%" colspan="1"><label class="radio radio-padding-left widget uib_w_56 d-margins" data-uib="twitter%20bootstrap/radio_button" data-ver="1"> 
                                  <!---- <input type="radio" name="atuacao" id="atuacao" checked> Sim</label>   ---->
                                  <input type="radio" name="atuacao" id="atuacao" value="1">
                                  Sim</label></td>
                              <td width="30%" colspan="1"><label class="radio radio-padding-left widget uib_w_56 d-margins" data-uib="twitter%20bootstrap/radio_button" data-ver="1"> 
                                  <!---- <input type="radio" name="atuacao" id="atuacao"> Não</label>  ---->
                                  <input type="radio" name="atuacao" id="atuacao" value="0" >
                                  Não</label></td>
                            </tr>
                        <tr>
                              <td width="80%" colspan="4"><div class="table-thing widget uib_w_27 d-margins" data-uib="twitter%20bootstrap/select" data-ver="1">
                                  <label class="narrow-control label-top-left">Qual?</label>
                                </div>
                            <input class="wide-control form-control default" type="text" id="atuacao_bioma" name="atuacao_bioma"></td>
                            </tr>
                      </table>
                        </div>
                  </div>
                    </div>
              </div>
                </div>
                
                 <div class="panel widget uib_w_26 panel-success" data-uib="twitter%20bootstrap/collapsible" data-ver="1">
                  <div class="panel-heading">
                <h4 class="panel-title"> SENHA DE ACESSO </h4>
              </div>
                  <div id="bs-accordion-group-3" class="panel-collapse collapse in">
                <div class="panel-body">
                
            <table width="100%" border="0">
                  <tr>
                <td width="25%"><div class="table-thing widget uib_w_11 d-margins" data-uib="twitter%20bootstrap/input" data-ver="1" id="texto_senhanunca">
                    <label class="narrow-control left" for="senha">Crie uma senha* </label>
                  </div></td>
                <td width="25%"><input class="wide-control form-control default input-sm" type="password" id="password"></td>
                <td width="50%"></td>
              </tr>
                  <tr>
                <td width="25%"><div class="table-thing widget uib_w_11 d-margins" data-uib="twitter%20bootstrap/input" data-ver="1" id="texto_senhanunca">
                    <label class="narrow-control left" for="senha">Confirme sua senha* </label>
                  </div></td>
                <td width="25%"><input class="wide-control form-control default input-sm" type="password" id="confirme_password" onblur="dados_iguais('password','confirme_password','newsletter','Senha');"></td>
                <td width="50%"></td>
              </tr>
                </table>
                </div></div></div>
            <label class="radio radio-padding-left widget uib_w_56 d-margins" data-uib="twitter%20bootstrap/radio_button" data-ver="1">
                  <input type="checkbox" name="newsletter" id="newsletter" checked>
                  Quero receber informações sobre cursos do IBAM</label>
            <label class="radio radio-padding-left widget uib_w_56 d-margins" data-uib="twitter%20bootstrap/radio_button" data-ver="1">
                  <input type="checkbox" name="veracidade" id="veracidade" checked>
                  Confirmo a veracidade e atualização dos dados acima registrados</label>
            <button class="btn widget uib_w_57 d-margins btn-success" data-uib="twitter%20bootstrap/button"  id="btn_confirma_inscricao" onclick="salva_meus_dados(<% =ID_TURMA %>)"><i class="glyphicon glyphicon-pencil button-icon-left" data-position="left"></i>Confirmar inscrição</button>
            <span class="uib_shim"></span> </div>
              <div class="container">
            <h6>
            Em caso de dúvida, sugestão ou reclamação, entre em contato conosco: </br> 
			pqga-ead@ibam.org.br, (21)2536-9774 ou whatsapp (21) 99805-0696 </label>
                </h6>
          </div>
            </div>
      </div>
        </div>
  </div>
    </div>
</div>
</div>
</div>
<style type="text/css">
#legenda label {
	display:block;
	width:x;
	height:y;
	color:#FF0000;
	text-align:right;
}

td{
	margin:5px;
	
	}
	
.collapsed{
	
	display:none;
	}
	
.Expanded{
	
	
	width:100%;
	 min-width: 200px; 
   
    z-index: 1100;
    position: absolute;
	font-size:11px;
	
	}	

.Expanded ul:houver {
background-color: #CCC;	
border:1px ;
border-color:#000;

	}	
.Expanded ul li:hover {

height:15px;
font-weight:bold;
	
}		

.single-column label{

	width:120px;
	font-size:11px;
}

.instituicoes{
	
	font-size:12px;
	
	}
.Expanded  a	{
		font-size:13px;
	color:#000!important;
	}
	

</style>
</body>
 <script src="../adm/scripts/popUpDialogo.js"></script>
  <script src="js/jquery.mask.min.js"></script>

</html>

