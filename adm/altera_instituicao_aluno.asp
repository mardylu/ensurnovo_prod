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
	cod_aluno     = request("cod_aluno")
	cod_enti      = request("cod_enti")

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

    function pega_uf()   {
        var cod_estadox = document.getElementById("cod_uf_enti").value;
        alert(cod_estadox);
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
        	<h1>Alteração da Instituição do Aluno</h1>

    		<form name="form" method="POST" action="altera_instituicao_aluno.asp" name="form">
    		<input type="hidden" name="cod_enti" value="<%=COD_ENTI%>">
    		<input type="hidden" name="coda" value="<%=request("coda")%>">
    		<p><br /></p>
<%
        sql = "SELECT tipoEnti,COD_UF_IBGE,COD_MUNI_IBGE FROM ALUNO WHERE COD_ALUNO="&cod_aluno
        RS.Open sql
        if (RS("tipoEnti") = 21)      then
            sqle =  "SELECT * FROM ENTIDADES WHERE COD_UF_IBGE="&RS("COD_UF_IBGE")     _
                                           & " AND COD_MUNI_IBGE="&RS("COD_MUNI_IBGE")   _
                                           & " AND NOME='Prefeitura'"
            RSSIM.Open  sqle
            cod_enti=RSSIM("COD_ENTI")
            Response.Write("<center>")
            Response.Write("Este aluno se inscreveu e escolheu [Pessoa Física] como instituição, foram listadas "   _
                        &  "apenas as instituições localizadas na cidade do aluno. Caso a instiuição não seja na "  _
                        &  "cidade do aluno, faça nova seleção.<br>")
            Response.Write("</center>")
            RSSIM.Close
        end if
        RS.Close
%>
<%
		sql = "SELECT * FROM ENTIDADES WHERE cod_enti="&cod_enti

        RSSIM.Open  sql

    	if not RSSIM.eof then

        E_NOME			= RSSIM("NOME")
        if isNULL (RSSIM("EMPPRIV_CNPJ")) then
            E_CNPJ = ""
        else
            E_CNPJ=RSSIM("EMPPRIV_CNPJ")
        end if
        E_CNPJ          = replace(E_CNPJ,".","")
        E_CNPJ          = replace(E_CNPJ,"-","")
        E_CNPJ          = replace(E_CNPJ,"/","")

        E_ENDERECO		= RSSIM("ENDERECO")
        E_CEP			= RSSIM("CEP")
        E_CEP           = replace(E_CEP,"-","")
        E_EMAIL			= RSSIM("EMAIL")
        E_WWW			= RSSIM("WWW")
        E_TELEFONE		= RSSIM("TEL1NUM")
        E_TEL1RM        = RSSIM("TEL1RM")
        E_TELEFONE2		= RSSIM("TEL2NUM")
        E_TEL2RM        = RSSIM("TEL2RM")
        COD_MUNI_ENTI	= RSSIM("COD_MUNI_IBGE")
        COD_UF_ENTI		= RSSIM("COD_UF_IBGE")
        tipoEnti		= RSSIM("ID_TIPO_ENTIDADE")

        E_TELEFONE      = replace(E_TELEFONE," ","")
        E_TELEFONE      = replace(E_TELEFONE,"(","")
        E_TELEFONE      = replace(E_TELEFONE,")","")
        E_TELEFONE      = replace(E_TELEFONE,"-","")
'        E_TELDDD        = mid(E_TELEFONE,3,2)
'        E_TELEFONE      = mid(E_TELEFONE,5,8)

        E_TELEFONE2     = replace(E_TELEFONE2," ","")
        E_TELEFONE2     = replace(E_TELEFONE2,"(","")
        E_TELEFONE2     = replace(E_TELEFONE2,")","")
        E_TELEFONE2     = replace(E_TELEFONE2,"-","")
'        E_TELDDD2       = mid(E_TELEFONE2,3,2)
'        E_TELEFONE2     = mid(E_TELEFONE2,5,8)

%>
        	<fieldset>
    			<legend>dados da instituição</legend>
    			<div id="buscaEnti" style="display:block;">
        <% RSSIM.Close %>
    				<p><label for="tipoEnti">Tipo instituição</label><%=createSelSIM("tipoEnti","SELECT ID_TIPO_ENTIDADE,DESCRICAO FROM TIPO_ENTIDADE",tipoEnti,1,"getEnti()")%></p>
    				<p><label for="COD_UF_ENTI">UF</label><%=createSelSIM("COD_UF_ENTI","SELECT COD_UF_IBGE,SIGLA_UF FROM UF ORDER BY SIGLA_UF",COD_UF_ENTI,1,"listaMunicipios(this.value,'COD_MUNI_ENTI');getEnti()")%></p>
    				<p><label for="COD_MUNI_ENTI">Município</label><input type="hidden" name="munie" value="<%=COD_MUNI_ENTI%>"><select name="COD_MUNI_ENTI" onChange="getEnti();"><option value=0>Selecione primeiro a UF</option></select></p>
    				<p><label for="xcodi_enti">Instituições</label>
                    <select name="instituicao"><option value=0></option>
                    <%
                    sql = "SELECT * FROM ENTIDADES WHERE COD_UF_IBGE='"&COD_UF_ENTI&"'"     _
                                                  &" AND COD_MUNI_IBGE='"&COD_MUNI_ENTI&"'" _
                                                  &" AND ID_TIPO_ENTIDADE='"&tipoEnti&"'"
                    RSSIM.OPEN sql
                    while not RSSIM.eof
                    xcod_enti=cstr(RSSIM("COD_ENTI"))
                    cod_enti =cstr(cod_enti)
' response.write("Cod_Enti: "&cod_enti&"<br>")
' response.write("xcodenti: "&xcod_enti&"<br>")
' response.write("tipoEnti: "&tipoEnti&"<br>")
                    %>
            		    <option value="<% =RSSIM("NOME") %>"<% if (cod_enti=xcod_enti) then %> selected <% end if %>><% =RSSIM("NOME") %></option>
                    <%
            		    RSSIM.movenext
            		wend
                    RSSIM.Close
                        %>
                    </select>
                    </p>
                    <%
                        if (E_CNPJ <> "")  then
                            CNPJ_formatado = mid(E_CNPJ,1,2)&"."&mid(E_CNPJ,3,3)&"."&mid(E_CNPJ,6,3)&"/"&mid(E_CNPJ,9,4)&"-"&mid(E_CNPJ,13,2)
                        else
                            CNPJ_formatado = "<br>"
                        end if
                    %>

    				<p><label for="E_CNPJ">CNPJ</label><%=CNPJ_formatado%></p>
    				<p><label for="E_ENDERECO">Endereço</label><%=E_ENDERECO%> </p>
                <%
                    if (E_CEP <> "")  then
                        CEP_formatado = mid(E_CEP,1,5)&"-"&mid(E_CEP,6,3)
                    else
                        CEP_formatado = "<br>"
                    end if
                %>
    				<p><label for="E_CEP">CEP</label><%=CEP_formatado%></p>
    				<p><label for="E_EMAIL">E-mail</label><%=E_EMAIL%></p>
    				<p><label for="E_WWW">Site</label><%=E_WWW%></p>
                <%
                    TDDD  = mid(E_TELEFONE,3,2)
                    TNUMA = mid(E_TELEFONE,5,4)
                    TNUMB = mid(E_TELEFONE,9,4)
                    if (TNUMA <> "")  then
                        TEL_formatado = "("&TDDD&") " & TNUMA & "-" & TNUMB & " - " & E_TEL1RM
                    else
                        TEL_formatado = "<br>"
                    end if

                    FDDD  = TDDD
                    FNUMA = mid(E_TELEFONE2,5,4)
                    FNUMB = mid(E_TELEFONE2,9,4)
                    if (FNUMA <> "")  then
                        FAX_formatado = "("&FDDD&") " & FNUMA & "-" & FNUMB & " - " & E_TEL2RM
                    else
                        FAX_formatado = "<br>"
                    end if
                %>

    				<p><label for="E_TELEFONE" >DDD/Tel./Ramal</label> <%=TEL_formatado%></p>
    				<p><label for="E_FAX">FAX</label><%=FAX_formatado%></p>

    				<input type="hidden" name="E_CNPJ" id="E_CNPJ" maxlength="14" size="15" value="<%=E_CNPJ%>" onKeyPress="return ValidateKeyPressed('INT', this, event);"></p>
    				<input type="hidden" name="E_ENDERECO" id="E_ENDERECO" value="<%=E_ENDERECO%>" maxlength="200" size="60"></p>
    				<input type="hidden" name="E_CEP" id="E_CEP" maxlength="8" size="10" value="<%=E_CEP%>" onKeyPress="return ValidateKeyPressed('INT', this, event);"></p>
    				<input type="hidden" name="E_EMAIL" id="E_EMAIL" maxlength="100" size="60" value="<%=E_EMAIL%>"></p>
    				<input type="hidden" name="E_WWW" id="E_WWW" maxlength="100" size="60" value="<%=E_WWW%>"></p>
                    <input type="hidden" name="E_TELDDD" id="E_TELDDD" value="<%=TDDD%>" maxlength="2" size="05" onKeyPress="return ValidateKeyPressed('INT', this, event);">
                    <input type="hidden" name="E_TELEFONE" id="E_TELEFONE" value="<%=E_TELEFONE%>" maxlength="9" size="20" onKeyPress="return ValidateKeyPressed('INT', this, event);">
                    <input type="hidden" name="E_TELRM" id="E_TELRM" maxlength="4" size="5" VALUE="<%=E_TEL1RM%>" onKeyPress="return ValidateKeyPressed('INT', this, event);"></p>
    				<input type="hidden" name="E_FAX" id="E_FAX" maxlength="18" size="20" value="<%=E_TELEFONE2%>" onKeyPress="return ValidateKeyPressed('INT', this, event);">
                    <input type="hidden" name="E_FAXRM" id="E_FAXRM" maxlength="4" size="5" VALUE="<%=E_TEL2RM%>" onKeyPress="return ValidateKeyPressed('INT', this, event);"></p>

                    <p>
                    <input type="hidden" name="cod_aluno" value="<%=cod_aluno%>">
                    <input type="hidden" name="operacao" value="confirmar">
                    <input type="submit" name="submit" value="Enviar" class="buttonF"><br /><br /></p>
            		</form>
    			</div>
    		</fieldset>
<%
        else
    		Response.Write("A instituição não foi encontrada em ENTIDADES: "&cod_enti)
            %>
' =============================================================================

        	<fieldset>
    			<legend>dados da instituição</legend>
    			<div id="buscaEnti" style="display:block;">
        <% RSSIM.Close %>
    				<p><label for="tipoEnti">Tipo instituição</label><%=createSelSIM("tipoEnti","SELECT ID_TIPO_ENTIDADE,DESCRICAO FROM TIPO_ENTIDADE",tipoEnti,1,"getEnti()")%></p>
    				<p><label for="COD_UF_ENTI">UF</label><%=createSelSIM("COD_UF_ENTI","SELECT COD_UF_IBGE,SIGLA_UF FROM UF ORDER BY SIGLA_UF",COD_UF_ENTI,1,"listaMunicipios(this.value,'COD_MUNI_ENTI');getEnti()")%></p>
    				<p><label for="COD_MUNI_ENTI">Município</label><input type="hidden" name="munie" value="<%=COD_MUNI_ENTI%>"><select name="COD_MUNI_ENTI" onChange="getEnti();"><option value=0>Selecione primeiro a UF</option></select></p>
    				<p><label for="xcodi_enti">Instituições</label>
                    <select name="instituicao"><option value=0></option>
                    <%
                    sql = "SELECT * FROM ENTIDADES WHERE COD_UF_IBGE='"&COD_UF_ENTI&"'"     _
                                                  &" AND COD_MUNI_IBGE='"&COD_MUNI_ENTI&"'" _
                                                  &" AND ID_TIPO_ENTIDADE='"&tipoEnti&"'"
                    RSSIM.OPEN sql
                    while not RSSIM.eof
                    xcod_enti=cstr(RSSIM("COD_ENTI"))
                    cod_enti =cstr(cod_enti)
' response.write("Cod_Enti: "&cod_enti&"<br>")
' response.write("xcodenti: "&xcod_enti&"<br>")
' response.write("tipoEnti: "&tipoEnti&"<br>")
                    %>
            		    <option value="<% =RSSIM("NOME") %>"<% if (cod_enti=xcod_enti) then %> selected <% end if %>><% =RSSIM("NOME") %></option>
                    <%
            		    RSSIM.movenext
            		wend
                    RSSIM.Close
                        %>
                    </select>
                    </p>
                    <%
                        if (E_CNPJ <> "")  then
                            CNPJ_formatado = mid(E_CNPJ,1,2)&"."&mid(E_CNPJ,3,3)&"."&mid(E_CNPJ,6,3)&"/"&mid(E_CNPJ,9,4)&"-"&mid(E_CNPJ,13,2)
                        else
                            CNPJ_formatado = "<br>"
                        end if
                    %>

    				<p><label for="E_CNPJ">CNPJ</label><%=CNPJ_formatado%></p>
    				<p><label for="E_ENDERECO">Endereço</label><%=E_ENDERECO%> </p>
                <%
                    if (E_CEP <> "")  then
                        CEP_formatado = mid(E_CEP,1,5)&"-"&mid(E_CEP,6,3)
                    else
                        CEP_formatado = "<br>"
                    end if
                %>
    				<p><label for="E_CEP">CEP</label><%=CEP_formatado%></p>
    				<p><label for="E_EMAIL">E-mail</label><%=E_EMAIL%></p>
    				<p><label for="E_WWW">Site</label><%=E_WWW%></p>
                <%
                    TDDD  = mid(E_TELEFONE,3,2)
                    TNUMA = mid(E_TELEFONE,5,4)
                    TNUMB = mid(E_TELEFONE,9,4)
                    if (TNUMA <> "")  then
                        TEL_formatado = "("&TDDD&") " & TNUMA & "-" & TNUMB & " - " & E_TEL1RM
                    else
                        TEL_formatado = "<br>"
                    end if

                    FDDD  = TDDD
                    FNUMA = mid(E_TELEFONE2,5,4)
                    FNUMB = mid(E_TELEFONE2,9,4)
                    if (FNUMA <> "")  then
                        FAX_formatado = "("&FDDD&") " & FNUMA & "-" & FNUMB & " - " & E_TEL2RM
                    else
                        FAX_formatado = "<br>"
                    end if
                %>

    				<p><label for="E_TELEFONE" >DDD/Tel./Ramal</label> <%=TEL_formatado%></p>
    				<p><label for="E_FAX">FAX</label><%=FAX_formatado%></p>

    				<input type="hidden" name="E_CNPJ" id="E_CNPJ" maxlength="14" size="15" value="<%=E_CNPJ%>" onKeyPress="return ValidateKeyPressed('INT', this, event);"></p>
    				<input type="hidden" name="E_ENDERECO" id="E_ENDERECO" value="<%=E_ENDERECO%>" maxlength="200" size="60"></p>
    				<input type="hidden" name="E_CEP" id="E_CEP" maxlength="8" size="10" value="<%=E_CEP%>" onKeyPress="return ValidateKeyPressed('INT', this, event);"></p>
    				<input type="hidden" name="E_EMAIL" id="E_EMAIL" maxlength="100" size="60" value="<%=E_EMAIL%>"></p>
    				<input type="hidden" name="E_WWW" id="E_WWW" maxlength="100" size="60" value="<%=E_WWW%>"></p>
                    <input type="hidden" name="E_TELDDD" id="E_TELDDD" value="<%=TDDD%>" maxlength="2" size="05" onKeyPress="return ValidateKeyPressed('INT', this, event);">
                    <input type="hidden" name="E_TELEFONE" id="E_TELEFONE" value="<%=E_TELEFONE%>" maxlength="9" size="20" onKeyPress="return ValidateKeyPressed('INT', this, event);">
                    <input type="hidden" name="E_TELRM" id="E_TELRM" maxlength="4" size="5" VALUE="<%=E_TEL1RM%>" onKeyPress="return ValidateKeyPressed('INT', this, event);"></p>
    				<input type="hidden" name="E_FAX" id="E_FAX" maxlength="18" size="20" value="<%=E_TELEFONE2%>" onKeyPress="return ValidateKeyPressed('INT', this, event);">
                    <input type="hidden" name="E_FAXRM" id="E_FAXRM" maxlength="4" size="5" VALUE="<%=E_TEL2RM%>" onKeyPress="return ValidateKeyPressed('INT', this, event);"></p>

                    <p>
                    <input type="hidden" name="cod_aluno" value="<%=cod_aluno%>">
                    <input type="hidden" name="operacao" value="confirmar">
                    <input type="submit" name="submit" value="Enviar" class="buttonF"><br /><br /></p>
            		</form>
    			</div>
    		</fieldset>


' =============================================================================
        <%
    	end if

'        RSSIM.Close
    end if


    if (operacao = "confirmar")   then
%>
        <body onLoad="selMuni();checkNacionalidade();checkPos();getEntiInfo();remarcarMuni();">
        <div id="pagina">
        	<div id="conteudo">
        	<h1>Alteração da Instituição do Aluno</h1>

            Confira os dados e clique em enviar para alterar ou clique em <a href='javascript:history.back(1)'>VOLTAR</a> para rever os dados.

    		<form name="form" method="POST" action="altera_instituicao_aluno.asp" name="form">
    		<input type="hidden" name="cod_enti" value="<%=COD_ENTI%>">
    		<input type="hidden" name="coda" value="<%=request("coda")%>">
    		<input type="hidden" name="instituicao" value="<%=request("instituicao")%>">
    		<p><br /></p>
<%
        cod_aluno       = request("cod_aluno")
        tipoEnti        = request("tipoEnti")
        COD_UF_ENTI     = request("COD_UF_ENTI")
        COD_MUNI_ENTI   = request("COD_MUNI_ENTI")
        INSTITUICAO     = request("instituicao")

	    cod_enti    = request("cod_enti")
    	E_NOME      = request("instituicao")
        E_CNPJ      = request("E_CNPJ")
        E_ENDERECO  = request("E_ENDERECO")
        E_CEP       = request("E_CEP")
        E_EMAIL     = request("E_EMAIL")
        E_WWW       = request("E_WWW")
        E_TELDDD    = request("E_TELDDD")
        E_TELEFONE  = request("E_TELEFONE")
        E_TELRM     = request("E_TELRM")
        E_TELEFONE2 = request("E_FAX")
        E_FAXRM     = request("E_FAXRM")

        E_TELEFONE      = replace(E_TELEFONE," ","")
        E_TELEFONE      = replace(E_TELEFONE,"(","")
        E_TELEFONE      = replace(E_TELEFONE,")","")
        E_TELEFONE      = replace(E_TELEFONE,"-","")

        E_TELEFONE2     = replace(E_TELEFONE2," ","")
        E_TELEFONE2     = replace(E_TELEFONE2,"(","")
        E_TELEFONE2     = replace(E_TELEFONE2,")","")
        E_TELEFONE2     = replace(E_TELEFONE2,"-","")

' response.write("xxxTipoenti: "&tipoEnti)
%>
        	<fieldset>
    			<legend>dados da instituição</legend>
    			<div id="buscaEnti" style="display:block;">
    				<p><label for="tipoEnti">Tipo instituição</label>
                    <select name="tipoEnti"><option value=0></option>

                    <%
                    sql = "SELECT ID_TIPO_ENTIDADE,DESCRICAO FROM TIPO_ENTIDADE"
                    RSSIM.OPEN sql
                    while not RSSIM.eof
                    %>
            		    <option value="<% =RSSIM("ID_TIPO_ENTIDADE") %>" <% if int(tipoEnti)=RSSIM("ID_TIPO_ENTIDADE") then %> selected <% end if %>><% =RSSIM("DESCRICAO") %></option>
                    <%
            		    RSSIM.movenext
            		wend
                    RSSIM.Close
                        %>
                    </select>
                    </p>

    				<p><label for="COD_UF_ENTI">UF</label>
                    <select name="cod_uf_enti" id="cod_uf_enti" onchange="getEnti()"><option value=0></option>
                    <%
                    sql = "SELECT * FROM UF ORDER BY SIGLA_UF"
                    RSSIM.OPEN sql
                    while not RSSIM.eof
                    %>
            		    <option value="<% =RSSIM("COD_UF_IBGE") %>" <% if int(COD_UF_ENTI)=RSSIM("COD_UF_IBGE") then %> selected <% end if %>><% =RSSIM("SIGLA_UF") %></option>
                    <%
            		    RSSIM.movenext
            		wend
                    RSSIM.Close
                        %>
                    </select>
                    </p>
<%
                    COD_UF_ENTI_AUX = request("cod_uf_enti")
' campoxxx=Request.QueryString("cod_uf_enti")
' response.write("CampoXXX do select: "&campoxxx)
' response.write("Código do select: "&COD_UF_ENTI_AUX)
%>
    				<p><label for="COD_MUNI_ENTI">Município</label>
                    <select name="cod_muni_enti"><option value=0></option>
                    <%
                    COD_UF_ENTI_AUX = request("cod_uf_enti")
                    sql = "SELECT * FROM MUNICIPIOS WHERE COD_UF_IBGE="&COD_UF_ENTI_AUX
' response.write("Código do Municipio: "&request("cod_muni_enti"))
' response.write(sql)
' response.end
                    RSSIM.OPEN sql
                    while not RSSIM.eof
                    %>
            		   <option value="<% =RSSIM("COD_MUNI_IBGE") %>" <% if int(COD_MUNI_ENTI)=RSSIM("COD_MUNI_IBGE") then %> selected <% end if %>><% =RSSIM("NOME_MUNI") %></option>
                    <%
            		    RSSIM.movenext
            		wend
                    RSSIM.Close
                    %>
                    </select>

                    </p>

    				<p><label for="E_NOME">Instituição</label><%=E_NOME%></p>
                    <%
                        if (E_CNPJ <> "")  then
                            CNPJ_formatado = mid(E_CNPJ,1,2)&"."&mid(E_CNPJ,3,3)&"."&mid(E_CNPJ,6,3)&"/"&mid(E_CNPJ,9,4)&"-"&mid(E_CNPJ,13,2)
                        else
                            CNPJ_formatado = "<br>"
                        end if
                    %>

    				<p><label for="E_CNPJ">CNPJ</label><%=CNPJ_formatado%></p>
    				<p><label for="E_ENDERECO">Endereço</label><%=E_ENDERECO%></p>
                    <%
                        if (E_CEP <> "")  then
                            CEP_formatado = mid(E_CEP,1,5)&"-"&mid(E_CEP,6,3)
                        else
                            CEP_formatado = "<br>"
                        end if
                    %>
    				<p><label for="E_CEP">CEP</label><%=CEP_formatado%></p>
    				<p><label for="E_EMAIL">E-mail</label><%=E_EMAIL%></p>
    				<p><label for="E_WWW">Site</label><% if (E_WWW="") then E_WWW="<br>" end if%><%=E_WWW%></p>

                <%
                    TDDD  = E_TELDDD
                    TNUMA = mid(E_TELEFONE,1,4)
                    TNUMB = mid(E_TELEFONE,5,4)
		            if TNUMA=""       or isNumeric(TNUMA)=false     then TNUMA=0
                    if (TNUMA = 0)  then TNUMA="" end if
                    if (TNUMA <> "")  then
                        TEL_formatado = "("&TDDD&") " & TNUMA & "-" & TNUMB & " - " & E_TELRM
                    else
                        TEL_formatado = "<br>"
                    end if

                    FDDD  = TDDD
                    FNUMA = mid(E_TELEFONE2,1,4)
                    FNUMB = mid(E_TELEFONE2,5,4)
		            if FNUMA=""       or isNumeric(FNUMA)=false     then FNUMA=0
                    if (FNUMA = 0)  then FNUMA="" end if
                    if (FNUMA <> "")  then
                        FAX_formatado = "("&FDDD&") " & FNUMA & "-" & FNUMB & " - " & E_FAXRM
                    else
                        FAX_formatado = "<br>"
                    end if
                %>

    				<p><label for="E_TELEFONE" >DDD/Tel./Ramal</label> <%=TEL_formatado%></p>
    				<p><label for="E_FAX">FAX</label><%=FAX_formatado%></p>

                    <p>
                    <input type="hidden" name="E_ENDERECO" id="E_ENDERECO" value="<%=E_ENDERECO%>" maxlength="200" size="60"></p>
                    <input type="hidden" name="E_CEP" id="E_CEP" maxlength="8" size="10" value="<%=E_CEP%>" onKeyPress="return ValidateKeyPressed('INT', this, event);"> </p>
                    <input type="hidden" name="E_EMAIL" id="E_EMAIL" maxlength="100" size="60" value="<%=E_EMAIL%>"></p>
                    <input type="hidden" name="E_WWW" id="E_WWW" maxlength="100" size="60" value="<%=E_WWW%>"></p>
                    <input type="hidden" name="E_TELDDD" id="E_TELDDD" value="<%=E_TELDDD%>" maxlength="2" size="05" onKeyPress="return ValidateKeyPressed('INT', this, event);">
                    <input type="hidden" name="E_TELEFONE" id="E_TELEFONE" value="<%=E_TELEFONE%>" maxlength="9" size="20" onKeyPress="return ValidateKeyPressed('INT', this, event);">
                    <input type="hidden" name="E_TELRM" id="E_TELRM" maxlength="4" size="5" onKeyPress="return ValidateKeyPressed('INT', this, event);"> </p>
                    <input type="hidden" name="E_FAX" id="E_FAX" maxlength="18" size="20" value="<%=E_FAX%>" onKeyPress="return ValidateKeyPressed('INT', this, event);">
                    <input type="hidden" name="E_FAXRM" id="E_FAXRM" maxlength="4" size="5" onKeyPress="return ValidateKeyPressed('INT', this, event);"> </p>
                    <input type="hidden" name="operacao" value="alterar">
                    <input type="hidden" name="cod_aluno" value="<%=cod_aluno%>">
                    <input type="submit" name="submit" value="Enviar" class="buttonF"><br /><br /></p>
            		</form>
    			</div>
    		</fieldset>
<%

    end if

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
        E_TELEFONE2 = request("E_FAX")

        tipoEnti        = request("tipoEnti")
        COD_UF_ENTI     = request("COD_UF_ENTI")
        COD_MUNI_ENTI   = request("COD_MUNI_ENTI")
        cod_aluno       = request("cod_aluno")
        instituicao     = request("instituicao")

        sql = "SELECT * FROM ENTIDADES WHERE COD_UF_IBGE='"&COD_UF_ENTI&"'"     _
                                      &" AND COD_MUNI_IBGE='"&COD_MUNI_ENTI&"'" _
                                      &" AND ID_TIPO_ENTIDADE='"&tipoEnti&"'"   _
                                      &" AND NOME='"&instituicao&"'"

        RSSIM.OPEN sql

        if not RSSIM.eof then
            novo_cod_enti=RSSIM("COD_ENTI")
        else
            novo_cod_enti=21
        end if

        RSSIM.Close

        sql = "UPDATE ALUNO SET COD_ENTI='"&novo_cod_enti&"',tipoenti='"&tipoEnti&"' WHERE COD_ALUNO='"&cod_aluno&"'"
' response.write(sql)
    	Con.Execute sql

'        RS.Open sql
'        RS.Close
        %>
            <script language=javascript>
                alert('A instituição do aluno foi atualizada com sucesso.');
                window.opener.location = 'altera_aluno02.asp?coda=<%=cod_aluno%>&operacao=carregar';
                window.close("#");
            </script>
        <%
end if

%>

	<p><br /><br /></p>
</body>
</html>
<%
conClose
conCloseSIM
%>


