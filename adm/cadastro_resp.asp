<!-- #INCLUDE FILE="library/parametros.asp" -->
<!-- #include file="inc/settings.asp" -->
<!-- #INCLUDE FILE="library/conOpen.asp" -->
<!-- #INCLUDE FILE="library/conOpenSIM.asp" -->
<!-- #INCLUDE FILE="library/fErroMsg.asp" -->
<!-- #INCLUDE FILE="library/fAddZero.asp" -->
<!-- #INCLUDE FILE="library/fFormataValor.asp" -->
<!-- #INCLUDE FILE="library/fData.asp" -->
<!-- #INCLUDE FILE="library/fChecaCPF_CNPJ.asp" -->
<!-- #INCLUDE FILE="library/vHoje.asp" -->

<%
function checaInt(qual)
	if qual="" or isNumeric(qual)=false then qual=0
	checaInt = int(qual)
end function
%>
<%
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
%>
<%
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

sql="SELECT t.VALOR,c.TITULO,c.SENHA,t.PARCELAS,T.COD_CURSO FROM TURMAS t join curso c on t.cod_curso=c.cod_curso WHERE t.COD_STATUS_TURMA=2 AND ID_TURMA="&cod

RS.Open sql
if RS.EOF then
	erroMsg("Curso não encontrado. Faça um refresh no seu navegador e tente novamente.")
else
	COD_CURSO=RS("COD_CURSO")
	VALOR=RS(0)
	TITULO=RS(1)
	SENHA=RS(2)
	PARCELAS=RS(3)
end if
RS.Close

if Len(SENHA)>0 and not isNull(SENHA) and Session("pwd"&cod)<>"ok" then erroMsg("O curso precisa ser validado com senha")

PARCELAS_ALUNO=0
if VALOR>0 then
	CUSTO_ENTI=Request.Form("CUSTO_ENTI")
	if CUSTO_ENTI<>"0" and CUSTO_ENTI<>"1" then erroMsg("Favor selecionar o responsável pelo pagamento")
	CUSTO_ENTI=int(CUSTO_ENTI)
	if CUSTO_ENTI=1 then
		entiObrigatorio = true
	else
		entiObrigatorio = false
	end if
	if PARCELAS=1 then PARCELAS_ALUNO=1
else
	entiObrigatorio = false
	CUSTO_ENTI=0
end if

tipoEnti=request("tipoEnti")
COD_UF_ENTI=request("COD_UF_ENTI")
COD_MUNI_ENTI=request("COD_MUNI_ENTI")
'est=request("est")
SETOR=request("SETOR")
CARGO=request("CARGO")
FORMA_PAGAMENTO=request("FORMA_PAGAMENTO")


if tipoEnti=0 then erroMsg("Favor selecionar o tipo de instituição")
if COD_UF_ENTI=0 then erroMsg("Favor selecionar a unidade da federação da instituição")
if COD_MUNI_ENTI=0 then erroMsg("Favor selecionar o municipio da instituição")
'if est="" then erroMsg("Favor selecionar o tipo de instituição")
if SETOR="" then erroMsg("Favor digitar o seu setor na instituição")
if CARGO="" then erroMsg("Favor digitar o seu cargo de instituição")
if FORMA_PAGAMENTO=0 then erroMsg("Favor selecionar uma forma de pagamento")


CPF=checaInt(Request.Form("CPF"))
NACIONALIDADE=Replace(Request.Form("NACIONALIDADE"),"'","''")
if NACIONALIDADE<>"brasil" and NACIONALIDADE<>"est" then erroMsg("Favor selecionar a nacionalidade")
if NACIONALIDADE="est" then CPF=0

if NACIONALIDADE="brasil" and CPF=0 then erroMsg("Favor indicar seu CPF")

if CPF<>0 then
	checaCPF_CNPJ CPF,1
	CPF=addZero(CPF,11)
end if

