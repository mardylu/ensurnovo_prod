
<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.Reflection" %>
<%@ Import Namespace="ASPPDFLib" %>

<script runat="server" LANGUAGE="C#">

void Page_Load(Object Source, EventArgs E)
{
	IPdfManager objPdf = new PdfManager();
	IPdfDocument objDoc = objPdf.CreateDocument( Missing.Value );
	IPdfPage objPage = objDoc.Pages.Add( Missing.Value, Missing.Value, Missing.Value );

	// Main Logo
	IPdfGraphics objLogo = objDoc.CreateGraphics("left=0; bottom=0; right=128; top=206");
	
    objLogo.Canvas.SetParams("FillColor=#313570");
    objLogo.Canvas.MoveTo(6, 177);
    objLogo.Canvas.LineTo(48, 201);
    objLogo.Canvas.LineTo(113, 162);
    objLogo.Canvas.LineTo(113, 86);
    objLogo.Canvas.LineTo(70, 62);
    objLogo.Canvas.LineTo(70, 137);
    objLogo.Canvas.ClosePath();
    objLogo.Canvas.Fill(Missing.Value);
    
    objLogo.Canvas.SetParams("FillColor=#5B88B1");
    objLogo.Canvas.MoveTo(61, 5);
    objLogo.Canvas.LineTo(61, 130);
    objLogo.Canvas.LineTo(20, 106);
    objLogo.Canvas.LineTo(20, 30);
    objLogo.Canvas.ClosePath();
    objLogo.Canvas.Fill(Missing.Value);

	// Transparency group to be used with the soft mask
	IPdfGState objGroup = objDoc.CreateGState("Group=true");
	// Required as we use luminocity for soft mask
	objGroup.SetColorSpace( objDoc.CreateColorSpace("DeviceRGB", Missing.Value ));

	// Soft mask based on an image to be used as alpha
	IPdfImage objImage = objDoc.OpenImage(Server.MapPath("17_alpha.png"), Missing.Value );
	IPdfGraphics objSM = objDoc.CreateGraphics("left=0; bottom=0; right=128; top=206");
	objSM.Canvas.DrawImage( objImage, "x=0; y=0" );

	// Associate the soft mask with a transparency group
	objSM.SetGroup( objGroup );

	// Drop Shadow. Uses GState object with a soft mask
	IPdfGState objGState = objDoc.CreateGState("fillalpha=0.5");
	objGState.SetSoftMask( objSM, "alpha=false" );
	IPdfGraphics objShadow = objDoc.CreateGraphics("left=0; bottom=0; right=128; top=206");
	
    objShadow.Canvas.SetGState( objGState );
    objShadow.Canvas.SetFillColor( 0.2f, 0.2f, 0.2f ); // gray
    objShadow.Canvas.FillRect( 0, 0, 128, 206 );

	// Draw shadow with an offset
	objPage.Canvas.DrawGraphics( objShadow, "x=110; y=490" );

	// Draw logo
	objPage.Canvas.DrawGraphics( objLogo, "x=100; y=500" );

	// Save document, the Save method returns generated file name
	string strFilename = objDoc.Save( Server.MapPath("dropshadow.pdf"), false );
	lblResult.Text = "Success! Download your PDF file <A HREF=" + strFilename + ">here</A>";
}


</script>


<HTML>
<HEAD>
<TITLE>AspPDF User Manual Chapter 17: Soft Maska</TITLE>
</HEAD>
<BODY>

<ASP:Label ID="lblResult" runat="server"/>

</BODY>
</HTML>
