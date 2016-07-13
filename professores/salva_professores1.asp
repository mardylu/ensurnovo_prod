<!-- #INCLUDE FILE="../library/parametros.asp" -->
<!-- #INCLUDE FILE="../library/conOpen.asp" -->
<!-- #INCLUDE FILE="../library/conOpenAF.asp" -->
<!-- #INCLUDE FILE="../library/conOpenSIM.asp" -->
<!-- #INCLUDE FILE="../library/fAddZero.asp" -->
<!-- #INCLUDE FILE="../library/fErroMsg.asp" -->
<!-- #INCLUDE FILE="../library/fData.asp" -->
<!-- #INCLUDE FILE="../library/vHoje.asp" -->
<!-- #INCLUDE FILE="../library/fFormataData.asp" -->
<!-- #INCLUDE FILE="../library/fChecaCPF_CNPJ.asp" -->

<%

cod = request("cod")

'if cod="" or isNumeric(cod)=false then erroMsg("Código inválido. Favor fazer um refresh no navegador e tentar novamente")

NOME=Replace(Request.Form("NOME"),"'","''")
if Len(NOME)=0 then erroMsg("Campo de nome é obrigatório")

CPF=Replace(Request.Form("CPF"),"'","''")
if Len(CPF)=0 then erroMsg("Campo de cpf é obrigatório")

SENHA=Replace(Request.Form("SENHA")," ","")
if Len(SENHA)=0 then erroMsg("Campo de senha é obrigatório")

if Len(CPF)>0 then
	checaCPF_CNPJ CPF,1
	CPF=addZero(CPF,11)
end if

EMAIL=Replace(Request.Form("EMAIL"),"'","''")
if Len(EMAIL)=0 then erroMsg("Campo de E-mail é obrigatório")

TELEFONECEL=Replace(Request.Form("TELEFONECEL"),"'","''")
if Len(TELEFONECEL)=0 then erroMsg("Campo de Telefone celular é obrigatório")

TELEFONERES=Replace(Request.Form("TELEFONERES"),"'","''")
if Len(TELEFONERES)=0 then erroMsg("Campo de Telefone residencial é obrigatório")

ENDERECO=Replace(Request.Form("ENDERECO"),"'","''")
if Len(ENDERECO)=0 then erroMsg("Campo de endereço é obrigatório")

CEP=Replace(Request.Form("CEP"),"'","''")
if Len(CEP)=0 then erroMsg("Campo de CEP é obrigatório")

COD_UF_IBGE=Replace(Request.Form("COD_UF_IBGE"),"'","''")
if Len(COD_UF_IBGE)=0 then erroMsg("Campo de UF é obrigatório")

COD_MUNI_IBGE=Replace(Request.Form("COD_MUNI_IBGE"),"'","''")
if Len(COD_MUNI_IBGE)=0 then erroMsg("Campo de municipio é obrigatório")

COD_ESCOLARIDADE=Replace(Request.Form("COD_ESCOLARIDADE"),"'","''")
if Len(COD_ESCOLARIDADE)=0 then erroMsg("Escolaridade é obrigatório")

