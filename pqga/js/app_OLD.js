var url_ajax = 'http://cursos.ibam.org.br/pqga/funcoes.asp?task=';

// Função para abrir a pagina para envio de senha por email
function esqueci_senha() {
	myVar=open('esqueci.asp','Senha','scrollbars=yes,width=300,height=140');
}

// Função popular os campos iniciais
function inicio() {
	document.getElementById("instituicao").style.display = 'none';
	popula_raca(0);
    popula_pos(0);
    popula_escolaridade(0);
    popula_instituicao(0);
    popula_pais(0);
    popula_uf(0);
    popula_uf_instituicao(0);
    popula_area(0);

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
    
    // Fim
}

//Função para comparar dados iguais
function dados_iguais(campo1,campo2,proximocampo,titulo) {
	if(document.getElementById(campo1).value==document.getElementById(campo2).value) {
		document.getElementById(proximocampo).focus();
	} else {
		mensagem='Os campos '+titulo+' e Confirme '+titulo+' estão difentes';
		alert("Mensagem: "+mensagem);
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
	            alert('Atenção: Observamos em nosso cadastrado que você já participou de cursos no IBAM. Sendo assim, por favor, digite seu CPF e senha na caixa acima. Caso tenha esquecido sua senha, clique no botão "esqueci minha senha"');
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
                mostra_dados(data);
            } else {
	            if (data=='erro') {
	                alert('Senha incorreta');
	            } else {
	                alert('CPF não cadastrado');
				}            
            }
        }
    });
}