if session("pass")="ok" then
	'checa se já se cadastrou neste curso
	RS.Open "SELECT ID_INSCRICAO FROM TURMA_ALUNO WHERE COD_ALUNO="&session("id")&" AND ID_TURMA="&cod
	if not RS.eof then
		ID_INSCRICAO = RS("ID_INSCRICAO")
		estaNoCurso=true
	else
		estaNoCurso=false
	end if
	RS.Close
	'checa se mudou cpf e se o novo já existe na base
	RS.Open "SELECT CPF FROM ALUNO WHERE COD_ALUNO="&session("id")
	if RS.EOF then
		erroMsg("Cadastro não encontrado. Favor fazer novo login.")
	else
		CPF_BASE = RS(0)
		codAluno = session("id")
	end if
	RS.Close
	if Len(CPF)=11 and int(CPF_BASE)<>int(CPF) then
		RS.Open "SELECT COUNT(*) FROM ALUNO WHERE CPF='"&CPF&"'"
		if RS(0)>0 then erroMsg("Esse cpf já está cadastrado na base. Favor voltar à página de inscrição, entrar com seu CPF no primeiro campo do formulário e clicar em 'recuperar meus dados'.")
		RS.Close
	end if
else
	estaNoCurso=false
	'checa se o cpf já está cadastrado na base
	RS.Open "SELECT COUNT(*) FROM ALUNO WHERE CPF='"&CPF&"'"
	if RS(0)>0 then erroMsg("Esse cpf já está cadastrado na base. Favor voltar à página de inscrição, entrar com seu CPF no primeiro campo do formulário e clicar em 'recuperar meus dados'.")
	RS.Close
end if


'	###	DADOS DA ENTIDADE	###

if codEnti>0 then
	RSSIM.Open "SELECT COUNT(*) FROM ENTIDADES WHERE COD_ENTI="&codEnti
		if RSSIM(0)=0 then erroMsg("Instituição não encontrada, favor reiniciar o processo de cadastro")
	RSSIM.Close
	entiJaExiste=true
else
	entiJaExiste=false
	
	tipoEnti=checaInt(Request.Form("tipoEnti")) 
	RSSIM.Open "SELECT COUNT(*) FROM TIPO_ENTIDADE WHERE ID_TIPO_ENTIDADE="&tipoEnti
	if RSSIM(0)=0 then
		if entiObrigatorio then erroMsg("O preenchimento dos campos da instituição são obrigatórios quando o pagamento é de responsabilidade dela")
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
			if entiObrigatorio or tipoEnti>0 then erroMsg("Favor selecionar o município da instituição")
		end if
		RSSIM.Close
	end if
	
	ADMIND_AREAS=checaInt(Request.Form("ADMIND_AREAS"))
	ADMIND_NATJUR=checaInt(Request.Form("ADMIND_NATJUR"))
	if tipoEnti=3 then
		if ADMIND_AREAS=0 or ADMIND_NATJUR=0 then erroMsg("Preencher todos os campos obrigatórios da instituição")
		RSSIM.Open "SELECT COUNT(*) FROM ADMIND_AREAS WHERE ID="&ADMIND_AREAS
		if RSSIM(0)=0 then erroMsg("Preencher todos os campos obrigatórios da instituição")
		RSSIM.Close
		RSSIM.Open "SELECT COUNT(*) FROM ADMIND_NATJUR WHERE ID="&ADMIND_NATJUR
		if RSSIM(0)=0 then erroMsg("Preencher todos os campos obrigatórios da instituição")
		RSSIM.Close
	end if
	if ADMIND_AREAS=0 then ADMIND_AREAS="null"
	if ADMIND_NATJUR=0 then ADMIND_NATJUR="null"

	SUBTIPO_ENTIDADE=checaInt(Request.Form("SUBTIPO_ENTIDADE")) 
	if tipoEnti=4 then
		if SUBTIPO_ENTIDADE=0 then erroMsg("Preencher todos os campos obrigatórios da instituição")
		RSSIM.Open "SELECT COUNT(*) FROM SUBTIPO_ENTIDADE WHERE ID_SUBTIPO_ENTIDADE="&SUBTIPO_ENTIDADE
		if RSSIM(0)=0 then erroMsg("Preencher todos os campos obrigatórios da instituição")
		RSSIM.Close
	end if
	if SUBTIPO_ENTIDADE=0 then SUBTIPO_ENTIDADE="null"
	
	E_NOME=Replace(Request.Form("E_NOME"),"'","''")
	if Len(E_NOME)=0 and tipoEnti>0 then erroMsg("O nome da instituição deve ser preenchido")
	E_CNPJ=Replace(Request.Form("E_CNPJ"),"'","''")
	E_ENDERECO=Replace(Request.Form("E_ENDERECO"),"'","''")
	E_CEP=checaInt(Request.Form("E_CEP")) 
	if E_CEP=0 then E_CEP="null"
	E_EMAIL=Replace(Request.Form("E_EMAIL"),"'","''")
	E_WWW=Replace(Request.Form("E_WWW"),"'","''")
	E_TELEFONE=checaInt(Request.Form("E_TELEFONE"))
	if E_TELEFONE=0 and tipoEnti>0 then erroMsg("O telefone da instituição deve ser preenchido")
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
if COD_RACA=0 then COD_RACA="null"

