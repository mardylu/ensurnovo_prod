
<%If session("key_ver")<>"ok" Then Response.Redirect "logout.asp"%>

<% 
SIGA_PROJETO=Session("siga_projeto") 

if Session("key_sta")="ok" or Session("key_ema")="ok" or Session("key_plc")="ok" or Session("key_plp")="ok" then
	mostraSel = true
else
	mostraSel = false
end if


%>

<input type="hidden" id="mostraSel" value="<% Response.Write(mostraSel) %>" />

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
   <script src="content/js/bootstrap-modal.js"></script>




</head>
<body>
<% 
SIGA_PROJETO=Session("siga_projeto") 

if Session("key_sta")="ok" or Session("key_ema")="ok" or Session("key_plc")="ok" or Session("key_plp")="ok" then
	mostraSel = true
else
	mostraSel = false
end if


%>

<input type="hidden" id="mostraSel" value="<% Response.Write(mostraSel) %>" />

<style>
.filha td, th {
  
	font-size:12px;
	text-align:center !important;

}

.filha td {
  
	font-size:10px;
	text-align:left !important;

}

.filha tbody {
	border-left: border: 1px solid #666;
	border-right: border: 1px solid #666;
	font-size:10px;
}

.filha th {    border: 1px solid #FFF; background: #2e6da4; color:#fff;}

.filha .neta th {    border: 1px solid #FFF; background-color:#AFE3F8; color:#000; }

.filha {

    width: 99%;
    border-collapse: collapse;
	margin-left:5px;
}

.filha .neta {

    width: 100%;
    border-collapse: collapse;
}

.collapsed {
    display: none;
}

.filha a {
	
	color: #fff;
}
	
.filha td a {
	
	color: #000;
	font-size:10px;

	}	
	
caption {

    padding: 0px 5px;
    margin: 0 0 5px;
    font-size: 12.5px;
    border-left: 5px solid #eee
	
	
}	

  
 th[data-sort]{
     cursor:pointer;
}
label{

	width:120px;
	font-size:11px;
}

    #msg {
      color: #0a0;
      text-align: center;
    }
</style>

<div id="ckmt">
	<!-- #INCLUDE FILE="include/topo.asp" -->
   <input type="hidden" id="codigo" value="<% Response.Write(Request.QueryString("id_turma")) %>" />
   <input type="hidden" id="cod_curso" value="<% Response.Write(Request.QueryString("cod_curso")) %>" />
   
   <input type="hidden" id="siga_projeto" value="<% Response.Write(Session("siga_projeto") ) %>" />
      <input type="hidden" id="tipoExibicao" value="1" />
   
  
   <div class="col-md-9 col-sm-7">
    <h1>Seleção de Pré-Inscritos - lista de alunos</h1>
    <div class="row">
     <div class="post-content overflow">
         <div class="col-sm-12 col-md-12">
            <div class="single-blog single-column">
                   <label for="tipoInstituicao">Tipo de Instituição</label>
                   <select class="dropdown-toggle"  id="tipoInstituicao" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"></select>
            </div>
        </div>
        <div class="col-sm-12 col-md-12">
            <div class="single-blog single-column">
                  <label for="tipoAtuacao">Tipo de Atuação</label>
                  <select class="dropdown-toggle" type="button" id="tipoAtuacao" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"></select>
            </div>
        </div>
        <div class="col-sm-12 col-md-12">
            <div class="single-blog single-column">
                <label for="escolaridade">Escolaridade</label>
               <select class="dropdown-toggle" type="button" id="escolaridade" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"></select>
            </div>
        </div>
             <div class="col-sm-12 col-md-12">
                <div class="single-blog single-column">
                    <label for="prioridade">Prioridade</label>
                      <select class="dropdown-toggle" type="button" id="prioridade" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        <option value="todas">Todas</option>
                        <option value="Baixa">Baixa</option>
                        <option value="Media">Média</option>
                        <option value="Alta">Alta</option>
                        <option value="Prioritaria">Prioritária</option>
                      </select>
                </div>
            </div>
             <div class="col-sm-12 col-md-12">
                <div class="single-blog single-column">
                   <label for="bioma">Bioma</label>
                    <input type="radio" class="ui-icon-radio-on" name="bioma1" checked value="2" >Todos</input>
                    <input type="radio" class="ui-icon-radio-on" name="bioma1" value="1" >Sim</input>
                    <input type="radio" class="ui-icon-radio-on" name="bioma1" value="0">Não</input>
    
                </div>
            </div>
              <div class="col-sm-12 col-md-12">
                <div class="single-blog single-column">
                    <label for="servidor">Servidor</label>
                    <input type="radio" class="ui-icon-radio-on" name="servidor1" checked value="2" >Todos</input>
                    <input type="radio" class="ui-icon-radio-on" name="servidor1" value="1" >Sim</input>
                    <input type="radio" class="ui-icon-radio-on" name="servidor1" value="0">Não</input>
                </div>
            </div>
             <div class="col-sm-12 col-md-12">
                <div class="single-blog single-column">
                    <label for="termo">Termo de Compromisso</label>
                    <input type="radio" class="ui-icon-radio-on" name="termo1" checked value="2" >Todos</input>
                    <input type="radio" class="ui-icon-radio-on" name="termo1" value="1" >Sim</input>
                    <input type="radio" class="ui-icon-radio-on" name="termo1" value="0">Não</input>
                </div>
            </div>
         </div>
    
      
            <div class="col-sm-12 col-md-12">
              <div class="row">
                <div class="col-sm-12 col-md-12">
                    <div class="col-md-2">
                        <button id="bt_gerar" type="button" class="btn btn-xs btn-primary" ><i class="fa fa-asterisk fa-binoculars"></i> Gerar Relatório</button>
                    </div>
                  <div class="col-md-2">
                    <button id="bt_menu" class="btn btn-xs btn-primary" type="button"  onClick="window.print();return false;"><i class="fa fa-print"></i> Imprimir</button>
                  </div>
             
                   <div class="col-md-2">
                    <button id="bt_limpar" class="btn btn-xs btn-primary" type="button" ><i class="fa fa-trash"></i> Limpar</button>
                  </div>
                   <div class="col-md-2">
                   <a href="gestao_turmas.asp?ord=tt&st=0" class="btn btn-xs btn-primary"><i class="fa fa-undo"></i> Voltar</a>

                  </div>
            </div>
          </div>
      </div>
    
    
   </div>
</div>

    <div class="col-md-3 col-sm-5" >
    	<div class="row">
        <div class="sidebar blog-sidebar" >
            <div class="sidebar-item  recent">
               <div class="media">
                     <div class="media-body">
                          <div id="cursoLabel" ></div>
                     </div>
               </div>   
               <div class="media">
                     <div class="media-body">
						<div id="codigoTurmaLabel" > </div>
                     </div>
               </div>   
               <div class="media">
                     <div class="media-body">
						<div id="periodoLabel" > </div>
                     </div>
               </div>   
               <div class="media">
                     <div class="media-body">
						<div id="situacaoLabel" ></div>
                     </div>
               </div>

    </div>                
  </div>
 </div>
</div>  
 <div id="grid">
  				<div class="col-sm-12 overflow">
                   <div class="social-icons pull-right">
                        <ul class="nav nav-pills">
                        <li id="msg"></li>
                            <li><a href="#" id="geral" class="collapsed" title="Lista Geral de Alunos"><i class="fa fa-list" style="color:blue"></i></a></li>
                            <li><a href="#" id="alunos" class="collapsed" title="Nomes de Alunos"><i class="fa fa-user" style="color:blue"></i></a></li>
                            <li><a href="#" id="participantes" title="Lista de Participante"><i class="fa fa-users" style="color:blue"></i></a></li>
                            <li><a href="#" id="planilha" title="Gerar Planilha"><i class="fa fa-file-excel-o" style="font-weight:bold;color:#207245"></i></a></li>
                            <li><a href="#" id="mudar" title="Mudar de Turma"><i class="fa fa-arrow-circle-o-right" style="font-weight:bold;color:red"></i></a></li>
                            
                        </ul>
                    </div> 
                </div>
  
            <table id="tableFilha" class="table table-responsive table-condensed filha" >
            <caption class="caption" ></caption>
            <thead>
				<tr>
                   <th id="colunaCheck" class="check"><input type="checkbox" name="main" value="1"></th>
                    <th data-sort="string" >Nome</th>
     				<th data-sort="string" class="header">Tipo Instituição</th>
				    <th data-sort="string" class="header">Nome Instituição</a></th>
                    <th data-sort="string" class="header">Cargo</th>
				    <th data-sort="string" class="header">Área Atuação</th>
    				<th data-sort="string" class="header">UF Município</th>
    				<th data-sort="string" class="header">Prioridade </th>
    				<th data-sort="string" class="header">Escolaridade</th>

    	   		    <th data-sort="string" class="header" title="Servidor Efetivo sim n?o">SRV</th>
    	   		    <th data-sort="string" class="header" title="Aceite do Termo de Compromisso 1=sim 0=n?o">TC</th>
    	   			<th data-sort="string" class="header" title="Turma Finalizada">TF</th>
    	   			<th data-sort="string" class="header" title="Turma em Andamento">TN</th>
    	   			<th data-sort="string" class="header" title="Total Enturma??o">TE</th>
    	   			<th data-sort="string" class="header" title="Total de Aprova??es">TA</th>
    	   			<th data-sort="string" class="header" title="Total de Evas?es">TV</th>
    	   			<th data-sort="string" class="header" title="Total de Reprova??es">TR</th>
    	   			<th data-sort="string" class="header" title="Total de Nunca Acessou">TS</th>

    			    <th data-sort="string" class="header">Bio</th>
				    <th data-sort="string" class="header"> Inscrição</th>
                    <th data-sort="string" class="participante collapsed">Telefone</th>
                    <th data-sort="string" class="participante collapsed">E-mail</th>
                    <th data-sort="string" class="participante collapsed">Entidade</th>
                    <th data-sort="string" class="participante collapsed">Função</th>
                    
              
                 </tr>
               </thead>
               <tbody id="dados">
             
               </tbody>
           	 </table>
                </br>
                </br>
  
  </div>
</div>


<div id="myModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  
    <div class="modal-dialog">
        <div class="modal-content">
		  <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span> <span class="sr-only">Close</span></button>
                 <h2>Tranferência de Aluno(s)</h2>
               <span class="row col-lg-12" id="totAlunos"></span>
               <span class="row col-lg-12 collapsed alert-success" id="totAlunosTranferidos"></span>
          </div>
            <div class="modal-body">
              <label for="turma">Turma</label>
              <select class="dropdown-toggle"  id="curso" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"></select>
             <button id="bt_enviar" class="btn btn-xs btn-success" type="button" ><i class="fa fa-floppy-o"></i> Confirmar</button>
           
            </div>
            
          <div class=" modal-footer panel-footer">
       		 pressione ESC para cancelar
        	</div>
        </div>
    
           
   </div>
</div>
</body>

<script>

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
	
 
	var date_from_string = function(str){
     
	 
        var DateParts = str.split('/');
        var Year = DateParts[2];
        var Month = DateParts[1];
        var Day = DateParts[0];
        return new Date(Year, Month, Day);
      }
      var moveBlanks = function(a, b) {
        if ( a < b ){
          if (a == "")
            return 1;
          else
            return -1;
        }
        if ( a > b ){
          if (b == "")
            return -1;
          else
            return 1;
        }
        return 0;
      };
      var moveBlanksDesc = function(a, b) {
        // Blanks are by definition the smallest value, so we don't have to
        // worry about them here
        if ( a < b )
          return 1;
        if ( a > b )
          return -1;
        return 0;
      };
      var table = $("table").stupidtable({
        "date":function(a,b){
          // Get these into date objects for comparison.
          aDate = date_from_string(a);
          bDate = date_from_string(b);
          return aDate - bDate;
        },
        "moveBlanks": moveBlanks,
        "moveBlanksDesc": moveBlanksDesc,
      });
	
	
			
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
						tabela = tabela + " <td class='header1 collapsed' >"  + value.UF_MUNICIPIO_PRIORIDADE         + "</td>"
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
	
						tabela = tabela + " <td class='header1 collapsed' >"+ value.UF_MUNICIPIO_BIO 				 +"</td>"
						tabela = tabela + " <td class='header1 collapsed' >"+ value.DT_CADASTRO		 +"</td>"
					}else{
							tabela = tabela + " <td class='header1' >"  + value.TIPO_INSTITUICAO + "</td>"
						tabela = tabela + " <td class='header1' >"  + value.NOME_INSTITUICAO + "</td>"
						tabela = tabela + " <td class='header1' >"  + value.CARGO 			 + "</td>"
						tabela = tabela + " <td class='header1' >"  + value.AREA_ATUACAO     + "</td>"
						tabela = tabela + " <td class='header1' >"  + value.UF_MUNICIPIO     + " </td>"
						tabela = tabela + " <td class='header1' >"  + value.UF_MUNICIPIO_PRIORIDADE       + "</td>"
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
	
						tabela = tabela + " <td class='header1' >"+ value.UF_MUNICIPIO_BIO 				 +"</td>"
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
			cod_curso		= 0;
			
			
		if ($("#tipoInstituicao").val() != 0){
			tipo_enti = $("#tipoInstituicao").val();
		}
		
		if ($("#tipoAtuacao").val() != 0){
			area_atu = $("#tipoAtuacao").val();
		}
		if ($("#cod_curso").val() != 0){
			cod_curso = $("#cod_curso").val();
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
			url = url + 'cod_curso='    + cod_curso      + '&';
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
		
		  var text = "Ops, não há alunos selecionados para transferência de turma!";
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
	
	if($("#curso").val()==0){
		
	   waitingDialog.show("Selecione uma Turma para transferência");
	   setTimeout(function () { waitingDialog.hide(); }, 5000); 
		return;		
	
	}
	
	
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
	
	 var umaUrl = CarregarParametros("gestao_selecao_excel.asp?opcao=4&");
	
	window.open(umaUrl);
	
	});

</script>


 <script src="scripts/popUpDialogo.js"></script>
<script src="scripts/stupidtable.min.js?dev"></script>



</html>