// Função para exibir os dados na tela
function mostra_dados(data) {
	var res = data.split('|');

	var cod_aluno 			= res[0];
	if (cod_aluno==null) { cod_aluno=0 }
	var cpf		  			= res[1];
	if (cpf==null) { cpf="" }
	var password			= res[2];
	if (password==null) { password="" }
	var tipoenti			= res[3];
	if (tipoenti==null) { tipoenti=0 }
	var cod_pais			= res[4];
	if (cod_pais==null) { cod_pais=0 }
	var nome				= res[5];
	if (nome==null) { nome="" }
	var dt_nascimento		= res[6];
	if (dt_nascimento==null) { dt_nascimento=0 }
	var sexo				= res[7];
	if (sexo==null) { sexo=0 }
	var cod_raca			= res[8];
	if (cod_raca==null) { cod_raca=0 }
	var email				= res[9];
	if (email==null) { email="" }
	var endereco			= res[10];
	if (endereco==null) { endereco="" }
	var cep					= res[11];
	if (cep==null) { cep="" }
	var formacao			= res[12];
	if (formacao==null) { formacao=0 }
	var cod_uf_ibge			= res[13];
	if (cod_uf_ibge==null) { cod_uf_ibge=0 }
	var cod_muni_ibge		= res[14];
	if (cod_muni_ibge==null) { cod_muni_ibge=0 }
	var cod_uf_enti			= res[15];
	if (cod_uf_enti==null) { cod_uf_enti=0 }
	var cod_muni_enti		= res[16];
	if (cod_muni_enti==null) { cod_muni_enti=0 }
	var cod_pos				= res[17];
	if (cod_pos==null) { cod_pos=0 }
	var pos					= res[18];
	if (pos==null) { pos="" }
	var cod_escolaridade	= res[19];
	if (cod_escolaridade==null) { cod_escolaridade=0 }
	var newsletter			= res[20];
	if (newsletter==null) { newsletter=0 }
	var e_nome				= res[21];
	if (e_nome==null) { e_nome="" }
	var e_cnpj				= res[22];
	if (e_cnpj==null) { e_cnpj="" }
	var e_endereco			= res[23];
	if (e_endereco==null) { e_endereco="" }
	var e_cep				= res[24];
	if (e_cep==null) { e_cep="" }
	var e_email				= res[25];
	if (e_email==null) { e_email="" }
	var e_www				= res[26];
	if (e_www==null) { e_www="" }
	var nome_social			= res[27];
	if (nome_social==null) { nome_social="" }
	var	telefone_pessoal	= res[28];
	if (telefone_pessoal==null) { telefone_pessoal="" }
	var telefone_entidade	= res[29];
	if (telefone_entidade==null) { telefone_entidade="" }
	var expectativas		= res[30];
	if (expectativas==null) { expectativas="" }
	var como_soube			= res[31];
	if (como_soube==null) { como_soube=0 }
	var atuacao_bioma		= res[32];
	if (atuacao_bioma==null) { atuacao_bioma=0 }
	var veracidade			= res[33];
	if (veracidade==null) { veracidade=0 }
	var setor				= res[34];
	if (setor==null) { setor="" }
	var cargo				= res[35];
	if (cargo==null) { cargo="" }
	var area_atuacao		= res[36];
	if (area_atuacao==null) { area_atuacao=0 }
	var atuacao	= res[37];
	if (atuacao==null) { atuacao="off" }
	if (atuacao=="") { atuacao="off" }
	var selecao_como_soube  = res[38];
	if (selecao_como_soube==null) { selecao_como_soube=0 }
	var ja_na_turma			= res[39];

    $('#cod_aluno').val(cod_aluno);
    formata_cpf_recuperado('cpf_cadastrado',cpf);
    $('#password').val(password);
    $('#confirme_password').val(password);
	popula_instituicao(tipoenti);
	popula_pais(cod_pais);
    $('#nome').val(nome);
 	$('#nome_social').val(nome_social);
 	dt_nascimento = dt_nascimento.substring(8,10)+'/'+dt_nascimento.substring(5,7)+'/'+dt_nascimento.substring(0,4)
  	$('#dt_nascimento').val(dt_nascimento);
    $('#sexo').val(sexo);
    popula_raca(cod_raca);
    $('#email').val(email);
    $('#confirme_email').val(email);
    $('#endereco').val(endereco);
    $('#cep').val(cep);
    $('#formacao').val(formacao);
    popula_uf(cod_uf_ibge);
    popula_municipio(cod_uf_ibge,cod_muni_ibge);
    popula_uf_instituicao(cod_uf_enti);
    popula_municipio_instituicao(cod_uf_enti,cod_muni_enti);
    popula_pos(cod_pos);
    $('#pos').val(pos);
    popula_escolaridade(cod_escolaridade);
    popula_area(area_atuacao);
    if (newsletter) {
		document.getElementById('newsletter').checked = true;
	}
    $('#e_nome').val(e_nome);
    $('#e_endereco').val(e_endereco);
    $('#e_cep').val(e_cep);
    $('#e_email').val(e_email);
    $('#e_www').val(e_www);
	$('#telefone_pessoal').val(telefone_pessoal);
	$('#telefone_entidade').val(telefone_entidade);
	$('#expectativas').val(expectativas);
	$('#como_soube').val(como_soube);
	$('#atuacao_bioma').val(atuacao_bioma);

	if (veracidade) {
		document.getElementById('veracidade').checked = true;
	}
    $('#e_cnpj').val(e_cnpj);
    $('#ja_na_turma').val(ja_na_turma);
    $('#ja_cadastrado').val('true');

    $('#setor').val(setor);
    $('#cargo').val(cargo);
    $('#atuacao').val(atuacao);
    $('#selecao_como_soube').val(selecao_como_soube);

    if (ja_na_turma==true) {
        alert('Você já está inscrito nesta turma. Os seus dados poderão ser atualizados.');
    }
}

// Função para mostra ou ocultar a div
function Mudarestado(opcao) {
    if (opcao=="m") {
		document.getElementById("instituicao").style.display = 'block';
	} else {
		document.getElementById("instituicao").style.display = 'none';
	}
}
// Função para mostra ou ocultar a div Área da Pós Graduação
function Mudarestadopos(opcao) {
    if (opcao=="m" && $('#cod_pos').val()>0) {
		document.getElementById("especifica_pos1").style.display = 'block';
		document.getElementById("especifica_pos2").style.display = 'block';
	} else {
		document.getElementById("especifica_pos1").style.display = 'none';
		document.getElementById("especifica_pos2").style.display = 'none';
	}
}

