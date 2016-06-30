<!-- #INCLUDE FILE="../library/parametros.asp" -->
<!-- #INCLUDE FILE="../library/conOpen.asp" -->
<!-- #INCLUDE FILE="../library/fErroMsg.asp" -->
<!-- #INCLUDE FILE="../library/fAddZero.asp" -->
<!-- #INCLUDE FILE="../library/fFormataValor.asp" -->
<!-- #INCLUDE FILE="../library/fData.asp" -->
<!-- #INCLUDE FILE="../library/fCreateSel.asp" -->
<!-- #INCLUDE FILE="../library/fChecaCPF_CNPJ.asp" -->
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<script type="text/javascript" src="../js/municipios.js"></script>
	<script language="JavaScript">
	<!--
	<%
	curMunis=""
	curCod=0
	RS.Open "SELECT NOME_MUNI,COD_MUNI_IBGE,COD_UF_IBGE FROM MUNICIPIOS ORDER BY COD_UF_IBGE,NOME_MUNI"
	while not RS.EOF
		codUf = RS("COD_UF_IBGE")
		if curCod<>codUf then
			if len(curMunis)<>0 then
				%>
				tempEstado = "<%=curMunis%>".split("##");
				estados[<%=curCod%>] = tempEstado;
				<%
			end if
			curMunis="|0"
			curCod=codUf
		end if
		curMunis = curMunis & "##" & RS("NOME_MUNI") & "|" &  RS("COD_MUNI_IBGE") & "|" &  RS("COD_UF_IBGE")
		RS.MoveNext
	wend
	RS.Close
	if len(curMunis)<>0 then
		%>
		tempEstado = "<%=curMunis%>".split("##");
		estados[<%=curCod%>] = tempEstado;
		<%
	end if
	%>
	
	//Função para evitar perda do select de municípios no back do IE
	function readCookie(name) {
	var nameEQ = name + "=";
	var ca = document.cookie.split(';');
	for(var i=0;i < ca.length;i++) {
		var c = ca[i];
		while (c.charAt(0)==' ') c = c.substring(1,c.length);
		if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
	}
	return null;
	}
	
	function remarcarMuni() {
		var bName = navigator.appName;
		if (bName == "Microsoft Internet Explorer") {
			var codPessoal = readCookie('muniPess');
			var codEnti = readCookie('muniEnti');
			if (codPessoal!=null) {
				document.form.COD_MUNI_IBGE.value = codPessoal;
			}
			if (codEnti!=null) {
				document.form.COD_MUNI_ENTI.value = codEnti;
			}
			getEntiIE();
		}
	}
	//Fim problema IE
	//-->
	</script>
	<script type="text/javascript" src="../js/validacao_pb.js"></script>
	<script type="text/javascript" src="../js/mascara.js"></script>
	<script type="text/javascript" src="../js/ajax.js"></script>
	<script type="text/javascript" src="../js/cadastro.js"></script>
	<link rel="stylesheet" type="text/css" href="../css/styles.css" />
	<link rel="stylesheet" type="text/css" href="../css/form.css" />
	<title>ENSUR Inscrições</title>
