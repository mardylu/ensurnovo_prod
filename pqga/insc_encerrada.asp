
<!-- #INCLUDE FILE="../library/parametros.asp" -->
<!-- #INCLUDE FILE="../library/conOpen.asp" -->

<%

Response.Expires = 0
Response.CacheControl = "no-cache"
Response.AddHeader "Pragma", "no-cache"

ID_TURMA = request("id_turma")

sql_curso = "SELECT t.cod_curso, t.cod_status_turma, t.id_turma, c.titulo FROM turmas as T  "   & _
            "  JOIN curso as c ON c.cod_curso=t.cod_curso                                   "   & _
            " WHERE t.id_turma='" & id_turma & "'"
RS.open sql_curso
if not RS.eof then
	TITULO = RS("titulo")
end if
RS.close

%>

<html><head>
<!----	<link rel="stylesheet" type="text/css" href="insc_encerrada_536_arquivos/bootstrap.css">     ---->
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<!----		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">   ---->

    <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate">
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv="Expires" content="0">

  <style type="text/css">
    #legenda label {
      display:block; width:x; height:y; color:#FF0000; text-align:right;
    }
  </style>



  </head>

  <body>
    <div class="upage" id="mainpage">
		<div id="topo">
			<div id="logo">
                <center>
                <img src="./images/header_logo.png" alt="" />
                </center>
            </div>
		</div>
		<div class="upage-outer">
        <div style="top: 0px;" class="upage-content ac0 content-area vertical-col" id="page_67_73">
         
            <div class="panel-heading">
              	<h4 class="panel-title-page">
	           		<p></p><center><strong><font face="arial" color="#668130" size="6">INSCRIÇÃO ENCERRADA</font></strong></center><p></p>
       			</h4>
              	<h2 class="panel-title">
	           		<p></p><center><font face="arial" color="#668130" size="6">Curso: <% Response.Write (titulo) %> </font></center><p></p>
       			</h2>
                <br><br>
              	<h2 class="panel-title">
	           		<p></p><center><font face="arial" color="#668130" size="4">
                    Conheça nossos cursos a distância com inscrições abertas em:
                    </font></center><p></p>
       			</h2>
              	<h2 class="panel-title">
	           		<p></p><center><font face="arial" color="#668130" size="4">
                   Para saber sobre outros cursos com inscrições abertas click 
                    <a href="http://www.amazonia-ibam.org.br/linhas-de-acao/capacitacao-em-gestao-ambiental">
                   aqui
                    </a>
                    </font></center><p></p>
       			</h2>

<p></p><center><font face="arial" color="#668130" size="4">Em caso de dúvida, sugestão ou reclamação, entre em contato conosco: </br>
pqga-ead@ibam.org.br, (21)2536-9774 ou whatsapp (21) 99805-0696</font></center><p></p>

            </div>
        </div>
        </div>
    </div>


</body>
</html>