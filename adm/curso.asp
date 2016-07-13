<%If Session("key_cur")<>"ok" Then Response.Redirect "logout.asp"%>
<!-- #INCLUDE FILE="../library/parametros.asp" -->
<!-- #INCLUDE FILE="../library/conOpen.asp" -->
<!-- #INCLUDE FILE="../library/fErroMsg.asp" -->
<!-- #INCLUDE FILE="../library/fCreateSel.asp" -->
<!-- #INCLUDE FILE="../library/fAddZero.asp" -->
<!-- #INCLUDE FILE="../library/fData.asp" -->
<%
RS.CursorType = 3

rcod = request("rcod")
if rcod=0 or rcod="" or isNumeric(rcod)=false then rcod=0
cod = request("cod")
if cod=0 or cod="" or isNumeric(cod)=false then cod=0

if cod>0 then
	sql = "SELECT * FROM CURSO WHERE COD_CURSO="&int(cod)
else
	if rcod>0 then
		sql = "SELECT * FROM CURSO WHERE COD_CURSO="&int(rcod)
	else
		sql = "SELECT * FROM CURSO WHERE COD_CURSO=0"
	end if
end if

RS.Open sql
if not RS.EOF then
	TITULO 		= RS("TITULO")
	EMENTA 		= RS("EMENTA")
	VALOR 		= addZero(RS("VALOR"),3)
	VALOR_TXT 	= RS("VALOR_TXT")
	PARCELAS	= RS("PARCELAS")
	COD_TIPO 	= RS("COD_TIPO")
	LUGAR 		= RS("LUGAR")
	HORARIO 	= RS("HORARIO")
	VAGAS 		= RS("VAGAS")
	COD_STATUS	= RS("COD_STATUS")
	DESTAQUE 	= RS("DESTAQUE")
	SENHA 		= RS("SENHA")
	COD_PROJETO = RS("COD_PROJETO")
	if COD_PROJETO=0 then COD_PROJETO=""
	URL 		= RS("URL")
	DESABILITADO= RS("DESABILITADO")
else
	COD_TIPO 	= 0
	COD_STATUS	= 0
	VALOR		= "000"
	VALOR_TXT	= ""
	PARCELAS	= ""
	DESABILITADO= 0
end if
RS.Close
%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

	<!-- TinyMCE -->
	<script type="text/javascript" src="tiny_mce/tiny_mce.js"></script>
	<script type="text/javascript">
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
	</script>
	<!-- /TinyMCE -->
	<script type="text/javascript" src="../js/validacao_pb.js"></script>
	<script type="text/javascript" src="../js/mascara.js"></script>
	<title>ENSUR Inscrições</title>
