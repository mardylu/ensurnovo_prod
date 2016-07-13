<HTML>
<HEAD>
<TITLE>AspPDF User Manual Chapter 15: Using Color Spaces with Tables</TITLE>
</HEAD>
<BODY>


<%

	Set Pdf = Server.CreateObject("Persits.Pdf")
	Set Doc = Pdf.CreateDocument
	
	Set Page = Doc.Pages.Add

	' Create an ICC color space
	Set csICC = Doc.CreateColorSpace( "ICCBased", "N=3" )
	csICC.LoadDataFromFile Server.MapPath( "AdobeRGB1998.icc" )

	Set Table = doc.CreateTable("rows=2; cols=3; width=400; height=300; border=10; cellborder=5; cellspacing=10; cellpadding=2")
	Table.Font = Doc.Fonts("Helvetica")
    
    ' Border color
    Table.SetColor "Type=1; ColorSpace=" & csICC.Index & "; c1=1; c2=0.5; c3=0.2"
    
    ' Cell Border Color
    Table.SetColor "Type=2; ColorSpace=" & csICC.Index & "; c1=0; c2=0; c3=1"
    
    ' BG Color
    Table.SetColor "Type=3; ColorSpace=" & csICC.Index & "; c1=1; c2=1; c3=0"
    
    ' Cell BG Color
    Table.SetColor "Type=4; ColorSpace=" & csICC.Index & "; c1=0; c2=1; c3=0"
    

	' Border color for individual cell
	Table(1, 1).SetColor "Type=2; ColorSpace=" & csICC.Index & "; c1=1; c2=0; c3=1"

	' Draw text, use the same color space for it
	Table(1, 1).AddText "Test", "ColorSpace=" & csICC.Index & ";c1=0.2; c2=0.4; c3=0.3"

	' Render table
	Page.Canvas.DrawTable Table, "x=106; y=700"

	Filename = Doc.Save( Server.MapPath( "cs_table.pdf" ), False )

	Response.Write "Success! Download your PDF file <A HREF=" & Filename & ">here</A>"

%>

</BODY>
</HTML>
