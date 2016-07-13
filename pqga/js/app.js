
var url_ajax = 'funcoes.asp?task=';

// Função para abrir a pagina para envio de senha por email
function esqueci_senha() {
	myVar=open('esqueci.asp','Senha','scrollbars=yes,width=300,height=140');
}

// Função popular os campos iniciais
function inicio() {
	
	popula_raca(0);
    popula_pos(0);
    popula_escolaridade(0);
    popula_instituicao(0);
	
    popula_pais(0);
    popula_uf(0);
    popula_uf_instituicao(0);
	popula_uf_instituicao_ensino(0);

    popula_area(0);
	$("#formulario_instituicao").hide();	
	Mudarestadonomecurso(0);
    // Seta o tamanho maximo dos campos
    $('#cpf').attr('maxlength',14);
    $('#senha').attr('maxlength',16);
    $('#nome').attr('maxlength',150);
    $('#email').attr('maxlength',150);
    $('#endereco').attr('maxlength',250);
    $('#cep').attr('maxlength',9);
    $('#formacao').attr('maxlength',100);
    $('#pos').attr('maxlength',100);
    $('#e_nome').attr('maxlength',150);
    $('#e_cnpj').attr('maxlength',18);
    $('#e_endereco').attr('maxlength',100);
    $('#e_cep').attr('maxlength',9);
    $('#e_email').attr('maxlength',50);
    $('#e_www').attr('maxlength',100);
    $('#password').attr('maxlength',12);
    $('#nome_social').attr('maxlength',100);
    $('#telefone_pessoal').attr('maxlength',14);
    $('#telefone_entidade').attr('maxlength',14);
    $('#expectativas').attr('maxlength',250);
    $('#como_soube').attr('maxlength',250);
    $('#atuacao_bioma').attr('maxlength',250);
    $('#setor').attr('maxlength',50);
    $('#cargo').attr('maxlength',50);
    $('#area_atuacao').attr('maxlength',250);
    $('#Nome_instituicao_Ensino').attr('maxlength',250);
	$('#previsao').attr('maxlength',20);
	document.getElementById("instituicao").style.display = 'none';
	TratamentoDeCamposDadosProfissionais(true);
    // Fim
}

//Função para comparar dados iguais
function dados_iguais(campo1,campo2,proximocampo,titulo) {
	

	if(document.getElementById(campo1).value==document.getElementById(campo2).value) {
		document.getElementById(proximocampo).focus();
	} else {
		mensagem='Os campos '+titulo+' e Confirme '+titulo+' estão diferentes';
		var msg = mensagem;
		 waitingDialog.show(msg);
    	  setTimeout(function () { waitingDialog.hide(); }, 3000);
		document.getElementById(campo1).value = '';
		document.getElementById(campo2).value = '';

		document.getElementById(campo1).focus();
	}
}

// Localiza CPF na base de dados para login
function procura_cpf() {
    var task 	 = 'procura_cpf';
    var cpf		 = '&cpf='+$('#cpf_cadastrado').val();
    var destino  = url_ajax+task+cpf;
    $.ajax({
        type:'GET',
        url:destino,
        success: function (data) {
	        if (data=='success') {
	            var msg = 'Atenção: Observamos em nosso cadastrado que você já participou de cursos no IBAM. Sendo assim, por favor, digite seu CPF e senha na caixa acima. Caso tenha esquecido sua senha, clique no botão "esqueci minha senha';
				 waitingDialog.show(msg);
   			     setTimeout(function () { waitingDialog.hide(); }, 3000);
	            $('#cpf_cadastrado').val('');
	            $('#cpf').focus();
	            $('#ja_cadastrado').val('true');
	            $('#ja_na_turma').val('false');
        	} else {
	            $('#ja_cadastrado').val('false');
			}
        }
    });
}


// Função de login, para recuperar os dados de alunos já cadastrados
function recupere_meus_dados(turma) {
	
		 waitingDialog.show("Aguarde, recuperando seus dados! ");
    var cpf_jacadastrado    = $("#cpf").val();
    cpf_jacadastrado        = cpf_jacadastrado.replace(".","");
    cpf_jacadastrado        = cpf_jacadastrado.replace(".","");
    cpf_jacadastrado        = cpf_jacadastrado.replace("-","");
    var senha_jacadastrado  = $("#senha").val();
    var task				= 'recupere_meus_dados';
    var cpf                 = '&cpf='+cpf_jacadastrado;
    var senha               = '&senha='+senha_jacadastrado;
    var id_turma            = '&id_turma='+turma;
    var destino  = url_ajax+task+cpf+senha+id_turma;

    $.ajax({
        type:'GET',
        url:destino,
        success: function (data) {
			
			
			
            if (data!='erro' && data!='erro1') {
                mostra_dados( $.parseJSON(data));
				 waitingDialog.hide();
            } else {
	            if (data=='erro') {
	                var msg = 'Senha incorreta';
					 waitingDialog.show(msg);
					  setTimeout(function () { waitingDialog.hide(); }, 3000);
					  
					  
	            } else {
	                var msg = 'CPF não cadastrado';
					 waitingDialog.show(msg);
					  setTimeout(function () { waitingDialog.hide(); }, 3000);
				}
            }
        }
    });
}