</head>
	<%

	coda=request("coda")
	if coda>0 then
		jaCadastrado = true
		'response.write session("id")
		'response.end
		sql = "SELECT * FROM ALUNO WHERE COD_ALUNO="&coda
		'response.write sql
		'response.end

		RS.Open sql
		if not RS.EOF then
			CPF 			= RS("CPF")
			if isNull(CPF) then CPF = ""
			ID_TIPO		 	= RS("ID_TIPO")
			ID_NUM		 	= RS("ID_NUM")
			NOME 			= RS("NOME")
			DT_NASCIMENTO 	= RS("DT_NASCIMENTO")
			SEXO 			= RS("SEXO")
			if SEXO then SEXO=1 else SEXO=0 end if
			COD_RACA 		= RS("COD_RACA")
			EMAIL 			= RS("EMAIL")
			ENDERECO 		= RS("ENDERECO")
			CEP 			= RS("CEP")
            CEP             = replace(CEP, "-", "")
			FORMACAO 		= RS("FORMACAO")
			CEP_ENTI 		= RS("CEP_ENTI")
			TEL_DDI 		= RS("TEL_DDI")
			TEL_DDD 		= RS("TEL_DDD")
			TEL 			= RS("TEL")
			FAX_DDI 		= RS("FAX_DDI")
			FAX_DDD 		= RS("FAX_DDD")
			FAX 			= RS("FAX")
			COD_UF_IBGE 	= RS("COD_UF_IBGE")
			COD_MUNI_IBGE 	= RS("COD_MUNI_IBGE")
			CPF 			= RS("CPF")
			COD_POS 		= RS("COD_POS")
			POS 			= RS("POS")
			COD_ESCOLARIDADE = RS("COD_ESCOLARIDADE")
			NEWSLETTER		 = RS("NEWSLETTER")
			E_NOME			= RS("E_NOME")
			E_CNPJ			= RS("E_CNPJ")
			E_ENDERECO		= RS("E_ENDERECO")
			E_CEP			= RS("E_CEP")
			E_EMAIL			= RS("E_EMAIL")
			E_WWW			= RS("E_WWW")
			E_TELEFONE		= RS("E_TELEFONE")
            E_TELDDD        = mid(E_TELEFONE,3,2)
            E_TELEFONE      = mid(E_TELEFONE,5,9)
			E_FAX			= RS("E_FAX")
            if ( isNull(E_FAX) )  then E_FAX=""  end if
			TEL_DDI_ENTI 	= RS("TEL_DDI_ENTI")
			if TEL_DDI_ENTI=0 then TEL_DDI_ENTI=""
			TEL_DDD_ENTI 	= RS("TEL_DDD_ENTI")
			if TEL_DDD_ENTI=0 then TEL_DDD_ENTI=""
			TEL_ENTI 		= RS("TEL_ENTI")
			EMAIL_ENTI 		= RS("EMAIL_ENTI")
			ENDERECO_ENTI 	= RS("ENDERECO_ENTI")
			TIPOENTI		= RS("TIPOENTI")
			COD_UF_ENTI		= RS("COD_UF_ENTI")
			COD_MUNI_ENTI	= RS("COD_MUNI_ENTI")
		else
			SEXO			= -1
			CPF 			= "0"
		end if
		RS.Close
		msql = "SELECT T.*,A.SETOR,A.CARGO,A.E_NOME,A.E_CNPJ,A.E_ENDERECO,A.E_CEP,A.E_EMAIL,A.E_WWW,A.E_TELEFONE,A.E_FAX FROM TURMA_ALUNO T JOIN ALUNO A ON T.COD_ALUNO = A.COD_ALUNO WHERE A.COD_ALUNO="&coda

		RS.Open msql
		if not RS.EOF then
			CARGO 			= RS("CARGO")
			COD_ENTI 		= RS("COD_ENTI")
			CUSTO_ENTI 		= RS("CUSTO_ENTI")
			if CUSTO_ENTI then CUSTO_ENTI=1 else CUSTO_ENTI=0 end if
			SETOR 			= RS("SETOR")
			SETOR			= RS("SETOR")
			CARGO			= RS("CARGO")
			E_NOME			= RS("E_NOME")
			E_CNPJ			= RS("E_CNPJ")
			E_ENDERECO		= RS("E_ENDERECO")
			E_CEP			= RS("E_CEP")
			E_EMAIL			= RS("E_EMAIL")
			E_WWW			= RS("E_WWW")
			E_TELEFONE		= RS("E_TELEFONE")
            E_TELDDD        = mid(E_TELEFONE,3,2)
            E_TELEFONE      = mid(E_TELEFONE,5,9)
			E_FAX			= RS("E_FAX")
            if ( isNull(E_FAX) )  then E_FAX=""  end if
		else
			CUSTO_ENTI		= -1
		end if
		RS.Close
'		if isNull(COD_ENTI) then COD_ENTI=0
'		if COD_ENTI>0 AND COD_ENTI<21 then
'			RS.Open "SELECT COD_MUNI_IBGE,COD_UF_IBGE,ID_TIPO_ENTIDADE FROM ENTIDADES WHERE COD_ENTI="&COD_ENTI
'			if not RS.EOF then
'				COD_MUNI_ENTI	= RS("COD_MUNI_IBGE")
'				COD_UF_ENTI		= RS("COD_UF_IBGE")
'				tipoEnti		= RS("ID_TIPO_ENTIDADE")
'			end if
'			RS.Close
 '       else
  '          COD_MUNI_ENTI	= ""
   '         COD_UF_ENTI		= ""
    '        tipoEnti		= 21
	'	end if
	else
		jaCadastrado = false
	
		SEXO			= -1
		CPF 			= "0"
		CUSTO_ENTI		= -1
	end if
	if isNull(COD_ENTI) then COD_ENTI=0

	%>
