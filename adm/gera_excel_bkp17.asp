<%

If session("key_plc")<>"ok" and session("key_plp")<>"ok" Then Response.Redirect "logout.asp"

p=request("p")
if p<>"1" and session("key_plc")<>"ok" then Response.Redirect "logout.asp"

Server.ScriptTimeout = 900

Response.Buffer = true
Response.Expires = 0
Response.Clear
%>
<!-- #INCLUDE FILE="../library/parametros.asp" -->
<!-- #INCLUDE FILE="../library/conOpen.asp" -->
<!-- #INCLUDE FILE="../library/conOpenSIM.asp" -->
<!-- #INCLUDE FILE="../library/fErroMsg.asp" -->
<!-- #INCLUDE FILE="../library/fData.asp" -->
<!-- #INCLUDE FILE="../library/vFormaPgt.asp" -->
<%

function simnao(vlr,sexo)
	if vlr then
		if sexo then
			simnao = "Masc"
		else
			simnao = "Sim"
		end if
	else
		if sexo then
			simnao = "Fem"
		else
			simnao = "Não"
		end if
	end if
end function

msql = Request.Form("msql")
sel = request.Form("sel")


if len(sel)=0 then erroMsg("Selecionar ao menos um aluno")
msql = Replace(msql,"WHERE ","WHERE COD_ALUNO IN ("&sel&") AND ")

msql = "SELECT A.COD_DEFICIENCIA,A.EMAIL_ENTI,A.ENDERECO_ENTI,A.CEP_ENTI,A.TEL_DDI_ENTI,A.TEL_DDd_ENTI,A.TEL_ENTI,A.NOME,CPF AS CPF,ID_TIPO,ID_NUM,DT_NASCIMENTO AS DT_NASCIMENTO,SEXO,isNull(R.DESCRICAO,'') AS RACA,P.NOME AS PAIS,EMAIL,ENDERECO,CEP,isNull(COD_MUNI_IBGE,0) AS COD_MUNI_IBGE,isNull(COD_UF_IBGE,0) AS COD_UF_IBGE,TEL_DDI,TEL_DDD,TEL,FAX_DDI,FAX_DDD,FAX,E.DESCRICAO AS ESCOLARIDADE,FORMACAO,POS.DESCRICAO AS POS,POS AS POS_AREA,NEWSLETTER,isNull((SELECT SUM(VALOR) FROM PAGAMENTO WHERE COD_ALUNO=C.COD_ALUNO AND ID_TURMA=C.ID_TURMA),0) AS VALOR_PAGO,C.DT_CADASTRO,isNull((SELECT MAX(DT_PGT) FROM PAGAMENTO WHERE COD_ALUNO=C.COD_ALUNO AND COD_CURSO=C.COD_CURSO),'') AS DT_PGT,C.APROVADO,C.COD_ENTI,C.CARGO,C.SETOR,C.TEL_DDI_ENTI,C.TEL_DDD_ENTI,C.TEL_ENTI,C.EMAIL_ENTI,C.ENDERECO_ENTI,C.CEP_ENTI,C.FORMA_PGT FROM TURMA_ALUNO C JOIN ALUNO A ON C.COD_ALUNO=A.COD_ALUNO LEFT JOIN ESCOLARIDADE E ON A.COD_ESCOLARIDADE=E.COD_ESCOLARIDADE LEFT JOIN RACA R ON A.COD_RACA=R.COD_RACA JOIN PAIS P ON A.COD_PAIS=P.COD_PAIS LEFT JOIN POS ON A.COD_POS=POS.COD_POS WHERE C.COD_ALUNO IN ("&sel&") AND "&msql
Response.ContentType = "application/vnd.ms-excel"
Response.AddHeader "Content-Disposition","attachment;filename=planilha.xls" & fn

if p="1" then
	Response.Write "<TABLE><tr><td><b>Nome</b></td><td><b>Tipo Instituição</b></td><td><b>Instituição</b></td><td><b>Setor</b></td><td><b>Cargo</b></td><td><b>Endereco Inst.</b></td><td><b>UF Inst.</b></td><td><b>Município Inst.</b></td><td><b>CEP Inst.</b></td><td><b>Tel inst.</b></td><td><b>Email inst.</b></td><td><b>Endereço</b></td><td><b>Município</b></td><td><b>UF</b></td><td><b>CEP</b></td><td><b>Tel</b></td><td><b>Fax</b></td><td><b>E-mail</b></td><td><b>Escolaridade</b></td><td><b>Nome do curso</b></td><td><b>Sexo</b></td><td><b>Nascimento</b></td><td><b>Raça</b></td><td><b>CPF</b></td><td><b>País</b></td><td><b>Pós</b></td><td><b>Área da pós</b></td><td><b>Cod Deficiência</b></td></tr>"