// Função para exibir os dados na tela
function mostra_dados(data) {


$.each(data, function(key, v){
	
	if (v.COD_UF_ENTI!=0) {
	    document.getElementsByName("vinculo")[0].checked = true;
	    document.getElementsByName("vinculo")[1].checked = false;
		document.getElementById("instituicao").style.display = 'block';
		
    }
	

	
    $('#cod_entidade').val(v.COD_ENTI);
    $('#cod_aluno').val(v.COD_ALUNO);
    formata_cpf_recuperado('cpf_cadastrado',v.CPF);
    $('#password').val(v.PASSWORD);
    $('#confirme_password').val(v.PASSWORD);
	
	popula_pais(v.COD_PAIS);
    $('#nome').val(v.NOME);
 	$('#nome_social').val(v.NOME_SOCIAL);
	
	if(v.DT_NASCIMENTO != ""){
		var dt_nascimento = (v.DT_NASCIMENTO).toString();
		
		var ano = dt_nascimento.substring(0,4);
		var mes = dt_nascimento.substring(4,6);
		var dia = dt_nascimento.substring(6,8);
		dt_nascimento = dia+'/'+mes+'/'+ano;
		$('#dt_nascimento').val(dt_nascimento);
	}
	
    $('#sexo').val((v.SEXO).toString());
    popula_raca(v.COD_RACA);
    $('#email').val(v.EMAIL);
    $('#confirme_email').val(v.EMAIL);
    $('#endereco').val(v.ENDERECO);
    formata_cep_recuperado('cep',(v.CEP).toString());
    //$('#cep').val(v.cep);
    $('#formacao').val(v.FORMACAO);
	
	if(v.COD_UF_IBGE == null){
		
		v.COD_UF_IBGE =0;
		}
		
		if(v.COD_UF_ENTI == null){
		
		v.COD_UF_ENTI =0;
		}
		
		
		if(v.INSTITUICAO_ENSINO_UF == null){
		
		v.INSTITUICAO_ENSINO_UF =0;
		}
		
		if(v.INSTITUICAO_ENSINO_MUNICIPIO == null){
		
		v.INSTITUICAO_ENSINO_MUNICIPIO =0;
		}
	popula_uf((v.COD_UF_IBGE).toString());
	
    popula_municipio(v.COD_UF_IBGE,v.COD_MUNI_IBGE);
	popula_instituicao(v.tipoEnti);
    popula_uf_instituicao((v.COD_UF_ENTI).toString());
	popula_uf_instituicao_ensino((v.INSTITUICAO_ENSINO_UF).toString());
    popula_municipio_instituicao((v.COD_UF_ENTI).toString(), v.COD_MUNI_ENTI);
    popula_municipio_instituicao_nova(v.INSTITUICAO_ENSINO_UF,v.INSTITUICAO_ENSINO_MUNICIPIO);
	
	
	
	popula_pos(v.COD_POS);
    $('#pos').val(v.AREA_POS);
	$("#cod_escolaridade").val(v.COD_ESCOLARIDADE);
    
    popula_area(v.AREA_ATUACAO);
    if (newsletter) {
		document.getElementById('newsletter').checked = true;
	}
    $('#e_nome').val(v.E_NOME);
    $('#e_endereco').val(v.E_ENDERECO);
    formata_cep_recuperado('e_cep',v.E_CEP);
    //$('#e_cep').val(v.e_cep);
    $('#e_email').val(v.E_EMAIL);
    $('#e_www').val(v.E_WWW);
	$('#setor').val(v.SETOR);
    $('#cargo').val(v.CARGO);
	
	
    formata_telefone_recuperado('telefone_pessoal',v.TELEFONE_PESSOAL);
	//$('#telefone_pessoal').val(v.telefone_pessoal);
    formata_telefone_recuperado('telefone_entidade',v.TELEFONE_ENTIDADE);
	//$('#telefone_entidade').val(v.telefone_entidade);
	$('#expectativas').val(v.EXPECTATIVAS);
	$('#como_soube').val(v.COMO_SOUBE);
	$('#atuacao_bioma').val(v.ATUACAO_BIOMA);
	$('#atuacao').val();
	
	//Checa o bioma de acordo
	TemAtuacao_Check(v.TEM_ATUACAO_BIOMA)
	
	
	if (veracidade) {
		document.getElementById('veracidade').checked = true;
	}
	formata_cnpj_recuperado('e_cnpj',(v.E_CNPJ).toString());
    //$('#e_cnpj').val(v.e_cnpj);
    $('#ja_na_turma').val(v.ja_na_turma);
	
	if(v.ja_na_turma == 1){
    $('#ja_cadastrado').val(true);
	}else{
		    $('#ja_cadastrado').val(false);
		}

   
    $('#area_atuacao').val(v.AREA_ATUACAO);
    $('#selecao_como_soube').val(v.SELECAO_COMO_SOUBE);
	$('#efetivo').val(v.EFETIVO);

	if (atuacao=="1") { document.getElementsByName("atuacao")[0].checked = true;    }         // sim = 1
	if (atuacao=="0") { document.getElementsByName("atuacao")[1].checked = true;    }         // não = 0

// xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
	if (v.EFETIVO=="sim") { document.getElementsByName("efetivo")[0].checked = true;    }
	if (v.EFETIVO=="nao") { document.getElementsByName("efetivo")[1].checked = true;    }

    // alert(tipoenti) ;
    if ( (tipoenti==6) || (tipoenti==15) || (tipoenti==16) || (tipoenti==17) || (tipoenti==18) || (tipoenti==19) )  {
    		// alert("if") ;
            document.getElementById("efetivo_tipo1").style.display = 'none';
    		document.getElementById("efetivo_tipo2").style.display = 'none';
    		document.getElementById("efetivo_tipo3").style.display = 'none';
    	} else {
    		// alert("else") ;
    		document.getElementById("efetivo_tipo1").style.display = 'block';
    		document.getElementById("efetivo_tipo2").style.display = 'block';
    		document.getElementById("efetivo_tipo3").style.display = 'block';
    }
	
 popula_escolaridade(v.COD_ESCOLARIDADE);
	Mudarestadonomecurso(v.COD_ESCOLARIDADE);
	Mudarestadopos(v.COD_POS);

	$('#Nome_instituicao_Ensino').val(v.INSTITUICAO_ENSINO);
	$('#cod_uf_Intituicao').val(v.INSTITUICAO_ENSINO_UF);
	$('#cod_muni_Instituicao').val(v.INSTITUICAO_ENSINO_MUNICIPIO);
	$('#CNPJ_instituicao_Ensino').val(v.INSTITUICAO_ENSINO_CNPJ);
   
	
	if(v.INSTITUICAO_ENSINO != ""){
		$("#EstudaSim").prop("checked", true);
		$("#formulario_instituicao").show();
		}
	
	
	if(v.INSTITUICAO_ENSINO_CONCLUSAO){
	
	var conclusao = (v.INSTITUICAO_ENSINO_CONCLUSAO).toString();
	
	conclusao = conclusao.substring(0,2) + "/"+ conclusao.substring(2,6);
		$('#previsao').val(conclusao);
	}
	
	 if (v.ja_na_turma==true) {
        var msg = 'Você já está inscrito nesta turma. Os seus dados poderão ser atualizados.';
		 waitingDialog.show(msg);
		setTimeout(function () { waitingDialog.hide(); }, 5000);

    }else{
		
		$("#painel_dadospessoais").prop("display", "none");
		$("#btn_confirma_inscricao").prop("disabled", false);
		
		}
});

}
// xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
    // xxxxxxxxxxxx   block   ou none
    // alert('Cod_UF: '+cod_uf_enti);
	
    // if (cod_uf_enti!=0) {   alert('Cod_UF: '+cod_uf_enti);  }
    // alert('Cod_UF: '+cod_uf_enti);

   


// Função para mostra ou ocultar a div
function Mudarestado(opcao) {
		if (opcao=="m") {
			document.getElementById("instituicao").style.display = 'block';
		} else {
			document.getElementById("instituicao").style.display = 'none';
			LimpaCampos(true);
		}
}


function LimpaCampos(ok){

$("#e_nome").val("");
$("#e_endereco").val("");
$("#e_cep").val("");
$("#e_www").val("");
$("#e_cnpj").val("");
TratamentoDeCamposDadosProfissionais(ok);
$("#tipoenti").val(0);
$("#area_atuacao").val(0);
$("#cod_uf_enti").val(0);
$("#cod_muni_enti").val(0);
$("#setor").val("");
$("#cargo").val("");
$("#e_email").val("");
$("#telefone_entidade").val("");
$("#cod_entidade").val("");




}

/*
0	Não possuo pós graduação
1	Especialização Completa
2	Mestrado Completo
3	Doutorado Completo
4	Especialização Incompleta
5	Mestrado Incompleto
6	Doutorado Incompleto
*/
// Função para mostra ou ocultar a div Área da Pós Graduação
function Mudarestadopos(opcao) {
	
	var cod_estudo = opcao;
		
    if (cod_estudo > 0) {
		
		document.getElementById("EstudaAtualmente").style.display = 'block';
		document.getElementById("especifica_pos1").style.display = 'block';
		document.getElementById("especifica_pos2").style.display = 'block';
		
	
	
	} else{
		
		document.getElementById("especifica_pos1").style.display = 'none';
		document.getElementById("especifica_pos2").style.display = 'none';
		$("#pos").val('');
		LimparCamposDaInstituicao();
		
		
		
		}
	
	if( cod_estudo >= 0 & cod_estudo <= 3) {
				
				LimparCamposDaInstituicao();
		
	}
	
	
}


// Função para mostra ou ocultar a div Área da Pós Graduação

		/*1	Ensino fundamental incompleto
		2	Ensino fundamental completo
		3	Ensino médio incompleto
		4	Ensino médio completo
		5	Profissional de nível técnico incompleto
		6	Profissional de nível técnico completo
		7	Ensino superior incompleto
		8	Ensino superior completo*/
		