'checagem de e-mail
EMAIL=Replace(Request.Form("EMAIL"),"'","''")
Set reMail = New RegExp
reMail.Pattern = "^[\w-\.]{1,}\@([\da-zA-Z-]{1,}\.){1,}[\da-zA-Z-]{2,3}$"
if not reMail.Test(EMAIL) then erroMsg("Campo de e-mail inválido, favor conferir os dados")
C_EMAIL=Replace(Request.Form("C_EMAIL"),"'","''")
if C_EMAIL<>EMAIL then erroMsg("Os campos de e-mail e confirmação de e-mail estão diferentes. Favor checar os dados.")

ENDERECO=Replace(Request.Form("ENDERECO"),"'","''")
if Len(ENDERECO)=0 then erroMsg("O endereço deve ser preenchido")
CEP=checaInt(Request.Form("CEP"))
COD_UF_IBGE=checaInt(Request.Form("COD_UF_IBGE"))
COD_MUNI_IBGE=checaInt(Request.Form("COD_MUNI_IBGE"))
COD_PAIS=checaInt(Request.Form("COD_PAIS"))

TEL_DDI=checaInt(Request.Form("TEL_DDI"))
TEL_DDD=checaInt(Request.Form("TEL_DDD"))
if TEL_DDD=0 then erroMsg("O DDD do telefone deve ser preenchido")
TEL=Replace(Request.Form("TEL"),"'","''")
if Len(TEL)=0 then erroMsg("O telefone deve ser preenchido")

FAX_DDI=checaInt(Request.Form("FAX_DDI"))
if FAX_DDI=0 then FAX_DDI="null"
FAX_DDD=checaInt(Request.Form("FAX_DDD"))
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
	if COD_PAIS=0 then erroMsg("O país deve ser selecionado")
	if TEL_DDI=0 then erroMsg("O DDI do telefone deve ser preenchido")
	if Len(Trim(ID_TIPO))=0 then erroMsg("O tipo do documento de identidade deve ser preenchido")
	if Len(Trim(ID_NUM))=0 then erroMsg("O número do documento de identidade deve ser preenchido")
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
	if COD_MUNI_IBGE=0 then erroMsg("O município deve ser preenchido")
end if

'	###	DADOS PROFISSIONAIS	###
SETOR=Replace(Request.Form("SETOR"),"'","''")

CARGO=Replace(Request.Form("CARGO"),"'","''")

EMAIL_ENTI=Replace(Request.Form("EMAIL_ENTI"),"'","''")
if Len(EMAIL_ENTI)>0 and not reMail.Test(EMAIL) then erroMsg("Campo de e-mail profissional inválido, favor conferir os dados")
Set reMail = Nothing

ENDERECO_ENTI=Replace(Request.Form("ENDERECO_ENTI"),"'","''")

CEP_ENTI=checaInt(Request.Form("CEP_ENTI"))

TEL_DDI_ENTI=checaInt(Request.Form("TEL_DDI_ENTI"))
TEL_DDD_ENTI=checaInt(Request.Form("TEL_DDD_ENTI"))
TEL_ENTI=Replace(Request.Form("TEL_ENTI"),"'","''")


NEWSLETTER=checaInt(Request.Form("NEWSLETTER"))

