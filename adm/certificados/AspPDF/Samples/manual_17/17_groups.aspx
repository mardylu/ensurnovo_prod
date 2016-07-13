
<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.Reflection" %>
<%@ Import Namespace="ASPPDFLib" %>

<script runat="server" LANGUAGE="C#">

IPdfDocument objDoc;
IPdfPage objPage;
IPdfManager objPdf;
IPdfGState objGState;
IPdfGState objGState2;
IPdfImage objImage;

void Page_Load(Object Source, EventArgs E)
{
	// Common part: draw background
	objPdf = new PdfManager();
	objDoc = objPdf.CreateDocument( Missing.Value );
	objPage = objDoc.Pages.Add( Missing.Value, Missing.Value, Missing.Value );

	// Rainbow background image
	objImage = objDoc.OpenImage( Server.MapPath( "17_rainbow.png" ), Missing.Value );

	objGState = objDoc.CreateGState("blendmode=2");
	objGState2 = objDoc.CreateGState("blendmode=1");

	DrawCircles( 600, true, true );
	DrawCircles( 400, true, false );
	DrawCircles( 200, false, true );
	DrawCircles( 0, false, false );

	// Save document, the Save method returns generated file name
	string strFilename = objDoc.Save( Server.MapPath("groups.pdf"), false );
	lblResult.Text = "Success! Download your PDF file <A HREF=" + strFilename + ">here</A>";
}

// Y-shift, isolated flag, knockout flag
void DrawCircles( int Y, bool Isolated, bool Knockout )
{
    IPdfGraphics objGraph = objDoc.CreateGraphics("left=0; bottom=0; right=200; top=200");

    // Create a circle graphics
    IPdfGraphics objCircle = objDoc.CreateGraphics("left=0; bottom=0; right=100; top=100");
    objCircle.Canvas.SetFillColor( 0.7f, 0.7f, 0.7f );
    objCircle.Canvas.FillEllipse( 50, 50, 50, 50 );

	// Parameter object for group creation
	IPdfParam objParam = objPdf.CreateParam(Missing.Value);
	objParam["Group"].Value = 1; // true
	if( Isolated ) objParam["Isolated"].Value = 1;
	if( Knockout ) objParam["Knockout"].Value = 1;
    IPdfGState objGroup = objDoc.CreateGState(objParam);
	    
    objGraph.SetGroup( objGroup );
    objGraph.Canvas.SetGState( objGState );
    objGraph.Canvas.DrawGraphics( objCircle, "x=25; y=28" );
    objGraph.Canvas.DrawGraphics( objCircle, "x=75; y=28" );
    objGraph.Canvas.DrawGraphics( objCircle, "x=25; y=78" );
    objGraph.Canvas.DrawGraphics( objCircle, "x=75; y=78" );

	objPage.Canvas.SaveState();

	objPage.Canvas.DrawImage( objImage, "x=0, y=" + Y );

    objPage.Canvas.SetGState( objGState2 );
    objPage.Canvas.DrawGraphics( objGraph, "x=0; y=" + Y );

	objPage.Canvas.RestoreState();
}





</script>


<HTML>
<HEAD>
<TITLE>AspPDF User Manual Chapter 17: Groups</TITLE>
</HEAD>
<BODY>

<ASP:Label ID="lblResult" runat="server"/>

</BODY>
</HTML>
