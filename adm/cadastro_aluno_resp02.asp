<!-- #INCLUDE FILE="../library/parametros.asp" -->
<!-- #include file="../inc/settings.asp" -->
<!-- #INCLUDE FILE="../library/conOpen.asp" -->
<!-- #INCLUDE FILE="../library/conOpenSIM.asp" -->
<!-- #INCLUDE FILE="../library/fErroMsg.asp" -->
<!-- #INCLUDE FILE="../library/fAddZero.asp" -->
<!-- #INCLUDE FILE="../library/fFormataValor.asp" -->
<!-- #INCLUDE FILE="../library/fData.asp" -->
<!-- #INCLUDE FILE="../library/fChecaCPF_CNPJ.asp" -->
<!-- #INCLUDE FILE="../library/vHoje.asp" -->
<!-- #INCLUDE FILE="../library/fFormataCPF.asp" -->
<!-- #INCLUDE FILE="../library/fFormataData.asp" -->
<!-- #INCLUDE FILE="../library/fEmail.asp" -->

<%
function checaInt(qual)
	if qual="" or isNumeric(qual)=false then qual=0
	checaInt = int(qual)
end function

Dim regEx
Set regEx = New RegExp
regEx.Pattern = "^[0-9]{2}\/[0-9]{2}\/[0-9]{4}$"
function validaData(wData)
	if regEx.Test(wData) then
		dataArray = Split(wData,"/")
		if isDate(dataArray(0)&" - "&MonthName(dataArray(1))&","&dataArray(2))=False Then
			validaData = 0
		else
			if int(dataArray(2))<1000 then
				validaData = 0
			else
				validaData = int(dataArray(2)&dataArray(1)&dataArray(0))
			end if
		end if
	else
		validaData = 0
	end if
end function

'Para evitar perda dos dados do IE no back


COD_MUNI_ENTI=checaInt(Request.Form("COD_MUNI_ENTI"))
if COD_MUNI_ENTI>0 then
	%><script language="javascript">document.cookie ='muniEnti=<%=COD_MUNI_ENTI%>; expires=Sat, 2 Aug 3000 20:47:11 UTC; path=/';</script><%
end if
COD_MUNI_IBGE=checaInt(Request.Form("COD_MUNI_IBGE"))
if COD_MUNI_IBGE>0 then
	%><script language="javascript">document.cookie ='muniPess=<%=COD_MUNI_IBGE%>; expires=Sat, 2 Aug 3000 20:47:11 UTC; path=/';</script><%
end if

cod=checaInt(Request.Form("cod"))
codEnti=checaInt(Request.Form("codEnti"))
coda=request("coda")

TIPOENTI=request("tipoEnti")
COD_UF_ENTI=request("COD_UF_ENTI")
COD_MUNI_ENTI=request("COD_MUNI_ENTI")

'est=request("est")
SETOR=request("SETOR")
CARGO=request("CARGO")
FORMA_PAGAMENTO=request("FORMA_PAGAMENTO")

E_NOME=request("E_NOME")
E_CNPJ=request("E_CNPJ")
E_ENDERECO=request("E_ENDERECO")
E_CEP=request("E_CEP")
E_CEP=replace(E_CEP,"-","")
E_EMAIL=request("E_EMAIL")
E_WWW=request("E_WWW")
E_TELEFONE=request("E_TELEFONE")
E_FAX=request("E_FAX")

' Response.write("xxxxxxxxxxxxxxxxxxxxxxxxxxx<br>")
' Response.write("TipoEnti: "&tipoEnti&"<br>")
' Response.write("COD_UF_ENTI: "&cod_uf_enti&"<br>")
' Response.write("COD_MUNI_ENTI: "&cod_muni_enti&"<br>")
' Response.write("E_NOME: "&E_NOME&"<br>")
' Response.write("E_CNPJ: "&E_CNPJ&"<br>")

