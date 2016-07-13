
<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.Reflection" %>
<%@ Import Namespace="ASPPDFLib" %>

<script runat="server" LANGUAGE="C#">


IPdfPage objPage;
IPdfDocument objDoc;

void Page_Load(Object Source, EventArgs E)
{
	IPdfManager objPdf = new PdfManager();
	objDoc = objPdf.CreateDocument( Missing.Value );
	
	objPage = objDoc.Pages.Add( Missing.Value, Missing.Value, Missing.Value );

	// Create some color spaces
	IPdfColorSpace csICC = objDoc.CreateColorSpace( "ICCBased", "N=3" );
	csICC.LoadDataFromFile( Server.MapPath( "AdobeRGB1998.icc" ) );

	// Draw an image with the default color space, and the same image with an ICC profile
	IPdfImage objImage = objDoc.OpenImage( Server.MapPath( "apple.jpg" ), Missing.Value );
	objPage.Canvas.DrawImage( objImage, "x=20; y=600; scalex=0.5, scaley=0.5" );
	objPage.Canvas.DrawText( "Without a profile", "x=20; y=595", objDoc.Fonts["Helvetica", Missing.Value] );

	IPdfImage objImage2 = objDoc.OpenImage( Server.MapPath( "apple.jpg" ), Missing.Value );
	objImage2.SetColorSpace( csICC );
	objPage.Canvas.DrawImage( objImage2, "x=240; y=600; scalex=0.5, scaley=0.5" );
	objPage.Canvas.DrawText( "With an ICC profile", "x=240; y=595", objDoc.Fonts["Helvetica", Missing.Value] );

	// Grayscale color space
	IPdfColorSpace csGray = objDoc.CreateColorSpace("DeviceGray", Missing.Value);
	DrawBars( 300, csGray, "Default Grayscale" );

	// Separation color space with a sampled transformation function
	IPdfFunction objFunc = objDoc.CreateFunction("type=0; Dmin1=0;Dmax1=1; Rmin1=0;Rmax1=1; Size1=5; BitsPerSample=8");
	object [] arrSamples = new object[5] { (object)0, (object)32, (object)64, (object)128, (object)255 };
	objFunc.SetSampleData( arrSamples );
	IPdfColorSpace csSep = objDoc.CreateColorSpace("Separation", Missing.Value);
	csSep.SetSeparationParams( "PANTONE 4525 C", csGray, objFunc );

	DrawBars( 180, csSep, "Grayscale based on a sampled function" );


	// Calibrated Gray
	IPdfColorSpace csCalGray = objDoc.CreateColorSpace("CalGray", "Xw=0.7; Yw=1; Zw=1.3");
	DrawBars( 60, csCalGray, "Calibrated Grayscale" );


	String strFilename = objDoc.Save( Server.MapPath("colorspace.pdf"), false );
	
	lblResult.Text = "Success! Download your PDF file <A HREF=" + strFilename + ">here</A>";
}


void DrawBars( int YCoord, IPdfColorSpace ColorSpace, string Title )
{
	// stroking colors: for bar borders
	objPage.Canvas.SetColorEx( "c1=0" );
	objPage.Canvas.LineWidth = 5;

	objPage.Canvas.SetFillColorSpace( ColorSpace );

	for( double c = 0; c <= 1; c += 0.1 )
	{
		objPage.Canvas.SetFillColorEx( "c1=" + c.ToString() );
		
		objPage.Canvas.DrawRect( 20 + (float)c * 500, YCoord, 50, 100 );
		objPage.Canvas.FillRect( 20 + (float)c * 500, YCoord, 50, 100 );
	}

	objPage.Canvas.DrawText( Title, "x=20; y=" + (YCoord + 10).ToString(), objDoc.Fonts["Helvetica", Missing.Value] );
}


</script>


<HTML>
<HEAD>
<TITLE>AspPDF User Manual Chapter 15: Color Space Sample</TITLE>
</HEAD>
<BODY>

<ASP:Label ID="lblResult" runat="server"/>

</BODY>
</HTML>
