// JavaScript Document


var cod = "";
var ordem = "";
codigoAlunos = [];

$(function() {
	

  $("table").stupidtable();
	cod = $("#codigo").val();
	ordem = "NOME";
	
	if($("#mostraSel").val() == false){
	   $("#colunaCheck").attr("class","collapsed");

	}

	PopularCombos();
	
 
	
			
	 $("table").on("beforetablesort", function (event, data) {
		
          // Apply a "disabled" look to the table while sorting.
          // Using addClass for "testing" as it takes slightly longer to render.
           $("#msg").text("Reordenando...");
          $("table").addClass("disabled");
        });

        $("table").on("aftertablesort", function (event, data) {
          // Reset loading message.
        $("#msg").html("&nbsp;");
          $("table").removeClass("disabled");

          var th = $(this).find("th");
          th.find(".arrow").remove();
          var dir = $.fn.stupidtable.dir;

          var arrow = data.direction === dir.ASC ? "&uarr;" : "&darr;";
          th.eq(data.column).append('<span class="arrow">' + arrow +'</span>');
		  
		
        });	
		
		
});
	
	
	$("input[name='main']").click(function(){
	 
        var val = this.checked;
        $('input[name=sel]').each(function () {
            $(this).prop('checked', val);
					
     
   		 });
	
	});
	
	$("#bt_gerar").click(function(){
			if($("#siga_projeto").val() == 1 ){
			ExibeGeral();
			}else{
				ExibeAluno();
				
				}
			PopulaGrid();
			
		});
	
	
    function PopulaGrid(){
	 		 
					 
		  var text = "Carregando, Aguarde!";
			  waitingDialog.show(text);
	
		       var umaUrl = CarregarParametros("gestao_selecaoJson.asp?opcao=4&");
		 
			var contador = 0;
			var tabela ="";
			$.getJSON(umaUrl, function(CursosLista) { 

	      		$.each(CursosLista, function(key, value){
 			       contador++;
			  		tabela = tabela + "  <tr class=" + value.COD_ALUNO + ">"
					
						if($("#mostraSel").val() == "True"){
							
						  		tabela = tabela + "<td style='text-align:center;' class='check'><input type='checkbox' name='sel'  value='" + value.COD_ALUNO + "'></td>"
						}
	                    tabela = tabela + " <td '><a href='aluno.asp?ord=&cod=" + $("#codigo").val() + "&st=0&coda=" + value.COD_ALUNO + "'>"  + value.NOME + "</a></td>"
					
					if($("#siga_projeto").val() == 1 ){
						tabela = tabela + " <td class='header1 collapsed' >"  + value.TIPO_INSTITUICAO   + "</td>"
						tabela = tabela + " <td class='header1 collapsed' >"  + value.NOME_INSTITUICAO   + "</td>"
						tabela = tabela + " <td class='header1 collapsed' >"  + value.CARGO 			 + "</td>"
						tabela = tabela + " <td class='header1 collapsed' >"  + value.AREA_ATUACAO       + "</td>"
						tabela = tabela + " <td class='header1 collapsed' >"  + value.UF_MUNICIPIO       + " </td>"
						tabela = tabela + " <td class='header1 collapsed' >"  + value.prioridade         + "</td>"
						tabela = tabela + " <td class='header1 collapsed' >"  + value.ESCOLARIDADE       +"</td>"
	
						tabela = tabela + " <td class='header1 collapsed' >"  + value.EFETIVO            +"</td>"
						tabela = tabela + " <td class='header1 collapsed' >"  + value.TC 				 +"</td>"
						tabela = tabela + " <td class='header1 collapsed' >"  + value.TF 				 +"</td>"
						tabela = tabela + " <td class='header1 collapsed' >"  + value.TN 				 +"</td>"
						tabela = tabela + " <td class='header1 collapsed' >"  + value.TE 				 +"</td>"
						tabela = tabela + " <td class='header1 collapsed' >"  + value.TA				 +"</td>"
						tabela = tabela + " <td class='header1 collapsed' >"  + value.TV 				 +"</td>"
						tabela = tabela + " <td class='header1 collapsed' >"  + value.TR 				 +"</td>"
						tabela = tabela + " <td class='header1 collapsed' >"  + value.TS				 +"</td>"
	
						tabela = tabela + " <td class='header1 collapsed' >"+ value.Bio 				 +"</td>"
						tabela = tabela + " <td class='header1 collapsed' >"+ value.DT_CADASTRO		 +"</td>"
					}else{
							tabela = tabela + " <td class='header1' >"  + value.TIPO_INSTITUICAO + "</td>"
						tabela = tabela + " <td class='header1' >"  + value.NOME_INSTITUICAO + "</td>"
						tabela = tabela + " <td class='header1' >"  + value.CARGO 			 + "</td>"
						tabela = tabela + " <td class='header1' >"  + value.AREA_ATUACAO     + "</td>"
						tabela = tabela + " <td class='header1' >"  + value.UF_MUNICIPIO     + " </td>"
						tabela = tabela + " <td class='header1' >"  + value.prioridade       + "</td>"
						tabela = tabela + " <td class='header1' >"  + value.ESCOLARIDADE     +"</td>"
	
						tabela = tabela + " <td class='header1' >"  + value.EFETIVO          +"</td>"
						tabela = tabela + " <td class='header1' >"  + value.TC 				 +"</td>"
						tabela = tabela + " <td class='header1' >"  + value.TF 				 +"</td>"
						tabela = tabela + " <td class='header1' >"  + value.TN 				 +"</td>"
						tabela = tabela + " <td class='header1' >"+ value.TE 				 +"</td>"
						tabela = tabela + " <td class='header1' >"+ value.TA				 +"</td>"
						tabela = tabela + " <td class='header1' >"+ value.TV 				 +"</td>"
						tabela = tabela + " <td class='header1' >"+ value.TR 				 +"</td>"
						tabela = tabela + " <td class='header1' >"+ value.TS				 +"</td>"
	
						tabela = tabela + " <td class='header1' >"+ value.Bio 				 +"</td>"
						tabela = tabela + " <td class='header1' >"+ value.DT_CADASTRO		 +"</td>"
						
						
						}
						tabela = tabela + " <td class='participante collapsed'>("+ value.TEL_DDD + ")" +  value.TEL +"</td>"
						tabela = tabela + " <td class='participante collapsed'>"+ value.EMAIL +"</td>"
						tabela = tabela + " <td class='participante collapsed'>"  + value.NOME_INSTITUICAO + "</td>"
						tabela = tabela + " <td class='participante collapsed'>"  + value.CARGO + "</td>"        
					
					tabela = tabela + "</tr>"
			 
		  });
		  
		  if(tabela == ""){
		      tabela = tabela + "<tr><td colspan='20'>"
              tabela = tabela + "<div class='alert alert-danger'>Não há registro para exibição</div></td></tr>"
			  }
			  
			   $("#dados").html(tabela);
		    $("caption").html(contador + " aluno(s) listado(s) ");
		  
		  });
		  
		   	   setTimeout(function () { waitingDialog.hide(); }, 3000);
			   
			   
			   
		 if($("#siga_projeto").val() == 2 ){
			ExibeGeral();
		}else{
			ExibeAluno();
		}
			  
	}
	
	
	function CarregarParametros(url){
			tipo_enti       = 0;
			area_atu        = null;
			escolaridade    = 0;
			prioridade      = 0;
			bioma           = 2;
			funciona        = 2;
			termo           = 2;
			
			
			
		if ($("#tipoInstituicao").val() != 0){
			tipo_enti = $("#tipoInstituicao").val();
		}
		
		if ($("#tipoAtuacao").val() != 0){
			area_atu = $("#tipoAtuacao").val();
		}
		if ($("#escolaridade").val() != 0){
			escolaridade = $("#escolaridade").val();
		}	
			if ($("#prioridade").val() != 0){
			prioridade = $("#prioridade").val();
		}	
		$("input[type=radio][name='bioma1']:checked").each(function(){
		  bioma =   $(this).val();
		});

		$("input[type=radio][name='servidor1']:checked").each(function(){
		  funciona =   $(this).val();
		});

		$("input[type=radio][name='termo1']:checked").each(function(){
		  termo =   $(this).val();
		});

			
            url = url + 'cod='       	+ cod      		+ '&';
			url = url + 'ordem='        + ordem         + '&';
			url = url + 'tipoenti='     + tipo_enti     + '&';
			url = url + 'areaatu='      + area_atu      + '&';
			url = url + 'escolaridade=' + escolaridade  + '&';
			url = url + 'prioridade='   + prioridade    + '&';
			url = url + 'bioma='        + bioma         + '&';
			url = url + 'funciona='     + funciona      + '&';
			url = url + 'termo='        + termo;
			return url;
		
	}
	
	