function Mudarestadonomecurso(opcao) {
  	var cod_estudo = document.getElementById('cod_escolaridade').value;

		  if (cod_estudo>='5')  {
				
			  document.getElementById("nomecurso1").style.display = 'block';
			  document.getElementById("nomecurso2").style.display = 'block';
			
		  }else{
			   document.getElementById("nomecurso1").style.display = 'none';
			  document.getElementById("nomecurso2").style.display = 'none';
			$("#formacao").val('');
			  
			  }
		// 	5	Profissional de nível técnico incompleto
		//  7	Ensino superior incompleto
			if (cod_estudo <='5' || cod_estudo=='7' )  {
					
					
					document.getElementById("cod_pos").style.display = 'none';
				//	document.getElementById("cod_pos_label").style.display = 'none';
					document.getElementById("especifica_pos1").style.display = 'none';
					document.getElementById("especifica_pos2").style.display = 'none';
					
			}
		
		if (cod_estudo =='5' || cod_estudo=='7' )  {
			document.getElementById("EstudaAtualmente").style.display = 'block';
		}else {
			
				
						LimparCamposDaInstituicao();
			}
		
		if (cod_estudo>='8')  {

			document.getElementById("cod_pos").style.display = 'block';
		
			
		}else{
			document.getElementById("cod_pos").style.display = 'none';
		
			}
			
			
	
}


function LimparCamposDaInstituicao(){
	
					document.getElementById("EstudaAtualmente").style.display = 'none';
					document.getElementById('EstudaSim').checked = false;
					
					$("#cod_uf_Intituicao").val(0);						
					$("#Nome_instituicao_Ensino").val("");
					$("#cod_muni_Instituicao").val(0);
					$("#CNPJ_instituicao_Ensino").val("");
					$("#previsao").val("");
					$("#formulario_instituicao").hide();
	
	}



// Função para mostrar ou ocultar a div
function Mudarefetivo(opc) {
  	var tipoenti_x = document.getElementById('tipoenti').value;
                // alert(tipoenti_x) ;
    if ((tipoenti_x==0 || tipoenti_x==6) || (tipoenti_x==15) || (tipoenti_x==16) || (tipoenti_x==17) || (tipoenti_x==18) || (tipoenti_x==19) )  {
    		// alert("if") ;
            document.getElementById("efetivo_tipo1").style.display = 'none';
    		document.getElementById("efetivo_tipo2").style.display = 'none';
    		document.getElementById("efetivo_tipo3").style.display = 'none';
    	} else {
    		// alert("else") ;
    		document.getElementById("efetivo_tipo1").style.display = 'block';
    		document.getElementById("efetivo_tipo2").style.display = 'block';
    		document.getElementById("efetivo_tipo3").style.display = 'block';
    }
	
/*	if(tipoenti_x ==1 || tipoenti_x==2){
		  TratamentoDeCamposDadosProfissionais(true);
		}else{*/
		 TratamentoDeCamposDadosProfissionais(false);
	//}
	
}

// Função para setar o efetivo como true na troca de opção
function Efetivo_Check(efetivo_check) {
            if(efetivo_check == "0")   {
                document.getElementsByName("efetivo")[0].value = true;
                document.getElementsByName("efetivo")[1].value = false;
            }
            if(efetivo_check == "1")   {
				
                document.getElementsByName("efetivo")[0].value = false;
                document.getElementsByName("efetivo")[1].value = true;
            }
}

// Função para setar o efetivo como true na troca de opção
function TemAtuacao_Check(atuacao_check) {
	
        if(atuacao_check == "0")   {

            document.getElementsByName("atuacao")[1].checked = true;
        }
        if(atuacao_check == "1")   {
            document.getElementsByName("atuacao")[0].checked = true;

        }
}

