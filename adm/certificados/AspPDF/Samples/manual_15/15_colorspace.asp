<HTML>
<HEAD>
<TITLE>AspPDF User Manual Chapter 15: Color Spaces</TITLE>
</HEAD>
<BODY>


<%

	Set Pdf = Server.CreateObject("Persits.Pdf")
	Set Doc = Pdf.CreateDocument
	
	Set Page = Doc.Pages.Add

	' Create some color spaces
	Set csICC = Doc.CreateColorSpace( "ICCBased", "N=3" )
	csICC.LoadDataFromFile Server.MapPath( "AdobeRGB1998.icc" )

	' Draw an image with the default color space, and the same image with an ICC profile
	Set Image = Doc.OpenImage( Server.MapPath( "apple.jpg" ) )
	Page.Canvas.DrawImage Image, "x=20; y=600; scalex=0.5, scaley=0.5"
	Page.Canvas.DrawText "Without a profile", "x=20; y=595", Doc.Fonts("Helvetica")

	Set Image2 = Doc.OpenImage( Server.MapPath( "apple.jpg" ) )
	Image2.SetColorSpace csICC
	Page.Canvas.DrawImage Image2, "x=240; y=600; scalex=0.5, scaley=0.5"
	Page.Canvas.DrawText "With an ICC profile", "x=240; y=595", Doc.Fonts("Helvetica")

	' grayscale color space
	Set csGray = doc.CreateColorSpace("DeviceGray")

	DrawBars 300, csGray, "Default Grayscale"

	Set Func = doc.CreateFunction("type=0; Dmin1=0;Dmax1=1; Rmin1=0;Rmax1=1; Size1=5; BitsPerSample=8")
	Func.SetSampleData Array(0, 32, 64, 128, 255)	
	Set csSep = doc.CreateColorSpace("Separation")
	csSep.SetSeparationParams "PANTONE 4525 C", csGray, Func

	DrawBars 180, csSep, "Grayscale based on a sampled function"

	' Calibrated Gray
	Set csCalGray = doc.CreateColorSpace("CalGray", "Xw=0.7; Yw=1; Zw=1.3")
	DrawBars 60, csCalGray, "Calibrated Grayscale"

	Filename = Doc.Save( Server.MapPath( "colorspace.pdf" ), False )

	Response.Write "Success! Download your PDF file <A HREF=" & Filename & ">here</A>"


	Sub DrawBars( YCoord, ColorSpace, Title )

		' stroking colors: for bar borders
		Page.Canvas.SetColorEx "c1=0"
		Page.Canvas.LineWidth = 5

		Page.Canvas.SetFillColorSpace ColorSpace

		For c = 0 to 1 step 0.1

			Page.Canvas.SetFillColorEx "c1=" & c
			
			Page.Canvas.DrawRect 20 + c * 500, YCoord, 50, 100
			Page.Canvas.FillRect 20 + c * 500, YCoord, 50, 100
		Next

		Page.Canvas.DrawText Title, "x=20; y=" & YCoord + 10, Doc.Fonts("Helvetica")

	End Sub
%>

</BODY>
</HTML>
