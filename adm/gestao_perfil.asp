  <%If session("key_ver")<>"ok" Then Response.Redirect "logout.asp"%>
  
  <% SIGA_PROJETO=Session("siga_projeto") %>
  
  <html lang="pt-BR">
  <head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
  
<title>ENSUR Inscrições</title>
	
	<link href="content/css/main.css" rel="stylesheet">
	<link rel="stylesheet" type="text/css" href="content/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="content/css/font-awesome.min.css">
	<link rel="stylesheet" type="text/css" href="css/jquery-ui.css">
	<script src="scripts/jquery-1.11.3.min.js" type="text/javascript"></script>
	
  <script src="content/js/bootstrap-collapse.js"></script>
	<script src="dataPicker/js/bootstrap-datepicker.min.js" ></script>
	<script src="dataPicker/locales/bootstrap-datepicker.pt.min.js" charset="UTF-8"></script>
	<script src="content/js/bootstrap-modal.js"></script>
	<link rel="stylesheet" type="text/css" href="dataPicker/css/bootstrap-datepicker.css">
  	<script src="scripts/jquery.mask.min.js"></script>
    <script src="scripts/Mascaras.js"></script>
<script>
 $(function() {
$('#dt_nascimento').datepicker({
    format: "dd/mm/yyyy",
    language: "pt-BR",
    daysOfWeekDisabled: "0",
    calendarWeeks: true
});
</script>
  </head>
  <body>
  <div id="ckmt">
	<!-- #INCLUDE FILE="include/topo.asp" -->
  

		
		
		<input type="hidden" name="ord" value="<% request("ord") %>">
		<input type="hidden" name="stt" value="<% request("stt") %>">
		<input type="hidden" name="st" value="<% request("st") %>">
		<input type="hidden" name="curso1" value="<% request("curso") %>">
		
	
   
	<div class="col-md-12 col-sm-12">
          <h1>Relatório de Perfil do Aluno</h1>     
          
             <div class="post-content overflow">
               <div class="row">
                <div class="col-sm-12 col-md-4">
                    <div class="single-blog single-column">
                    <label for="curso">Curso</label>
                    <select class="dropdown-toggle" name="curso" id="curso" ></select>
                    </div>
                </div>
                   
              
                <div class="col-sm-12 col-md-4">
                  <div class="single-blog single-column">
                    <label for="turma">Turma</label>
                    <select class="dropdown-toggle" name="turma" id="turma"></select>
                  </div>
                </div>
                 <div class="col-sm-12 col-md-4">
                   <div class="single-blog single-column">
                         <label for="estado">Estado</label>
                         <select class="dropdown-toggle" name="estado" id="estado">
                        </select>
                    </div>
                </div>
              
            </div>
          </div>	  
		
            
            
               <div class="col-sm-12 col-md-12">
               <div class="row">
                <div class="col-sm-12 col-md-4">
                   <div class="single-blog single-column">
                         <label for="municipio">Município</label>
                         <select class="dropdown-toggle" name="municipio" id="municipio">
                         <option value="0"> Todos</option>
                        </select>
                    </div>
                </div>
               
                 <div class="col-sm-12 col-md-4">
                   <div class="single-blog single-column">
                    <label for="data_inicial">Período - Início</label>
                     <input type="text" id="data_inicial" ><span class="add-on"><i class="icon-th"></i></span></input>
                  </div> 
                </div>
                <div class="col-sm-12 col-md-4">
                   <div class="single-blog single-column">
                     <label for="data_final">Período - Final</label>
                     <input type="text" id="data_final"><span class="add-on"><i class="icon-th"></i></span></input>
                 </div> 
                </div>
             
             </div>
           </div>
         </div>
		
		 <div class="col-sm-12 col-md-12">
         <div class="row">
			<div class="post-content overflow">
                <div class="col-md-2">
                    <button id="bt_gerar" type="button" class="btn btn-xs btn-primary" ><i class="fa fa-asterisk fa-binoculars"></i> Gerar Relatório</button>
                </div>
                 <div class="col-md-2">
              	     		<button id="bt_excel" class="btn btn-xs btn-success" type="button" ><i class="fa fa-file-excel-o" style="font-weight:bold;color:#207245"></i> Exportar</button>
	            </div>
              <div class="col-md-2">
                <button id="bt_menu" class="btn btn-xs btn-primary" type="button"  onClick="window.print();return false;"><i class="fa fa-print"></i> Imprimir</button>
              </div>
		 
               <div class="col-md-2">
                <button id="bt_limpar" class="btn btn-xs btn-primary" type="button" ><i class="fa fa-trash"></i> Limpar</button>
              </div>
	 	 </div>
	 	</div>
	 </div>
		
		<br />		
		<br />
      <div class="col-sm-12 overflow">
                   <div class="social-icons pull-right">
                    
                    </div> 
                </div>
                <br>
		<div id="Grid">
        	
                                <br>
                
        <table class="table table-responsive">
        <tr>
          <td>
        <div class=" alert alert-info">Realize um filtro para obeter resultado</div>
        	</td>
        </tr>
        </table>

		</div>
	 <br>
       
        
  
  
  </div> 
		
        
      
  
  </body>
 <script type="application/javascript">
 
 
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
	
		var curso =0;
	
		if($("#curso").val() != null){
			
			curso = $("#curso").val();
			}
	
		$.getJSON('gestao_perfilJson.asp?opcao=2&curso=' + curso , function(turma) { 
		
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
								tabela = tabela + "<td class='header1' > Frequêcia</td>"
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
				$("#Grid").html("<table class='table table-responsive'><tr><td><div class=' alert alert-danger'>Não há registro para exibição</div></td></tr></table>")
				

				
				}
		
		
		
	 	
		
		
	 }
	 
	 function CarregarParamentros(){
		
	
		 curso          = 0;
		 turma          = 0;
		 data_inicial   = $("#data_inicial").val();
		 data_final     = $("#data_final").val();
 		 estado         = 0;
		 municipio      = 0;
		
		
		 // realizar essa validaÃ§Ã£o quando ambos estiverem preenchido
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

 $("#bt_excel").click(function(){  
	
  var umaUrlGrupo = "gestao_perfil_excel.asp?opcao=6&" +  CarregarParamentros();
	window.open(umaUrlGrupo)
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
 
 </script>
  
<style>


table {
	
width:	98%;
	}
.filha td, th {
  
	font-size:16px;
	text-align:left !important;


}

.filha tbody {
	border-left: border: 1px solid #666;
	border-right: border: 1px solid #666;
}

.filha th {    border: 1px solid #FFF; background: #2e6da4; color:#fff; font-weight:bold !important;}

.filha .neta td   {    border: 1px solid #FFF; background-color:#d9edf7; color:#000; font-weight:bold !important; }

.titulo {
	font-weight:bold;
	}
	
.titulo td{
		vertical-align:middle !important;
	
	}

.filha {

    width: 100%;
    border-collapse: collapse;
}

.filha .neta {

    width: 100%;
    border-collapse: collapse;
}

 th[data-sort]{
     cursor:pointer;
}

label{

	width:100px;
	font-size:11px;
}
</style>

<script src="scripts/popUpDialogo.js"></script>

  </html>
