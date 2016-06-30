// JavaScript Document

$(function() {
			
		CarregaCombos();
		
		 $('#data_inicial').datepicker({
	format: "dd/mm/yyyy",
	language: "pt-BR",
	daysOfWeekDisabled: "0",
	calendarWeeks: true
  });
  
  $('#data_final').datepicker({
	format: "dd/mm/yyyy",
	language: "pt-BR",
	daysOfWeekDisabled: "0",
	calendarWeeks: true
  });
		
});
	
	function CarregaCombos(){
		
		CarregaCurso();		
		CarregaTurma();
		CarregaEstado();
		
		
		} 
		
		

	function CarregaTurma(){
	
		$.getJSON('gestao_perfilJson.asp?opcao=2&curso=0', function(turma) { 
		
		 var options = "";
		 	 options += '<option value="0" selected >TODOS</option>';
            $.each(turma, function(key, value){
               options += '<option value="' + value.ID_TURMA + '">' + value.CODIGO_TURMA + '</option>';
            });
	
		$('#turma').html(options);
			
	});
		
		
		}
	function CarregaEstado(){
	
	
		$.getJSON('gestao_perfilJson.asp?opcao=3', function(estados) { 
		
    		 var options = "";
		 	 options += '<option value="0" selected >TODOS</option>';
            $.each(estados, function(key, value){
               options += '<option value="' + value.COD_UF_IBGE + '">' + value.NOME_UF + '</option>';
            });
	
		$('#estado').html(options);
			
	});
		
		
}
		
