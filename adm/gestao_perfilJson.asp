<% @LANGUAGE="VBSCRIPT" CODEPAGE="65001" %>
<!-- #INCLUDE FILE="../library/parametros.asp" -->
<!--#include file="ajaxScripts/JSON_2.0.4.asp"-->
<!-- #INCLUDE file="../library/conOpen.asp" -->

<%
Function QueryToJSON(dbcomm, params)
        Dim rs, jsa
        Set rs = dbcomm.Execute(,params,1)
        Set jsa = jsArray()
        Do While Not (rs.EOF Or rs.BOF)
                Set jsa(Null) = jsObject()
                For Each col In rs.Fields
                        jsa(Null)(col.Name) = col.Value
                Next
        rs.MoveNext
        Loop
        Set QueryToJSON = jsa
        rs.Close
End Function
%>


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
   
   '***********************
   'Conslta Curso
   '***********************
  if opcao = 1 then
  
   query = "SELECT COD_CURSO,TITULO FROM CURSO WHERE SIGA_PROJETO = ? ORDER BY TITULO"
  
   end if
   
   '***********************
   'Conslta Turmas
   '***********************
  if opcao = 2 then
 
   
    if curso = 0 then
                query="SELECT ID_TURMA,CODIGO_TURMA FROM TURMAS "           & _
                          "       WHERE SIGA_PROJETO='"&projetoID&"' "       & _
                          "       ORDER BY CODIGO_TURMA,ID_TURMA"
            else
                query="SELECT ID_TURMA,CODIGO_TURMA FROM TURMAS "           & _
                          "       WHERE SIGA_PROJETO='"&projetoID&"' "       & _
                          "         AND COD_CURSO='"&curso&"' "                 & _
                          "       ORDER BY CODIGO_TURMA"
       end if
   
  end if
  
   '***********************
   'Conslta Curso
   '***********************
  if opcao = 3 then
  
   query = "SELECT SIGLA_UF, NOME_UF, COD_UF_IBGE FROM UF ORDER BY NOME_UF"
  
   end if
   
   if opcao = 4 then

   query = "SELECT COD_UF_IBGE, COD_MUNI_IBGE, NOME_MUNI FROM MUNICIPIOS"    & _
                          "       WHERE COD_UF_IBGE='"&estado&"' "           & _
                          "       ORDER BY NOME_MUNI"

  end if
 

  if opcao = 5 then
  
 
 
			 query = " SELECT ORDENACAO,GRUPO, INDICADOR"   & _ 
					     ",sum([FREQUENCIA]) as FREQUENCIA" & _ 
		        		 ",sum(nao_aprovados) as NAO_APROVADOS"  & _ 
						 ",sum([Aprovados]) as APROVADOS"  & _ 
						 ",sum([Evadidos]) as EVADIDOS" & _ 
						 ",sum([Ausentes]) as AUSENTES" & _ 
						 ",sum([Efetivos]) as EFETIVOS" & _ 
        					" FROM VIEW_GESTAO_PERFIL_ASP " & _
						" where INDICADOR is not null and  [siga_projeto] =" & projetoID 
 
	    						
							   
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
								  query = query & " and UF    =" &  estado
								end if
								
							
							
								if municipio > 0 then
								  query = query & " and MUNICIPIO  =" &  municipio
								end if 
								
							
					 	query = query & "	group by ordenacao,GRUPO,indicador"
     					query = query & "	order by ordenacao,GRUPO,Indicador"
  
  
  end if
  
  if opcao = 6 then
  
  
  
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

	 
	 END IF 
 
'Response.Write(query & "<br><br>")
arParams = array(projetoID)

Set cmd = Server.CreateObject("ADODB.Command")
cmd.CommandText = query
Set cmd.ActiveConnection = Con
QueryToJSON(cmd, arParams).Flush
Con.Close : Set Con = Nothing
%> 






