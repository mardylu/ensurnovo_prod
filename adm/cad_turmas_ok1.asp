<%If Session("key_cur")<>"ok" Then Response.Redirect "logout.asp"%>
<!-- #INCLUDE FILE="../library/parametros.asp" -->
<!-- #INCLUDE FILE="../library/conOpen.asp" -->
<!-- #INCLUDE FILE="../library/fErroMsg.asp" -->
<!-- #INCLUDE FILE="../library/fCreateSel.asp" -->
<!-- #INCLUDE FILE="../library/fAddZero.asp" -->
<!-- #INCLUDE FILE="../library/fData.asp" -->
<%
RS.CursorType = 3

cod = request("cod")
if cod>0 then
	sql = "SELECT * FROM CURSO WHERE COD_CURSO="&int(cod)
	RS.Open sql
	if not RS.EOF then
		COD_STATUS_TURMA = 1
		ID_TEMA 	= RS("ID_TEMA")
		ID_SUBTEMA 	= RS("ID_SUBTEMA")
		TITULO 		= RS("TITULO")
		EMENTA 		= RS("EMENTA")
		VALOR 		= addZero(RS("VALOR"),3)
		VALOR_TXT 	= RS("VALOR_TXT")
		PARCELAS	= RS("PARCELAS")
		COD_TIPO 	= RS("COD_TIPO")
		LUGAR 		= RS("LUGAR")
		HORARIO 	= RS("HORARIO")
		COD_STATUS	= RS("COD_STATUS")
		DESTAQUE 	= RS("DESTAQUE")
		SENHA 		= RS("SENHA")
		COD_PROJETO = RS("COD_PROJETO")
		CARGA_HORARIA_HORAS = RS("CARGA_HORARIA_HORAS")
		CARGA_HORARIA_TIPO = RS("CARGA_HORARIA_TIPO")
		NOME_BREVE = RS("NOME_BREVE")
		FIC_VERSO = RS("FIC_VERSO")
		NOME_FANTASIA = RS("TITULO")
		DURACAO = RS("DURACAO")
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
		EMENTA = RS("EMENTA")
		NOME_BREVE = RS("NOME_BREVE")
		DURACAO = RS("DURACAO")
		
		if COD_PROJETO=0 then COD_PROJETO=""
		URL 		= RS("URL")
		CODIGO_TURMA = right(year(now()),2)&"."&right("0"&cint(ID_TEMA),2)&"."&right("000"&cint(cod),3)&"."
	end if
	RS.Close