//Função para salvar os dados
function salva_meus_dados(turma) {

		 waitingDialog.show("Aguarde Realizando seu cadastro!");

        var efetivo00 ="";
        var efetivo_campo = document.getElementsByName("efetivo");
        if(efetivo_campo[0].checked == true)   {
            var efetivo00 = "sim";
        }
        if(efetivo_campo[1].checked == true)   {
            var efetivo00 = "nao";
        }
//        if(efetivo_campo[0].checked == true)   {  var efetivo00 = document.getElementsByName("efetivo")[0].value;  }
//        if(efetivo_campo[1].checked == true)   {  var efetivo00 = document.getElementsByName("efetivo")[1].value;  }
        var atuacao_campo = document.getElementsByName("atuacao");
        if(atuacao_campo[0].checked == true)   {
            var atuacao00 = "1";
        }
        if(atuacao_campo[1].checked == true)   {
            var atuacao00 = "0";
        }

	var erro=0;
	var id_turma = document.getElementById('id_turma').value;
	var cod_aluno = document.getElementById('cod_aluno').value;
	var ja_na_turma = document.getElementById('ja_na_turma').value;
	var ja_cadastrado = document.getElementById('ja_cadastrado').value;

	if (ja_cadastrado=='true') {
		var acao_aluno='&acao_aluno=atualiza_aluno';
	} else {
		var acao_aluno='&acao_aluno=incluir_aluno';
	}

	if (ja_na_turma=='true') {
		var msg = 'Você já está cadastrado nesta turma, seus dados serão atualizados........';
		 waitingDialog.show(msg);
					  setTimeout(function () { waitingDialog.hide(); }, 3000);
		var acao_turma='&acao_turma=atualizar_turma';
	} else {
		var acao_turma='&acao_turma=incluir_na_turma';
	}

	var erro_msg = '';
	if ($('#cpf_cadastrado').val().length < 14) {
		erro_msg=erro_msg+'O campo CPF é de preenchimento obrigatório.</br>';
		erro = 1;
	}
	if ($('#password').val().length < 5) {
		erro_msg=erro_msg+'O campo de SENHA deve ter no mínimo 5 caracteres e é obrigatório.</br>';
		erro = 1;
	}
	if ($('#confirme_password').val().length < 5) {
		erro_msg=erro_msg+'O campo de CONFIRMAÇÃO DE SENHA é obrigatório e deve conter no mínimo 5 caracteres.</br>';
		erro = 1;
	}
	if ($('#cod_pais').val().length < 1) {
		erro_msg=erro_msg+'A seleção de PAÍS é obrigatória.</br>';
		erro = 1;
	}
	if ($('#nome').val().length < 5) {
		erro_msg=erro_msg+'O campo NOME COMPLETO é de preenchimento obrigatório e deve conter no mínimo 5 caracteres</br>';
		erro = 1;
	}
	if ($('#dt_nascimento').val().length < 10) {
		erro_msg=erro_msg+'O campo DATA DE NASCIMENTO é de preenchimento obrigatório.</br>';
		erro = 1;
	}
//	if ($('#sexo').val().length < 1) {
//		erro_msg=erro_msg+'A seleção de sexo é obrigatória.</br>';
//		erro = 1;
//	}
	if ($('#telefone_pessoal').val().length < 13) {
		erro_msg=erro_msg+'O campo de TELEFONE é de preenchimento obrigatório, apenas números e deve conter o DDD com dois caracteres e o número no formato xxxx-xxxx ou xxxxx-xxxx.</br>';
		erro = 1;
	}
    if ($('#telefone_pessoal').val().length > 0) {
        xddd = $('#telefone_pessoal').val();
        xstr = xddd.substring(1, 2);
            if (xstr == 0) {
                erro_msg=erro_msg+'O DDD do TELEFONE PESSOAL não pode conter 0. Digite dois caracteres.</br>';
                erro = 1;
            }
    }
    if ($('#email').val().length < 8) {
		erro_msg=erro_msg+'O campo de E-MAIL é de preenchimento obrigatório  e deve conter no mínimo 8 caracteres.</br>';
		erro = 1;
	}
	if ($('#confirme_email').val().length < 8) {
		erro_msg=erro_msg+'O campo de CONFIRMAÇÃO DE E-MAIL é de preenchimento obrigatório e deve conter no mínimo 8 caracteres.</br>';
		erro = 1;
	}
	if ($('#endereco').val().length < 5) {
		erro_msg=erro_msg+'O campo de ENDEREÇO é de preenchimento obrigatório e deve conter no mínimo 5 caracteres.</br>';
		erro = 1;
	}
	if ($('#cep').val().length < 9) {
		erro_msg=erro_msg+'O campo CEP é de preenchimento obrigatório e deve conter 8 caracteres.</br>';
		erro = 1;
	}
	if ($('#cod_uf_ibge').val().length > 1) {
		if ($('#cod_muni_ibge').val().length < 1) {
			erro_msg=erro_msg+'A seleção de MUNICÍPIO é obrigatória.</br>';
			erro = 1;
		}
	}
	if ($('#cod_uf_ibge').val().length < 1) {
		erro_msg=erro_msg+'A seleção de ESTADO é obrigatória.</br>';
		erro = 1;
	}
	if ($('#cod_escolaridade').val().length < 1) {
		erro_msg=erro_msg+'A seleção de ESCOLARIDADE é obrigatória.</br>';
		erro = 1;
	}
	
	
	/**/
	
	if ($('#EstudaSim').is(":checked")) {
		if ($('#Nome_instituicao_Ensino').val().length == 0) {
			erro_msg=erro_msg+'A Instituição de Ensino é obrigatória.</br>';
			erro = 1;
			
			}	
			
    	if ($('#cod_uf_Intituicao').val() == "") {
			erro_msg=erro_msg+'Informe a UF da Instituição de Ensino .</br>';
			erro = 1;
				
			}	
			
	if ($('#cod_muni_Instituicao').val() == "") {
			erro_msg=erro_msg+'Informe o MUNICIPIO da Instituição de Ensino .</br>';
			erro = 1;
				
			}	
			
		}
	
	/*/*/
	
	
	if ($('#expectativas').val().length < 8) {
		erro_msg=erro_msg+'O campo de DESCRIÇÃO DE EXPECTATIVAS é de preenchimento obrigatório e deve conter no mínimo 8 caracteres.</br>';
		erro = 1;
	}
	if ($('#selecao_como_soube').val()==null || $('#selecao_como_soube').val().length < 1) {
		erro_msg=erro_msg+'A seleção "Como ficou sabendo do curso" é obrigatória.</br>';
		erro = 1;
	}
	if (($('#como_soube').val().length < 1) && ($('#selecao_como_soube').val() == 6)) {
		erro_msg=erro_msg+'O campo Outros/Especificar é obrigatório na seleção OUTROS.</br>';
		erro = 1;
	}
	if (document.getElementById('atuacao').checked) {
		if ($('#atuacao_bioma').val().length == 5) {
			erro_msg=erro_msg+'O campo "Qual?" é de preenchimento obrigatório.</br>';
			erro = 1;
		}
	}
	if (document.getElementById('vinculo').checked) {
		if ($('#tipoenti').val() == 0) {
			erro_msg=erro_msg+'O campo TIPO DE INSTITUIÇÃO é de preenchimento orbrigatório, caso não participe de nenhuma, selecione pessoa física.</br>';
			erro = 1;
		}
		if ($('#e_nome').val().length == 0) {
			erro_msg=erro_msg+'O campo "NOME DA INSTITUIÇÃO é de preenchimento obrigatório.</br>';
			erro = 1;
		}
		if ($('#setor').val().length == 0) {
			erro_msg=erro_msg+'O campo "SETOR" é de preenchimento obrigatório.</br>';
			erro = 1;
		}
		if ($('#cargo').val().length == 5) {
			erro_msg=erro_msg+'O campo "CARGO/FUNÇÃO" é de preenchimento obrigatório.</br>';
			erro = 1;
		}
		if ($('#area_atuacao').val() == 0) {
			erro_msg=erro_msg+'A seleção de ÁREA DE ATUAÇÃO é de preenchimento obrigatório.</br>';
			erro = 1;
		}
		if ($('#e_email').val().length < 8) {
			erro_msg=erro_msg+'O campo de E-MAIL PROFISSIONAL é de preenchimento obrigatório. </br>';
			erro = 1;
		}
		if ($('#telefone_entidade').val().length < 5) {
			erro_msg=erro_msg+'O campo TELEFONE PROFISSIONAL é de preenchimento obrigatório, apenas números e deve conter o DDD com dois caracteres e o número no formato xxxx-xxxx ou xxxxx-xxxx.</br>';
			erro = 1;
		}
		if ($('#telefone_entidade').val().length > 0) {
		    xddd = $('#telefone_entidade').val();
            xstr = xddd.substring(1, 2);
            if (xstr == 0) {
			    erro_msg=erro_msg+'O DDD do TELEFONE PROFISSIONAL não pode conter 0. Digite dois caracteres.</br>';
			    erro = 1;
            }
		}
		if ($('#cod_uf_enti').val().length >1)  {
			if ($('#cod_muni_enti').val() == "" )  {
				erro_msg=erro_msg+'A seleção de MUNICÍPIO DA INSTITUIÇÃO é obrigatória.</br>';
				erro = 1;
			}
		}
		if ($('#cod_uf_enti').val() == 0) {
			erro_msg=erro_msg+'A seleção de UF DA INSTITUIÇÃO é de preenchimento obrigatório.</br>';
			erro = 1;
		}
		

		if ($('#cod_entidade').val() != "" & $('#e_cnpj').val().length != 18) {
			
			erro_msg=erro_msg+'O campo CNPJ DA INSTITUIÇÃO é de preenchimento obrigatório.</br>';
			erro = 1;
		}
		
		if($('#e_cnpj').val().length > 4 & $('#e_cnpj').val().length < 18 ){
			erro_msg=erro_msg+'O campo CNPJ DA INSTITUIÇÃO é de preenchimento obrigatório.</br>';
			erro = 1;
			}
		
		if ($('#e_endereco').val().length < 5) {
			erro_msg=erro_msg+'O campo ENDEREÇO DA INSTITUIÇÃO é de preenchimento obrigatório e deve conter no mínimo 5 caracteres.</br>';
			erro = 1;
		}
		if ($('#e_cep').val().length < 8) {
			erro_msg=erro_msg+'O campo CEP DA INSTITUIÇÃO é de preenchimento obrigatório e deve conter no mínimo 5 caracteres.</br>';
			erro = 1;
		}

//	    var efetivo_campo = document.getElementsByName("efetivo");
//        if(efetivo_campo[0].checked == true)   {  var efetivo00 = document.getElementsByName("efetivo")[0].value;  }
//        if(efetivo_campo[1].checked == true)   {  var efetivo00 = document.getElementsByName("efetivo")[1].value;  }
		if ( ($('#tipoenti').val() != 6)  && ($('#tipoenti').val() != 15) && ($('#tipoenti').val() != 16) ) {
		    if ( ($('#tipoenti').val() != 17) && ($('#tipoenti').val() != 18) && ($('#tipoenti').val() != 19) )  {
                if ( (efetivo00 != "sim") && (efetivo00 != "nao") )  {
        			erro_msg=erro_msg+'É preciso selecionar o tipo de Servidor Efetivo - sim ou não.</br>';
        			erro = 1;
                }
            }
        }

	}

	if (erro==0) {
	    var cpf_cadastrado 		= '&cpf_cadastrado='+$('#cpf_cadastrado').val();
	    var password 			= '&password='+$('#password').val();
	    var confirme_password	= '&confirme_password='+$('#confirme_password').val();
		var tipoenti			= '&tipoenti='+$('#tipoenti').val();
		var cod_pais			= '&cod_pais='+$('#cod_pais').val();
	    var nome				= '&nome='+$('#nome').val();
	 	var nome_social			= '&nome_social='+$('#nome_social').val();
	 	var dt_nascimento		= $('#dt_nascimento').val();
	    dt_nascimento = dt_nascimento.substring(6,10)+dt_nascimento.substring(3,5)+dt_nascimento.substring(0,2)
	  	var dt_nascimento		= '&dt_nascimento='+dt_nascimento;
	    var sexo 				= '&sexo='+$('#sexo').val();
	    var cod_raca			= '&cod_raca='+$('#cod_raca').val();
	    var email 				= '&email='+$('#email').val();
	    var confirme_email		= '&confirme_email='+$('#confirme_email').val();
	    var endereco			= '&endereco='+$('#endereco').val();
	    var cep 				= '&cep='+$('#cep').val();
	    var formacao			= '&formacao='+$('#formacao').val();
	    var cod_entidade		= '&cod_entidade='+$('#cod_entidade').val();
	    var cod_uf_ibge			= '&cod_uf_ibge='+$('#cod_uf_ibge').val();
	    var cod_muni_ibge		= '&cod_muni_ibge='+$('#cod_muni_ibge').val();
	    var cod_uf_enti			= '&cod_uf_enti='+$('#cod_uf_enti').val();
	    var cod_muni_enti		= '&cod_muni_enti='+$('#cod_muni_enti').val();
	    var cod_pos				= '&cod_pos='+$('#cod_pos').val();
	    var pos					= '&pos='+$('#pos').val();
	    var cod_escolaridade	= '&cod_escolaridade='+$('#cod_escolaridade').val();
		if (document.getElementById('newsletter').checked) {
			newsletter=1;
		} else {
			newsletter=0;
		}
	    var newsletter			= '&newsletter='+newsletter;
	    var e_nome				= '&e_nome='+$('#e_nome').val();
	    var e_endereco			= '&e_endereco='+$('#e_endereco').val();
	    var e_cep				= '&e_cep='+$('#e_cep').val();
	    var e_email				= '&e_email='+$('#e_email').val();
	    var e_www				= '&e_www='+$('#e_www').val();
		var e_cnpj				= '&e_cnpj='+$('#e_cnpj').val();
		var telefone_pessoal	= '&telefone_pessoal='+$('#telefone_pessoal').val();
		var telefone_entidade	= '&telefone_entidade='+$('#telefone_entidade').val();
		var expectativas		= '&expectativas='+$('#expectativas').val();
		var como_soube			= '&como_soube='+$('#como_soube').val();
		var atuacao_bioma		= '&atuacao_bioma='+$('#atuacao_bioma').val();
		if (document.getElementById('veracidade').checked) {
			veracidade=1;
		} else {
			veracidade=0;
		}
		var veracidade			= '&veracidade='+veracidade;
		var id_turma			= '&id_turma='+id_turma;
		var cod_aluno			= '&cod_aluno='+cod_aluno;
		var setor				= '&setor='+$('#setor').val();
		var cargo				= '&cargo='+$('#cargo').val();
		var area_atuacao		= '&area_atuacao='+$('#area_atuacao').val();
//		var atuacao	            = '&atuacao='+$('#atuacao').val();
		var atuacao00           = '&atuacao='+atuacao00;
		var selecao_como_soube  = '&selecao_como_soube='+$('#selecao_como_soube').val();
//		var efetivo00           = '&efetivo='+$('#efetivo00').val();
		var efetivo00           = '&efetivo='+efetivo00;
		var ja_na_turma         = '&ja_na_turma='+ja_na_turma;
		var Nome_instituicao_Ensino       = '&Nome_instituicao_Ensino='+$('#Nome_instituicao_Ensino').val();
		var cod_uf_Intituicao   = '&cod_uf_Intituicao='+$('#cod_uf_Intituicao').val();
		var cod_muni_Instituicao   = '&cod_muni_Instituicao='+ $('#cod_muni_Instituicao').val();
		var CNPJ_instituicao_Ensino   = '&CNPJ_instituicao_Ensino='+$('#CNPJ_instituicao_Ensino').val();
		var previsao   			= '&previsao='+$('#previsao').val().replace("/","");
		var ID_USUARIO_LOG   	= '&ID_USUARIO_LOG='+$('#ID_USUARIO_LOG').val();
		var task				= 'cadastrar_aluno';

	    var destino  = url_ajax+task+acao_turma+acao_aluno+cpf_cadastrado+password+tipoenti+cod_pais+nome+nome_social+dt_nascimento+sexo+cod_raca+email+endereco+cep+formacao;
	    destino		 = destino+cod_uf_ibge+cod_muni_ibge+cod_uf_enti+cod_muni_enti+cod_pos+pos+cod_escolaridade+newsletter+e_nome+e_endereco+e_cep+e_email+e_www;
	    destino		 = destino+e_cnpj+telefone_pessoal+telefone_entidade+expectativas+como_soube+atuacao_bioma+veracidade+cod_aluno+id_turma;
	    destino		 = destino+setor+cargo+area_atuacao+atuacao00+selecao_como_soube+efetivo00+ja_na_turma;
		destino		 = destino+Nome_instituicao_Ensino+cod_uf_Intituicao+cod_muni_Instituicao+CNPJ_instituicao_Ensino+previsao+cod_entidade;

var res = encodeURI(destino);

// alert("Efetivo00: "+efetivo00)
// alert("Destino: "+destino);
// window.location.assign(destino);
// alert("ALERT: Acao_Aluno - "+acao_aluno)

	    $.ajax({
	        type:'GET',
//	        url:destino,
	        url:res,
	        success: function (data) {
	             waitingDialog.show("Dados gravados com sucesso!");
				if (acao_turma == "atualizar_turma") {
		            url_benvindo = 'dados_atualizados.asp?x=1'+cod_aluno+id_turma;
				} else {
		            url_benvindo = 'bem_vindo.asp?x=1'+cpf_cadastrado+id_turma;
	    	    }
				
				 waitingDialog.hide();
			    window.location.assign(url_benvindo);
            },
                error: function (xhr, ajaxOptions, thrownError) {
                var msg = xhr;
				 waitingDialog.show("Ops´, um erro ocorreu estão verificando, tente mais tarde por favor!");
				 setTimeout(function () { waitingDialog.hide(); }, 5000);
                }
	    });

	} else {
		var msg = erro_msg;
		 waitingDialog.show(msg);
		setTimeout(function () { waitingDialog.hide(); }, 5000);
	}
}


