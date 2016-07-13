<!-- #INCLUDE FILE="../library/parametros.asp" -->
<!-- #INCLUDE file="../library/conOpen.asp" -->
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

	<title>ENSUR SIGA</title>
</head>
<body>

<% 
 
  
  Dim projetoID, query, opcao, data_inicio, data_final, curso, turma, estado, municipio, prioridade, cpf
   opcao = Request.QueryString("opcao")
   projetoID = Session("siga_projeto")
   data_inicial= Request.QueryString("data_inicial") 
   data_final= Request.QueryString("data_final")
   estado= Request.QueryString("estado")
   municipio= Request.QueryString("municipio")
   prioridade= Request.QueryString("prioridade")
   cpf= Request.QueryString("cpf")
   curso= Request.QueryString("curso")
   turma= Request.QueryString("turma")
   
   
     query = "SELECT ID_TURMA,COD_CURSO, [CURSO],[CODIGO_TURMA],[TIPO], DT_INICIO_TURMA, DT_FIM_TURMA" & _
	     ",[TUTOR],[CPF],[ALUNO],[UF],[MUNICIPIO], isnull(PRIORIDADE,'-') as PRIORIDADE " 				 & _
         ",isnull(GEOCODIGO, '-') as GEOCODIGO, UPPER(EFETIVO) as EFETIVO,[NATUREZA],[CARGO], isnull(ESPERA,'-') as ESPERA ,[STATUS] "     	 & _
         " FROM VIEW_GESTAO_SITUACAO_ASP where "  & _


		 " SIGA_PROJETO   =" & projetoID 
		
		if data_inicial <> "" then 
	      query = query & " and DT_INICIO_TURMA >=" & data_inicial
		end if
		
		if data_final <> "" then 
          query = query & " and DT_FIM_TURMA  <=" & data_final  
		end if
		
        if turma <> "undefined" and turma <> 0 then 
          query = query & " and ID_TURMA      =" &  turma
		end if
		
		if curso <> "" then
			if curso > 0  then
				 query = query & " and COD_CURSO     =" &  curso
			end if
		end if
		
		
		if estado > 0 then
          query = query & " and COD_UF_IBGE    =" &  estado
		end if
		
	
	
		if municipio > 0 then
          query = query & " and COD_MUNI_IBGE  =" &  municipio
		end if 
		
		if prioridade <> "todas" then
        query = query & " and PRIORIDADE       ='" &  prioridade & "'"
		end if 
		
		if cpf <> "" then
	      query = query & " and CPF			  ='" & replace(replace( cpf,".",""),"-","") &"'"
		end if 
		
		
		
		 query = query & "	ORDER BY ALUNO "

RS.Open(query)
 
Response.Write("<h2>Relatorio de Alunos por turma</h2>" )
   
   %>
	
<div id="pagina">
	<div id="conteudo">
    
    
       <table id="tableFilha" class="table table-responsive table-condensed filha" >
            <caption class="caption" ></caption>
            <thead>
				<tr style="color:#000; background-color:#CCC;">
                
                <th class="header" > Curso</th>
                <th class="header" > Turma</th>
        		<th class="header" > Modelo</th>
                <th class="header" > Início</th>
                <th class="header" > Término</th>
                <th class="header" > Tutor</th>
                <th> CPF</th>
                <th> Aluno</th>
                <th> UF</th>
                <th> Município</th>
                <th> Prioridade</th>
                <th> Geocódigo</th>
                <th> Efetivo</th>
                <th> Natureza</th>
                <th> Cargo</th>
                <th> Espera</th>
                <th> Status</th>
                
                
                </tr>
              
              <tbody>
  <%
    	  while not RS.EOF
		  
		  
		  %>

              <tr>

              

									<td  > <% Response.Write(RS("CURSO")) %> </td>
									<td  ><% Response.Write(RS("CODIGO_TURMA")) %>  </td>
									<td  ><% Response.Write(RS("TIPO")) %>  </td>
									<td  ><% Response.Write(RS("DT_INICIO_TURMA")) %>  </td>
									<td  ><% Response.Write(RS("DT_FIM_TURMA")) %>  </td>
									<td  ><% Response.Write(RS("TUTOR")) %>  </td>
                                    
                                     <td  ><% Response.Write(RS("CPF")) %> </td>
                                     <td  ><% Response.Write(RS("ALUNO")) %> </td>
                                     <td  ><% Response.Write(RS("UF")) %> </td>								 
                                     <td  ><% Response.Write(RS("MUNICIPIO")) %> </td>
                                     <td  ><% Response.Write(RS("PRIORIDADE")) %> </td>
                                     <td  ><% Response.Write(RS("GEOCODIGO")) %> </td>
                                     <td  ><% Response.Write(RS("EFETIVO")) %> </td>
                                     <td  ><% Response.Write(RS("NATUREZA")) %> </td>
                                     <td  ><% Response.Write(RS("CARGO")) %> </td>								 								 
                                     <td  ><% Response.Write(RS("ESPERA")) %> </td>								 								 
                                     <td  ><% Response.Write(RS("STATUS")) %> </td>
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
Response.AddHeader "Content-Disposition","attachment;filename=RelatorioAlunosTurma.xls" & fn

	%>
    
</body>
</html>