function CarregaCurso(){
		 
	 	var url = "gestao_selecaoJson.asp?opcao=1&cod=" + $("#codigo").val();
		
		 $.getJSON(url, function(curso) { 

		 $("#cursoLabel").html("<b>Curso: </b>" + curso[0].TITULO);
		 $("#codigoTurmaLabel").html("<b>Cóigo Turma: </b>" + curso[0].CODIGO_TURMA);
		 $("#periodoLabel").html("<b>Início: </b>" + curso[0].DT_INICIO_TURMA + ' Término: '+ curso[0].DT_FIM_TURMA);
		 $("#situacaoLabel").html("<b>Situação da turma: </b>" + curso[0].STATUS_TURMA);
		 
		});
		 
 }
 
 
function CarregaInstituicao(){

		$.getJSON('gestao_selecaoJson.asp?opcao=13', function(tipoInstituicao) { 
		 var options = "";
		  options += '<option value="0" selected >TODOS</option>';
            $.each(tipoInstituicao, function(key, value){
              options += '<option value="' + value.ID_TIPO_ENTIDADE + '">' + value.DESCRICAO + '</option>';
            });
		
		$('#tipoInstituicao').html(options);
		//PopulaGrid();
		});

 }
 
 function CarregaAreaDeAtuacao(){

		$.getJSON('gestao_selecaoJson.asp?opcao=2&cod=' + $("#codigo").val(), function(AreaAtuacao) { 
		 var options = "";
		  options += '<option value="" selected >TODOS</option>';
            $.each(AreaAtuacao, function(key, value){
              options += '<option value="' + value.ID_ATUACAO + '">' + value.ATUACAO + '</option>';
            });
		
		$('#tipoAtuacao').html(options);
		//PopulaGrid();
		});

 }
 
 
 
 function CarregaEscolaridade(){

		$.getJSON('gestao_selecaoJson.asp?opcao=3&cod=' + $("#codigo").val(), function(Escolaridade) { 
		 var options = "";
		  options += '<option value="0" selected >TODOS</option>';
            $.each(Escolaridade, function(key, value){
               options += '<option value="' + value.COD_ESCOLARIDADE + '">' + value.DESCRICAO + '</option>';
            });
		
		$('#escolaridade').html(options);
		//PopulaGrid();
		});

 }
 