' if (TIPOENTI>0 AND TIPOENTI<21) then erroMsg("Favor selecionar o tipo de institui��o")
if (TIPOENTI>0 AND TIPOENTI<21) then
    if COD_UF_ENTI=0 then erroMsg("Favor selecionar a unidade da federa��o da institui��o")   end if
end if
if (TIPOENTI>0 AND TIPOENTI<21) then
    if COD_MUNI_ENTI="" then  COD_MUNI_ENTI=0  end if
    ' Response.write("TipoEnti dentro: "&tipoEnti&"<br>")
    if COD_MUNI_ENTI=0 then
        erroMsg("Favor selecionar o municipio da institui��o")
    end if
end if
'if est="" then erroMsg("Favor selecionar o tipo de institui��o")

CPF=checaInt(Request.Form("CPF"))
NACIONALIDADE=Replace(Request.Form("NACIONALIDADE"),"'","''")
if NACIONALIDADE<>"brasil" and NACIONALIDADE<>"est" then erroMsg("Favor selecionar a nacionalidade")
if NACIONALIDADE="est" then CPF=0

if NACIONALIDADE="brasil" and CPF=0 then erroMsg("Favor indicar seu CPF")

CPF=replace(CPF,"-","")
CPF=replace(CPF,".","")

if CPF<>0 then
	checaCPF_CNPJ CPF,1
	CPF=addZero(CPF,11)
end if


if codEnti>0 then
	'RSSIM.Open "SELECT COUNT(*) FROM ENTIDADES WHERE COD_ENTI="&codEnti
	'	if RSSIM(0)=0 then erroMsg("Institui��o n�o encontrada, favor reiniciar o processo de cadastro")
	'RSSIM.Close
	'entiJaExiste=true
else
	entiJaExiste=false

	tipoEnti=checaInt(Request.Form("tipoEnti"))
	RSSIM.Open "SELECT COUNT(*) FROM TIPO_ENTIDADE WHERE ID_TIPO_ENTIDADE="&tipoEnti
	if RSSIM(0)=0 then
		if entiObrigatorio then erroMsg("O preenchimento dos campos da institui��o s�o obrigat�rios quando o pagamento � de responsabilidade dela")
		tipoEnti=0
	end if
	RSSIM.Close

	COD_UF_ENTI=checaInt(Request.Form("COD_UF_ENTI"))
	COD_MUNI_ENTI=checaInt(Request.Form("COD_MUNI_ENTI"))
	if (tipoEnti=16 or tipoEnti=18) and codMuni=0 then
		COD_UF_ENTI="null"
		COD_MUNI_ENTI="null"
	else
		RSSIM.Open "SELECT COUNT(*) FROM MUNICIPIOS WHERE COD_UF_IBGE="&COD_UF_ENTI&" AND COD_MUNI_IBGE="&COD_MUNI_ENTI
		if RSSIM(0)=0 then
			if entiObrigatorio or (tipoEnti>0 AND tipoenti<21) then erroMsg(" Favor selecionar o munic�pio da institui��o")
		end if
		RSSIM.Close
	end if

	ADMIND_AREAS=checaInt(Request.Form("ADMIND_AREAS"))
	ADMIND_NATJUR=checaInt(Request.Form("ADMIND_NATJUR"))
	if tipoEnti=3 then
		if ADMIND_AREAS=0 or ADMIND_NATJUR=0 then erroMsg("Preencher todos os campos obrigat�rios da institui��o")
		RSSIM.Open "SELECT COUNT(*) FROM ADMIND_AREAS WHERE ID="&ADMIND_AREAS
		if RSSIM(0)=0 then erroMsg("Preencher todos os campos obrigat�rios da institui��o")
		RSSIM.Close
		RSSIM.Open "SELECT COUNT(*) FROM ADMIND_NATJUR WHERE ID="&ADMIND_NATJUR
		if RSSIM(0)=0 then erroMsg("Preencher todos os campos obrigat�rios da institui��o")
		RSSIM.Close
	end if
	if ADMIND_AREAS=0 then ADMIND_AREAS="null"
	if ADMIND_NATJUR=0 then ADMIND_NATJUR="null"

	SUBTIPO_ENTIDADE=checaInt(Request.Form("SUBTIPO_ENTIDADE"))
	if tipoEnti=4 then
		if SUBTIPO_ENTIDADE=0 then erroMsg("Preencher todos os campos obrigat�rios da institui��o")
		RSSIM.Open "SELECT COUNT(*) FROM SUBTIPO_ENTIDADE WHERE ID_SUBTIPO_ENTIDADE="&SUBTIPO_ENTIDADE
		if RSSIM(0)=0 then erroMsg("Preencher todos os campos obrigat�rios da institui��o")
		RSSIM.Close
	end if
	if SUBTIPO_ENTIDADE=0 then SUBTIPO_ENTIDADE="null"

	E_NOME=Replace(Request.Form("E_NOME"),"'","''")
	if Len(E_NOME)=0 and tipoEnti>0 and tipoenti<21 then erroMsg("O nome da institui��o deve ser preenchido")
	E_CNPJ=Replace(Request.Form("E_CNPJ"),"'","''")
	E_ENDERECO=Replace(Request.Form("E_ENDERECO"),"'","''")
	E_CEP=checaInt(Request.Form("E_CEP"))
    E_CEP=replace(E_CEP,"-","")
	' if E_CEP=0 then E_CEP="null"
	E_EMAIL=Replace(Request.Form("E_EMAIL"),"'","''")
	E_WWW=Replace(Request.Form("E_WWW"),"'","''")
	E_TELEFONE=checaInt(Request.Form("E_TELEFONE"))
	E_TELRM=checaInt(Request.Form("E_TELRM"))
	if E_TELRM=0 then E_TELRM="null"
	E_FAX=checaInt(Request.Form("E_FAX"))
	if E_FAX=0 then E_FAX="null"
	E_FAXRM=checaInt(Request.Form("E_FAXRM"))
	if E_FAXRM=0 then E_FAXRM="null"
