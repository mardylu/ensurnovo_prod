
// JavaScript Document

	  

var url_ajax = 'funcoes.asp?task=';

// Função para abrir a pagina para envio de senha por email


$(function() {
	
	
	
});


// Função de login, para recuperar os dados de alunos já cadastrados
function recupere_meus_dados() {
	
		 /*waitingDialog.show("Aguarde, recuperando seus dados! ");*/

  
    var task  = 'recupere_meus_dados';
    var CODA  = '&CODA='+$("#cod_aluno").val();
    var destino  = url_ajax+task+CODA;

    $.ajax({
        type:'GET',
        url:destino,
        success: function (data) {
		
            if (data!='erro' && data!='erro1') {
             
			    mostra_dados( $.parseJSON(data));

            } else {

	                var msg = 'Ops, aluno não encontrado!';
					 waitingDialog.show(msg);
					  setTimeout(function () { waitingDialog.hide(); }, 3000);
					  
					  
            }
        }
    });
}


function ListaDeCursos() {

    var task  = 'lista_de_cursos_do_aluno';
    var COD_ALUNO  = '&COD_ALUNO='+$("#cod_aluno").val();
    var destino  = url_ajax+task+COD_ALUNO;

console.log(COD_ALUNO);
    $.ajax({
        type:'GET',
        url:destino,
        success: function (data) {
             
			   TabelaDeCurso($.parseJSON(data));
        }
    });
}


function TabelaDeCurso(data){
	var umTabela = "";
		umTabela="<table  class='table table-condensed  table-striped filha'>";
   var count = Object.keys(data).length;

	    umTabela = umTabela + "<tr>"

		umTabela = umTabela + "<th> CODIGO TURMA </th>"
		umTabela = umTabela + "<th> TITULO </th>"
		umTabela = umTabela + "<th> INSTITUICAO </th>"  //incluido por Raphael Lopes em 01/06/2016
		umTabela = umTabela + "<th> UF </th>"           //incluido por Raphael Lopes em 01/06/2016
		umTabela = umTabela + "<th> MUNICIPIO </th>"	//incluido por Raphael Lopes em 01/06/2016	
		umTabela = umTabela + "<th>INICIO</th>"
		umTabela = umTabela + "<th>TERMINO</th>"
		umTabela = umTabela + "<th> STATUS </th>"
		umTabela = umTabela + "</tr>"
		

	if(count >0){
		$.each(data, function(key, v){
		umTabela = umTabela + "<tr>"

		umTabela = umTabela + "<td>" + v.CODIGO_TURMA + "</td>"
		umTabela = umTabela + "<td>" + v.TITULO + "</td>"
		umTabela = umTabela + "<td>" + v.INSTITUICAO_CURSO + "</td>"  //incluido por Raphael Lopes em 01/06/2016
		umTabela = umTabela + "<td>" + v.UF_CURSO + "</td>"           //incluido por Raphael Lopes em 01/06/2016
		umTabela = umTabela + "<td>" + v.MUNICIPIO_CURSO + "</td>"    //incluido por Raphael Lopes em 01/06/2016
		umTabela = umTabela + "<td>" + formataData((v.DT_INICIO_TURMA).toString()) + "</td>"
		umTabela = umTabela + "<td>" + formataData((v.DT_FIM_TURMA).toString()) + "</td>"
		umTabela = umTabela + "<td>" + v.STATUS + "</td>"
		umTabela = umTabela + "</tr>"
		
		
		
		
		
		});
	}else{
			
			 umTabela = umTabela + " <td>Este aluno não participou de nenhum curso</td><tr>"
			
			}
		
		umTabela = umTabela + "</table>"
		
		
		$("#Grid").html(umTabela);
		
		
	}