TELEFONECEL=request.form("TELEFONECEL")
TELEFONERES=request.form("TELEFONERES")
TEMA1=request.form("ID_TEMA1")
TEMA2=request.form("ID_TEMA2")
TEMA3=request.form("ID_TEMA3")
TEMA4=request.form("ID_TEMA4")
TEMA5=request.form("ID_TEMA5")
TEMA6=request.form("ID_TEMA6")
DATA_NASCIMENTO=request.form("DATA_NASCIMENTO")
NOME_FANTASIA=request.form("NOME_FANTASIA")
SUBTEMA1=request.form("ID_SUBTEMA1")
SUBTEMA2=request.form("ID_SUBTEMA2")
SUBTEMA3=request.form("ID_SUBTEMA3")
SUBTEMA4=request.form("ID_SUBTEMA4")
SUBTEMA5=request.form("ID_SUBTEMA5")
SUBTEMA6=request.form("ID_SUBTEMA6")
SUBTEMA7=request.form("ID_SUBTEMA7")
SUBTEMA8=request.form("ID_SUBTEMA8")
SUBTEMA9=request.form("ID_SUBTEMA9")
SUBTEMA10=request.form("ID_SUBTEMA10")
SUBTEMA11=request.form("ID_SUBTEMA11")
SUBTEMA12=request.form("ID_SUBTEMA12")
SUBTEMA13=request.form("ID_SUBTEMA13")
SUBTEMA14=request.form("ID_SUBTEMA14")
SUBTEMA15=request.form("ID_SUBTEMA15")
SUBTEMA16=request.form("ID_SUBTEMA16")
SUBTEMA17=request.form("ID_SUBTEMA17")
SUBTEMA18=request.form("ID_SUBTEMA18")
SUBTEMA19=request.form("ID_SUBTEMA19")
SUBTEMA20=request.form("ID_SUBTEMA20")
SUBTEMA21=request.form("ID_SUBTEMA21")
SUBTEMA22=request.form("ID_SUBTEMA22")
SUBTEMA23=request.form("ID_SUBTEMA23")
SUBTEMA24=request.form("ID_SUBTEMA24")
DOMINGOM=request.form("DOMINGOM")
DOMINGOT=request.form("DOMINGOT")
DOMINGON=request.form("DOMINGON")
SEGUNDAM=request.form("SEGUNDAM")
SEGUNDAT=request.form("SEGUNDAT")
SEGUNDAN=request.form("SEGUNDAN")
TERCAM=request.form("TERCAM")
TERCAT=request.form("TERCAT")
TERCAN=request.form("TERCAN")
QUARTAM=request.form("QUARTAM")
QUARTAT=request.form("QUARTAT")
QUARTAN=request.form("QUARTAN")
QUINTAM=request.form("QUINTAM")
QUINTAT=request.form("QUINTAT")
QUINTAN=request.form("QUINTAN")
SEXTAM=request.form("SEXTAM")
SEXTAT=request.form("SEXTAT")
SEXTAN=request.form("SEXTAN")
SABADOM=request.form("SABADOM")
SABADOT=request.form("SABADOT")
SABADON=request.form("SABADON")
EMAIL=request.form("EMAIL")
MINICURRICULO=request.form("MINICURRICULO")
GUID_PROF=request.form("id")
COD_UF_IBGE=request.form("COD_UF_IBGE")
COD_MUNI_IBGE=request.form("COD_MUNI_IBGE")
ENDERECO=request.form("ENDERECO")
BAIRRO=request.form("BAIRRO")
CEP=request.form("CEP")
COD_ESCOLARIDADE=request.form("COD_ESCOLARIDADE")
FORMACAO=request.form("FORMACAO")
COD_POS=request.form("COD_POS")
POS=request.form("POS")

MINICURRICULO=Replace(Request.Form("MINICURRICULO"),"  "," ")


CPF=Replace(Request.Form("CPF"),"'","''")
if Len(CPF)>0 then
	sqlx = "SELECT NOME, CPF FROM PROFESSORES WHERE CPF='"&CPF&"'"
	RS.Open (sqlx)
	if not RS.EOF then erroMsg("O professor já está cadastrado. Por favor, retorne e digite o CPF para recuperar os seus dados")
	RS.Close
end if


