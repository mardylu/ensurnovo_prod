<!-- #INCLUDE FILE="../library/parametros.asp" -->
<!-- #INCLUDE FILE="../library/conOpen.asp" -->
<!-- #INCLUDE FILE="../library/conOpenSIM.asp" -->
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
<!----
<%
    operacao      = request("operacao")
	cod_enti      = request("cod_enti")
    cod_aluno     = request("coda")
'	cod_uf_enti   = request("cod_uf_enti")
'	cod_muni_enti = request("cod_muni_enti")

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
	<title>ENSUR Instituições</title>
</head>

<%
    if (operacao = "carregar")   then
%>
        <body onLoad="selMuni();checkNacionalidade();checkPos();getEntiInfo();remarcarMuni();">
        <div id="pagina">




        	<div id="conteudo">
        	<h1>Alteração dos dados da Instituição</h1>

    		<form name="form" method="POST" action="altera_instituicao.asp" name="form">
    		<input type="hidden" name="cod_enti" value="<%=COD_ENTI%>">
    		<input type="hidden" name="coda" value="<%=request("coda")%>">
    		<p><br /></p>
<%
		sql = "SELECT * FROM ENTIDADES WHERE COD_ENTI="&cod_enti

        RSSIM.Open  sql
		'response.write sql
		'response.end

    	if not RSSIM.eof then

            E_NOME			= RSSIM("NOME")
            'if isNull (RSSIM("EMPPRIV_CNPJ")) then E_CNPJ="" end if
            E_CNPJ			= RSSIM("EMPPRIV_CNPJ")
            E_CNPJ          = replace(E_CNPJ,".","")
            E_CNPJ          = replace(E_CNPJ,"-","")
            E_CNPJ          = replace(E_CNPJ,"/","")

            E_ENDERECO		= RSSIM("ENDERECO")
            E_CEP			= RSSIM("CEP")
            E_CEP          = replace(E_CEP,"-","")
            E_EMAIL			= RSSIM("EMAIL")
            E_WWW			= RSSIM("WWW")
            E_TELEFONE		= RSSIM("TEL1NUM")
            E_TEL1RM	    = RSSIM("TEL1RM")
            E_TELEFONE2		= RSSIM("TEL2NUM")
            E_FAXRM	        = RSSIM("TEL2RM")
            COD_MUNI_ENTI	= RSSIM("COD_MUNI_IBGE")
            COD_UF_ENTI		= RSSIM("COD_UF_IBGE")
            tipoEnti		= RSSIM("ID_TIPO_ENTIDADE")

            E_TELEFONE      = replace(E_TELEFONE," ","")
            E_TELEFONE      = replace(E_TELEFONE,"(","")
            E_TELEFONE      = replace(E_TELEFONE,")","")
            E_TELEFONE      = replace(E_TELEFONE,"-","")
            E_TELDDD        = mid(E_TELEFONE,1,2)
            E_TELEFONE      = mid(E_TELEFONE,3,9)

            E_TELEFONE2     = replace(E_TELEFONE2," ","")
            E_TELEFONE2     = replace(E_TELEFONE2,"(","")
            E_TELEFONE2     = replace(E_TELEFONE2,")","")
            E_TELEFONE2     = replace(E_TELEFONE2,"-","")
            E_FAXDDD        = mid(E_TELEFONE2,3,2)
            E_TELEFONE2     = mid(E_TELEFONE2,5,8)

'    	    if not RSSIM.eof then
%>
        	<fieldset>
    			<legend>dados da instituição</legend>
    			<div id="buscaEnti" style="display:block;">
<% RSSIM.Close %>
    				<p><label for="tipoEnti">Tipo instituição</label>

                <%
                    sql = "SELECT ID_TIPO_ENTIDADE,DESCRICAO FROM TIPO_ENTIDADE WHERE ID_TIPO_ENTIDADE="&TIPOENTI
                    RSSIM.Open sql
                    tipo_descricao=RSSIM("DESCRICAO")
                    RSSIM.Close
                    Response.Write(tipo_descricao)
                %>
<!----
                    <a href="javascript:abrir('./altera_instituicao_aluno.asp?operacao=carregar&
                    cod_aluno=<%=COD_ALUNO%>&
                    cod_enti=<%=COD_ENTI%>
                    ');">
                    Clique aqui para selecionar uma nova instituição do aluno.</a>
