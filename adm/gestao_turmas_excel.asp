<!-- #INCLUDE FILE="../library/parametros.asp" -->
<!-- #INCLUDE file="../library/conOpen.asp" -->
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

	<title>ENSUR SIGA</title>
</head>
<body>

<% 
 
  
  Dim query, opcao, data_inicio, data_final, stt, ord, sqlord, curso, turma, st
   opcao = Request.QueryString("opcao")
   projetoID = Session("siga_projeto")
   data_inicial= Request.QueryString("data_inicial") 
   data_final= Request.QueryString("data_final")
   stt= Request.QueryString("stt")
   st= Request.QueryString("st")
   curso= Request.QueryString("curso")
   turma= Request.QueryString("turma")
   ord= Request.QueryString("ord")
   
   query ="gestao_turma_SP " & projetoID &","& stt &","& st &","& curso &","&turma&",'"&data_inicial&"','"&data_final&"'"


RS.Open(query)

Response.Write("<h2>Seleção de Pré-Inscritos - lista de turmas</h2>" )
   
   %>
	
<div id="pagina">
	<div id="conteudo">
    
    
       <table  class='table table-condensed  table-striped filha'>
			<thead>
					<tr style="color:#000; background-color:#CCC;" >		
							<th >Curso</th>
							<th >Tipo</th>
							<th >Status Curso</th>
                            <th >Codigo da Turma</th>
										<th>Data de Inicio</th>
										<th>Data de Término</th>
										<th>Status</th>
										<th>Nome Breve</th>
										<th>Alunos</th>
					</tr>
					</thead>
				<tbody>
  <%
  Dim Alunos
    	  while not RS.EOF
		  
		  if RS("ALUNOS") = NULL THEN
		  Alunos = 0
		  ELSE
		  Alunos = RS("ALUNOS")

		  
		  END IF
		  %>

              <tr>
						<td> <% Response.Write(RS("TITULO")) %> </td>
						<td> <% Response.Write(RS("TDESC")) %> </td>
						<td> <% Response.Write(RS("SDESC")) %> </td>
		              	<td> <% Response.Write(RS("CODIGO_TURMA")) %> </td>
                        <td> <% Response.Write(RS("DT_INICIO_TURMA")) %> </td>
                        <td> <% Response.Write(RS("DT_FIM_TURMA")) %>    </td>
                        <td> <% Response.Write(RS("STATUS_TURMA")) %>    </td>
                        <td> <% Response.Write(RS("NOME_BREVE")) %>      </td>

                        <td><% Response.Write(Alunos) %> </td>


								
						    </tr>
              
              

              
              	<%
					
			
	 		RS.MoveNext
			wend
       		RS.Close
		%>
              </tbody>
                </table>
                </div>
                </div>
                
                    <%
Response.Write("<h3>Exportado por: " & Session("nome") & " em: " & Day(Now) & "/" & month(Now) & "/" & year(Now) &  " </h3>" )
	
Response.ContentType = "application/vnd.ms-excel"
Response.AddHeader "Content-Disposition","attachment;filename=SelecaoPreInscritos-listaTurmas.xls" & fn

	%>
    

</body>
</html>
