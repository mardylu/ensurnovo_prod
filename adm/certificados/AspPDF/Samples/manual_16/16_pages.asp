<HTML>
<HEAD>
<TITLE>AspPDF User Manual Chapter 16: IE-based HTML-to-PDF Conversion, Sample 2</TITLE>
</HEAD>
<BODY>

<%
	Set Pdf = Server.CreateObject("Persits.Pdf")

	' Create empty document
	Set Doc = Pdf.CreateDocument

	Set Param = Pdf.CreateParam

	' Convert URL to image
	Set Image = Doc.OpenUrl( "http://support.persits.com/default.asp?displayall=1", "AspectRatio=0.7727" )

	' Iterate through all images
	While Not Image Is Nothing
		' Add a new page
		Set Page = Doc.Pages.Add

		' Compute scale based on image width and page width
		Scale = Page.Width / Image.Width

		' Draw image
		Param("x") = 0
		Param("y") = Page.Height - Image.Height * Scale
		Param("ScaleX") = Scale
		Param("ScaleY") = Scale
		Page.Canvas.DrawImage Image, Param

		' Go to next image
		Set Image = Image.NextImage
	Wend
	
	' Save document, the Save method returns generated file name
	Filename = Doc.Save( Server.MapPath("pages.pdf"), False )

	Response.Write "Success! Download your PDF file <A HREF=" & Filename & ">here</A>"
%>

</BODY>
</HTML>
