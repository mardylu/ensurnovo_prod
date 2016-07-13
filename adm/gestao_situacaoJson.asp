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
  
 
 query = "SELECT ID_TURMA,COD_CURSO, [CURSO],[CODIGO_TURMA],[TIPO], DT_INICIO_TURMA, DT_FIM_TURMA" & _
	     ",[TUTOR],[CPF],[ALUNO],[UF],[MUNICIPIO], isnull(PRIORIDADE,'-') as PRIORIDADE " 				 & _
         ",isnull(GEOCODIGO, '-') as GEOCODIGO, UPPER(EFETIVO) as EFETIVO,[NATUREZA],[CARGO], isnull(ESPERA,'-') as ESPERA ,[STATUS] "     	 & _
         " FROM VIEW_GESTAO_SITUACAO_ASP where "  & _

		 " SIGA_PROJETO   =" & projetoID 
		
		if data_inicial <> "" then 
	      query = query & " and INICIO_TURMA >=" & data_inicial
		end if
		
		if data_final <> "" then 
          query = query & " and FIM_TURMA  <=" & data_final  
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
	      query = query & " and CPF_ORIGINAL ='" & replace(replace( cpf,".",""),"-","") &"'"
		end if 
		
		
		
		 query = query & "	ORDER BY ALUNO "
  
  end if
  
  if opcao = 6 then
  
			 query = "SELECT DISTINCT ID_TURMA, COD_CURSO, CURSO, CODIGO_TURMA, TIPO, isnull(TUTOR,'Proº Indefinido') as TUTOR, DT_INICIO_TURMA, DT_FIM_TURMA " & _
			          " FROM VIEW_GESTAO_SITUACAO_ASP"     & _
	 				  " where SIGA_PROJETO   =" & projetoID 
						
						if data_inicial <> "" then 
						  query = query & " and INICIO_TURMA >='" & data_inicial & "'"
						end if
						
						if data_final <> "" then 
						  query = query & " and FIM_TURMA  <='" & data_final  & "'"
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
						query = query & " and PRIORIDADE     ='" &  prioridade & "'"
						end if 
						
						if cpf <> "" then
						  query = query & " and CPF_ORIGINAL	  ='" &  replace(replace( cpf,".",""),"-","") &"'"
						end if 
						
						
					 query = query & "	ORDER BY CURSO, CODIGO_TURMA "
	 
	 END IF 
'Response.Write(query & "<br><br>")
arParams = array(projetoID)

Set cmd = Server.CreateObject("ADODB.Command")
cmd.CommandText = query
Set cmd.ActiveConnection = Con
QueryToJSON(cmd, arParams).Flush
Con.Close : Set Con = Nothing
%> 






