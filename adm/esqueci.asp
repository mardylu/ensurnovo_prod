<HTML>
<HEAD>
<title>IBAM - Instituto Brasileiro de Administra��o Municipal</title>
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
	<form name="esqueci" method="post" action="esqueci.asp">
	<INPUT TYPE="hidden" NAME="task" VALUE="send">
	<table width=180 cellpadding=0 cellspacing=5 border=0 align=center>

	<tr>
	<td align=center>
	<BR><font face="Verdana" size=1 color="#213C81"><b>INFORME SEU LOGIN</b></font><br>
	</td>
	</tr>

	<tr>
	<td align=center><INPUT TYPE="text" NAME="LOGIN" SIZE="20" MAXLENGTH="50"></td>
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
	LOGIN=Request("LOGIN")
	senha=""
	IF LOGIN<>"" THEN
		LOGIN=REPLACE(LOGIN,"'","''")
		%>
		<!-- #INCLUDE FILE="../library/parametros.asp" -->
		<!-- #INCLUDE FILE="../library/conOpen.asp" -->
		<!-- #INCLUDE FILE="../library/fEmail.asp" -->
		<%
		RS.Open "SELECT SENHA,isNull(EMAIL,'') AS E_MAIL FROM USUARIO WHERE LOGIN='"&LOGIN&"'"
		IF RS.EOF THEN erro=1
		IF erro=0 THEN
			SENHA=RS("SENHA")
			E_MAIL=RS("E_MAIL")
			if Len(E_MAIL)=0 then erro=2
		END IF
		RS.Close
		conClose
	ELSE
		erro=1
	END IF

	IF erro=0 THEN
		mailErr=email(E_MAIL,"webensur@ibam.org.br","Sua senha para o sistema de inscri��es da ENSUR � "&SENHA,"Pedido de senha")
		%>
		<font face="Verdana" size=1 color="#7B8E92"><B>Sua senha foi enviada com sucesso para o e-mail <%=E_MAIL%>.</B>
		<br><BR><a href="javascript:window.close()">Fechar</a><br></font>
		<%
	ELSEIF erro=1 THEN
		%>
		<font face="Verdana" size=1 color="#7B8E92"><B>Login n�o encontrado no sistema. Favor contatar a administra��o do IBAM.</B>
		<br><BR><a href="javascript:window.close()">Fechar</a><br></font>
		<%
	ELSEIF erro=2 THEN
		%>
		<font face="Verdana" size=1 color="#7B8E92"><B>N�o existe e-mail cadastrado para este login no sistema. Favor contatar a administra��o do IBAM.</B>
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
