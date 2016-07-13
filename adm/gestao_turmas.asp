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
<script src="dataPicker/js/bootstrap-datepicker.min.js"  charset="UTF-8" ></script>
<script src="dataPicker/locales/bootstrap-datepicker.pt.min.js" charset="UTF-8" language="javascript" ></script>
<script src="content/js/bootstrap-modal.js"></script>
<link rel="stylesheet" type="text/css" href="dataPicker/css/bootstrap-datepicker.css">
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
  
  <input type="hidden" name="ord" value="<% request("ord") %>">
  <input type="hidden" name="stt" value="<% request("stt") %>">
  <input type="hidden" name="st" value="<% request("st") %>">
  <input type="hidden" name="curso1" value="<% request("curso") %>">
  <div class="col-md-12 col-sm-12">
    <h1>Seleção de Pré-Inscritos - lista de turmas</h1>
    <div class="row">
      <div class="post-content overflow">
        <div class="col-sm-12 col-md-4">
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
        <div class="col-sm-12 col-md-4">
          <div class="single-blog single-column">
            <label for="st">Status curso</label>
            <select class="dropdown-toggle" name="st" id="st">
              <option value="0" <% if request("st")=0 then %> Selected  <% end if %>>TODOS</option>
              <option value="1" <% if request("st")=1 then %> Selected  <% end if %>>HABILITADO</option>
              <option value="2" <% if request("st")=2 then %> Selected  <% end if %>>DESABILITADO</option>
              <option value="3" <% if request("st")=5 then %> Selected  <% end if %>>CANCELADO</option>
            </select>
          </div>
        </div>
      </div>
    </div>
    <div class="post-content overflow">
      <div class="row">
        <div class="col-sm-12 col-md-4">
          <div class="single-blog single-column">
            <label for="stt">Status da turma</label>
            <select class="dropdown-toggle" name="stt" id="stt">
            </select>
          </div>
        </div>
        <div class="col-sm-12 col-md-4">
          <div class="single-blog single-column">
            <label for="data_inicial">Período - Inicio</label>
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
      <div class="col-md-2">
        <button id="bt_gerar" type="button" class="btn btn-xs btn-primary" ><i class="fa fa-asterisk fa-binoculars"></i> Gerar Relatório</button>
      </div>
    <div class="col-md-2">
      <button id="bt_excel" class="btn btn-xs btn-success" type="button" ><i class="fa fa-file-excel-o" style="font-weight:bold;color:#207245"></i>  Exportar</button>
	 </div>
      
      <div class="col-md-2">
        <button id="bt_menu" class="btn btn-xs btn-primary" type="button"  onClick="window.print();return false;"><i class="fa fa-print"></i> Imprimir</button>
      </div>
      <div class="col-md-2">
        <button id="bt_limpar" class="btn btn-xs btn-primary" type="button" ><i class="fa fa-trash"></i> Limpar</button>
      </div>
     
      <div class="col-md-6"></div>
    </div>
    <br>
    <br>
  </div>
  <div class="col-sm-12 overflow"></div>
  <div id="Grid"></div>
  <br>
  <br>
</div>
</body>
<script type="text/javascript">

$(function() {
		$("table").stupidtable();
		
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
		
		var st          = 0;
		var stt         = 0;
		var curso       = $("#curso").val();
		var turma       = 0;
		var data_inicial = $("#data_inicial").val();
		var data_final  = $("#data_final").val();
		
	CarregaCombos();
	});
	
	 
function CarregaCurso(){
		 
		 	var url = "Gestao_turmasJson.asp?opcao=1"
		
		 $.getJSON(url, function(cursos) { 
		
		 var options = "";
		   options += '<option value="0" selected >Selecione um Curso</option>';
            $.each(cursos, function(key, value){
               options += '<option value="' + value.COD_CURSO + '">' + value.TITULO + '</option>';
            });
		  
	
			$('#curso').html(options);
			var optionsInicia = '<option value="0" selected >TODOS</option>';
    		$('#turma').html(optionsInicia);
		     PopulaGrid();
		});
		 
 }
	 
