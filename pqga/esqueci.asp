<!-- #INCLUDE FILE="includes/parametros.asp" -->
<!-- #INCLUDE FILE="includes/conOpen.asp" -->
<!-- #INCLUDE FILE="includes/fEmail.asp" -->

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
		CPF=request.form("CPF")
		'CPF=mid(CPF,1,3)&"."&mid(CPF,4,3)&"."&mid(CPF,7,3)&"-"&mid(CPF,10,2)
		SQL = "SELECT PASSWORD,EMAIL FROM ALUNO WHERE CPF='"&CPF&"'"
		RS.Open SQL 
		IF RS.EOF THEN erro=1
		IF erro=0 THEN
			SENHA=RS("PASSWORD")
			E_MAIL=RS("EMAIL")
			if Len(E_MAIL)=0 then erro=2
		END IF
		RS.Close
		conClose
	ELSE
		erro=1
	END IF
	
	IF erro=0 THEN
        MSG = "Sua senha para o sistema de Capacita��o da Gest�o Ambiental �: <b>" & SENHA  & "</b><br><br>"        & _
              "(utilize a senha em negrito para acessar o site e fazer sua pr�-inscri��o)"
		mailErr=envia_emailhtml(E_MAIL,"pqga-ead@ibam.org.br",MSG," Capacita��o da Gest�o Ambiental - Pedido de senha")
		%>
		<font face="Verdana" size=1 color="#7B8E92"><B>Sua senha foi enviada com sucesso para o e-mail <%=E_MAIL%>.</B>
		<br><BR><a href="javascript:window.close()">Fechar</a><br></font>
		<%
	ELSEIF erro=1 THEN
		%>
		<font face="Verdana" size=1 color="#7B8E92"><B>CPF n�o encontrado no sistema. Favor contatar a administra��o do IBAM.</B>
		<br><BR><a href="javascript:window.close()">Fechar</a><br></font>
		<%
	ELSEIF erro=2 THEN
		%>
		<font face="Verdana" size=1 color="#7B8E92"><B>N�o existe e-mail cadastrado para este CPF no sistema. Favor contatar a administra��o do IBAM.</B>
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
