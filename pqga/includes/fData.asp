<%
FUNCTION formataData(wData) '####Formata as datas para DD/MM/AAAA####
	IF wData<>"" AND Len(wData)=8 THEN
		wData=MID(wData,7,2)&"/"&MID(wData,5,2)&"/"&MID(wData,1,4)
	END IF
	formataData=wData
END FUNCTION
%>
<%
FUNCTION formataData1(wData) '####Formata as datas para DD/MM/AAAA####
	IF wData<>"" AND Len(wData)=10 THEN
		wData=MID(wData,9,2)&"/"&MID(wData,6,2)&"/"&MID(wData,1,4)
	END IF
	formataData1=wData
END FUNCTION
%>
<%
FUNCTION formataData3(wData) '####Formata as datas para DD/MM/AAAA####
	IF wData<>"" AND Len(wData)=10 THEN
		wData=MID(wData,9,2)&"."&MID(wData,6,2)&"."&MID(wData,1,4)
	END IF
	formataData3=wData
END FUNCTION
%>
<%
FUNCTION formataData4(wData) '####Formata as datas para AAAAMMDD####
	IF wData<>"" AND Len(wData)=10 THEN
		wData=cint(MID(wData,7,4)&MID(wData,4,2)&MID(wData,1,2))
	END IF
	formataData4=wData
END FUNCTION
%>
<%
FUNCTION formataDataPonto(wData) '####Formata as datas para DD.MM.AAAA####
	IF wData<>"" AND Len(wData)=8 THEN
		wData=MID(wData,7,2)&"."&MID(wData,5,2)&"."&MID(wData,1,4)
	END IF
	formataDataPonto=wData
END FUNCTION
%>
<%
FUNCTION formataHora(wData) '####Formata hora para HH:MM####
	IF Len(wData)=3 THEN wData="0"&wData
	IF wData<>"" AND Len(wData)=4 THEN
		wData=MID(wData,1,2)&":"&MID(wData,3,2)
	END IF
	formataHora=wData
END FUNCTION
%>
<%
FUNCTION getDiff(psTipo,piDataIni,piHoraIni,piDataFim,piHoraFim) '####Retorna a diferença entre duas datas de acordo com o tipo####
	if Len(piDataIni)<>8 or Len(piHoraIni)>4 or Len(piDataFim)<>8 or Len(piHoraFim)>4 then
		liDiff = 0
	else
		liDiff = DateDiff(psTipo,Mid(piDataIni,1,4)&"-"&MonthName(Mid(piDataIni,5,2))&"-"&Mid(piDataIni,7,2)&" "&Mid(piHoraIni,1,2)&":"&Mid(piHoraIni,3,2),Mid(piDataFim,1,4)&"-"&MonthName(Mid(piDataFim,5,2))&"-"&Mid(piDataFim,7,2)&" "&Mid(piHoraFim,1,2)&":"&Mid(piHoraFim,3,2))
	end if
	getDiff = liDiff
END FUNCTION
%>
<%
FUNCTION addDate(psTipo,piValor,piData) '####Retorna a diferença entre duas datas de acordo com o tipo####
	if Len(piData)<>8 then
		liFinalDate = 0
	else
		liFinalDate = DateAdd(psTipo,piValor,Mid(piData,1,4)&"-"&MonthName(Mid(piData,5,2))&"-"&Mid(piData,7,2))
		liFinalDate = int(Year(liFinalDate)&addZero(Month(liFinalDate),2)&addZero(Day(liFinalDate),2))
	end if
	addDate = liFinalDate
END FUNCTION
%>
<%
FUNCTION formataDataVB(wData) '####Formata as datas em VB para quebrar linha entre a data e a hora (para browser 800x600)#### REQUER addZero
	if not isNull(wData) then
		wData=day(wData)&"/"&month(wData)&"/"&year(wData)&"<br>"&addZero(hour(wData),2)&":"&addZero(Minute(wData),2)
	end if
	formataDataVB=wData
END FUNCTION
%>
<%
function validaData(wData)
	Dim regExData
	Set regExData = New RegExp
	regExData.Pattern = "^[0-9]{2}\/[0-9]{2}\/[0-9]{4}$"
	if regExData.Test(wData) then
		dataArray = Split(wData,"/")
		if isDate(dataArray(0)&" - "&MonthName(dataArray(1))&","&dataArray(2))=False Then
			validaData = 0
		else
			if int(dataArray(2))<2000 then
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