<!-- #INCLUDE FILE="../library/parametros.asp" -->
<!-- #INCLUDE FILE="../library/conOpen.asp" -->
<!-- #include file="ajaxScripts/JSON_2.0.4.asp"-->
<!-- #INCLUDE FILE="../library/fEmail.asp" -->

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
' response.CharSet="iso-8859-1"
response.CharSet="UTF-8"
Response.Expires = 0
Response.CacheControl = "no-cache"
Response.AddHeader "Pragma", "no-cache"


task = request("task")

' Response.Write (task)
' Response.Write ("SCRIPT LANGUAGE='JavaScript' TYPE='text/javascript'>alert "&task&")
' Response.End



select case task
	case "pesquisa_aluno":
	
	
		CPF = request("cpf")
		NOME = request("nome")
			
			

		sql =   "SELECT A.COD_ALUNO, A.NOME, A.CPF, A.DT_NASCIMENTO FROM ALUNO A INNER JOIN TURMA_ALUNO TA ON A.COD_ALUNO = TA.COD_ALUNO  WHERE (A.CPF='"&CPF&"' OR A.ID_NUM = '" & CPF & "')"

		if NOME <> "" then 
			sql =  sql + " AND A.NOME LIKE  '%" & NOME & "%'"
		end if

		sql =  sql + "	GROUP BY A.COD_ALUNO, A.NOME, A.CPF, A.DT_NASCIMENTO "
		sql =  sql + " ORDER BY A.COD_ALUNO,  A.NOME" 		

		'Response.Write(sql)
		arParams = array(0)
		Set cmd = Server.CreateObject("ADODB.Command")
		cmd.CommandText = sql
		Set cmd.ActiveConnection = Con
		QueryToJSON(cmd, arParams).Flush
		Con.Close : Set Con = Nothing
			
			
			
	case "pesquisa_turma":
	
	
		COD_ALUNO = request("cod_aluno")
			
			
		sql =   "SELECT T.ID_TURMA,  T.COD_CURSO, A.COD_ALUNO, t.CODIGO_TURMA, T.DT_INICIO_TURMA,T.DT_FIM_TURMA,T.COD_STATUS_TURMA,TS.STATUS_TURMA,T.NOME_BREVE,TA.FORMA_PGT,FG.FORMA_DE_PAGAMENTO "
		sql = sql & " FROM TURMA_ALUNO TA INNER JOIN ALUNO A ON A.COD_ALUNO = TA.COD_ALUNO INNER JOIN TURMAS T ON TA.ID_TURMA = T.ID_TURMA "
		sql = sqL & " INNER JOIN TURMA_STATUS TS ON TS.COD_STATUS_TURMA = T.COD_STATUS_TURMA INNER JOIN FORMA_PAGAMENTO FG ON FG.FORMA_PAGTO = TA.FORMA_PGT "
		sql = sqL & " where A.COD_ALUNO = " & COD_ALUNO

		sql =  sql + " ORDER BY A.COD_ALUNO,  A.NOME" 					

		'Response.Write(sql)
		arParams = array(0)
		Set cmd = Server.CreateObject("ADODB.Command")
		cmd.CommandText = sql
		Set cmd.ActiveConnection = Con
		QueryToJSON(cmd, arParams).Flush
		Con.Close : Set Con = Nothing
			
						
		
	
	
	
	
	
end select 

Response.Write(resultado)

%>