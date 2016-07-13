<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!-- #INCLUDE FILE="../library/parametros.asp" -->
<!-- #INCLUDE FILE="../library/conOpen.asp" -->
<!-- #INCLUDE FILE="../library/conOpenSIM.asp" -->
<!-- #INCLUDE FILE="../library/fErroMsg.asp" -->
<!-- #INCLUDE FILE="../library/fFormataValor.asp" -->
<!-- #INCLUDE FILE="../library/fFormataCPF.asp" -->
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
		
		<table border = 0 width=100%>
			<tr><td width="90%"><h1>SECRETARIA ENSUR</h1></td><td width="10%">
			<a href="default.asp"><img src="../adm/img/btnp_seta_invet.gif" border="0"></a></td><td width="90%"></td></tr>
		</table>
		<h2>Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.</h2><br>
		<%
			sql = "SELECT A.COD_ALUNO,A.NOME,A.CPF,A.TIPOENTI,I.DESCRICAO,A.SETOR,A.CARGO,A.DT_NASCIMENTO,A.ENDERECO,A.COD_MUNI_IBGE,A.COD_UF_IBGE,M.NOME_MUNI,U.NOME_UF,U.SIGLA_UF FROM ALUNO A LEFT JOIN WEBSIMSQL.DBO.TIPO_ENTIDADE I ON A.TIPOENTI=I.ID_TIPO_ENTIDADE LEFT JOIN WEBSIMSQL.DBO.MUNICIPIOS M ON A.COD_MUNI_IBGE=M.COD_MUNI_IBGE AND A.COD_UF_IBGE=M.COD_UF_IBGE LEFT JOIN WEBSIMSQL.DBO.UF U ON A.COD_UF_IBGE=U.COD_UF_IBGE WHERE COD_ALUNO="&session("id")
			RS.open sql
		%>			
		<form action="salva_requerimento.asp" method="post" name="login">
			<input type="hidden" name="opcao" value="<% =request("opcao") %>">
			<fieldset>
				<legend>Requerimento</legend>
				
				<p>Eu, <% =RS("NOME") %>, CPF: <% =formatacpf(RS("CPF")) %>, (cargo/função) <% =RS("CARGO") %> na Instituição <% =RS("DESCRICAO") %>,  nascido em <% =FORMATADATA(RS("DT_NASCIMENTO")) %>, endereço <% =RS("ENDERECO") %>, <% =RS("NOME_MUNI") %> - <% =RS("SIGLA_UF") %>, venho, pelo presente, solicitar:
				<br>
				<br>
				<%
				RS.Close
				sql = "SELECT * FROM TIPO_REQUERIMENTO WHERE TIPO_REQUERIMENTO='"&request("opcao")&"'"
				RS.open sql
				%>
				<strong><% =RS("REQUERIMENTO") %></strong>
				<% RS.Close %>
				<p></p>
				Selecione seu curso:
				<select name="COD_CURSO" width="500" style="width: 500px">
					<option value="0">Não sei qual curso</option>
					<%
					RS.Open "SELECT COD_CURSO,TITULO FROM CURSO ORDER BY TITULO"
					While not RS.EOF'
						%><option value="<%=RS(0)%>"><%=right(RS(1),80)%></option><%
						RS.MoveNext
					Wend
					RS.Close
					%>
				</select>.
</p><br><p>
SOLICITAÇÃO / JUSTIFICATIVA:
<textarea name="JUSTIFICATIVA" id="JUSTIFICATIVA" cols="90%" rows="6"></textarea></p><br><p>
</p><br><p>
Data <% =day(date())&"/"&right("00"&month(date()),2)&"/"&year(date()) %>  -  <% =response.write(FormatDateTime(now(),vbshorttime)) %> 
				
				<p><label for="ENVIAR">&nbsp;</label><input type="submit" name="submit" value="Enviar" class="buttonF">
			</fieldset>
			</form>
			<br><br>
	<!-- #INCLUDE FILE="../include/footer.asp" -->
</div>
</body>
</html>
<%conClose%>



