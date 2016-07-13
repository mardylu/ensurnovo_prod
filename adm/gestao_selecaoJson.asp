
<% @LANGUAGE="VBSCRIPT" CODEPAGE="65001" %>
<!-- #include file="ajaxScripts/JSON_2.0.4.asp"-->
<!-- #INCLUDE FILE="../library/parametros.asp" -->
<!-- #INCLUDE file="../library/conOpenSIM.asp" -->
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
 
  
Dim opcao, codigo_uf_entidade, codigo_muni_entidade, query, SIGLA_UF_ALUNO, COD_MUNI_IBGE_ALUNO, cod, ordem, st,tipo_enti,area_atu, escolaridade,prioridade,bioma,funciona, termo, codAluno, codTurmaNova, cod_curso

	
	tipo_enti = Request.QueryString("tipoenti")
	area_atu = Request.QueryString("areaatu")
	escolaridade = Request.QueryString("escolaridade")
	prioridade = Request.QueryString("prioridade")
	bioma = Request.QueryString("bioma")
	funciona = Request.QueryString("funciona")
	termo = Request.QueryString("termo")

	opcao = Request.QueryString("opcao")
	cod = Request.QueryString("cod")
	codigo_uf_entidade = Request.QueryString("cod_uf")
	codigo_muni_entidade = Request.QueryString("cod_mu")
	ordem = Request.QueryString("ordem")
    codAluno = Request.QueryString("codAluno")
	codTurmaNova = Request.QueryString("codTurmaNova")
	cod_curso=Request.QueryString("cod_curso")
   '*****************************************
  ' Filtroa UF no Banco  WebsimSQl
   '*****************************************
   if opcao = 10 then
   
   
    query = "SELECT SIGLA_UF FROM UF "
	
	   if codigo_uf_entidade <> 0 then
	   
	   		query = query & " WHERE COD_UF_IBGE=" & codigo_uf_entidade
		   
		end if
	 
			
	end if
	
  '*****************************************
  ' Filtroa Municipio no Banco  WebsimSQl
  '*****************************************
	if opcao = 11 then
	query = "SELECT NOME_MUNI FROM MUNICIPIOS "                       & _
	
		  " WHERE COD_UF_IBGE='"   & codigo_uf_entidade   & "'"     & _
		  "   AND COD_MUNI_IBGE='" & codigo_muni_entidade & "'"
	
	end if
	
	
	
   '*****************************************
  ' Filtroa BIOMA_CIDADE no Banco  ensur_insc_novo2
   '*****************************************

  if opcao = 12 then
   		'query = "SELECT PRIORIDADE FROM BIOMA_CIDADE WHERE COD_UF_IBGE="&COD_UF_IBGE_ALUNO&" AND COD_MUNI_IBGE="&COD_MUNI_IBGE_ALUNO 'Alterado por Raphael Lopes em 09/06/2016
		query = "SELECT PRIORIDADE FROM MUNICIPIOS M INNER JOIN PRIORIDADE P ON M.PRIORIDADE=P.COD_PRIORIDADE WHERE COD_UF_IBGE="&COD_UF_IBGE_ALUNO&" AND COD_MUNI_IBGE="&COD_MUNI_IBGE_ALUNO
  end if		
  
 
   '*****************************************
  ' Filtroa Tipo Entidade no Banco  WebsimSQl
  '*****************************************
	if opcao = 13 then
	query = "SELECT ID_TIPO_ENTIDADE, DESCRICAO FROM TIPO_ENTIDADE ORDER BY DESCRICAO "                       
	end if
  
  
		
 if opcao >= 10 then
	
  'Response.Write(query & "<br><br>")

  arParams= array(opcao)
  
  Set cmd = Server.CreateObject("ADODB.Command")
  cmd.CommandText = query
  Set cmd.ActiveConnection = ConSIM
  QueryToJSON(cmd, arParams).Flush
  ConSIM.Close : Set ConSIM = Nothing
  
  end if

  
%>

<%
'*******************************************************************

	IF opcao = 1 then
	
	
		   query = "gestao_selecao_alunos_SP "& cod
					
					
					
					
					
	end if

 '*****************************************
  ' Filtroa AREA_ATUACAO no Banco  ensur_insc_novo2
  '*****************************************
	if opcao = 2 then
		query = "SELECT ID_ATUACAO, ATUACAO FROM AREA_ATUACAO "                       
	end if
	if opcao = 3 then
		query = "SELECT COD_ESCOLARIDADE, DESCRICAO FROM ESCOLARIDADE"                       
	end if

    if opcao = 4 then 
	
      query = "exec gestao_selecao_SP " & cod & " , " & ordem & " , " & tipo_enti & " , " & area_atu &" , " & escolaridade & " , " & prioridade & "," & bioma & " , " & funciona & " ," & termo  & " ," & cod_curso
	  
	end if

    if opcao = 5 then
	
   	query = "SELECT COUNT(*) FROM TURMA_ALUNO WHERE ID_TURMA="&codTurma&" AND COD_ALUNO="&codAluno

	
	end if
	
	if opcao = 6 then
	
	 query = "transferencia_alunos_SP " & cod & " , " & codTurmaNova & " , " & codAluno

	end if

   if opcao = 7 then
		
	 query = "SELECT T.ID_TURMA,C.TITULO,T.CODIGO_TURMA,T.COD_STATUS_TURMA,C.COD_STATUS FROM TURMAS T JOIN CURSO C ON T.COD_CURSO=C.COD_CURSO WHERE T.ID_TURMA<>'"&cod&"' AND (T.COD_STATUS_TURMA=1 OR T.COD_STATUS_TURMA=2 OR T.COD_STATUS_TURMA=3 OR T.COD_STATUS_TURMA=7) AND C.COD_STATUS=1 ORDER BY TITULO, CODIGO_TURMA"

	end if
	
	
	if opcao = 100 then
	

			Set cmd = Server.CreateObject("ADODB.Command") 
			cmd.CommandText = "transferencia_alunos_SP"
			cmd.CommandType = 4  
			
			
			cmd.Parameters("@cod_turma") = cod 
			cmd.Parameters("@cod_turma_nova") = codTurmaNova
			cmd.Parameters("@cod_aluno") =codAluno
		 Set cmd.ActiveConnection = Con
			cmd.Execute
			
			Con.Close
			SET Con = Nothing
			
			Response.Write(cod & "<br><br>")
	end if
	
 if opcao < 10 then
  
'	Response.Write(query & "<br><br>")
	arParams = array(cod)
	
	Set cmd = Server.CreateObject("ADODB.Command")
	cmd.CommandText = query
	Set cmd.ActiveConnection = Con
	QueryToJSON(cmd, arParams).Flush
	Con.Close : Set Con = Nothing

end if

%>

