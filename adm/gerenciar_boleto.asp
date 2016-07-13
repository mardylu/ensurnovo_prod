<%If session("key_ver")<>"ok" Then Response.Redirect "logout.asp"%>
<% SIGA_PROJETO=Session("siga_projeto") %>
<html lang="pt-BR">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>ENSUR Gerador de Boletos do Aluno</title>
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
</head>

<body>
<div id="ckmt"> 
  <!-- #INCLUDE FILE="include/topo.asp" -->
  
  <div class="col-md-12 col-sm-12">
    <h1>Gerador de Boletos do Aluno</h1>
  </div>
  <div class="col-md-12 col-sm-12">
    <div class="post-content overflow">
      <div class="col-sm-12 col-md-1">
        <label for="curso">Nome</label>
      </div>
      <div class="col-sm-5 col-md-4">
        <input type="text" id="nome" name="nome" placeholder="Nome do aluno" class="form-control">
      </div>
      <div class="col-sm-12 col-md-2">
        <label for="turma">CPF/ Identidade</label>
      </div>
      <div class="col-sm-12 col-md-4">
        <input class="form-control" name="cpf" placeholder="" id="cpf">
        </select>
        Nº de identidade somente para estrangeiros </div>
    </div>
  </div>
  <div class="col-sm-12 col-md-12 ">
    <div class="post-content overflow">
      <button id="bt_gerar" type="button" class="btn  btn-primary" ><i class="fa fa-asterisk fa-binoculars"></i> Gerar Relatório</button>
    </div>
  </div>
  <div class="col-sm-12 overflow fieldset">
    <div id="table">

	 <table  class='table table-condensed  table-striped filha'>
							 <caption id="totalizador"></caption>
								 <thead>
								<tr >	
										<th colspan='5' data-sort='string'>Aluno</th>
										<th data-sort='string'>CPF</th>
										<th data-sort='string' >Data de Nascimento</th>
								</tr>
								</thead>
                                <tbody id="corpo">
                                
                                </tbody>
                                </table>
    
    </div>
    <br>
  </div>
</div>

<script   >

$(function() {
	//	$("table").stupidtable();
});
$("#bt_gerar").click(function(){
 var baseUri  = "gerencia_funcoes.asp?"	
		 var url = baseUri +  "task=pesquisa_aluno&cpf=" + $("#cpf").val() + "&nome=" + $("#nome").val() + "";
		
		$.getJSON(url, function(alunos) { 
			CarregaGrid(alunos);
			
		});
});


 
 
 function CarregaGrid(alunosLista){
	 
	 	  var text = "Carregando, Aguarde!";
                  waitingDialog.show(text);
			
          
			var contador = 0;
			var tabela ="";
					
					
				 $.each(alunosLista, function(key, value){
						tabela = tabela + "<tr class='titulo' >"		
						
							tabela = tabela + "<td colspan='5' aling='center'><a href='altera_aluno.asp?cod=" + value.COD_ALUNO + "'>" + value.NOME + "</a></td>"
								tabela = tabela + "<td>" + value.CPF + "</td>"
								tabela = tabela + "<td>" + value.DT_NASCIMENTO +"</td>"
							tabela = tabela + "</tr>"
				
							contador++;
				
							var urlCurso = "gerencia_funcoes.asp?task=pesquisa_turma&cod_aluno=" + value.COD_ALUNO ;
							
							$.getJSON(urlCurso, function(data) {
								
								
												tabela = tabela + "<tr class='neta'>"
													tabela = tabela + "<th >Codigo da Turma</th>"
													tabela = tabela + "<th>Data de Inicio</th>"
													tabela = tabela + "<th>Data de Término</th>"
													tabela = tabela + "<th>Status</th>"
													tabela = tabela + "<th>Nome Breve</th>"
													tabela = tabela + "<th>Forma Pgt</th>"
													tabela = tabela + "<th>Enviar Boleto</th>"
												tabela = tabela + "</tr>"
											
																
											  $.each(data, function(key, value1){	
												
												 if(value.COD_ALUNO == value1.COD_ALUNO){
													 tabela = tabela + "<tr>"
														tabela = tabela + "<td><a href='cad_turmas.asp?tur=" + value1.ID_TURMA +"&cod_curso='" + value1.COD_CURSO + "'>"+ value1.CODIGO_TURMA +"</td>"
														tabela = tabela + "<td>" + value1.DT_INICIO_TURMA +"</td>"
														tabela = tabela + "<td>" + value1.DT_FIM_TURMA    +"</td>"
														tabela = tabela + "<td>" + value1.STATUS_TURMA    +"</td>"
														tabela = tabela + "<td>" + value1.NOME_BREVE      +"</td>"
														tabela = tabela + "<td>" + value1.FORMA_DE_PAGAMENTO   +"</td>"
														tabela = tabela + "<td> </td>"
													 tabela = tabela + "</tr>"
													
												 }
											});
											
										
									});	
							 });
					
				
				
				if(tabela==""){ 
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
					
						$("#corpo").html(tabela);		
						$("#totalizador").html(" Total de alunso encontrados: " + contador);
				

		 
			
			console.log(tabela);
			
		 waitingDialog.hide();
		 
		 
	 }
</script>

</body>

<style>


table {
	
width:	98%;
	}
.filha td, th {
  
	font-size:14px;
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
	font-size:13px;
}
</style>

<script src="scripts/popUpDialogo.js"></script>
<script src="scripts/stupidtable.min.js?dev"></script>
</html>