'if not entiJaExiste and tipoEnti>0 then
'	conSIM.execute "INSERT INTO ENTIDADES (COD_UF_IBGE,COD_MUNI_IBGE,ID_TIPO_ENTIDADE,ID_SUBTIPO_ENTIDADE,NOME,ENDERECO,CEP,EMAIL,WWW,TEL1,TEL1NUM,TEL1RM,TEL2,TEL2NUM,TEL2RM,TEL3,TEL3NUM,TEL3RM,DATA_ATUALIZACAO,ADMIND_NATJUR,ADMIND_AREA,EMPPRIV_RECEITA,EMPPRIV_CNPJ) VALUES ("&COD_UF_ENTI&","&COD_MUNI_ENTI&","&tipoEnti&","&SUBTIPO_ENTIDADE&",'"&E_NOME&"','"&E_ENDERECO&"','"&E_CEP&"','"&E_EMAIL&"','"&E_WWW&"',1,"&E_TELEFONE&","&E_TELRM&",2,"&E_FAX&","&E_FAXRM&",1,null,null,"&hoje&","&ADMIND_NATJUR&","&ADMIND_AREAS&",0,'"&E_CNPJ&"')"
'	RSSIM.Open "SELECT MAX(COD_ENTI) FROM ENTIDADES WHERE ID_TIPO_ENTIDADE="&tipoEnti&" AND NOME='"&E_NOME&"' AND DATA_ATUALIZACAO="&hoje
'	codEnti=Int(RSSIM(0))
'	RSSIM.Close
'end if

ASSOCIADO=0
if codEnti>0 then
	RSSIM.Open "SELECT VALIDADE FROM PAGAMENTOS WHERE COD_ENTI="&codEnti&" AND IBAMGOV=0 AND TELEIBAM=0 ORDER BY VALIDADE DESC"
	if not RSSIM.EOF then
		validade = RSSIM("VALIDADE")
	else
		validade = 0
	end if
	if validade>=hoje then ASSOCIADO=1
end if

if session("pass")="ok" then
	con.execute "UPDATE ALUNO SET NOME='"&Ucase(NOME)&"',NEWSLETTER="&NEWSLETTER&",COD_PAIS="&COD_PAIS&",DT_NASCIMENTO="&DT_NASCIMENTO&",CPF='"&CPF&"',ID_TIPO='"&ID_TIPO&"',ID_NUM='"&ID_NUM&"',SEXO="&SEXO&",COD_RACA="&COD_RACA&",EMAIL='"&EMAIL&"',ENDERECO='"&Ucase(ENDERECO)&"',CEP='"&CEP&"',COD_MUNI_IBGE="&COD_MUNI_IBGE&",COD_UF_IBGE="&COD_UF_IBGE&",TEL='"&TEL&"',TEL_DDI="&TEL_DDI&",TEL_DDD="&TEL_DDD&",FAX='"&FAX&"',FAX_DDI="&FAX_DDI&",FAX_DDD="&FAX_DDD&",COD_ESCOLARIDADE="&COD_ESCOLARIDADE&",FORMACAO='"&Ucase(FORMACAO)&"',COD_POS="&COD_POS&",POS='"&Ucase(POS)&"' WHERE COD_ALUNO="&session("id")
else
	con.execute "INSERT INTO ALUNO (NOME,COD_PAIS,CPF,ID_TIPO,ID_NUM,DT_NASCIMENTO,SEXO,COD_RACA,EMAIL,ENDERECO,CEP,COD_MUNI_IBGE,COD_UF_IBGE,TEL,TEL_DDI,TEL_DDD,FAX,FAX_DDI,FAX_DDD,COD_ESCOLARIDADE,FORMACAO,COD_POS,POS) VALUES ('"&Ucase(NOME)&"','"&COD_PAIS&"','"&cpf&"','"&ID_TIPO&"','"&ID_NUM&"',"&DT_NASCIMENTO&","&SEXO&","&COD_RACA&",'"&EMAIL&"','"&Ucase(ENDERECO)&"','"&CEP&"',"&COD_MUNI_IBGE&","&COD_UF_IBGE&",'"&TEL&"',"&TEL_DDI&","&TEL_DDD&",'"&FAX&"',"&FAX_DDI&","&FAX_DDD&","&COD_ESCOLARIDADE&",'"&Ucase(FORMACAO)&"',"&COD_POS&",'"&Ucase(POS)&"')"
	RS.Open "SELECT Max(COD_ALUNO) FROM ALUNO WHERE CPF='"&CPF&"'"
	codAluno=RS(0)
	RS.Close
	'loga automático
	'Session("pass")="ok"
	'Session("id")=codAluno
