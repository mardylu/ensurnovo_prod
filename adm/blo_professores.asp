<%If Session("key_cur")<>"ok" Then Response.Redirect "logout.asp"%>
<!-- #INCLUDE FILE="../library/parametros.asp" -->
<!-- #INCLUDE FILE="../library/conOpen.asp" -->
<!-- #INCLUDE FILE="../library/conOpenSIM.asp" -->
<!-- #INCLUDE FILE="../library/fErroMsg.asp" -->
<!-- #INCLUDE FILE="../library/fCreateSel.asp" -->
<!-- #INCLUDE FILE="../library/fAddZero.asp" -->
<!-- #INCLUDE FILE="../library/fFormataData.asp" -->
<!-- #INCLUDE FILE="../library/fData.asp" -->
<!-- #INCLUDE FILE="../library/fFormataCPF.asp" -->
<!-- #INCLUDE FILE="../library/fFormataCep.asp" -->
<!-- #INCLUDE FILE="../library/guid.asp" -->

<%
GUID_PROF=""
cod = request("cod")
if cod=0 or cod="" or isNumeric(cod)=false then cod=0
RS.Open "SELECT * FROM PROFESSORES WHERE ID_PROFESSOR="&int(cod)
if not RS.EOF then
	NOME=RS("NOME")
	CPF=RS("CPF")
	TELEFONECEL=RS("TELEFONECEL")
	TELEFONERES=RS("TELEFONERES")
	ID_TEMA1=RS("TEMA1")
	ID_TEMA2=RS("TEMA2")
	ID_TEMA3=RS("TEMA3")
	ID_TEMA4=RS("TEMA4")
	ID_TEMA5=RS("TEMA5")
	ID_TEMA6=RS("TEMA6")
	SENHA=RS("SENHA")
	ID_SUBTEMA1=RS("SUBTEMA1")
	ID_SUBTEMA2=RS("SUBTEMA2")
	ID_SUBTEMA3=RS("SUBTEMA3")
	ID_SUBTEMA4=RS("SUBTEMA4")
	ID_SUBTEMA5=RS("SUBTEMA5")
	ID_SUBTEMA6=RS("SUBTEMA6")
	ID_SUBTEMA7=RS("SUBTEMA7")
	ID_SUBTEMA8=RS("SUBTEMA8")
	ID_SUBTEMA9=RS("SUBTEMA9")
	ID_SUBTEMA10=RS("SUBTEMA10")
	ID_SUBTEMA11=RS("SUBTEMA11")
	ID_SUBTEMA12=RS("SUBTEMA12")
	ID_SUBTEMA13=RS("SUBTEMA13")
	ID_SUBTEMA14=RS("SUBTEMA14")
	ID_SUBTEMA15=RS("SUBTEMA15")
	ID_SUBTEMA16=RS("SUBTEMA16")
	ID_SUBTEMA17=RS("SUBTEMA17")
	ID_SUBTEMA18=RS("SUBTEMA18")
	ID_SUBTEMA19=RS("SUBTEMA19")
	ID_SUBTEMA20=RS("SUBTEMA20")
	ID_SUBTEMA21=RS("SUBTEMA21")
	ID_SUBTEMA22=RS("SUBTEMA22")
	ID_SUBTEMA23=RS("SUBTEMA23")
	ID_SUBTEMA24=RS("SUBTEMA24")
	DOMINGOM=RS("DOMINGOM")
	DOMINGOT=RS("DOMINGOT")
	DOMINGON=RS("DOMINGON")
	SEGUNDAM=RS("SEGUNDAM")
	SEGUNDAT=RS("SEGUNDAT")
	SEGUNDAN=RS("SEGUNDAN")
	TERCAM=RS("TERCAM")
	TERCAT=RS("TERCAT")
	TERCAN=RS("TERCAN")
	QUARTAM=RS("QUARTAM")
	QUARTAT=RS("QUARTAT")
	QUARTAN=RS("QUARTAN")
	QUINTAM=RS("QUINTAM")
	QUINTAT=RS("QUINTAT")
	QUINTAN=RS("QUINTAN")
	SEXTAM=RS("SEXTAM")
	SEXTAT=RS("SEXTAT")
	SEXTAN=RS("SEXTAN")
	SABADOM=RS("SABADOM")
	SABADOT=RS("SABADOT")
	SABADON=RS("SABADON")
	EMAIL=RS("EMAIL")
	MINICURRICULO=RS("MINICURRICULO")
	FICHA_TECNICA=RS("FICHA_TECNICA")
	DATA_NASCIMENTO=RS("DATA_NASCIMENTO")
	STATUS_PROFESSOR=RS("STATUS_PROFESSOR")
	NOME_FANTASIA=RS("NOME_FANTASIA")
	GUID_PROF=RS("GUID_PROF")
	ENDERECO=RS("ENDERECO")
	BAIRRO=RS("BAIRRO")
	COD_MUNI_IBGE=RS("COD_MUNI_IBGE")
	COD_UF_IBGE=RS("COD_UF_IBGE")
	CEP=RS("CEP")
	COD_ESCOLARIDADE=RS("COD_ESCOLARIDADE")
	FORMACAO=RS("FORMACAO")
	COD_POS=RS("COD_POS")
	POS=RS("POS")
end if
IF GUID_PROF="" then
	GUID_PROF=genguid()
END IF
RS.Close

Set RS2 = Server.CreateObject("ADODB.Recordset")
RS2.CursorType = 0
RS2.ActiveConnection = Con

Set RSSIM2 = Server.CreateObject("ADODB.Recordset")
RSSIM2.CursorType = 0
RSSIM2.ActiveConnection = ConSIM

'Option Explicit
On Error Resume Next

' Declara as variáveis
Dim objFSO, objFolder
Dim objCollection, objItem

Dim strPhysicalPath, strTitle, strServerName
Dim strPath, strTemp
Dim strName, strFile, strExt, strAttr
Dim intSizeB, intSizeK, intAttr, dtmDate

' Declara as constantes
Const vbReadOnly = 1
Const vbHidden = 2
Const vbSystem = 4
Const vbVolume = 8
Const vbDirectory = 16
Const vbArchive = 32
Const vbAlias = 64
Const vbCompressed = 128

' Não armazenar em cache 
Response.AddHeader "Pragma", "No-Cache"
Response.CacheControl = "Private"

' obter o caminho URL da atual pasta
strTemp = Mid(Request.ServerVariables("URL"),2)
strPath = ""

Do While Instr(strTemp,"/")
  strPath = strPath & Left(strTemp,Instr(strTemp,"/"))
  strTemp = Mid(strTemp,Instr(strTemp,"/")+1)      
Loop

strPath = "/sistemas/ronaldo/adm/curriculos/" 

' Configura o título da página
strServerName = UCase(Request.ServerVariables("SERVER_NAME"))
strTitle = "Lista dos Arquivos " & strPath & " folder"

' cria os objetos do sistema de arquivos
strPhysicalPath = Server.MapPath(strPath)
Set objFSO = Server.CreateObject("Scripting.FileSystemObject")
Set objFolder = objFSO.GetFolder(strPhysicalPath)
''''''''''''''''''''''''''''''''''''''''
' imprimir a lista de pastas
''''''''''''''''''''''''''''''''''''''''

Set objCollection = objFolder.SubFolders

For Each objItem in objCollection
  strName = objItem.Name
  strAttr = MakeAttr(objItem.Attributes)      
  dtmDate = CDate(objItem.DateLastModified)
