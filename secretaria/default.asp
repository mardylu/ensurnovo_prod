<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!-- #INCLUDE FILE="../library/parametros.asp" -->
<!-- #INCLUDE FILE="../library/conOpen.asp" -->
<!-- #INCLUDE FILE="../library/conOpenSIM.asp" -->
<!-- #INCLUDE FILE="../library/fErroMsg.asp" -->
<!-- #INCLUDE FILE="../library/fFormataValor.asp" -->
<!-- #INCLUDE FILE="../library/fPagamentos.asp" -->
<!-- #INCLUDE FILE="../library/fData.asp" -->

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

	<link rel="stylesheet" type="text/css" href="../css/styles1.css" />
	<link rel="stylesheet" type="text/css" href="../css/form1.css" />
	<script type="text/javascript">
	function submitForm() {
		
		//document.parcForm.submit();
		return false;
	}

	tinyMCE.init({
		// General options
		mode : "exact",
		elements : "info",
		theme : "advanced",
		plugins : "autolink,lists,advlink,contextmenu,paste,directionality,fullscreen,noneditable,nonbreaking,inlinepopups",

		// Theme options
		theme_advanced_buttons1 : "bold,italic,underline,strikethrough,|,bullist,numlist,|,outdent,indent,blockquote,|,undo,redo,|,link,unlink,|,code,fullscreen",
		theme_advanced_buttons2 : "",
		theme_advanced_buttons3 : "",
		theme_advanced_buttons4 : "",
		theme_advanced_toolbar_location : "top",
		theme_advanced_toolbar_align : "left",
		theme_advanced_statusbar_location : "bottom",
		theme_advanced_resizing : true
	});
	 function newDoc1(opcao) {
		 opcao=document.form.opcao.value;
		 if (opcao > 0) {
			 url = 'requerimento.asp?opcao=';
			 url = url + opcao + '&id='
			 url = url + <% =session("id") %>
			 window.location=url;
	 	}
	 }
	</script>
	<script>
		function openWindow2(opcao) {
		if (opcao == 's') {
			myVar=open('esqueci_visitante.asp','PASSWORD','scrollbars=yes,width=300,height=140'); 
		}
		if (opcao == 'c') {
			myVar=open('cadastro_adm.asp','PASSWORD','scrollbars=yes,width=900,height=800');
		}
	}
	</script>

<title>ENSUR Inscrições</title>
</head>
<body>
<div id="pagina">
	<!-- #INCLUDE FILE="../include/topo_visitante.asp" -->
	<div id="conteudo">
		<h1>SECRETARIA ENSUR</h1><br>
		<h3>
        <span style="font-weight:bold;">
        Área para solicitação de requerimentos e comprovantes de alunos e ex-alunos da Escola Nacional de Serviços Urbanos – ENSUR.
        </span>
        </h3>
        <br><br>
		<%if session("pass")<>"ok" then%>
			<form action="login_visitante.asp" method="post" name="login">
			<fieldset>
				<legend>entre com seus dados</legend>
				<p><label for="CPF" class="requerido">CPF</label><input type="text" name="CPF" id="CPF" maxlength="11" size="12" onKeyPress="return ValidateKeyPressed('INT', this, event);"> somente números</p>
				<p><label for="PASSWORD" class="requerido">SENHA</label><input type="password" name="PASSWORD" id="PASSWORD" maxlength="20" size="12"></p>
				<p><label for="ENVIAR">&nbsp;</label><input type="submit" name="submit" value="Enviar" class="buttonF">
				<p><a href="javascript:openWindow2('s');">Esqueci minha senha</a></p>
				<p><a href="javascript:openWindow2('c');">Caso ainda não esteja cadastrado, e queira se cadastrar como cliente do IBAM clique aqui>></a></p>
			</fieldset>
			</form>
		<%
		else
			if session("id") > 0 then
			else
				session("id") = request("ID_VISITANTE")
			end if
			sql = "SELECT NOME,CPF FROM ALUNO WHERE COD_ALUNO="&session("id")
			RS.Open sql
		
				if RS.EOF then
					%><p>Seu cadastro não foi encontrado em nossa base. Faça um novo login. Caso o erro persista, favor entrar em contato com o IBAM.</p><%
				else
					NOME = RS("NOME")
					CPF = RS("CPF")
				end if
			RS.Close
			%>
			<h2><%=NOME%></h2>
			<p><br /></p>
			<form name="form" action="requerimento.asp?op=1" method="get">
			<select name="opcao" onChange="newDoc1(this.value);">
			<option value="0">Selecione o requerimento</option>
			<% 
			sql = "SELECT * FROM TIPO_REQUERIMENTO"
			RS.open sql
			while not RS.eof
				%>
				<option value="<% =RS("TIPO_REQUERIMENTO")%>" <% if INT(opcao)=RS("TIPO_REQUERIMENTO") then %> Selected  <% end if %>><% =RS("REQUERIMENTO")%></option>
				<%
				RS.movenext
			wend
			RS.close
			%>
			</select>
			</form>			
			<%
		end if
		%>
	<!-- #INCLUDE FILE="../include/footer.asp" -->
</div>
</body>
</html>
<%conClose%>



