<!-- #INCLUDE FILE="../library/parametros.asp" -->
<!-- #INCLUDE FILE="../library/conOpen.asp" -->
<!-- #INCLUDE FILE="../library/fAddZero.asp" -->
<!-- #INCLUDE FILE="../library/fErroMsg.asp" -->
<!-- #INCLUDE FILE="../library/fData.asp" -->
<!-- #INCLUDE FILE="../library/fFormataData.asp" -->
<!-- #INCLUDE FILE="../library/vHoje.asp" -->
<!-- #INCLUDE FILE="../library/fEmail.asp" -->
<!-- #INCLUDE FILE="../library/fFormataCPF.asp" -->

<%
COD_CURSO = request("COD_CURSO")
data=year(date())&right("0"&month(date()),2)&right("0"&day(date()),2)
hora=FormatDateTime(now(),vbshorttime)
x=split(hora,":")
hora=right("0"&x(0),2)&right("0"&x(1),2)


if COD_CURSO > 0 then
else
	COD_CURSO=0
end if
sql = "INSERT INTO REQUERIMENTO (COD_ALUNO,DATA,COD_CURSO,JUSTIFICATIVA,TIPO_REQUERIMENTO,STATUS,HORA) VALUES ('"&SESSION("ID")&"','"&data&"','"&REQUEST("COD_CURSO")&"','"&REQUEST("JUSTIFICATIVA")&"','"&request("opcao")&"','Pendente','"&hora&"')"
con.execute sql

sql = "SELECT A.NOME,A.CPF,A.TIPOENTI,I.DESCRICAO,A.SETOR,A.CARGO,A.DT_NASCIMENTO,A.ENDERECO FROM ALUNO A LEFT JOIN WEBSIMSQL.DBO.TIPO_ENTIDADE I ON A.TIPOENTI=I.ID_TIPO_ENTIDADE WHERE COD_ALUNO="&session("id")
RS.open sql

TEXTO = "Eu, "&RS("NOME")&", CPF: "&formatacpf(RS("CPF"))&", (cargo/função) "&RS("CARGO")&" na Instituição "&RS("DESCRICAO")&", nascido em "&FORMATADATA(RS("DT_NASCIMENTO"))&", endereço "&RS("ENDERECO")&", venho, pelo presente, solicitar bolsa (parcial / integral) no curso "
RS.Close
if int(request("COD_CURSO")) > 0 then
	sql = "SELECT * FROM CURSO WHERE COD_CURSO='"&REQUEST("COD_CURSO")&"'"
	RS.open sql
	TEXTO = TEXTO & RS("TITULO") & CHR(10)&CHR(10)
	TEXTO = TEXTO & "JUSTIFICATIVA" & CHR(10)&CHR(10)
	RS.Close
end if

TEXTO = TEXTO & REQUEST("JUSTIFICATIVA") & CHR(10)&CHR(10)
TEXTO = TEXTO & "data " & day(date())&"/"&right("00"&month(date()),2)&"/"&year(date()) & " - " & FormatDateTime(now(),vbshorttime)
sql = "SELECT * FROM TIPO_REQUERIMENTO WHERE TIPO_REQUERIMENTO='"&request("opcao")&"'"
RS.open sql
subject = RS("TIPO_REQUERIMENTO")
mailErr=email(E_MAIL,"coordenacao_ensur@ibam.org.br",TEXTO,subject)
mailErr=email(E_MAIL,"rh_professores@ibam.org.br",TEXTO,subject)
conClose

%>
<script language="javascript">
	alert('Seu requerimento foi enviado com sucesso.\n\nO prazo máximo de resposta será de 15 dias.\n\nObrigado \nENSUR');
	window.location = 'default.asp';
</script>
<%
Response.end

%>