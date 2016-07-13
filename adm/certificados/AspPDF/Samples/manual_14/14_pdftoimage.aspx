<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.Reflection" %>
<%@ Import Namespace="ASPPDFLib" %>

<%@ Page aspCompat="True" %> 

<script runat="server" LANGUAGE="C#">

void Page_Load(Object Source, EventArgs E)
{
	IPdfManager objPdf = new PdfManager();
	IPdfDocument objDoc = objPdf.CreateDocument( Missing.Value );
	objDoc.ImportFromUrl( "http://www.aspupload.com", "landscape=true", 
		Missing.Value, Missing.Value );

	// Save and reopen as Page.Preview only works on new documents.
	IPdfDocument objNewDoc = objPdf.OpenDocumentBinary( objDoc.SaveToMemory(), Missing.Value );

	// Create preview for Page 1 at 50% scale.
	IPdfPage objPage = objNewDoc.Pages[1];
	IPdfPreview objPreview = objPage.ToImage("ResolutionX=36; ResolutionY=36" );

	objPreview.SaveHttp( "filename=preview.png" );
}
</script>