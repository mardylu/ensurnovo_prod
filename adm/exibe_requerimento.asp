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

<title>ENSUR Inscri��es</title>
</head>
<body>
<div id="pagina">
	<!-- #INCLUDE FILE="include/topo.asp" -->
	<div id="conteudo">
		<% sql = "SELECT R.ID_REQUERIMENTO,R.JUSTIFICATIVA,R.JUSTIFICATIVA_IBAM,R.HORA,R.COD_ALUNO,R.DATA,R.TIPO_REQUERIMENTO,R.STATUS,T.REQUERIMENTO,A.NOME,STATUS,A.COD_ALUNO,A.NOME,A.CPF,A.TIPOENTI,I.DESCRICAO,A.SETOR,A.CARGO,A.DT_NASCIMENTO,A.ENDERECO,A.COD_MUNI_IBGE,A.COD_UF_IBGE,M.NOME_MUNI,U.NOME_UF,U.SIGLA_UF,R.COD_CURSO,C.TITULO FROM REQUERIMENTO R JOIN TIPO_REQUERIMENTO T ON T.TIPO_REQUERIMENTO=R.TIPO_REQUERIMENTO LEFT JOIN ALUNO A ON A.COD_ALUNO=R.COD_ALUNO LEFT JOIN WEBSIMSQL.DBO.TIPO_ENTIDADE I ON A.TIPOENTI=I.ID_TIPO_ENTIDADE LEFT JOIN WEBSIMSQL.DBO.MUNICIPIOS M ON A.COD_MUNI_IBGE=M.COD_MUNI_IBGE AND A.COD_UF_IBGE=M.COD_UF_IBGE LEFT JOIN WEBSIMSQL.DBO.UF U ON A.COD_UF_IBGE=U.COD_UF_IBGE LEFT JOIN CURSO C ON R.COD_CURSO=C.COD_CURSO WHERE ID_REQUERIMENTO='"&request("ID_REQUERIMENTO")&"'"
		RS.open sql
		%>			
		<form action="salva_status_requerimento.asp" method="post" name="login">
			<input type="hidden" name="ID_REQUERIMENTO" value="<% =request("ID_REQUERIMENTO") %>">
			<fieldset>
				<legend>Requerimento</legend>
				<table>
				<tr><td colspan="2">
				Eu, <% =RS("NOME") %>, CPF: <% =formatacpf(RS("CPF")) %>, (cargo/fun��o) <% =RS("CARGO") %> na Institui��o <% =RS("DESCRICAO") %>,  nascido em <% =FORMATADATA(RS("DT_NASCIMENTO")) %>, endere�o <% =RS("ENDERECO") %>, <% =RS("NOME_MUNI") %> - <% =RS("SIGLA_UF") %>, venho, pelo presente, solicitar:
				</td></tr>
				<tr><td colspan="2">
				<strong><% =RS("REQUERIMENTO") %></strong>
				</td></tr>
				<tr><td colspan="2">
				<% if RS("COD_CURSO")>0 THEN %><strong><% =RS("TITULO") %></strong><%end if%>
				</td></tr>
				<tr><td>SOLICITA��O / JUSTIFICATIVA:</td>
				<td><textarea name="JUSTIFICATIVA" id="JUSTIFICATIVA" cols="130" rows="6" readonly><% =RS("JUSTIFICATIVA") %></textarea></td></tr>
				<tr><td>Data</td><td><% =formataData(RS("DATA")) %> - <% =formataHora(RS("HORA")) %></td> </tr>
				</table>
			</fieldset>
			<fieldset>
				<legend>Resposta</legend>
				<table>
				<tr>
				<td>Situa��o:</td>
				<td><select name="status_requerimento">

                <% if (RS("STATUS") = "Concedido") then  %>
                    <option value="Concedido" selected>Concedido</option>
                <% else %>
                    <option value="Concedido">Concedido</option>
                <% end if %>
                <% if (RS("STATUS") = "Pendente")  then %>
                   	<option value="Pendente"  selected>Pendente</option>
                <% else %>
                   	<option value="Pendente">Pendente</option>
                <% end if %>
                <% if (RS("STATUS") = "Negado")    then %>
                   	<option value="Negado"    selected>Negado</option>
                <% else  %>
                   	<option value="Negado"    >Negado</option>
                <% end if %>
                </select></td></tr>
				<tr>
				<td>JUSTIFICATIVA IBAM:</td>
				<td><textarea name="JUSTIFICATIVA_IBAM" id="JUSTIFICATIVA_IBAM" cols="130" rows="6"><% =RS("JUSTIFICATIVA_IBAM") %></textarea></td></tr>
				</table>
				<input type="submit" name="submit" value="Enviar" class="buttonF"><p><br></p>
			</fieldset>
			</form>
			<p><br></p>
	<!-- #INCLUDE FILE="../include/footer.asp" -->
</div>
</body>
</html>
<%conClose%>