end if

'	###	DADOS PESSOAIS	###

NOME=Replace(Request.Form("NOME"),"'","''")
if Len(NOME)=0 then erroMsg("O nome deve ser preenchido")

'COD_CURSO=REQUEST("COD_CURSO")

ID_TIPO=Replace(Request.Form("ID_TIPO"),"'","''")
ID_NUM=Replace(Request.Form("ID_NUM"),"'","''")

DT_NASCIMENTO=validaData(Request.Form("DT_NASCIMENTO"))
if DT_NASCIMENTO=0 then erroMsg("A data de nascimento deve ser preenchida")
SEXO=Request.Form("SEXO")
if SEXO<>"0" and SEXO<>"1" then erroMsg("O sexo deve ser preenchido")
SEXO=int(SEXO)
COD_RACA=checaInt(Request.Form("COD_RACA"))
' if COD_RACA=0 then COD_RACA="null"

'checagem de e-mail
E_MAIL=Replace(Request.Form("EMAIL"),"'","''")
Set reMail = New RegExp
reMail.Pattern = "^[\w-\.]{1,}\@([\da-zA-Z-]{1,}\.){1,}[\da-zA-Z-]{2,3}$"
if (tipoEnti<>21) then
    if not reMail.Test(E_MAIL) then erroMsg("Campo de e-mail inv�lido, favor conferir os dados")
end if
C_E_MAIL=Replace(Request.Form("C_EMAIL"),"'","''")
if C_E_MAIL<>E_MAIL then erroMsg("Os campos de e-mail e confirma��o de e-mail est�o diferentes. Favor checar os dados.")