Next

''''''''''''''''''''''''''''''''''''''''
' imprimir a lista de arquivos
''''''''''''''''''''''''''''''''''''''''

Set objCollection = objFolder.Files

For Each objItem in objCollection
  strName = objItem.Name
  strFile = Server.HTMLEncode(Lcase(strName))

  intSizeB = objItem.Size
  intSizeK = Int((intSizeB/1024) + .5)
  If intSizeK = 0 Then intSizeK = 1

  strAttr = MakeAttr(objItem.Attributes)
  'strName = Ucase(objItem.ShortName)
  If Instr(strName,".") Then strExt = Right(strName,Len(strName)-Instr(strName,".")) Else strExt = ""
  dtmDate = CDate(objItem.DateLastModified)
	if mid(strName,1,37)=GUID_PROF&"_foto" then
		str_foto = "<a href="&strPath&strFile&">"&strName&"</a>"
		foto = strPath&strFile
	end if
Next
Set objFSO = Nothing
Set objFolder = Nothing

' Adiciona a função IIf () para VBScript
Function IIf(i,j,k)
  If i Then IIf = j Else IIf = k
End Function

%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<!-- TinyMCE -->
	<script type="text/javascript" src="tiny_mce/tiny_mce.js"></script>
	<script type="text/javascript">
		tinyMCE.init({
			// General options
			mode : "exact",
			elements : "info",
			theme : "advanced",
			plugins : "autolink,lists,advlink,contextmenu,paste,directionality,fullscreen,noneditable,nonbreaking,inlinepopups",
	
			// Theme options
			theme_advanced_buttons1 : "bold,italic,underline,strikethrough,|,bullist,numlist,|,outdent,indent,blockquote,|,undo,redo,|,link,unlink,|,code,fullscreen",
			theme_advanced_buttons2 : "",
			theme_advanced_buttons3 : "",
			theme_advanced_buttons4 : "",
			theme_advanced_toolbar_location : "top",
			theme_advanced_toolbar_align : "left",
			theme_advanced_statusbar_location : "bottom",
			theme_advanced_resizing : true
		});
	</script>
	<script type="text/javascript">
		function GetSelectedItem1(selecionado) {
			len = document.form.ID_TEMA1.length;
			i = 0;
			chosen = "none";
			document.forms['form'].ID_SUBTEMA1.length = 0;
			document.forms['form'].ID_SUBTEMA2.length = 0;
			document.forms['form'].ID_SUBTEMA3.length = 0;
			document.forms['form'].ID_SUBTEMA4.length = 0;
			
 			for (i = 0; i < len; i++) {
				var xpto;
				if (document.form.ID_TEMA1[i].selected ) {
				<% 
				RS.open "SELECT ID_TEMA,TEMA FROM TEMAS ORDER BY TEMA"
				do while not RS.eof %>
					if(document.form.ID_TEMA1[i].value== "<% =RS("ID_TEMA") %>") {
						var z=1;
						<% sql="select ID_SUBTEMA,ID_TEMA,SUBTEMA from SUBTEMAS where ID_TEMA='"&RS("ID_TEMA")&"' order by SUBTEMA"
						RS2.Open sql %>
						document.forms['form'].ID_SUBTEMA1.options[1] = new Option(" ");
						document.forms['form'].ID_SUBTEMA2.options[1] = new Option(" ");
						document.forms['form'].ID_SUBTEMA3.options[1] = new Option(" ");
						document.forms['form'].ID_SUBTEMA4.options[1] = new Option(" ");
						<%do while not RS2.eof %>
							document.forms['form'].ID_SUBTEMA1.options[z] = new Option("<% =RS2("SUBTEMA") %>","<% =RS2("ID_SUBTEMA") %>");
							<% if cod > 0 then%>
								var subtema = <% =RS2("ID_SUBTEMA") %>
								if (subtema == <% =ID_SUBTEMA1 %>) {
									document.forms['form'].ID_SUBTEMA1.options[z].selected = true;
								}							
							<% end if %>
							document.forms['form'].ID_SUBTEMA2.options[z] = new Option("<% =RS2("SUBTEMA") %>","<% =RS2("ID_SUBTEMA") %>");
							<% if cod > 0 then%>
								var subtema = <% =RS2("ID_SUBTEMA") %>
								if (subtema == <% =ID_SUBTEMA2 %>) {
									document.forms['form'].ID_SUBTEMA2.options[z].selected = true;
								}							
							<% end if %>
							document.forms['form'].ID_SUBTEMA3.options[z] = new Option("<% =RS2("SUBTEMA") %>","<% =RS2("ID_SUBTEMA") %>");
							<% if cod > 0 then%>
								var subtema = <% =RS2("ID_SUBTEMA") %>
								if (subtema == <% =ID_SUBTEMA3 %>) {
									document.forms['form'].ID_SUBTEMA3.options[z].selected = true;
								}							
							<% end if %>
							document.forms['form'].ID_SUBTEMA4.options[z] = new Option("<% =RS2("SUBTEMA") %>","<% =RS2("ID_SUBTEMA") %>");
							<% if cod > 0 then%>
								var subtema = <% =RS2("ID_SUBTEMA") %>
								if (subtema == <% =ID_SUBTEMA4 %>) {
									document.forms['form'].ID_SUBTEMA4.options[z].selected = true;
								}							
							<% end if %>
							z=z+1;	
							<% RS2.movenext
						
						loop 
						RS2.CLOSE%>
					}
					<% RS.movenext
				loop 
				RS.CLOSE
				%>
				GetSelectedItem2(document.form.ID_TEMA2.value);
				}
			}
		}
		function GetSelectedItem2(selecionado) {
			len = document.form.ID_TEMA2.length;
			i = 0;
			chosen = "none";
			document.forms['form'].ID_SUBTEMA5.length = 0;
			document.forms['form'].ID_SUBTEMA6.length = 0;
			document.forms['form'].ID_SUBTEMA7.length = 0;
			document.forms['form'].ID_SUBTEMA8.length = 0;
			
 			for (i = 0; i < len; i++) {
				var xpto;
				if (document.form.ID_TEMA2[i].selected ) {
				<% 
				RS.open "SELECT ID_TEMA,TEMA FROM TEMAS ORDER BY TEMA"
				do while not RS.eof %>
					if(document.form.ID_TEMA2[i].value== "<% =RS("ID_TEMA") %>") {
						var z=1;
						<% sql="select ID_SUBTEMA,ID_TEMA,SUBTEMA from SUBTEMAS where ID_TEMA='"&RS("ID_TEMA")&"' order by SUBTEMA"
						RS2.Open sql %>
						document.forms['form'].ID_SUBTEMA5.options[1] = new Option(" ");
						document.forms['form'].ID_SUBTEMA6.options[1] = new Option(" ");
						document.forms['form'].ID_SUBTEMA7.options[1] = new Option(" ");
						document.forms['form'].ID_SUBTEMA8.options[1] = new Option(" ");
						<%do while not RS2.eof %>
							document.forms['form'].ID_SUBTEMA5.options[z] = new Option("<% =RS2("SUBTEMA") %>","<% =RS2("ID_SUBTEMA") %>");
							<% if cod > 0 then%>
								var subtema = <% =RS2("ID_SUBTEMA") %>
								if (subtema == <% =ID_SUBTEMA5 %>) {
									document.forms['form'].ID_SUBTEMA5.options[z].selected = true;
								}							
							<% end if %>
							document.forms['form'].ID_SUBTEMA6.options[z] = new Option("<% =RS2("SUBTEMA") %>","<% =RS2("ID_SUBTEMA") %>");
							<% if cod > 0 then%>
								var subtema = <% =RS2("ID_SUBTEMA") %>
								if (subtema == <% =ID_SUBTEMA6 %>) {
									document.forms['form'].ID_SUBTEMA6.options[z].selected = true;
								}							
							<% end if %>
							document.forms['form'].ID_SUBTEMA7.options[z] = new Option("<% =RS2("SUBTEMA") %>","<% =RS2("ID_SUBTEMA") %>");
							<% if cod > 0 then%>
								var subtema = <% =RS2("ID_SUBTEMA") %>
								if (subtema == <% =ID_SUBTEMA7 %>) {
									document.forms['form'].ID_SUBTEMA7.options[z].selected = true;
								}							
							<% end if %>
							document.forms['form'].ID_SUBTEMA8.options[z] = new Option("<% =RS2("SUBTEMA") %>","<% =RS2("ID_SUBTEMA") %>");
							<% if cod > 0 then%>
								var subtema = <% =RS2("ID_SUBTEMA") %>
								if (subtema == <% =ID_SUBTEMA8 %>) {
									document.forms['form'].ID_SUBTEMA8.options[z].selected = true;
								}							
							<% end if %>
							z=z+1;	
							<% RS2.movenext
						
						loop 
						RS2.CLOSE%>
					}
					<% RS.movenext
				loop 
				RS.CLOSE
				%>
				GetSelectedItem3(document.form.ID_TEMA3.value);
				}
			}
		}

		function GetSelectedItem3(selecionado) {
			len = document.form.ID_TEMA3.length;
			i = 0;
			chosen = "none";
			document.forms['form'].ID_SUBTEMA9.length = 0;
			document.forms['form'].ID_SUBTEMA10.length = 0;
			document.forms['form'].ID_SUBTEMA11.length = 0;
			document.forms['form'].ID_SUBTEMA12.length = 0;
			
 			for (i = 0; i < len; i++) {
				var xpto;
				if (document.form.ID_TEMA3[i].selected ) {
				<% 
				RS.open "SELECT ID_TEMA,TEMA FROM TEMAS ORDER BY TEMA"
				do while not RS.eof %>
					if(document.form.ID_TEMA3[i].value== "<% =RS("ID_TEMA") %>") {
						var z=1;
						<% sql="select ID_SUBTEMA,ID_TEMA,SUBTEMA from SUBTEMAS where ID_TEMA='"&RS("ID_TEMA")&"' order by SUBTEMA"
						RS2.Open sql %>
						document.forms['form'].ID_SUBTEMA9.options[1] = new Option(" ");
						document.forms['form'].ID_SUBTEMA10.options[1] = new Option(" ");
						document.forms['form'].ID_SUBTEMA11.options[1] = new Option(" ");
						document.forms['form'].ID_SUBTEMA12.options[1] = new Option(" ");
						<%do while not RS2.eof %>
							document.forms['form'].ID_SUBTEMA9.options[z] = new Option("<% =RS2("SUBTEMA") %>","<% =RS2("ID_SUBTEMA") %>");
							<% if cod > 0 then%>
								var subtema = <% =RS2("ID_SUBTEMA") %>
								if (subtema == <% =ID_SUBTEMA9 %>) {
									document.forms['form'].ID_SUBTEMA9.options[z].selected = true;
								}							
							<% end if %>
							document.forms['form'].ID_SUBTEMA10.options[z] = new Option("<% =RS2("SUBTEMA") %>","<% =RS2("ID_SUBTEMA") %>");
							<% if cod > 0 then%>
								var subtema = <% =RS2("ID_SUBTEMA") %>
								if (subtema == <% =ID_SUBTEMA10 %>) {
									document.forms['form'].ID_SUBTEMA10.options[z].selected = true;
								}							
							<% end if %>
							document.forms['form'].ID_SUBTEMA11.options[z] = new Option("<% =RS2("SUBTEMA") %>","<% =RS2("ID_SUBTEMA") %>");
							<% if cod > 0 then%>
								var subtema = <% =RS2("ID_SUBTEMA") %>
								if (subtema == <% =ID_SUBTEMA11 %>) {
									document.forms['form'].ID_SUBTEMA11.options[z].selected = true;
								}							
							<% end if %>
							document.forms['form'].ID_SUBTEMA12.options[z] = new Option("<% =RS2("SUBTEMA") %>","<% =RS2("ID_SUBTEMA") %>");
							<% if cod > 0 then%>
								var subtema = <% =RS2("ID_SUBTEMA") %>
								if (subtema == <% =ID_SUBTEMA12 %>) {
									document.forms['form'].ID_SUBTEMA12.options[z].selected = true;
								}							
							<% end if %>
							z=z+1;	
							<% RS2.movenext
						
						loop 
						RS2.CLOSE%>
					}
					<% RS.movenext
				loop 
				RS.CLOSE
				%>
				GetSelectedItem4(document.form.ID_TEMA4.value);
				}
			}
		}
		function GetSelectedItem4(selecionado) {
			len = document.form.ID_TEMA4.length;
			i = 0;
			chosen = "none";
			document.forms['form'].ID_SUBTEMA13.length = 0;
			document.forms['form'].ID_SUBTEMA14.length = 0;
			document.forms['form'].ID_SUBTEMA15.length = 0;
			document.forms['form'].ID_SUBTEMA16.length = 0;
			
 			for (i = 0; i < len; i++) {
				var xpto;
				if (document.form.ID_TEMA4[i].selected ) {
				<% 
				RS.open "SELECT ID_TEMA,TEMA FROM TEMAS ORDER BY TEMA"
				do while not RS.eof %>
					if(document.form.ID_TEMA4[i].value== "<% =RS("ID_TEMA") %>") {
						var z=1;
						<% sql="select ID_SUBTEMA,ID_TEMA,SUBTEMA from SUBTEMAS where ID_TEMA='"&RS("ID_TEMA")&"' order by SUBTEMA"
						RS2.Open sql %>
						document.forms['form'].ID_SUBTEMA13.options[1] = new Option(" ");
						document.forms['form'].ID_SUBTEMA14.options[1] = new Option(" ");
						document.forms['form'].ID_SUBTEMA15.options[1] = new Option(" ");
						document.forms['form'].ID_SUBTEMA16.options[1] = new Option(" ");
						<%do while not RS2.eof %>
							document.forms['form'].ID_SUBTEMA13.options[z] = new Option("<% =RS2("SUBTEMA") %>","<% =RS2("ID_SUBTEMA") %>");
							<% if cod > 0 then%>
								var subtema = <% =RS2("ID_SUBTEMA") %>
								if (subtema == <% =ID_SUBTEMA13 %>) {
									document.forms['form'].ID_SUBTEMA13.options[z].selected = true;
								}							
							<% end if %>
							document.forms['form'].ID_SUBTEMA14.options[z] = new Option("<% =RS2("SUBTEMA") %>","<% =RS2("ID_SUBTEMA") %>");
							<% if cod > 0 then%>
								var subtema = <% =RS2("ID_SUBTEMA") %>
								if (subtema == <% =ID_SUBTEMA14 %>) {
									document.forms['form'].ID_SUBTEMA14.options[z].selected = true;
								}							
							<% end if %>
							document.forms['form'].ID_SUBTEMA15.options[z] = new Option("<% =RS2("SUBTEMA") %>","<% =RS2("ID_SUBTEMA") %>");
							<% if cod > 0 then%>
								var subtema = <% =RS2("ID_SUBTEMA") %>
								if (subtema == <% =ID_SUBTEMA15 %>) {
									document.forms['form'].ID_SUBTEMA15.options[z].selected = true;
								}							
							<% end if %>
							document.forms['form'].ID_SUBTEMA16.options[z] = new Option("<% =RS2("SUBTEMA") %>","<% =RS2("ID_SUBTEMA") %>");
							<% if cod > 0 then%>
								var subtema = <% =RS2("ID_SUBTEMA") %>
								if (subtema == <% =ID_SUBTEMA16 %>) {
									document.forms['form'].ID_SUBTEMA16.options[z].selected = true;
								}							
							<% end if %>
							z=z+1;	
							<% RS2.movenext
						
						loop 
						RS2.CLOSE%>
					}
					<% RS.movenext
				loop 
				RS.CLOSE
				%>
				GetSelectedItem5(document.form.ID_TEMA5.value);
				}
			}
		}
		function GetSelectedItem5(selecionado) {
			len = document.form.ID_TEMA5.length;
			i = 0;
			chosen = "none";
			document.forms['form'].ID_SUBTEMA17.length = 0;
			document.forms['form'].ID_SUBTEMA18.length = 0;
			document.forms['form'].ID_SUBTEMA19.length = 0;
			document.forms['form'].ID_SUBTEMA20.length = 0;
			
 			for (i = 0; i < len; i++) {
				var xpto;
				if (document.form.ID_TEMA5[i].selected ) {
				<% 
				RS.open "SELECT ID_TEMA,TEMA FROM TEMAS ORDER BY TEMA"
				do while not RS.eof %>
					if(document.form.ID_TEMA5[i].value== "<% =RS("ID_TEMA") %>") {
						var z=1;
						<% sql="select ID_SUBTEMA,ID_TEMA,SUBTEMA from SUBTEMAS where ID_TEMA='"&RS("ID_TEMA")&"' order by SUBTEMA"
						RS2.Open sql %>
						document.forms['form'].ID_SUBTEMA17.options[1] = new Option(" ");
						document.forms['form'].ID_SUBTEMA18.options[1] = new Option(" ");
						document.forms['form'].ID_SUBTEMA19.options[1] = new Option(" ");
						document.forms['form'].ID_SUBTEMA20.options[1] = new Option(" ");
						<%do while not RS2.eof %>
							document.forms['form'].ID_SUBTEMA17.options[z] = new Option("<% =RS2("SUBTEMA") %>","<% =RS2("ID_SUBTEMA") %>");
							<% if cod > 0 then%>
								var subtema = <% =RS2("ID_SUBTEMA") %>
								if (subtema == <% =ID_SUBTEMA17 %>) {
									document.forms['form'].ID_SUBTEMA17.options[z].selected = true;
								}							
							<% end if %>
							document.forms['form'].ID_SUBTEMA18.options[z] = new Option("<% =RS2("SUBTEMA") %>","<% =RS2("ID_SUBTEMA") %>");
							<% if cod > 0 then%>
								var subtema = <% =RS2("ID_SUBTEMA") %>
								if (subtema == <% =ID_SUBTEMA18 %>) {
									document.forms['form'].ID_SUBTEMA18.options[z].selected = true;
								}							
							<% end if %>
							document.forms['form'].ID_SUBTEMA19.options[z] = new Option("<% =RS2("SUBTEMA") %>","<% =RS2("ID_SUBTEMA") %>");
							<% if cod > 0 then%>
								var subtema = <% =RS2("ID_SUBTEMA") %>
								if (subtema == <% =ID_SUBTEMA19 %>) {
									document.forms['form'].ID_SUBTEMA19.options[z].selected = true;
								}							
							<% end if %>
							document.forms['form'].ID_SUBTEMA20.options[z] = new Option("<% =RS2("SUBTEMA") %>","<% =RS2("ID_SUBTEMA") %>");
							<% if cod > 0 then%>
								var subtema = <% =RS2("ID_SUBTEMA") %>
								if (subtema == <% =ID_SUBTEMA20 %>) {
									document.forms['form'].ID_SUBTEMA20.options[z].selected = true;
								}							
							<% end if %>
							z=z+1;	
							<% RS2.movenext
						
						loop 
						RS2.CLOSE%>
					}
					<% RS.movenext
				loop 
				RS.CLOSE
				%>
				GetSelectedItem6(document.form.ID_TEMA6.value);
				}
			}
		}
		function GetSelectedItem6(selecionado) {
			len = document.form.ID_TEMA6.length;
			i = 0;
			chosen = "none";
			document.forms['form'].ID_SUBTEMA21.length = 0;
			document.forms['form'].ID_SUBTEMA22.length = 0;
			document.forms['form'].ID_SUBTEMA23.length = 0;
			document.forms['form'].ID_SUBTEMA24.length = 0;
			
 			for (i = 0; i < len; i++) {
				var xpto;
				if (document.form.ID_TEMA6[i].selected ) {
				<% 
				RS.open "SELECT ID_TEMA,TEMA FROM TEMAS ORDER BY TEMA"
				do while not RS.eof %>
					if(document.form.ID_TEMA6[i].value== "<% =RS("ID_TEMA") %>") {
						var z=1;
						<% sql="select ID_SUBTEMA,ID_TEMA,SUBTEMA from SUBTEMAS where ID_TEMA='"&RS("ID_TEMA")&"' order by SUBTEMA"
						RS2.Open sql %>
						document.forms['form'].ID_SUBTEMA21.options[1] = new Option(" ");
						document.forms['form'].ID_SUBTEMA22.options[1] = new Option(" ");
						document.forms['form'].ID_SUBTEMA23.options[1] = new Option(" ");
						document.forms['form'].ID_SUBTEMA24.options[1] = new Option(" ");
						<%do while not RS2.eof %>
							document.forms['form'].ID_SUBTEMA21.options[z] = new Option("<% =RS2("SUBTEMA") %>","<% =RS2("ID_SUBTEMA") %>");
							<% if cod > 0 then%>
								var subtema = <% =RS2("ID_SUBTEMA") %>
								if (subtema == <% =ID_SUBTEMA21 %>) {
									document.forms['form'].ID_SUBTEMA21.options[z].selected = true;
								}							
							<% end if %>
							document.forms['form'].ID_SUBTEMA22.options[z] = new Option("<% =RS2("SUBTEMA") %>","<% =RS2("ID_SUBTEMA") %>");
							<% if cod > 0 then%>
								var subtema = <% =RS2("ID_SUBTEMA") %>
								if (subtema == <% =ID_SUBTEMA22 %>) {
									document.forms['form'].ID_SUBTEMA22.options[z].selected = true;
								}							
							<% end if %>
							document.forms['form'].ID_SUBTEMA23.options[z] = new Option("<% =RS2("SUBTEMA") %>","<% =RS2("ID_SUBTEMA") %>");
							<% if cod > 0 then%>
								var subtema = <% =RS2("ID_SUBTEMA") %>
								if (subtema == <% =ID_SUBTEMA23 %>) {
									document.forms['form'].ID_SUBTEMA23.options[z].selected = true;
								}							
							<% end if %>
							document.forms['form'].ID_SUBTEMA24.options[z] = new Option("<% =RS2("SUBTEMA") %>","<% =RS2("ID_SUBTEMA") %>");
							<% if cod > 0 then%>
								var subtema = <% =RS2("ID_SUBTEMA") %>
								if (subtema == <% =ID_SUBTEMA24 %>) {
									document.forms['form'].ID_SUBTEMA24.options[z].selected = true;
								}							
							<% end if %>
							z=z+1;	
							<% RS2.movenext
						
						loop 
						RS2.CLOSE%>
					}
					<% RS.movenext
				loop 
				RS.CLOSE
				%>
				GetSelectedEstado(document.form.COD_UF_IBGE.value);
				}
			}
		}
		
		function GetSelectedEstado(selecionado) {
			len = document.form.COD_UF_IBGE.length;
			i = 0;
			chosen = "none";
			document.forms['form'].COD_MUNI_IBGE.length = 0;
			
 			for (i = 0; i < len; i++) {
				var xpto;
				if (document.form.COD_UF_IBGE[i].selected ) {
				<% 
				RSSIM.open "SELECT COD_UF_IBGE,SIGLA_UF FROM UF ORDER BY SIGLA_UF"
				do while not RSSIM.eof %>
					if(document.form.COD_UF_IBGE[i].value== "<% =RSSIM("COD_UF_IBGE") %>") {
						var z=0;
						<% sql="SELECT NOME_MUNI,COD_MUNI_IBGE,COD_UF_IBGE FROM MUNICIPIOS where COD_UF_IBGE='"&RSSIM("COD_UF_IBGE")&"' order by NOME_MUNI"
						RSSIM2.Open sql
						do while not RSSIM2.eof %>
							document.forms['form'].COD_MUNI_IBGE.options[z] = new Option("<% =RSSIM2("NOME_MUNI") %>","<% =RSSIM2("COD_MUNI_IBGE") %>");
							var seq = <% =RSSIM2("COD_MUNI_IBGE") %>
							if (seq == <% =Cint(COD_MUNI_IBGE) %>) {
								document.forms['form'].COD_MUNI_IBGE.options[z].selected = true;
							}							
							z=z+1;	
							<% RSSIM2.movenext
						loop 
						RSSIM2.CLOSE%>
					}
					<% RSSIM.movenext
				loop 
				RSSIM.CLOSE
				%>
				}
			}
					
		}				

	</script>
	<!-- /TinyMCE -->
	<script type="text/javascript" src="../js/validacao_pb.js"></script>
	<script type="text/javascript" src="../js/municipios.js"></script>
	<script type="text/javascript" src="../js/mascara.js"></script>

	<title>ENSUR Inscrições</title>