//Função para limpar os campos quando zerar o CPF
function cpf_vazio() {
	if ($('#cpf').val()=='') {
	    $('#cpf').val('');
	    $('#password').val('');
	    $('#confirme_password').val('');
		popula_instituicao(0);
		popula_pais(0);
	    $('#nome').val('');
	 	$('#nome_social').val('');
	  	$('#dt_nascimento').val('');
	    $('#sexo').val('');
	    popula_raca(0);
	    $('#email').val('');
	    $('#confirme_email').val('');
	    $('#endereco').val('');
	    $('#cep').val('');
	    $('#formacao').val('');
	    popula_uf(0);
	    popula_municipio(0,0);
	    popula_uf_instituicao(0);
	    popula_municipio_instituicao(0,0);
	    popula_pos(0);
	    $('#pos').val('');
	    popula_escolaridade(0);
	    popula_area(0);
	    $('#newsletter').val(0);
	    $('#e_nome').val('');
	    $('#e_endereco').val('');
	    $('#e_cep').val('');
	    $('#e_email').val('');
	    $('#e_www').val('');
		$('#telefone_pessoal').val('');
		$('#telefone_entidade').val('');
		$('#expectativas').val('');
		$('#como_soube').val('');
		$('#atuacao_bioma').val('');
		$('#veracidade').val('');
		$('#e_cnpj').val('');
		$('#setor').val('');
		$('#cargo').val('');
		$('#area_atuacao').val('');
		$('#atuacao').val('');
		$('#selecao_como_soube').val('');
		$('#fetivo').val('');
	}
}

// Função para exibir o dropdown de raça
function popula_raca(sel) {
    var task = 'popula_raca';
    var destino  = url_ajax+task+'&selecao='+sel;
    $.ajax({
        type:'GET',
        url:destino,
        success: function (data) {
            $('#cod_raca').html(data).show();
        }
    });
}



// FUnção par popular o dropdown de escolaridade
function popula_escolaridade(sel) {
    var task = 'popula_escolaridade';
    var destino  = url_ajax+task+'&selecao='+sel;

    $.ajax({
        type:'GET',
        url:destino,
        success: function (data) {
            $('#cod_escolaridade').html(data).show();
        }
    });
}