</head>
<body>
<div id="pagina">
	<!-- #INCLUDE FILE="include/topo.asp" -->
	<div id="conteudo">
		<h1>Cadastro de cursos</h1>
		<%If Session("key_cud")="ok" and cod>0 Then%>
			<br />
			<a href="javascript:confirm('CONFIRMA A EXCLUSÃO DO CURSO, SUAS INSCRIÇÕES E PAGAMENTOS?')?window.location='curso_del.asp?cod=<%=cod%>':void(0);" style="font-weight:bold; color:#880000; background:ddd; padding:4px 10px; border:1px solid #888;">APAGAR ESSE CURSO</a>
			<br />
		<%end if%>
		<%If cod=0 Then%>
			<form name="form" method="GET" action="curso.asp">
				Copiar dados de:<br />
				<select name="rcod" onChange="this.form.submit();">
					<option></option>
					<%
					RS.Open "SELECT COD_CURSO,TITULO FROM CURSO ORDER BY TITULO"
					While not RS.EOF'
						%><option value="<%=RS(0)%>"><%=RS(1)%></option><%
						RS.MoveNext
					Wend
					RS.Close
					%>
				</select>
			</form>
		<%end if%>
		<form name="form" method="POST" action="curso_resp.asp">
		<input type="hidden" name="cod" value="<%=cod%>">
		<fieldset>
			<legend>informações do curso</legend>
			<p><label for="TITULO" class="requerido">Título</label><input type="text" name="TITULO" id="TITULO" maxlength="200" size="60" value="<%=TITULO%>"></p>
			<p><label for="DESABILITADO" class="requerido">Habilitado</label><select name="DESABILITADO"><option value="0"<%if not DESABILITADO then Response.Write " SELECTED"%>>Sim</option><option value="1"<%if DESABILITADO then Response.Write " SELECTED"%>>Não</option></select></p>
			<p><label for="URL">Endereço web</label><input type="text" name="URL" id="URL" maxlength="20" size="60" value="<%=URL%>"></p>
			<p><label for="COD_TIPO" class="requerido">Tipo</label><%=createSel("COD_TIPO","SELECT * FROM CURSO_TIPO ORDER BY DESCRICAO",COD_TIPO,1,"")%></p>
			<p><label for="COD_STATUS" class="requerido">Status</label><%=createSel("COD_STATUS","SELECT * FROM CURSO_STATUS ORDER BY COD_STATUS",COD_STATUS,0,"")%></p>
			<p><label for="EMENTA" class="requerido">Informações</label><textarea name="EMENTA" id="info" cols="40" rows="6"><%=EMENTA%></textarea></p>
			<p><label for="VALOR" class="requerido">Valor</label><input type="text" name="VALOR" id="VALOR" maxlength="8" size="10" value="<%=Mid(VALOR,1,Len(VALOR)-2)&","&Mid(VALOR,Len(VALOR)-1)%>" onKeyPress="return ValidateKeyPressed('MONEY', this, event);"></p>
			<p><label for="VALOR_TXT">Texto do valor</label><textarea name="VALOR_TXT" cols="40" rows="6"><%=VALOR_TXT%></textarea></p>
			<p><label for="PARCELAS">Máx. de parcelas</label><input type="text" name="PARCELAS" id="PARCELAS" maxlength="2" size="10" value="<%=PARCELAS%>" onKeyPress="return ValidateKeyPressed('NUMBER', this, event);"> (0 = não haverá pagamento pela internet)</p>
			<p><label for="DT_INICIO">início</label><input type="text" name="DT_INICIO" id="DT_INICIO" maxlength="10" size="11" value="<%=formataData(DT_INICIO)%>" onKeyPress="return ValidateKeyPressed('DATE', this, event);" onChange="valida_campo(4,this);"></p>
			<p><label for="DT_FIM">termino</label><input type="text" name="DT_FIM" id="DT_FIM" maxlength="10" size="11" value="<%=formataData(DT_FIM)%>" onKeyPress="return ValidateKeyPressed('DATE', this, event);" onChange="valida_campo(4,this);"></p>
			<p><label for="DATA_TXT">Texto da data</label><textarea name="DATA_TXT" cols="40" rows="6"><%=DATA_TXT%></textarea></p>
			<p><label for="VAGAS">Vagas</label><input type="text" name="VAGAS" id="VAGAS" maxlength="8" size="10" value="<%=VAGAS%>" onKeyPress="return ValidateKeyPressed('NUMBER', this, event);"></p>
			<p><label for="LUGAR">Local</label><input type="text" name="LUGAR" id="LUGAR" maxlength="200" size="60" value="<%=LUGAR%>"></p>
			<p><label for="HORARIO">Carga horária</label><input type="text" name="HORARIO" id="HORARIO" maxlength="200" size="60" value="<%=HORARIO%>"></p>
			<p><label for="DESTAQUE">Destaque</label><input type="text" name="DESTAQUE" id="DESTAQUE" maxlength="11" size="11" value="<%=DESTAQUE%>"></p>
			<p><label for="SENHA">Senha</label><input type="text" name="SENHA" id="SENHA" maxlength="15" size="11" value="<%=SENHA%>"></p>
			<p><label for="COD_PROJETO">Cód. Projeto</label><input type="text" name="COD_PROJETO" id="COD_PROJETO" maxlength="15" size="11" value="<%=COD_PROJETO%>" onKeyPress="return ValidateKeyPressed('NUMBER', this, event);"></p>
			<p><br /><label for="submit">&nbsp;</label><input type="submit" name="submit" value="Enviar" class="buttonF"><br /><br /></p>
		</fieldset>
		</form>
		<br />
		<ul>
			<li>Os campos marcados em laranja são obrigatórios</li>
		</ul>
		<br />
	</div>	
</div>
</body>
</html>
<%conClose%>