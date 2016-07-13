<!-- #INCLUDE FILE="includes/parametros.asp" -->
<!-- #INCLUDE FILE="includes/conOpen.asp" -->

<%
id_turma = request("id_turma")
cod_aluno = request("cod_aluno")

' sql = "select * from turma_aluno where id_turma="&id_turma&" and cod_aluno="&cod_aluno
sql = "select * from turmas where id_turma="&id_turma
RS.open sql
if not RS.eof then
	cod_curso=RS("cod_curso")
end if
RS.close

sql="select * from curso where cod_curso="&cod_curso
RS.open sql
if not RS.eof then
	TITULO = rs("titulo")
end if
RS.close

sql="select * from aluno where cod_aluno="&cod_aluno

RS.open sql
if not RS.eof then
	NOME = rs("NOME")
end if
RS.close

%>
<html>

  <head>
    <link rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="css/pg_cadastro_main.less.css" class="main-less">
    <meta charset="iso-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">

    <script src="intelxdk.js"></script>
    <script src="js/app.js"></script>
    <script type="application/javascript" src="lib/jquery.min.js"></script>
    <script type="application/javascript" src="marginal/marginal-position.min.js"></script>
    <script type="application/javascript" src="js/pg_fullinfo_user_scripts.js"></script>
    <script type="application/javascript" src="bootstrap/js/bootstrap.min.js"></script>
  </head>

  <body>

    <div class="upage" id="mainpage">
		<div id="topo">
			<div id="logo"></div>
		</div>
		<div class="upage-outer">
            <div class="upage-content ac0 content-area vertical-col" id="page_67_73">

                <div class="panel-heading">
                  	<h3 class="panel-title-page">
    	           		<p><center><strong><font face="arial" size="6" color="#668130">PRÉ-INSCRIÇÃO</font></strong></center></p>
           			</h3>
                </div>


                <div id="painel_2" class="panel-collapse collapse in">
                    <div class="panel-body">

                        Prezado(a) Sr(a). <% =NOME %>
                        <br><br>
                        Sua pré-inscrição já foi efetuada anteriormente. Atualizamos os seus dados com as informações enviadas neste momento.
                        Qualquer dúvida, entre em contato conosco: pqga-ead@ibam.org.br ou pelo telefone (21) 2536-9774
                        ou 2536-9737
                        <br><br>
                        Cordialmente,
                        <br>
                        PQGA - Programa de Qualificação Gestão Ambiental - Municípios Bioma Amazônia
                        <br>
                        IBAM - Instituto Brasileiro de Administração Municipal
                        <br><br><br><br>
                        <table border="0" width="100%">
                            <tr height="40" align="right">
                                <td bgcolor="#308185">
                                    <a href="http://www.amazonia-ibam.org.br/">
                                       <font color="#FFFFFF">voltar </font>
                                    </a>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

  </body>

</html>