else
	if request("tur")>0 then
		sql = "select T.FIC_APRESENTACAO,T.FIC_OBJETIVO,T.FIC_CONTEUDO,T.FIC_PUBLICO,T.FIC_VERSO,T.FIC_CONTEUDISTA,T.EMENTA,T.FREQUENCIA,T.ID_PROFESSOR,P.MINICURRICULO,C.TITULO,T.ID_TURMA,T.DURACAO,T.CARGA_HORARIA_HORAS,T.CARGA_HORARIA_TIPO,T.NOME_BREVE,T.FIC_VERSO,T.NOME_FANTASIA,T.CODIGO_INSCRICAO,T.ID_TEMA,T.ID_SUBTEMA,C.COD_STATUS,t.COD_TIPO,T.COD_CURSO,T.VALOR,T.PARCELAS,T.VALOR_TXT,T.DATA_TXT,T.VAGAS,T.LUGAR,T.HORARIO,T.ID_PROFESSOR,C.TITULO,DT_FIM_INSC,DT_FIM_TURMA,DT_INICIO_INSC,DT_INICIO_TURMA,CODIGO_TURMA,T.COD_STATUS_TURMA,M.TEMA,S.SUBTEMA,ST.STATUS_TURMA From TURMAS T JOIN TEMAS M ON T.ID_TEMA=M.ID_TEMA JOIN SUBTEMAS S ON T.ID_SUBTEMA=S.ID_SUBTEMA JOIN TURMA_STATUS ST ON T.COD_STATUS_TURMA=ST.COD_STATUS_TURMA JOIN CURSO C ON T.COD_CURSO=C.COD_CURSO LEFT JOIN PROFESSORES P ON P.ID_PROFESSOR=T.ID_PROFESSOR WHERE T.ID_TURMA="&request("tur")
		
		RS.Open sql
		if not rs.eof then
			COD_STATUS_TURMA = RS("COD_STATUS_TURMA")
			COD_CURSO	=RS("COD_CURSO")
			COD_TIPO	=RS("COD_TIPO")
			ID_TEMA 	= RS("ID_TEMA")
			ID_SUBTEMA 	= RS("ID_SUBTEMA")
			TITULO 		= RS("TITULO")
			'EMENTA 		= RS("EMENTA")
			'COD_TIPO 	= RS("COD_TIPO")
			LUGAR 		= RS("LUGAR")
			HORARIO 	= RS("HORARIO")
			VAGAS 		= RS("VAGAS")
			COD_STATUS	= RS("COD_STATUS")
			'DESTAQUE 	= RS("DESTAQUE")
			'SENHA 		= RS("SENHA")
			'COD_PROJETO = RS("COD_PROJETO")
			'URL 		= RS("URL")
			CODIGO_TURMA = RS("CODIGO_TURMA")	
			DT_INICIO_INSC = RS("DT_INICIO_INSC")
			DT_FIM_INSC = RS("DT_FIM_INSC")
			DT_INICIO_TURMA = RS("DT_INICIO_TURMA")
			DT_FIM_TURMA = RS("DT_FIM_TURMA")
			ID_PROFESSOR = RS("ID_PROFESSOR")
			DATA_TXT = RS("DATA_TXT")
			COD_TIPO = RS("COD_TIPO")
			CODIGO_INSCRICAO = RS("CODIGO_INSCRICAO")
			CARGA_HORARIA_HORAS = RS("CARGA_HORARIA_HORAS")
			CARGA_HORARIA_TIPO = RS("CARGA_HORARIA_TIPO")
			NOME_BREVE = RS("NOME_BREVE")
			FIC_VERSO = RS("FIC_VERSO")
			MINICURRICULO = RS("MINICURRICULO")
			FIC_APRESENTACAO = RS("FIC_APRESENTACAO")
			FIC_OBJETIVO = RS("FIC_OBJETIVO")
			FIC_CONTEUDO = RS("FIC_CONTEUDO")
			FIC_PUBLICO = RS("FIC_PUBLICO")
			FIC_VERSO = RS("FIC_VERSO")
			FIC_CONTEUDISTA = RS("FIC_CONTEUDISTA")
			EMENTA = RS("EMENTA")
			if LEN(TRIM(RS("NOME_FANTASIA")))>0 then
				NOME_FANTASIA = RS("NOME_FANTASIA")
			else
				NOME_FANTASIA = RS("TITULO")
			end if				
			VALOR 		= addZero(RS("VALOR"),3)
			VALOR_TXT 	= RS("VALOR_TXT")
			PARCELAS	= RS("PARCELAS")
			DURACAO = RS("DURACAO")
			FREQUENCIA = RS("FREQUENCIA")
			RS.Close
		else
			erroMsg("Turma não cadastrada.")
		end if
	else
		TEXTO_VALOR = "Formas de Pagamento:"&CHR(10)&CHR(10)&"Boleto bancário, até uma semana antes do início do curso, com 10% de desconto."&CHR(10)&"3x sem juros ou em até 18x no cartão de crédito."&CHR(10)&"Entidades associadas ao IBAM, 20% de desconto."
		VALOR		= "000"
		COD_TIPO 	= 0
		COD_STATUS	= 1
		DATA_TXT	= ""
		COD_STATUS_TURMA = 1
	end if

end if
If VALOR>1 THEN
ELSE
	VALOR		= "000"
