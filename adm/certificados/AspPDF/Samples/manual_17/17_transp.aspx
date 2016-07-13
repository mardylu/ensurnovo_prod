
<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.Reflection" %>
<%@ Import Namespace="ASPPDFLib" %>

<script runat="server" LANGUAGE="C#">

IPdfDocument objDoc;
IPdfPage objPage;

void Page_Load(Object Source, EventArgs E)
{
	// Common part: draw background
	IPdfManager objPdf = new PdfManager();
	objDoc = objPdf.CreateDocument( Missing.Value );
	objPage = objDoc.Pages.Add( Missing.Value, Missing.Value, Missing.Value );

	objPage.Canvas.SetFillColor( 0.8f, 0.8f, 0.8f );
	objPage.Canvas.FillRect( 0, 0, objPage.Width / 2, objPage.Height );
	objPage.Canvas.SetFillColor( 1, 1, 1 );
	objPage.Canvas.FillRect( objPage.Width / 2, 0, objPage.Width, objPage.Height );

	objPage.Canvas.SaveState();
	objPage.Canvas.SetCTM( 1, 0, 0, 1, 206, 600 );
	UpperLeft();
	objPage.Canvas.RestoreState();

	objPage.Canvas.SaveState();
	objPage.Canvas.SetCTM( 1, 0, 0, 1, 206, 400 );
	UpperRight();
	objPage.Canvas.RestoreState();

	objPage.Canvas.SaveState();
	objPage.Canvas.SetCTM( 1, 0, 0, 1, 206, 200 );
	LowerLeft();
	objPage.Canvas.RestoreState();

	objPage.Canvas.SaveState();
	objPage.Canvas.SetCTM( 1, 0, 0, 1, 206, 0 );
	LowerRight();
	objPage.Canvas.RestoreState();

	// Save document, the Save method returns generated file name
	string strFilename = objDoc.Save( Server.MapPath("transp.pdf"), false );
	lblResult.Text = "Success! Download your PDF file <A HREF=" + strFilename + ">here</A>";
}

void UpperLeft()
{
    IPdfGraphics objCirc1 = objDoc.CreateGraphics("left=0; bottom=0; right=100; top=100");
    objCirc1.Canvas.SetFillColor( 1, 0, 0 );
    objCirc1.Canvas.FillEllipse( 50, 50, 50, 50 );
    
    IPdfGraphics objCirc2 = objDoc.CreateGraphics("left=0; bottom=0; right=100; top=100");
    objCirc2.Canvas.SetFillColor( 1, 1, 0 );
    objCirc2.Canvas.FillEllipse( 50, 50, 50, 50 );
    
    IPdfGraphics objCirc3 = objDoc.CreateGraphics("left=0; bottom=0; right=100; top=100");
    objCirc3.Canvas.SetFillColor( 0, 0, 1 );
    objCirc3.Canvas.FillEllipse( 50, 50, 50, 50 );

	IPdfGraphics objGraph = objDoc.CreateGraphics("left=0; bottom=0; right=200; top=200");
    objGraph.Canvas.DrawGraphics( objCirc1, "x=25; y=28" );
    objGraph.Canvas.DrawGraphics( objCirc2, "x=50; y=71" );
    objGraph.Canvas.DrawGraphics( objCirc3, "x=75; y=28" );

	objPage.Canvas.DrawGraphics( objGraph, "x=0; y=0" );
}

void UpperRight()
{
    IPdfGraphics objCirc1 = objDoc.CreateGraphics("left=0; bottom=0; right=100; top=100");
    objCirc1.Canvas.SetFillColor( 1, 0, 0 );
    objCirc1.Canvas.FillEllipse( 50, 50, 50, 50 );
    
    IPdfGraphics objCirc2 = objDoc.CreateGraphics("left=0; bottom=0; right=100; top=100");
    objCirc2.Canvas.SetFillColor( 1, 1, 0 );
    objCirc2.Canvas.FillEllipse( 50, 50, 50, 50 );
    
    IPdfGraphics objCirc3 = objDoc.CreateGraphics("left=0; bottom=0; right=100; top=100");
    objCirc3.Canvas.SetFillColor( 0, 0, 1 );
    objCirc3.Canvas.FillEllipse( 50, 50, 50, 50 );

	IPdfGraphics objGraph = objDoc.CreateGraphics("left=0; bottom=0; right=200; top=200");
	IPdfGState objGState = objDoc.CreateGState("BlendMode=1; FillAlpha=0.5");
	objGraph.Canvas.SetGState( objGState );
    objGraph.Canvas.DrawGraphics( objCirc1, "x=25; y=28" );
    objGraph.Canvas.DrawGraphics( objCirc2, "x=50; y=71" );
    objGraph.Canvas.DrawGraphics( objCirc3, "x=75; y=28" );

	objPage.Canvas.DrawGraphics( objGraph, "x=0; y=0" );
}