</head>

<body onload="GetSelectedItem1(document.form.ID_TEMA1.value)">

<div id="pagina">
	<!-- #INCLUDE FILE="include/topo.asp" -->
	<div id="conteudo">
		<table border = 0 width=100%>
			<tr><td WIDTH="10%"><a href="lista_professores.asp"><img src="img/btnp_seta_invet.gif" border="0"></a></td><td WIDTH="90%"><h1>Cadastro de Professores</h1></td></tr>
		</table>
		<form name="form" method="POST" action="salva_professores.asp">
		<input type="hidden" name="cod" value="<%=cod%>">
		<input type="hidden" name="volta" value="bloq">
		<fieldset>
			<legend>informações do professor</legend>
			<table width=100%>
			<tr><td nowrap><label for="NOME" class="requerido">Nome</label></td><td colspan=3><input type="text" name="NOME" id="NOME" maxlength="150" size="60" value="<%=NOME%>"></td><td rowspan="7"><img src="<% if foto<>"" then response.write foto end if%>" border="1" width="120" height="150" ></td></tr>
			<tr><td nowrap><label for="NOME_FANTASIA" class="requerido">Nome Fantasia</label></td><td colspan=3><input type="text" name="NOME_FANTASIA" id="NOME_FANTASIA" maxlength="500" size="60" value="<%=NOME_FANTASIA%>"></td></tr>
			<tr><td nowrap><label for="SENHA" class="requerido">Senha</label></td><td colspan=3><input type="password" name="SENHA" id="SENHA" maxlength="12" size="20" value="<%=SENHA%>"></td></tr>
			<tr><td nowrap><label for="DATA_NASCIMENTO" class="requerido">Data de Nascimento</label></td><td colspan=3><input type="text" name="DATA_NASCIMENTO" id="DATA_NASCIMENTO" maxlength="10" size="15" value="<%=formatadata1(DATA_NASCIMENTO)%>" onKeyPress="return ValidateKeyPressed('DATE', this, event);" onChange="valida_campo(4,this);"><a href="javascript:void(0)" onclick="if(self.gfPop)gfPop.fPopCalendar(document.form.DATA_NASCIMENTO);return false;" HIDEFOCUS><img class="PopcalTrigger" align="absmiddle" src="HelloWorld/calbtn.gif" width="34" height="22" border="0" alt=""></a> </td></tr>
			<tr><td nowrap><label for="CPF" class="requerido">CPF</label></td><td><input type="text" name="CPF" id="CPF" maxlength="14" size="30" value="<%=formatacpf(CPF)%>"></td></tr>
			<tr><td nowrap><label for="EMAIL" class="requerido">e-mail</label></td><td colspan=3><input type="text" name="EMAIL" id="EMAIL" maxlength="200" size="60" value="<%=EMAIL%>"></td></tr>
			<tr><td nowrap><label for="TELEFONECEL" class="requerido">Telefone Celular</label></td><td><input type="text" name="TELEFONECEL" id="TELEFONECEL" maxlength="14" size="20" value="<%=formatatel(TELEFONECEL)%>"></td></tr>
			<tr><td nowrap><label for="TELEFONERES">Telefone Residencial</label></td><td><input type="text" name="TELEFONERES" id="TELEFONERES" maxlength="14" size="20" value="<%=formatatel(TELEFONERES)%>"></td></tr>

			<tr><td nowrap><label for="ENDERECO">Endereço</label></td><td><input type="text" name="ENDERECO" id="ENDERECO" maxlength="150" size="60" value="<%=ENDERECO%>"></td></tr>
			<tr><td><label for="COD_UF_IBGE">UF</label></td><td>
			
			<select name="COD_UF_IBGE" id="COD_UF_IBGE" onchange="GetSelectedEstado(this.value);">
					<option></option>
					<%
					RSSIM.open "SELECT COD_UF_IBGE,SIGLA_UF FROM UF ORDER BY SIGLA_UF"
					while not RSSIM.eof%>
						<option value="<% =RSSIM("COD_UF_IBGE") %>" <%if RSSIM("COD_UF_IBGE")=COD_UF_IBGE then%>selected <%end if%>><% =RSSIM("SIGLA_UF") %></option><%
						RSSIM.movenext
					wend
					RSSIM.Close

					%></select></p></td>			
			</td></tr>
			<tr><td><label for="COD_MUNI_IBGE">Município</label></td><td>
			<select name="COD_MUNI_IBGE"><option></option>
			</select></td></tr>
			
			<tr><td><label for="CEP">CEP</label></td><td><input type="text" name="CEP" id="CEP" maxlength="8" size="10" value="<%=CEP%>" onKeyPress="return ValidateKeyPressed('INT', this, event);"> somente números</td></tr>
			
			<tr><td nowrap>
			<label for="STATUS_PROFESSOR" class="requerido">Status do Professor</label></td><td><select name="STATUS_PROFESSOR" readonly>
			<option value=" "></option>
			<option value="Bloqueado" <% if STATUS_PROFESSOR = "Bloqueado" then%> Selected <% end if %> >Bloqueado</option>
			<option value="Ativo" <% if STATUS_PROFESSOR = "Ativo" then%> Selected <% end if %> >Ativo</option>
			</select>
			</td></tr>
		</table>
		</fieldset>
		<fieldset>
			<legend>formação acadêmica / titulação</legend>
			<table width=100%>
			<tr><td nowrap><label for="COD_ESCOLARIDADE">Escolaridade</label></td><td><%=createSel("COD_ESCOLARIDADE","SELECT COD_ESCOLARIDADE,DESCRICAO FROM ESCOLARIDADE ORDER BY COD_ESCOLARIDADE",COD_ESCOLARIDADE,1,"checkPos()")%></td></tr>
			<tr><td nowrap><label for="FORMACAO">Nome do curso</label></td><td><input type="text" name="FORMACAO" id="FORMACAO" maxlength="250" size="60" value="<%=FORMACAO%>"></td></tr>
			<tr><td nowrap><label for="COD_POS">Pós-graduação</label></td><td><%=createSel("COD_POS","SELECT COD_POS,DESCRICAO FROM POS ORDER BY COD_POS",COD_POS,1,"checkPos()")%></td></tr>
			<tr><td nowrap><label for="POS">Área (especificar)</label></td><td><input type="text" name="POS" id="POS" maxlength="250" size="60" value="<%=POS%>"></td></tr>
			</table>
		</fieldset>
		<fieldset>
			<legend>Temas e Sub-áreas</legend>
			<table width=100%>
			<tr>
				<%
				sql="SELECT ID_TEMA,TEMA FROM TEMAS ORDER BY TEMA"
				rs.Open sql
				%>
				<td Width="20%"><label for="TEMA1" class="requerido">Área 1</label></td><td Width="20%">
				<select name="ID_TEMA1" id="ID_TEMA1" onchange="GetSelectedItem1(this.value);">
					<option></option>
					<%while not RS.eof%>
						<option value="<% =RS("ID_TEMA") %>" <%if RS("ID_TEMA")=ID_TEMA1 then%>selected <%end if%>><% =RS("TEMA") %></option><%
						RS.movenext
					wend
					RS.Close

					%></select></p></td>
				<td Width="20%">
				<label for="ID_SUBTEMA1">Sub-área 1</label></td><td Width="40%">
				<select name="ID_SUBTEMA1" id="ID_SUBTEMA1">
				<option></option>
				</select>
				</td></tr><tr>
				<td Width="20%"></td><td Width="20%"></td><td Width="20%">
				<label for="ID_SUBTEMA2">Sub-área 2</label></td><td Width="40%">
				<select name="ID_SUBTEMA2" id="ID_SUBTEMA2">
				<option></option>
				</select>
				</td></tr>
				<tr><td Width="20%"></td><td Width="20%"></td><td Width="20%">
				<label for="ID_SUBTEMA3">Sub-área 3</label></td><td Width="40%">
				<select name="ID_SUBTEMA3" id="ID_SUBTEMA3">
				<option></option>
				</select>
				</td></tr>
				<tr><td Width="20%"></td><td Width="20%"></td><td Width="20%">
				<label for="ID_SUBTEMA4">Sub-área 4</label></td><td Width="40%">
				<select name="ID_SUBTEMA4" id="ID_SUBTEMA4">
				<option></option>
				</select>
				</td></tr>
			</table>
		</fieldset>
		<fieldset>
			<legend>Temas e Sub-áreas</legend>
			<table width=100%>
			<tr>
				<%
				sql="SELECT ID_TEMA,TEMA FROM TEMAS ORDER BY TEMA"
				rs.Open sql
				%>
				<td Width="20%"><label for="TEMA2">Área 2</label></td><td Width="20%">
				<select name="ID_TEMA2" id="ID_TEMA2" onchange="GetSelectedItem2(this.value);">
					<option></option>
					<%while not RS.eof%>
						<option value="<% =RS("ID_TEMA") %>" <%if RS("ID_TEMA")=ID_TEMA2 then%>selected <%end if%>><% =RS("TEMA") %></option><%
						RS.movenext
					wend
					RS.Close

					%></select></p></td>
				<td Width="20%">
				<label for="ID_SUBTEMA5">Sub-área 1</label></td><td Width="40%">
				<select name="ID_SUBTEMA5" id="ID_SUBTEMA5">
				<option></option>
				</select>
				</td></tr>
				<tr><td Width="20%"></td><td Width="20%"></td><td Width="20%">
				<label for="ID_SUBTEMA6">Sub-área 2</label></td><td Width="40%">
				<select name="ID_SUBTEMA6" id="ID_SUBTEMA6">
				<option></option>
				</select>
				</td></tr>
				<tr><td Width="20%"></td><td Width="20%"></td><td Width="20%">
				<label for="ID_SUBTEMA7">Sub-área 3</label></td><td Width="40%">
				<select name="ID_SUBTEMA7" id="ID_SUBTEMA7">
				<option></option>
				</select>
				</td></tr>
				<tr><td Width="20%"></td><td Width="20%"></td><td Width="20%">
				<label for="ID_SUBTEMA8">Sub-área 4</label></td><td Width="40%">
				<select name="ID_SUBTEMA8" id="ID_SUBTEMA8">
				<option></option>
				</select>
				</td></tr>
			</table>
		</fieldset>		
		<fieldset>
			<legend>Temas e Sub-áreas</legend>
			<table width=100%>
			<tr>
				<%
				sql="SELECT ID_TEMA,TEMA FROM TEMAS ORDER BY TEMA"
				rs.Open sql
				%>
				<td Width="20%"><label for="TEMA3">Área 3</label></td><td Width="20%">
				<select name="ID_TEMA3" id="ID_TEMA3" onchange="GetSelectedItem3(this.value);">
					<option></option>
					<%while not RS.eof%>
						<option value="<% =RS("ID_TEMA") %>" <%if RS("ID_TEMA")=ID_TEMA3 then%>selected <%end if%>><% =RS("TEMA") %></option><%
						RS.movenext
					wend
					RS.Close

					%></select></p></td>
				<td Width="20%">
				<label for="ID_SUBTEMA9">Sub-área 1</label></td><td Width="40%">
				<select name="ID_SUBTEMA9" id="ID_SUBTEMA9">
				<option></option>
				</select>
				</td></tr>
				<tr><td Width="20%"></td><td Width="20%"></td><td Width="20%">
				<label for="ID_SUBTEMA10">Sub-área 2</label></td><td Width="40%">
				<select name="ID_SUBTEMA10" id="ID_SUBTEMA10">
				<option></option>
				</select>
				</td></tr>
				<tr><td Width="20%"></td><td Width="20%"></td><td Width="20%">
				<label for="ID_SUBTEMA11">Sub-área 3</label></td><td Width="40%">
				<select name="ID_SUBTEMA11" id="ID_SUBTEMA11">
				<option></option>
				</select>
				</td></tr>
				<tr><td Width="20%"></td><td Width="20%"></td><td Width="20%">
				<label for="ID_SUBTEMA12">Sub-área 4</label></td><td Width="40%">
				<select name="ID_SUBTEMA12" id="ID_SUBTEMA12">
				<option></option>
				</select>
				</td></tr>
			</table>
		</fieldset>		
		<fieldset>
			<legend>Temas e Sub-áreas</legend>
			<table width=100%>
			<tr>
				<%
				sql="SELECT ID_TEMA,TEMA FROM TEMAS ORDER BY TEMA"
				rs.Open sql
				%>
				<td Width="20%"><label for="TEMA4">Área 4</label></td><td Width="20%">
				<select name="ID_TEMA4" id="ID_TEMA4" onchange="GetSelectedItem4(this.value);">
					<option></option>
					<%while not RS.eof%>
						<option value="<% =RS("ID_TEMA") %>" <%if RS("ID_TEMA")=ID_TEMA4 then%>selected <%end if%>><% =RS("TEMA") %></option><%
						RS.movenext
					wend
					RS.Close

					%></select></p></td>
				<td Width="20%">
				<label for="ID_SUBTEMA13">Sub-área 1</label></td><td Width="40%">
				<select name="ID_SUBTEMA13" id="ID_SUBTEMA13">
				<option></option>
				</select>
				</td></tr>
				<tr><td Width="20%"></td><td Width="20%"></td><td Width="20%">
				<label for="ID_SUBTEMA14">Sub-área 2</label></td><td Width="40%">
				<select name="ID_SUBTEMA14" id="ID_SUBTEMA14">
				<option></option>
				</select>
				</td></tr>
				<tr><td Width="20%"></td><td Width="20%"></td><td Width="20%">
				<label for="ID_SUBTEMA15">Sub-área 3</label></td><td Width="40%">
				<select name="ID_SUBTEMA15" id="ID_SUBTEMA15">
				<option></option>
				</select>
				</td></tr>
				<tr><td Width="20%"></td><td Width="20%"></td><td Width="20%">
				<label for="ID_SUBTEMA16">Sub-área 4</label></td><td Width="40%">
				<select name="ID_SUBTEMA16" id="ID_SUBTEMA16">
				<option></option>
				</select>
				</td></tr>
			</table>
		</fieldset>		
		<fieldset>
			<legend>Temas e Sub-áreas</legend>
			<table width=100%>
			<tr>
				<%
				sql="SELECT ID_TEMA,TEMA FROM TEMAS ORDER BY TEMA"
				rs.Open sql
				%>
				<td Width="20%"><label for="TEMA5">Área 5</label></td><td Width="20%">
				<select name="ID_TEMA5" id="ID_TEMA5" onchange="GetSelectedItem5(this.value);">
					<option></option>
					<%while not RS.eof%>
						<option value="<% =RS("ID_TEMA") %>" <%if RS("ID_TEMA")=ID_TEMA5 then%>selected <%end if%>><% =RS("TEMA") %></option><%
						RS.movenext
					wend
					RS.Close

					%></select></p></td>
				<td Width="20%">
				<label for="ID_SUBTEMA17">Sub-área 1</label></td><td Width="40%">
				<select name="ID_SUBTEMA17" id="ID_SUBTEMA17">
				<option></option>
				</select>
				</td></tr>
				<tr><td Width="20%"></td><td Width="20%"></td><td Width="20%">
				<label for="ID_SUBTEMA18">Sub-área 2</label></td><td Width="40%">
				<select name="ID_SUBTEMA18" id="ID_SUBTEMA18">
				<option></option>
				</select>
				</td></tr>
				<tr><td Width="20%"></td><td Width="20%"></td><td Width="20%">
				<label for="ID_SUBTEMA19">Sub-área 3</label></td><td Width="40%">
				<select name="ID_SUBTEMA19" id="ID_SUBTEMA19">
				<option></option>
				</select>
				</td></tr>
				<tr><td Width="20%"></td><td Width="20%"></td><td Width="20%">
				<label for="ID_SUBTEMA20">Sub-área 4</label></td><td Width="40%">
				<select name="ID_SUBTEMA20" id="ID_SUBTEMA20">
				<option></option>
				</select>
				</td></tr>
			</table>
		</fieldset>		
		<fieldset>
			<legend>Temas e Sub-áreas</legend>
			<table width=100%>
			<tr>
				<%
				sql="SELECT ID_TEMA,TEMA FROM TEMAS ORDER BY TEMA"
				rs.Open sql
				%>
				<td Width="20%"><label for="TEMA6">Área 6</label></td><td Width="20%">
				<select name="ID_TEMA6" id="ID_TEMA6" onchange="GetSelectedItem6(this.value);">
					<option></option>
					<%while not RS.eof%>
						<option value="<% =RS("ID_TEMA") %>" <%if RS("ID_TEMA")=ID_TEMA6 then%>selected <%end if%>><% =RS("TEMA") %></option><%
						RS.movenext
					wend
					RS.Close

					%></select></p></td>
				<td Width="20%">
				<label for="ID_SUBTEMA21">Sub-área 1</label></td><td Width="40%">
				<select name="ID_SUBTEMA21" id="ID_SUBTEMA21">
				<option></option>
				</select>
				</td></tr>
				<tr><td Width="20%"></td><td Width="20%"></td><td Width="20%">
				<label for="ID_SUBTEMA22">Sub-área 2</label></td><td Width="40%">
				<select name="ID_SUBTEMA22" id="ID_SUBTEMA22">
				<option></option>
				</select>
				</td></tr>
				<tr><td Width="20%"></td><td Width="20%"></td><td Width="20%">
				<label for="ID_SUBTEMA23">Sub-área 3</label></td><td Width="40%">
				<select name="ID_SUBTEMA23" id="ID_SUBTEMA23">
				<option></option>
				</select>
				</td></tr>
				<tr><td Width="20%"></td><td Width="20%"></td><td Width="20%">
				<label for="ID_SUBTEMA24">Sub-área 4</label></td><td Width="40%">
				<select name="ID_SUBTEMA24" id="ID_SUBTEMA24">
				<option></option>
				</select>
				</td></tr>
			</table>
		</fieldset>		
		<fieldset>
			<legend>Disponibilidade</legend>
				<table border =0 width=50% align=center>
					<tr><td></td><td><label>Manhã</label></td><td><label class="titulo1">Tarde</label></td><td><label class="titulo1">Noite</label></td></tr>
					<tr>
						<td><label>Domingo</label></td>
						<td><label><input type="checkbox" value="1" name="DOMINGOM" <% if DOMINGOM="1" then%>checked<%end if%>></label></td>
						<td><label><input type="checkbox" value="1" name="DOMINGOT" <% if DOMINGOT="1" then%>checked<%end if%>></label></td>
						<td><label><input type="checkbox" value="1" name="DOMINGON" <% if DOMINGON="1" then%>checked<%end if%>></label></td>
					</tr>
					<tr>
						<td nowrap><label>Segunda-feira</label></td>
						<td><label><input type="checkbox" value="1" name="SEGUNDAM" <% if SEGUNDAM="1" then%>checked<%end if%>></label></td>
						<td><label><input type="checkbox" value="1" name="SEGUNDAT" <% if SEGUNDAT="1" then%>checked<%end if%>></label></td>
						<td><label><input type="checkbox" value="1" name="SEGUNDAN" <% if SEGUNDAN="1" then%>checked<%end if%>></label></td>
					</tr>
					<tr>
						<td><label>Terça-feira</label></td>
						<td><label><input type="checkbox" value="1" name="TERCAM" <% if TERCAM="1" then%>checked<%end if%>></label></td>
						<td><label><input type="checkbox" value="1" name="TERCAT" <% if TERCAT="1" then%>checked<%end if%>></label></td>
						<td><label><input type="checkbox" value="1" name="TERCAN" <% if TERCAN="1" then%>checked<%end if%>></label></td>
					</tr>
					<tr>
						<td><label>Quarta-feira</label></td>
						<td><label><input type="checkbox" value="1" name="QUARTAM" <% if QUARTAM="1" then%>checked<%end if%>></label></td>
						<td><label><input type="checkbox" value="1" name="QUARTAT" <% if QUARTAT="1" then%>checked<%end if%>></label></td>
						<td><label><input type="checkbox" value="1" name="QUARTAN" <% if QUARTAN="1" then%>checked<%end if%>></label></td>
					</tr>
					<tr>
						<td><label>Quinta-feira</label></td>
						<td><label><input type="checkbox" value="1" name="QUINTAM" <% if QUINTAM="1" then%>checked<%end if%>></label></td>
						<td><label><input type="checkbox" value="1" name="QUINTAT" <% if QUINTAT="1" then%>checked<%end if%>></label></td>
						<td><label><input type="checkbox" value="1" name="QUINTAN" <% if QUINTAN="1" then%>checked<%end if%>></label></td>
					</tr>
					<tr>
						<td><label>Sexta-feira</label></td>
						<td><label><input type="checkbox" value="1" name="SEXTAM" <% if SEXTAM="1" then%>checked<%end if%>></label></td>
						<td><label><input type="checkbox" value="1" name="SEXTAT" <% if SEXTAT="1" then%>checked<%end if%>></label></td>
						<td><label><input type="checkbox" value="1" name="SEXTAN" <% if SEXTAN="1" then%>checked<%end if%>></label></td>
					</tr>
					<tr>
						<td><label>Sabado</label></td>
						<td><label><input type="checkbox" value="1" name="SABADOM" <% if SABADOM="1" then%>checked<%end if%>></label></td>
						<td><label><input type="checkbox" value="1" name="SABADOT" <% if SABADOT="1" then%>checked<%end if%>></label></td>
						<td><label><input type="checkbox" value="1" name="SABADON" <% if SABADON="1" then%>checked<%end if%>></label></td>
					</tr>
				</table>
		</fieldset>	
		<fieldset>
			<legend>Curriculo</legend>
			<table width=100%>
				
			</td></tr>
				<tr><td colspan=6><p><label for="MINICURRICULO">Mini Curriculo</label><textarea name="MINICURRICULO" cols="80" rows="6"><%=MINICURRICULO%></textarea></p></td></tr>
			</table>
			<br><br>
			<input type="hidden" value="<%=GUID_PROF%>" name="id">
