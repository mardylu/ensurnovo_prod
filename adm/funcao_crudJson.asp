
<% @LANGUAGE="VBSCRIPT" CODEPAGE="65001" %>
<!-- #INCLUDE FILE="../library/parametros.asp" -->
<!--#include file="ajaxScripts/JSON_2.0.4.asp"-->
<!-- #INCLUDE file="../library/conOpen.asp" -->

<%

response.CharSet="UTF-8"
Response.Expires = 0
Response.CacheControl = "no-cache"
Response.AddHeader "Pragma", "no-cache"

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

	  Dim query, Descricao, opcao, id, ativo
	   opcao = Request.QueryString("opcao")
  	   descricao = Request.QueryString("descricao")
	   id = Request.QueryString("id")
	   ativo = Request.QueryString("ativo")
select case opcao
	case 1:
	
	  
	query = "Popula_Dados_SP " & opcao 
	if descricao <> "" then 
		query = query & ","& descricao &""
		else
		query = query & ",''"
	end if
	
	
	case 2:
	query = "Popula_Dados_SP " & opcao  &","& descricao &","& id &","& ativo
	
	case 3:

  	query = "Popula_Dados_SP " & opcao  &","& descricao &","& 0 &","& ativo
	
		
	
	case 4:
	
	  
	query = "Popula_Dados_SP " & opcao 
	if descricao <> "" then 
		query = query & ","& descricao &""
		else
		query = query & ",''"
	end if
	
	
	case 5:
	query = "Popula_Dados_SP " & opcao  &","& descricao &","& id &","& ativo
	
	case 6:

  	query = "Popula_Dados_SP " & opcao  &","& descricao &","& 0 &","& 3
	
	end select
	
	



'Response.Write(query & "<br><br>")

arParams = array(opcao)
Set cmd = Server.CreateObject("ADODB.Command")
cmd.CommandText = query
Set cmd.ActiveConnection = Con
QueryToJSON(cmd, arParams).Flush
Con.Close : Set Con = Nothing	


	
%>