void LowerLeft()
{
    IPdfGraphics objCirc1 = objDoc.CreateGraphics("left=0; bottom=0; right=100; top=100");
    objCirc1.Canvas.SetFillColor( 1, 0, 0 );
    objCirc1.Canvas.FillEllipse( 50, 50, 50, 50 );
    
    IPdfGraphics objCirc2 = objDoc.CreateGraphics("left=0; bottom=0; right=100; top=100");
    objCirc2.Canvas.SetFillColor( 1, 1, 0 );
    objCirc2.Canvas.FillEllipse( 50, 50, 50, 50 );
    
    IPdfGraphics objCirc3 = objDoc.CreateGraphics("left=0; bottom=0; right=100; top=100");
    objCirc3.Canvas.SetFillColor( 0, 0, 1 );
    objCirc3.Canvas.FillEllipse( 50, 50, 50, 50 );

	IPdfGState objGroup = objDoc.CreateGState( "Group=true");
	IPdfGraphics objGraph = objDoc.CreateGraphics("left=0; bottom=0; right=200; top=200");
	objGraph.SetGroup( objGroup );
    objGraph.Canvas.DrawGraphics( objCirc1, "x=25; y=28" );
    objGraph.Canvas.DrawGraphics( objCirc2, "x=50; y=71" );
    objGraph.Canvas.DrawGraphics( objCirc3, "x=75; y=28" );

	IPdfGState objGState = objDoc.CreateGState("BlendMode=1; FillAlpha=0.5");
	objPage.Canvas.SetGState( objGState );
	objPage.Canvas.DrawGraphics( objGraph, "x=0; y=0" );
}

void LowerRight()
{
	IPdfGState objGState = objDoc.CreateGState("BlendMode=1; FillAlpha=0.5");
	
    IPdfGraphics objCirc1 = objDoc.CreateGraphics("left=0; bottom=0; right=100; top=100");
	objCirc1.Canvas.SetGState( objGState );
    objCirc1.Canvas.SetFillColor( 1, 0, 0 );
    objCirc1.Canvas.FillEllipse( 50, 50, 50, 50 );
    
    IPdfGraphics objCirc2 = objDoc.CreateGraphics("left=0; bottom=0; right=100; top=100");
	objCirc2.Canvas.SetGState( objGState );
    objCirc2.Canvas.SetFillColor( 1, 1, 0 );
    objCirc2.Canvas.FillEllipse( 50, 50, 50, 50 );
    
    IPdfGraphics objCirc3 = objDoc.CreateGraphics("left=0; bottom=0; right=100; top=100");
	objCirc3.Canvas.SetGState( objGState );
    objCirc3.Canvas.SetFillColor( 0, 0, 1 );
    objCirc3.Canvas.FillEllipse( 50, 50, 50, 50 );

	IPdfGState objGroup = objDoc.CreateGState( "Group=true");
	IPdfGraphics objGraph = objDoc.CreateGraphics("left=0; bottom=0; right=200; top=200");
	objGraph.SetGroup( objGroup );
    objGraph.Canvas.DrawGraphics( objCirc1, "x=25; y=28" );
    objGraph.Canvas.DrawGraphics( objCirc2, "x=50; y=71" );
    objGraph.Canvas.DrawGraphics( objCirc3, "x=75; y=28" );

	IPdfGState objGState2 = objDoc.CreateGState("BlendMode=9; FillAlpha=1");
	objPage.Canvas.SetGState( objGState2 );
	objPage.Canvas.DrawGraphics( objGraph, "x=0; y=0" );
}




</script>


<HTML>
<HEAD>
<TITLE>AspPDF User Manual Chapter 17: Transparency</TITLE>
</HEAD>
<BODY>

<ASP:Label ID="lblResult" runat="server"/>

</BODY>
</HTML>
