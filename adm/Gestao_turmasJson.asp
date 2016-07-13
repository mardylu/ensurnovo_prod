
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
   
   '***********************
   'Conslta Curso
   '***********************
  if opcao = 1 then
  
   query = "SELECT COD_CURSO ,TITULO FROM CURSO WHERE SIGA_PROJETO = ? ORDER BY TITULO"
  
   end if

'***********************   
'   Consulta Turmas
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
  '
  '***********************
  if opcao = 3 then
  
   query = "SELECT COD_STATUS_TURMA,STATUS_TURMA FROM TURMA_STATUS ORDER BY STATUS_TURMA"
  
   end if
   
   if opcao = 4 then
  
        if st<>0 then
		
			sqlwhere = " and C.COD_STATUS=" & st
		end if		
		
		if stt<>0 then
		
			sqlwhere = sqlwhere & " and U.COD_STATUS_TURMA=" & stt
		end if		

         if data_inicial <> "" then 
			  	sqlwhere = sqlwhere & " AND N.DT_INICIO_TURMA >=" & data_inicial
		 end if
			  
		if data_final <> "" then 
		  	sqlwhere = sqlwhere  & " and N.DT_FIM_TURMA <=" & data_final
		end if

		if curso>0 then
			sqlwhere = sqlwhere & " AND C.COD_CURSO="&curso
		end if
   
     if turma <> "undefined" and turma <> 0 then 
			sqlwhere = sqlwhere & " and N.ID_TURMA = '" & turma & "'"
			  end if
   
     if ord="" then
			sqlord = "TITULO"
		end if

		select case ord
			case "tp": sqlord = "T.DESCRICAO"
			case "tt": sqlord = "TITULO"
			case "st": sqlord = "C.COD_STATUS"
		end select
		  
			   query = "SELECT DISTINCT C.COD_CURSO,T.DESCRICAO AS TDESC,S.DESCRICAO AS SDESC,C.TITULO  "          & _
                        "       ,N.SIGA_PROJETO FROM TURMAS N"																															& _
                        "  LEFT JOIN TURMA_ALUNO  AS L  ON N.ID_TURMA=L.ID_TURMA "                                     					& _
                        "       JOIN TURMA_STATUS AS U  ON N.COD_STATUS_TURMA=U.COD_STATUS_TURMA "                      				& _
                        "       JOIN CURSO        AS C  ON C.COD_CURSO=N.COD_CURSO "   													& _
			            "  JOIN CURSO_STATUS S ON C.COD_STATUS=S.COD_STATUS "                                     						& _
                        "  JOIN CURSO_TIPO   T ON C.COD_TIPO=T.COD_TIPO "                                   							& _     
						"  JOIN CURSO_TIPO   AS CT ON CT.COD_TIPO=N.COD_TIPO "        													& _
			                "  WHERE C.SIGA_PROJETO=" & projetoID & sqlwhere & " "                               						& _
              "  ORDER BY " & sqlord
			  
			  
  end if
 
  if opcao = 5 then
 			query ="gestao_turma_SP " & projetoID &","& stt &","& st &","& curso &","&turma&",'"&data_inicial&"','"&data_final&"'"
  
  end if
 
'Response.Write(query & "<br><br>")
arParams = array(projetoID)

Set cmd = Server.CreateObject("ADODB.Command")
cmd.CommandText = query
Set cmd.ActiveConnection = Con
QueryToJSON(cmd, arParams).Flush
Con.Close : Set Con = Nothing
%> 






