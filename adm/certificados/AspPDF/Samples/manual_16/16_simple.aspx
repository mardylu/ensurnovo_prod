
<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.Reflection" %>
<%@ Import Namespace="ASPPDFLib" %>

<script runat="server" LANGUAGE="C#">

void Page_Load(Object Source, EventArgs E)
{
	IPdfManager objPdf = new PdfManager();

	// Create empty document
	IPdfDocument objDoc = objPdf.CreateDocument( Missing.Value );

	// Add a new page
	IPdfPage objPage = objDoc.Pages.Add( Missing.Value, Missing.Value, Missing.Value );

	// Convert www.persits.com to image
	IPdfImage objImage = objDoc.OpenUrl( "http://www.persits.com", Missing.Value, Missing.Value, Missing.Value );

	// Shrink as needed to fit width
	float fScale = objPage.Width / objImage.Width;

	// Align image top with page top
	float fY = objPage.Height - objImage.Height * fScale;
	
	// Draw image
	IPdfParam objParam = objPdf.CreateParam( Missing.Value );
	objParam["x"].Value = 0;
	objParam["y"].Value = fY;
	objParam["ScaleX"].Value = fScale;
	objParam["ScaleY"].Value = fScale;
	objPage.Canvas.DrawImage( objImage, objParam );

	// Save document, the Save method returns generated file name
	string strFilename = objDoc.Save( Server.MapPath("iehtmltopdf.pdf"), false );

	lblResult.Text = "Success! Download your PDF file <A HREF=" + strFilename + ">here</A>";
}





</script>


<HTML>
<HEAD>
<TITLE>AspPDF User Manual Chapter 16: IE-based HTML-to-PDF Conversion, Sample 1</TITLE>
</HEAD>
<BODY>

<ASP:Label ID="lblResult" runat="server"/>

</BODY>
</HTML>
