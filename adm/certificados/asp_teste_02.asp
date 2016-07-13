
<%

Set Pdf = Server.CreateObject("Persits.Pdf")
Set Doc = Pdf.CreateDocument
Set Page = Doc.Pages.Add

Set Image = Doc.OpenImage( Server.MapPath( "certificadofrente.jpg") )

Set Param = Pdf.CreateParam

For i = 1 To 3
   Param("x") = (Page.Width - Image.Width / i) / 2
   Param("y") = Page.Height - Image.Height * i / 2 - 200
   Param("ScaleX") = 1 / i
   Param("ScaleY") = 1 / i

   Page.Canvas.DrawImage Image, Param
Next

Filename = Doc.Save( Server.MapPath("image.pdf"), False )


%>

