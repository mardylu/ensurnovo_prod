<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>IBAM - Instituto Brasileiro de Administração Municipal</title>

<link rel="shortcut icon" href="<%=SITEURL%>media/img/favicon.ico" />
<link rel="icon" type="image/ico" href="<%=SITEURL%>media/img/favicon.ico" />
<link type="text/css" href="<%=SITEURL%>media/css/estilo.css" rel="stylesheet" media="screen" />
<!--[if IE]>
	<link type="text/css" href="<%=SITEURL%>media/css/estilo_ie.css" rel="stylesheet" media="screen" />
<![endif]-->
<!--[if IE 6]>
	<link type="text/css" href="<%=SITEURL%>media/css/estilo_ie6.css" rel="stylesheet" media="screen" />
<![endif]-->
<link type="text/css" href="<%=SITEURL%>media/css/externo.css" rel="stylesheet" media="screen" />
<link type="text/css" href="<%=SITEURL%>media/css/print.css" rel="stylesheet" media="print" />
<link type="text/css" href="css/estilo.css" rel="stylesheet" media="screen" />
<script type="text/javascript" src="<%=SITEURL%>media/js/jquery-1.4.1.min.js"></script>
<script type="text/javascript" src="<%=SITEURL%>media/js/jquery.maskedinput-1.2.2.min.js"></script>
<script type="text/javascript" src="<%=SITEURL%>media/js/jquery.cornerz.js"></script>
<script type="text/javascript" src="<%=SITEURL%>media/js/pngfix.js"></script>
<script type="text/javascript">
	var base_url = '<%=SITEURL%>';
</script>
<script type="text/javascript" src="<%=SITEURL%>media/js/estrutura.js"></script>
<script type="text/javascript" src="<%=SITEURL%>media/js/externo.js"></script>
</head>
<body>
<%Randomize%>
<div id="toplogo">
	<div class="coluna_central"><img id="logo_topo" src="<%=SITEURL%>media/img/topo/topo<%=Int((rnd*5))+1%>.png" /></div>
</div>
<div id="topfaixa">
	<div class="coluna_central">
		<div id="faixa_busca">
			<form action="<%=SITEURL%>busca" method="get" accept-charset="utf-8"><input type="text" id="busca" name="busca" value="" /><button type="submit" id="faixa_submit"></button></form>
		</div>
		<div id="faixa_menu">
			<ul>
				<li><a href="<%=SITEURL%>home">PRINCIPAL</a></li>
				<li><a href="<%=SITEURL%>info/institucional">INSTITUCIONAL<!--[if gte IE 7]><!--></a><!--<![endif]-->
					<ul id="ul_institucionais">
					</ul>
				</li>
				<li><a href="#">NOTÍCIAS<!--[if gte IE 7]><!--></a><!--<![endif]-->
					<ul>
						<li><a href="<%=SITEURL%>noticias">Informe</a></li>
						<li><a href="<%=SITEURL%>entrevistas">Entrevistas</a></li>
					</ul>
				</li>
				<li><a href="<%=MUNIURL%>">MUNICÍPIOS</a></li>
				<li><a href="<%=LIVROURL%>">LIVRARIA</a></li>
				<li><a href="#">CONTATO<!--[if gte IE 7]><!--></a><!--<![endif]-->
					<ul>
						<li><a href="<%=SITEURL%>info/contato/7">Fale Conosco</a></li>
						<li><a href="<%=SITEURL%>info/contato/8">Trabalhe Conosco</a></li>
					</ul>
				</li>
			</ul>
		</div>
	</div>
</div>
<br><br><br><br><br><br><br><br><br><br><br><br><br>
<div id="maincontainer">
	<div class="coluna_central">
		<div id="info">
			<div id="interna">
				<div id="interna_conteudo">