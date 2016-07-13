
<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.Reflection" %>
<%@ Import Namespace="ASPPDFLib" %>

<script runat="server" LANGUAGE="C#">

void Page_Load(Object Source, EventArgs E)
{
	IPdfManager objPdf = new PdfManager();

	// Create empty document
	IPdfDocument objDoc = objPdf.CreateDocument( Missing.Value );

	IPdfParam objParam = objPdf.CreateParam( Missing.Value );

	// Convert URL to image
	IPdfImage objImage = objDoc.OpenUrl( "http://support.persits.com/default.asp?displayall=1", "AspectRatio=0.7727", Missing.Value, Missing.Value );

	// Iterate through all images
	while( objImage != null )
	{
		// Add a new page
		IPdfPage objPage = objDoc.Pages.Add( Missing.Value, Missing.Value, Missing.Value );

		// Compute scale based on image width and page width
		float fScale = objPage.Width / objImage.Width;

		// Draw image
		objParam["x"].Value = 0;
		objParam["y"].Value = objPage.Height - objImage.Height * fScale;
		objParam["ScaleX"].Value = fScale;
		objParam["ScaleY"].Value = fScale;
		objPage.Canvas.DrawImage( objImage, objParam );

		// Go to next image
		objImage = objImage.NextImage;
	}

	// Save document, the Save method returns generated file name
	string strFilename = objDoc.Save( Server.MapPath("pages.pdf"), false );

	lblResult.Text = "Success! Download your PDF file <A HREF=" + strFilename + ">here</A>";
}





</script>


<HTML>
<HEAD>
<TITLE>AspPDF User Manual Chapter 16: IE-based HTML-to-PDF Conversion, Sample 2</TITLE>
</HEAD>
<BODY>

<ASP:Label ID="lblResult" runat="server"/>

</BODY>
</HTML>