<%
   'Option Explicit
   On Error Resume Next

   ' Declara as variáveis
 
   Do While Instr(strTemp,"/")
      strPath = strPath & Left(strTemp,Instr(strTemp,"/"))
      strTemp = Mid(strTemp,Instr(strTemp,"/")+1)      
   Loop
 
   strPath = "/sistemas/ronaldo/adm/curriculos/" 
   
   ' Configura o título da página
   strServerName = UCase(Request.ServerVariables("SERVER_NAME"))
   strTitle = "Lista dos Arquivos " & strPath & " folder"
 
   ' cria os objetos do sistema de arquivos
   strPhysicalPath = Server.MapPath(strPath)
   Set objFSO = Server.CreateObject("Scripting.FileSystemObject")
   Set objFolder = objFSO.GetFolder(strPhysicalPath)
   ''''''''''''''''''''''''''''''''''''''''
   ' imprimir a lista de pastas
   ''''''''''''''''''''''''''''''''''''''''
 
   Set objCollection = objFolder.SubFolders
 
   For Each objItem in objCollection
      strName = objItem.Name
      strAttr = MakeAttr(objItem.Attributes)      
      dtmDate = CDate(objItem.DateLastModified)
	Next
 
   ''''''''''''''''''''''''''''''''''''''''
   ' imprimir a lista de arquivos
   ''''''''''''''''''''''''''''''''''''''''
 
   Set objCollection = objFolder.Files
 
   For Each objItem in objCollection
      strName = objItem.Name
      strFile = Server.HTMLEncode(Lcase(strName))
 
      intSizeB = objItem.Size
      intSizeK = Int((intSizeB/1024) + .5)
      If intSizeK = 0 Then intSizeK = 1
 
      strAttr = MakeAttr(objItem.Attributes)
      'strName = Ucase(objItem.ShortName)
      If Instr(strName,".") Then strExt = Right(strName,Len(strName)-Instr(strName,".")) Else strExt = ""
      dtmDate = CDate(objItem.DateLastModified)
		if mid(strName,1,46)=GUID_PROF&"_minicurriculo" then
			str_minicurriculo = "<a href="&strPath&strFile&">"&strName&"</a>"
		end if
		if mid(strName,1,42)=GUID_PROF&"_curriculo" then
			str_curriculo = "<a href="&strPath&strFile&">"&strName&"</a>"
		end if
		if mid(strName,1,37)=GUID_PROF&"_foto" then
			str_foto = "<a href="&strPath&strFile&">"&strName&"</a>"
			foto = strPath&strFile
		end if
	Next
   Set objFSO = Nothing
   Set objFolder = Nothing
 
   ' Adiciona a função IIf () para VBScript
   Function IIf(i,j,k)
      If i Then IIf = j Else IIf = k
   End Function
 
   ' esta função cria uma seqüência dos atributos dos arquivos
   Function MakeAttr(intAttr)
      MakeAttr = MakeAttr & IIf(intAttr And vbArchive,"A","-")
      MakeAttr = MakeAttr & IIf(intAttr And vbSystem,"S","-")
      MakeAttr = MakeAttr & IIf(intAttr And vbHidden,"H","-")
      MakeAttr = MakeAttr & IIf(intAttr And vbReadOnly,"R","-")
   End Function