else
	Response.Write "<TABLE><tr><td><b>Nome</b></td><td><b>Tipo Instituição</b></td><td><b>Instituição</b></td><td><b>Setor</b></td><td><b>Cargo</b></td><td><b>Endereco Inst.</b></td><td><b>UF Inst.</b></td><td><b>Município Inst.</b></td><td><b>CEP Inst.</b></td><td><b>Tel inst.</b></td><td><b>Email inst.</b></td><td><b>Endereço</b></td><td><b>Município</b></td><td><b>UF</b></td><td><b>CEP</b></td><td><b>Tel</b></td><td><b>Fax</b></td><td><b>E-mail</b></td><td><b>Escolaridade</b></td><td><b>Nome do curso</b></td><td><b>Sexo</b></td><td><b>Nascimento</b></td><td><b>Raça</b></td><td><b>CPF</b></td><td><b>País</b></td><td><b>Pós</b></td><td><b>Área da pós</b></td><td><b>Valor pago</b></td><td><b>Data cadastro</b></td><td><b>Data últ. pgt</b></td><td><b>Forma Pgt.</b></td><td><b>Aprovado</b></td><td><b>Cod Dediciência</b></td></tr>"
end if


RS.Open msql
WHILE NOT RS.EOF

	enti = ""
	muni = ""
	uf = ""

	if not isNull(RS("COD_ENTI")) then
		RSSIM.Open "SELECT E.ID_TIPO_ENTIDADE,NOME,isNull(SIGLA_UF,'') AS SIGLA_UF,isNull(NOME_MUNI,'') AS NOME_MUNI, T.DESCRICAO AS TIPO_INSTITUICAO FROM ENTIDADES E LEFT JOIN MUNICIPIOS M ON E.COD_MUNI_IBGE=M.COD_MUNI_IBGE AND E.COD_UF_IBGE=M.COD_UF_IBGE LEFT JOIN UF ON E.COD_UF_IBGE=UF.COD_UF_IBGE LEFT JOIN TIPO_ENTIDADE T ON T.ID_TIPO_ENTIDADE=E.ID_TIPO_ENTIDADE WHERE COD_ENTI="&RS("COD_ENTI")
		if NOT RSSIM.EOF then
			enti=RSSIM("NOME")
			if Len(RSSIM("SIGLA_UF"))>0 and Len(RSSIM("NOME_MUNI"))>0 then
				muni = RSSIM("NOME_MUNI")
				uf = RSSIM("SIGLA_UF")