// Função para mostra ou ocultar a div Área da Pós Graduação
function Mudarestadonomecurso(opcao) {
  	var cod_estudo = document.getElementById('cod_escolaridade').value;

    if (cod_estudo=='7' || cod_estudo=='8')  {
        if (opcao=="m") {
    		document.getElementById("nomecurso1").style.display = 'block';
    		document.getElementById("nomecurso2").style.display = 'block';
    	} else {
    		document.getElementById("nomecurso1").style.display = 'none';
    		document.getElementById("nomecurso2").style.display = 'none';
    	}
    }
}

//Função para salvar os dados
function salva_meus_dados(turma) {
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
		alert('Você já está cadastrado nesta turma, seus dados serão atualizados');
		var acao_turma='&acao_turma=atualizar_turma';
	} else {
		var acao_turma='&acao_turma=incluir_na_turma';
	}

	var erro_msg = '';
	if ($('#cpf_cadastrado').val().length < 14) {
		erro_msg=erro_msg+'O campo CPF é de preenchimento obrigatório.\r\n';
		erro = 1;
	}
	if ($('#password').val().length < 5) {
		erro_msg=erro_msg+'O campo de SENHA deve ter no mínimo 5 caracteres e é obrigatório.\r\n';
		erro = 1;
	}
	if ($('#confirme_password').val().length < 5) {
		erro_msg=erro_msg+'O campo de CONFIRMAÇÃO DE SENHA é obrigatório e deve conter no mínimo 5 caracteres.\r\n';
		erro = 1;
	}
	if ($('#cod_pais').val().length < 1) {
		erro_msg=erro_msg+'A seleção de PAÍS é obrigatória.\r\n';
		erro = 1;
	}
	if ($('#nome').val().length < 5) {
		erro_msg=erro_msg+'O campo NOME COMPLETO é de preenchimento obrigatório e deve conter no mínimo 5 caracteres\r\n';
		erro = 1;
	}
	if ($('#dt_nascimento').val().length < 10) {
		erro_msg=erro_msg+'O campo DATA DE NASCIMENTO é de preenchimento obrigatório.\r\n';
		erro = 1;
	}