function PopularCombos(){
    CarregaCurso();	
	CarregaInstituicao();
	CarregaAreaDeAtuacao();
	CarregaEscolaridade();
	
	PopulaGrid();
}
 
 
$("#bt_limpar").click(function(){
		if($("#siga_projeto").val() == 2 ){
			ExibeGeral();
		}else{
			ExibeAluno();
		}
	
	$("#tipoInstituicao").val(0) 
	$("#tipoAtuacao").val('');
	$("#escolaridade").val(0);
	$("#prioridade").val('todas')
	
	
	PopulaGrid();



});



function ExibeParticipante(){
	
$(".header").addClass("collapsed");
$(".header1").addClass("collapsed");
if($("#mostraSel").val() == "False"){
	$("#colunaCheck").addClass("collapsed");
}
	$(".participante").removeClass("collapsed");
	
}

function ExibeGeral(){

	
	$(".header").removeClass("collapsed");
	$(".header1").removeClass("collapsed");
	if($("#mostraSel").val() == "True"){
		$("#colunaCheck").removeClass("collapsed");
	}else {
		$("#colunaCheck").addClass("collapsed");
	}
	$(".participante").addClass("collapsed");
	
}


function ExibeAluno(){
	
	$(".header").addClass("collapsed");
	$(".header1").addClass("collapsed");
	
	if($("#mostraSel").val() == "True"){
	$("#colunaCheck").removeClass("collapsed");		
	}else{
	$("#colunaCheck").addClass("collapsed");
	}
	$(".participante").addClass("collapsed");
	
}

