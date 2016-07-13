<!-- #INCLUDE FILE="../library/parametros.asp" -->
<!-- #INCLUDE FILE="../library/conOpen.asp" -->
<!-- #include file="includes/JSON_2.0.4.asp"-->
<!-- #INCLUDE FILE="includes/fEmail.asp" -->

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


Function GeraGUID()
  Dim tmpTemp
  tmpTemp = Right(String(4,48) & Year(Now()),4)
  tmpTemp = tmpTemp & Right(String(4,48) & Month(Now()),2)
  tmpTemp = tmpTemp & Right(String(4,48) & Day(Now()),2)
  tmpTemp = tmpTemp & Right(String(4,48) & Hour(Now()),2)
  tmpTemp = tmpTemp & Right(String(4,48) & Minute(Now()),2)
  tmpTemp = tmpTemp & Right(String(4,48) & Second(Now()),2)
  GeraGUID = tmpTemp
End Function


' ====< INÍCIO - GRAVAR ARQUIVO DE LOG DAS INSCRIÇÕES
 '   Dim objeto, gravaArquivo, sArquivo, sEmail

  '  Set objeto = CreateObject("Scripting.FileSystemObject")
   ' sArquivo = Server.MapPath ("inscricoes.html")

'	If objeto.FileExists(sArquivo) = false Then
 '       Set gravaArquivo = objeto.CreateTextFile(sArquivo ,True)
  '  else
   '     Set gravaArquivo = objeto.OpenTextFile(sArquivo, 8, true)
   ' end if

   ' log_data =  "<br><br>====< Data e Hora do registro: " & date & " - " & hour(Now) & " : " & minute(Now) & " : " & second(Now)  & " >===="
   ' gravaArquivo.WriteLine(log_data)

    'For each objItem in Request.Querystring
    '	param_url = "nome = " & objItem & " e valor = " &Request.Querystring(objItem) &"<br>"
    '	param_url = objItem & " = " &Request.Querystring(objItem) &"<br>"
    '    gravaArquivo.WriteLine(param_url)
    'Next

    'gravaArquivo.close
    'set objeto =nothing
    'set gravaArquivo =nothing
' ====< FINAL - GRAVAR ARQUIVO DE LOG DAS INSCRIÇÕES


