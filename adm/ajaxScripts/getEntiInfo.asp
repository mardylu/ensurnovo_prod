


<%
codEnti=request("codEnti")
if codEnti="" or isNumeric(codEnti)=false then codEnti=0
codEnti=int(codEnti)

if codEnti=0 then
	conClose
	response.write "Favor selecionar a entidade"
	response.end
end if

RS.Open "SELECT NOME,isNull(SIGLA_UF,'') AS SIGLA_UF,isNull(NOME_MUNI,'') AS NOME_MUNI,ENDERECO,CEP,EMAIL,WWW,TEL1,TEL1NUM,TEL2,TEL2NUM,TEL3,TEL3NUM,EMPPRIV_CNPJ FROM ENTIDADES E LEFT JOIN MUNICIPIOS M ON E.COD_MUNI_IBGE=M.COD_MUNI_IBGE AND E.COD_UF_IBGE=M.COD_UF_IBGE LEFT JOIN UF ON E.COD_UF_IBGE=UF.COD_UF_IBGE WHERE COD_ENTI="&codEnti
if RS.EOF then
	conClose
	response.write "Favor selecionar a entidade"
	response.end
else
	str=""
	telArray=Array("","Tel:","Fax:","Tel/Fax:","Cel:")
	FUNCTION formataCep(wData) '####Formata os Cep para NNNNN-NNN####
		IF wData<>"" and not isNull(wData) AND wData<>"null" AND isNumeric(wData) AND Len(wData)<9 THEN
			IF Len(wData)<8 THEN
				zeros=String(8-Len(wData),"0")
				wData=zeros&wData
			END IF
			wData=MID(wData,1,5)&"-"&MID(wData,6)
		ELSE
			wData = ""
		END IF
		formataCep=wData
	END FUNCTION
	FUNCTION formataTel(wTel) '####Formata os numeros de telefone####
		IF Len(wTel)=10 THEN
			telnum="("&MID(wTel,1,2)&") "&MID(wTel,3,4)&"-"&MID(wTel,7)
		ELSEIF Len(wTel)>7 AND Len(wTel)<10 THEN
			telnum="("&MID(wTel,1,2)&") "&MID(wTel,3,3)&"-"&MID(wTel,6)
		ELSE
			telnum=wTel
		END IF
		formataTel=telnum
	END FUNCTION
	str = str & "<p><label for=""NOME_ENTI"">Nome</label>"&RS("NOME")&"&nbsp;("
	if Len(RS("SIGLA_UF"))>0 and Len(RS("NOME_MUNI"))>0 then
		str = str & RS("NOME_MUNI")&"/"&RS("SIGLA_UF")
	else
	str = str & "Estrangeiro"
	end if
	str = str & ")</p>"
	str = str & "<p><label for=""NOME_ENTI"">Endereço</label>"&RS("ENDERECO")&"&nbsp;</p>"
	str = str & "<p><label for=""NOME_ENTI"">CEP</label>"&formataCep(RS("CEP"))&"&nbsp;</p>"
	if len(RS("EMAIL"))>0 then
		str = str & "<p><label for=""NOME_ENTI"">E-mail</label>"&RS("EMAIL")&"</p>"
	end if
	if len(RS("WWW"))>0 then
		str = str & "<p><label for=""NOME_ENTI"">WWW</label>"&RS("WWW")&"</p>"
	end if
	if len(RS("TEL1NUM"))>1 then
		str = str & "<p><label for=""NOME_ENTI"">"&telArray(RS("TEL1"))&"</label>"&formataTel(RS("TEL1NUM"))&"</p>"
	end if
	if len(RS("TEL2NUM"))>1 then
		str = str & "<p><label for=""NOME_ENTI"">"&telArray(RS("TEL2"))&"</label>"&formataTel(RS("TEL2NUM"))&"</p>"
	end if
	if len(RS("TEL3NUM"))>1 then
		str = str & "<p><label for=""NOME_ENTI"">"&telArray(RS("TEL3"))&"</label>"&formataTel(RS("TEL3NUM"))&"</p>"
	end if
	if len(RS("EMPPRIV_CNPJ"))>0 then
		str = str & "<p><label for=""NOME_ENTI"">CNPJ</label>"&RS("EMPPRIV_CNPJ")&"</p>"
	end if
	str = str & "<p><label for=""PESSOAL"">&nbsp;</label><a href=""mailto:webensur@ibam.org.br"">Favor entrar em contato com o IBAM caso os dados estejam incorretos</a></p>"
end if
RS.Close

response.write "ok"&str
conClose
%>