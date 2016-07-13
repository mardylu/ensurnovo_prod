<HTML>
<HEAD>
<TITLE>AspPDF User Manual Chapter 16: IE-based HTML-to-PDF Conversion, Sample 1</TITLE>
</HEAD>
<BODY>

<%
	Set Pdf = Server.CreateObject("Persits.Pdf")

	' Create empty document
	Set Doc = Pdf.CreateDocument

	' Add a new page
	Set Page = Doc.Pages.Add

	' Convert www.persits.com to image
	Set Image = Doc.OpenUrl( "http://www.persits.com" )

	' Shrink as needed to fit width
	Scale = Page.Width / Image.Width

	' Align image top with page top
	Y = Page.Height - Image.Height * Scale
	
	' Draw image
	Set Param = Pdf.CreateParam
	Param("x") = 0
	Param("y") = Y
	Param("ScaleX") = Scale
	Param("ScaleY") = Scale
	Page.Canvas.DrawImage Image, Param

	' Save document, the Save method returns generated file name
	Filename = Doc.Save( Server.MapPath("iehtmltopdf.pdf"), False )

	Response.Write "Success! Download your PDF file <A HREF=" & Filename & ">here</A>"
%>

</BODY>
</HTML>