select case task
	case "cadastrar_aluno":
		acao_turma			=request("acao_turma")
		acao_aluno			=request("acao_aluno")
		cpf_cadastrado		=request("cpf_cadastrado")
		cpf_cadastrado		=replace(cpf_cadastrado,".","")
		cpf_cadastrado		=replace(cpf_cadastrado,"-","")
		password			=request("password")
		tipoenti			=request("tipoenti")
		cod_pais			=request("cod_pais")
		nome				=left(request("nome"),150)
		nome_social			=request("nome_social")
		dt_nascimento		=request("dt_nascimento")
		sexo				=request("sexo")
		cod_raca			=request("cod_raca")
		sEmail				=request("email")
		endereco			=left(request("endereco"),250)
		cep					=request("cep")
		formacao			=left(request("formacao"),100)
		COD_ENTI    		=request("cod_entidade")
    	cod_uf_ibge			=request("cod_uf_ibge")
    	cod_muni_ibge		=request("cod_muni_ibge")
    	cod_uf_enti			=request("cod_uf_enti")
    	cod_muni_enti		=request("cod_muni_enti")
    	cod_pos				=request("cod_pos")
    	pos					=left(request("pos"),100)
    	cod_escolaridade	=request("cod_escolaridade")
    	newsletter			=request("newsletter")
    	e_nome				=left(request("e_nome"),150)
    	e_endereco			=request("e_endereco")
    	e_cep				=request("e_cep")
    	e_email				=request("e_email")
    	e_www				=request("e_www")
    	e_cnpj				=request("e_cnpj")
    	telefone_pessoal	=left(request("telefone_pessoal"),18)
    	telefone_entidade	=left(request("telefone_entidade"),18) 'TELEFONE_PROFISSIONAL

    	expectativas		=request("expectativas")
		selecao_como_soube	=request("selecao_como_soube")      ' Select Como Soube'
    	como_soube			=request("como_soube")              ' Campo input outros
    	atuacao	            =request("atuacao")                 ' Campo radio sim=1 ou não=0
    	atuacao_bioma		=request("atuacao_bioma")           ' Campo input Qual

    	veracidade			=request("veracidade")
    	id_turma			=request("id_turma")
    	cod_aluno			=request("cod_aluno")

    	area_atuacao		=request("area_atuacao")
		setor				=request("setor")
    	cargo				=request("cargo")
		
		'/***********************************\
		Nome_instituicao_Ensino	=request("Nome_instituicao_Ensino")
		cod_uf_Instituicao		=request("cod_uf_Intituicao")
		cod_muni_Instituicao		=request("cod_muni_Instituicao")
		CNPJ_instituicao_Ensino	=request("CNPJ_instituicao_Ensino")
		previsao				=request("previsao")
		efetivo				=request("efetivo")
	'	/***********************************\
        if (atuacao = "1") then
            atuacao = 1
        else
            atuacao = 0
        end if


      



  ' Recupera o código do curso
    	sql = "select t.COD_CURSO, DT_INICIO_TURMA, DT_FIM_TURMA,titulo  "
    	sql = sql + " from turmas t inner join curso c on c.cod_curso = t.cod_curso "
		sql = sql + " where id_turma="&id_turma

    	RS.open sql
    	if not RS.eof then
    		cod_curso=RS("COD_CURSO")
            dt_inicio=RS("DT_INICIO_TURMA")         ' data de inicio
            dt_final=RS("DT_FIM_TURMA")             
    		nome_curso=RS("TITULO")
    	end if
    	RS.close

        dt_inicio   = replace(dt_inicio," ","")
        dt_final    = replace(dt_final," ","")
        dt_inicio   = mid(dt_inicio,7,2) & "/" & mid(dt_inicio,5,2) & "/" & mid(dt_inicio,1,4)
        dt_final    = mid(dt_final,7,2)  & "/" & mid(dt_final,5,2)  & "/" & mid(dt_final,1,4)
        data_inicio = replace(dt_inicio," ","")
        dt_final    = replace(dt_final," ","")
    	dt_cadastro = year(date())&right("00"&month(date()),2)&right("00"&day(date()),2)

    	
		if cod_uf_enti="" or cod_uf_enti = "null" or isnull("cod_uf_enti") then cod_uf_enti=0
    	if cod_pos="" or cod_pos = "null" or isnull("cod_pos")then cod_pos=0
		if isnull("cod_muni_enti") or cod_muni_enti="" or cod_muni_enti="null" then cod_muni_enti=0
		
		if tipoenti="" or tipoenti="null" then tipoenti=0
		if tipoenti=0  then tipoenti=21

		if COD_ENTI="" or COD_ENTI="null" then COD_ENTI=0


' ====< INÍCIO - Alteração para testar se o aluno já está inscrito no SIGA >====
'       sql = "SELECT * FROM ALUNO WHERE COD_ALUNO='"&COD_ALUNO&"'"
        sql = "SELECT * FROM ALUNO WHERE CPF='" & cpf_cadastrado &"'"
        RS.open sql
        if not RS.eof then
            acao_aluno="atualiza_aluno"
        else
            acao_aluno="incluir_aluno"
        end if
        RS.Close
' ====< FINAL - Alteração para testar se o aluno já está inscrito na turma >====

        if ( efetivo = "" )  then efetivo = "nao"   end if

        ' ====< Ajuste do TELEFONE_PESSOAL >====
		
        telefone_pessoal = replace(telefone_pessoal, "(", "")
        telefone_pessoal = replace(telefone_pessoal, ")", "")
        telefone_pessoal = replace(telefone_pessoal, "-", "")
        telefone_pessoal = replace(telefone_pessoal, " ", "")