function mostra_dados(data){
	
	
	$.each(data, function(key, v){
	$('#NOME').html(v.NOME);
	

	
	$('#CPF').html(formata_cpf(v.CPF));
	
	
	$('#SENHA').html(v.PASSWORD);
	$('#RACA').html(v.RACA_DESCRICAO);
	$('#DEFICIENCIA').html(v.DEFICIENCIA);
	$('#ESCOLARIDADE').html(v.ESCOLARIDADE);
    $('#EMAIL').html(v.EMAIL);
	$('#NASCIMENTO').html(formataData((v.DT_NASCIMENTO).toString()));

	
   $('#NACIONALIDADE').html(v.PAIS_DESCRICAO);
   $('#ENDERECO').html(v.ENDERECO);
   $('#CEP').html(formata_cep(v.CEP));
   $('#MUNICIPIO').html(v.NOME_MUNI_DADOS_PESSOAIS);
   $('#UF_PESSOAL').html(v.SIGLA_UF_DADOS_PESSOAIS);
     
   $('#FAX').html(formata_telefone(v.FAX_PESSOAL));
   $('#TEL').html(formata_telefone(v.TELEFONE_PESSOAL ));
	
	var sexo_ ="Feminino" ;
    if(v.SEXO == "1"){
		sexo_ = "Masculino"
	}
	
    $('#SEXO').html(sexo_);
    $('#pos').html(v.POS);
    $('#ENDERECO_ENTI').html(v.E_ENDERECO);
    $('#CEP_ENTI').html(formata_cep(v.E_CEP));

    $('#EMAIL_ENTI').html(v.E_EMAIL);
   	$('#SETOR').html(v.SETOR);
    $('#CARGO').html(v.CARGO);
	$('#FAX_ENTI').html(formata_telefone(v.E_FAX));
	$('#ESCOLATIRADE').html(v.COD_ESCOLARIDADE);
    $('#FORMACAO').html(v.FORMACAO);
	$('#POS').html(v.POS);
	$('#AREA').html(v.AREA_POS);
		
	$('#UF_ENTI').html(v.SIGLA_UF_PROFISSIONAL);
    $('#MUNI_ENTI').html(v.NOME_MUNI_PROFISSIONAL);
	$('#TEL_ENTI').html(formata_telefone(v.TELEFONE_ENTIDADE));
	    //$('#e_cnpj').html(v.e_cnpj);
    $('#ja_na_turma').html(v.ja_na_turma);
	
	   
    $('#area_atuacao').html(v.AREA_ATUACAO);
    $('#selecao_como_soube').html(v.SELECAO_COMO_SOUBE);
	$('#efetivo').html(v.EFETIVO);


	$('#NOME_INSTITUICAO_ENSINO').html(v.INSTITUICAO_ENSINO);
	$('#UF_INSTITUICAO_ENSINO').html(v.SIGLA_UF_FORMACAO_ACADEMICA);
	$('#MUNI_INSTITUICAO_ENSINO').html(v.NOME_MUNI_FORMACAO_ACADEMICA);
	$('#CNPJ_INSTITUICAO_ENSINO').html(v.INSTITUICAO_ENSINO_CNPJ);
	

	
	if(v.INSTITUICAO_ENSINO_CONCLUSAO){
	var conclusao = (v.INSTITUICAO_ENSINO_CONCLUSAO).toString();
	conclusao = conclusao.substring(0,2) + "/"+ conclusao.substring(2,6);
		$('#PREVISAO_INSTITUICAO_ENSINO').html(conclusao);
	}
	
	});
	}
	
	
function formata_cpf(dado) {
		
	var cpf_recuperado = "";
	if(dado != ""){	
    cpf_recuperado = dado.substring(0,3)+'.'+dado.substring(3,6)+'.'+dado.substring(6,9)+'-'+dado.substring(9,11);
	}
   return cpf_recuperado;
}
	
	
function formataData(dado){
	
	var dt_nascimento = ""
	
	if(dado != ""){
				
		var ano = dado.substring(0,4);
		var mes = dado.substring(4,6);
		var dia = dado.substring(6,8);
		dt_nascimento = dia+'/'+mes+'/'+ano;
	
	}
	
	return dt_nascimento;
	}	
	
// Função para ajuste de picture de cnpj
function formata_cnpj(campo,dado) {

    var cnpj_recuperado = dado.substring(0,2)+'.'+dado.substring(2,5)+'.'+dado.substring(5,8)+'/'+dado.substring(8,12)+'-'+dado.substring(12,14);
  return cnpj_recuperado;
	
	
}

// Função para ajuste de picture de cep
function formata_cep(dado) {
    var cep_recuperado = dado.substring(0,5)+'-'+dado.substring(5,8);
	
	return cep_recuperado;

}

// Função para ajuste de picture de telefone
function formata_telefone(dado) {
	var tel_recuperado = "";
	if(dado != "" && dado != null){	
	
	var t = dado.length;
	if (dado.substring(0,1) == '0') {
		dado = dado.substring(1,t);
	}
	var t = dado.length;
	if (t==10) {
    	var tel_recuperado = '(55 '+dado.substring(0,2)+')'+dado.substring(2,6)+'-'+dado.substring(6,10);
	} else {
    	var tel_recuperado = '(55 '+dado.substring(0,2)+')'+dado.substring(2,7)+'-'+dado.substring(7,11);
	}	
	}
    return tel_recuperado;
}


$("#task").change(function(){
	
	if(this.val() == "mail"){
		$("#myModal").modal();
		}
	
	
			if (this.val==='curso') {
				document.getElementById('cursoDados').style.display = 'block';
			} else {
				document.getElementById('cursoDados').style.display = 'none';
			}
			if (this.val==='vencimento') {
				document.getElementById('vencDados').style.display = 'block';
			} else {
				document.getElementById('vencDados').style.display = 'none';
			}
		
	});