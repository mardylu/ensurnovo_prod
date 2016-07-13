
<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.Reflection" %>
<%@ Import Namespace="ASPPDFLib" %>

<script runat="server" LANGUAGE="C#">

void Page_Load(Object Source, EventArgs E)
{
	IPdfManager objPdf = new PdfManager();

	// Create a new document
	IPdfDocument objDoc = objPdf.CreateDocument( Missing.Value );
	IPdfPage objPage = objDoc.Pages.Add( Missing.Value, Missing.Value, Missing.Value );

	// Open existing PDF
	IPdfDocument objAnotherDoc = objPdf.OpenDocument( Server.MapPath("1040es.pdf"), Missing.Value );

	// Turn page 1 into a PdfGraphics object
	IPdfGraphics objGraphics = objDoc.CreateGraphicsFromPage( objAnotherDoc, 1 );

	// Draw on this document several times
	objPage.Canvas.DrawGraphics( objGraphics, "x=10; y=500; scalex=0.3; scaley=0.3" );
	objPage.Canvas.DrawGraphics( objGraphics, "x=180; y=600; scalex=0.2; scaley=0.2; angle=-30" );
	objPage.Canvas.DrawGraphics( objGraphics, "x=300; y=550; scalex=0.1; scaley=0.1; angle=-60" );


	// Save document, the Save method returns generated file name
	String strFilename = objDoc.Save( Server.MapPath("page2graphics.pdf"), false );

	lblResult.Text = "Success! Download your PDF file <A HREF=" + strFilename + ">here</A>";
}

</script>


<HTML>
<HEAD>
<TITLE>AspPDF User Manual Chapter 9: Page-to-Graphics Sample</TITLE>
</HEAD>
<BODY>

<ASP:Label ID="lblResult" runat="server"/>

</BODY>
</HTML>