CPF = Replace(CPF,".","")
CPF = Replace(CPF,"-","")
CPF = mid(CPF, 1, 3) & "." & mid(CPF, 4, 3) & "." & mid(CPF, 7, 3) & "-" & mid(CPF, 10, 2)
if session("id")=""  or isNumeric(session("id"))=false    then session("id")=0
if session("id")>0 then
	sql = "UPDATE PROFESSORES SET SENHA='"&SENHA&"',POS='"&POS&"',COD_POS='"&COD_POS&"',FORMACAO='"&FORMACAO&"',COD_ESCOLARIDADE='"&COD_ESCOLARIDADE&"',ENDERECO='"&ENDERECO&"',BAIRRO='"&BAIRRO&"',CEP='"&CEP&"',COD_MUNI_IBGE='"&COD_MUNI_IBGE&"',COD_UF_IBGE='"&COD_UF_IBGE&"',DATA_NASCIMENTO='"&formatadataG(DATA_NASCIMENTO)&"',NOME_FANTASIA='"&NOME_FANTASIA&"',NOME='"&NOME&"',CPF='"&CPF&"',TELEFONECEL='"&TELEFONECEL&"',TELEFONERES='"&TELEFONERES&"',TEMA1='"&TEMA1&"',TEMA2='"&TEMA2&"',TEMA3='"&TEMA3&"',TEMA4='"&TEMA4&"',TEMA5='"&TEMA5&"',TEMA6='"&TEMA6&"',SUBTEMA1='"&SUBTEMA1&"',SUBTEMA2='"&SUBTEMA2&"',SUBTEMA3='"&SUBTEMA3&"',SUBTEMA4='"&SUBTEMA4&"',SUBTEMA5='"&SUBTEMA5&"',SUBTEMA6='"&SUBTEMA6&"',SUBTEMA7='"&SUBTEMA7&"',SUBTEMA8='"&SUBTEMA8&"',SUBTEMA9='"&SUBTEMA9&"',SUBTEMA10='"&SUBTEMA10&"',SUBTEMA11='"&SUBTEMA11&"',SUBTEMA12='"&SUBTEMA12&"',SUBTEMA13='"&SUBTEMA13&"',SUBTEMA14='"&SUBTEMA14&"',SUBTEMA15='"&SUBTEMA15&"',SUBTEMA16='"&SUBTEMA16&"',SUBTEMA17='"&SUBTEMA17&"',SUBTEMA18='"&SUBTEMA18&"',SUBTEMA19='"&SUBTEMA19&"',SUBTEMA20='"&SUBTEMA20&"',SUBTEMA21='"&SUBTEMA21&"',SUBTEMA22='"&SUBTEMA22&"',SUBTEMA23='"&SUBTEMA23&"',SUBTEMA24='"&SUBTEMA24&"',SEGUNDAM='"&SEGUNDAM&"',SEGUNDAT='"&SEGUNDAT&"',SEGUNDAN='"&SEGUNDAN&"',DOMINGOM='"&DOMINGOM&"',DOMINGOT='"&DOMINGOT&"',DOMINGON='"&DOMINGON&"',TERCAM='"&TERCAM&"',TERCAT='"&TERCAT&"',TERCAN='"&TERCAN&"',QUARTAM='"&QUARTAM&"',QUARTAT='"&QUARTAT&"',QUARTAN='"&QUARTAN&"',QUINTAM='"&QUINTAM&"',QUINTAT='"&QUINTAT&"',QUINTAN='"&QUINTAN&"',SEXTAM='"&SEXTAM&"',SEXTAT='"&SEXTAT&"',SEXTAN='"&SEXTAN&"',SABADOM='"&SABADOM&"',SABADOT='"&SABADOT&"',SABADON='"&SABADON&"',EMAIL='"&EMAIL&"',MINICURRICULO='"&MINICURRICULO&"',GUID_PROF='"&GUID_PROF&"' WHERE ID_PROFESSOR="&session("id")

	con.execute sql
	conClose
	conCloseSIM
	conCloseAF
	%>
		<script language="JavaScript">
		<!--
			alert("Seus dados foram atualizados com sucesso!");
			window.close();
		//-->
		</script>
	<%
		Response.End
