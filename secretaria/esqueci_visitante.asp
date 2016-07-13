<HTML>
<HEAD>
<title>IBAM - Instituto Brasileiro de Administração Municipal</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<style>
A {
text-decoration: none;
color: #54686C;
}

A:hover {
text-decoration: underline;
}
</style>

</HEAD>

<BODY marginwidth=0 marginheight=0 topmargin=0 leftmargin=0 border=0 bgcolor="#FFFFFF">
<%
task=Request("task")
IF task<>"send" THEN
	%>
	<form name="esqueci" method="post" action="esqueci_visitante.asp">
	<INPUT TYPE="hidden" NAME="task" VALUE="send">
	<table width=180 cellpadding=0 cellspacing=5 border=0 align=center>

	<tr>
	<td align=center>
	<BR><font face="Verdana" size=1 color="#213C81"><b>INFORME SEU CPF</b></font><br>
	</td>
	</tr>

	<tr>
	<td align=center><INPUT TYPE="text" NAME="CPF" SIZE="20" MAXLENGTH="20"></td>
	</tr>

	<tr>
	<td align=center><br><INPUT TYPE="submit" VALUE="Enviar"><br></td>
	</tr>

	</table>
	</form>
<%ELSE%>
	<table width=180 cellpadding=0 cellspacing=5 border=0 align=center>

	<tr>
	<td align=left>
	<BR><BR>
	<%
	erro=0
	CPF=Request("CPF")
	senha=""
	IF CPF<>"" THEN
		CPF=REPLACE(CPF,"'","''")
		%>
		<!-- #INCLUDE FILE="../library/parametros.asp" -->
		<!-- #INCLUDE FILE="../library/conOpen.asp" -->
		<!-- #INCLUDE FILE="../library/fEmail.asp" -->
		<%
		CPF=request.form("CPF")
		CPF=mid(CPF,1,3)&"."&mid(CPF,4,3)&"."&mid(CPF,7,3)&"-"&mid(CPF,10,2)

		RS.Open "SELECT SENHA,EMAIL FROM VISITANTE WHERE CPF='"&CPF&"'"
		IF RS.EOF THEN erro=1
		IF erro=0 THEN
			SENHA=RS("SENHA")
			E_MAIL=RS("EMAIL")
			if Len(E_MAIL)=0 then erro=2
		END IF
		RS.Close
		conClose
	ELSE
		erro=1
	END IF
	
	IF erro=0 THEN
		mailErr=email(E_MAIL,"webensur@ibam.org.br","Sua senha para o sistema de inscrições da ENSUR é "&SENHA,"Pedido de senha")
		%>
		<font face="Verdana" size=1 color="#7B8E92"><B>Sua senha foi enviada com sucesso para o e-mail <%=E_MAIL%>.</B>
		<br><BR><a href="javascript:window.close()">Fechar</a><br></font>
		<%
	ELSEIF erro=1 THEN
		%>
		<font face="Verdana" size=1 color="#7B8E92"><B>CPF não encontrado no sistema. Favor contatar a administração do IBAM.</B>
		<br><BR><a href="javascript:window.close()">Fechar</a><br></font>
		<%
	ELSEIF erro=2 THEN
		%>
		<font face="Verdana" size=1 color="#7B8E92"><B>Não existe e-mail cadastrado para este CPF no sistema. Favor contatar a administração do IBAM.</B>
		<br><BR><a href="javascript:window.close()">Fechar</a><br></font>
		<%
	END IF
	%>
	</td>
	</tr>
	</table>
<%END IF%>
</BODY>
</HTML>