function CarregaMunicipio(estado){
	
		$.getJSON('gestao_perfilJson.asp?opcao=4&estado=' + estado, function(municipio) { 
		
    		 var options = "";
		 	 options += '<option value="0" selected >TODOS</option>';
            $.each(municipio, function(key, value){
               options += '<option value="' + value.COD_MUNI_IBGE + '">' + value.NOME_MUNI + '</option>';
            });
	
		$('#municipio').html(options);
			
	});
		
		
}		
	$('#estado').change(function(){
		CarregaMunicipio($("#estado").val());
	});

	//Preenche Combo Turma e Grid
	$('#curso').change(function(){
		CarregaTurma();
		
	});	
	

     function CarregaCurso(){
		 
		 	var url = "gestao_perfilJson.asp?opcao=1"
		
		 $.getJSON(url, function(cursos) { 
		
		 var options = "";
		   options += '<option value="0" selected >Selecione um Curso</option>';
            $.each(cursos, function(key, value){
               options += '<option value="' + value.COD_CURSO + '">' + value.TITULO + '</option>';
            });
		  
	
			$('#curso').html(options);
			var optionsInicia = '<option value="0" selected >TODOS</option>';
    		$('#turma').html(optionsInicia);
		    
		});
		 
 }		
 
  function SomenteNumero(e) {
        var tecla = (window.event) ? event.keyCode : e.which;
        if ((tecla > 47 && tecla < 58)) return true;
        else {
            if (tecla == 8 || tecla == 0) return true;
            else return false;
        }
    }
 
 function PopulaGrid(){
	 			
		  var text = "Carregando, Aguarde!";
		  waitingDialog.show(text);
		
		  var umaUrlGrupo = "gestao_perfilJson.asp?opcao=6&" +  CarregarParamentros();
			 var umaListaAgrupada;
			$.getJSON(umaUrlGrupo, function(data) {
				umaListaAgrupada = data;

			});
			
			
			if(umaListaAgrupada != "undefined"){
			
			 var ordenador = "";
			 var totalGeral = "";
		    var tabela = "";
			var umaUrl = "gestao_perfilJson.asp?opcao=5&" +  CarregarParamentros();
 			$.getJSON(umaUrl, function(data) {
						 
			tabela = tabela + "     <table class='table table-responsive table-striped filha' >  <tbody id='dados'>"
			
				$.each(umaListaAgrupada, function(key, value){
					
						
						
						ordenador = value.ORDENACAO;
						
							tabela = tabela + "<tr class='neta' >"
								tabela = tabela + "<td class='header1' colspan='3' >" + value.GRUPO + "</td>"
								tabela = tabela + "<td class='header1' > Frequência</td>"
								tabela = tabela + "<td class='header1' > Percentual(%)</td>"
								tabela = tabela + "<td class='header1' > Não Aprovado</td>"
								tabela = tabela + "<td class='header1' > Aprovados</td>"
								tabela = tabela + "<td class='header1' > Evadidos</td>"
								tabela = tabela + "<td class='header1' > Ausentes</td>"
								tabela = tabela + "<td class='header1' > Efetivos</td> "               
								tabela = tabela + "</tr>"


							$.each(data, function(key, value1){			
							 if(ordenador == value1.ORDENACAO){
					
								if(value.ORDENACAO == 0){
										totalGeral = value1.FREQUENCIA 
									}
					
								var Percentual =   (value1.FREQUENCIA * 100) / totalGeral;
					
					
									tabela = tabela + "<tr >"
										 tabela = tabela + "<td   colspan='3' >" + value1.INDICADOR        +"</td>"
										 
										 tabela = tabela + "<td class='header1'>"  + value1.FREQUENCIA       +"</td>"
										 tabela = tabela + "<td class='header1' >"  + Percentual.toFixed(2)  +"</td>"
										 tabela = tabela + "<td class='header1'>"  + value1.NAO_APROVADOS     +"</td>"								 
										 tabela = tabela + "<td class='header1'>"  + value1.APROVADOS         +"</td>"
										 tabela = tabela + "<td class='header1'>"  + value1.EVADIDOS          +"</td>"
										 tabela = tabela + "<td class='header1'>"  + value1.AUSENTES         +"</td>"
										 tabela = tabela + "<td class='header1'>"  + value1.EFETIVOS         +"</td>"
									tabela = tabela + "</tr>"
									
									Percentual = "";
							 }

				
									
						});
						
						
				
				});
					tabela = tabela + "    </tbody> </table>"
				$("#Grid").html(tabela);
				 waitingDialog.hide();
			});
	
			}else{
				$("#Grid").html("<div class=' alert alert-info'>Não há registro para exibição</div>");
				
				}
		
		
		
	 	
		
		
	 }
	 
	 function CarregarParamentros(){
		
	
		 curso          = 0;
		 turma          = 0;
		 data_inicial   = $("#data_inicial").val();
		 data_final     = $("#data_final").val();
 		 estado         = 0;
		 municipio      = 0;
		
		
		 // realizar essa validação quando ambos estiverem preenchido
	 if (data_inicial != "" & data_final != ""){
     	    if (data_final < data_inicial) {
				
			  var text = "Ops, A data final "+ data_final + " de pesquisa é menor do que a data inicial "+ data_inicial +"!";
               waitingDialog.show(text);
               setTimeout(function () { waitingDialog.hide(); }, 3000);
				$("#data_inicial").val('');
				$("#data_final").val('');
				
				return;
        }
 	  }
		
	
		if ($("#curso").val() != 0){
			curso = $("#curso").val();
		}
			
		if ($("#turma").val() != null){
			turma = $("#turma").val();
		}
	
		if ($("#estado").val() != null){
			estado = $("#estado").val();
			
		}
		
		if ($("#municipio").val() != null){
			municipio = $("#municipio").val();
			
		}
		
	
		if(data_inicial != ""){
		data_inicial = dataSemFormatcao(data_inicial);
		}

		if(data_final != ""){
		 data_final = dataSemFormatcao(data_final);
		}


	
	var	url = 'estado='         	 + estado       + '&';
		url = url + 'municipio='     + municipio    + '&';
		url = url + 'curso='      	 + curso      	+ '&';
		url = url + 'turma='      	 + turma      	+ '&';
		url = url + 'data_inicial='  + data_inicial + '&';
		url = url + 'data_final='	 + data_final  	+"";    
		
		
		return url;
	}
	
	
	$("#bt_gerar").click(function(){  
	
	PopulaGrid();
	
		});
	 
 
$("#bt_limpar").click(function(){

	$("#curso").val(0);
	$("#turma").val(0);
	$("#estado").val(0);
	$("#municipio").val(0);
	$("#data_inicial").val("");
	$("#data_final").val("");
	
	
});

function dataSemFormatcao(umaData){
	
		var data = umaData.split("/");
		return data[2]+data[1]+data[0] ;
	
}