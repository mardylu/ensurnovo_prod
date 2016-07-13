
<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.Reflection" %>
<%@ Import Namespace="ASPPDFLib" %>

<script runat="server" LANGUAGE="C#">

void Page_Load(Object Source, EventArgs E)
{
	IPdfManager objPdf = new PdfManager();

	// Create empty document
	IPdfDocument objDoc = objPdf.CreateDocument(Missing.Value);

	// Convert HTML to PDF
	objDoc.ImportFromUrl( "http://www.asppdf.com", "landscape=true; scale=0.75", Missing.Value, Missing.Value );

	// Add metadata from a file
	string strMetadata = objPdf.LoadTextFromFile( Server.MapPath("metadata.txt") );

	// Replace placeholder with actual document title
	strMetadata = strMetadata.Replace( "@@@title@@@", objDoc.Title );

	objDoc.MetaData = strMetadata;

	// Add output intent using an RGB color profile. Borrow .icc file from Chapter 15
	string strProfilePath = Server.MapPath(".") + @"\..\manual_15\AdobeRGB1998.icc";
	objDoc.AddOutputIntent( "AdobeRGB", "Custom", strProfilePath, 3 );

	// Save document
	string strPath = Server.MapPath( "pdfa.pdf");
	string strFileName = objDoc.Save( strPath, false);

	lblResult.Text = "Success! Download your PDF file <A HREF=" + strFileName + ">here</A>";
}


</script>


<HTML>
<HEAD>
<TITLE>AspPDF User Manual Chapter 12: Creating a PDF/A-Compliant Document</TITLE>
</HEAD>
<BODY>

<ASP:Label ID="lblResult" runat="server"/>

</BODY>
</HTML>