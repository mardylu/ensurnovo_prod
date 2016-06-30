<%If session("key_ver")<>"ok" Then Response.Redirect "logout.asp"%>
<% SIGA_PROJETO=Session("siga_projeto") %>
<html lang="pt-BR">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>ENSUR - Área de Atuação</title>
<link href="content/css/main.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="content/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="content/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css" href="css/jquery-ui.css">
<script src="scripts/jquery-1.11.3.min.js" type="text/javascript"></script>
<script src="content/js/bootstrap-modal.js"></script>
<script src="scripts/popUpDialogo.js"></script>
<% SIGA_PROJETO=Session("siga_projeto") %>
</head>

<body>
<div id="ckmt" > 
  <!-- #INCLUDE FILE="include/topo.asp" -->
  
  <div class="panel widget uib_w_9 panel-info ">
    <div class="panel-heading">Cadastro de Área de Atuação</div>
    <input type="hidden" id="id" />
    <div class="row">
      <div class="post-content overflow">
        <div class="col-sm-12 col-md-12">
          <div class="single-blog single-column">
            <label>Descricao</label>
            <input type="text" id="descricao" name"descricao" class="span2"/>
          </div>
        </div>
      </div>
    </div>
    <div class="row">
      <div class="post-content overflow">
        <div class="col-sm-12 col-md-12">
          <div class="single-blog single-column">
            <label>Ativo</label>
            <input type="checkbox" id="Ativo" name"Ativo" value="" >
            </input>
          </div>
        </div>
      </div>
    </div>
    <br />
    <div class="col-sm-12 col-md-12">
              <div class="row">
                <div class="col-sm-12 col-md-12">
                    <div class="col-md-2">
                       <a href="#" class="btn btn-primary " onClick="" id="gravar"><i class="fa fa-save "></i> Salvar</a>
                    </div>
                  <div class="col-md-2">
                    <a href="#" class="btn btn-primary " onClick="" id="limpar"><i class="fa fa-trash "></i> Limpar</a> 
                  </div>
             
               
            </div>
          </div>
      </div>
    <div class="row"> <br />
      <br />
    </div>
  </div>
  <br />
  <div class="container-fluid">
    <table id="" class="table  table-striped">
    <caption></caption>
      <thead>
      <th>Descrição</th>
      <th>Ativo</th>
        <th>Ação</th>
          </thead>
      <tbody id="tbody">
      </tbody>
    </table>
  </div>
</div>
</div>
<script type="text/javascript">


$().ready(function(){
	
	CarregaGrid();
	
	});
	
	
	function CarregaGrid(){
	
			  waitingDialog.show("Carregando, Aguarde!");
				 setTimeout(function () { waitingDialog.hide();}, 2000);
				 
			  	var umaUrl = "funcao_crudJson.asp?opcao=4&descricao='" +  $("#descricao").val() + "'";
				
				var tabela = "";
				var contador = 0;
 			$.getJSON(umaUrl, function(data) {
				
					$.each(data, function(key, value){
						
							tabela = tabela + "<tr >"
								tabela = tabela + "<td >" + value.DESCRICAO + "</td>"
								tabela = tabela + "<td>" + value.Ativo + "</td>"
								tabela = tabela + "<td><a href='#' value='"+ value.Id +"_"+ value.DESCRICAO +"_"+ value.Ativo  + "' class='btn btn-warning btn-sm-6 btnEditar'><i class='fa fa-edit '></i> Editar</a></td>"
							tabela = tabela + "</tr>"
								contador++;
				
						});
						
						$("#tbody").html(tabela);
						$("caption").html("Total de Registros: " + contador);
						$(".btnEditar").bind("click", editar);   
			});
			
			
		

		}
		
		
		function editar(){
			  var par = $(this).attr("value"); //tr
			  var arr = par.split("_");
		
		
			$("#descricao").val(arr[1]);
		    $("#id").val(arr[0]);
			if(arr[2] == 'Sim'){
				$("#Ativo").prop("checked",true);
				}
			else {
				$("#Ativo").prop("checked",false);
				}	
			$("#gravar").html("<i class='fa fa-save'></i> Editar").removeClass("btn-primary").addClass("btn-warning")
			
		}


$("#gravar").click(function(){
	
	var umaUrl  = "";
	
	if($("#descricao").val() == ""){
			waitingDialog.show("Informe uma descrição!");
			 setTimeout(function () {  waitingDialog.hide(); }, 2000);
		return;
		}
	
	var ativo =  $("#Ativo").is(":checked");
	
		if($("#id").val() != ""){
			umaUrl= "funcao_crudJson.asp?opcao=5&descricao='" +  $("#descricao").val() + "'&id=" + $("#id").val() +"&Ativo=" + ativo;
		}else{
			umaUrl= "funcao_crudJson.asp?opcao=6&descricao='" +  $("#descricao").val() + "'";
		}
		
		var urlFinal = encodeURI(umaUrl);
		waitingDialog.show("Dados atualizados com sucesso!");
		$.getJSON(urlFinal, function(data) {
			
			
			 $("#descricao").val("");
			 $("#id").val("");
			 $("#Ativo").prop("checked",true);
			$("#gravar").html("<i class='fa fa-save'></i> Gravar").removeClass("btn-warning").addClass("btn-primary")
		});

		 setTimeout(function () { CarregaGrid(); }, 2000);

	

});

$("#limpar").click(function(){
	
	Limpar();
	
	});

function Limpar(){
	
	 $("#descricao").val("");
			 $("#id").val("");
			 $("#Ativo").prop("checked",true);
			$("#gravar").html("<i class='fa fa-save'></i> Gravar").removeClass("btn-warning").addClass("btn-primary")
	}
</script>
</body>
</html>
