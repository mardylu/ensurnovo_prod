<HTML>
<HEAD>
<TITLE>AspPDF User Manual Chapter 17: Groups</TITLE>
</HEAD>
<BODY>

<%
Set PDF = Server.CreateObject("Persits.PDF")
Set Doc = PDF.CreateDocument
Set Page = Doc.Pages.Add

' Rainbow background image
Set Image = Doc.OpenImage( Server.MapPath( "17_rainbow.png" ) )

Set GState = Doc.CreateGState("blendmode=2")
Set GState2 = Doc.CreateGState("blendmode=1")

Call DrawCircles( 600, True, True )
Call DrawCircles( 400, True, False )
Call DrawCircles( 200, False, True )
Call DrawCircles( 0, False, False )

' Save document, the Save method returns generated file name
Filename = Doc.Save( Server.MapPath("groups.pdf"), False )
Response.Write "Success! Download your PDF file <A HREF=" & Filename & ">here</A>"

' Y-shift, isolated flag, knockout flag
Sub DrawCircles( Y, Isolated, Knockout )

    Set Graph = Doc.CreateGraphics("left=0; bottom=0; right=200; top=200")

    ' Create a circle graphics
    Set Circle = Doc.CreateGraphics("left=0; bottom=0; right=100; top=100")
    Circle.Canvas.SetFillColor 0.7, 0.7, 0.7
    Circle.Canvas.FillEllipse 50, 50, 50, 50

	' Parameter object for group creation
	Set Param = PDF.CreateParam
	Param("Group") = 1 ' True
	If Isolated Then Param("Isolated") = 1
	If Knockout Then Param("Knockout") = 1
    Set Group = Doc.CreateGState(Param)
	    
    Graph.SetGroup Group
    Graph.Canvas.SetGState GState
    Graph.Canvas.DrawGraphics Circle, "x=25; y=28"
    Graph.Canvas.DrawGraphics Circle, "x=75; y=28"
    Graph.Canvas.DrawGraphics Circle, "x=25; y=78"
    Graph.Canvas.DrawGraphics Circle, "x=75; y=78"

	Page.Canvas.SaveState

	Page.Canvas.DrawImage Image, "x=0, y=" & Y

    Page.Canvas.SetGState GState2
    Page.Canvas.DrawGraphics Graph, "x=0; y=" & Y

	Page.Canvas.RestoreState
End Sub

%>

</BODY>
</HTML>