//	if ($('#sexo').val().length < 1) {
//		erro_msg=erro_msg+'A seleção de sexo é obrigatória.\r\n';
//		erro = 1;
//	}
	if ($('#telefone_pessoal').val().length < 13) {
		erro_msg=erro_msg+'O campo de TELEFONE é de preenchimento obrigatório, apenas números e deve conter o DDD com dois caracteres e o número no formato xxxx-xxxx ou xxxxx-xxxx.\r\n';
		erro = 1;
	}
    if ($('#telefone_pessoal').val().length > 0) {
        xddd = $('#telefone_pessoal').val();
        xstr = xddd.substring(1, 2);
            if (xstr == 0) {
                erro_msg=erro_msg+'O DDD do TELEFONE PESSOAL não pode conter 0. Digite dois caracteres.\r\n';
                erro = 1;
            }
    }
    if ($('#email').val().length < 8) {
		erro_msg=erro_msg+'O campo de E-MAIL é de preenchimento obrigatório  e deve conter no mínimo 8 caracteres.\r\n';
		erro = 1;
	}
	if ($('#confirme_email').val().length < 8) {
		erro_msg=erro_msg+'O campo de CONFIRMAÇÃO DE E-MAIL é de preenchimento obrigatório e deve conter no mínimo 8 caracteres.\r\n';
		erro = 1;
	}
	if ($('#endereco').val().length < 5) {
		erro_msg=erro_msg+'O campo de ENDEREÇO é de preenchimento obrigatório e deve conter no mínimo 5 caracteres.\r\n';
		erro = 1;
	}
	if ($('#cep').val().length < 9) {
		erro_msg=erro_msg+'O campo CEP é de preenchimento obrigatório e deve conter 8 caracteres.\r\n';
		erro = 1;
	}
	if ($('#cod_uf_ibge').val().length > 1) {
		if ($('#cod_muni_ibge').val().length < 1) {
			erro_msg=erro_msg+'A seleção de MUNICÍPIO é obrigatória.\r\n';
			erro = 1;
		}
	}
	if ($('#cod_uf_ibge').val().length < 1) {
		erro_msg=erro_msg+'A seleção de ESTADO é obrigatória.\r\n';
		erro = 1;
	}
	if ($('#cod_escolaridade').val().length < 1) {
		erro_msg=erro_msg+'A seleção de ESCOLARIDADE é obrigatória.\r\n';
		erro = 1;
	}
	if ($('#expectativas').val().length < 8) {
		erro_msg=erro_msg+'O campo de DESCRIÇÃO DE EXPECTATIVAS é de preenchimento obrigatório e deve conter no mínimo 8 caracteres.\r\n';
		erro = 1;
	}
	if ($('#selecao_como_soube').val()==null || $('#selecao_como_soube').val().length < 1) {
		erro_msg=erro_msg+'A seleção "Como ficou sabendo do curso" é obrigatória.\r\n';
		erro = 1;
	}
	if (($('#como_soube').val().length < 1) && ($('#selecao_como_soube').val() == 6)) {
		erro_msg=erro_msg+'O campo Outros/Especificar é obrigatório na seleção OUTROS.\r\n';
		erro = 1;
	}
	if (document.getElementById('atuacao').checked) {
		if ($('#atuacao_bioma').val().length < 5) {
			erro_msg=erro_msg+'O campo "Qual?" é de preenchimento obrigatório e deve conter no mínimo 5 caracteres.\r\n';
			erro = 1;
		}
	}
	if (document.getElementById('vinculo').checked) {
		if ($('#tipoenti').val() == 0) {
			erro_msg=erro_msg+'O campo TIPO DE INSTITUIÇÃO é de preenchimento orbigatório, caso não participe de nenhuma, selecione pessoa física.\r\n';
			erro = 1;
		}
		if ($('#e_nome').val().length < 5) {
			erro_msg=erro_msg+'O campo "NOME DA INSTITUIÇÃO é de preenchimento obrigatório e deve conter no mínimo 5 caracteres.\r\n';
			erro = 1;
		}
		if ($('#setor').val().length < 5) {
			erro_msg=erro_msg+'O campo "SETOR" é de preenchimento obrigatório e deve conter no mínimo 5 caracteres.\r\n';
			erro = 1;
		}
		if ($('#cargo').val().length < 5) {
			erro_msg=erro_msg+'O campo "CARGO/FUNÇÃO" é de preenchimento obrigatório e deve conter no mínimo 5 caracteres.\r\n';
			erro = 1;
		}
		if ($('#area_atuacao').val() == 0) {
			erro_msg=erro_msg+'A seleção de ÁREA DE ATUAÇÃO é de preenchimento obrigatório.\r\n';
			erro = 1;
		}
		if ($('#e_email').val().length < 8) {
			erro_msg=erro_msg+'O campo de E-MAIL PROFISSIONAL é de preenchimento obrigatório. \r\n';
			erro = 1;
		}
		if ($('#telefone_entidade').val().length < 5) {
			erro_msg=erro_msg+'O campo TELEFONE PROFISSIONAL é de preenchimento obrigatório, apenas números e deve conter o DDD com dois caracteres e o número no formato xxxx-xxxx ou xxxxx-xxxx.\r\n';
			erro = 1;
		}
		if ($('#telefone_entidade').val().length > 0) {
		    xddd = $('#telefone_entidade').val();
            xstr = xddd.substring(1, 2);
            if (xstr == 0) {
			    erro_msg=erro_msg+'O DDD do TELEFONE PROFISSIONAL não pode conter 0. Digite dois caracteres.\r\n';
			    erro = 1;
            }
		}
		if ($('#cod_uf_enti').val().length >1)  {
			if ($('#cod_muni_enti').val().length < 1)  {
				erro_msg=erro_msg+'A seleção de MUNICÍPIO DA INSTITUIÇÃO é obrigatória.\r\n';
				erro = 1;
			}
		}
		if ($('#cod_uf_enti').val() == 0) {
			erro_msg=erro_msg+'A seleção de UF DA INSTITUIÇÃO é de preenchimento obrigatório.\r\n';
			erro = 1;
		}
		if ($('#e_cnpj').val().length < 5) {
			erro_msg=erro_msg+'O campo CNPJ DA INSTITUIÇÃO é de preenchimento obrigatório.\r\n';
			erro = 1;
		}
		if ($('#e_endereco').val().length < 5) {
			erro_msg=erro_msg+'O campo ENDEREÇO DA INSTITUIÇÃO é de preenchimento obrigatório e deve conter no mínimo 5 caracteres.\r\n';
			erro = 1;
		}
		if ($('#e_cep').val().length < 8) {
			erro_msg=erro_msg+'O campo CEP DA INSTITUIÇÃO é de preenchimento obrigatório e deve conter no mínimo 5 caracteres.\r\n';
			erro = 1;
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
		var atuacao	            = '&atuacao='+$('#atuacao').val();
		var selecao_como_soube  = '&selecao_como_soube='+$('#selecao_como_soube').val();

		var task				= 'cadastrar_aluno';


	    var destino  = url_ajax+task+acao_turma+acao_aluno+cpf_cadastrado+password+tipoenti+cod_pais+nome+nome_social+dt_nascimento+sexo+cod_raca+email+endereco+cep+formacao;
	    destino		 = destino+cod_uf_ibge+cod_muni_ibge+cod_uf_enti+cod_muni_enti+cod_pos+pos+cod_escolaridade+newsletter+e_nome+e_endereco+e_cep+e_email+e_www;
	    destino		 = destino+e_cnpj+telefone_pessoal+telefone_entidade+expectativas+como_soube+atuacao_bioma+veracidade+cod_aluno+id_turma;
	    destino		 = destino+setor+cargo+area_atuacao+atuacao+selecao_como_soube;

    
	    $.ajax({
	        type:'GET',
	        url:destino,
	        success: function (data) {
				if (ja_na_turma=='true') {
		            url_benvindo = 'dados_atualizados.asp?x=1'+cod_aluno+id_turma;
				} else {
		            url_benvindo = 'bem_vindo.asp?x=1'+cpf_cadastrado+id_turma;
	    	    }
			    window.location.assign(url_benvindo);
	        }
	    });
	} else {
		alert(erro_msg);
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
            $('#cod_pos').html(data).show();
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
            $('#cod_uf_enti').html(data).show();
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
	            alert("CPF inválido");
	            document.getElementById(campo).focus();
	            document.getElementById(campo).value = "";
	        }
	    }
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
	            alert("CNPJ inválido");
	            document.getElementById(campo).focus();
	            document.getElementById(campo).value = "";
	        }
	    }
	}	    
}

// Função para ajuste de picture de cpf
function formata_cpf_recuperado(campo,dado,event) {
    var cpf_recuperado = dado.substring(0,3)+'.'+dado.substring(3,6)+'.'+dado.substring(6,9)+'-'+dado.substring(9,11);
    document.getElementById(campo).value = cpf_recuperado;
}

// Função para ajuste de picture de cnpj
function formata_cnpj_recuperado(campo,dado,event) {
    var cnpj_recuperado = dado.substring(0,2)+'.'+dado.substring(3,3)+'.'+dado.substring(6,3)+'/'+dado.substring(9,4)+'-'+dado.substring(13,2);
    document.getElementById(campo).value = cnpj_recuperado;
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
            alert("Atenção 3: "+data);
        }
    });
    
    $("#cpf_trocasenha").val('');
    $("#senhaatual_troca").val('');
    $("#senha_troca").val('');
    $("#confirme_troca").val('');
    
    activate_page("#mainpage"); 
}
