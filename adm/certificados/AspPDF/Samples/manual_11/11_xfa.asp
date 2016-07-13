<HTML>
<HEAD>
<TITLE>AspPDF User Manual Chapter 11a: XFA Support</TITLE>
</HEAD>
<BODY>

<%

	Set PDF = Server.CreateObject("Persits.PDF")

	' Open an XFA form
	Set Doc = PDF.OpenDocument( Server.MapPath( "Purchase Order.pdf" ) )

	' Check if the form contains XFA data
	If Not Doc.Form.HasXFA Then
		Response.Write "This form contains no XFA information."
		Response.End
	End If

	' Load XFA dataset from the PDF form to Microsoft XML processor object
	Set Xml = Server.CreateObject("Microsoft.XMLDOM")
	Xml.Async = False ' need synchronous operation
	Xml.LoadXml( Doc.Form.XFADatasets )

	' Fill PO number
	Set Node = Xml.DocumentElement.SelectSingleNode("/xfa:datasets/xfa:data/form1/header/txtPONum")
	Node.text = "1234456577"

	' Fill Ordered By Company
	Set Node = Xml.DocumentElement.SelectSingleNode("/xfa:datasets/xfa:data/form1/header/txtOrderedByCompanyName")
	Node.text = "Acme, Inc."

	' Fill Terms and Conditions: 1 for cash, 2 for credit
	Set Node = Xml.DocumentElement.SelectSingleNode("/xfa:datasets/xfa:data/form1/total/TermsConditions")
	Node.text = "2"

	' Fill State Tax checkbox and state tax rate of 8.5%
	Set Node = Xml.DocumentElement.SelectSingleNode("/xfa:datasets/xfa:data/form1/total/chkStateTax")
	Node.text = "1"
	Set Node = Xml.DocumentElement.SelectSingleNode("/xfa:datasets/xfa:data/form1/total/numStateTaxRate")
	Node.text = "8.5"

	' Add purchase order items

	' First, delete two existing detail nodes under form1
	Set Node = Xml.DocumentElement.SelectSingleNode("/xfa:datasets/xfa:data/form1")
	Node.RemoveChild Xml.getElementsByTagName("detail")(0)
	Node.RemoveChild Xml.getElementsByTagName("detail")(0)

	' Add three new detail nodes
	for i = 1 to 3
		Set Detail = Xml.createElement("detail")
		Set Subdetail = Xml.createElement("txtPartNum")
		Subdetail.text = "PART#" & i
		Detail.appendChild Subdetail
		Set Subdetail = Xml.createElement("txtDescription")
		Subdetail.text = "Description #" & i
		Detail.appendChild Subdetail
		Set Subdetail = Xml.createElement("numQty")
		Subdetail.text = 5 * i
		Detail.appendChild Subdetail
		Set Subdetail = Xml.createElement("numUnitPrice")
		Subdetail.text = 100 * i
		Detail.appendChild Subdetail
		
		Node.insertBefore Detail, Xml.getElementsByTagName("total")(0)
	next

	' Plug the dataset back to the PDF form
	Doc.Form.XFADatasets = Xml.xml

	'Save document
	Path = Server.MapPath( "xfaform.pdf")
	FileName = Doc.Save( Path, false)

	Response.Write "Success! Download your PDF file <A TARGET=""_new"" HREF=" & Filename & ">here</A>"


%>

</BODY>
</HTML>
