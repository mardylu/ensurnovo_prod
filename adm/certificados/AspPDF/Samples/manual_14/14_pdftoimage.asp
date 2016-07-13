<%
	' AspPDF User Manual Chapter 14: PDF to Image Sample
	' This script calls SaveHttp and therefore cannot contain any HTML tag.


	Set Pdf = Server.CreateObject("Persits.Pdf")
	Set Doc = Pdf.CreateDocument
	Doc.ImportFromUrl "http://www.aspupload.com", "landscape=true"

	' Save and reopen as Page.Preview only works on new documents.
	Set NewDoc = Pdf.OpenDocumentBinary( Doc.SaveToMemory )

	' Create preview for Page 1 at 50% scale.
	Set Page = NewDoc.Pages(1)
	Set Preview = Page.ToImage("ResolutionX=36; ResolutionY=36" )

	Preview.SaveHttp( "filename=preview.png" )
%>