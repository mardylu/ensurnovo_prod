<%
	const URLI = "cursos.ibam.org.br/"
	const servidor="10.0.0.1"
	const loginbanco="sqlibam"
	const senhabanco="sql"
	const tipobanco="MSSQL" 
	const banco="ensur_insc_novo2"
	const path_certificado="c:\inetpub\wwwroot\ensurnovo\adm\Certificados\"
	
	
	SITEURL = "http://www.ibam.org.br/"
	MUNIURL = "http://municipios.ibam.org.br/"
	CURSOURL = "http://cursos.ibam.org.br/"
	CONCURSOURL = "http://www.ibam-concursos.org.br/"
	CONCURSOSPURL = "http://www.ibamsp-concursos.org.br/"
	INFORMEURL = "http://informe.ibam.org.br/?p=subscribe&id=1"
	LAMURL = "http://lam.ibam.org.br/"
	LIVROURL = "http://ibamlivraria.webstorelw.com.br/"
	EADURL = "http://www.ead.ibam.org.br/moodle/"
	
	CURPAGE = LCase(Request.ServerVariables("SCRIPT_NAME"))

%>