// FUnção par popular o dropdown de area de atuação
function popula_area(sel) {
    var task = 'popula_area';
    var destino  = url_ajax+task+'&selecao='+sel;

    $.ajax({
        type:'GET',
        url:destino,
        success: function (data) {
            $('#area_atuacao').html(data).show();
    		$('#tipoArea_Intituicao').html(data).show();
        }
    });
}

// Função para popular o dropdown de pos-graduação
function popula_pos(sel) {
    var task 	 = 'popula_pos';
    var destino  = url_ajax+task+'&selecao='+sel;

    $.ajax({
        type:'GET',
        url:destino,
        success: function (data) {
            $('#cod_pos').html(data);
        }
    });
}

// Função para popular o dropdown de tipo de instituições
function popula_instituicao(sel) {
    var task 	 = 'popula_instituicao';
    var destino  = url_ajax+task+'&selecao='+sel;
    $.ajax({
        type:'GET',
        url:destino,
        success: function (data) {
            $('#tipoenti').html(data).show();
			$('#tipoenti_Intituicao').html(data).show();
        }
    });
}

// Função para popular o dropdown de Paises
function popula_pais(sel) {
    var task = 'popula_pais';
    var destino  = url_ajax+task+'&selecao='+sel;

    $.ajax({
        type:'GET',
        url:destino,
        success: function (data) {
            $('#cod_pais').html(data).show();
        }
    });
}

// Função para popular o dropdown de Unidades da Federação
function popula_uf_instituicao(sel) {
    var task = 'popula_uf';
    var destino  = url_ajax+task+'&selecao='+sel;

    $.ajax({
        type:'GET',
        url:destino,
        success: function (data) {
            $('#cod_uf_enti').html(data);

		 }
    });
}

function popula_uf_instituicao_ensino(sel) {
    var task = 'popula_uf';
    var destino  = url_ajax+task+'&selecao='+sel;

    $.ajax({
        type:'GET',
        url:destino,
        success: function (data) {
          
            $('#cod_uf_Intituicao').html(data);
		 }
    });
}


// Função para popular o dropdown de Municipios, dependente do dropdown de unidades da federação
function popula_municipio_instituicao(uf,muni) {
    var task 	 = 'popula_municipio';
    var destino  = url_ajax+task+'&uf='+uf+'&municipio='+muni;

    $.ajax({
        type:'GET',
        url:destino,
        success: function (data) {
            $('#cod_muni_enti').html(data).show();
			
		
        }
    });
}

function popula_municipio_instituicao_nova(uf,muni) {
    var task 	 = 'popula_municipio';
    var destino  = url_ajax+task+'&uf='+uf+'&municipio='+muni;

    $.ajax({
        type:'GET',
        url:destino,
        success: function (data) {

			$('#cod_muni_Instituicao').html(data).show();
        }
    });
}

// Função para popular o dropdown de Unidades da Federação
function popula_uf(sel) {
    var task = 'popula_uf';
    var destino  = url_ajax+task+'&selecao='+sel;

    $.ajax({
        type:'GET',
        url:destino,
        success: function (data) {
            $('#cod_uf_ibge').html(data).show();
        }
    });
}

// Função para popular o dropdown de Municipios, dependente do dropdown de unidades da federação
function popula_municipio(uf,muni) {
    var task 	 = 'popula_municipio';
    var destino  = url_ajax+task+'&uf='+uf+'&municipio='+muni;

    $.ajax({
        type:'GET',
        url:destino,
        success: function (data) {
            $('#cod_muni_ibge').html(data).show();
        }
    });
}


//Função para validar CPF
function valida_cpf(num_cpf) {
	
    var parte1 = num_cpf.substr(0,3);
    var parte2 = num_cpf.substr(4,3);
    var parte3 = num_cpf.substr(8,3);
    var str_partes = parte1 + parte2 + parte3;
    str_partes = str_partes.toString();
    var dig_fim = num_cpf.substr(12,2);
    var soma_dig1 = 0;
    var soma_dig2 = 0;
    var cont = 0;
    var tamanho =  str_partes.length;
    
    for (cont = 1; cont <= tamanho; cont++) {
        soma_dig1 = soma_dig1 + parseInt(str_partes.substr(cont-1,1)) * (11 - cont);
        soma_dig2 = soma_dig2 + parseInt(str_partes.substr(cont-1,1)) * (12 - cont);
    }
    var dig1=0;
    var dig2=0;

    var p_dig1 = soma_dig1%11;
    if (p_dig1==0 || p_dig1==1) { dig1=0 } else { dig1 = 11 - p_dig1 }

    var p_dig2 = soma_dig2 + (dig1 * 2);
    p_dig2 = p_dig2%11;
    
    if (p_dig2==0 || p_dig2==1) { dig2=0 } else { dig2 = 11 - p_dig2 }
    var dig_calculado = dig1.toString() + dig2.toString();
    
    if (parseInt(dig_fim) == parseInt(dig_calculado)) {
        return true;
    } else {
        return false;
    }
}

// Fução para validar CNPJ
function valida_cnpj(num_cnpj) {
    var parte1  = num_cnpj.substr(0,2);
    var parte2  = num_cnpj.substr(3,3);
    var parte3  = num_cnpj.substr(7,3);
    var parte4  = num_cnpj.substr(11,4);
    var str_partes = parte1 + parte2 + parte3 + parte4;
    str_partes = str_partes.toString();
    var dig_fim = num_cnpj.substr(16,2);
    var soma_dig1 = 0;
    var soma_dig2 = 0;
    var cont = 0;
    var tamanho = str_partes.length;
    var temp = 0;
    var dig1 = 0;
    var dig2 = 0;
    
    for (cont = 1; cont <= tamanho; cont++) {
        if (cont < 5) { temp = 6 - cont } else { temp = 14 - cont}
        soma_dig1 = soma_dig1 + parseInt(str_partes.substr(cont-1,1)) * temp;
        if (cont < 6) { temp = 7 - cont } else { temp = 15 - cont}
        soma_dig2 = soma_dig2 + parseInt(str_partes.substr(cont-1,1)) * temp;
    }
    var p_dig1 = soma_dig1%11;
    if (p_dig1==0 || p_dig1==1) { dig1 = 0 } else { dig1 = 11 - p_dig1 }
    
    var p_dig2 = soma_dig2 + (dig1 * 2);
    p_dig2 = p_dig2%11;
    if (p_dig2 == 0 || p_dig2 == 1) { dig2 = 0 } else { dig2 = 11 - p_dig2 }
    var dig_calculado = dig1.toString() + dig2.toString();
    
    if (parseInt(dig_fim) == parseInt(dig_calculado)) {
        return true;
    } else {
        return false;
    }
}

// Função para ajuste de picture de data
function formata_data(campo,dado,destino,event) {
	var x = event.keyCode;
	if (x!=8) {
	    if (dado.length==2) {
	        dado = dado+'/';
	    }
	    if (dado.length==5) {
	        dado = dado+'/';
	    }
	    document.getElementById(campo).value = dado;
    }
    if (dado.length == 10) {
       document.getElementById(destino).focus();
	}
}