END IF
%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

	<!-- TinyMCE -->
	<script type="text/javascript" src="tiny_mce/tiny_mce.js"></script>
	<script type="text/javascript" src="../js/validacao_pb.js"></script>
	<script type="text/javascript" src="../js/mascara.js"></script>
	<script type="text/javascript" src="calendar1.js"></script>
	<script type="text/javascript">
		tinyMCE.init({
			// General options
			mode : "exact",
			elements : "apresentacao1,objetivo1,conteudo1,publico1,verso1,minicurriculo,ementa",
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
		function checkAcao(val) {
			
			if (val==='4') {
				document.getElementById('codigo').style.display = 'block';
			} else {
				document.getElementById('codigo').style.display = 'none';
			}
		}
	</script>
	<!-- /TinyMCE -->
	<title>ENSUR Inscrições</title>
</head>
<body onLoad="checkAcao(document.form.COD_TIPO.value);">

<div id="pagina">
	<!-- #INCLUDE FILE="include/topo.asp" -->
	<div id="conteudo">
		<table border = 0 width=100%>
			<tr><td width="10%"><a href="lista_turmas.asp"><img src="img/btnp_seta_invet.gif" border="0"></a></td><td width="90%"><h1>Cadastro de Turmas</h1></td></tr>
		</table>
		
		<%If cod=0 and request("tur")=0 Then%>
			<form name="form" method="POST" action="cad_turmas.asp?tur=0">
				Selecione o curso:<br />
				<select name="cod" onChange="this.form.submit();">
					<option></option>
					<%
					RS.Open "SELECT C.COD_CURSO,C.TITULO,T.TEMA,S.SUBTEMA FROM CURSO C JOIN TEMAS T ON C.ID_TEMA=T.ID_TEMA JOIN SUBTEMAS S ON C.ID_SUBTEMA=S.ID_SUBTEMA  WHERE COD_STATUS = 1 ORDER BY TITULO"
					While not RS.EOF'
						%><option value="<%=RS("COD_CURSO")%>"><%=RS("TITULO")%></option><%
						RS.MoveNext
					Wend
					RS.Close
					%>
				</select>
			</form>
		<%end if%>
		<form name="form" method="POST" action="salva_turma.asp" onSubmit="return checkForm();">
		<input type="hidden" name="acod" value="<%=cod%>">
		<input type="hidden" name="tur" value="<%=request("tur")%>">
		<input type="hidden" name="COD_CURSO" value="<%=COD_CURSO%>">
		<input type="hidden" name="ID_TEMA" value="<%=ID_TEMA%>">
		<input type="hidden" name="ID_SUBTEMA" value="<%=ID_SUBTEMA%>">
		
		<fieldset>
			<legend>Informações do curso</legend>
				<p><label for="TITULO" class="soleitura">Título</label><input type="text" name="TITULO" id="TITULO" maxlength="200" size="60" value="<%=TITULO%>" readonly class="readonly"></p>
				<p><label for="ID_TEMA" class="soleitura">Tema</label><%=createSeldisabled("ID_TEMA","SELECT * FROM TEMAS ORDER BY TEMA",ID_TEMA,0,"")%></p>
				<p><label for="ID_SUBTEMA" class="soleitura">Sub-tema</label><%=createSeldisabled("ID_SUBTEMA","SELECT ID_SUBTEMA,SUBTEMA FROM SUBTEMAS ORDER BY SUBTEMA",ID_SUBTEMA,0,"")%></p>
				<p><label for="COD_STATUS" class="soleitura">Status</label><%=createSeldisabled("COD_STATUS","SELECT * FROM CURSO_STATUS ORDER BY COD_STATUS",COD_STATUS,0,"")%></p>
				<p><label for="FIC_APRESENTACAO" class="requerido">Apresentação</label><textarea name="FIC_APRESENTACAO" readonly id="apresentacao1" cols="40" rows="6"><%=FIC_APRESENTACAO%></textarea></p>
				<p><label for="FIC_OBJETIVO" class="requerido">Objetivo</label><textarea name="FIC_OBJETIVO" readonly id="objetivo1" cols="40" rows="6"><%=FIC_OBJETIVO%></textarea></p>
				<p><label for="FIC_CONTEUDO" class="requerido">Conteúdo Programático</label><textarea readonly name="FIC_CONTEUDO" id="conteudo1" cols="40" rows="6"><%=FIC_CONTEUDO%></textarea></p>
				<p><label for="FIC_PUBLICO" class="requerido">Publico Alvo</label><textarea name="FIC_PUBLICO" readonly id="publico1" cols="40" rows="6"><%=FIC_PUBLICO%></textarea></p>
				<p><label for="FIC_VERSO" class="requerido">Verso do Certificado</label><textarea name="FIC_VERSO" id="verso1" cols="40" rows="6"><%=FIC_VERSO%></textarea></p>
				<% if EMENTA<>"" then %>
					<p><label for="EMENTA" class="requerido">Informações</label><textarea name="EMENTA" readonly id="ementa" readonly cols="40" rows="6"><%=EMENTA%></textarea></p>
				<% end if%>
		</fieldset>
		<fieldset>
			<legend>Informações da turma</legend>
			<p><label for="CODIGO_TURMA" class="soleitura">Código da Turma</label><input type="text" name="CODIGO_TURMA" id="CODIGO_TURMA" maxlength="100" size="50" value="<%=CODIGO_TURMA%>" readonly class="readonly"></p>
			<p><label for="COD_STATUS_TURMA" class="requerido">Status Turma</label><%=createSel("COD_STATUS_TURMA","SELECT * FROM TURMA_STATUS ORDER BY COD_STATUS_TURMA",COD_STATUS_TURMA,0,"")%></p>
			<p><label for="NOME_FANTASIA" class="requerido">Nome Fantasia</label><input type="text" name="NOME_FANTASIA" id="NOME_FANTASIA" maxlength="200" size="60" value="<%=NOME_FANTASIA%>"></p>
			<p><label for="NOME_BREVE" class="requerido">Nome Breve</label><input type="text" name="NOME_BREVE" id="NOME_BREVE" maxlength="200" size="60" value="<%=NOME_BREVE%>"></p>
			<p><label for="COD_TIPO" class="requerido">Modalidade/Tipo</label>
			<select name="COD_TIPO" onChange="checkAcao(this.value);" value="<% =COD_TIPO %>">
			 	<option value="0"></option>"
				<%
				sql="SELECT * FROM CURSO_TIPO ORDER BY DESCRICAO"
				RS.open sql
				while not RS.eof
					response.write "<option value="&RS("COD_TIPO") 
						if RS("COD_TIPO")=COD_TIPO then 
							response.write " Selected "
						end if
						response.write ">"&RS("DESCRICAO")&"</option>"
					if not RS.EOF then
						RS.movenext
					end if
				wend
				RS.Close
				%>
				</select>
			</p>
			<fieldset id="codigo" style="display:block" border="0">
				<p><label for="CODIGO_INSCRICAO" class="requerido">Código de Inscrição</label><input type="text" name="CODIGO_INSCRICAO" id="CODIGO_INSCRICAO" value="<% =CODIGO_INSCRICAO %>" maxlength="6" size="6"></p>
			</fieldset>
			<p><label for="DT_INICIO_INSC" class="requerido">Início Inscrições</label><input type="text" name="DT_INICIO_INSC" class="plain" id="DT_INICIO_INSC" maxlength="10" size="11" value="<%=formataData1(DT_INICIO_INSC)%>" onKeyPress="return ValidateKeyPressed('DATE', this, event);" onChange="valida_campo(4,this);"><a href="javascript:void(0)" onclick="if(self.gfPop)gfPop.fPopCalendar(document.form.DT_INICIO_INSC);return false;" HIDEFOCUS><img class="PopcalTrigger" align="absmiddle" src="HelloWorld/calbtn.gif" width="34" height="22" border="0" alt=""></a> 
			<p><label for="DT_FIM_INSC" class="requerido">Fim Inscrições</label><input type="text" name="DT_FIM_INSC" id="DT_FIM_INSC" class="plain" maxlength="10" size="11" value="<%=formataData1(DT_FIM_INSC)%>" onKeyPress="return ValidateKeyPressed('DATE', this, event);" onChange="valida_campo(4,this);"><a href="javascript:void(0)" onclick="if(self.gfPop)gfPop.fPopCalendar(document.form.DT_FIM_INSC);return false;" HIDEFOCUS><img class="PopcalTrigger" align="absmiddle" src="HelloWorld/calbtn.gif" width="34" height="22" border="0" alt=""></a> </p> 
			<p><label for="DT_INICIO_TURMA" class="requerido">Início Turma</label><input type="text" name="DT_INICIO_TURMA" id="DT_INICIO" class="plain" maxlength="10" size="11" value="<%=formataData1(DT_INICIO_TURMA)%>" onKeyPress="return ValidateKeyPressed('DATE', this, event);" onChange="valida_campo(4,this);"><a href="javascript:void(0)" onclick="if(self.gfPop)gfPop.fPopCalendar(document.form.DT_INICIO_TURMA);return false;" HIDEFOCUS><img class="PopcalTrigger" align="absmiddle" src="HelloWorld/calbtn.gif" width="34" height="22" border="0" alt=""></a> 
			<p><label for="DT_FIM_TURMA" class="requerido">Fim Turma</label><input type="text" name="DT_FIM_TURMA" id="DT_FIM" class="plain" maxlength="10" size="11" value="<%=formataData1(DT_FIM_TURMA)%>" onKeyPress="return ValidateKeyPressed('DATE', this, event);" onChange="valida_campo(4,this);"><a href="javascript:void(0)" onclick="if(self.gfPop)gfPop.fPopCalendar(document.form.DT_FIM_TURMA);return false;" HIDEFOCUS><img class="PopcalTrigger" align="absmiddle" src="HelloWorld/calbtn.gif" width="34" height="22" border="0" alt=""></a> </p>
			
			<p><label for="DATA_TXT">Texto da data</label><textarea name="DATA_TXT" cols="100" rows="2"><%=DATA_TXT%></textarea></p>
			<p><label for="VAGAS" class="requerido">Vagas</label><input type="text" name="VAGAS" id="VAGAS" maxlength="8" size="10" value="<%=VAGAS%>" onKeyPress="return ValidateKeyPressed('NUMBER', this, event);"></p>
			<p><label for="LUGAR" class="requerido">Local</label><input type="text" name="LUGAR" id="LUGAR" maxlength="200" size="60" value="<%=LUGAR%>"></p>
			<p><label for="CARGA_HORARIA_HORAS" class="requerido">Carga Horária</label><input type="text" name="CARGA_HORARIA_HORAS" id="CARGA_HORARIA_HORAS" maxlength="4" size="10" value="<%=CARGA_HORARIA_HORAS%>"></p>
			<p><label for="DURACAO" class="requerido">Duração</label><input type="text" name="DURACAO" id="DURACAO" maxlength="4" size="10" value="<%=DURACAO%>"></p>
			<p><label for="CARGA_HORARIA_TIPO" class="requerido">Tipo da Duração</label><select name="CARGA_HORARIA_TIPO">
			<option value=""></option>
			<option value="Dias" <% if CARGA_HORARIA_TIPO = "Dias" then%> Selected <% end if %>>Dia(s)</option>
			<option value="Semanas" <% if CARGA_HORARIA_TIPO = "Semanas" then%> Selected <% end if %>>Semana(s)</option>
			<option value="Meses" <% if CARGA_HORARIA_TIPO = "Meses" then%> Selected <% end if %>>Mes(es)</option>
			</select>
			<p><label for="FREQUENCIA" class="requerido">Frequência</label><input type="text" name="FREQUENCIA" id="FREQUENCIA" maxlength="4" size="10" value="<%=FREQUENCIA%>"> * períodos</p>
			</p>
		</fieldset>
		<fieldset>
			<legend>Dados Financeiros</legend>			
			<p><label for="VALOR" class="requerido">Valor</label><input type="text" name="VALOR" id="VALOR" maxlength="8" size="10" value="<%=Mid(VALOR,1,Len(VALOR)-2)&","&Mid(VALOR,Len(VALOR)-1)%>" onKeyPress="return ValidateKeyPressed('MONEY', this, event);"></p>
			<p><label for="VALOR_TXT">Texto do valor</label><textarea name="VALOR_TXT" cols="40" rows="6"><%=VALOR_TXT%></textarea></p>
			<p><label for="PARCELAS">Boleto (parcelas)</label><input type="text" name="PARCELAS" id="PARCELAS" maxlength="2" size="10" value="<% =PARCELAS%>" onKeyPress="return ValidateKeyPressed('NUMBER', this, event);"></p>
		</fieldset>
		<fieldset>
			<legend>Dados do professor</legend>			

			<p><label for="ID_PROFESSOR" class="requerido">Professor </label><%=createSel("ID_PROFESSOR","SELECT * FROM PROFESSORES ORDER BY NOME",ID_PROFESSOR,1,"")%></p>
			<p><label for="MINICURRICULO" class="requerido">Minicurriculo</label><textarea name="MINICURRICULO" readonly id="minicurriculo" cols="40" rows="6"><%=MINICURRICULO%></textarea></p>
			<p><br /><label for="submit">&nbsp;</label><input type="submit" name="submit" value="Enviar" class="buttonF"><br /><br /></p>
		</form>

		</fieldset>
		<br />
		<ul>
			<li>Os campos marcados em laranja são obrigatórios</li>
		</ul>
		<br/>
	</div>	
</div>
<iframe width=174 height=189 name="gToday:normal:agenda.js" id="gToday:normal:agenda.js" src="HelloWorld/ipopeng.htm" scrolling="no" frameborder="0" style="visibility:visible; z-index:999; position:absolute; top:-500px; left:-500px;">
</iframe>

</body>
</html>
<%conClose%>