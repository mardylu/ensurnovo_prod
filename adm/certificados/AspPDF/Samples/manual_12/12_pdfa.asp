<HTML>
<HEAD>
<TITLE>AspPDF User Manual Chapter 12: Creating a PDF/A-Compliant Document</TITLE>
</HEAD>
<BODY>

<%

	Set PDF = Server.CreateObject("Persits.PDF")
	Set Doc = PDF.CreateDocument

	' Convert HTML to PDF
	Doc.ImportFromUrl "http://www.asppdf.com", "landscape=true; scale=0.75"

	' Add metadata from a file
	strMetadata = PDF.LoadTextFromFile( Server.MapPath("metadata.txt") )

	' Replace placeholder with actual document title
	strMetadata = Replace( strMetadata, "@@@title@@@", Doc.Title )

	Doc.MetaData = strMetadata

	' Add output intent using an RGB color profile. Borrow .icc file from Chapter 15
	strProfilePath = Server.MapPath(".") & "\..\manual_15\AdobeRGB1998.icc"
	Doc.AddOutputIntent "AdobeRGB", "Custom", strProfilePath, 3

	'Save document
	Path = Server.MapPath( "pdfa.pdf")
	FileName = Doc.Save( Path, false)

	Response.Write "Success! Download your PDF file <A TARGET=""_new"" HREF=" & Filename & ">here</A>"
%>

</BODY>
</HTML>
