<!-- #INCLUDE FILE="../library/parametros.asp" -->
<!-- #INCLUDE file="../library/conOpen.asp" -->
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

	<title>ENSUR SIGA</title>
</head>
<body>

<%
 
  
Dim opcao, codigo_uf_entidade, codigo_muni_entidade, query, SIGLA_UF_ALUNO, COD_MUNI_IBGE_ALUNO, cod, ordem, st,tipo_enti,area_atu, escolaridade,prioridade,bioma,funciona, termo, codAluno, codTurmaNova

	
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
	
	
	    query = "exec gestao_selecao_SP " & cod & " , " & ordem & " , " & tipo_enti & " , " & area_atu &" , " & escolaridade & " , " & prioridade & "," & bioma & " , " & funciona & " ," & termo 
		
		
RS.Open(query)
 
Response.Write("<h2>Sele��o de Pr�-Inscritos - lista de alunos</h2>" )
Response.Write("<h3>Nome do curso: " & (RS("NOME_CURSO")) & "   Turma: " & (RS("CODIGO_TURMA"))& " </h3>")
Response.Write("<h3>In�cio: " & (RS("INICIO_TURMA")) & "   FIM: " & (RS("FIM_TURMA")) & "    </h3>" )
	
	%>
	
<div id="pagina">
	<div id="conteudo">
    
    
       <table id="tableFilha" class="table table-responsive table-condensed filha" >
            <caption class="caption" ></caption>
            <thead>
				<tr style="color:#000; background-color:#CCC;">
                  
                    <th data-sort="string" >Nome</th>
     				<th data-sort="string" class="header">CPF</th>
					<th data-sort="string" class="header">Nome Social</th>
					<th data-sort="string" class="header">Sexo</th>
					<th data-sort="string" class="header">Ra�a</th>
					<th data-sort="string" class="header">Nascimento</th>
					<th data-sort="string" class="header">Defici�ncia</th>
					<th data-sort="string" class="header">Telefone</th>
					<th data-sort="string" class="header">Fax</th>
					<th data-sort="string" class="header">E-mail</th>
					<th data-sort="string" class="header">Pa�s</th>
					<th data-sort="string" class="header">UF</th>
					<th data-sort="string" class="header">Munic�pio</th>
					<th data-sort="string" class="header">Geo-c�digo</th>
					<th data-sort="string" class="header">Prioridade</th>
					<th data-sort="string" class="header">Bioma</th>
					<th data-sort="string" class="header">Endere�o</th>
					<th data-sort="string" class="header">CEP</th>
					<th data-sort="string" class="header">Escolaridade</th>
					<th data-sort="string" class="header">Curso</th>
					<th data-sort="string" class="header">P�s-gradua��o</th>
					<th data-sort="string" class="header">�rea da p�s-gradua��o</th>
					<th data-sort="string" class="header">Estuda?</th>
					<th data-sort="string" class="header">Institui��o de Ensino</th>
					<th data-sort="string" class="header">CNPJ Educacional</th>
					<th data-sort="string" class="header">Previs�o de conclus�o</th>
     				<th data-sort="string" class="header">UF Educacional</th>
					<th data-sort="string" class="header">Munic�pio Educacional</th>
					<th data-sort="string" class="header">Geo-c�digo Educacional</th>
					<th data-sort="string" class="header">Prioridade Educacional</th>
					<th data-sort="string" class="header">Bioma Educacional</th>
					<th data-sort="string" class="header">V�nculo Institucional</th>
					<th data-sort="string" class="header">Tipo Institui��o</th>
				    <th data-sort="string" class="header">Nome Institui��o</a></th>
				    <th data-sort="string" class="header">CNPJ Institui��o</a></th>
					<th data-sort="string" class="header">Telefone Institui��o</th>
					<th data-sort="string" class="header">Fax Institui��o</th>
					<th data-sort="string" class="header">E-mail Institui��o</th>					
					<th data-sort="string" class="header">Setor</a></th>
                    <th data-sort="string" class="header">Cargo</th>
				    <th data-sort="string" class="header">�rea Atua��o</th>
    				<th data-sort="string" class="header">UF Institui��o</th>
    				<th data-sort="string" class="header">Munic�pio Institui��o</th>
					<th data-sort="string" class="header">Geo-c�digo Institui��o</th>
					<th data-sort="string" class="header">Prioridade Institui��o</th>
					<th data-sort="string" class="header">Bioma Institui��o</th>
					<th data-sort="string" class="header">Endere�o Institui��o</th>
					<th data-sort="string" class="header">CEP Institui��o</th>
					<th data-sort="string" class="header">Site Institui��o</th>
    	   		    <th data-sort="string" class="header" title="Servidor Efetivo sim n�o">SRV</th>
					<th data-sort="string" class="header">Senha</th>
					<th data-sort="string" class="header">Expectativas</th>
					<th data-sort="string" class="header">Como Soube</th>
					<th data-sort="string" class="header">Outros/especificar</th>
					<th data-sort="string" class="header">Atua��o Bioma</th>
					<th data-sort="string" class="header">Qual atua��o</th>
    	   		    <th data-sort="string" class="header" title="Aceite do Termo de Compromisso 1=sim 0=n�o">TC</th>
    	   			<th data-sort="string" class="header" title="Turma Finalizada">TF</th>
    	   			<th data-sort="string" class="header" title="Turma em Andamento">TN</th>
    	   			<th data-sort="string" class="header" title="Total Enturma��es">TE</th>
    	   			<th data-sort="string" class="header" title="Total de Aprova��es">TA</th>
    	   			<th data-sort="string" class="header" title="Total de Evas�es">TV</th>
    	   			<th data-sort="string" class="header" title="Total de Reprova��es">TR</th>
    	   			<th data-sort="string" class="header" title="Total de Nunca Acessou">TS</th>
    	   			<th data-sort="string" class="header" title="Data da Inscri��o">Inscri��o</th>

              
                 </tr>
               </thead>
               <tbody >
    
    <%
    	  while not RS.EOF
		  
		  
		  %>
     		<tr>  <td > <% Response.Write(RS("NOME")) %></td>
					
						 <td class="header1 collapsed" ><% Response.Write(RS("CPF")) %></td>
						 <td class="header1 collapsed" ><% Response.Write(RS("NOME_SOCIAL")) %></td>
						 <td class="header1 collapsed" ><% Response.Write(RS("SEXO")) %></td>
						 <td class="header1 collapsed" ><% Response.Write(RS("RACA")) %></td>
						 <td class="header1 collapsed" ><% Response.Write(RS("DT_NASCIMENTO")) %></td>
						 <td class="header1 collapsed" ><% Response.Write(RS("DEFICIENCIA")) %></td>
						 <td class="header1 collapsed" ><% Response.Write(RS("TELEFONE")) %></td>
						 <td class="header1 collapsed" ><% Response.Write(RS("FAX")) %></td>
						 <td class="header1 collapsed" ><% Response.Write(RS("EMAIL")) %></td>
						 <td class="header1 collapsed" ><% Response.Write(RS("PAIS")) %></td>
						 <td class="header1 collapsed" ><% Response.Write(RS("UF")) %></td>
						 <td class="header1 collapsed" ><% Response.Write(RS("MUNICIPIO")) %></td>
						 <td class="header1 collapsed" ><% Response.Write(RS("GEOCODIGO")) %></td>
						 <td class="header1 collapsed" ><% Response.Write(RS("PRIORIDADE")) %></td>
						 <td class="header1 collapsed" ><% Response.Write(RS("BIO")) %></td>
						 <td class="header1 collapsed" ><% Response.Write(RS("ENDERECO")) %></td>
						 <td class="header1 collapsed" ><% Response.Write(RS("CEP")) %></td>
						 <td class="header1 collapsed" ><% Response.Write(RS("ESCOLARIDADE")) %></td>
						 <td class="header1 collapsed" ><% Response.Write(RS("CURSO")) %></td>
						 <td class="header1 collapsed" ><% Response.Write(RS("POS")) %></td>
						 <td class="header1 collapsed" ><% Response.Write(RS("AREA")) %></td>
						 <td class="header1 collapsed" ><% Response.Write(RS("ESTUDA")) %></td>
						 <td class="header1 collapsed" ><% Response.Write(RS("INSTITUICAO_ENSINO")) %></td>
						 <td class="header1 collapsed" ><% Response.Write(RS("INSTITUICAO_ENSINO_CNPJ")) %></td>
						 <td class="header1 collapsed" ><% Response.Write(RS("INSTITUICAO_ENSINO_CONCLUSAO")) %></td>
						 <td class="header1 collapsed" ><% Response.Write(RS("INSTITUICAO_ENSINO_UF")) %></td>
						 <td class="header1 collapsed" ><% Response.Write(RS("INSTITUICAO_ENSINO_MUNICIPIO")) %></td>
						 <td class="header1 collapsed" ><% Response.Write(RS("INSTITUICAO_ENSINO_GEOCODIGO")) %></td>
						 <td class="header1 collapsed" ><% Response.Write(RS("INSTITUICAO_ENSINO_PRIORIDADE")) %></td>
						 <td class="header1 collapsed" ><% Response.Write(RS("INSTITUICAO_ENSINO_BIO")) %></td>
						 <td class="header1 collapsed" ><% Response.Write(RS("VINCULO")) %></td>
						 <td class="header1 collapsed" ><% Response.Write(RS("TIPO_INSTITUICAO")) %></td>
						 <td class="header1 collapsed" ><% Response.Write(RS("NOME_INSTITUICAO")) %> </td>
						 <td class="header1 collapsed" ><% Response.Write(RS("CNPJ")) %> </td>
						 <td class="header1 collapsed" ><% Response.Write(RS("TELEFONE_INSTITUICAO")) %> </td>
						 <td class="header1 collapsed" ><% Response.Write(RS("FAX_INSTITUICAO")) %> </td>
						 <td class="header1 collapsed" ><% Response.Write(RS("EMAIL_INSTITUICAO")) %> </td>
						 <td class="header1 collapsed" ><% Response.Write(RS("SETOR")) %> </td>
						 <td class="header1 collapsed" ><% Response.Write(RS("CARGO")) %> </td>
						 <td class="header1 collapsed" ><% Response.Write(RS("AREA_ATUACAO")) %> </td>
						 <td class="header1 collapsed" ><% Response.Write(RS("UF_INSTITUICAO")) %> </td>
						 <td class="header1 collapsed" ><% Response.Write(RS("MUNICIPIO_INSTITUICAO")) %> </td>
						 <td class="header1 collapsed" ><% Response.Write(RS("GEOCODIGO_INSTITUICAO")) %> </td>
						 <td class="header1 collapsed" ><% Response.Write(RS("PRIORIDADE_INSTITUICAO")) %> </td>
						 <td class="header1 collapsed" ><% Response.Write(RS("BIO_INSTITUICAO")) %> </td>
						 <td class="header1 collapsed" ><% Response.Write(RS("ENDERECO_INSTITUICAO")) %> </td>
						 <td class="header1 collapsed" ><% Response.Write(RS("CEP_INSTITUICAO")) %> </td>
						 <td class="header1 collapsed" ><% Response.Write(RS("SITE_INSTITUICAO")) %> </td>
						 
						 <td class="header1 collapsed" ><% Response.Write(RS("EFETIVO")) %> </td>
						 <td class="header1 collapsed" ><% Response.Write(RS("PASSWORD")) %> </td>
						 <td class="header1 collapsed" ><% Response.Write(RS("EXPECTATIVAS")) %> </td>
						 <td class="header1 collapsed" ><% Response.Write(RS("SELECAO_COMO_SOUBE")) %> </td>
						 <td class="header1 collapsed" ><% Response.Write(RS("COMO_SOUBE")) %> </td>
						 <td class="header1 collapsed" ><% Response.Write(RS("ATUACAO_BIOMA")) %> </td>
						 <td class="header1 collapsed" ><% Response.Write(RS("QUAL_ATUACAO_BIOMA")) %> </td>
						 <td class="header1 collapsed" ><% Response.Write(RS("TC")) %> </td>
						 <td class="header1 collapsed" ><% Response.Write(RS("TF")) %> </td>
						 <td class="header1 collapsed" ><% Response.Write(RS("TN")) %> </td>
						 <td class="header1 collapsed" ><% Response.Write(RS("TE")) %> </td>
						 <td class="header1 collapsed" ><% Response.Write(RS("TA")) %> </td>
						 <td class="header1 collapsed" ><% Response.Write(RS("TV")) %> </td>
						 <td class="header1 collapsed" ><% Response.Write(RS("TR")) %> </td>
						 <td class="header1 collapsed" ><% Response.Write(RS("TS")) %> </td>
						 <td class="header1 collapsed" ><% Response.Write(RS("DT_CADASTRO")) %> </td>
	
  
					
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
Response.AddHeader "Content-Disposition","attachment;filename=Selecao_PreInscritosLista.xls" & fn

	%>
    </body>
    </html>