
<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.Reflection" %>
<%@ Import Namespace="ASPPDFLib" %>

<script runat="server" LANGUAGE="C#">

void Page_Load(Object Source, EventArgs E)
{
	IPdfManager objPdf = new PdfManager();
	IPdfDocument objDoc = objPdf.OpenDocument(Server.MapPath("population.pdf"), Missing.Value);
    IPdfPage objPage = objDoc.Pages[1];
    IPdfPreview objPreview = objPage.ToImage("extracttext=7"); // sort/glue
    
    objPage.Canvas.LineWidth = 0.5f;
    objPage.Canvas.SetFillColor( 1, 0, 0 );
    
    int i = 1;
    
    foreach( IPdfRect rect in objPreview.TextItems )
	{
        objPage.Canvas.SetColor( 1, 0, 0 );
        objPage.Canvas.SetFillColor( 1, 0, 0 );
        
		// Red outline
		objPage.Canvas.DrawRect( rect.Left, rect.Bottom, rect.Width, rect.Height );
        
        // Small box on top to display count
        objPage.Canvas.FillRect( rect.Left, rect.Top, 10, 5 );
        objPage.Canvas.DrawRect( rect.Left, rect.Top, 10, 5 );      
        objPage.Canvas.DrawText( i.ToString(), "x=" + (rect.Left + 1).ToString() + "; y=" + (rect.Top + 6).ToString() + ";color=white; size=5", 
			objDoc.Fonts["Helvetica", Missing.Value] );

		i++;
    }

	String strFilename = objDoc.Save( Server.MapPath("extracttext.pdf"), false );
	
	lblResult.Text = "Success! Download your PDF file <A HREF=" + strFilename + ">here</A>";
}





</script>


<HTML>
<HEAD>
<TITLE>AspPDF User Manual Chapter 14: Structured Text Extraction Sample</TITLE>
</HEAD>
<BODY>

<ASP:Label ID="lblResult" runat="server"/>

</BODY>
</HTML>