ENDERECO=Replace(Request.Form("ENDERECO"),"'","''")
if Len(ENDERECO)=0 then erroMsg("O endere�o deve ser preenchido")
CEP=checaInt(Request.Form("CEP"))
COD_UF_IBGE=checaInt(Request.Form("COD_UF_IBGE"))
COD_MUNI_IBGE=checaInt(Request.Form("COD_MUNI_IBGE"))
COD_PAIS=checaInt(Request.Form("COD_PAIS"))

TEL_DDI=checaInt(Request.Form("TEL_DDI"))
TEL_DDD=checaInt(Request.Form("TEL_DDD"))
TEL=Replace(Request.Form("TEL"),"'","''")

if FAX_DDI=0 then FAX_DDI="null"
if FAX_DDD=0 then FAX_DDD="null"
FAX=Replace(Request.Form("FAX"),"'","''")

COD_ESCOLARIDADE=checaInt(Request.Form("COD_ESCOLARIDADE"))
if COD_ESCOLARIDADE<5 then FORMACAO=""
if COD_ESCOLARIDADE=0 then COD_ESCOLARIDADE="null"
FORMACAO=Replace(Request.Form("FORMACAO"),"'","''")

COD_POS=checaInt(Request.Form("COD_POS"))
if COD_POS=0 then COD_POS="null"
POS=Replace(Request.Form("POS"),"'","''")
if COD_POS="null" then POS=""

if NACIONALIDADE="est" then
	if COD_PAIS=0 then erroMsg("O pa�s deve ser selecionado")
	if TEL_DDI=0 then erroMsg("O DDI do telefone deve ser preenchido")
	if Len(Trim(ID_TIPO))=0 then erroMsg("O tipo do documento de identidade deve ser preenchido")
	if Len(Trim(ID_NUM))=0 then erroMsg("O n�mero do documento de identidade deve ser preenchido")
	CEP="null"
	COD_UF_IBGE="null"
	COD_MUNI_IBGE="null"
else
	COD_PAIS=0
	if TEL_DDI=0 then TEL_DDI="null"
	ID_TIPO=""
	ID_NUM=""
	if CEP=0 then erroMsg("O CEP deve ser preenchido")
	if COD_UF_IBGE=0 then erroMsg("A UF deve ser preenchida")
	if COD_MUNI_IBGE=0 then erroMsg("O munic�pio deve ser preenchido")
end if

'	###	DADOS PROFISSIONAIS	###
SETOR=Replace(Request.Form("SETOR"),"'","''")

CARGO=Replace(Request.Form("CARGO"),"'","''")

EMAIL_ENTI=Replace(Request.Form("EMAIL_ENTI"),"'","''")
if Len(EMAIL_ENTI)>0 and not reMail.Test(E_MAIL) then erroMsg("Campo de e-mail profissional inv�lido, favor conferir os dados")
Set reMail = Nothing

ENDERECO_ENTI=Replace(Request.Form("ENDERECO_ENTI"),"'","''")

CEP_ENTI=checaInt(Request.Form("CEP_ENTI"))
' E_CEP = mid(CEP_ENTI,1,5)&"-"&mid(CEP_ENTI,6,3)
E_CEP   = CEP_ENTI
TEL_DDI_ENTI=checaInt(Request.Form("TEL_DDI_ENTI"))
TEL_DDD_ENTI=checaInt(Request.Form("TEL_DDD_ENTI"))
TEL_ENTI=Replace(Request.Form("TEL_ENTI"),"'","''")


