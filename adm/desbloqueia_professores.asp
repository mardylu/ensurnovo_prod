<%If session("key_usu")<>"ok" Then Response.Redirect "logout.asp"%>
<% if Session("key_blo")<>"ok" then erroMsg("Você não tem permissão para desbloquear professores")%>
<!-- #INCLUDE FILE="../library/parametros.asp" -->
<!-- #INCLUDE FILE="../library/conOpen.asp" -->
<!-- #INCLUDE FILE="../library/fErroMsg.asp" -->
<!-- #INCLUDE FILE="../library/fData.asp" -->
<!-- #INCLUDE FILE="../library/fFormataCep.asp" -->
<!-- #INCLUDE FILE="../library/fData.asp" -->
<!-- #INCLUDE FILE="../library/fFormataCPF.asp" -->
<!-- #INCLUDE FILE="../library/fFormataData.asp" -->
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
    <meta http-equiv="Pragma" content="no-cache" />
    <meta http-equiv="Expires" content="0" />

<%

' FORM para filtro do Professor
    id_professor = request("id_professor")

' FORM para atualizar o status do Professor
    id_professor = request("id_professor")
    status_prof  = request("status_prof")

' FORM para filtro por nome do Professor
    nome_prof = request("nome_prof")
    if ( nome_prof <> "" )  then
        id_professor=0
    end if


%>
<script type="text/javascript">

function newDoc1() {
	id_professor   = document.selecao.id_professor.value;
	url = 'desbloqueia_professores.asp?';
    url = url + 'id_professor=' + id_professor;
    window.location=url;
}
function newDoc2(indice, prof, stat) {

    // alert ("IDX: "  + indice);
    // alert ("PROF: " + prof);
    // alert ("STAT: " + stat);

    id_professor = prof;
    status_prof  = stat;
    url = 'desbloqueia_professores.asp?';
    url = url + 'id_professor=' + id_professor      + '&';
    url = url + 'status_prof='  + status_prof;
    window.location=url;
}

function newDoc3(nome_prof) {
    // alert('Nome_Prof' + nome_prof);
    id_professor = prof;
    nome_prof = document.form.nome_prof.value;
    url = 'desbloqueia_professores.asp?';
    if (nome_prof!='') {
        url = url + 'nome_prof=' + nome_prof;
    }
    window.location=url;
}

</script>

<%

    if ( len(status_prof) <> 0 )    then
        sql_atualiza = "UPDATE professores SET STATUS_PROFESSOR='" & status_prof & "' WHERE id_professor='" & id_professor & "'"

Response.Write ( "SQL: " & sql_atualiza & "<br>" )

        Con.Execute ( sql_atualiza )
    end if
%>

	<title>ENSUR Inscrições</title>
</head>

