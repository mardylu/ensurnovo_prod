<!-- #INCLUDE FILE="../library/parametros.asp" -->
<!-- #INCLUDE FILE="../../library/conOpen.asp" -->
<!-- #INCLUDE FILE="../../library/conOpenSIM.asp" -->
<!-- #INCLUDE FILE="../../library/fErroMsg.asp" -->
<!-- #INCLUDE FILE="../../library/fCreateSel.asp" -->
<!-- #INCLUDE FILE="../../library/fAddZero.asp" -->
<!-- #INCLUDE FILE="../../library/fFormataData.asp" -->
<!-- #INCLUDE FILE="../../library/fData.asp" -->
<!-- #INCLUDE FILE="../../library/fFormataCPF.asp" -->
<!-- #INCLUDE FILE="../../library/fFormataCep.asp" -->
<!-- #INCLUDE FILE="../../library/guid.asp" -->

<%
planilha = request("planilha")


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


' obter o caminho URL da atual pasta
strTemp = Mid(Request.ServerVariables("URL"),2)
strPath = ""

Do While Instr(strTemp,"/")
  strPath = strPath & Left(strTemp,Instr(strTemp,"/"))
  strTemp = Mid(strTemp,Instr(strTemp,"/")+1)
Loop

strPath = "/adm/curriculos/"

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

	<!-- /TinyMCE -->
	<script type="text/javascript" src="../js/validacao_pb.js"></script>
	<script type="text/javascript" src="../js/municipios.js"></script>
	<script type="text/javascript" src="../js/mascara.js"></script>

	<title>ENSUR Inscrições</title>
</head>

<body>

<div id="pagina">

		<fieldset>
			<legend>Curriculo</legend>
			<table width=100% border="1">

			</td></tr>
				<tr><td colspan=6><p><label for="MINICURRICULO">Mini Curriculo</label><textarea name="MINICURRICULO" cols="60" rows="6"  maxlength="250"><%=MINICURRICULO%></textarea></p></td></tr>
			</table>
			<br><br>
			<input type="hidden" value="<%=GUID_PROF%>" name="id">
			<input type="hidden" value="<%=session("id")%>" name="cod">
<%
   'Option Explicit
   On Error Resume Next

   ' Declara as variáveis
 
   Do While Instr(strTemp,"/")
      strPath = strPath & Left(strTemp,Instr(strTemp,"/"))
      strTemp = Mid(strTemp,Instr(strTemp,"/")+1)      
   Loop
 
'  strPath = "/sistemas/ronaldo/adm/curriculos/"
   strPath = "/adm/curriculos/"

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
<!----  <li><a href="javascript:window.open('../library/arquivoUploadProf.asp?tipo=minicurriculo&id=<%=GUID_PROF%>','','width=300,height=200');void(0);">Mini-curriculo - <% if str_minicurriculo="" then %> Clique aqui para fazer upload do arquivo»</a><%else%><%=str_minicurriculo%><%end if %></li><br><br>  ---->
<!----  <li><a href="javascript:window.open('../library/arquivoUploadProf.asp?tipo=foto&id=<%=GUID_PROF%>','','width=300,height=200');void(0);">Foto  - <%=str_foto%> - <% if str_foto="" then %> Clique aqui para fazer upload do arquivo»</a><%else%><%=str_foto%><%end if %></li><br><br>---->
	<li><a href="javascript:window.open('../library/arquivoUploadProf.asp?tipo=curriculo&id=<%=GUID_PROF%>','','width=300,height=200');void(0);">Curriculo  - <% if str_curriculo="" then %> Clique aqui para fazer upload do arquivo»</a><%else%><%=str_curriculo%><%end if %></li><br><br>
 	<li>Foto: <%=str_foto%> - <a href="javascript:window.open('../library/arquivoUploadProf.asp?tipo=foto&id=<%=GUID_PROF%>','','width=400,height=300');void(0);">Clique aqui para trocar ou fazer o upload da foto »»»</a></li><br><br>
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

</body>
</html>
<%conClose%>