'        telefone_pessoal = "55" & telefone_pessoal
		
		TEL_DDI = "55"
        TEL_DDD  = MID(telefone_pessoal,1,2)
        TEL = MID(telefone_pessoal,3,9)
		

        ' ====< Ajuste do TELEFONE_ENTIDADE >====
        telefone_entidade = replace(telefone_entidade, "(", "")
        telefone_entidade = replace(telefone_entidade, ")", "")
        telefone_entidade = replace(telefone_entidade, "-", "")
        telefone_entidade = replace(telefone_entidade, " ", "")
      '  telefone_entidade = "55" & telefone_entidade
	  

	  
	  	TEL_DDI_ENTI = "55"
        TEL_DDD_ENTI  = MID(telefone_entidade,1,2)
        TEL_ENTI = MID(telefone_entidade,3,9)

        ' ====< Ajuste do CEP - E_CEP - E_CNPJ >====
        cep    = replace(cep, "-", "")
        cep    = replace(cep, " ", "")
		
        e_cep  = replace(e_cep, "-", "")
        e_cep  = replace(e_cep, " ", "")
		
        e_cnpj = replace(e_cnpj, ".", "")
        e_cnpj = replace(e_cnpj, "/", "")
        e_cnpj = replace(e_cnpj, "-", "")
        e_cnpj = replace(e_cnpj, " ", "")
		
		 Response.Write("CNPJ " & e_cnpj)
		
		CNPJ_instituicao_Ensino = replace(CNPJ_instituicao_Ensino, ".", "")
        CNPJ_instituicao_Ensino = replace(CNPJ_instituicao_Ensino, "/", "")
        CNPJ_instituicao_Ensino = replace(CNPJ_instituicao_Ensino, "-", "")
        CNPJ_instituicao_Ensino = replace(CNPJ_instituicao_Ensino, " ", "")
		
        endereco = replace(endereco, "'", "''")
		
		if Nome_instituicao_Ensino = "" then
		
		Nome_instituicao_Ensino = ""
		cod_uf_Instituicao = 0
		cod_muni_Instituicao = 0
		CNPJ_instituicao_Ensino = ""
		previsao = ""
		end if
		

		'/*****************************************CRIA UMA ENTIDADE ******************************************************************************/
		'Caso não tenha sido encontrado a entidade o código "COD_ENTI" vira  = 0
		' E para gravar a entidade é necessário ter uma UF
		
		
		if COD_ENTI = 0 then
		
		 if  cod_uf_enti > 0  then
		
				Response.Write("</br>" )
		Response.Write("CODIGO_UF " & cod_uf_enti) 
			Response.Write("</br>" )
			
	        hoje = year(date())&right("00"&month(date()),2)&right("00"&day(date()),2)
	       
            e_endereco  = replace(e_endereco, "'", "''")
            endereco    = replace(endereco, "'", "''")

	
			sql  = "[Armazena_Entidade_SP] " & COD_ENTI &"," &cod_uf_enti&","&cod_muni_enti&","&tipoEnti&",0,'"&e_nome&"','"&e_endereco&"','"&e_cep&"','','"&e_www&"',1,"&telefone_entidade&",0,2,0,0,1,0,0,'"&hoje&"',0,0,0,'"&e_cnpj&"'"


			Response.Write(sql )


			RS.open sql
			if not RS.eof then
				COD_ENTI=RS("COD_ENTI")
			end if
			RS.close

			response.Write(	COD_ENTI)
		end if
		
		end if


'/*************************************************************************************************************************/


		
		
		
    	if acao_aluno = "atualiza_aluno" then
    	
	    	sql = "update aluno set "
    		sql = sql & "cpf='"&cpf_cadastrado&"',password='"&password&"',tipoenti='"&tipoenti&"',cod_pais='"&cod_pais&"',nome='"&nome&"'"
    		sql = sql & ",nome_social='"&nome_social&"',dt_nascimento='"&dt_nascimento&"',sexo='"&sexo&"',cod_raca='"&cod_raca&"',email='"&sEmail&"',endereco='"&endereco&"'"
    		sql = sql & ",cep='"&cep&"',formacao='"&formacao&"',cod_uf_ibge='"&cod_uf_ibge&"',cod_muni_ibge='"&cod_muni_ibge&"',cod_uf_enti='"&cod_uf_enti&"',cod_muni_enti='"&cod_muni_enti&"'"
    		sql = sql & ",cod_pos='"&cod_pos&"',pos='"&pos&"',cod_escolaridade='"&cod_escolaridade&"',newsletter='"&newsletter&"',e_nome='"&e_nome&"',e_endereco='"&e_endereco&"'"
    		sql = sql & ",e_cep='"&e_cep&"',e_email='"&e_email&"',e_www='"&e_www&"',e_cnpj='"&e_cnpj&"',telefone_pessoal='"&telefone_pessoal&"',telefone_entidade='"&telefone_entidade&"'"
    		sql = sql & ",expectativas='"&expectativas&"',como_soube='"&como_soube&"',atuacao_bioma='"&atuacao_bioma&"',veracidade='"&veracidade&"'"
    		sql = sql & ",setor='"&setor&"',cargo='"&cargo&"',origem='1',area_atuacao='"&area_atuacao&"',tem_atuacao_bioma='"&atuacao&"',selecao_como_soube='"&selecao_como_soube&"',efetivo='"&efetivo&"',cod_enti='"&COD_ENTI&"'" 
			sql = sql & ",INSTITUICAO_ENSINO = '"&Nome_instituicao_Ensino&"',INSTITUICAO_ENSINO_UF='"&cod_uf_Instituicao&"',INSTITUICAO_ENSINO_MUNICIPIO='"&cod_muni_Instituicao&"',INSTITUICAO_ENSINO_CNPJ='"&CNPJ_instituicao_Ensino&"',INSTITUICAO_ENSINO_CONCLUSAO='"&previsao&"'"

			sql = sql & ", TEL_DDI = '" & TEL_DDI &"'" 
    		sql = sql & ", TEL_DDD = '" & TEL_DDD&"'" 
			sql = sql & ", TEL = '"& TEL & "'" 
			
			sql = sql & ", TEL_DDI_ENTI = '" & TEL_DDI &"'" 
    		sql = sql & ", TEL_DDD_ENTI = '" & TEL_DDD_ENTI&"'" 
			sql = sql & ", TEL_ENTI = '"& TEL_ENTI & "'" 
			
			sql = sql & ", ID_USUARIO_LOG = '"& Session("id") & "'" 
		
			
			sql = sql & " where cod_aluno='"&cod_aluno&"'"
			
			Response.Write(sql)
			
			RS.open sql
			
			resultado="Dados do aluno atualizados com sucesso!"
    	else
