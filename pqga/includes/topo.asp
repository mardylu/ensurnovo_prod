<div id="topo">
	<div id="logo"></div>
</div>
<div id="menu">
<ul>
<%if session("pass")="ok" then%>
	<li><a href="logout.asp">logout</a></li>
<%end if%>
<li><a href="area_pessoal.asp">área pessoal</a></li>
<li><a href="default.asp?t=1">cursos descentralizados</a></li>
<li><a href="default.asp">cursos ensur</a></li>
<li><a href="http://www.ibam.org.br">site do ibam</a></li>
</ul>
</div>
