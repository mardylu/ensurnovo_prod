<%If Session("key_cur")<>"ok" Then Response.Redirect "logout.asp"%>
<!-- #INCLUDE FILE="../library/parametros.asp" -->
<!-- #INCLUDE FILE="../library/conOpen.asp" -->
<!-- #INCLUDE FILE="../library/fErroMsg.asp" -->
<!-- #INCLUDE FILE="../library/fCreateSel.asp" -->
<!-- #INCLUDE FILE="../library/fAddZero.asp" -->
<!-- #INCLUDE FILE="../library/fData.asp" -->

<%
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
	ID_TEMA 	= RS("ID_TEMA")
	ID_SUBTEMA	= RS("ID_SUBTEMA")
	TITULO 		= RS("TITULO")
	EMENTA 		= RS("EMENTA")
	VALOR 		= addZero(RS("VALOR"),3)
	INSCRICAO 	= addZero(RS("INSCRICAO"),3)
	VALOR_TXT 	= RS("VALOR_TXT")
	PARCELAS	= RS("PARCELAS")
	COD_TIPO 	= RS("COD_TIPO")
	COD_STATUS	= RS("COD_STATUS")
	DESTAQUE 	= RS("DESTAQUE")
	SENHA 		= RS("SENHA")
	COD_PROJETO = RS("COD_PROJETO")
	if COD_PROJETO=0 then COD_PROJETO=""
	URL 		= RS("URL")
	INSCRICAO 	= RS("INSCRICAO")
	BOLETO		= RS("BOLETO")
	PAGSEGURO	= RS("PAGSEGURO")
	DEPOSITO	= RS("DEPOSITO")
	EMPENHO		= RS("EMPENHO")
	GRATUITO	= RS("GRATUITO")
	RELACAO_COMERCIAL = RS("RELACAO_COMERCIAL")
	CARGA_HORARIA_HORAS = RS("CARGA_HORARIA_HORAS")
	CARGA_HORARIA_TIPO = RS("CARGA_HORARIA_TIPO")
	FIC_APRESENTACAO = RS("FIC_APRESENTACAO")
	FIC_OBJETIVO = RS("FIC_OBJETIVO")
	FIC_CONTEUDO = RS("FIC_CONTEUDO")
	FIC_PUBLICO = RS("FIC_PUBLICO")
	FIC_VERSO = RS("FIC_VERSO")
	FIC_CONTEUDISTA = RS("FIC_CONTEUDISTA")
	NOME_BREVE = RS("NOME_BREVE")
	
	if INSCRICAO > 0 then
	else
		INSCRICAO	= "000"
	end if
else
	COD_TIPO 	= 0
	COD_STATUS	= 0
	VALOR		= "000"
	INSCRICAO	= "000"
	VALOR_TXT	= "Formas de Pagamento: Boleto bancário, até uma semana antes do início do curso, com 10% de desconto. 3x sem juros ou em até 18x no cartão de crédito. Entidades associadas ao IBAM, 20% de desconto."
	DATA_TXT	= ""
	PARCELAS	= "1"
end if
RS.Close

Set RS2 = Server.CreateObject("ADODB.Recordset")
RS2.CursorType = 0
RS2.ActiveConnection = Con