else
	sql = "INSERT INTO PROFESSORES (POS,COD_POS,FORMACAO,COD_ESCOLARIDADE,ENDERECO,BAIRRO,CEP,COD_MUNI_IBGE,COD_UF_IBGE,DATA_NASCIMENTO,STATUS_PROFESSOR,NOME_FANTASIA,NOME,CPF,TELEFONECEL,TELEFONERES,TEMA1,TEMA2,TEMA3,TEMA4,TEMA5,TEMA6,SUBTEMA1,SUBTEMA2,SUBTEMA3,SUBTEMA4,SUBTEMA5,SUBTEMA6,SUBTEMA7,SUBTEMA8,SUBTEMA9,SUBTEMA10,SUBTEMA11,SUBTEMA12,SUBTEMA13,SUBTEMA14,SUBTEMA15,SUBTEMA16,SUBTEMA17,SUBTEMA18,SUBTEMA19,SUBTEMA20,SUBTEMA21,SUBTEMA22,SUBTEMA23,SUBTEMA24,DOMINGOM,DOMINGOT,DOMINGON,SEGUNDAM,SEGUNDAT,SEGUNDAN,TERCAM,TERCAT,TERCAN,QUARTAM,QUARTAT,QUARTAN,QUINTAM,QUINTAT,QUINTAN,SEXTAM,SEXTAT,SEXTAN,SABADOM,SABADOT,SABADON,EMAIL,MINICURRICULO,GUID_PROF,SIGA_PROJETO) VALUES ('"&POS&"','"&COD_POS&"','"&FORMACAO&"','"&COD_ESCOLARIDADE&"','"&ENDERECO&"','"&BAIRRO&"','"&CEP&"','"&COD_MUNI_IBGE&"','"&COD_UF_IBGE&"','"&formatadataG(DATA_NASCIMENTO)&"','Bloqueado','"&NOME_FANTASIA&"','"&NOME&"','"&CPF&"','"&TELEFONECEL&"','"&TELEFONERES&"','"&TEMA1&"','"&TEMA2&"','"&TEMA3&"','"&TEMA4&"','"&TEMA5&"','"&TEMA6&"','"&SUBTEMA1&"','"&SUBTEMA2&"','"&SUBTEMA3&"','"&SUBTEMA4&"','"&SUBTEMA5&"','"&SUBTEMA6&"','"&SUBTEMA7&"','"&SUBTEMA8&"','"&SUBTEMA9&"','"&SUBTEMA10&"','"&SUBTEMA11&"','"&SUBTEMA12&"','"&SUBTEMA13&"','"&SUBTEMA14&"','"&SUBTEMA15&"','"&SUBTEMA16&"','"&SUBTEMA17&"','"&SUBTEMA18&"','"&SUBTEMA19&"','"&SUBTEMA20&"','"&SUBTEMA21&"','"&SUBTEMA22&"','"&SUBTEMA23&"','"&SUBTEMA24&"','"&DOMINGOM&"','"&DOMINGOT&"','"&DOMINGON&"','"&SEGUNDAM&"','"&SEGUNDAT&"','"&SEGUNDAN&"','"&TERCAM&"','"&TERCAT&"','"&TERCAN&"','"&QUARTAM&"','"&QUARTAT&"','"&QUARTAN&"','"&QUINTAM&"','"&QUINTAT&"','"&QUINTAN&"','"&SEXTAM&"','"&SEXTAT&"','"&SEXTAN&"','"&SABADOM&"','"&SABADOT&"','"&SABADON&"','"&EMAIL&"','"&MINICURRICULO&"','"&GUID_PROF&"','0')"
	con.execute sql
	conClose
	conCloseSIM
	conCloseAF
	%>
		<script language="JavaScript">
		<!--
			alert("Obrigado por se cadastrar como professor do IBAM, dentro de alguns dias nós entraremos em contato com você informando a senha e a liberação do seu acesso ao sistema.");
			window.close();
		//-->
		</script>
	<%
		Response.End
end if
%>
