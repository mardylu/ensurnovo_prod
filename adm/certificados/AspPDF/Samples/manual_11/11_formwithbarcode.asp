<HTML>
<HEAD>
<TITLE>AspPDF User Manual Chapter 11: Form with a Barcode</TITLE>
</HEAD>
<BODY>


<%
	' Form field values
	Dim arrValues(17) ' 18 values

	arrValues( 0) = "N-400" ' form type
	arrValues( 1) = "09/13/13" ' form revision
	arrValues( 2) = "1" ' page number
	arrValues( 3) = "123456789" ' A-Nunber
	arrValues( 4) = "D"	' Eligibility
	arrValues( 5) = "SECTION 317,INA"	' Explanation
	arrValues( 6) = "Smith"	' Legal name
	arrValues( 7) = "John"
	arrValues( 8) = "Frederick"
	arrValues( 9) = "Smith"	' Name as it appears on card
	arrValues(10) = "John"
	arrValues(11) = "Frederick"
	arrValues(12) = "" ' Other names
	arrValues(13) = ""
	arrValues(14) = ""
	arrValues(15) = ""
	arrValues(16) = ""
	arrValues(17) = ""

	Set Pdf = Server.CreateObject("Persits.Pdf")
	Set Doc = Pdf.OpenDocument( Server.MapPath("n-400.pdf") )

	' Disconnect XFA and JavaScript
	Doc.Form.Modify( "RemoveXFA=true; RemoveJavaScript=true" )

	' Fill out fields
	Set Field = Doc.Form.FindField("form1[0].#subform[0].#area[0].Line1_AlienNumber[0]")
	Field.SetFieldValueEx arrValues(3)

	' Option 5 is selected
	Set Field = Doc.Form.FindField("form1[0].#subform[0].Part1_Eligibility[0]")
	Field.SetFieldValueEx Field.FieldOnValue

	Set Field = Doc.Form.FindField("form1[0].#subform[0].Part1Line5_OtherExplain[0]")
	Field.SetFieldValueEx "RELIGIOUS DUTIES"

	Set Field = Doc.Form.FindField("form1[0].#subform[0].Line1_FamilyName[0]")
	Field.SetFieldValueEx arrValues(6)

	Set Field = Doc.Form.FindField("form1[0].#subform[0].Line1_GivenName[0]")
	Field.SetFieldValueEx arrValues(7)

	Set Field = Doc.Form.FindField("form1[0].#subform[0].Line1_MiddleName[0]")
	Field.SetFieldValueEx arrValues(8)

	Set Field = Doc.Form.FindField("form1[0].#subform[0].Line2_FamilyName[0]")
	Field.SetFieldValueEx arrValues(9)

	Set Field = Doc.Form.FindField("form1[0].#subform[0].Line2_GivenName[0]")
	Field.SetFieldValueEx arrValues(10)

	Set Field = Doc.Form.FindField("form1[0].#subform[0].Line2_MiddleName[0]")
	Field.SetFieldValueEx arrValues(11)

	' Draw PDF417 barcode
	Dim strBarcodeValue ' |-terminated array of values to encode as a barcode
	For i = 0 To 17
		strBarcodeValue = strBarcodeValue & arrValues(i) & "|"
	Next

	Set Page = Doc.Pages(1)
	Page.Canvas.DrawBarcode2D strBarcodeValue, "X=36; Y=36; Width=540; Height=108; QZV=6, QZH=8; " &_
		"ErrorLevel=5; Columns=28; Rows=5"

	' Flatten form
	Set FlatDoc = Pdf.OpenDocumentBinary( Doc.SaveToMemory() )
	FlatDoc.Form.Modify( "Flatten=true; FlattenAnnots=true" )

	Filename = FlatDoc.Save( Server.MapPath("formbarcode.pdf"), False )

	Response.Write "Success! Download your PDF file <A HREF=" & Filename & ">here</A>"
%>

</BODY>
</HTML>