---->

                </p>
                <%
                    sql = "SELECT e.id_tipo_entidade,e.cod_enti,u.sigla_uf, u.nome_uf, m.nome_muni,e.cod_uf_ibge,e.cod_muni_ibge " _
                        & "FROM entidades AS e "    _
                        & "JOIN uf AS u ON e.cod_uf_ibge=u.cod_uf_ibge "    _
                        & "JOIN municipios AS m ON e.cod_muni_ibge=m.cod_muni_ibge "    _
						& "                    AND e.cod_uf_ibge=m.cod_uf_ibge  "   _
                        & "WHERE e.cod_enti="&cod_enti
                    RSSIM.Open sql
                    cidade_enti=RSSIM("NOME_MUNI")
                    estado_enti=RSSIM("NOME_UF")
                    sigla_enti=RSSIM("SIGLA_UF")
                    RSSIM.Close
                %>
				<p><label for="COD_UF_ENTI">UF</label><%=estado_enti%> - <%=sigla_enti%></p>
				<p><label for="COD_MUNI_ENTI">Município</label><%=cidade_enti%>
                <%
        			RSSIM.Open "SELECT * FROM ENTIDADES WHERE COD_ENTI="&COD_ENTI
        			if not RSSIM.EOF then
        				COD_MUNI_ENTI	= RSSIM("COD_MUNI_IBGE")
        				COD_UF_ENTI		= RSSIM("COD_UF_IBGE")
        				tipoEnti		= RSSIM("ID_TIPO_ENTIDADE")
        			end if
                %>

                    <input type="hidden" name="E_NOME" id="E_NOME" maxlength="200" size="60" value="<%=E_NOME%>">

    				<p><label for="E_NOME">Instituição</label><%=E_NOME%></p>
    				<p><label for="E_CNPJ">CNPJ</label><input type="text" name="E_CNPJ" id="E_CNPJ" maxlength="14" size="15" value="<%=E_CNPJ%>" onKeyPress="return ValidateKeyPressed('INT', this, event);"> somente números</p>
    				<p><label for="E_ENDERECO">Endereço</label><input type="text" name="E_ENDERECO" id="E_ENDERECO" value="<%=E_ENDERECO%>" maxlength="200" size="60"></p>
    				<p><label for="E_CEP">CEP</label><input type="text" name="E_CEP" id="E_CEP" maxlength="8" size="10" value="<%=E_CEP%>" onKeyPress="return ValidateKeyPressed('INT', this, event);"> somente números</p>
    				<p><label for="E_EMAIL">E-mail</label><input type="text" name="E_EMAIL" id="E_EMAIL" maxlength="100" size="60" value="<%=E_EMAIL%>"></p>
    				<p><label for="E_WWW">Site</label><input type="text" name="E_WWW" id="E_WWW" maxlength="100" size="60" value="<%=E_WWW%>"></p>
    				<p><label for="E_TELEFONE" >DDD/Tel./Ramal</label>
                    <input type="text" name="E_TELDDD" id="E_TELDDD" value="<%=E_TELDDD%>" maxlength="2" size="05" onKeyPress="return ValidateKeyPressed('INT', this, event);">
                    <input type="text" name="E_TELEFONE" id="E_TELEFONE" value="<%=E_TELEFONE%>" maxlength="9" size="20" onKeyPress="return ValidateKeyPressed('INT', this, event);"> / <input type="text" name="E_TELRM" id="E_TELRM" value="<%=E_TEL1RM%>" maxlength="4" size="5" onKeyPress="return ValidateKeyPressed('INT', this, event);"> somente números</p>
    				<p><label for="E_FAX">DDD/Fax/Ramal</label>
                    <input type="text" name="E_FAXDDD" id="E_FAXDDD" value="<%=E_FAXDDD%>" maxlength="2" size="05" onKeyPress="return ValidateKeyPressed('INT', this, event);">
                    <input type="text" name="E_FAX" id="E_FAX" maxlength="18" size="20" value="<%=E_TELEFONE2%>" onKeyPress="return ValidateKeyPressed('INT', this, event);"> / <input type="text" name="E_FAXRM" id="E_FAXRM" value="<%=E_FAXRM%>" maxlength="4" size="5" onKeyPress="return ValidateKeyPressed('INT', this, event);"> somente números</p>
                    <p>
                    <input type="hidden" name="operacao" value="alterar">
                    <input type="submit" name="submit" value="Enviar" class="buttonF"><br /><br /></p>
            		</form>
    			</div>
    		</fieldset>
<%
        else
    		Response.Write("A instituição não foi encontrada em ENTIDADES: "&cod_enti)
    	end if

'        RSSIM.Close
    end if


