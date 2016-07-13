
<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.Reflection" %>
<%@ Import Namespace="ASPPDFLib" %>

<script runat="server" LANGUAGE="C#">

void Page_Load(Object Source, EventArgs E)
{
	IPdfManager objPdf = new PdfManager();

	// Create empty document
	IPdfDocument objDoc = objPdf.CreateDocument( Missing.Value );

	// Parameter object for image drawing
	IPdfParam objParam = objPdf.CreateParam( Missing.Value );

	// Parameter object for hyperlink annotation drawing
    IPdfParam objHyperlinkParam = objPdf.CreateParam( Missing.Value );
    objHyperlinkParam.Set( "Type = link" );

	// Convert URL to image. Enable hyperlinks. Use hemming.
	IPdfImage objImage = objDoc.OpenUrl( "http://support.persits.com/default.asp?displayall=1", 
		"AspectRatio=0.7727; hyperlinks=true; hem=50; hemcolor=white", 
		Missing.Value, Missing.Value );

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

		// Now draw hyperlinks from the Image.Hyperlinks collection
        foreach( IPdfRect objRect in objImage.Hyperlinks )
		{
            objHyperlinkParam["x"].Value = objRect.Left * fScale;
			// Y-coordinate must be lifted by the same amount as the image itself
            objHyperlinkParam["y"].Value = objRect.Bottom * fScale + objParam["y"].Value;
            objHyperlinkParam["width"].Value = objRect.Width * fScale;
            objHyperlinkParam["height"].Value = objRect.Height * fScale;
            objHyperlinkParam["border"].Value = 0;
            
			// Create link annotation
			IPdfAnnot objAnnot = objPage.Annots.Add("", objHyperlinkParam, Missing.Value, Missing.Value);
            objAnnot.SetAction( objDoc.CreateAction("type=URI", objRect.Text) );
        }

		// Go to next image
		objImage = objImage.NextImage;
	}

	// Save document, the Save method returns generated file name
	string strFilename = objDoc.Save( Server.MapPath("hyperlinks.pdf"), false );

	lblResult.Text = "Success! Download your PDF file <A HREF=" + strFilename + ">here</A>";
}





</script>


<HTML>
<HEAD>
<TITLE>AspPDF User Manual Chapter 16: IE-based HTML-to-PDF Conversion, Sample 3</TITLE>
</HEAD>
<BODY>

<ASP:Label ID="lblResult" runat="server"/>

</BODY>
</HTML>