// Função para ajuste de picture de telefone
function formata_telefone(campo,dado,event) {
	if (dado.length == 1 && dado == '0') {
		dado = '';
	    document.getElementById(campo).value = dado;
	} else {
		var x = event.keyCode;
		if (x!=8) {
		    dado = dado.replace("-","");
	        dado = dado.replace("(","");
	        dado = dado.replace(")","");
		    if (dado.length==11)  {  dado = '('+dado.substring(0,2)+')'+dado.substring(2,7)+'-'+dado.substring(7,11);  }
		    if (dado.length==10)  {  dado = '('+dado.substring(0,2)+')'+dado.substring(2,6)+'-'+dado.substring(6,10);  }
		    if (dado.length==9)   {  dado = '('+dado.substring(0,2)+')'+dado.substring(2,6)+'-'+dado.substring(6,10);  }
		    if (dado.length==8)   {  dado = '('+dado.substring(0,2)+')'+dado.substring(2,6)+'-'+dado.substring(6,10);  }
		    if (dado.length==7)   {  dado = '('+dado.substring(0,2)+')'+dado.substring(2,6)+'-'+dado.substring(6,10);  }
		    if (dado.length==6)   {  dado = '('+dado.substring(0,2)+')'+dado.substring(2,6)+'-';   }
		    if (dado.length==5)   {  dado = '('+dado.substring(0,2)+')'+dado.substring(2,5);  }
		    if (dado.length==4)   {  dado = '('+dado.substring(0,2)+')'+dado.substring(2,4);  }
		    if (dado.length==3)   {  dado = '('+dado.substring(0,2)+')'+dado.substring(2,3);  }
		    if (dado.length==2)   {  dado = '('+dado+')';     }
		    if (dado.length==1)   {  dado = '('+dado;  	    }
		    document.getElementById(campo).value = dado;
	    }
	}
}

function corrige_traco(campo,dado,event) {
	if (dado.length==0) {
	} else {
		if (dado.length!=14) {
			dado = dado.replace("-","");
			dado = dado.substring(0,8)+'-'+dado.substring(8,13);
			document.getElementById(campo).value = dado;
		}	
	}
}

// Função para ajuste de picture de cep
function formata_cep(campo,dado,event) {
	var x = event.keyCode;
	if (x!=8) {
	    if (dado.length==5) {
	        dado = dado+'-';
	    }
	    document.getElementById(campo).value = dado;
    }
}

// Função para ajuste de picture de cpf
function formata_cpf_digitado(campo,dado,destino,event) {
/*
    var e = event.keyCode || e.which;
    alert("Var e: "+e);
    var y = String.fromCharCode(event.keyCode);
    alert("Char y "+y);
*/
	var x = event.keyCode;

	if (x!=8) {
	    if (dado.length==3) {
	        dado = dado + '.';
	        document.getElementById(campo).value = dado;
	    }
	    if (dado.length==7) {
	        dado = dado + '.';
	        document.getElementById(campo).value = dado;
	    }
	    if (dado.length==11) {
	        dado = dado + '-';
	        document.getElementById(campo).value = dado;
	    }
	    if (dado.length == 14) {
	        var cpf_valido = valida_cpf(dado);
	        
	        if (cpf_valido) {
	            document.getElementById(destino).focus();
	        } else {
	            var msg = "CPF inválido";
				 waitingDialog.show(msg);
			     setTimeout(function () { waitingDialog.hide(); }, 3000);
	            document.getElementById(campo).focus();
	            document.getElementById(campo).value = "";
	        }
	    }
    }
}



function SomenteNumero(e){
    var tecla=(window.event)?event.keyCode:e.which;   
    if((tecla>47 && tecla<58)) return true;
	
    else{
    	if (tecla==8 || tecla==0) return true;
	else  return false;
    }
}

// Função para ajuste de picture de cnpj
function formata_cnpj_digitado(campo,dado,destino,event) {
	var x = event.keyCode;
	
	
	if (x!=8) {

	    if (dado.length==2) {
	        dado = dado + '.'; 
	        document.getElementById(campo).value = dado;
	    }
	    if (dado.length==6) {
	        dado = dado + '.'; 
	        document.getElementById(campo).value = dado;
	    }
	    if (dado.length==10) { 
	        dado = dado + '/';
	        document.getElementById(campo).value = dado;
	    }
	    if (dado.length==15) { 
	        dado = dado + '-';
	        document.getElementById(campo).value = dado;
	    }
	    if (dado.length == 18) {
	        var cnpj_valido = valida_cnpj(dado);
	        
	        if (cnpj_valido) {
	            document.getElementById(destino).focus();
	        } else {
				
	           

  				 waitingDialog.show("CNPJ inválido");
			    setTimeout(function () { waitingDialog.hide(); }, 3000);
				
				 document.getElementById(campo).value = "";
	            document.getElementById(campo).focus();

	        }
	    }
	}	 
	
	
}

// Função para ajuste de picture de cpf
function formata_cpf_recuperado(campo,dado,event) {
	
	if(dado != "" & dado != null){
    var cpf_recuperado = dado.substring(0,3)+'.'+dado.substring(3,6)+'.'+dado.substring(6,9)+'-'+dado.substring(9,11);
    document.getElementById(campo).value = cpf_recuperado;
	document.getElementById(campo).disabled = "true";
	}
}

// Função para ajuste de picture de cnpj
function formata_cnpj_recuperado(campo,dado) {
    var cnpj_recuperado = dado.substring(0,2)+'.'+dado.substring(2,5)+'.'+dado.substring(5,8)+'/'+dado.substring(8,12)+'-'+dado.substring(12,14);
    document.getElementById(campo).value = cnpj_recuperado;
	
	
}

// Função para ajuste de picture de cep
function formata_cep_recuperado(campo,dado) {
    var cep_recuperado = dado.substring(0,5)+'-'+dado.substring(5,8);
    document.getElementById(campo).value = cep_recuperado;
}

// Função para ajuste de picture de telefone
function formata_telefone_recuperado(campo,dado) {
	
	
	var t = dado.length;
	if (dado.substring(0,1) == '0') {
		dado = dado.substring(1,t);
	}
	var t = dado.length;
	if (t==10) {
    	var tel_recuperado = '('+dado.substring(0,2)+')'+dado.substring(2,6)+'-'+dado.substring(6,10);
	} else {
    	var tel_recuperado = '('+dado.substring(0,2)+')'+dado.substring(2,7)+'-'+dado.substring(7,11);
	}	
    document.getElementById(campo).value = tel_recuperado;
}

function formataDataMesAno(){

var valor = $("#")	
}

// Função para listar as turmas da página inicial
function doListaTurmas() {
    var programa = 'mob_lista_turmas.asp';
    var destino  = url_ajax+programa;
    
    $.ajax({
        type:'GET',
        url:destino,
        success: function (data) {
            $('#Col_turmas_1').html(data).show();
        }
    });
}

// Função para coleta de informações pagina de todas as informações do curso
function doFullInfo(id) {
    var programa = 'mob_fullinfo.asp?id='+id;
    var destino  = url_ajax+programa;
    
    $.ajax({
        type:'GET',
        url:destino,
        success: function (data) {
            $('#grid_1').html(data).show();
        }
    });
}

// Função para troca de senha
function troca_senha() {
    var programa = 'mob_troca_senha.asp';
    var cpf_trocasenha      = $("#cpf_trocasenha").val();
    cpf_trocasenha          = cpf_trocasenha.replace(".","");
    cpf_trocasenha          = cpf_trocasenha.replace(".","");
    cpf_trocasenha          = cpf_trocasenha.replace("-","");
    cpf_trocasenha          = '?cpf='+cpf_trocasenha;
    var senhaatual_troca    = '&PASSWORD='+$("#senhaatual_troca").val();  
    var senha_troca         = '&PASSWORD1='+$("#senha_troca").val();
    var confirme_troca      = '&PASSWORD2='+$("#confirme_troca").val();
    
    var destino  = url_ajax+programa+cpf_trocasenha+senhaatual_troca+senha_troca+confirme_troca;
    
    $.ajax({
        type:'GET',
        url:destino,
        success: function (data) {
            var msg = "Atenção: "+data;
			 waitingDialog.show(msg);
			    setTimeout(function () { waitingDialog.hide(); }, 3000);
        }
    });
    
    $("#cpf_trocasenha").val('');
    $("#senhaatual_troca").val(''); 
    $("#senha_troca").val('');
    $("#confirme_troca").val('');
    
    activate_page("#mainpage"); 
}


