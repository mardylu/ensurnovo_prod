<%
	FirstName = Request("FirstName")
	If FirstName = "" Then FirstName = "John"

	LastName = Request("LastName")
	If LastName = "" Then LastName = "Smith"

	SSN1 = Request("SSN1")
	If SSN1 = "" Then SSN1 = "123"

	SSN2 = Request("SSN2")
	If SSN2 = "" Then SSN2 = "45"

	SSN3 = Request("SSN3")
	If SSN3 = "" Then SSN3 = "6789"

	Amount = Request("Amount")
	If Amount = "" Then Amount = "60000"

%>

<HTML>
<HEAD>
<TITLE>AspPDF Form Fill-out Demo</TITLE>
</HEAD>
<BODY>

<TABLE WIDTH="640"><TR><TD>
<FONT FACE="Arial" SIZE="2">
<A HREF="images/1040ez.pdf" TARGET="_new"><IMG ALT="Download the blank interactive 1040EZ form here" SRC="images/1040ez.gif" ALIGN="RIGHT" BORDER="0"></A>
<h3>AspPDF Form Fill-out Demo</h3>
AspPDF is capable of programmatically
filling in fields of an interactive PDF form such as the IRS 1040EZ.
For the sake of simplicity, only a few fields are used in this demo.
See Chapter 11 of the manual for more information.

<P>
<TABLE BORDER="0" CELLSPACING="3" CELLPADDING="0" STYLE="font-name:arial; font-size: 12">

<FORM NAME="Form" ACTION="asp_teste_00.asp" METHOD="POST">

<TR><TD><B>First Name</B>:</TD><TD><INPUT SIZE="40" TYPE="TEXT" NAME="FirstName" VALUE="<% = FirstName %>"></TD></TR>

<TR><TD><B>Last Name</B>:</TD><TD><INPUT SIZE="40" TYPE="TEXT" NAME="LastName" VALUE="<% = LastName %>"></TD></TR>

<TR><TD><B>SSN</B>:</TD><TD><INPUT SIZE="3" TYPE="TEXT" NAME="SSN1" VALUE="<% = SSN1 %>">-<INPUT SIZE="2" TYPE="TEXT" NAME="SSN2" VALUE="<% = SSN2 %>">-<INPUT SIZE="4" TYPE="TEXT" NAME="SSN3" VALUE="<% = SSN3 %>"></TD></TR>

<TR><TD><B>Can your parents (or someone else)<BR>claim you on their return?</B></TD><TD><INPUT SIZE="4" TYPE="CHECKBOX" NAME="CLAIM" <% If Request("CLAIM") = "on" Then Response.Write "checked" %>></TD></TR>

<TR><TD><B>Wages, salaries, and tips</B>:</TD><TD>$<INPUT SIZE="40" TYPE="TEXT" NAME="Amount" VALUE="<% = Amount %>"></TD></TR>



<TR><TD COLSPAN="2"><INPUT TYPE="SUBMIT" NAME="Save" VALUE="Generate PDF"></TD></TR>

</FORM>
</TABLE>

<%
	If Request("Save") <> "" Then

		Set PDF = Server.CreateObject("Persits.PDF")

		' Open an existing document, form W-9
		Set Doc = PDF.OpenDocument( Server.MapPath( "1040ez.pdf" ) )

		' Create font object
		Set Font = Doc.Fonts("Helvetica-Bold")

		' Set First Name
		Set Field = Doc.Form.FindField("f1-1")
		Field.SetFieldValue FirstName, Font

		' Set Last Name
		Set Field = Doc.Form.FindField("f1-2")
		Field.SetFieldValue LastName, Font


		' Set SSN (all three components)
		Set Field = Doc.Form.FindField("f1-8")
		Field.SetFieldValue SSN1, Font

		Set Field = Doc.Form.FindField("f1-9")
		Field.SetFieldValue SSN2, Font

		Set Field = Doc.Form.FindField("f1-10")
		Field.SetFieldValue SSN3, Font

		' Set Amount, use formatting
		Set Field = Doc.Form.FindField("f1-14") ' dollars
		Field.SetFieldValue "$" + Pdf.FormatNumber(Amount, "Precision=0, delimiter=true"), Font

		Set Field = Doc.Form.FindField("f1-15") ' cents
		Field.SetFieldValue "00", Font

		' Claim Checkbox. This field has two children
		Set Field = Doc.Form.FindField("c1-3")
		If Request("Claim") = "on" Then
			Field.Children(1).SetFieldValue "Yes", Nothing
		Else
			Field.Children(2).SetFieldValue "No", Nothing
		End If


		' We use Session ID for file names
		' false means "do not overwrite"
		' The method returns generated file name
		Path = Server.MapPath( "files") & "\" & Session.SessionID & ".pdf"
'		Path = Session.SessionID & ".pdf"
'        Path = Server.MapPath() & Session.SessionID & ".pdf"
        Path = "C:\inetpub\wwwroot\ensurnovo\adm\certificados\" & Session.SessionID & ".pdf"
		Response.Write(Path)
'        Response.End
		FileName = Doc.Save( Path, false)

		Response.Write "<P><B>Success. Your PDF file <font color=gray>" & FileName & "</font> can be downloaded <A TARGET=""_new"" HREF=""" & FileName & """><B>here</B></A></B>."
		Set Page = Nothing
		Set Doc = Nothing
		Set Pdf = Nothing

	End If
%>
<P>
<B><A HREF="demo_form.zip">Download source code (ASP and ASP.NET/C#) for this demo</A></B>

</FONT>
</TABLE>
</BODY>
</HTML>