'			telefone_entidade = "(55)"&telefone_entidade
'			telefone_pessoal = "(55)"&telefone_pessoal

			sql = "insert into aluno (cpf,password,tipoenti,cod_pais,nome,nome_social,dt_nascimento,sexo,cod_raca,email,endereco,cep,formacao,cod_uf_ibge,cod_muni_ibge,cod_uf_enti,cod_muni_enti,cod_pos,pos,cod_escolaridade,newsletter,e_nome,e_endereco,e_cep,e_email,e_www,e_cnpj,telefone_pessoal,telefone_entidade,expectativas,como_soube,atuacao_bioma,veracidade,setor,cargo,area_atuacao,tem_atuacao_bioma,selecao_como_soube,efetivo,cod_enti,origem, INSTITUICAO_ENSINO,INSTITUICAO_ENSINO_UF,INSTITUICAO_ENSINO_MUNICIPIO,INSTITUICAO_ENSINO_CNPJ,INSTITUICAO_ENSINO_CONCLUSAO, ID_USUARIO_LOG, TEL_DDI, TEL_DDD, TEL) values ("
			sql = sql & "'"&cpf_cadastrado&"','"&password&"','"&tipoenti&"','"&cod_pais&"','"&nome&"','"&nome_social&"','"&dt_nascimento&"','"&sexo&"','"&cod_raca&"','"&sEmail&"','"&endereco&"','"&cep&"','"&formacao&"','"&cod_uf_ibge&"','"&cod_muni_ibge&"','"&cod_uf_enti&"','"&cod_muni_enti&"','"&cod_pos&"','"&pos&"','"&cod_escolaridade&"','"&newsletter&"','"&e_nome&"','"&e_endereco&"','"&e_cep&"','"&e_email&"','"&e_www&"','"&e_cnpj&"','"&telefone_pessoal&"','"&telefone_entidade&"','"&expectativas&"','"&como_soube&"','"&atuacao_bioma&"','"&veracidade&"','"&setor&"','"&cargo&"','"&area_atuacao&"','"&atuacao&"','"&selecao_como_soube&"','"&efetivo&"','"&COD_ENTI&"','0','"&Nome_instituicao_Ensino&"','"&cod_uf_Instituicao&"','"&cod_muni_Instituicao&"','"&CNPJ_instituicao_Ensino&"','"&previsao&"','"&ID_USUARIO_LOG&"','"&TEL_DDI&"' ,'"&TEL_DDD&"','"&TEL&"')" 
		
			
			
			
				response.Write(sql)
			resultado="Aluno cadastrado com sucesso!"

			RS.open sql
			sql = "select * from aluno where cpf='"&cpf_cadastrado&"'"
			RS.open sql
			if not RS.eof then
				cod_aluno=RS("COD_ALUNO")
			end if
			RS.close
    	end if

' ====< INÍCIO - Alteração para testar se o aluno já está inscrito na turma >====
        sql = "SELECT * FROM TURMA_ALUNO WHERE COD_ALUNO='"&COD_ALUNO&"' AND ID_TURMA='"&ID_TURMA&"'"
' Response.Write (sql)
' Response.End
        RS.open sql
        if not RS.eof then
            acao_turma="atualizar_turma"
        else
            acao_turma="incluir_na_turma"
        end if
        RS.Close
