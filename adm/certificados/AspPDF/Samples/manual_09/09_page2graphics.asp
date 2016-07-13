<HTML>
<HEAD>
<TITLE>AspPDF User Manual Chapter 9: Page-to-Graphics Sample</TITLE>
</HEAD>
<BODY>

<%
	Set Pdf = Server.CreateObject("Persits.Pdf")

	' Create a new document
	Set Doc = Pdf.CreateDocument
	Set Page = Doc.Pages.Add

	' Open existing PDF
	Set AnotherDoc = Pdf.OpenDocument( Server.MapPath("1040es.pdf") )

	' Turn page 1 into a PdfGraphics object
	Set Graphics = Doc.CreateGraphicsFromPage( AnotherDoc, 1 )

	' Draw on this document several times

	Page.Canvas.DrawGraphics Graphics, "x=10; y=500; scalex=0.3; scaley=0.3"
	Page.Canvas.DrawGraphics Graphics, "x=180; y=600; scalex=0.2; scaley=0.2; angle=-30"
	Page.Canvas.DrawGraphics Graphics, "x=300; y=550; scalex=0.1; scaley=0.1; angle=-60"


	' Save document, the Save method returns generated file name
	Filename = Doc.Save( Server.MapPath("page2graphics.pdf"), False )

	Response.Write "Success! Download your PDF file <A HREF=" & Filename & ">here</A>"
%>

</BODY>
</HTML>
