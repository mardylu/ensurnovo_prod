<%response.Charset="ISO-8859-1"%>
<!-- #INCLUDE FILE="../library/conOpenSIM.asp" -->
<%
codEnti=0
tipoEnti=request("tipoEnti")
if tipoEnti="" or isNumeric(tipoEnti)=false then tipoEnti=0
tipoEnti=int(tipoEnti)
codUf=request("COD_UF_ENTI")
if codUf="" or isNumeric(codUf)=false then codUf=0
codUf=int(codUf)
codMuni=request("COD_MUNI_ENTI")
if codMuni="" or isNumeric(codMuni)=false then codMuni=0
codMuni=int(codMuni)

if tipoEnti<>16 and tipoEnti<>18 and codMuni=0 then
	conCloseSIM
	response.write "Favor selecionar o município"
	response.end
end if

if codMuni<>0 and tipoEnti=0 then
	conCloseSIM
	response.write "Favor selecionar o tipo de instituição"
	response.end
end if

'Em caso de prefeitura ou camara, selecionar automático
if (tipoEnti=1 or tipoEnti=2) and codMuni>0 and codUf>0 then
	RS.Open "SELECT COD_ENTI FROM ENTIDADES WHERE ID_TIPO_ENTIDADE="&tipoEnti&" AND COD_MUNI_IBGE="&codMuni&" AND COD_UF_IBGE="&codUf
	if not RS.EOF then codEnti = CInt(RS(0))
	RS.Close
end if

if codEnti>0 then
	conCloseSIM
	response.write "ok|"&codEnti&"|ok"
	response.end
end if

'Senão, procurar na base
if (tipoEnti=16 or tipoEnti=18) and codMuni=0 then
	msql = "SELECT COD_ENTI,NOME FROM ENTIDADES WHERE COD_UF_IBGE=null AND COD_MUNI_IBGE=null AND ID_TIPO_ENTIDADE="&tipoEnti
else 
	msql = "SELECT COD_ENTI,NOME FROM ENTIDADES WHERE COD_UF_IBGE="&codUf&" AND COD_MUNI_IBGE="&codMuni&" AND ID_TIPO_ENTIDADE="&tipoEnti
end if

str = ""
RS.Open msql
while not RS.EOF
	str = str & "|" & RS(0) & "|" & RS(1)
	RS.MoveNext
wend
RS.Close

response.write "ok"&str
conCloseSIM
%>