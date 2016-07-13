<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
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
  <script src="dataPicker/js/bootstrap-datepicker.min.js" charset="UTF-8"></script>
  <script src="dataPicker/locales/bootstrap-datepicker.pt.min.js" charset="UTF-8"></script>
  <script src="content/js/bootstrap-modal.js"></script>
  <link rel="stylesheet" type="text/css" href="dataPicker/css/bootstrap-datepicker.css">
  <script src="scripts/jquery.mask.min.js"></script>
  <script src="scripts/Mascaras.js"></script>
  <script>
  
  $(function() {
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
  </script>
  </head>
  <body>
  <div id="ckmt"> 
    <!-- #INCLUDE FILE="include/topo.asp" -->
    <form name="form" >
      <h1>Relat&oacute;rio de alunos por turma</h1>
      <input type="hidden" name="ord" value="<% request("ord") %>">
      <input type="hidden" name="stt" value="<% request("stt") %>">
      <input type="hidden" name="st" value="<% request("st") %>">
      <input type="hidden" name="curso1" value="<% request("curso") %>">
      <div class="col-md-12 col-sm-12">
        <div class="row">
          <div class="post-content overflow">
            <div class="col-sm-12 col-md-8">
              <div class="single-blog single-column">
                <label for="curso">Curso</label>
                <select class="dropdown-toggle" name="curso" id="curso" >
                </select>
              </div>
            </div>
            <div class="col-sm-12 col-md-4">
              <div class="single-blog single-column">
                <label for="turma">Turma</label>
                <select class="dropdown-toggle" name="turma" id="turma">
                </select>
              </div>
            </div>
          </div>
        </div>
        <div class="row">
          <div class="post-content overflow">
            <div class="col-sm-12 col-md-4">
              <div class="single-blog single-column">
                <label for="estado">Estado</label>
                <select class="dropdown-toggle" name="estado" id="estado">
                </select>
              </div>
            </div>
            <div class="col-sm-12 col-md-4">
              <div class="single-blog single-column">
                <label for="municipio">Municípo</label>
                <select class="dropdown-toggle" name="municipio" id="municipio">
                  <option value="0"> Todos</option>
                </select>
              </div>
            </div>
            <div class="col-sm-12 col-md-4">
              <div class="single-blog single-column">
                <label for="prioridade">Prioridade</label>
                <select class="dropdown-toggle" type="button" id="prioridade" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                  <option value="todas">Todas</option>
                  <option value="Baixa">Baixa</option>
                  <option value="M?dia">Média</option>
                  <option value="Alta">Alta</option>
                  <option value="Priorit?ria">Prioritáia</option>
                </select>
              </div>
            </div>
          </div>
        </div>
        <div class="row">
          <div class="post-content overflow">
            <div class="col-sm-12 col-md-4">
              <div class="single-blog single-column">
                <label for="cpf">CPF</label>
                <input type="text" id="cpf" class="mask-cpf span2" onKeyPress="return SomenteNumero(event)" >
                </input>
              </div>
            </div>
            <div class="col-sm-12 col-md-4">
              <div class="single-blog single-column">
                <label for="data_inicial">Período - Início</label>
                <input type="text" id="data_inicial" class="span2">
                <span class="add-on"><i class="icon-th"></i></span>
                </input>
              </div>
            </div>
            <div class="col-sm-12 col-md-4">
              <div class="single-blog single-column">
                <label for="data_final">Período - Final</label>
                <input type="text" id="data_final" class="span2">
                <span class="add-on"><i class="icon-th"></i></span>
                </input>
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
    </form>
    <br />
    <br />
    <div id="Grid">
      <table id="stupid" class="table table-condensed  table-striped filha"  cellspacing="5" cellpadding="5" width="100%" border="0">
        <caption>
        </caption>
        <thead>
          <tr >
            <th class="header" colspan="4" > Curso</th>
            <th class="header" > Turma</th>
            <th class="header" > Modelo</th>
            <th class="header" > Início</th>
            <th class="header" > Término</th>
            <th class="header" colspan='3'> Tutor</th>
          </tr>
        </thead>
        <tbody id="dados">
          <tr>
            <td colspan="11"><div class=" alert alert-info">Realize um filtro para obter resultado</div></td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</body>
  <script type="text/javascript">

$(function() {
		
	
	CarregaCombos();
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
	
		$.getJSON('Gestao_situacaoJson.asp?opcao=2&curso=' + curso, function(turma) { 
		
		 var options = "";
		 	 options += '<option value="0" selected >TODOS</option>';
            $.each(turma, function(key, value){
               options += '<option value="' + value.ID_TURMA + '">' + value.CODIGO_TURMA + '</option>';
            });
	
		$('#turma').html(options);
			
	});
		
		
		}
	function CarregaEstado(){
	
	
		$.getJSON('Gestao_situacaoJson.asp?opcao=3', function(estados) { 
		
    		 var options = "";
		 	 options += '<option value="0" selected >TODOS</option>';
            $.each(estados, function(key, value){
               options += '<option value="' + value.COD_UF_IBGE + '">' + value.NOME_UF + '</option>';
            });
	
		$('#estado').html(options);
			
	});
		
		
}
		
function CarregaMunicipio(estado){
	
		$.getJSON('Gestao_situacaoJson.asp?opcao=4&estado=' + estado, function(municipio) { 
		
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
	
/*	//Status Turma
	$('#st').change(function(){
		PopulaGrid();
	});
    $('#stt').change(function(){
		PopulaGrid();
	});
*/
	
	//Preenche Combo Turma e Grid
	$('#curso').change(function(){
		CarregaTurma();
		
	});	
	

     function CarregaCurso(){
		 
		 	var url = "Gestao_situacaoJson.asp?opcao=1"
		
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
		    var tabela = ""
			var urlCursoAgrupo = 'gestao_situacaoJson.asp?opcao=6&' +  CarregarParamentros();
			var  CursosLista;
			var contadordeAluno =0;
			var contadordeTurma =0;		
			
			$.getJSON(urlCursoAgrupo, function(agrupado) {
				
				CursosLista = agrupado;
			});
		
			var urlCurso = 'gestao_situacaoJson.asp?opcao=5&' +  CarregarParamentros();
			
			$.getJSON(urlCurso, function(data) {
					if(data != ""){
					var id_turma = "";
					var cod_curso = "";
					
					$.each(CursosLista, function(key, value){
						contadordeTurma++;
						   tabela = tabela + "	<tr class='titulo'>"
									tabela = tabela + "<td  colspan='4'>" + value.CURSO + "</th>"
									tabela = tabela + "<td  >" + value.CODIGO_TURMA+"</th>"
									tabela = tabela + "<td  >" + value.TIPO +"</td>"
									tabela = tabela + "<td  >" + value.DT_INICIO_TURMA +"</td>"
									tabela = tabela + "<td  >" + value.DT_FIM_TURMA + "</td>"
									tabela = tabela + "<td  colspan='3'>" + value.TUTOR +"</td>"
						   tabela = tabela + " </tr>"
						   tabela = tabela + "<tr class='neta'>"
											tabela = tabela + "<th> CPF</th>"	
											tabela = tabela + "<th> Aluno</th>"
											tabela = tabela + "<th> UF</th>"
											tabela = tabela + "<th> Município</th>"
											tabela = tabela + "<th> Prioridade</th>"
											tabela = tabela + "<th> Geocódigo</th>"
											tabela = tabela + "<th> Efetivo</th>"
											tabela = tabela + "<th> Natureza</th>"
											tabela = tabela + "<th> Cargo</th>"
											tabela = tabela + "<th> Espera</th>"		
											tabela = tabela + "<th> Status</th>"
							tabela = tabela + "</tr>"
							
												id_turma = value.ID_TURMA;
												cod_curso = value.COD_CURSO;
																		
													 
											$.each(data, function(key, value1){
												
												if(id_turma == value1.ID_TURMA && cod_curso == value1.COD_CURSO ){
													contadordeAluno++
												tabela = tabela + "<tr>"
													 tabela = tabela + "<td >"  + value1.CPF           	        +"</td>"
													 tabela = tabela + "<td>"  + value1.ALUNO         			+"</td>"
													 tabela = tabela + "<td>"  + value1.UF           			+"</td>"								 
													 tabela = tabela + "<td>"  + value1.MUNICIPIO           	+"</td>"
													 tabela = tabela + "<td>"  + value1.PRIORIDADE           	+"</td>"
													 tabela = tabela + "<td>"  + value1.GEOCODIGO           	+"</td>"
													 tabela = tabela + "<td>"  + value1.EFETIVO            		+"</td>"
													 tabela = tabela + "<td>"  + value1.NATUREZA    			+"</td>"
													 tabela = tabela + "<td>"  + value1.CARGO        			+"</td>"								 								 
													 tabela = tabela + "<td>"  + value1.ESPERA        			+"</td>"								 								 
													 tabela = tabela + "<td>"  + value1.STATUS         			+"</td>"
												
												tabela = tabela + "</tr>"
												}
											
											});
								
						});
						
						}else{
						 
						tabela = tabela + " <tr >"
						 tabela = tabela + "<td colspan='11'><div class='alert alert-danger'>Não há registro para exibição</div></td>"
						 tabela = tabela + "</tr>"
						 
						 }
	   $("#dados").html(tabela);
	    $("caption").html(" Total de Cursos: " + contadordeTurma + " com : " + contadordeAluno + " alunos ");
	   	 waitingDialog.hide();
	 	});
	 }
	 
	 function CarregarParamentros(){
		
	
		 curso          = 0;
		 turma          = 0;
		 data_inicial   = $("#data_inicial").val();
		 data_final     = $("#data_final").val();
 		 estado         = 0;
		 municipio      = 0;
		 prioridade     = 0;
		 cpf      		= "";

		
		 // realizar essa valida??o quando ambos estiverem preenchido
	 if (data_inicial != "" & data_final != ""){
     	    if (data_final < data_inicial) {
				
			  var text = "Ops, A data final "+ data_final + " de pesquisa ? menor do que a data inicial "+ data_inicial +"!";
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
		
		if ($("#prioridade").val() != null){
			prioridade = $("#prioridade").val();
			
		}
		
		if ($("#cpf").val() != null){
			cpf = $("#cpf").val();
			
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
		url = url + 'prioridade='    + prioridade   + '&';
		url = url + 'cpf='      	 + cpf      	+ '&';
		url = url + 'data_inicial='  + data_inicial + '&';
		url = url + 'data_final='	 + data_final  	+"";    
		
		
		return url;
	}
	
	
	$("#bt_gerar").click(function(){  
	
	PopulaGrid();
	});
	 
	 $("#bt_limpar").click(function(){
	
	
	$("#curso").val(0) 
	$("#turma").val(0);
	$("#estado").val(0);
	$("#municipio").val(0);
	$("#prioridade").val("todas");
	$("#cpf").val("");
	$("#data_inicial").val("");
	$("#data_final").val("");
	 });
 function dataSemFormatcao(umaData){
	
		var data = umaData.split("/");
		return data[2]+data[1]+data[0] ;
	
}

$("#bt_excel").click(function(){
	

	  var umaUrl =  "gestao_situacao_excel.asp?opcao=5&" +  CarregarParamentros();
  
	  window.open(umaUrl);
	
	})

</script>
  <style>
.filha td, th {
	font-size:16px;
	text-align:center !important;
}
.filha tbody {
 border-left: border: 1px solid #666;
 border-right: border: 1px solid #666;
}
.filha th {
	border: 1px solid #FFF;
	background: #2e6da4;
	color:#fff;
}
.filha .neta th {
	border: 1px solid #FFF;
	background-color:#AFE3F8;
	color:#000;
}
.filha {
	width: 100%;
	border-collapse: collapse;
}
.filha .neta {
	width: 100%;
	border-collapse: collapse;
}
.filha .neta th {
	border: 1px solid #FFF;
	background-color:#d9edf7;
	color:#000;
	min-height:25px;
}
th[data-sort] {
	cursor:pointer;
}
.titulo {
	height:50px;
}
.titulo td {
	vertical-align:middle !important;
}
.collapsed {
	display: none;
}
caption {
	padding: 0px 5px;
	margin: 0 0 5px;
	font-size: 12.5px;
	border-left: 5px solid #eee
}
label {
	width:120px;
	font-size:11px;
}
</style>
  <script src="scripts/popUpDialogo.js"></script>
  <script src="scripts/stupidtable.min.js?dev"></script>
  </html>
  