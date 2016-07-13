<!-- #INCLUDE FILE="../library/parametros.asp" -->
<!-- #INCLUDE file="../library/conOpen.asp" -->
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

	<title>ENSUR SIGA</title>
</head>
<body>

<%

  Dim projetoID, query, opcao, data_inicio, data_final, curso, turma, estado, municipio, prioridade, stt, genero
   opcao = Request.QueryString("opcao")
   projetoID = Session("siga_projeto")
   data_inicial= Request.QueryString("data_inicial") 
   data_final= Request.QueryString("data_final")
   estado= Request.QueryString("estado")
   municipio= Request.QueryString("municipio")
   prioridade= Request.QueryString("prioridade")
   stt= Request.QueryString("stt")
   curso= Request.QueryString("curso")
   turma= Request.QueryString("turma")
   genero= Request.QueryString("genero")
	
 
			 query1 = " SELECT ORDENACAO,GRUPO, INDICADOR"   & _ 
					     ",sum([FREQUENCIA]) as FREQUENCIA" & _ 
		        		 ",sum(nao_aprovados) as NAO_APROVADOS"  & _ 
						 ",sum([Aprovados]) as APROVADOS"  & _ 
						 ",sum([Evadidos]) as EVADIDOS" & _ 
						 ",sum([Ausentes]) as AUSENTES" & _ 
						 ",sum([Efetivos]) as EFETIVOS" & _ 
        					" FROM VIEW_GESTAO_PERFIL_ASP " & _
						" where INDICADOR is not null and  [siga_projeto] =" & projetoID 
 
	    						
							   
								if data_inicial <> "" then 
								  query1 = query1 & " and DT_INICIO_TURMA >=" & data_inicial
								end if
								
								if data_final <> "" then 
								  query1 = query1 & " and DT_FIM_TURMA  <=" & data_final  
								end if
								
								if turma <> "undefined" and turma <> 0 then 
								  query1 = query1 & " and ID_TURMA      =" &  turma
								end if
								
								if curso <> "" then
									if curso > 0  then
										 query1 = query1 & " and COD_CURSO     =" &  curso
									end if
								end if
								
								
								if estado > 0 then
								  query1 = query1 & " and UF    =" &  estado
								end if
								
							
							
								if municipio > 0 then
								  query1 = query1 & " and MUNICIPIO  =" &  municipio
								end if 
								
							
					 	query1 = query1 & "	group by ordenacao,GRUPO,indicador"
     					query1 = query1 & "	order by ordenacao,GRUPO,Indicador"
  
 

  
  
  
				  query = "SELECT distinct ORDENACAO,GRUPO " 		 & _
						" FROM  VIEW_GESTAO_PERFIL_ASP "				 & _
	             		" where SIGA_PROJETO   =" & projetoID 
		
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
						
						
						
					query = query & "	group by ordenacao,GRUPO"
					query = query & "	order by ordenacao,GRUPO"

	 
  'RS.Open(query1)
  
  RS.Open(query1)
 
Response.Write("<h2>Relatório de Perfil do Aluno</h2>" )



	
%>

<div id="pagina">
	<div id="conteudo">
    
    <table id="tabela01" cellspacing="5" cellpadding="5" border="1">
					     <tr  style="color:#000; background-color:#CCC;"  >
								<td class='header1' > Grupo </td>
                                <td class='header1' > Indicador </td>
								<td class='header1' > Frequência</td>
								<td class='header1' > Percentual(%)</td>
								<td class='header1' > Não Aprovado</td>
								<td class='header1' > Aprovados</td>
								<td class='header1' > Evadidos</td>
								<td class='header1' > Ausentes</td>
								<td class='header1' > Efetivos</td>
						</tr>

          				  <%
         
						Dim	totalGeral, Percentual	
						totalGeral = 0
						  while not RS.EOF
						
					
								if RS("ORDENACAO") = 0 then 										
									totalGeral = RS("FREQUENCIA") 
								end if	

								
								 Percentual = (RS("FREQUENCIA") * 100) / totalGeral
								    Percentual = round(Percentual, 2)
                                          
					
							%>
									<tr >
                                         <td class="header1"> <%  Response.Write( RS("GRUPO") )		   %> </td>
										 <td class="header1"> <%  Response.Write( RS("INDICADOR") )    %>  </td>
										 <td class="header1"> <%  Response.Write( RS("FREQUENCIA") )   %>  </td>
										 <td class="header1"> <%  Response.Write( Percentual )  	    %>  </td>
										 <td class="header1"> <%  Response.Write( RS("NAO_APROVADOS")) %>  </td>								 
										 <td class="header1"> <%  Response.Write( RS("APROVADOS") )    %>  </td>
										 <td class="header1"> <%  Response.Write( RS("EVADIDOS") ) 	%>	</td>
										 <td class="header1"> <%  Response.Write( RS("AUSENTES") )  	%>  </td>
										 <td class="header1"> <%  Response.Write( RS("EFETIVOS") )  	%>  </td>
									</tr>
									
									
							<%
			Percentual = 0
			
			
	 		RS.MoveNext
			wend
       		RS.Close
		%>
         
          
            </table>
    </div>
    </div>
    
    
    <%
Response.Write("<h3>Exportado por: " & Session("nome") & " em: " & Day(Now) & "/" & month(Now) & "/" & year(Now) &  " </h3>" )
	
Response.ContentType = "application/vnd.ms-excel"
Response.AddHeader "Content-Disposition","attachment;filename=RelatorioDePerfilDoAluno.xls" & fn

	%>
    
    
    </body>
    </html>