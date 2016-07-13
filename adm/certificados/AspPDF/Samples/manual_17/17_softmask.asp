<HTML>
<HEAD>
<TITLE>AspPDF User Manual Chapter 17: Soft Masks</TITLE>
</HEAD>
<BODY>

<%
Set PDF = Server.CreateObject("Persits.PDF")
Set Doc = PDF.CreateDocument
Set Page = Doc.Pages.Add

' Main Logo
Set Logo = Doc.CreateGraphics("left=0; bottom=0; right=128; top=206")
With Logo.Canvas
    .SetParams ("FillColor=#313570")
    .MoveTo 6, 177
    .LineTo 48, 201
    .LineTo 113, 162
    .LineTo 113, 86
    .LineTo 70, 62
    .LineTo 70, 137
    .ClosePath
    .Fill
    
    .SetParams ("FillColor=#5B88B1")
    .MoveTo 61, 5
    .LineTo 61, 130
    .LineTo 20, 106
    .LineTo 20, 30
    .ClosePath
    .Fill
End With

' Transparency group to be used with the soft mask
Set Group = doc.CreateGState("Group=true")
' Required as we use luminocity for soft mask
Group.SetColorSpace Doc.CreateColorSpace("DeviceRGB")

' Soft mask based on an image to be used as alpha
Set Image = Doc.OpenImage(Server.MapPath("17_alpha.png"))
Set SM = Doc.CreateGraphics("left=0; bottom=0; right=128; top=206")
SM.Canvas.DrawImage Image, "x=0; y=0"

' Associate the soft mask with a transparency group
SM.SetGroup Group

' Drop Shadow. Uses GState object with a soft mask
Set GState = Doc.CreateGState("fillalpha=0.5")
GState.SetSoftMask SM, "alpha=false"
Set Shadow = Doc.CreateGraphics("left=0; bottom=0; right=128; top=206")
With Shadow.Canvas
    .SetGState GState
    .SetFillColor 0.2, 0.2, 0.2 ' gray
    .FillRect 0, 0, 128, 206
End With

' Draw shadow with an offset
Page.Canvas.DrawGraphics Shadow, "x=110; y=490"

' Draw logo
Page.Canvas.DrawGraphics Logo, "x=100; y=500"

' Save document, the Save method returns generated file name
Filename = Doc.Save( Server.MapPath("dropshadow.pdf"), False )
Response.Write "Success! Download your PDF file <A HREF=" & Filename & ">here</A>"

%>

</BODY>
</HTML>