' ====< FINAL - Alteração para testar se o aluno já está inscrito na turma >====

    	if acao_turma = "atualizar_turma" then
			sql = "update turma_aluno set "
			sql = sql & "ID_TURMA='"&ID_TURMA&"',COD_CURSO='"&COD_CURSO&"',COD_ALUNO='"&COD_ALUNO&"',DT_CADASTRO='"&DT_CADASTRO&"',COD_ENTI='"&COD_ENTI&"',EMAIL_ENTI='"&E_EMAIL&"',ENDERECO_ENTI='"&E_ENDERECO&"',CEP_ENTI='"&E_CEP&"' "
			sql = sql & "WHERE COD_ALUNO='"&COD_ALUNO&"' AND ID_TURMA='"&ID_TURMA&"'"
			RS.open sql
    	else
			sql = "INSERT INTO TURMA_ALUNO (ID_TURMA,COD_CURSO,COD_ALUNO,DT_CADASTRO,COD_ENTI,EMAIL_ENTI, "                             & _
                  "                         ENDERECO_ENTI,CEP_ENTI,STATUS,APROVADO,CUSTO_ENTI,PARCELAS,ASSOCIADO,FORMA_PGT) "           & _
                  "       VALUES ('"&ID_TURMA&"','"&COD_CURSO&"','"&COD_ALUNO&"','"&DT_CADASTRO&"','"&COD_ENTI&"',"                     & _
                  "'"&E_EMAIL&"','"&E_ENDERECO&"','"&E_CEP&"','MATRICULADO',0,0,0,0,0)"