$("#geral").click(function(){
	$("#tipoExibicao").val(1);
	ExibeGeral();	
});

$("#alunos").click(function(){
	$("#tipoExibicao").val(2);
	ExibeAluno();

});


$("#participantes").click(function(){
	$("#tipoExibicao").val(3);
	ExibeParticipante();
});


/* ao clicar no todos, seleciona todos e altera a class de todas as linhas */
		


$("#mudar").click(function(){
		
		
		
	if( $('input[name=sel]:checked').length == 0 ){
		
		  var text = "Ops, nÃ£o hÃ¡ alunos selecionados para transferÃªncia de turma!";
               waitingDialog.show(text);
               setTimeout(function () { waitingDialog.hide(); }, 5000);
		
	}else{
				var contador = 0;
		$('input[name=sel]:checked').each(function(){
			codigoAlunos.push($(this).val());
			contador++;
		});
        CarregaTurma();
		
		$("#totAlunos").html("Total de Alunos: " + contador);
		$("#myModal").modal();
	}
	
	console.log(codigoAlunos);
	


		
});

function CarregaTurma(){
		 
	 	var url = "gestao_selecaoJson.asp?opcao=7&cod=" + $("#codigo").val()
		
		 $.getJSON(url, function(cursos) { 
		
		 var options = "";
		   options += '<option value="0" selected >Selecione um Curso</option>';
            $.each(cursos, function(key, value){
               options += '<option value="' + value.ID_TURMA + '">' + value.CODIGO_TURMA+ ' - ' + value.TITULO + '</option>';
            });
		  	
			$('#curso').html(options);
			    		
		    
		});
		 
 }
 
 $("#bt_enviar").click(function(){
	
	 var contador = 0;
  $.each(codigoAlunos, function(key, value){
	  	  
	  var url ="gestao_selecaoJson.asp?opcao=6&cod=" + $("#codigo").val() + "&codTurmaNova=" + $("#curso").val() + "&codAluno=" + value;
	
	  $.getJSON(url, function(ok) { 
					
		 if(ok[0].Id == 1){
			 contador++;
			 
	    	   $(".close").click();	  
			  
			  var text = "Transferindo, " + contador + " aluno(s) transferido(s) !";
				   waitingDialog.show(text);
				   setTimeout(function () { waitingDialog.hide(); }, 5000); 
				   PopulaGrid();
		  }else{	 
		  
			var text = "Ops, transferência não permitida para o(s) aluno(s) escolhido(s) !";
				   waitingDialog.show(text);
				   setTimeout(function () { waitingDialog.hide(); }, 5000); 
		  }
		  
 	  });
	 });  
 contador = 0;	
});


$("#planilha").click(function(){
	
	var action = "";
	
	 if ($("#siga_projeto").val()==2)  {
	     action = "gera_excelpqga.asp?p=1";
		} 
		else {
    	action = "gera_excel.asp?p=1";
		}
window.open(action);
	
	});