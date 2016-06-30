
<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.Reflection" %>
<%@ Import Namespace="ASPPDFLib" %>

<script runat="server" LANGUAGE="C#">

void Page_Load(Object Source, EventArgs E)
{
	IPdfManager objPdf = new PdfManager();

	// Create empty document
	IPdfDocument objDoc = objPdf.CreateDocument(Missing.Value);

	// Set various document properties
	objDoc.Title = "AspPDF Chapter 3 Hello World Sample";
	objDoc.Creator = "John Smith";

	// Add a new page
	IPdfPage objPage = objDoc.Pages.Add(Missing.Value, Missing.Value, Missing.Value);

	// Select one of the standard PDF fonts
	IPdfFont objFont = objDoc.Fonts["Helvetica", Missing.Value];

	// Param string
	String strParams = "x=0; y=650; width=612; alignment=center; size=50";
	
	// Draw text on page
	objPage.Canvas.DrawText( "Hello World!", strParams, objFont );

	// Encrypt, set "no changing, no printing" flags
	objDoc.Encrypt( "abc", "xyz", 128, pdfPermissions.pdfFull & (~pdfPermissions.pdfModify) & (~pdfPermissions.pdfPrint) );

	// Save document, the Save method returns generated file name
	String strFilename = objDoc.Save( Server.MapPath("encrypted.pdf"), false );

	lblResult.Text = "Success! Download your PDF file <A HREF=" + strFilename + ">here</A>";
}

</script>


<HTML>
<HEAD>
<TITLE>AspPDF User Manual Chapter 8: Encryption Sample</TITLE>
</HEAD>
<BODY>

<ASP:Label ID="lblResult" runat="server"/>

</BODY>
</HTML>