<body onLoad="selMuni();checkNacionalidade();checkPos();getEntiInfo();remarcarMuni();">
<div id="pagina">
	<!-- #INCLUDE FILE="include/topo.asp" -->
	<div id="conteudo">
	<h1>CADASTRO DE ALUNOS</h1><p><br /></p>
	<p><br /></p>
	<%if precisaSenha and not Session("pwd"&cod)="ok" then%>
		<p>Por favor digite a senha abaixo para acessar o formulário de cadastro<%=senhaMsg%></p>
		<form action="cadastro_adm.asp" method="post" name="formSenha">
		<input type="hidden" name="cod" value="<%=cod%>">
		<input type="hidden" name="coda" value="<%=request("coda")%>">
		<input type="hidden" name="COD_CURSO" value="<%=COD_CURSO%>">
		<input type="hidden" name="tentativas" value="<%=tentativas%>">
		<fieldset>
			<p><label for="pwd">Senha</label><input type="text" name="pwd" id="pwd" maxlength="15" size="20"></p>
			<p><label for="ENVIAR">&nbsp;</label><input type="submit" name="submit" value="Enviar senha" class="buttonF"></p>
		</fieldset>
		</form>
	<%else%>
		<%if not jaCadastrado then%>
			<p>Caso já tenha participado de curso no IBAM, entre com seu CPF para preenchimento automático da ficha</p>
			<form action="login.asp" method="post" name="cpflogin">
			<input type="hidden" name="cod" value="<%=cod%>">
			<input type="hidden" name="coda" value="<%=request("coda")%>">
			<fieldset>
				<p><label for="CPF" class="requerido">CPF</label><input type="text" name="CPF" id="CPF" maxlength="11" size="12" onKeyPress="return ValidateKeyPressed('INT', this, event);"> somente números</p>
				<p><label for="ENVIAR">&nbsp;</label><input type="submit" name="submit" value="Recuperar meus dados" class="buttonF"></p>
			</fieldset>
			</form>
		<%end if%>
		<%if jaNoCurso then%>
		<div id="jaNoCurso">
			<p>Você já está inscrito neste curso e está alterando os dados da sua inscrição.</p>
		</div>
		<%end if%>
		<form name="form" method="POST" action="cadastro_aluno_resp.asp" name="form">
		<input type="hidden" name="cod" value="<%=cod%>">
		<input type="hidden" name="codEnti" value="<%=COD_ENTI%>">
		<input type="hidden" name="coda" value="<%=request("coda")%>">
		<p><br /></p>
		<fieldset>
			<legend>dados pessoais</legend>
			<p><label for="NOME" class="requerido">Nome</label><input type="text" name="NOME" id="NOME" maxlength="250" size="60" value="<%=NOME%>"></p>
			<p><label for="NACIONALIDADE" class="requerido">Nacionalidade</label><input type="radio" name="NACIONALIDADE" id="NACIONALIDADE" value="brasil" onClick="setNacionalidade(1);"<%if len(CPF)>0 and CPF<>"0" then response.write " CHECKED"%>> Brasileira&nbsp;&nbsp;&nbsp;<input type="radio" name="NACIONALIDADE" id="NACIONALIDADE" value="est" onClick="setNacionalidade(0);"<%if len(CPF)=0 then response.write " CHECKED"%>> Estrangeira</p>
			<p class="est"><label for="COD_PAIS">País</label><%=createSel("COD_PAIS","SELECT COD_PAIS,NOME FROM PAIS WHERE COD_PAIS>0 ORDER BY NOME",COD_PAIS,1,"")%></p>
			<p class="brasil"><label for="CPF" class="requerido">CPF</label><input type="text" name="CPF" id="CPF" maxlength="11" size="15" value="<%if CPF<>"0" then response.write CPF%>" onKeyPress="return ValidateKeyPressed('INT', this, event);"> somente números</p>
			<p class="est"><label for="ID_TIPO" class="requerido">Identidade Tipo</label><input type="text" name="ID_TIPO" id="ID_TIPO" maxlength="50" size="20" value="<%=ID_TIPO%>"></p>
			<p class="est"><label for="ID_NUM" class="requerido">Identidade Número</label><input type="text" name="ID_NUM" id="ID_NUM" maxlength="50" size="20" value="<%=ID_NUM%>"></p>
			<p><label for="DT_NASCIMENTO" class="requerido">Dt. Nascimento</label><input type="text" name="DT_NASCIMENTO" id="DT_NASCIMENTO" maxlength="10" size="11" value="<%=formataData(DT_NASCIMENTO)%>" onKeyPress="return ValidateKeyPressed('DATE', this, event);" onChange="valida_campo(4,this);"></p>
			<p><label for="SEXO" class="requerido">Sexo</label><input type="radio" name="SEXO" value="0"<%if SEXO=0 then response.write " CHECKED"%>> Feminino&nbsp;&nbsp;&nbsp;<input type="radio" name="SEXO" value="1"<%if SEXO=1 then response.write " CHECKED"%>> Masculino</p>
			<p><label for="COD_RACA">Raça ou Cor</label><%=createSel("COD_RACA","SELECT COD_RACA,DESCRICAO FROM RACA ORDER BY COD_RACA",COD_RACA,1,"")%></p>
			<p><label for="EMAIL" class="requerido">E-mail</label><input type="text" name="EMAIL" id="EMAIL" maxlength="250" size="40" value="<%=EMAIL%>"></p>
			<p><label for="C_EMAIL" class="requerido">Confirme e-mail</label><input type="text" name="C_EMAIL" id="C_EMAIL" maxlength="250" size="40" value="<%=EMAIL%>"></p>
			<p><label for="ENDERECO" class="requerido">Endereço</label><input type="text" name="ENDERECO" id="ENDERECO" maxlength="250" size="60" value="<%=ENDERECO%>"></p>
			<p class="brasil"><label for="CEP" class="requerido">CEP</label><input type="text" name="CEP" id="CEP" maxlength="8" size="10" value="<%=CEP%>" onKeyPress="return ValidateKeyPressed('INT', this, event);"> somente números</p>
			<p class="brasil"><label for="COD_UF_IBGE" class="requerido">UF</label><%=createSelSIM("COD_UF_IBGE","SELECT COD_UF_IBGE,SIGLA_UF FROM UF ORDER BY SIGLA_UF",COD_UF_IBGE,1,"listaMunicipios(this.value,'COD_MUNI_IBGE')")%></p>
			<p class="brasil"><label for="COD_MUNI_IBGE" class="requerido">Município</label><input type="hidden" name="muni" value="<%=COD_MUNI_IBGE%>"><select name="COD_MUNI_IBGE"><option value=0>Selecione primeiro a UF</option></select></p>
			<p><label for="TEL" class="requerido">DDI/DDD/Tel.</label><input type="text" name="TEL_DDI" id="TEL_DDI" maxlength="3" size="4" value="<%=TEL_DDI%>" onKeyPress="return ValidateKeyPressed('INT', this, event);"> / <input type="text" name="TEL_DDD" id="TEL_DDD" maxlength="3" size="4" value="<%=TEL_DDD%>" onKeyPress="return ValidateKeyPressed('INT', this, event);"> / <input type="text" name="TEL" id="TEL" maxlength="9" size="20" value="<%=TEL%>"></p>
			<p><label for="FAX">DDI/DDD/Fax</label><input type="text" name="FAX_DDI" id="FAX_DDI" maxlength="3" size="4" value="<%=FAX_DDI%>" onKeyPress="return ValidateKeyPressed('INT', this, event);"> / <input type="text" name="FAX_DDD" id="FAX_DDD" maxlength="3" size="4" value="<%=FAX_DDD%>" onKeyPress="return ValidateKeyPressed('INT', this, event);"> / <input type="text" name="FAX" id="FAX" maxlength="30" size="20" value="<%=FAX%>"></p>
		</fieldset>
		<p><br /></p>
		<fieldset>
			<legend>formação acadêmica / titulação</legend>
			<p><label for="COD_ESCOLARIDADE">Escolaridade</label><%=createSel("COD_ESCOLARIDADE","SELECT COD_ESCOLARIDADE,DESCRICAO FROM ESCOLARIDADE ORDER BY COD_ESCOLARIDADE",COD_ESCOLARIDADE,1,"checkPos()")%></p>
			<p id="pformacao"><label for="FORMACAO">Nome do curso</label><input type="text" name="FORMACAO" id="FORMACAO" maxlength="250" size="60" value="<%=FORMACAO%>"></p>
			<p><label for="COD_POS">Pós-graduação</label><%=createSel("COD_POS","SELECT COD_POS,DESCRICAO FROM POS ORDER BY COD_POS",COD_POS,1,"checkPos()")%></p>
			<p id="ppos"><label for="POS">Área (especificar)</label><input type="text" name="POS" id="POS" maxlength="250" size="60" value="<%=POS%>"></p>
		</fieldset>
		<p><br /></p>
		<fieldset>
			<legend>dados profissionais</legend>
			<p><label for="EMAIL_ENTI">E-mail</label><input type="text" name="EMAIL_ENTI" id="EMAIL_ENTI" maxlength="250" size="40" value="<%=EMAIL_ENTI%>"></p>
			<p><label for="ENDERECO_ENTI">Endereço</label><input type="text" name="ENDERECO_ENTI" id="ENDERECO_ENTI" maxlength="250" size="60" value="<%=ENDERECO_ENTI%>"></p>
			<p><label for="CEP_ENTI">CEP</label><input type="text" name="CEP_ENTI" id="CEP_ENTI" maxlength="8" size="10" value="<%=CEP_ENTI%>" onKeyPress="return ValidateKeyPressed('INT', this, event);"> somente números</p>
			<p><label for="TEL_ENTI">DDI/DDD/Tel.</label><input type="text" name="TEL_DDI_ENTI" id="TEL_DDI_ENTI" maxlength="3" size="4" value="<%=TEL_DDI_ENTI%>" onKeyPress="return ValidateKeyPressed('INT', this, event);"> / <input type="text" name="TEL_DDD_ENTI" id="TEL_DDD_ENTI" maxlength="3" size="4" value="<%=TEL_DDD_ENTI%>" onKeyPress="return ValidateKeyPressed('INT', this, event);"> / <input type="text" name="TEL_ENTI" id="TEL_ENTI" maxlength="9" size="20" value="<%=TEL_ENTI%>"></p>
		</fieldset>
		<p><br /></p>
		<fieldset>
			<legend>dados da instituição</legend>
			<div id="buscaEnti" style="display:block;">
				<p><label for="tipoEnti">Tipo instituição</label><%=createSelSIM("tipoEnti","SELECT ID_TIPO_ENTIDADE,DESCRICAO FROM TIPO_ENTIDADE",tipoEnti,1,"getEnti()")%></p>
				<p><label for="COD_UF_ENTI">UF</label><%=createSelSIM("COD_UF_ENTI","SELECT COD_UF_IBGE,SIGLA_UF FROM UF ORDER BY SIGLA_UF",COD_UF_ENTI,1,"listaMunicipios(this.value,'COD_MUNI_ENTI');getEnti()")%></p>
				<p><label for="COD_MUNI_ENTI">Município</label><input type="hidden" name="munie" value="<%=COD_MUNI_ENTI%>"><select name="COD_MUNI_ENTI" onChange="getEnti();"><option value=0>Selecione primeiro a UF</option></select></p>
				<div id="selEnti" style="display:none;">
					<p><label for="est">Selecionar sua instituição</label><select name="COD_ENTI" onChange="document.form.codEnti.value=this.value;getEntiInfo();"><option value=0></option></select></p>
					<p><label for="est">&nbsp;</label><input type="checkbox" name="naoachou" onClick="naoAchou();" value="ok"> Clique aqui se sua instituição não consta na lista acima</p>
				</div>
				<div id="admind" style="display:none;">
					<p><label for="ADMIND_AREAS" class="requerido">Área de atuação</label><%=createSelSIM("ADMI ND_AREAS","SELECT ID,AREA_DE_ATUACAO FROM ADMIND_AREAS",0,1,"")%></p>
					<p><label for="ADMIND_NATJUR" class="requerido">Nat. Jurídica</label><%=createSelSIM("ADMIND_NATJUR","SELECT ID,NATUREZA_JURIDICA FROM ADMIND_NATJUR",0,1,"")%></p>
				</div>
				<div id="assoc" style="display:none;">
					<p><label for="SUBTIPO" class="requerido">Abrangência</label><%=createSelSIM("SUBTIPO_ENTIDADE","SELECT ID_SUBTIPO_ENTIDADE,DESCRICAO FROM SUBTIPO_ENTIDADE WHERE ID_TIPO_ENTIDADE=4",0,1,"")%></p>
				</div>
				<p><label for="E_NOME">Instituição</label><input type="text" name="E_NOME" id="E_NOME" maxlength="200" size="60" value="<%=E_NOME%>"></p>
				<p><label for="E_CNPJ">CNPJ</label><input type="text" name="E_CNPJ" id="E_CNPJ" maxlength="14" size="15" value="<%=E_CNPJ%>" onKeyPress="return ValidateKeyPressed('INT', this, event);"> somente números</p>
				<p><label for="E_ENDERECO">Endereço</label><input type="text" name="E_ENDERECO" id="E_ENDERECO" value="<%=E_ENDERECO%>" maxlength="200" size="60"></p>
				<p><label for="E_CEP">CEP</label><input type="text" name="E_CEP" id="E_CEP" maxlength="8" size="10" value="<%=E_CEP%>" onKeyPress="return ValidateKeyPressed('INT', this, event);"> somente números</p>
				<p><label for="E_EMAIL">E-mail</label><input type="text" name="E_EMAIL" id="E_EMAIL" maxlength="100" size="60" value="<%=E_EMAIL%>"></p>
				<p><label for="E_WWW">Site</label><input type="text" name="E_WWW" id="E_WWW" maxlength="100" size="60" value="<%=E_WWW%>"></p>
				<p><label for="E_TELEFONE" >Tel./Ramal</label>
                <input type="text" name="E_TELDDD" id="E_TELDDD" value="<%=E_TELDDD%>" maxlength="2" size="05" onKeyPress="return ValidateKeyPressed('INT', this, event);">
                <input type="text" name="E_TELEFONE" id="E_TELEFONE" value="<%=E_TELEFONE%>" maxlength="9" size="20" onKeyPress="return ValidateKeyPressed('INT', this, event);"> / <input type="text" name="E_TELRM" id="E_TELRM" maxlength="4" size="5" onKeyPress="return ValidateKeyPressed('INT', this, event);"> somente números</p>
				<p><label for="E_FAX">Fax / Ramal</label><input type="text" name="E_FAX" id="E_FAX" maxlength="18" size="20" value="<%=E_FAX%>" onKeyPress="return ValidateKeyPressed('INT', this, event);"> / <input type="text" name="E_FAXRM" id="E_FAXRM" maxlength="4" size="5" onKeyPress="return ValidateKeyPressed('INT', this, event);"> somente números</p>
				<div id="outraEnti" style="display:none;">
					<p><label class="requerido" for="est">&nbsp;</label><a href="javascript:outraEnti();">Selecionar outra entidade</a></p>
				</div>
				<p><label for="SETOR">Setor</label><input type="text" name="SETOR" id="SETOR" maxlength="250" size="60" value="<%=SETOR%>"></p>
				<p><label for="CARGO">Cargo / Função</label><input type="text" name="CARGO" id="CARGO" maxlength="200" size="60" value="<%=CARGO%>"></p>
			</div>
			<div id="enti_ok">
			
			</div>
			<div id="enti_no" style="display:none;">
			</div>
		</fieldset>
		<p><br /></p>
		<p><br /></p>
		<p><br /><input type="checkbox" name="NEWSLETTER" value="1" CHECKED <%if NEWSLETTER then response.write " CHECKED"%>> Quero receber informações sobre cursos do IBAM<br /></p>
		<p><br /><input type="submit" name="submit" value="Enviar" class="buttonF"><br /><br /></p>
		</form>
		<br />
		<ul>
			<li>Os campos marcados em <span class="laranja">laranja</span> são obrigatórios</li>
		</ul>
	<%end if%>
	<p><br /><br /></p>
	</div>
	<!-- #INCLUDE FILE="../include/footer.asp" -->
</div>
</body>
</html>
<%
conClose
conCloseSIM
%>