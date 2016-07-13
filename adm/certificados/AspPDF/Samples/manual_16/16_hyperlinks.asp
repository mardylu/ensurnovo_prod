<HTML>
<HEAD>
<TITLE>AspPDF User Manual Chapter 16: IE-based HTML-to-PDF Conversion, Sample 3</TITLE>
</HEAD>
<BODY>

<%

	Set Pdf = Server.CreateObject("Persits.Pdf")

	' Create empty document
	Set Doc = Pdf.CreateDocument

	' Parameter object for image drawing
	Set Param = Pdf.CreateParam

	' Parameter object for hyperlink annotation drawing
    Set HyperlinkParam = PDF.CreateParam
    HyperlinkParam.Set "Type = link"

	' Convert URL to image. Enable hyperlinks. Use hemming.
	Set Image = Doc.OpenUrl( "http://support.persits.com/default.asp?displayall=1", _
		"AspectRatio=0.7727; hyperlinks=true; hem=50; hemcolor=white" )

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

		' Now draw hyperlinks from the Image.Hyperlinks collection
        For Each Rect In Image.Hyperlinks
            HyperlinkParam("x") = Rect.Left * Scale
			' Y-coordinate must be lifted by the same amount as the image itself
            HyperlinkParam("y") = Rect.Bottom * Scale + Param("y")
            HyperlinkParam("width") = Rect.Width * Scale
            HyperlinkParam("height") = Rect.Height * Scale
            HyperlinkParam("border") = 0
            
			' Create link annotation
			Set Annot = Page.Annots.Add("", HyperlinkParam)
            Annot.SetAction Doc.CreateAction("type=URI", Rect.Text)
        Next

		' Go to next image
		Set Image = Image.NextImage
	Wend
	
	' Save document, the Save method returns generated file name
	Filename = Doc.Save( Server.MapPath("hyperlinks.pdf"), False )

	Response.Write "Success! Download your PDF file <A HREF=" & Filename & ">here</A>"

%>

</BODY>
</HTML>
