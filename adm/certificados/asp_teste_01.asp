
<%

Set Pdf = Server.CreateObject("Persits.Pdf")
Set Doc = Pdf.CreateDocument

Doc.Title = "AspPDF Chapter 3 Hello World Sample"
Doc.Creator = "John Smith"

Set Page = Doc.Pages.Add

Set Font = Doc.Fonts("Helvetica")

Params = "x=0; y=650; width=612; alignment=center; size=50"
Page.Canvas.DrawText "Hello World!", Params, Font

Filename = Doc.Save( Server.MapPath("hello.pdf"), False )

Response.Write "Success! Download your PDF file <A HREF=" & Filename & ">here</A>"


%>