function pesquisa_por_cnpj(){
	
	var e_cnpj = $("#e_cnpj").val();
	e_cnpj = e_cnpj.replace('.','');
	e_cnpj = e_cnpj.replace('.','');
	e_cnpj = e_cnpj.replace('/','');
	e_cnpj = e_cnpj.replace('-','');
	
	if(Object.keys(e_cnpj).length == 14 )
	
	Carrega_Entidade();
	}
	
	
// // Função para Popular Dados da Entidade
function Carrega_Entidade() {
	
	tipo_entidade = $("#tipoenti").val();
	cod_entidade = $("#cod_entidade").val();
	var e_cnpj = $("#e_cnpj").val();
	e_cnpj = e_cnpj.replace('.','');
	e_cnpj = e_cnpj.replace('.','');
	e_cnpj = e_cnpj.replace('/','');
	e_cnpj = e_cnpj.replace('-','');
	

	if( cod_entidade != 0 ||  Object.keys(e_cnpj).length == 14 ||
	((tipo_entidade == 1 || tipo_entidade == 2) & ($("#cod_uf_enti").val() != "" &   $("#cod_muni_enti").val() != ""))){
	
	   var COD_UF_IBGE = "cod_uf_enti=" + $("#cod_uf_enti").val();
       var COD_MUNI_IBGE = "&cod_muni_enti=" + $("#cod_muni_enti").val(); 
	   var ID_TIPO_ENTIDADE ="&tipoenti=" + $("#tipoenti").val(); 
   	   var DESCRICAO ="&DESCRICAO=" + $("#e_nome").val(); 
	   var cod_entidade ="&COD_ENTI=" + cod_entidade; 
	   var cnpj ="&cnpj=" + e_cnpj.replace(".","").replace("-","").replace("/",""); 
	
    var task = 'popula_instituicao_dados&';

    var destino  = url_ajax+task+COD_UF_IBGE+COD_MUNI_IBGE+ID_TIPO_ENTIDADE+DESCRICAO+cnpj+cod_entidade;
    $.ajax({
        type:'GET',
        url:destino,
		dataType:'json',
        success: function (data) {
	       if(data != ""){
		   
     	   var count = Object.keys(data).length;
			 if(count == 0){
				    $("#e_nome").val("").prop("disabled", false);
					   $("#e_endereco").val("").prop("disabled", false);
					   $("#e_cep").val("").prop("disabled", false);
					   $("#e_www").val("").prop("disabled", false);
					   $("#e_cnpj").val("").prop("disabled", false);
    				   $("#cod_entidade").val("0");
					  
				 }
			   else if(count > 1){
				     var umHtml = "<ul>";
					$.each(data, function(key, value){				   
							var auto = "auto_" + value.COD_ENTI
						   umHtml = umHtml + " <li id='" + auto + "'>";
						   umHtml = umHtml + "<a href='#' onclick='selecionar("+ value.COD_ENTI +"); return false;' class='instituicoes' id="+ auto + "> Nome: "+ value.NOME + " - "+ value.ENDERECO +"</a></li>"
					});
					
					   umHtml = umHtml + "</ul>"
				   	
				   waitingDialog.show(umHtml);

				   }else{
			   
					$.each(data, function(key, value){
					   $("#e_nome").val(value.NOME).prop("disabled", true);
					   $("#e_endereco").val(value.ENDERECO).prop("disabled", true);
					   $("#e_cep").val(value.CEP).prop("disabled", true);
					   $("#e_www").val(value.WWW).prop("disabled", true);
					   $("#e_cnpj").val(value.EMPPRIV_CNPJ).prop("disabled", true);
					  $("#cod_entidade").val(value.COD_ENTI).prop("disabled", true);
					  $("#e_cnpj").mask("99.999.999/9999-99");
					 
					  
					   });
		 			  }
		  	 }
		}
    });
	
	}
}


function Carrega_Entidade_AutoComplete() {
	
var umaLista = "";
	
	
	  var COD_UF_IBGE = "cod_uf_enti=" + $("#cod_uf_enti").val();
      var COD_MUNI_IBGE = "&cod_muni_enti=" + $("#cod_muni_enti").val(); 
	  var ID_TIPO_ENTIDADE ="&tipoenti=" + $("#tipoenti").val(); 
   	  var DESCRICAO ="&DESCRICAO=" + $("#e_nome").val(); 
	  
	  if($("#e_nome").val().length > 3){
	
    var task = 'popula_instituicao_dados&';
	
    var destino  = url_ajax+task+COD_UF_IBGE+COD_MUNI_IBGE+ID_TIPO_ENTIDADE+DESCRICAO;
    
    $.ajax({
        type:'GET',
        url:destino,
		dataType:'json',
        success: function (data) {
	       if(data != ""){
			  
			  
 			var umHtml = "";
			  umHtml = "<ul>"
		
		$.each(data, function(key, value){
				
				var auto = "auto_" + value.COD_ENTI
			       umHtml = umHtml + " <li id='" + auto + "'>";
		           umHtml = umHtml + "<a href='#painel_dadosdainstituicao' onclick='selecionar(" + value.COD_ENTI + ");'>Nome: "+ value.NOME + " End: "+ value.ENDERECO +"</a></li>";
			
			   });

			   umHtml = umHtml + "</ul>";
			   $("#complete").html("")
    			$("#complete").append(umHtml).removeAttr("class", "collapsed").attr("class","alert-info Expanded");

			  

		   }else{
			   $("#complete").html("")
   			$("#complete").append(umHtml).removeAttr("class", "alert-info Expanded").attr("class","collapsed");
			   
			   }
        }
	
		
    });
	
	  }
}


function selecionar(valor){
	
	$("#cod_entidade").val(valor);
	$("#complete").removeAttr("class", "alert-info Expanded").attr("class","collapsed");
	Carrega_Objeto_Entidade();
	waitingDialog.hide();
	$("#cod_entidade").focus();
	
	}

	
	function ValidaEmail(campo){
		
		var sEmail	= campo;
		// filtros
		var emailFilter=/^.+@.+\..{2,}$/;
		var illegalChars= /[\(\)\<\>\,\;\:\\\/\"\[\]]/
		// condição
		if(!(emailFilter.test(sEmail))||sEmail.match(illegalChars)){
			   waitingDialog.show('Por favor, informe um email válido.');
			    setTimeout(function () { waitingDialog.hide(); }, 3000);
		}
	}
	
	
	
	
// // Função para Popular Dados da Entidade
function Carrega_Objeto_Entidade() {
	
	
	cod_entidade = $("#cod_entidade").val();
	

	if( cod_entidade != "" ){
	
	   var cod_entidade ="COD_ENTI=" + cod_entidade; 
	
    var task = 'popula_instituicao_dados&';

    var destino  = url_ajax+task+cod_entidade;
    $.ajax({
        type:'GET',
        url:destino,
		dataType:'json',
        success: function (data) {
	       if(data != ""){
		
					$.each(data, function(key, value){
					   $("#e_nome").val(value.NOME).prop("disabled", true);
					   $("#e_endereco").val(value.ENDERECO).prop("disabled", true);
					   $("#e_cep").val(value.CEP).prop("disabled", true);
					   $("#e_www").val(value.WWW).prop("disabled", true);
					   formata_cnpj_recuperado('e_cnpj',value.EMPPRIV_CNPJ);
					   $("#e_cnpj").prop("disabled", true);
					  $("#cod_entidade").val(value.COD_ENTI);
					  
					   });
		 			  }
				}
    });
	
	}
}

function TratamentoDeCamposDadosProfissionais(desativa){
	

	
   $("#e_nome").prop("disabled", desativa);
   $("#e_endereco").prop("disabled", desativa);
   $("#e_cep").prop("disabled", desativa);
   $("#e_www").prop("disabled", desativa);
   $("#e_cnpj").prop("disabled", desativa);

	
	}