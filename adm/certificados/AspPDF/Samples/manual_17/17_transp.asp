<HTML>
<HEAD>
<TITLE>AspPDF User Manual Chapter 17: Transparency</TITLE>
</HEAD>
<BODY>


<%
' Common part: draw background
Set PDF = Server.CreateObject("Persits.PDF")
Set Doc = PDF.CreateDocument
Set Page = Doc.Pages.Add
Page.Canvas.SetFillColor 0.8, 0.8, 0.8
Page.Canvas.FillRect 0, 0, page.width / 2, page.height
Page.Canvas.SetFillColor 1, 1, 1
Page.Canvas.FillRect page.width / 2, 0, page.width, page.height

Page.Canvas.SaveState
Page.Canvas.SetCTM 1, 0, 0, 1, 206, 600
Call UpperLeft
Page.Canvas.RestoreState

Page.Canvas.SaveState
Page.Canvas.SetCTM 1, 0, 0, 1, 206, 400
Call UpperRight
Page.Canvas.RestoreState

Page.Canvas.SaveState
Page.Canvas.SetCTM 1, 0, 0, 1, 206, 200
Call LowerLeft
Page.Canvas.RestoreState

Page.Canvas.SaveState
Page.Canvas.SetCTM 1, 0, 0, 1, 206, 0
Call LowerRight
Page.Canvas.RestoreState

' Save document, the Save method returns generated file name
Filename = Doc.Save( Server.MapPath("transp.pdf"), False )
Response.Write "Success! Download your PDF file <A HREF=" & Filename & ">here</A>"

' Upper-left: no grouping or transparency
Sub UpperLeft
    Set Circ1 = Doc.CreateGraphics("left=0; bottom=0; right=100; top=100")
    Circ1.Canvas.SetFillColor 1, 0, 0
    Circ1.Canvas.FillEllipse 50, 50, 50, 50
    
    Set Circ2 = Doc.CreateGraphics("left=0; bottom=0; right=100; top=100")
    Circ2.Canvas.SetFillColor 1, 1, 0
    Circ2.Canvas.FillEllipse 50, 50, 50, 50
    
    Set Circ3 = Doc.CreateGraphics("left=0; bottom=0; right=100; top=100")
    Circ3.Canvas.SetFillColor 0, 0, 1
    Circ3.Canvas.FillEllipse 50, 50, 50, 50

	Set Graph = Doc.CreateGraphics("left=0; bottom=0; right=200; top=200")
    Graph.Canvas.DrawGraphics Circ1, "x=25; y=28"
    Graph.Canvas.DrawGraphics Circ2, "x=50; y=71"
    Graph.Canvas.DrawGraphics Circ3, "x=75; y=28"

	Page.Canvas.DrawGraphics Graph, "x=0; y=0"
End Sub


' Upper-right: no grouping, 0.5 opacity
Sub UpperRight
    Set Circ1 = Doc.CreateGraphics("left=0; bottom=0; right=100; top=100")
    Circ1.Canvas.SetFillColor 1, 0, 0
    Circ1.Canvas.FillEllipse 50, 50, 50, 50
    
    Set Circ2 = Doc.CreateGraphics("left=0; bottom=0; right=100; top=100")
    Circ2.Canvas.SetFillColor 1, 1, 0
    Circ2.Canvas.FillEllipse 50, 50, 50, 50
    
    Set Circ3 = Doc.CreateGraphics("left=0; bottom=0; right=100; top=100")
    Circ3.Canvas.SetFillColor 0, 0, 1
    Circ3.Canvas.FillEllipse 50, 50, 50, 50

	Set Graph = Doc.CreateGraphics("left=0; bottom=0; right=200; top=200")
	Set GState = Doc.CreateGState("BlendMode=1; FillAlpha=0.5")
	Graph.Canvas.SetGState GState
    Graph.Canvas.DrawGraphics Circ1, "x=25; y=28"
    Graph.Canvas.DrawGraphics Circ2, "x=50; y=71"
    Graph.Canvas.DrawGraphics Circ3, "x=75; y=28"

	Page.Canvas.DrawGraphics Graph, "x=0; y=0"
End Sub


' Lower-left: grouping, no opacity within group, 0.5 opacity for entire group
Sub LowerLeft
    Set Circ1 = Doc.CreateGraphics("left=0; bottom=0; right=100; top=100")
    Circ1.Canvas.SetFillColor 1, 0, 0
    Circ1.Canvas.FillEllipse 50, 50, 50, 50
    
    Set Circ2 = Doc.CreateGraphics("left=0; bottom=0; right=100; top=100")
    Circ2.Canvas.SetFillColor 1, 1, 0
    Circ2.Canvas.FillEllipse 50, 50, 50, 50
    
    Set Circ3 = Doc.CreateGraphics("left=0; bottom=0; right=100; top=100")
    Circ3.Canvas.SetFillColor 0, 0, 1
    Circ3.Canvas.FillEllipse 50, 50, 50, 50

	Set Group = Doc.CreateGState( "Group=true")
	Set Graph = Doc.CreateGraphics("left=0; bottom=0; right=200; top=200")
	Graph.SetGroup Group
    Graph.Canvas.DrawGraphics Circ1, "x=25; y=28"
    Graph.Canvas.DrawGraphics Circ2, "x=50; y=71"
    Graph.Canvas.DrawGraphics Circ3, "x=75; y=28"

	Set GState = Doc.CreateGState("BlendMode=1; FillAlpha=0.5")
	Page.Canvas.SetGState GState
	Page.Canvas.DrawGraphics Graph, "x=0; y=0"
End Sub

' Lower-right: grouping, 0.5 opacity within group, no opacity for entire group, HardLight
Sub LowerRight
	Set GState = Doc.CreateGState("BlendMode=1; FillAlpha=0.5")
	
    Set Circ1 = Doc.CreateGraphics("left=0; bottom=0; right=100; top=100")
	Circ1.Canvas.SetGState GState
    Circ1.Canvas.SetFillColor 1, 0, 0
    Circ1.Canvas.FillEllipse 50, 50, 50, 50
    
    Set Circ2 = Doc.CreateGraphics("left=0; bottom=0; right=100; top=100")
	Circ2.Canvas.SetGState GState
    Circ2.Canvas.SetFillColor 1, 1, 0
    Circ2.Canvas.FillEllipse 50, 50, 50, 50
    
    Set Circ3 = Doc.CreateGraphics("left=0; bottom=0; right=100; top=100")
	Circ3.Canvas.SetGState GState
    Circ3.Canvas.SetFillColor 0, 0, 1
    Circ3.Canvas.FillEllipse 50, 50, 50, 50

	Set Group = Doc.CreateGState( "Group=true")
	Set Graph = Doc.CreateGraphics("left=0; bottom=0; right=200; top=200")
	Graph.SetGroup Group
    Graph.Canvas.DrawGraphics Circ1, "x=25; y=28"
    Graph.Canvas.DrawGraphics Circ2, "x=50; y=71"
    Graph.Canvas.DrawGraphics Circ3, "x=75; y=28"

	Set GState2 = Doc.CreateGState("BlendMode=9; FillAlpha=1")
	Page.Canvas.SetGState GState2
	Page.Canvas.DrawGraphics Graph, "x=0; y=0"
End Sub





%>

</BODY>
</HTML>