end if
if estaNoCurso then
	hojed=mid(hoje,1,4)&"-"&mid(hoje,5,2)&"-"&mid(hoje,7,2)
	sql = "UPDATE TURMA_ALUNO SET COD_ENTI="&codEnti&",ASSOCIADO="&ASSOCIADO&",CUSTO_ENTI="&CUSTO_ENTI&",SETOR='"&Ucase(SETOR)&"',CARGO='"&Ucase(CARGO)&"',EMAIL_ENTI='"&EMAIL_ENTI&"',ENDERECO_ENTI='"&Ucase(ENDERECO_ENTI)&"',CEP_ENTI='"&CEP_ENTI&"',TEL_DDI_ENTI="&TEL_DDI_ENTI&",TEL_DDD_ENTI="&TEL_DDD_ENTI&",TEL_ENTI='"&TEL_ENTI&"',DT_CADASTRO='"&hojed&"',FORMA_PGT="&FORMA_PAGAMENTO&" WHERE ID_INSCRICAO="&ID_INSCRICAO
	con.execute sql
else
	hoje=cstr(hoje)
	dia=mid(hoje,7,2)
	mes=mid(hoje,5,2)
	ano=mid(hoje,1,4)
	
	hoje = cdate(ano&"-"&mes&"-"&dia)
'	response.write hoje

	sql = "INSERT INTO TURMA_ALUNO (ID_TURMA,COD_CURSO,COD_ALUNO,DT_CADASTRO,APROVADO,COD_ENTI,ASSOCIADO,CUSTO_ENTI,SETOR,CARGO,EMAIL_ENTI,ENDERECO_ENTI,CEP_ENTI,TEL_DDI_ENTI,TEL_DDD_ENTI,TEL_ENTI,PARCELAS) VALUES ("&cod&","&COD_CURSO&","&codAluno&",'"&hoje&"',0,"&codEnti&","&ASSOCIADO&","&CUSTO_ENTI&",'"&Ucase(SETOR)&"','"&Ucase(CARGO)&"','"&EMAIL_ENTI&"','"&Ucase(ENDERECO_ENTI)&"','"&CEP_ENTI&"',"&TEL_DDI_ENTI&","&TEL_DDD_ENTI&",'"&TEL_ENTI&"',"&PARCELAS_ALUNO&")"
'	response.write sql
'	response.end
	con.execute sql
end if

'limpa a senha
Session("pwd"&cod)=""

%>
<!-- #include file="inc/template_topo.asp" -->

<script language="javascript">
	//Limpa os cookies para o problema do IE
	document.cookie ='muniEnti=<0; expires=Wed, 2 Aug 2000 20:47:11 UTC; path=/';
	document.cookie ='muniPess=<0; expires=Wed, 2 Aug 2000 20:47:11 UTC; path=/';	
</script>

<h1>Formulário de Inscrição</h1>
<p>Prezado(a) Sr(a). <%=NOME%></p>
<p><br /></p>
<p>Sua inscrição para o curso "<strong><%=TITULO%></strong>" foi efetuada com sucesso. O IBAM entrará em contato para confirmar sua participação.<br /></p>
<p>Mais informações envie mensagem para a ENSUR pelo e-mail <a href="mailto:webensur@ibam.org.br">webensur@ibam.org.br</a><br /></p>
<p><br /></p>
<%if PARCELAS>0 then
	if request("FORMA_PAGAMENTO") = 1 then
		response.redirect "boleto.asp?cod="&cod&"&parc="&PARCELAS
	end if%>
	<p class="laranja"><a href="area_pessoal.asp" class="laranja">Clique aqui para entrar em sua área pessoal e gerar o boleto de pagamento. Você pode também utilizar o link "Minhas inscrições" no topo dessa página para gerar segunda via de boleto, acompanhar o status de seus pagamentos ou enviar documento de empenho.</a><br /></p>
	<p><br /></p>
<%end if%>
<p>Cordialmente,<br />IBAM - Instituto Brasileiro de Administração Municipal</p>

<!-- #include file="inc/template_baixo.asp" -->
<%conClose%>