%>
	<table width="100%">
	<tr><td width="70%">	
		<li><a href="javascript:window.open('../library/arquivoUploadProf.asp?tipo=minicurriculo&id=<%=GUID_PROF%>','','width=300,height=200');void(0);">Mini-curriculo - <% if str_minicurriculo="" then %> Clique aqui para fazer upload do arquivo»</a><%else%><%=str_minicurriculo%><%end if %></li><br><br>
		<li><a href="javascript:window.open('../library/arquivoUploadProf.asp?tipo=curriculo&id=<%=GUID_PROF%>','','width=300,height=200');void(0);">Curriculo  - <% if str_curriculo="" then %> Clique aqui para fazer upload do arquivo»</a><%else%><%=str_curriculo%><%end if %></li><br><br>
		<li><a href="javascript:window.open('../library/arquivoUploadProf.asp?tipo=foto&id=<%=GUID_PROF%>','','width=300,height=200');void(0);">Foto  - <% if str_foto="" then %> Clique aqui para fazer upload do arquivo»</a><%else%><%=str_foto%><%end if %></li><br><br>
	</tr>
	</table>
			<tr><td><br /><label for="submit">&nbsp;</label>
			<input type="submit" name="submit" value="Enviar" class="buttonF"><br /><br /></td></tr>
		

		</fieldset>
		</form>
		<br />
		<ul>
			<li>Os campos marcados em laranja são obrigatórios</li>
		</ul>
		<br />
	</div>	
</div>
<iframe width=174 height=189 name="gToday:normal:agenda.js" id="gToday:normal:agenda.js" src="HelloWorld/ipopeng.htm" scrolling="no" frameborder="0" style="visibility:visible; z-index:999; position:absolute; top:-500px; left:-500px;">
</iframe>

</body>
</html>
<%conClose%>