%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

	<!-- TinyMCE -->
	<script type="text/javascript" src="tiny_mce/tiny_mce.js"></script>
	<script type="text/javascript">
		tinyMCE.init({
			// General options
			mode : "exact",
			elements : "info,apresentacao1,objetivo1,conteudo1,publico1,verso1",
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
	
	
	<!-- /TinyMCE -->

		function GetSelectedItem(selecionado) {
			len = document.form1.ID_TEMA.length;
			i = 0;
			chosen = "none";
			document.forms['form1'].ID_SUBTEMA.length = 0;
			
 			for (i = 0; i < len; i++) {
				var xpto;
				if (document.form1.ID_TEMA[i].selected ) {
				<% 
				RS.open "SELECT ID_TEMA,TEMA FROM TEMAS ORDER BY TEMA"
				do while not RS.eof %>
					if(document.form1.ID_TEMA[i].value== "<% =RS("ID_TEMA") %>") {
						var z=0;
						<% sql="select ID_SUBTEMA,ID_TEMA,SUBTEMA from SUBTEMAS where ID_TEMA='"&RS("ID_TEMA")&"' order by SUBTEMA"
						RS2.Open sql
						
						do while not RS2.eof %>
							var seq = <% =Cint(RS2("ID_SUBTEMA")) %>
							if (seq == selecionado) {
								xpto = z;
							}
							document.forms['form1'].ID_SUBTEMA.options[z++] = new Option("<% =RS2("SUBTEMA") %>","<% =RS2("ID_SUBTEMA") %>");
							<% RS2.movenext
						loop 
						RS2.CLOSE%>
					}
					<% RS.movenext
				loop 
				RS.CLOSE
				%>
				document.forms['form1'].ID_SUBTEMA.options[xpto].selected = true;
				}
			}
					
		}				
	</script>
	
		
<script type="text/javascript" src="../js/validacao_pb.js"></script>
<script type="text/javascript" src="../js/mascara.js"></script>
<title>ENSUR Inscrições</title>
</head>
<body onLoad="GetSelectedItem(document.form1.ID_TEMA.value);checkAcao(document.form1.task.value);">
">
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
			<form name="form" method="GET" action="cad_cursos.asp">
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
		<form name="form1" method="POST" action="salva_curso.asp">
		<input type="hidden" name="cod" value="<%=cod%>">
		<fieldset>
			<legend>informações do curso</legend>
			<table width=100% border=0>
			<tr>
			<%
				sql="SELECT ID_TEMA,TEMA FROM TEMAS ORDER BY TEMA"
				RS.Open sql
			%>
			<td><label for="TEMA" class="requerido">TEMA</label>
				<select name="ID_TEMA" id="ID_TEMA" onchange="GetSelectedItem(this.value);">
					<option><---Selecione primeiro o Tema---></option>
					<%while not RS.eof%>
						<option value="<% =RS("ID_TEMA") %>" <%if RS("ID_TEMA")=ID_TEMA then%>selected <%end if%>><% =RS("TEMA") %></option><%
						RS.movenext
					wend
					RS.Close

					%></select></p></td>
			</tr>
			<tr>
			<td><label for="ID_SUBTEMA" class="requerido">SUB-TEMA</label>
				<select name="ID_SUBTEMA" id="ID_SUBTEMA">
				<option></option>
				</select>
				</td>
			</tr>
			<tr><td><p><label for="TITULO" class="requerido">Título</label><input type="text" name="TITULO" id="TITULO" maxlength="200" size="60" value="<%=TITULO%>"></p></td></tr>
			<tr><td><p><label for="NOME_BREVE" class="requerido">Nome Breve</label><input type="text" name="NOME_BREVE" id="NOME_BREVE" maxlength="200" size="60" value="<%=NOME_BREVE%>"></p></td></tr>
			<tr><td><p><label for="URL">Endereço web</label><input type="text" name="URL" id="URL" maxlength="20" size="60" value="<%=URL%>"></p></td></tr>
			<tr><td><p><label for="COD_TIPO" class="requerido">Tipo</label>
			<select name="COD_TIPO" onChange="checkAcao(this.value);">
				<%
				sql="SELECT * FROM CURSO_TIPO ORDER BY DESCRICAO"
				RS.open sql
				while not RS.eof
					response.write "<option value="&RS("COD_TIPO")&">"&RS("DESCRICAO")&"</option>"
					if not RS.EOF then
						RS.movenext
					end if
				wend
				RS.close
				%>
				</select>
			</p></td></tr>
			<tr>
			</tr>
			<tr><td><p><label for="COD_STATUS" class="requerido">Status</label><%=createSel("COD_STATUS","SELECT * FROM CURSO_STATUS ORDER BY COD_STATUS",COD_STATUS,0,"")%></p></td></tr>
			</fieldset>
			<fieldset>
			<legend>Ficha Técnica</legend>
			<tr><td><p><label for="EMENTA" class="requerido">Informações</label><textarea name="EMENTA" id="info" cols="40" rows="6"><%=EMENTA%></textarea></p></td></tr>
			<tr><td><p><label for="FIC_APRESENTACAO" class="requerido">Apresentação</label><textarea name="FIC_APRESENTACAO" id="apresentacao1" cols="40" rows="6"><%=FIC_APRESENTACAO%></textarea></p></td></tr>
			<tr><td><p><label for="FIC_OBJETIVO" class="requerido">Objetivo</label><textarea name="FIC_OBJETIVO" id="objetivo1" cols="40" rows="6"><%=FIC_OBJETIVO%></textarea></p></td></tr>
			<tr><td><p><label for="FIC_CONTEUDO" class="requerido">Conteúdo Programático</label><textarea name="FIC_CONTEUDO" id="conteudo1" cols="40" rows="6"><%=FIC_CONTEUDO%></textarea></p></td></tr>
			<tr><td><p><label for="FIC_PUBLICO" class="requerido">Publico Alvo</label><textarea name="FIC_PUBLICO" id="publico1" cols="40" rows="6"><%=FIC_PUBLICO%></textarea></p></td></tr>
			<tr><td><p><label for="FIC_VERSO" class="requerido">Verso do Certificado</label><textarea name="FIC_VERSO" id="verso1" cols="40" rows="6"><%=FIC_VERSO%></textarea></p></td></tr>
			<tr><td><p><label for="VALOR" class="requerido">Valor</label><input type="text" name="VALOR" id="VALOR" maxlength="8" size="10" value="<%=Mid(VALOR,1,Len(VALOR)-2)&","&Mid(VALOR,Len(VALOR)-1)%>" onKeyPress="return ValidateKeyPressed('MONEY', this, event);"></p></td></tr>
			<tr><td><p><label for="VALOR_TXT">Texto do valor</label><textarea name="VALOR_TXT" cols="40" rows="6"><%=VALOR_TXT%></textarea></p></td></tr>
			<tr><td><p><label for="PARCELAS">Máx. de parcelas</label><input type="text" name="PARCELAS" id="PARCELAS" maxlength="2" size="10" value="<% =PARCELAS%>" onKeyPress="return ValidateKeyPressed('NUMBER', this, event);"></p></td></tr>
			<tr><td><table width="80%" align="center" border="0">
			<tr><td colspan="6" align="center">Formas de pagamento</td></tr>
			<tr><td><p><label for="BOLETO" >Boleto<input type="checkbox" value="1" name="BOLETO" <% if BOLETO="1" then%>checked<%end if%>></label></p></td>
			<td><p><label for="PAGSEGURO" >Pag-seguro<input type="checkbox" value="1" name="PAGSEGURO" <% if PAGSEGURO="1" then%>checked<%end if%>></label></p></td>
			<td><p><label for="EMPENHO" >Empenho<input type="checkbox" value="1" name="EMPENHO" <% if EMPENHO="1" then%>checked<%end if%>></label></p></td>
			<td><p><label for="DEPOSITO" >Deposito<input type="checkbox" value="1" name="DEPOSITO" <% if DEPOSITO="1" then%>checked<%end if%>></label></p></td>
			<td><p><label for="GRATUITO" >Gratuíto<input type="checkbox" value="1" name="GRATUITO" <% if GRATUITO="1" then%>checked<%end if%>></label></p></td></tr>
			</table></td></tr>
			<tr><td><p><label for="DESTAQUE">Destaque</label><input type="text" name="DESTAQUE" id="DESTAQUE" maxlength="11" size="11" value="<%=DESTAQUE%>"></p></td></tr>
			<tr><td><p><label for="SENHA">Senha</label><input type="text" name="SENHA" id="SENHA" maxlength="15" size="11" value="<%=SENHA%>"></p></td></tr>
			<tr><td><p><label for="COD_PROJETO">Cód. Projeto</label><input type="text" name="COD_PROJETO" id="COD_PROJETO" maxlength="15" size="11" value="<%=COD_PROJETO%>" onKeyPress="return ValidateKeyPressed('NUMBER', this, event);"></p></td></tr>
			<tr><td><p><br /><label for="submit">&nbsp;</label><input type="submit" name="submit" value="Enviar" class="buttonF"><br /><br /></p></td></tr>
		</fieldset>
		</form>
		<br />
		</table>
		<ul>
			<li>Os campos marcados em laranja são obrigatórios</li>
		</ul>
		<br />
	</div>	
</div>
</body>
</html>
<%conClose%>