' Response.Write("Cod_Enti: "&cod_enti)


    if (operacao = "alterar")   then

        erro = "nao"
	    cod_enti    = request("cod_enti")
    	E_NOME      = request("E_NOME")
        E_CNPJ      = request("E_CNPJ")
        E_ENDERECO  = request("E_ENDERECO")
        E_CEP       = request("E_CEP")
        E_EMAIL     = request("E_EMAIL")
        E_WWW       = request("E_WWW")
        E_TELDDD    = request("E_TELDDD")
        E_TELEFONE  = request("E_TELEFONE")
        E_TELRM     = request("E_TELRM")
        E_FAXDDD    = request("E_FAXDDD")
        E_TELEFONE2 = request("E_FAX")
        E_FAXRM     = request("E_FAXRM")
        E_CNPJ		= request("E_CNPJ")

        if (len(E_CNPJ) < 14)   then
            erro = "sim"
            Response.Write(len(E_CNPJ))
        %>
            <script language=javascript>
                alert('O CNPJ está inválido.');
                location.href='altera_instituicao.asp?cod_enti=<%=cod_enti%>&operacao=carregar';
            </script>";
        <%
        end if

        if (len(E_ENDERECO) < 5)   then
            erro = "sim"
        %>
            <script language=javascript>
                alert('O ENDEREÇO está inválido.');
                location.href='altera_instituicao.asp?cod_enti=<%=cod_enti%>&operacao=carregar';
            </script>";
        <%
        end if

        if (len(E_NOME) < 5)   then
            erro = "sim"
        %>
            <script language=javascript>
                alert('O NOME está inválido.');
                location.href='altera_instituicao.asp?cod_enti=<%=cod_enti%>&operacao=carregar';
            </script>";
        <%
        end if

        if (len(E_CEP) < 8)   then
            erro = "sim"
        %>
            <script language=javascript>
                alert('O CEP está inválido.');
                location.href='altera_instituicao.asp?cod_enti=<%=cod_enti%>&operacao=carregar';
            </script>";
        <%
        end if

        if (len(E_TELEFONE) > 8) OR (len(E_TELEFONE) = 0)  then
            erro = "sim"
        %>
            <script language=javascript>
                alert('O TELEFONE está inválido.');
                location.href='altera_instituicao.asp?cod_enti=<%=cod_enti%>&operacao=carregar';
            </script>";
        <%
        end if

        if (len(E_TELEFONE2) > 8) OR ( (len(E_TELEFONE2) <> 0) AND (len(E_TELEFONE2) < 8) ) then
            erro = "sim"
        %>
            <script language=javascript>
                alert('O FAX está inválido.');
                location.href='altera_instituicao.asp?cod_enti=<%=cod_enti%>&operacao=carregar';
            </script>";
        <%
        end if


        if (erro = "nao")   then
            E_TELEFONE  = "55" + E_TELDDD  + E_TELEFONE
            E_TELEFONE2 = "55" + E_FAXDDD  + E_TELEFONE2
            if (len(E_TELEFONE)  = 0) then E_TELEFONE=0  end if
            if (E_TELEFONE2 = "") then E_TELEFONE2=0 end if
            if (len(E_TELEFONE2) = 0) then E_TELEFONE2=0 end if
            sql = "UPDATE ENTIDADES SET NOME='"&E_NOME&"', "            _
                                	&"	ENDERECO='"&E_ENDERECO&"', "    _
                                	&"	CEP='"&E_CEP&"', "              _
                                	&"	EMAIL='"&E_EMAIL&"', "          _
                                	&"	WWW='"&E_WWW&"', "              _
                                	&"	TEL1NUM="&E_TELEFONE&", "       _
                                	&"	TEL1RM="&E_TELRM&", "           _
                                	&"	TEL2NUM="&E_TELEFONE2&", "      _
                                	&"	TEL2RM="&E_FAXRM&", "           _
                                	&"	EMPPRIV_CNPJ='"&E_CNPJ&"' "     _
                                &"  WHERE COD_ENTI='"&cod_enti&"'"
 'response.write(sql)
            RSSIM.Open
            conSIM.execute sql
            RSSIM.Close
            %>
                <script language=javascript>
                    alert('A instituição foi atualizada com sucesso.');
                    window.opener.location = 'altera_aluno02.asp?coda=<%=cod_aluno%>&operacao=carregar';
                    window.close("#");
                    location.href='altera_instituicao.asp?cod_enti=<%=cod_enti%>&operacao=carregar';

                </script>
            <%
        end if

    end if
%>

	<p><br /><br /></p>
	<!-- #INCLUDE FILE="../include/footer.asp" -->
</body>
</html>
<%
conClose
conCloseSIM
%>