<body>
<div id="pagina">
	<!-- #INCLUDE FILE="include/topo.asp" -->
	<div id="conteudo">
		<table border = 0 width=100%>
			<tr><td WIDTH="10%"><a href="cad_professores.asp"><img src="img/btnp_novo.gif" border="0"></a></td><td WIDTH="90%"><h1>Bloqueio/Desbloqueio de Professor</h1></td></tr>
		</table>

		<table border="0" width="100%" cellspacing="10">
			<tr>
                <td WIDTH="10%" align="right">
                    <label  class="header">Professores</label>
                </td>
                <td WIDTH="90%" align="left">
               		<form  name="selecao" action="desbloqueia_professores.asp" method="get">
                    <input type="hidden" name="status_prof" id="status_prof" value="" >
                    <select name="id_professor" id="id_professor" onchange="newDoc1(this.value);">
                        <option value="0">Todos</option>
                        <%
                    		RS.Open "SELECT * FROM professores WHERE SIGA_PROJETO=" & SIGA_PROJETO & " OR SIGA_PROJETO=0 ORDER BY nome"
                			while not RS.EOF
                				%>
                				<option value="<%=RS("id_professor")%>"
                                <% if (cInt(id_professor) = RS("ID_PROFESSOR")) then Response.Write(" selected")%> >
                                <%=RS("nome")%></option>
                				<%
                                RS.MoveNext
                			wend
                            RS.Close
                        %>
                    </select>
                </td>
            </tr>


            <tr>
                <td width="10%" align="right">
                    <label class="header">Parte do Nome</label>
                </td>
                <td>
                    <input type="text" name="NOME_PROF" id="NOME_PROF" maxlength="100" size="50" VALUE="<% =request("NOME_PROF") %>"  onchange="newDoc3(this.value);">
                    </form>
                </td>
            </tr>
		</table>
        <br><br>
		<%
        sql_where = ""
        if id_professor=""  or isNumeric(id_professor)=false    then id_professor=0
        if ( id_professor <> 0 )    then sql_where = " AND id_professor='" & id_professor & "' "    end if
        if ( nome_prof <> "" )    then sql_where = " AND nome LIKE '%" & nome_prof & "%' "    end if
		sql_professor = "SELECT * FROM professores WHERE (SIGA_PROJETO=" & SIGA_PROJETO & " OR SIGA_PROJETO=0) "
        sql_professor = sql_professor & sql_where & " ORDER BY nome"

        ' Response.Write "SQL: " & sql_professor & "<br>"

		RS.Open (sql_professor)
		if RS.EOF then
			%><p>Nenhum professor cadastrado</p><%
		else
			%>
			<table id="tabela">
			<tr><td class="header">Nome</td>
                <td class="header">CPF</td>
                <td class="header">Status</td>
                <td class="header">Tel. Celular</td>
                <td class="header">Tel. Residencial</td>
                <td class="header">e-mail</td>
<!----                <td class="header">Mini-curriculo</td>        ---->
                <td class="header">Atv/Bloq</td>
                <td class="header">Excluir</td>
            </tr>
			<%
			c = 0
            idx = 0
			while not RS.EOF
                idx = idx + 1
				%><tr class="c<%=c%>">
					<td><a href="blo_professores.asp?cod=<%=RS("id_professor")%>"><%=RS("nome")%></a></td>
					<td><a href="blo_professores.asp?cod=<%=RS("id_professor")%>"><%=formatacpf(RS("cpf"))%></a></td>
					<td><a href="blo_professores.asp?cod=<%=RS("id_professor")%>"><%=(RS("status_professor"))%></a></td>
					<td><a href="blo_professores.asp?cod=<%=RS("id_professor")%>"><%=formatatel(RS("telefonecel"))%></a></td>
					<td><a href="blo_professores.asp?cod=<%=RS("id_professor")%>"><%=formatatel(RS("telefoneres"))%></a></td>
					<td><a href="blo_professores.asp?cod=<%=RS("id_professor")%>"><%=RS("email")%></a></td>
<!----					<td><a href="blo_professores.asp?cod=<%=RS("id_professor")%>"><%=RS("minicurriculo")%></a></td>     ---->

                    <% if (RS("STATUS_PROFESSOR") = "Ativo")  then  %>
					    <td align="center"><a alt="Bloquear o Professor" href="javascript:window.confirm('Confirma o bloqueio do Professor?')?window.location='troca_status_professores.asp?bloq=block&cod=<%=RS("id_professor")%>':void(0)"><img src="img/cad_fechado.jpg" border="0" /></a></td>
                    <% else %>
                        <td align="center"><a alt="Desbloquear o Professor"href="javascript:window.confirm('Confirma a ativação do Professor?')?window.location='troca_status_professores.asp?bloq=ativa&cod=<%=RS("id_professor")%>':void(0)"><img src="img/cad_aberto.jpg" border="0" /></a></td>
                    <% end if %>

					<td align="center"><a href="javascript:window.confirm('Confirma a exclusão do Professor?')?window.location='del_professores.asp?cod=<%=RS("id_professor")%>':void(0)"><img src="img/ic_del.gif" border="0" /></a></td>
                    </tr>
                <%


				c = 1 - c
				RS.MoveNext
			wend
		end if
		RS.Close
		%>
		</table>
	</div>
</div>
</body>
</html>
<%conClose%>