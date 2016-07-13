<HTML>
<HEAD>
<TITLE>AspPDF User Manual Chapter 14: Structured Text Extraction</TITLE>
</HEAD>
<BODY>


<%

	Set Pdf = Server.CreateObject("Persits.Pdf")
    Set Doc = PDF.OpenDocument( Server.MapPath("population.pdf"))
    Set Page = doc.Pages(1)
    Set Preview = Page.ToImage("extracttext=7") ' sort/glue
    
    Page.Canvas.LineWidth = 0.5
    Page.Canvas.SetFillColor 1, 0, 0    
    
    Dim i: i = 1
    
    For Each rect In Preview.TextItems
        Page.Canvas.SetColor 1, 0, 0
        Page.Canvas.SetFillColor 1, 0, 0
        
		' Red outline
		Page.Canvas.DrawRect rect.Left, rect.Bottom, rect.Width, rect.Height 
        
        'Small box on top to display count
        Page.Canvas.FillRect rect.Left, rect.Top, 10, 5
        Page.Canvas.DrawRect rect.Left, rect.Top, 10, 5      
        Page.Canvas.DrawText i, "x=" & rect.Left + 1 & "; y=" & rect.Top + 6 & ";color=white; size=5", Doc.Fonts("Helvetica")
        
        i = i + 1
    Next
    
    Filename = Doc.Save( Server.MapPath("extracttext.pdf"), False )

	Response.Write "Success! Download your PDF file <A HREF=" & Filename & ">here</A>"

%>

</BODY>
</HTML>
