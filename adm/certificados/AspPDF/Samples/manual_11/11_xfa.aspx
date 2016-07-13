<%@ Page Language="C#" Debug="true" %>

<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.Reflection" %>
<%@ Import Namespace="System.Xml" %>
<%@ Import Namespace="ASPPDFLib" %>

<script runat="server" LANGUAGE="C#">

void Page_Load(Object Source, EventArgs E)
{
	XmlNode Node;


	IPdfManager objPdf = new PdfManager();

	// Open an XFA form
	IPdfDocument objDoc = objPdf.OpenDocument( Server.MapPath( "Purchase Order.pdf" ), Missing.Value );

	// Check if the form contains XFA data
	if( !objDoc.Form.HasXFA )
	{
		lblResult.Text = "This form contains no XFA information.";
		return;
	}

	// Load XFA dataset from the PDF form to Microsoft XML processor object
	XmlDocument Xml = new XmlDocument();
	Xml.LoadXml( objDoc.Form.XFADatasets  );

	XmlNamespaceManager Mgr = new XmlNamespaceManager(Xml.NameTable);
	Mgr.AddNamespace("xfa", "http://www.xfa.org/schema/xfa-data/1.0/");

	// Fill PO number
	Node = Xml.DocumentElement.SelectSingleNode("/xfa:datasets/xfa:data/form1/header/txtPONum", Mgr);
	Node.InnerText = "1234456577";

	// Fill Ordered By Company
	Node = Xml.DocumentElement.SelectSingleNode("/xfa:datasets/xfa:data/form1/header/txtOrderedByCompanyName", Mgr);
	Node.InnerText = "Acme, Inc.";

	// Fill Terms and Conditions: 1 for cash, 2 for credit
	Node = Xml.DocumentElement.SelectSingleNode("/xfa:datasets/xfa:data/form1/total/TermsConditions", Mgr);
	Node.InnerText = "2";

	// Fill State Tax checkbox and state tax rate of 8.5%
	Node = Xml.DocumentElement.SelectSingleNode("/xfa:datasets/xfa:data/form1/total/chkStateTax", Mgr);
	Node.InnerText = "1";
	Node = Xml.DocumentElement.SelectSingleNode("/xfa:datasets/xfa:data/form1/total/numStateTaxRate", Mgr);
	Node.InnerText = "8.5";

	// Add purchase order items

	// First, delete two existing detail nodes under form1
	Node = Xml.DocumentElement.SelectSingleNode("/xfa:datasets/xfa:data/form1", Mgr );
	Node.RemoveChild( Xml.GetElementsByTagName("detail")[0] );
	Node.RemoveChild( Xml.GetElementsByTagName("detail")[0] );

	// Add three new detail nodes
	for( int i = 1; i <= 3; i++ )
	{
		XmlNode Detail, Subdetail;

		Detail = Xml.CreateElement("detail");
		Subdetail = Xml.CreateElement("txtPartNum");
		Subdetail.InnerText = "PART#" + i.ToString();
		Detail.AppendChild( Subdetail );
		Subdetail = Xml.CreateElement("txtDescription");
		Subdetail.InnerText = "Description #" + i.ToString();
		Detail.AppendChild( Subdetail );
		Subdetail = Xml.CreateElement("numQty");
		Subdetail.InnerText = (5 * i).ToString();
		Detail.AppendChild( Subdetail );
		Subdetail = Xml.CreateElement("numUnitPrice");
		Subdetail.InnerText = (100 * i).ToString();
		Detail.AppendChild( Subdetail );
		
		Node.InsertBefore( Detail, Xml.GetElementsByTagName("total")[0] );
	}


	// Plug the dataset back to the PDF form
	objDoc.Form.XFADatasets = Xml.InnerXml;

	// Save document
	string Path = Server.MapPath( "xfaform.pdf");
	string FileName = objDoc.Save( Path, false);

	lblResult.Text = "Success! Download your PDF file <A TARGET=\"_new\" HREF=" + FileName + ">here</A>";
}





</script>


<HTML>
<HEAD>
<TITLE>AspPDF User Manual Chapter 11a: XFA Support</TITLE>
</HEAD>
<BODY>

<ASP:Label ID="lblResult" runat="server"/>

</BODY>
</HTML>
