<%If session("key_ver")<>"ok" Then Response.Redirect "logout.asp"%>
<!-- #INCLUDE FILE="../library/parametros.asp" -->
<!-- #INCLUDE FILE="../library/conOpen.asp" -->
<%  SIGA_PROJETO=Session("siga_projeto")  %>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
<!----	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">  ---->
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />

<link href="content/css/main.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="content/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="content/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css" href="css/jquery-ui.css">
<script src="scripts/jquery-1.11.3.min.js" type="text/javascript"></script>
<script src="content/js/bootstrap-modal.js"></script>

<script src="scripts/popUpDialogo.js"></script>
<script>
            $(document).ready(function() {
			
			inicio();
							
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
			 
			
      	
				
		
    </script>
<style type="text/css">
#legenda label {
	display:block;
	width:x;
	height:y;
	color:#FF0000;
	text-align:right;
}
td {
	margin:5px;
}
.collapsed {
	display:none;
}
.Expanded {
	/* width: 300px; 
    height: 300px;*/
    z-index: 1001;
	background-color: #fff;
	z-index: 1100;
	position: absolute;
	font-size:11px;
}
 .Expanded ul:houver {
background-color: #CCC;
border:1px;
border-color:#000;
}
.Expanded ul li:hover {
	height:15px;
	font-weight:bold;
}
.single-column label {
	width:120px;
	font-size:11px;
}
.instituicoes {
	font-size:12px;
}
label {
	font-size:12px;
	text-align:left;
}
</style>
</head>

<body >
<div id="ckmt"> 
  <!-- #INCLUDE FILE="include/topo.asp" -->
  
  <input type="hidden" name="cod_aluno" id="cod_aluno" value="<%=request("coda")%>">
  <input type="hidden" name="ja_cadastrado" id="ja_cadastrado" value="">
  <input type="hidden" name="ja_na_turma" id="ja_na_turma" value="">
  <div class="col-sm-12 col-md-6">
    <div class="single-blog single-column">
      <h2>CADASTRO DE ALUNOS</h2>
    </div>
  </div>
  <br>
  <div id="legenda" class="align-right">
    <label id="nome_legenda">
    <h6>* Campos obrigat&oacute;rios</h6>
    </label>
  </div>
  </br>
  <div id="painel_2" class="panel widget uib_w_9 panel-info " >
    <div class="panel-heading">
      <h4 class="panel-title"> Pesquisar por CPF</h4>
    </div>
    <div id="bs-accordion-group-0" class="panel-collapse collapse in">
      <div class="panel-body">
        <div class="col uib_col_3 single-col" data-uib="layout/col" data-ver="1">
          <div class="widget-container content-area vertical-col"> Caso tenha participado anteriormente de curso do IBAM, voc&ecirc; j&aacute; tem SENHA no nosso banco de dados.</div>
          <div class="col-sm-12 col-md-2">
            <div class="single-blog single-column">
              <label class="narrow-control " for="cpf">CPF </label>
            </div>
          </div>
          <div class="col-sm-12 col-md-2">
            <div class="single-blog single-column">
              <input class="wide-control form-control default input-sm" type="text" id="cpf" onkeyup="formata_cpf_digitado('cpf',this.value,'cpf',event)">
            </div>
          </div>
          <div class="col-sm-12 col-md-2">
            <div class="single-blog single-column">
              <button class="btn widget uib_w_57 d-margins btn-success" onclick="procura_cpf();">Ok</button>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  <div class=" panel widget uib_w_9 panel-info" data-uib="twitter%20bootstrap/collapsible" data-ver="1" id="painel_dadospessoais">
    <div class="panel-heading">
      <h4 class="panel-title"> DADOS PESSOAIS </h4>
    </div>
    <div id="bs-accordion-group-2" class="post-content panel-collapse collapse in ">
      <div class="panel-body">
        <div class="col-md-7 col-sm-7" data-uib="layout/col" data-ver="0">
          <div class="widget-container content-area vertical-col">
            <div class="row">
              <div class="col-sm-6 col-md-12 ">
                <label class="narrow-control left" for="nome" >Nome Completo*</label>
                <div class="single-blog single-column">
                  <input class="wide-control form-control default input-sm" type="text" id="nome">
                </div>
              </div>
            </div>
            <div class="row">
              <div class="col-sm-12 col-md-12">
                <label class="narrow-control left " for="nome">Nome social</label>
                <div class="single-blog single-column">
                  <input class="wide-control form-control default input-sm" placeholder="Caso atenda por um nome diferente do registro" type="text" id="nome_social">
                </div>
              </div>
            </div>
            <div class="row">
              <div class="col-sm-12 col-md-6">
                <label class="narrow-control" for="cpf">CPF* </label>
                <div class="single-blog single-column">
                  <input class="wide-control form-control default input-sm" type="tel" id="cpf_cadastrado" onkeyup="formata_cpf_digitado('cpf_cadastrado',this.value,'dt_nascimento',event)">
                </div>
              </div>
            </div>
            <div class="row">
              <div class="col-sm-12 col-md-6">
                <div class="table-thing widget uib_w_15 d-margins" data-uib="twitter%20bootstrap/input" data-ver="1" id="texto_nascimentonunca">
                  <label class="narrow-control left" for="nascimento"> Data de Nascimento*</label>
                </div>
                <div class="single-blog single-column">
                  <input class="wide-control form-control default input-sm" type="text" id="dt_nascimento" onkeyup="formata_data('dt_nascimento',this.value,'cod_raca',event)">
                </div>
              </div>
            </div>
            <div class="row">
              <div class="col-sm-12 col-md-6">
                <div class="table-thing widget uib_w_19 d-margins" data-uib="twitter%20bootstrap/select" data-ver="1">
                  <label class="narrow-control left">Raça/Cor ou Etnia</label>
                </div>
                <div class="single-blog single-column">
                  <select class="wide-control form-control default input-sm" id="cod_raca">
                  </select>
                </div>
              </div>
            </div>
            
               <div class="row">
              <div class="col-sm-12 col-md-6">
                <div class="table-thing widget uib_w_19 d-margins" data-uib="twitter%20bootstrap/select" data-ver="1">
                  <label class="narrow-control left">Deficiência</label>
                </div>
                <div class="single-blog single-column">
                  <select class="wide-control form-control default input-sm" id="cod_deficiencia">
                  </select>
                </div>
              </div>
            </div>
            
            
            <div class="row">
              <div class="col-sm-12 col-md-6">
                <div class="table-thing widget uib_w_20 d-margins" data-uib="twitter%20bootstrap/select" data-ver="1" id="texto_sexo">
                  <label class="narrow-control left">Sexo</label>
                </div>
                <div class="single-blog single-column">
                  <select class="wide-control form-control default input-sm" id="sexo">
                    <option></option>
                    <option value="0">Feminino</option>
                    <option value="1">Masculino</option>
                  </select>
                </div>
              </div>
            </div>
            <div class="row">
              <div class="col-sm-12 col-md-4">
                <div class="table-thing widget uib_w_24 d-margins" data-uib="twitter%20bootstrap/input" data-ver="1" id="texto_telefonenunca">
                  <label class="narrow-control left" for="telefone">DDD/Telefone*</label>
                </div>
                <div class="single-blog single-column">
                  <input class="wide-control form-control default input-sm" type="tel" id="telefone_pessoal" onblur="corrige_traco('telefone_pessoal',this.value,event);">
                </div>
              </div>
            </div>
            
             <div class="row">
              <div class="col-sm-12 col-md-4">
                <div class="table-thing widget uib_w_24 d-margins" data-uib="twitter%20bootstrap/input" data-ver="1" id="texto_telefonenunca">
                  <label class="narrow-control left" for="fax">DDD/FAX*</label>
                </div>
                <div class="single-blog single-column">
                  <input class="wide-control form-control default input-sm" type="tel" id="fax_pessoal" >
                </div>
              </div>
            </div>
            
            <div class="row">
              <div class="col-sm-12 col-md-6">
                <div class="table-thing widget uib_w_21 d-margins" data-uib="twitter%20bootstrap/input" data-ver="1" id="texto_emailnunca">
                  <label class="narrow-control left" for="email">Email pessoal*</label>
                </div>
                <div class="single-blog single-column">
                  <input class="wide-control form-control default input-sm" type="email" id="email">
                </div>
              </div>
            </div>
            <div class="row">
              <div class="col-sm-12 col-md-6">
                <div class="table-thing widget uib_w_22 d-margins" data-uib="twitter%20bootstrap/input" data-ver="1" id="texto_confirmenunca">
                  <label class="narrow-control left" for="confirme">Confirme e-mail*</label>
                </div>
                <div class="single-blog single-column">
                  <input class="wide-control form-control default input-sm" type="email" id="confirme_email" onblur="dados_iguais('email','confirme_email','endereco','e-mail');">
                </div>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-sm-12 col-md-8">
              <div class="table-thing widget uib_w_23 d-margins" data-uib="twitter%20bootstrap/input" data-ver="1" id="texto_endereconunca">
                <label class="narrow-control left" for="endereco">Endereço*</label>
              </div>
              <div class="single-blog single-column">
                <input class="wide-control form-control default input-sm" type="text" id="endereco">
              </div>
            </div>
            <div class="col-sm-12 col-md-4">
             
                <div class="table-thing widget uib_w_20 d-margins" data-uib="twitter%20bootstrap/select" data-ver="1" id="texto_cep">
                  <label class="narrow-control left">CEP*</label>
                </div> <div class="single-blog single-column">
                <input class="wide-control form-control default input-sm" type="text" id="cep" >
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-sm-12 col-md-4">
              <div class="table-thing widget uib_w_20 d-margins" data-uib="twitter%20bootstrap/select" data-ver="1" id="texto_pais">
                <label class="narrow-control left">País</label>
              </div>
              <div class="single-blog single-column">
                <select class="wide-control form-control default input-sm" id="cod_pais" onchange="popula_uf(this.value);">
                </select>
              </div>
            </div>
            <div class="col-sm-12 col-md-4">
              <div class="table-thing widget uib_w_20 d-margins" data-uib="twitter%20bootstrap/select" data-ver="1" id="texto_estado">
                <label class="narrow-control left">Estado*</label>
              </div>
              <div class="single-blog single-column">
                <select class="wide-control form-control default input-sm" id="cod_uf_ibge" onchange="popula_municipio(this.value,document.getElementById('cod_muni_ibge').value);">
                </select>
              </div>
            </div>
            <div class="col-sm-12 col-md-4">
              <div class="table-thing widget uib_w_20 d-margins" data-uib="twitter%20bootstrap/select" data-ver="1" id="texto_municipio">
                <label class="narrow-control left">Municipio*</label>
              </div>
              <div class="single-blog single-column">
                <select class="wide-control form-control default input-sm" id="cod_muni_ibge">
                </select>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  <div class="panel widget uib_w_26 panel-info" data-uib="twitter%20bootstrap/collapsible" data-ver="1">
    <div class="panel-heading">
      <h4 class="panel-title"> FORMAÇÃO ACADÊMICA</h4>
    </div>
    <div id="bs-accordion-group-3" class="panel-collapse collapse in">
      <div class="panel-body">
        <div class="col-md-7 col-sm-7" data-uib="layout/col" data-ver="0">
          <div class="widget-container content-area vertical-col">
            <div class="row">
              <div class="col-sm-12 col-md-6">
                <div  data-uib="twitter%20bootstrap/select" data-ver="1">
                  <label class="narrow-control left">Escolaridade*</label>
                </div>
                <div class="single-blog single-column">
                  <select class="wide-control form-control default input-sm" id="cod_escolaridade" onclick="Mudarestadonomecurso('m');">
                  </select>
                </div>
              </div>
              <div class="col-sm-12 col-md-6">
               
                  <label class="narrow-control left">Nome do Curso</label>
                   <div class="single-blog single-column">
                  <input class="wide-control form-control default input-sm" type="text" id="formacao">
                </div>
              </div>
            </div>
            <div class="row">
              <div class="col-sm-12 col-md-6">
                <label class="narrow-control left" id="cod_pos_label"  >Pós-graduação</label>
                <div class="single-blog single-column">
                  <select class="wide-control form-control default input-sm" id="cod_pos"  onchange="Mudarestadopos('m');">
                  </select>
                </div>
              </div>
              <div class="col-sm-12 col-md-6">
                <label class="narrow-control left" for="especificarpos">Área (especificar)</label>
                <div class="single-blog single-column">
                  <input class="wide-control form-control default input-sm" type="text" id="pos">
                </div>
              </div>
            </div>
            <div class="col-sm-12 col-md-4">
              <label class="narrow-control left">Estuda atualmente? *</label>
              <div class="single-blog single-column align-right">
                <input type="checkbox" id="EstudaSim" />
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="panel widget uib_w_26 panel-info" id="formulario_instituicao" data-uib="twitter%20bootstrap/collapsible" data-ver="1">
        <div class="panel-heading">
          <h4 class="panel-title"> INSTITUIÇÃO DE ENSINO </h4>
        </div>
        <div id="bs-accordion-group-3" class="panel-collapse collapse in">
          <div class="panel-body">
            <div class="row">
              <div class="col-md-12 col-sm-7">
                <div class="row">
                  <div class="col-sm-12 col-md-6">
                    <label class="narrow-control left" for="Nome_instituicao_Ensino">Instituição de Ensino</label>
                    <div class="single-blog single-column ">
                      <input type="text" id="Nome_instituicao_Ensino" data-toggle="text"  class="wide-control form-control default input-sm" aria-haspopup="true" aria-expanded="false" />
                    </div>
                  </div>
                </div>
                <div class="row">
                  <div class="col-sm-12 col-md-3">
                    <label class="narrow-control left" for="cod_uf_Intituicao">UF*</label>
                    <div class="single-blog single-column">
                      <select class="wide-control form-control default input-sm" id="cod_uf_Intituicao" onchange="popula_municipio_instituicao_nova(this.value,document.getElementById('cod_muni_Instituicao').value);">
                      </select>
                    </div>
                  </div>
                  <div class="col-sm-12 col-md-3">
                    <label class="narrow-control left" for="cod_muni_Instituicao">Municipio*</label>
                    <div class="single-blog single-column">
                      <select class="wide-control form-control default input-sm" id="cod_muni_Instituicao">
                      </select>
                    </div>
                  </div>
                </div>
                <div class="row">
                  <div class="col-sm-12 col-md-3">
                    <label class="narrow-control left" for="CNPJ_instituicao_Ensino">CNPJ</label>
                    <div class="single-blog single-column">
                      <input type="text" id="CNPJ_instituicao_Ensino" data-toggle="text" class="wide-control form-control default input-sm" aria-haspopup="true" aria-expanded="true" />
                    </div>
                  </div>
                  <div class="col-sm-12 col-md-3">
                    <label class="narrow-control left">Previsão Conclusão</label>
                    <div class="single-blog single-column">
                      <input type="text" id="previsao" data-toggle="text"  class="wide-control form-control default input-sm"  aria-haspopup="true" aria-expanded="false"  />
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  
  <!--  Ate aqui esta legal -->
  
  <div class="panel widget uib_w_34 panel-info" data-uib="twitter%20bootstrap/collapsible" data-ver="1" id="painel_dadosdainstituicao">
    <div class="panel-heading">
      <h4 class="panel-title"> DADOS INSTITUCIONAIS</h4>
    </div>
    <div id="bs-accordion-group-5" class="panel-collapse collapse in">
      <div class="panel-body">
        <div class="col-md-7 col-sm-7" data-uib="layout/col" data-ver="0">
          <div class="widget-container content-area vertical-col">
            <div class="row">
              <div class="col-sm-12 col-md-4">
                <div class="single-blog  "> Trabalha ou atua em alguma instituição? </div>
              </div>
              <div class="col-sm-12 col-md-2">
                <div class="single-blog single-column ">
                  <input type="radio" name="vinculo" id="vinculo" onclick="Mudarestado('m');">
                  Sim </div>
              </div>
              <div class="col-sm-12 col-md-2">
                <div class="single-blog single-column ">
                  <input type="radio" name="vinculo" id="vinculo" onclick="Mudarestado('o');">
                  Não </div>
              </div>
            </div>
            <div class="row">
              <div id="instituicao">
                <input type="hidden" id="cod_entidade"/>
                <div class="row">
                  <div class="col-sm-12 col-md-12">
                    <label class="narrow-control left" for="tipoenti">Natureza da Instituição*</label>
                    <div class="single-blog single-column ">
                      <select class="wide-control form-control default input-sm" id="tipoenti"  onchange="Mudarefetivo('m');">
                      </select>
                    </div>
                  </div>
                </div>
                <div class="row">
                  <div class="col-sm-12 col-md-6">
                    <div  id="texto_tipoinstituicaonunca">
                      <label class="narrow-control left">Área de atuação*</label>
                      <div class="single-blog single-column " >
                        <select class="wide-control form-control default input-sm" id="area_atuacao">
                          <option value=0></option>
                        </select>
                      </div>
                    </div>
                  </div>
                  <div class="col-sm-12 col-md-6">
                    <label for="efetivo"  class="narrow-control left">Servidor efetivo? *</label>
                    <div class="single-blog single-column ">
                      <input type="radio" name="efetivo" id="efetivo" value="sim" onchange="Efetivo_Check('0');">
                      Sim
                      </input>
                      <input type="radio" name="efetivo" id="efetivo" value="nao" onchange="Efetivo_Check('1');">
                      Não
                      </input>
                    </div>
                  </div>
                </div>
             
              <div class="row">
                <div class="col-sm-12 col-md-6">
                  <label class="narrow-control left">UF*</label>
                  <div class="single-blog single-column">
                    <select class="wide-control form-control default input-sm" id="cod_uf_enti" onchange="popula_municipio_instituicao(this.value,document.getElementById('cod_muni_enti').value);">
                    </select>
                  </div>
                </div>
                <div class="col-sm-12 col-md-6">
                  <label class="narrow-control left">Municipio*</label>
                  <div class="single-blog single-column">
                    <select class="wide-control form-control default input-sm" id="cod_muni_enti" onChange="Carrega_Entidade();">
                    </select>
                  </div>
                </div>
              </div>
              <div class="row">
                <div class="col-sm-12 col-md-3">
                  <label class="narrow-control left" for="e_cnpj">CNPJ*</label>
                  <div class="single-blog single-column">
                    <input class="wide-control form-control default input-sm" type="text" id="e_cnpj"  onkeyup="formata_cnpj_digitado('e_cnpj',this.value,'e_nome',event)" >
                  </div>
                </div>
                <div class="col-sm-12 col-md-7">
                  <label class="narrow-control left" for="nome_instituicao">Nome Instituição*</label>
                  <div class="single-blog single-column ">
                    <input class="wide-control form-control default input-sm" onKeyPress="Carrega_Entidade_AutoComplete();" type="text" id="e_nome">
                    <div class=" collapsed" id="complete"></div>
                  </div>
                </div>
                
                <div class="col-sm-12 col-md-2">
                  <div class="single-blog single-column ">
					</br>
						<a href="#" id="limparDadosDaPRofissionais" onclick="LimpaCampos('false');" class="btn btn-info" tooltip="Limpar dados da instituição"> <i class="fa fa-eraser"></i> Limpar </a> 
                  </div>
                </div>
                
              </div>
              <div class="row">
                <div class="col-sm-12 col-md-6">
                  <label class="narrow-control left" for="setor">Setor*</label>
                  <div class="single-blog single-column">
                    <input class="wide-control form-control default input-sm" type="text" id="setor" name="setor">
                  </div>
                </div>
                <div class="col-sm-12 col-md-6">
                  <label class="narrow-control left" for="cargo">Cargo/Função*</label>
                  <div class="single-blog single-column">
                    <input class="wide-control form-control default input-sm" type="text" id="cargo" name="cargo">
                  </div>
                </div>
              </div>
              <div class="row">
                <div class="col-sm-12 col-md-6">
                  <label for="e_email" class="narrow-control left" >E-mail profissional*</label>
                  <div class="single-blog single-column">
                    <input class="wide-control form-control default input-sm" type="email" id="e_email" onBlur="ValidaEmail(this.value);" >
                  </div>
                </div>
                <div class="col-sm-12 col-md-3">
                  <label class="narrow-control left" for="telefone_entidade">DDD/Telefone*</label>
                  <div class="single-blog single-column">
                    <input class="wide-control form-control default input-sm" type="tel" id="telefone_entidade" >
                  </div>
                </div>
                 <div class="col-sm-12 col-md-3">
                  <label class="narrow-control left" for="telefone_entidade">DDD/Fax*</label>
                  <div class="single-blog single-column">
                    <input class="wide-control form-control default input-sm" type="text" id="fax_entidade" >
                  </div>
                </div>
              </div>
              <div class="row">
                <div class="col-sm-12 col-md-8">
                  <div class="" data-uib="twitter%20bootstrap/input" data-ver="1" id="texto_enderecoinstituicaonunca">
                    <label class="narrow-control left" for="endereco_instituicao">Endereço*</label>
                  </div>
                  <div class="single-blog single-column">
                    <input class="wide-control form-control default input-sm" type="text" id="e_endereco">
                  </div>
                </div>
                <div class="col-sm-12 col-md-4">
                  <label class="narrow-control left" for="cep_instituicao">CEP*</label>
                  <div class="single-blog single-column ">
                    <input class="wide-control form-control default input-sm" type="tel" id="e_cep">
                  </div>
                </div>
                <div class="col-sm-12 col-md-12">
                  <label class="narrow-control left" for="e_www">Site</label>
                  <div class="single-blog single-column ">
                    <input class="wide-control form-control default input-sm" type="url" id="e_www">
                  </div>
                   </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  <div class="panel widget uib_w_26 panel-info" data-uib="twitter%20bootstrap/collapsible" style="display:none;" data-ver="1">
    <div class="panel-heading">
      <h4 class="panel-title"> DESEJAMOS SABER MAIS SOBRE VOC&Ecirc; </h4>
    </div>
    <div id="bs-accordion-group-3" class="panel-collapse collapse in">
      <div class="panel-body">
        <div class="col uib_col_4 single-col" data-uib="layout/col" data-ver="0">
          <div class="widget-container content-area vertical-col">
            <div class="table-thing widget uib_w_27 d-margins" data-uib="twitter%20bootstrap/select" data-ver="1">
              <label class="narrow-control left">Quais s&atilde;o suas expectativas para participar do curso? *</label>
            </div>
            <input class="wide-control form-control default" type="text" id="expectativas">
            <div class="table-thing widget uib_w_27 d-margins" data-uib="twitter%20bootstrap/select" data-ver="1">
              <label class="narrow-control left">Como ficou sabendo do curso? *</label>
            </div>
            <div class="table-thing widget uib_w_27 d-margins" data-uib="twitter%20bootstrap/select" data-ver="1">
              <label class="narrow-control left">Outros/especificar</label>
            </div>
            <select class="wide-control form-control default input-sm" id="selecao_como_soube" name="selecao_como_soube">
              <option></option>
              <option value="0">E-Mail</option>
              <option value="1">Marketing</option>
              <option value="2">Facebook</option>
              <option value="3">Folder</option>
              <option value="4">Indica&ccedil;&atilde;o</option>
              <option value="5">Newsletter de parceiros</option>
              <option value="6">Outros</option>
              <option value="7"></option>
              <option value="8"></option>
            </select>
            <input class="wide-control form-control default" type="text" id="como_soube">
            <div class="table-thing widget uib_w_27 d-margins" data-uib="twitter%20bootstrap/select" data-ver="1">
              <label class="narrow-control left">Tem alguma atua&ccedil;&atilde;o no Bioma Amaz&ocirc;nia? *</label>
            </div>
            <label class="radio radio-padding-left widget uib_w_56 d-margins" data-uib="twitter%20bootstrap/radio_button" data-ver="1"> 
              <!---- <input type="radio" name="atuacao" id="atuacao" checked> Sim</label>   ---->
              <input type="radio" name="atuacao" id="atuacao" value="1" onchange="TemAtuacao_Check('1');">
              Sim</label>
            <label class="radio radio-padding-left widget uib_w_56 d-margins" data-uib="twitter%20bootstrap/radio_button" data-ver="1"> 
              <!---- <input type="radio" name="atuacao" id="atuacao"> Não</label>  ---->
              <input type="radio" name="atuacao" id="atuacao" value="0" onchange="TemAtuacao_Check('0');">
              N&atilde;o</label>
            <div class="table-thing widget uib_w_27 d-margins" data-uib="twitter%20bootstrap/select" data-ver="1">
              <label class="narrow-control left">Qual?</label>
            </div>
            <input class="wide-control form-control default" type="text" id="atuacao_bioma" name="atuacao_bioma">
          </div>
        </div>
      </div>
    </div>
  </div>
  <div class="panel widget uib_w_26 panel-info" data-uib="twitter%20bootstrap/collapsible" style="display:none;"  data-ver="1">
    <div class="panel-heading">
      <h4 class="panel-title"> SENHA DE ACESSO </h4>
    </div>
    <div id="bs-accordion-group-3" class="panel-collapse collapse in">
      <div class="panel-body">
        <div class="table-thing widget uib_w_11 d-margins" data-uib="twitter%20bootstrap/input" data-ver="1" id="texto_senhanunca">
          <label class="narrow-control left" for="senha">Crie uma senha* </label>
        </div>
        <input class="wide-control form-control default input-sm" type="password" id="password">
        <div class="table-thing widget uib_w_11 d-margins" data-uib="twitter%20bootstrap/input" data-ver="1" id="texto_senhanunca">
          <label class="narrow-control left" for="senha">Confirme sua senha* </label>
        </div>
        <input class="wide-control form-control default input-sm" type="password" id="confirme_password" onblur="dados_iguais('password','confirme_password','newsletter','Senha');">
      </div>
    </div>
  </div>
  <div class="container">
    <div class="col-sm-12 col-md-12">
      <div class="row">
        <div class="col-sm-12 col-md-12">
          <input type="checkbox" name="newsletter" id="newsletter" checked>
          Quero receber informa&ccedil;&otilde;es sobre cursos do IBAM </div>
        <div class="col-md-12">
          <input type="checkbox" name="veracidade" id="veracidade" checked>
          Confirmo a veracidade e atualiza&ccedil;&atilde;o dos dados acima registrados </div>
        <div class="col-md-12">
          <button class="btn widget uib_w_57 d-margins btn-success" data-uib="twitter%20bootstrap/button"  id="btn_confirma_inscricao" onclick="salva_meus_dados(<% =ID_TURMA %>)"><i class="fa fa-save" data-position="left"></i> Confirmar Edi&ccedil;&atilde;o</button>
          <span class="uib_shim"></span> </div>
      </div>
    </div>
  </div>
</div>
</div>
</body>
<script src="App/app.js" ></script>

<script src="scripts/jquery.mask.min.js"></script>
</html>
