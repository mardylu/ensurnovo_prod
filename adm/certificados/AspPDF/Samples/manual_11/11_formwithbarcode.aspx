
<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.Reflection" %>
<%@ Import Namespace="ASPPDFLib" %>

<script runat="server" LANGUAGE="C#">

void Page_Load(Object Source, EventArgs E)
{
	// Form field values
	string [] arrValues = new string[18]; // 18 values

	arrValues[ 0] = "N-400"; // form type
	arrValues[ 1] = "09/13/13"; // form revision
	arrValues[ 2] = "1"; // page number
	arrValues[ 3] = "123456789"; // A-Nunber
	arrValues[ 4] = "D";	// Eligibility
	arrValues[ 5] = "SECTION 317,INA";	// Explanation
	arrValues[ 6] = "Smith";	// Legal name
	arrValues[ 7] = "John";
	arrValues[ 8] = "Frederick";
	arrValues[ 9] = "Smith";	// Name as it appears on card
	arrValues[10] = "John";
	arrValues[11] = "Frederick";
	arrValues[12] = ""; // Other names
	arrValues[13] = "";
	arrValues[14] = "";
	arrValues[15] = "";
	arrValues[16] = "";
	arrValues[17] = "";

	IPdfManager objPdf = new PdfManager();
	IPdfDocument objDoc = objPdf.OpenDocument( Server.MapPath("n-400.pdf"), Missing.Value );

	// Disconnect XFA and JavaScript
	objDoc.Form.Modify( "RemoveXFA=true; RemoveJavaScript=true" );

	// Fill out fields
	IPdfAnnot objField = objDoc.Form.FindField("form1[0].#subform[0].#area[0].Line1_AlienNumber[0]");
	objField.SetFieldValueEx( arrValues[3] );

	// Option 5 is selected
	objField = objDoc.Form.FindField("form1[0].#subform[0].Part1_Eligibility[0]");
	objField.SetFieldValueEx( objField.FieldOnValue );

	objField = objDoc.Form.FindField("form1[0].#subform[0].Part1Line5_OtherExplain[0]");
	objField.SetFieldValueEx( "RELIGIOUS DUTIES" );

	objField = objDoc.Form.FindField("form1[0].#subform[0].Line1_FamilyName[0]");
	objField.SetFieldValueEx( arrValues[6] );

	objField = objDoc.Form.FindField("form1[0].#subform[0].Line1_GivenName[0]");
	objField.SetFieldValueEx( arrValues[7] );

	objField = objDoc.Form.FindField("form1[0].#subform[0].Line1_MiddleName[0]");
	objField.SetFieldValueEx( arrValues[8] );

	objField = objDoc.Form.FindField("form1[0].#subform[0].Line2_FamilyName[0]");
	objField.SetFieldValueEx( arrValues[9] );

	objField = objDoc.Form.FindField("form1[0].#subform[0].Line2_GivenName[0]");
	objField.SetFieldValueEx( arrValues[10] );

	objField = objDoc.Form.FindField("form1[0].#subform[0].Line2_MiddleName[0]");
	objField.SetFieldValueEx( arrValues[11] );

	// Draw PDF417 barcode
	string strBarcodeValue = ""; // |-terminated array of values to encode as a barcode
	for( int i = 0; i < 18; i++ )
	{
		strBarcodeValue = strBarcodeValue + arrValues[i] + "|";
	}

	IPdfPage objPage = objDoc.Pages[1];
	objPage.Canvas.DrawBarcode2D( strBarcodeValue, "X=36; Y=36; Width=540; Height=108; QZV=6, QZH=8; " +
		"ErrorLevel=5; Columns=28; Rows=5", Missing.Value );

	// Flatten form
	IPdfDocument objFlatDoc = objPdf.OpenDocumentBinary( objDoc.SaveToMemory(), Missing.Value );
	objFlatDoc.Form.Modify( "Flatten=true; FlattenAnnots=true" );

	string strFilename = objFlatDoc.Save( Server.MapPath("formbarcode.pdf"), false );

	lblResult.Text = "Success! Download your PDF file <A HREF=" + strFilename + ">here</A>";
}


</script>


<HTML>
<HEAD>
<TITLE>AspPDF User Manual Chapter 11: Form with a Barcode</TITLE>
</HEAD>
<BODY>

<ASP:Label ID="lblResult" runat="server"/>

</BODY>
</HTML>