NEWSLETTER=checaInt(Request.Form("NEWSLETTER"))
sql = "UPDATE ALUNO SET TEL_ENTI='"&TEL_ENTI&"',TEL_DDD_ENTI='"&TEL_DDD_ENTI&"',TEL_DDI_ENTI='"&TEL_DDI_ENTI&"',"             _
    & "ENDERECO_ENTI='"&ENDERECO_ENTI&"',EMAIL_ENTI='"&EMAIL_ENTI&"',CEP_ENTI='"&CEP_ENTI&"',NOME='"&Ucase(NOME)&"',"         _
    & "NEWSLETTER="&NEWSLETTER&",COD_PAIS="&COD_PAIS&",DT_NASCIMENTO="&DT_NASCIMENTO&",CPF='"&CPF&"',ID_TIPO='"&ID_TIPO&"',"  _
    & "ID_NUM='"&ID_NUM&"',SEXO="&SEXO&",COD_RACA="&COD_RACA&",EMAIL='"&E_MAIL&"',ENDERECO='"&Ucase(ENDERECO)&"',"            _
    & "CEP='"&CEP&"',COD_MUNI_IBGE="&COD_MUNI_IBGE&",COD_UF_IBGE="&COD_UF_IBGE&",TEL='"&TEL&"',TEL_DDI="&TEL_DDI&","          _
    & "TEL_DDD="&TEL_DDD&",FAX='"&FAX&"',FAX_DDI="&FAX_DDI&",FAX_DDD="&FAX_DDD&",COD_ESCOLARIDADE="&COD_ESCOLARIDADE&","      _
    & "FORMACAO='"&Ucase(FORMACAO)&"',COD_POS="&COD_POS&",POS='"&Ucase(POS)&"',TIPOENTI="&TIPOENTI&","                        _
    & "COD_UF_ENTI="&COD_UF_ENTI&",COD_MUNI_ENTI="&COD_MUNI_ENTI&",SETOR='"&SETOR&"',CARGO='"&CARGO&"',"                      _
    & "E_NOME='"&Ucase(E_NOME)&"',E_CNPJ='"&Ucase(E_CNPJ)&"',E_ENDERECO='"&Ucase(E_ENDERECO)&"',E_CEP='"&E_CEP&"',"           _
    & "E_EMAIL='"&E_EMAIL&"',E_WWW='"&E_WWW&"',E_TELEFONE='"&E_TELEFONE&"',E_FAX='"&E_FAX&"' WHERE COD_ALUNO="&coda
' response.write sql
' response.end

con.execute sql
'con.execute "INSERT INTO HISTOTICO_ALUNO (COD_ALUNO,EMAIL,ENDERECO,CEP,COD_MUNI_IBGE,COD_UF_IBGE,TEL_DDI,TEL_DDD,TEL,FAX_DDI,FAX_DDD,FAX,COD_ESCOLARIDADE,FORMACAO,COD_POS,POS,TIPOENTI,COD_UF_ENTI,COD_MUNI_ENTI,SETOR,CARGO,E_NOME,E_CNPJ,E_ENDERECO,E_CEP,E_EMAIL,E_WWW,E_TELEFONE,E_FAX) VALUES ("&session("id")&",'"&E_MAIL&"','"&Ucase(ENDERECO)&"','"&CEP&"',"&COD_MUNI_IBGE&","&COD_UF_IBGE&","&TEL_DDI&","&TEL_DDD&",'"&TEL&"','"&FAX&"',"&FAX_DDI&","&FAX_DDD&","&COD_ESCOLARIDADE&",'"&Ucase(FORMACAO)&"',"&COD_POS&",'"&Ucase(POS)&"',"&TIPOENTI&","&COD_UF_ENTI&","&COD_MUNI_ENTI&",'"&Ucase(SETOR)&"','"&Ucase(CARGO)&"','"&Ucase(E_NOME)&"','"&Ucase(E_CNPJ)&"','"&Ucase(E_ENDERECO)&"','"&E_CEP&"','"&E_EMAIL&"','"&E_WWW&"','"&E_TELEFONE&"','"&E_FAX&"')"

%>
    <script language=javascript>
        alert('Os dados do aluno foram atualizados com sucesso.');
        location.href='altera_aluno02.asp?coda=<%=coda%>&operacao=carregar';
    </script>

<!-- #include file="inc/template_baixo.asp" -->
<%conClose%>