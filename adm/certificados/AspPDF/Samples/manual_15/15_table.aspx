
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


	// Create an ICC color space
	IPdfColorSpace csICC = objDoc.CreateColorSpace( "ICCBased", "N=3" );
	csICC.LoadDataFromFile( Server.MapPath( "AdobeRGB1998.icc" ) );

	IPdfTable objTable = objDoc.CreateTable("rows=2; cols=3; width=400; height=300; border=10; cellborder=5; cellspacing=10; cellpadding=2");
	objTable.Font = objDoc.Fonts["Helvetica", Missing.Value];
    
    // Border color
    objTable.SetColor("Type=1; ColorSpace=" + csICC.Index + "; c1=1; c2=0.5; c3=0.2");
    
    // Cell Border Color
    objTable.SetColor("Type=2; ColorSpace=" + csICC.Index + "; c1=0; c2=0; c3=1");
    
    // BG Color
    objTable.SetColor("Type=3; ColorSpace=" + csICC.Index + "; c1=1; c2=1; c3=0");
    
    // Cell BG Color
    objTable.SetColor("Type=4; ColorSpace=" + csICC.Index + "; c1=0; c2=1; c3=0");
    

	// Border color for individual cell
	objTable[1, 1].SetColor("Type=2; ColorSpace=" + csICC.Index + "; c1=1; c2=0; c3=1");

	// Draw text, use the same color space for it
	objTable[1, 1].AddText("Test", "ColorSpace=" + csICC.Index + ";c1=0.2; c2=0.4; c3=0.3", Missing.Value);

	// Render table
	objPage.Canvas.DrawTable( objTable, "x=106; y=700" );


	String strFilename = objDoc.Save( Server.MapPath("cs_table.pdf"), false );
	
	lblResult.Text = "Success! Download your PDF file <A HREF=" + strFilename + ">here</A>";
}



</script>


<HTML>
<HEAD>
<TITLE>AspPDF User Manual Chapter 15: Using Color Spaces with Tables</TITLE>
</HEAD>
<BODY>

<ASP:Label ID="lblResult" runat="server"/>

</BODY>
</HTML>