' Response.write(sql)
			RS.open sql
			resultado = resultado & "Aluno matriculado na turma!"
    	end if


        sql = "SELECT NOME FROM ALUNO WHERE COD_ALUNO='"&COD_ALUNO&"'"
        RS.open sql
            NOME_FORM = RS("NOME")
        RS.Close

        ' Gerar email de confirmação de pré-inscrição
        if (acao_turma = "atualizar_turma") OR ( acao_turma = "incluir_na_turma" ) then

            ' GERA O TERMO DE COMPROMISSO
            guid = GeraGUID()

            URL = "http://cursos.ibam.org.br/pqga/termo/termo_gera.asp?cod_aluno=" & COD_ALUNO & "&id_turma=" & ID_TURMA & "&guid=" & guid
            Set GetConnection = CreateObject("Microsoft.XMLHTTP")
            GetConnection.Open "GET", URL, False
            GetConnection.Send

            ' CRIA A URL DO TERMO DE COMPROMISSO
            URL_TERMO = "http://cursos.ibam.org.br/pqga/termo/xtermo_" &guid & ".html"

            ' CRIA A MENSAGEM PARA CONFIRMAÇÃO DA PRÉ-INSCRIÇÃO
            MSG="<html> " & _
                "<head> " & _
                "<style> " & _
                "p { " & _
                "    font-family: Arial, Helvetica, sans-serif; " & _
                "    font-size: 12px; " & _
                "} " & _
                "</style> " & _
                "</head> " & _
                "<body lang=PT-BR link=blue vlink=purple style='tab-interval:35.4pt'> " & _
                "<div class=WordSection1> " & _
                "<p ></p> " & _
                "<table border=1 cellpadding=8 width='90%'> " & _
                " <tr> " & _
                "  <td width=573 valign=top> " & _
                "  <p> " & _
                "    <table width='100%'> " & _
                "        <tr> " & _
                "            <td align='left'  width='50%'><img width=269 height=108 src='http://cursos.ibam.org.br/pqga/images/Email_PQGA_logo01.png'></td> " & _
                "            <td align='right' width='50%'><img width=164 height=90 src='http://cursos.ibam.org.br/pqga/images/Email_PQGA_logo02.jpg'></td> " & _
                "        </tr> " & _
                "    </table> " & _
                "  </p> " & _
                "  </td> " & _
                " </tr> " & _
                " <tr> " & _
                "  <td width=573 valign=top> " & _
                " Prezado, " & NOME_FORM & "<br><br>"  & _
                " Obrigada por seu interesse em participar da capacitação oferecida pelo PQGA/IBAM. <br><br>"  & _
                " As turmas são formadas em função da demanda pelos cursos e conforme a ordem de pré-inscrição.  <br><br>"  & _
                " É importante ler atentamente o TERMO DE COMPROMISSO e, estando de acordo, aceitá-lo. Só a partir daí sua participação será possível. <br><br>"  & _
                " <b>Acesse: " & URL_TERMO & " </b> <br><br>"  & _
                " Quando a turma estiver disponível, serão informados os próximos passos necessários à sua participação. <br><br>"  & _
                " Se houver alguma dúvida, não hesite e entre em contato pelo e-mail pqga-ead@ibam.org.br ou pelo telefone (21) 2536-9774 ou 2536-9737 ou whatsapp (21)99805-0696 " & _
                " A equipe do Programa está permanentemente pronta para orientá-lo(a).  <br><br>"  & _
                "Att, <br><br>"  & _
                "Gestão Acadêmica PQGA/IBAM <br><br>"  & _
                "<a href=www.amazonia-ibam.org.br>www.amazonia-ibam.org.br</a><br>"  & _
                "<a href=www.facebook.com/pqgaibam>www.facebook.com/pqgaibam</a> <br><br><br><br>"   & _
                "  </td> " & _
                " </tr> " & _
                "</table> " & _
                "<p></p> " & _
                "</div> " & _
                "</body> " & _
                "</html>"

                EMAIL_DESTINO = sEmail
                TITULO = "Capacitação em Gestão Ambiental - Confirmação da Pré-Inscrição"
				
			'/**************************** DESCOMENTAR ENVIO DE EMAIL /****************************
			
			'	mailErr=envia_emailhtml(EMAIL_DESTINO,"pqga-ead@ibam.org.br",MSG,TITULO)

        end if

	case "procura_cpf":
		CPF = request("CPF")
		CPF = replace(CPF,".","")
		CPF = replace(CPF,"-","")

		sql = "SELECT * FROM ALUNO WHERE CPF='"&CPF&"'"
		RS.open sql

		if RS.EOF then
			resultado="erro"
		else
			resultado="success"
		end if
		RS.close
		
	case "recupere_meus_dados":
		CPF = request("CPF")
		SENHA = request("SENHA")
		ID_TURMA = request("ID_TURMA")

		sql = "SELECT * FROM ALUNO WHERE CPF='"&CPF&"' AND PASSWORD='"&SENHA&"'"
		
		
		RS.open sql
		if RS.EOF then
			RS.close
			sql = "SELECT * FROM ALUNO WHERE CPF='"&CPF&"'"
			RS.open sql
			if RS.eof then
				resultado="erro1"
			else
				resultado="erro"
			end if
			
			RS.close
		else
		
				
		
			sql = "exec Recuperar_Aluno_SP " & RS("COD_ALUNO") &","& ID_TURMA
			Session("id")=RS("COD_ALUNO")
			'Response.Write(sql & "<br><br>")
			arParams = array(ID_TURMA)
			Set cmd = Server.CreateObject("ADODB.Command")
			cmd.CommandText = sql
			Set cmd.ActiveConnection = Con
			QueryToJSON(cmd, arParams).Flush
			Con.Close : Set Con = Nothing

			
			
		'	RS.Close
		'	RS.open sql
		'	if RS.eof then
		'		resultado = resultado & "|false"
		'	else
		'		resultado = resultado & "|true"
		'	end if
		'	RS.close
		end if
		
	case "popula_raca"
	  	selecao	= request("selecao")
	  	if isnull(selecao) or selecao="" then
	  		selecao = 0
	  	end if
	  	selecao=int(selecao)

	    sql = "SELECT COD_RACA,DESCRICAO FROM RACA ORDER BY DESCRICAO"
		RS.open sql

		if RS.EOF then
			resultado="erro"
		else
		    resultado = resultado & "<option value=0>Não desejo declarar</option>"
			while not RS.EOF
			    resultado = resultado & "<option value='" & RS("COD_RACA") & "'"
			    if selecao = RS("COD_RACA") then
				    resultado = resultado & " selected "
				end if
			    resultado = resultado & ">" & RS("DESCRICAO")  & "</option>"
				RS.movenext
			wend
		end if
		
	case "popula_escolaridade":
	  	selecao	= request("selecao")
	  	if isnull(selecao) or selecao="" then
	  		selecao = 0
	  	end if
	  	selecao=int(selecao)

	    sql = "SELECT COD_ESCOLARIDADE,DESCRICAO FROM ESCOLARIDADE ORDER BY COD_ESCOLARIDADE"
		RS.open sql

		if RS.EOF then
			resultado="erro"
		else
		    resultado = resultado & "<option value= '0'> </option>"
			while not RS.EOF
			    resultado = resultado & "<option value='" & RS("COD_ESCOLARIDADE") & "'"
			    if selecao = RS("COD_ESCOLARIDADE") then
				    resultado = resultado & " selected "
				end if
			    resultado = resultado & ">" & RS("DESCRICAO")  & "</option>"
				RS.movenext
			wend
		end if
		
	case "popula_area":
	  	selecao	= request("selecao")
	  	if isnull(selecao) or selecao="" then
	  		selecao = 0
	  	end if
	  	selecao=int(selecao)

	    sql = "SELECT ID_ATUACAO,ATUACAO FROM AREA_ATUACAO WHERE ATIVO = 1 ORDER BY ID_ATUACAO"
		RS.open sql

		if RS.EOF then
			resultado="erro"
		else
		    resultado = resultado & "<option> </option>"
			while not RS.EOF
			    resultado = resultado & "<option value='" & RS("ID_ATUACAO") & "'"
			    if selecao = RS("ID_ATUACAO") then
				    resultado = resultado & " selected "
				end if
			    resultado = resultado & ">" & RS("ATUACAO")  & "</option>"
				RS.movenext
			wend
		end if
		
	case "popula_pos":
	  	selecao	= request("selecao")
	  	if isnull(selecao) or selecao="" or selecao = "null" then
	  		selecao = 0
	  	end if
	  	selecao=int(selecao)

	    sql = "SELECT COD_POS,DESCRICAO FROM POS ORDER BY COD_POS"
		RS.open sql

		if RS.EOF then
			resultado="erro"
		else
			while not RS.EOF
			    resultado = resultado & "<option value='" & RS("COD_POS") & "'"
			    if selecao = RS("COD_POS") then
				    resultado = resultado & " selected "
				end if
			    resultado = resultado & ">" & RS("DESCRICAO")  & "</option>"
				RS.movenext
			wend
		end if
		
	case "popula_instituicao":
	  	selecao	= request("selecao")
	  	if isnull(selecao) or selecao="" then
	  		selecao = 0
	  	end if
	  	selecao=int(selecao)

	    'sql = "SELECT ID_TIPO_ENTIDADE,DESCRICAO FROM TIPO_ENTIDADE WHERE DESCRICAO <>'Pessoa Física' and ATIVO = 1"
		sql = "exec Popula_Dados_SP 1, '', 1, 1"
		RS.open sql

		if RS.EOF then
			resultado="erro"
		else
			resultado = resultado & "<option> </option>"
			while not RS.EOF
			    resultado = resultado & "<option value='" & RS("ID") & "'"
			    if selecao = RS("ID") then
				    resultado = resultado & " selected "
				end if
			    resultado = resultado & ">" & RS("DESCRICAO")  & "</option>"
				RS.movenext
			wend
		end if
		
	case "popula_instituicao_dados"
	
	
	COD_UF_IBGE = request("cod_uf_enti")
	COD_MUNI_IBGE = request("cod_muni_enti")
	ID_TIPO_ENTIDADE = request("tipoenti")
	DESCRICAO = request("DESCRICAO")
	cnpj = request("cnpj")
	CODIGO = request("COD_ENTI") 

		if CODIGO = "0"  then 
    		CODIGO = ""
		
		END IF
		
		 sql = " SELECT COD_ENTI,COD_UF_IBGE,COD_MUNI_IBGE,ID_TIPO_ENTIDADE,ID_SUBTIPO_ENTIDADE,NOME,ENDERECO,CEP,EMAIL,WWW"
		 sql = sql & "  ,TEL1,TEL1NUM,TEL1RM,TEL2,TEL2NUM,TEL2RM,TEL3,TEL3NUM,TEL3RM,DATA_ATUALIZACAO,ADMIND_NATJUR"
		 sql = sql & "  ,ADMIND_AREA,EMPPRIV_RECEITA,EMPPRIV_CNPJ  FROM ENTIDADES where 1=1"
		 
		 
		 if CODIGO = "" then 
		 
			 if COD_UF_IBGE <> "" then 
			  sql = sql & "  and COD_UF_IBGE =" &  COD_UF_IBGE   
			  end if 
			
			 if COD_MUNI_IBGE <> "" then 
	
				 sql = sql & "  and COD_MUNI_IBGE =" & COD_MUNI_IBGE 
			 end if
				 
			  if ID_TIPO_ENTIDADE <> "" then 
				 sql = sql & " and ID_TIPO_ENTIDADE = " &  ID_TIPO_ENTIDADE 
			  end if	
			  		 
			  IF DESCRICAO <> "" THEN
				 sql = sql & " and NOME LIKE '%" & DESCRICAO & "%'"
			  END IF
				
				if cnpj <> "" then
					 sql = sql & " and EMPPRIV_CNPJ ='" & cnpj & "'"
				end if
		END IF
		if CODIGO <> ""  then
		 sql = sql & " and COD_ENTI = " & CODIGO
	  	end if
	'Response.Write(sql & "<br><br>")
	arParams = array(1)
	Set cmd = Server.CreateObject("ADODB.Command")
	cmd.CommandText = sql
	Set cmd.ActiveConnection = Con
	QueryToJSON(cmd, arParams).Flush
	Con.Close : Set Con = Nothing

		
	case "popula_pais":
	  	selecao	= request("selecao")
	  	if isnull(selecao) or selecao="" then
	  		selecao = 0
	  	end if
	  	selecao=int(selecao)

	    sql = "SELECT COD_PAIS,NOME FROM PAIS ORDER BY NOME"
		RS.open sql

		if RS.EOF then
			resultado="erro"
		else
		    resultado = resultado & "<option> </option>"
			while not RS.EOF
			    resultado = resultado & "<option value='" & RS("COD_PAIS") & "'"
			    if selecao = RS("COD_PAIS") then
				    resultado = resultado & " selected "
				end if
			    resultado = resultado & ">" & RS("NOME")  & "</option>"
				RS.movenext
			wend
		end if
		
	case "popula_uf":
	  	selecao	= request("selecao")
	  	if isnull(selecao) or selecao="" then
	  		selecao = 0
	  	end if
	  	selecao=int(selecao)

	    sql = "SELECT COD_UF_IBGE,SIGLA_UF FROM UF ORDER BY SIGLA_UF"
		RS.open sql

		if RS.EOF then
			resultado="erro"
		else
		    resultado = resultado & "<option> </option>"
			while not RS.EOF
			    resultado = resultado & "<option value='" & RS("COD_UF_IBGE") & "'"
			    if selecao = RS("COD_UF_IBGE") then
				    resultado = resultado & " selected "
				end if
			    resultado = resultado & ">" & RS("SIGLA_UF")  & "</option>"
				RS.movenext
			wend
		end if
		
	case "popula_municipio":
	  	uf	= request("uf")
	  	municipio = request("municipio")

	  	if isnull(uf) or uf="" then
	  		uf = 0
	  	end if
	  	if isnull(municipio) or municipio="" then
	  		municipio = 0
	  	end if

	  	uf=int(uf)
	  	municipio=int(municipio)

	    sql = "SELECT NOME_MUNI,COD_MUNI_IBGE,COD_UF_IBGE FROM MUNICIPIOS WHERE COD_UF_IBGE="&uf&" ORDER BY COD_UF_IBGE,NOME_MUNI"
		RS.open sql

		if RS.EOF then
			resultado="erro"
		else
		    resultado = resultado & "<option> </option>"
			while not RS.EOF
			    resultado = resultado & "<option value='" & RS("COD_MUNI_IBGE") & "'"
			    if municipio = RS("COD_MUNI_IBGE") then
				    resultado = resultado & " selected "
				end if
			    resultado = resultado & ">" & RS("NOME_MUNI")  & "</option>"
				RS.movenext
			wend
		end if
		
	
		
		
	case "NOVA_INTITUICAO":
	
	  	opcao = request("opcao")
		COD_UF_IBGE =  request("COD_UF_IBGE")
    	COD_MUNI_IBGE =  request("COD_MUNI_IBGE")
        ID_TIPO_ENTIDADE = request("ID_TIPO_ENTIDADE")
    	ID_ATUACAO = request("ID_ATUACAO")
 		NOME_INSTITUICAO = request("NOME_INSTITUICAO")
    	CNPJ = request("CNPJ")
    	WWW =  request("WWW")
    	STATUS = 3
		
	Set cmd = Server.CreateObject("ADODB.Command") 
			cmd.CommandText = "INTITUICAO_SP"
			cmd.CommandType = 4
					
		     Set cmd.ActiveConnection = Con
			   cmd.Parameters.Refresh
			   
			    cmd.Parameters("@OPCAO") = opcao
				cmd.Parameters("@COD_UF_IBGE") = COD_UF_IBGE
    		    cmd.Parameters("@COD_MUNI_IBGE") =  COD_MUNI_IBGE
			    cmd.Parameters("@ID_TIPO_ENTIDADE") = ID_TIPO_ENTIDADE
			    cmd.Parameters("@ID_ATUACAO") = ID_ATUACAO
			    cmd.Parameters("@NOME_INSTITUICAO") = NOME_INSTITUICAO
			    cmd.Parameters("@CNPJ") =  CNPJ
			    cmd.Parameters("@WWW") = WWW
			    cmd.Parameters("@STATUS") = STATUS
				
				
				

			Set rs  = cmd.execute
			resultado =  rs("Sequencial")
			Con.Close
			SET Con = Nothing
			


	  
	
end select
response.write (resultado)


%>
