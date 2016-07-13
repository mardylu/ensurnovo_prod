<%
FUNCTION formataValor(wData) '####Formata valor para N.NNN,NN####
	wData = Trim(CStr(" "&wData))
	IF wData<>"" AND LEN(wData)>2 THEN
		If wData < 0 Then
			wNeg = True
			wData = Replace(wData,"-","")
		End if
		qValor=MID(wData,1,Len(wData)-2)
		cent=MID(wData,Len(wData)-1)
		tamValor=Len(qValor)
		IF qValor<>"" THEN
			fator=FIX((tamValor-1)/3)
			IF fator > 0 THEN
				base=tamValor-(fator*3)
				tempValor=MID(qValor,1,base)
				FOR i = 0 TO fator-1
					tempValor=tempValor&"."&MID(qValor,base+(1+(i*3)),3)
				NEXT
				qValor=tempValor
			END IF
			wData=qValor&","&cent
		END IF
	ELSEIF LEN(wData)=2 THEN
		wData="0,"&wData
	ELSEIF LEN(wData)=1 THEN
		wData="0,0"&wData
	ELSE
		wData=""
	END If
	If wNeg Then
		wData = "-"&wData
	End if
	if wData = "" then wData = "0,00"
	formataValor=wData
END FUNCTION

FUNCTION formataValorSemCent(wData) '####Formata valor para N.NNN,NN####
	wData = Trim(CStr(" "&wData))
	IF wData<>"" AND LEN(wData)>0 THEN
		If wData < 0 Then
			wNeg = True
			wData = Replace(wData,"-","")
		End if
		qValor=wData
		tamValor=Len(qValor)
		IF qValor<>"" THEN
			fator=FIX((tamValor-1)/3)
			IF fator > 0 THEN
				base=tamValor-(fator*3)
				tempValor=MID(qValor,1,base)
				FOR i = 0 TO fator-1
					tempValor=tempValor&"."&MID(qValor,base+(1+(i*3)),3)
				NEXT
				qValor=tempValor
			END IF
			wData=qValor
		END IF
	ELSE
		wData=""
	END If
	If wNeg Then
		wData = "-"&wData
	End if
	if wData = "" then wData = "0"
	formataValorSemCent=wData
END FUNCTION

FUNCTION formataValorUS(wData) '####Formata valor para NNN.NN####
	IF wData<>"" AND LEN(wData)>2 THEN
		wData=MID(wData,1,Len(wData)-2)&"."&MID(wData,Len(wData)-1)
	ELSEIF LEN(wData)=2 THEN
		wData="0."&wData
	ELSEIF LEN(wData)=1 THEN
		wData="0.0"&wData
	ELSEIF LEN(wData)=0 THEN
		wData="0.00"
	END IF
	formataValorUS=wData
END FUNCTION

FUNCTION formataValorSist(wData) '####Formata valor para N.NNN,NN####
	neg=false
	if len(wData)>1 then
		if mid(wData,1,1)="-" then
			neg=true
			wData = mid(wData,2)
		end if
	end if
	IF wData<>"" AND LEN(wData)>2 THEN
		wData=formatNumber(MID(wData,1,Len(wData)-2),0)&"#"&MID(wData,Len(wData)-1)
	ELSEIF LEN(wData)=2 THEN
		wData="0#"&wData
	ELSEIF LEN(wData)=1 THEN
		wData="0#0"&wData
	ELSEIF LEN(wData)=0 THEN
		wData="0#00"
	END IF
	if inStr(wData,",")>0 then
		wData = replace(wData,",",".")
	end if
	wData = replace(wData,"#",",")
	if neg then wData="-"&wData
	formataValorSist=wData
END FUNCTION

FUNCTION formataValor1(wData) '####Formata valor para N.NNN,NN####
	'wData = Trim(CStr(" "&wData))
	'IF wData>0 AND wData>9 THEN
	'	qValor=MID(wData,1,Len(wData)-2)
	'	cent=MID(wData,Len(wData)-1)
	'	tamValor=Len(qValor)
	'	IF qValor<>"" THEN
	'		fator=FIX((tamValor-1)/3)
	'		IF fator > 0 THEN
	'			base=tamValor-(fator*3)
	'			tempValor=MID(qValor,1,base)
	'			FOR i = 0 TO fator-1
	'				tempValor=tempValor&"."&MID(qValor,base+(1+(i*3)),3)
	'			NEXT
	'			qValor=tempValor
	'		END IF
	'		wData=qValor&","&cent
	'	END IF
	'ELSEIF LEN(wData)=2 THEN
	'	wData="0,"&wData
	'ELSEIF LEN(wData)=1 THEN
	'	wData="0,0"&wData
	'ELSE
	'	wData=""
	'END If
	'If wNeg Then
	'	wData = "-"&wData
	'End if
	'if wData = "" then wData = "0,00"
	formataValor=wData
END FUNCTION

%>
