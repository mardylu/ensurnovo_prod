<!-- #INCLUDE FILE="../library/parametros.asp" -->
<!-- #INCLUDE FILE="../library/conOpen.asp" -->
<!-- #INCLUDE FILE="../library/conOpenSIM.asp" -->
<!-- #INCLUDE FILE="../library/fErroMsg.asp" -->
<!-- #INCLUDE FILE="../library/fAddZero.asp" -->
<!-- #INCLUDE FILE="../library/fFormataValor.asp" -->
<!-- #INCLUDE FILE="../library/fData.asp" -->
<!-- #INCLUDE FILE="../library/fCreateSel.asp" -->
<!-- #INCLUDE FILE="../library/fChecaCPF_CNPJ.asp" -->

<%  SIGA_PROJETO=Session("siga_projeto")  %>

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<script type="text/javascript" src="../js/municipios.js"></script>
	<script language="JavaScript">
	<!--
	<%
	curMunis=""
	curCod=0
	RSSIM.Open "SELECT NOME_MUNI,COD_MUNI_IBGE,COD_UF_IBGE FROM MUNICIPIOS ORDER BY COD_UF_IBGE,NOME_MUNI"
	while not RSSIM.EOF
		codUf = RSSIM("COD_UF_IBGE")
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
		curMunis = curMunis & "##" & RSSIM("NOME_MUNI") & "|" &  RSSIM("COD_MUNI_IBGE") & "|" &  RSSIM("COD_UF_IBGE")
		RSSIM.MoveNext
	wend
	RSSIM.Close
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

    function abrir(URL) {
      var width = 800;
      var height = 500;
      var left = 40;
      var top = 40;
      window.open(URL,'janela', 'width='+width+', height='+height+', top='+top+', left='+left+', scrollbars=yes, status=no, toolbar=no, location=no, directories=no, menubar=no, resizable=no, fullscreen=no');
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
            E_CNPJ          = replace(E_CNPJ,"-","")
            E_CNPJ          = replace(E_CNPJ,".","")
            E_CNPJ          = replace(E_CNPJ,"/","")
			E_ENDERECO		= RS("E_ENDERECO")
			E_CEP			= RS("E_CEP")
			E_EMAIL			= RS("E_EMAIL")
			E_WWW			= RS("E_WWW")
			E_TELEFONE		= RS("E_TELEFONE")
			E_FAX			= RS("E_FAX")
			TEL_DDI_ENTI 	= RS("TEL_DDI_ENTI")
			if TEL_DDI_ENTI=0 then TEL_DDI_ENTI=""
			TEL_DDD_ENTI 	= RS("TEL_DDD_ENTI")
			if TEL_DDD_ENTI=0 then TEL_DDD_ENTI=""
			TEL_ENTI 		= RS("TEL_ENTI")
			EMAIL_ENTI 		= RS("EMAIL_ENTI")
			ENDERECO_ENTI 	= RS("ENDERECO_ENTI")
			TIPOENTI		= RS("TIPOENTI")
            COD_ENTI_ALUNO  = RS("COD_ENTI")
			COD_UF_ENTI		= RS("COD_UF_ENTI")
			COD_MUNI_ENTI	= RS("COD_MUNI_ENTI")
			TIPO_ENTI		= RS("TIPOENTI")
			SETOR			= RS("SETOR")
			CARGO			= RS("CARGO")

            if ( SIGA_PROJETO = 2 )  then
    			EMAIL_ENTI		= RS("E_EMAIL")
    			ENDERECO_ENTI	= RS("E_ENDERECO")
    			CEP_ENTI		= RS("E_CEP")
    			TEL_DDI_ENTI	= mid(RS("E_TELEFONE"),1,2)
    			TEL_ENTI		= RS("TELEFONE_ENTIDADE")
                TEL_ENTI        = replace(TEL_ENTI, "(", "")
                TEL_ENTI        = replace(TEL_ENTI, ")", "")
                TEL_ENTI        = replace(TEL_ENTI, "-", "")
    			TEL_DDI_ENTI	= mid(TEL_ENTI,1,2)
    			TEL_DDD_ENTI	= mid(TEL_ENTI,3,2)
    			TEL_ENTI        = mid(TEL_ENTI,5,9)
                TEL_PESSOAL     = RS("TELEFONE_PESSOAL")
                TEL_PESSOAL     = replace(TEL_PESSOAL, "(", "")
                TEL_PESSOAL     = replace(TEL_PESSOAL, ")", "")
                TEL_PESSOAL     = replace(TEL_PESSOAL, "-", "")
    			TEL_DDI		    = mid(TEL_PESSOAL,1,2)
    			TEL_DDD		    = mid(TEL_PESSOAL,3,2)
    			TEL             = mid(TEL_PESSOAL,5,9)
            else
    			EMAIL_ENTI		= RS("EMAIL_ENTI")
    			ENDERECO_ENTI	= RS("ENDERECO_ENTI")
    			CEP_ENTI		= RS("CEP_ENTI")
    			TEL_DDI_ENTI	= RS("TEL_DDI_ENTI")
    			TEL_ENTI		= RS("TEL_ENTI")
            end if

		end if
		RS.Close
    end if
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
		<form name="form" method="POST" action="cadastro_aluno_resp02.asp" name="form">
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
				<p><label for="tipoEnti">Tipo instituição</label>
                <%
                    if (tipoenti=0) then tipoenti=21    end if
                    sql = "SELECT ID_TIPO_ENTIDADE,DESCRICAO FROM TIPO_ENTIDADE WHERE ID_TIPO_ENTIDADE="&TIPOENTI
' response.write(coda&"<br>")
' response.write(sql&"<br>")
' response.end
                    RSSIM.Open sql
               		if not RSSIM.EOF then
                        tipo_descricao=RSSIM("DESCRICAO")
                    else
                        tipo_descricao="Pessoa Física"
                    end if
                    RSSIM.Close
                    Response.Write(tipo_descricao)
                    if (tipoEnti <> 21) then
                        cod_operacao = "carregar"
                    else
                        cod_operacao = "carregar"
                    end if
                %>
                    <a href="javascript:abrir('./altera_instituicao_aluno.asp?operacao=<%=cod_operacao%>&cod_aluno=<%=coda%>&cod_enti=<%=COD_ENTI_ALUNO%>');">

                    <span style="display:inline-block; width: 150;"></span>
                    Clique aqui para trocar a instituição do aluno.
                    </a>
                </p>
                <%
                    sql = "SELECT e.id_tipo_entidade,e.cod_enti,u.sigla_uf, u.nome_uf, m.nome_muni,e.cod_uf_ibge,e.cod_muni_ibge " _
                        & "FROM entidades AS e "    _
                        & "JOIN uf AS u ON e.cod_uf_ibge=u.cod_uf_ibge "    _
                        & "JOIN municipios AS m ON e.cod_muni_ibge=m.cod_muni_ibge "    _
						& "                    AND e.cod_uf_ibge=m.cod_uf_ibge  "   _
                        & "WHERE e.cod_enti="&COD_ENTI_ALUNO
                    RSSIM.Open sql

'                   Contador dos registros de instituição encontrados na tabela ENTIDADES
                    i=RSSIM.RecordCount
'response.write(sql)
		            if not RSSIM.EOF then
                        cidade_enti=RSSIM("NOME_MUNI")
                        estado_enti=RSSIM("NOME_UF")
                        sigla_enti=RSSIM("SIGLA_UF")
                    else
                        cidade_enti=""
                        estado_enti=""
                        sigla_enti =""
                    end if
                    RSSIM.Close
                %>
                <%
				'response.write "TIPO_ENTI " & TIPO_ENTI
' Response.Write("Cod_enti Select para pegar o nome: "&COD_ENTI_ALUNO)
					if TIPO_ENTI<>21 then
						sql = "SELECT * FROM ENTIDADES WHERE COD_ENTI="&COD_ENTI_ALUNO
						'response.write sql
	        			RSSIM.Open sql

	        			if not RSSIM.EOF then
	        				if isNull (RSSIM("EMPPRIV_CNPJ")) then
	        					CNPJ_ENTI = ""
	        				else
		        				CNPJ_ENTI = RSSIM("EMPPRIV_CNPJ")
		                        CNPJ_ENTI = replace(CNPJ_ENTI,"-","")
		                        CNPJ_ENTI = replace(CNPJ_ENTI,".","")
		                        CNPJ_ENTI = replace(CNPJ_ENTI,"/","")
		                        CEP_ENTI  = replace(CEP,"-","")
		                    end if
	        				COD_MUNI_ENTI	= RSSIM("COD_MUNI_IBGE")
	        				COD_UF_ENTI		= RSSIM("COD_UF_IBGE")
	        				tipoEnti		= RSSIM("ID_TIPO_ENTIDADE")
	                        NOME_ENTI       = RSSIM("NOME")
	                        ENDERECO_ENTI   = RSSIM("ENDERECO")
	                        EMAIL_ENTI      = RSSIM("EMAIL")
	                        WWW_ENTI        = RSSIM("WWW")
	                        TEL1NUM_ENTI    = "55" & RSSIM("TEL1NUM")
	                        TEL2NUM_ENTI    = "55" & RSSIM("TEL2NUM")
	                        TEL1RM_ENTI     = RSSIM("TEL1RM")
	                        TEL2RM_ENTI     = RSSIM("TEL2RM")
		        			E_CNPJ          = RSSIM("EMPPRIV_CNPJ")
	                    end if
                    else
                        CEP_ENTI        = 0
        				COD_MUNI_ENTI   = ""
        				estado_enti     = ""
        				cidade_enti     = ""
        				sigla_enti		= ""
        				COD_UF_ENTI	    = ""
        				tipoEnti	    = 21
                        NOME_ENTI       = ""
                        ENDERECO_ENTI   = ""
                        EMAIL_ENTI      = ""
                        WWW_ENTI        = ""
                        TEL1NUM_ENTI    = ""
                        TEL2NUM_ENTI    = ""
                        TEL1RM_ENTI     = ""
                        TEL2RM_ENTI     = ""
        			end if
                %>

                <input type="hidden" name="tipoenti" value="<%=tipoEnti%>">
                <input type="hidden" name="cod_uf_enti" value="<%=cod_uf_enti%>">
                <input type="hidden" name="cod_muni_enti" value="<%=cod_muni_enti%>">
				<p><label for="COD_UF_ENTI">UF</label><%=estado_enti%> - <%=sigla_enti%></p>
				<p><label for="COD_MUNI_ENTI">Município</label><%=cidade_enti%>
				<p><label for="E_NOME">Instituição</label><%=NOME_ENTI%></p>

                <%
'                if ( SIGA_PROJETO=2 )  then
'                   if (E_CNPJ <> "")  then
'                        CNPJ_formatado = mid(E_CNPJ,1,2)&"."&mid(E_CNPJ,3,3)&"."&mid(E_CNPJ,6,3)&"/"&mid(E_CNPJ,9,4)&"-"&mid(E_CNPJ,13,2)
'                    else
'                        CNPJ_formatado = "<br>"
'                    end if
 '               else
                    if (CNPJ_ENTI <> "")  then
                        CNPJ_formatado = mid(CNPJ_ENTI,1,2)&"."&mid(CNPJ_ENTI,3,3)&"."&mid(CNPJ_ENTI,6,3)&"/"&mid(CNPJ_ENTI,9,4)&"-"&mid(CNPJ_ENTI,13,2)
                    else
                        CNPJ_formatado = "<br>"
                    end if
'                end if
                %>
				<p><label for="E_CNPJ">CNPJ</label><%=CNPJ_formatado%></p>
				<p><label for="E_ENDERECO">Endereço</label><%=ENDERECO_ENTI%></p>
                <%
                    if (CEP_ENTI <> 0)  then
                        CEP_formatado = mid(CEP_ENTI,1,5)&"-"&mid(CEP_ENTI,6,3)
                    else
                        CEP_formatado = "<br>"
                    end if
                %>
				<p><label for="E_CEP">CEP</label><%=CEP_formatado%></p>
				<p><label for="E_EMAIL">E-mail</label><%=EMAIL_ENTI%></p>
				<p><label for="E_WWW">Site</label><% if ( WWW_ENTI = "" ) then Response.Write ("<br>") else Response.Write (WWW_ENTI) end if %></p>
                <%
                    TDDI  = mid(TEL1NUM_ENTI,1,2)
                    TDDD  = mid(TEL1NUM_ENTI,3,2)
                    TNUMA = mid(TEL1NUM_ENTI,5,4)
                    TNUMB = mid(TEL1NUM_ENTI,9,4)
                    if (TNUMA <> "")  then
                        TEL_formatado = "("&TDDI&") " & "("&TDDD&") " & TNUMA & "-" & TNUMB & " - " & TEL1RM_ENTI
                    else
                        TEL_formatado = "<br>"
                    end if

                    FDDI  = mid(TEL2NUM_ENTI,1,2)
                    FDDD  = mid(TEL2NUM_ENTI,3,2)
                    FNUMA = mid(TEL2NUM_ENTI,5,4)
                    FNUMB = mid(TEL2NUM_ENTI,9,4)

                    if (FNUMA <> "")  then
                        FAX_formatado = "("&FDDI&") " & "("&FDDD&") " & FNUMA & "-" & FNUMB & " - " & TEL2RM_ENTI
                    else
                        Fax_formatado = "<br>"
                    end if
                %>
				<p><label for="E_TELEFONE" >DDD/Tel./Ramal</label> <%=TEL_formatado%>
				<p><label for="E_FAX" >Fax./Ramal</label> <%=FAX_formatado%>

                <%
                'response.write("TipoEnti: " & tipoenti & "<br><br>")
                'response.write("Nome: " & RSSIM("NOME") & "<br><br>")
                'response.write("Nome: " & NOME_ENTI & "<br><br>")
                ' response.end

'                i=RSSIM.RecordCount

				if (tipoenti <> 21) and i<>-1 then   %>
                    <input type="hidden" name="E_NOME" id="E_NOME" maxlength="200" size="60" value="<%=RSSIM("NOME")%>">
    				<input type="hidden" name="E_CNPJ" id="E_CNPJ" maxlength="14" size="15" value="<%=RSSIM("EMPPRIV_CNPJ")%>" >
    				<input type="hidden" name="E_ENDERECO" id="E_ENDERECO" value="<%=RSSIM("ENDERECO")%>" maxlength="200" size="60">
    				<input type="hidden" name="E_CEP" id="E_CEP" maxlength="8" size="10" value="<%=RSSIM("CEP")%>" >
    				<input type="hidden" name="E_EMAIL" id="E_EMAIL" maxlength="100" size="60" value="<%=RSSIM("EMAIL")%>">
    				<input type="hidden" name="E_WWW" id="E_WWW" maxlength="100" size="60" value="<%=RSSIM("WWW")%>">
                    <input type="hidden" name="E_TELEFONE" id="E_TELEFONE" value="<%=RSSIM("TEL1NUM")%>" maxlength="9" size="20">
                    <input type="hidden" name="E_TELRM" id="E_TELRM" maxlength="4" size="5" value="<%=RSSIM("TEL1RM")%>">
    				<input type="hidden" name="E_FAX" id="E_FAX" maxlength="18" size="20" value="<%=RSSIM("TEL2NUM")%>">
                    <input type="hidden" name="E_FAXRM" id="E_FAXRM" maxlength="4" size="5" value="<%=RSSIM("TEL2RM")%>">
        		<%	RSSIM.Close
                end if   %>

				<p><label for="SETOR">Setor</label><input type="text" name="SETOR" id="SETOR" maxlength="250" size="60" value="<%=SETOR%>"></p>
				<p><label for="CARGO">Cargo / Função</label>
                    <input type="text" name="CARGO" id="CARGO" maxlength="200" size="60" value="<%=CARGO%>">
                    <br><br>
                    <a href="javascript:abrir('./altera_instituicao.asp?operacao=carregar&cod_enti=<%=COD_ENTI_ALUNO%>&coda=<%=coda%>');">
                    <span style="display:inline-block; width: 150;"></span>
                    <% if TIPO_ENTI<>21 then%>
                    <h5 style="text-align:right"><h5>Clique aqui para alterar os dados da instituição.</h5></font></a>
                    <% end if%>
                </p>

			</div>
		</fieldset>
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