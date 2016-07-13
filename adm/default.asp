<%if Session("adm")="ok" then response.redirect "cursos.asp"%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<title>ENSUR Inscrições - SIGA</title>
	<link rel="stylesheet" type="text/css" href="css/styles2.css" />
	<script language="javascript">
	function openWindow2() {
		myVar=open('esqueci.asp','Senha','scrollbars=yes,width=300,height=140');
	}
	</script>
</head>
<body class="fundo_img">

<div id="fundo_img">

<form name="form" action="login.asp" method="post">
<div id="login" align="left">
	<div id="login_top"></div>
	<div id="login_mid">
			<center>
			<h1>ENSUR - SIGA</h1>
			<h1>Sistema Integrado de Gestão Acadêmica -</h1>
			</center>
		<div id="info">

            <table>
            <tr>
                <td valign="top">
        			<p>login<br><input type="text" size=20 maxlength=20 name="LOGIN"></p>
        			<p>senha<br><input type="password" size=20 maxlength=20 name="SENHA"><br />
        			<p><a href="javascript:openWindow2();">esqueci minha senha</a></p>
        			<p><input type="submit" value="Enviar" class="buttonF"></p>
                </td>
                <td width="80px">
                </td>
                <td valign="top">
        			<p>projeto<br> <select name="siga_projeto"">
                                        <option value="1">ENSUR</option>
                                        <option value="2">PQGA</option>
                                        <option value="3">SDH</option>
                                    </select> <br /></p>
                </td>
            </tr>
            </table>
		</div>
	</div>
	<div id="login_bot"></div>
</div>
</form>

</div>

</body>
</html>