//				enti = enti & " ("&muni&"/"&uf&")"
				desc = RSSIM("TIPO_INSTITUICAO")
			else
				muni = "Estrangeiro"
				uf = "Estrangeiro"
			end if
		end if
		RSSIM.Close
	end if
	if RS("COD_UF_IBGE")>0 and RS("COD_MUNI_IBGE")>0 then
		RSSIM.Open "SELECT SIGLA_UF,NOME_MUNI FROM MUNICIPIOS M JOIN UF ON M.COD_UF_IBGE=UF.COD_UF_IBGE WHERE M.COD_UF_IBGE="&RS("COD_UF_IBGE")&" AND M.COD_MUNI_IBGE="&RS("COD_MUNI_IBGE")
		if NOT RSSIM.EOF then
			ufresid=RSSIM(0)
			muniresid=RSSIM(1)
		end if
		RSSIM.Close
	end if
	CPF=mid(RS("CPF"),1,3)&"."&mid(RS("CPF"),4,3)&"."&mid(RS("CPF"),7,3)&"-"&mid(RS("CPF"),10,2)
    if ( RS("COD_DEFICIENCIA") = 0 ) then nome_deficiencia = "Não possuo deficiência"  end if
    if ( RS("COD_DEFICIENCIA") = 1 ) then nome_deficiencia = "Não possuo deficiência"  end if
    if ( RS("COD_DEFICIENCIA") = 2 ) then nome_deficiencia = "Deficiência auditiva"  end if
    if ( RS("COD_DEFICIENCIA") = 3 ) then nome_deficiencia = "Deficiência motora e/ou mobilidade reduzida"  end if
    if ( RS("COD_DEFICIENCIA") = 4 ) then nome_deficiencia = "Deficiência visual"  end if
    if ( RS("COD_DEFICIENCIA") = 5 ) then nome_deficiencia = "Deficiência intelectual"  end if
    if ( RS("COD_DEFICIENCIA") = 6 ) then nome_deficiencia = "Deficiência múltipla (pessoa com mais de um tipo de deficiência)"  end if
    if ( RS("COD_DEFICIENCIA") = 7 ) then nome_deficiencia = "Outra deficiência"  end if

	if p="1" then
		Response.Write "<tr><td>"&RS("NOME")&"</td><td>"&desc&"</td><td>"&enti&"</td><td>"&RS("SETOR")&"</td><td>"&RS("CARGO")&"</td><td>"&RS("ENDERECO_ENTI")&"</td><td>"&uf&"</td><td>"&muni&"</td><td>"&RS("CEP_ENTI")&"</td><td>("&RS("TEL_DDI_ENTI")&"-"&RS("TEL_DDD_ENTI")&") "&RS("TEL_ENTI")&"</td><td>"&RS("EMAIL_ENTI")&"</td><td>"&RS("ENDERECO")&"</td><td>"&muniresid&"</td><td>"&ufresid&"</td><td>"&RS("CEP")&"</td><td>("&RS("TEL_DDI")&"-"&RS("TEL_DDD")&") "&RS("TEL")&"</td><td>("&RS("FAX_DDI")&"-"&RS("FAX_DDD")&") "&RS("FAX")&"</td><td>"&RS("EMAIL")&"</td><td>"&RS("ESCOLARIDADE")&"</td><td>"&RS("FORMACAO")&"</td><td>"&simnao(RS("SEXO"),true)&"</td><td> "&formataData(RS("DT_NASCIMENTO"))&"</td><td>"&RS("RACA")&"</td><td> "&CPF&"</td><td>"&RS("PAIS")&"</td><td>"&RS("POS")&"</td><td>"&RS("POS_AREA")&"</td><td>"&nome_deficiencia&"</td></tr>"
	else
		Response.Write "<tr><td>"&RS("NOME")&"</td><td>"&desc&"</td><td>"&enti&"</td><td>"&RS("SETOR")&"</td><td>"&RS("CARGO")&"</td><td>"&RS("ENDERECO_ENTI")&"</td><td>"&uf&"</td><td>"&muni&"</td><td>"&RS("CEP_ENTI")&"</td><td>("&RS("TEL_DDI_ENTI")&"-"&RS("TEL_DDD_ENTI")&") "&RS("TEL_ENTI")&"</td><td>"&RS("EMAIL_ENTI")&"</td><td>"&RS("ENDERECO")&"</td><td>"&muniresid&"</td><td>"&ufresid&"</td><td>"&RS("CEP")&"</td><td>("&RS("TEL_DDI")&"-"&RS("TEL_DDD")&") "&RS("TEL")&"</td><td>("&RS("FAX_DDI")&"-"&RS("FAX_DDD")&") "&RS("FAX")&"</td><td>"&RS("EMAIL")&"</td><td>"&RS("ESCOLARIDADE")&"</td><td>"&RS("FORMACAO")&"</td><td>"&simnao(RS("SEXO"),true)&"</td><td> "&formataData(RS("DT_NASCIMENTO"))&"</td><td>"&RS("RACA")&"</td><td> "&CPF&"</td><td>"&RS("PAIS")&"</td><td>"&RS("POS")&"</td><td>"&RS("POS_AREA")&"</td><td>"&RS("VALOR_PAGO")&"</td><td> "&formataData(RS("DT_CADASTRO"))&"</td><td> "&formataData(RS("DT_PGT"))&"</td><td> "&aFormaPgt(RS("FORMA_PGT"))&"</td><td>"&simnao(RS("APROVADO"),0)&"</td><td>"&nome_deficiencia&"</td></tr>"
	end if
	RS.MoveNext
wend
RS.Close
conClose
conCloseSIM
Response.Write "</TABLE>"
Server.ScriptTimeout = 90
%>