function CarregaStatusTurma(){ 
		//Preenche combo status Turma
		 $.getJSON('Gestao_turmasJson.asp?opcao=3', function(status) { 
		
		 var options = "";
		 options += '<option value="0" selected >TODOS</option>';
            $.each(status, function(key, value){
               options += '<option value="' + value.COD_STATUS_TURMA + '">' + value.STATUS_TURMA + '</option>';
            });

			$('#stt').html(options);
		
		});
	
}
	
	
	
	function CarregaCombos(){
		
		CarregaCurso();		
		CarregaStatusTurma();
		CarregaTurma();
		
		
		} 
	
	
	function CarregaTurma(){
		
		
		$.getJSON('Gestao_turmasJson.asp?opcao=2&curso=0', function(cursos) { 
		
		 var options = "";
		 	 options += '<option value="0" selected >TODOS</option>';
            $.each(cursos, function(key, value){
               options += '<option value="' + value.ID_TURMA + '">' + value.CODIGO_TURMA + '</option>';
            });
	
		$('#turma').html(options);
			
	});
		
		
		}
	
/*	$('#turma').change(function(){
		PopulaGrid();
	});
	
	//Status Turma
	$('#st').change(function(){
		PopulaGrid();
	});
    $('#stt').change(function(){
		PopulaGrid();
	});
*/
	
	//Preenche Combo Turma e Grid
	$('#curso').change(function(){

		$.getJSON('Gestao_turmasJson.asp?opcao=2&curso=' + $('#curso').val(), function(cursos) { 
		
		 var options = "";
		 	 options += '<option value="0" selected >TODOS</option>';
            $.each(cursos, function(key, value){
               options += '<option value="' + value.ID_TURMA + '">' + value.CODIGO_TURMA + '</option>';
            });
	
		$('#turma').html(options);
		//PopulaGrid();
		});
		
	});


    $("#bt_gerar").click(function(){
		
		
		PopulaGrid();
		
      });

	 function PopulaGrid() {
        
				  var text = "Carregando, Aguarde!";
                  waitingDialog.show(text);


			var urlCurso = "Gestao_turmasJson.asp?opcao=4&ord=&" +  CarregarParamentros();
				var  CursosLista;
				$.getJSON(urlCurso, function(data) {
					
					CursosLista =  data;
					
				});
			       
    	 
		  var umaUrl =  "Gestao_turmasJson.asp?opcao=5&" +  CarregarParamentros();
		  
			
          
			var contador = 0;
			var tabela ="";
          $.getJSON(umaUrl, function(data) { 


				 tabela = tabela + "<table  class='table table-condensed  table-striped filha'>"
				 "<caption> Total de Cursos: " + contador + "</caption>"
				     tabela = tabela + "<thead>"
					tabela = tabela + "<tr >"		
							tabela = tabela + "<th colspan='5' data-sort='string'>Curso</th>"
							tabela = tabela + "<th data-sort='string'>Tipo</th>"
							tabela = tabela + "<th data-sort='string' >Status Curso</th>"
					tabela = tabela + "</tr>"
					tabela = tabela + "</thead>"
					tabela = tabela + "<tbody >"
    				
		       $.each(CursosLista, function(key, value){
				
				
					tabela = tabela + "<tr class='titulo' >"		

						tabela = tabela + "<td colspan='5' aling='center'><a href='cad_turmas.asp?cod=" + value.COD_CURSO + "'>" + value.TITULO + "</a></td>"
						tabela = tabela + "<td>" + value.TDESC + "</td>"
						tabela = tabela + "<td>" + value.SDESC +"</td>"
    				tabela = tabela + "</tr>"
					
	    						
									tabela = tabela + "<tr class='neta'>"
										tabela = tabela + "<th >Codigo da Turma</th>"
										tabela = tabela + "<th>Data de Inicio</th>"
										tabela = tabela + "<th>Data de Término</th>"
										tabela = tabela + "<th>Status</th>"
										tabela = tabela + "<th>Nome Breve</th>"
										tabela = tabela + "<th>Modalidade</th>"
										tabela = tabela + "<th>Alunos</th>"
									tabela = tabela + "</tr>"
		                		tabela = tabela + "<tbody class='filha'>" // corpo da filha
							
				    
				   
 
									$.each(data, function(key, value1){
										
										totAlunos = 0;
										if(value1.ALUNOS == null){ 
										totAlunos  = 0 ;
										}
										else{
											totAlunos = value1.ALUNOS;
											}
										
										
									 if(value.COD_CURSO == value1.COD_CURSO){
										 tabela = tabela + "<tr>"
										tabela = tabela + "<td><a href='cad_turmas.asp?tur=" + value1.ID_TURMA +"&cod_curso='" + value1.COD_CURSO + "'>"+ value1.CODIGO_TURMA +"</td>"
										tabela = tabela + "<td>" + value1.DT_INICIO_TURMA +"</td>"
										tabela = tabela + "<td>" + value1.DT_FIM_TURMA    +"</td>"
										tabela = tabela + "<td>" + value1.STATUS_TURMA    +"</td>"
										tabela = tabela + "<td>" + value1.NOME_BREVE      +"</td>"
										tabela = tabela + "<td>" + value1.TDESC           +"</td>"
										tabela = tabela + "<td><a href='gestao_selecao.asp?id_turma=" + value1.ID_TURMA +"&cod_curso=" + value1.COD_CURSO + "'>"+ totAlunos  +"</td>"
										tabela = tabela + "</tr>"
										
									 }
						
									 });
									 
		    tabela = tabela + "</tbody>"
						contador++;	
			   
			   });
			    
		 tabela = tabela + "</tbody>"
				
				if(contador==0){ 
					 tabela  = ""
					 tabela = tabela + "<table  class='table table-condensed  table-striped filha'>"
				     tabela = tabela + "<thead>"
					tabela = tabela + "<tr >"		
							tabela = tabela + "<th >Curso</th>"
							tabela = tabela + "<th >Tipo</th>"
							tabela = tabela + "<th >Status Curso</th>"
					tabela = tabela + "</tr>"
					tabela = tabela + "</thead>"
					tabela = tabela + "<tbody>"
					 					
				
					 tabela = tabela + "<tr><td colspan='3'><div class='alert alert-danger'>Não há registro para exibição</div><td></tr>"
					 tabela = tabela + "</tbody>"
				
										
					}
				
	tabela = tabela + "</table>"	
		 $("#Grid").html(tabela);
		 
		 waitingDialog.hide();
		 
	 });
	
	}
	
	
	function CarregarParamentros(){
		
	
		 st          = 0;
		 stt         = 0;
		 curso       = $("#curso").val();
		 turma       = 0;
		 data_inicial = $("#data_inicial").val();
		 data_final  = $("#data_final").val();
		
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
		
	

		if ($("#turma").val() != null){
			turma = $("#turma").val();
		}
		
		
		
		if ($("#st").val() != 0){
			st = $("#st").val();
		}
    
	
		if ($("#stt").val() != null){
			stt = $("#stt").val();
			
		}
	
		if(data_inicial != ""){
		data_inicial = dataSemFormatcao(data_inicial);
		}

		if(data_final != ""){
		 data_final = dataSemFormatcao(data_final);
		}


	
	var	url = 'st='         + st         + '&';
		url = url + 'stt='        + stt        + '&';
		url = url + 'curso='      + curso      + '&';
		url = url + 'turma='      + turma      + '&';
		url = url + 'data_inicial=' + data_inicial+ '&';
		url = url + 'data_final='+ data_final  +"";    
		
		
		return url;
	}
	



$("#bt_limpar").click(function(){

	$("#curso").val(0);
	$("#turma").val(0);
	$("#st").val(0);
	$("#stt").val(0);
	$("#data_inicial").val("");
	$("#data_final").val("");
	
	CarregaCombos();
	 PopulaGrid();
	
});


function dataSemFormatcao(umaData){
	
		var data = umaData.split("/");
		return data[2]+data[1]+data[0] ;
	
}



$("#bt_excel").click(function(){
	var umaUrl = "gestao_turmas_excel.asp?opcao=4&ord=&" +  CarregarParamentros();
	
	window.open(umaUrl);
	
	});

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
	background-color:#d9edf7;
	color:#000;
}
.titulo {
	height:50px;
}
.titulo td {
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
th[data-sort] {
	cursor:pointer;
}
.collapsed {
	display: none;
}
label {
	width:100px;
	font-size:11px;
}
</style>
<script>

$('thead').on('click', function(){
    $(this).next('tbody').toggleClass('collapsed');
});
</script>
<script src="scripts/popUpDialogo.js"></script>
<script src="scripts/stupidtable.min.js?dev"></script>
</html>
