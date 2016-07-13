<%If session("key_ver")<>"ok" Then Response.Redirect "logout.asp"%>
<!-- #INCLUDE FILE="../library/parametros.asp" -->
<!-- #INCLUDE FILE="../library/conOpen.asp" -->
<!-- #INCLUDE FILE="../library/conOpenSIM.asp" -->
<!-- #INCLUDE FILE="../library/fErroMsg.asp" -->
<!-- #INCLUDE FILE="../library/fFormataData.asp" -->
<!-- #INCLUDE FILE="../library/fData.asp" -->
<!-- #INCLUDE FILE="../library/fCreateSel.asp" -->

<%

Set RS1 = Server.CreateObject("ADODB.Recordset")
RS1.CursorType = 0
RS1.ActiveConnection = Con

    SIGA_PROJETO=Session("siga_projeto")

%>

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

	<title>ENSUR SIGA</title>
</head>
<body>
<div id="pagina">
	<div id="conteudo">
	<%
		Set RS1 = Server.CreateObject("ADODB.Recordset")
		RS1.CursorType = 0
		RS1.ActiveConnection = Con

		Set RS2 = Server.CreateObject("ADODB.Recordset")
		RS2.CursorType = 0
		RS2.ActiveConnection = Con

		pv         = request("pv")
        planilha   = request("planilha")

		curso      = request("curso")
		turma      = request("turma")
		estado     = request("estado")
		municipio  = request("municipio")
		ini_mes    = request("ini_mes")
		ini_ano    = request("ini_ano")
		fim_mes    = request("fim_mes")
		fim_ano    = request("fim_ano")

		if pv=""            or isNumeric(pv)=false          then pv=0
		if curso=""         or isNumeric(curso)=false       then curso=0
		if turma=""         or isNumeric(turma)=false       then turma=0
		if estado=""        or isNumeric(estado)=false      then estado=0
		if municipio=""     or isNumeric(municipio)=false   then municipio=0
		if ini_mes  =""     or isNumeric(ini_mes)=false     then ini_mes=0      end if
		if ini_ano  =""     or isNumeric(ini_ano)=false     then ini_ano=2016   end if
		if fim_mes  =""     or isNumeric(fim_mes)=false     then fim_mes=0      end if
		if fim_ano  =""     or isNumeric(fim_ano)=false     then fim_ano=2016   end if

        if len(ini_mes)  = 1  then ini_mes = "0" & ini_mes   end if
        data_inicio = ini_ano & ini_mes & "00"
        if len(fim_mes)  = 1  then fim_mes = "0" & fim_mes   end if
        data_final  = fim_ano & "12" & "99"


' Response.Write ("pv: " & pv & "<br>")
' Response.Write ("planilha: " & planilha & "<br>")
' Response.End

Response.ContentType = "application/vnd.ms-excel"
Response.AddHeader "Content-Disposition","attachment;filename=planilha.xls" & fn

'   ========<   MONTAGEM DA SELEÇÃO DOS FILTROS PARA O SELECT DE CONTAGEM

    sql_filtro  = ""
    if ( curso<>0)       then sql_filtro = sql_filtro & "           AND TA.COD_CURSO='"       & curso        & "'"  end if
    if ( turma<>0)       then sql_filtro = sql_filtro & "           AND TA.ID_TURMA='"        & turma        & "'"  end if
    if ( estado<>0)      then sql_filtro = sql_filtro & "           AND A.COD_UF_IBGE='"      & estado       & "'"  end if
    if ( municipio<>0)   then sql_filtro = sql_filtro & "           AND A.COD_MUNI_IBGE='"    & municipio    & "'"  end if
    if data_inicio <> 0 then
    	sql_filtro = sql_filtro & " AND DT_INICIO_TURMA>=" & data_inicio & " "
    end if
    if data_final <> 0 then
    	sql_filtro = sql_filtro & " AND DT_FIM_TURMA<=" & data_final & " "
    end if

'   ========<   INICÍO DA CONTAGEM DOS INDICADORES DOS ALUNOS NO PQGA    >========

    if ( planilha = "OK" )   then
    %>
        <table id="tabela01" cellspacing="5" cellpadding="5" border="1">
            <tr class="c1">
                <td class="header" align="center">Indicador</td>
                <td class="header" align="center">Frequência</td>
                <td class="header" align="center">Percentual</td>
                <td class="header" align="center">Não Aprovados</td>
                <td class="header" align="center">Aprovados</td>
                <td class="header" align="center">Evadidos</td>
                <td class="header" align="center">Ausentes</td>
                <td class="header" align="center">Efetivos</td>
            </tr>
    <%
        '==============<  ACUMULADOR GERAL  >==============
        sql_acumuladores = ""
        sql_acumuladores = sql_acumuladores & "SELECT  COUNT (DISTINCT(a.cod_aluno)) as total_geral, "
        sql_acumuladores = sql_acumuladores & " COUNT(DISTINCT a.cod_aluno) as total_alunos, "
        sql_acumuladores = sql_acumuladores & " COUNT(DISTINCT CASE WHEN a.efetivo = 'sim' THEN a.cod_aluno END) as efetivo_sim, "
        sql_acumuladores = sql_acumuladores & " COUNT(DISTINCT CASE WHEN a.efetivo = 'nao' THEN a.cod_aluno END) as efetivo_nao, "
        sql_acumuladores = sql_acumuladores & " COUNT(DISTINCT CASE WHEN ta.status = 'APROVADO'  THEN a.cod_aluno END) as aprovado, "
        sql_acumuladores = sql_acumuladores & " COUNT(DISTINCT CASE WHEN ta.status = 'REPROVADO' THEN a.cod_aluno END) as reprovado, "
        sql_acumuladores = sql_acumuladores & " COUNT(DISTINCT a.cod_aluno) as total_avaliados, "
        sql_acumuladores = sql_acumuladores & " COUNT(DISTINCT CASE WHEN ta.certificado =  'C'  THEN a.cod_aluno END) as certificado_sim, "
        sql_acumuladores = sql_acumuladores & " COUNT(DISTINCT CASE WHEN ta.certificado <> 'C'  THEN a.cod_aluno END) as certificado_nao "
        '==============<  FROM ALUNO - JOIN - WHERE (filtros)  >==============
        sql_acumuladores = sql_acumuladores &   " FROM aluno AS a "
        sql_acumuladores = sql_acumuladores &   " JOIN turma_aluno AS ta ON ta.cod_aluno = a.cod_aluno "
        sql_acumuladores = sql_acumuladores &   " JOIN turmas AS t ON t.id_turma = ta.id_turma "
        sql_acumuladores = sql_acumuladores &   " WHERE t.siga_projeto=2 "
        sql_acumuladores = sql_acumuladores &   sql_filtro

        RS.Open (sql_acumuladores)
        if RS.EOF then
    		%>
                <p>Total Geral - Nenhum aluno cadastrado que atenda aos filtros selecionados</p>
            <%
        else
            total_geral = RS("TOTAL_GERAL")
%>
            <tr class="c1">
                <span style="font-weight: bold">
                <td><b>Total Geral de Participantes</b>                                                 </td>
                <td align="center">     <% Response.Write(RS("TOTAL_GERAL")) %>                         </td>
                <td align="center">     <%  percentual = ( RS("TOTAL_GERAL") / total_geral) * 100
                                            Response.Write ( percentual )      %>                       </td>
                <td align="center">     <%  Response.Write( RS("REPROVADO") )  %>                       </td>
                <td align="center">     <%  Response.Write( RS("APROVADO") )   %>                       </td>
                <td align="center"> -                                                                   </td>
                <td align="center"> -                                                                   </td>
                <td align="center">    <%  Response.Write( RS("EFETIVO_SIM") ) %>                       </td>
                </span>
            </tr>
            <tr class="c0" height="20">  <td colspan=8>  </td></tr>
<%
        end if
        RS.Close

        '==============<  ACUMULADOR POR SEXO  >==============
        sql_acumuladores = ""
        sql_acumuladores = sql_acumuladores & "SELECT  COUNT (DISTINCT(a.cod_aluno)) as total_geral, "
        sql_acumuladores = sql_acumuladores & " COUNT(DISTINCT a.cod_aluno) as total_alunos, "

        sql_acumuladores = sql_acumuladores & " COUNT(DISTINCT CASE WHEN a.sexo = '0'  THEN a.cod_aluno END) as mulher, "
        sql_acumuladores = sql_acumuladores & " COUNT(DISTINCT CASE WHEN a.sexo = '1'  THEN a.cod_aluno END) as homem, "
        sql_acumuladores = sql_acumuladores & " COUNT(DISTINCT CASE WHEN a.sexo = '0' AND a.efetivo='sim' THEN a.cod_aluno END) as mulher_servidor, "
        sql_acumuladores = sql_acumuladores & " COUNT(DISTINCT CASE WHEN a.sexo = '1' AND a.efetivo='sim' THEN a.cod_aluno END) as homem_servidor, "
        sql_acumuladores = sql_acumuladores & " COUNT(DISTINCT CASE WHEN a.sexo = '0' AND ta.status = 'APROVADO'  THEN a.cod_aluno END) as mulher_aprovado, "
        sql_acumuladores = sql_acumuladores & " COUNT(DISTINCT CASE WHEN a.sexo = '0' AND ta.status = 'REPROVADO' THEN a.cod_aluno END) as mulher_reprovado, "
        sql_acumuladores = sql_acumuladores & " COUNT(DISTINCT CASE WHEN a.sexo = '1' AND ta.status = 'APROVADO'  THEN a.cod_aluno END) as homem_aprovado, "
        sql_acumuladores = sql_acumuladores & " COUNT(DISTINCT CASE WHEN a.sexo = '1' AND ta.status = 'REPROVADO' THEN a.cod_aluno END) as homem_reprovado "
        '==============<  FROM ALUNO - JOIN - WHERE (filtros)  >==============
        sql_acumuladores = sql_acumuladores &   " FROM aluno AS a "
        sql_acumuladores = sql_acumuladores &   " JOIN turma_aluno AS ta ON ta.cod_aluno = a.cod_aluno "
        sql_acumuladores = sql_acumuladores &   " JOIN turmas AS t ON t.id_turma = ta.id_turma "
        sql_acumuladores = sql_acumuladores &   " WHERE t.siga_projeto=2 "
        sql_acumuladores = sql_acumuladores &   sql_filtro

        RS.Open (sql_acumuladores)
        if RS.EOF then
    		%>
                <p>Gênero - Nenhum aluno cadastrado que atenda aos filtros selecionados</p>
            <%
        else
%>
            <tr class="c1"><td colspan=8 align="left"><span style="font-weight: bold">Gênero</span></td></tr>
            <tr class="c0">
                <td><b>Total de Mulheres</b>                                                 </td>
                <td align="center">     <% Response.Write(RS("MULHER")) %>                         </td>
                <td align="center">     <%  percentual = ( RS("MULHER") / (RS("MULHER") + RS("HOMEM")) ) * 100
                                            percentual = round (percentual, 2)
                                            Response.Write ( percentual )      %>                       </td>
                <td align="center">     <%  Response.Write( RS("MULHER_REPROVADO") )  %>                       </td>
                <td align="center">     <%  Response.Write( RS("MULHER_APROVADO") )   %>                       </td>
                <td align="center"> -                                                                   </td>
                <td align="center"> -                                                                   </td>
                <td align="center">    <%  Response.Write( RS("MULHER_SERVIDOR") ) %>                   </td>
            </tr>

            <tr class="c0">
                <td><b>Total de Homens</b>                                                 </td>
                <td align="center">     <% Response.Write(RS("HOMEM")) %>                         </td>
                <td align="center">     <%  percentual = ( RS("HOMEM") / (RS("MULHER") + RS("HOMEM")) ) * 100
                                            percentual = round (percentual, 2)
                                            Response.Write ( percentual )      %>                       </td>
                <td align="center">     <%  Response.Write( RS("HOMEM_REPROVADO") )  %>                       </td>
                <td align="center">     <%  Response.Write( RS("HOMEM_APROVADO") )   %>                       </td>
                <td align="center"> -                                                                   </td>
                <td align="center"> -                                                                   </td>
                <td align="center">    <%  Response.Write( RS("HOMEM_SERVIDOR") ) %>                    </td>
            </tr>
            <tr class="c0" height="20">  <td colspan=8>  </td></tr>
    <%
        end if
        RS.Close

        '==============<  ACUMULADOR POR SERVIDORES  >==============
        sql_acumuladores = ""
        sql_acumuladores = sql_acumuladores & "SELECT  COUNT (DISTINCT(a.cod_aluno)) as total_geral, "
        sql_acumuladores = sql_acumuladores & " COUNT(DISTINCT a.cod_aluno) as total_alunos, "
        sql_acumuladores = sql_acumuladores & " COUNT(DISTINCT CASE WHEN a.efetivo = 'sim' THEN a.cod_aluno END) as total_efetivo, "
        sql_acumuladores = sql_acumuladores & " COUNT(DISTINCT CASE WHEN a.efetivo = 'sim' AND ta.status = 'APROVADO'  THEN a.cod_aluno END) as efetivo_aprovado, "
        sql_acumuladores = sql_acumuladores & " COUNT(DISTINCT CASE WHEN a.efetivo = 'sim' AND ta.status = 'REPROVADO' THEN a.cod_aluno END) as efetivo_reprovado "
        '==============<  FROM ALUNO - JOIN - WHERE (filtros)  >==============
        sql_acumuladores = sql_acumuladores &   " FROM aluno AS a "
        sql_acumuladores = sql_acumuladores &   " JOIN turma_aluno AS ta ON ta.cod_aluno = a.cod_aluno "
        sql_acumuladores = sql_acumuladores &   " JOIN turmas AS t ON t.id_turma = ta.id_turma "
        sql_acumuladores = sql_acumuladores &   " WHERE t.siga_projeto=2 "
        sql_acumuladores = sql_acumuladores &   sql_filtro

        RS.Open (sql_acumuladores)
        if RS.EOF then
    		%>
                <p>Servidores - Nenhum aluno cadastrado que atenda aos filtros selecionados</p>
            <%
        else
%>
            <tr class="c1"><td colspan=8 align="left"><span style="font-weight: bold">Servidores</span></td></tr>
            <tr class="c0">
                <td><b>Total de Servidores Efetivo</b>                                                 </td>
                <td align="center">     <% Response.Write(RS("TOTAL_EFETIVO")) %>                         </td>
                <td align="center">     <%  percentual = ( RS("TOTAL_EFETIVO") / RS("TOTAL_GERAL") ) * 100
                                            percentual = round (percentual, 2)
                                            Response.Write ( percentual )      %>                       </td>
                <td align="center">     <%  Response.Write( RS("EFETIVO_REPROVADO") )  %>                       </td>
                <td align="center">     <%  Response.Write( RS("EFETIVO_APROVADO") )   %>                       </td>
                <td align="center"> -                                                                   </td>
                <td align="center"> -                                                                   </td>
                <td align="center">    <%  Response.Write( RS("TOTAL_EFETIVO") ) %>                   </td>
            </tr>
            <tr class="c0" height="20">  <td colspan=8>  </td></tr>
    <%
        end if
        RS.Close

' xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx==============
        '==============<  ACUMULADOR POR ESCOLARIDADE  >==============
%>
            <tr class="c1"><td colspan=8 align="left"><span style="font-weight: bold">Escolaridade</span></td></tr>
            <!---- <tr class="c0">   ---->
<%
        sql_inicio = ""
        sql_inicio = sql_inicio & "SELECT  COUNT (DISTINCT(a.cod_aluno)) as total_geral, "
        sql_inicio = sql_inicio & " COUNT(DISTINCT a.cod_aluno) as total_alunos, "

        sql_escolaridade = "SELECT COD_ESCOLARIDADE, DESCRICAO FROM ESCOLARIDADE"
        RS.Open(sql_escolaridade)
        c = 0
        while not RS.EOF
            sql_acumula = ""
            cod_escolaridade  = RS("COD_ESCOLARIDADE")
            desc_escolaridade = RS("DESCRICAO")

            sql_acumula = sql_acumula &   " COUNT(DISTINCT CASE WHEN a.cod_escolaridade = '"                  & _
                                                      cod_escolaridade & "'  THEN a.cod_aluno END) as escolaridade, "
            sql_acumula = sql_acumula &   " COUNT(DISTINCT CASE WHEN a.cod_escolaridade = '"                  & _
                                                      cod_escolaridade & "'  AND ta.status = 'APROVADO' THEN a.cod_aluno END) as escolaridade_aprovado, "
            sql_acumula = sql_acumula &   " COUNT(DISTINCT CASE WHEN a.cod_escolaridade = '"                  & _
                                                      cod_escolaridade & "'  AND ta.status = 'REPROVADO' THEN a.cod_aluno END) as escolaridade_reprovado, "
            sql_acumula = sql_acumula &   " COUNT(DISTINCT CASE WHEN a.cod_escolaridade = '"                  & _
                                                      cod_escolaridade & "'  AND efetivo = 'sim' THEN a.cod_aluno END) as escolaridade_efetivo, "
            sql_acumula = sql_acumula &   " COUNT(DISTINCT CASE WHEN a.cod_escolaridade = '"                  & _
                                                      cod_escolaridade & "'  THEN a.cod_aluno END) as escolar"
            '==============<  FROM ALUNO - JOIN - WHERE (filtros)  >==============
            sql_acumula = sql_acumula &   " FROM aluno AS a "
            sql_acumula = sql_acumula &   " JOIN turma_aluno AS ta ON ta.cod_aluno = a.cod_aluno "
            sql_acumula = sql_acumula &   " JOIN turmas AS t ON t.id_turma = ta.id_turma "
            sql_acumula = sql_acumula &   " WHERE t.siga_projeto=2 "
            sql_acumula = sql_acumula &   sql_filtro

            sql_acumuladores = sql_inicio + sql_acumula
            RS1.Open (sql_acumuladores)
%>
            <tr class="c<%=c%>">
                <td><b><% Response.Write( desc_escolaridade ) %></b>                                              </td>
                <td align="center">     <% Response.Write(RS1("ESCOLARIDADE")) %>                               </td>
                <td align="center">     <%  percentual = ( RS1("ESCOLARIDADE") / RS1("TOTAL_ALUNOS") ) * 100
                                            percentual = round (percentual, 2)
                                            Response.Write ( percentual )      %>                       </td>
                <td align="center">     <%  Response.Write( RS1("ESCOLARIDADE_REPROVADO") )  %>                       </td>
                <td align="center">     <%  Response.Write( RS1("ESCOLARIDADE_APROVADO") )   %>                       </td>
                <td align="center"> -                                                                   </td>
                <td align="center"> -                                                                   </td>
                <td align="center">    <%  Response.Write( RS1("ESCOLARIDADE_EFETIVO") ) %>                   </td>
            </tr>
<%          RS1.Close
            c = 1 -c
            RS.MoveNext
        wend
        RS.Close

' xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx==============
        '==============<  ACUMULADOR POR POS-GRADUAÇÃO  >==============
%>
            <tr class="c0" height="20">  <td colspan=8>  </td></tr>
            <tr class="c1"><td colspan=8 align="left"><span style="font-weight: bold">Graduação</span></td></tr>
<%
        sql_inicio = ""
        sql_inicio = sql_inicio & "SELECT  COUNT (DISTINCT(a.cod_aluno)) as total_geral, "
        sql_inicio = sql_inicio & " COUNT(DISTINCT a.cod_aluno) as total_alunos, "

        sql_pos = "SELECT COD_POS, DESCRICAO FROM POS"
        RS.Open(sql_pos)
        c = 0
        while not RS.EOF
            sql_acumula = ""
            cod_pos          = RS("COD_POS")
            pos_descricao    = RS("DESCRICAO")

            sql_acumula = sql_acumula &   " COUNT(DISTINCT CASE WHEN a.cod_pos = '"                  & _
                                                      cod_pos & "'  THEN a.cod_aluno END) as graduacao, "
            sql_acumula = sql_acumula &   " COUNT(DISTINCT CASE WHEN a.cod_pos = '"                  & _
                                                      cod_pos & "'  AND ta.status = 'APROVADO' THEN a.cod_aluno END) as pos_aprovado, "
            sql_acumula = sql_acumula &   " COUNT(DISTINCT CASE WHEN a.cod_pos = '"                  & _
                                                      cod_pos & "'  AND ta.status = 'REPROVADO' THEN a.cod_aluno END) as pos_reprovado, "
            sql_acumula = sql_acumula &   " COUNT(DISTINCT CASE WHEN a.cod_pos = '"                  & _
                                                      cod_pos & "'  AND efetivo = 'sim' THEN a.cod_aluno END) as pos_efetivo, "
            sql_acumula = sql_acumula &   " COUNT(DISTINCT CASE WHEN a.cod_pos = '"                  & _
                                                      cod_pos & "'  THEN a.cod_aluno END) as pos_graduacao"
            '==============<  FROM ALUNO - JOIN - WHERE (filtros)  >==============
            sql_acumula = sql_acumula &   " FROM aluno AS a "
            sql_acumula = sql_acumula &   " JOIN turma_aluno AS ta ON ta.cod_aluno = a.cod_aluno "
            sql_acumula = sql_acumula &   " JOIN turmas AS t ON t.id_turma = ta.id_turma "
            sql_acumula = sql_acumula &   " WHERE t.siga_projeto=2 "
            sql_acumula = sql_acumula &   sql_filtro

            sql_acumuladores = sql_inicio + sql_acumula
            RS1.Open (sql_acumuladores)
%>
            <tr class="c<%=c%>">
                <td><b><% Response.Write( pos_descricao ) %></b>                                              </td>
                <td align="center">     <% Response.Write(RS1("GRADUACAO")) %>                               </td>
                <td align="center">     <%  percentual = ( RS1("GRADUACAO") / RS1("TOTAL_ALUNOS") ) * 100
                                            percentual = round (percentual, 2)
                                            Response.Write ( percentual )      %>                       </td>
                <td align="center">     <%  Response.Write( RS1("POS_REPROVADO") )  %>                       </td>
                <td align="center">     <%  Response.Write( RS1("POS_APROVADO") )   %>                       </td>
                <td align="center"> -                                                                   </td>
                <td align="center"> -                                                                   </td>
                <td align="center">    <%  Response.Write( RS1("POS_EFETIVO") ) %>                   </td>
            </tr>
<%          RS1.Close
            c = 1 - c
            RS.MoveNext
        wend
        RS.Close

' xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx==============

        '==============<  ACUMULADOR POR ÁREA DE ATUAÇÃO  >==============
%>
            <tr class="c0" height="20">  <td colspan=8>  </td></tr>
            <tr class="c1"><td colspan=8 align="left"><span style="font-weight: bold">Área de Atuação</span></td></tr>
<%
        sql_inicio = ""
        sql_inicio = sql_inicio & "SELECT  COUNT (DISTINCT(a.cod_aluno)) as total_geral, "
        sql_inicio = sql_inicio & " COUNT(DISTINCT a.cod_aluno) as total_alunos, "

        sql_atuacao = "SELECT ID_ATUACAO, ATUACAO FROM AREA_ATUACAO"
        RS.Open(sql_atuacao)
        c = 0
        while not RS.EOF
            sql_acumula = ""
            atuacao_desc = RS("ATUACAO")
            atuacao_id   = RS("ID_ATUACAO")

            sql_acumula = sql_acumula &   " COUNT(DISTINCT CASE WHEN a.area_atuacao = '"                  & _
                                                      atuacao_id & "'  THEN a.cod_aluno END) as atuacao, "
            sql_acumula = sql_acumula &   " COUNT(DISTINCT CASE WHEN a.area_atuacao = '"                  & _
                                                      atuacao_id & "'  AND ta.status = 'APROVADO' THEN a.cod_aluno END) as atuacao_aprovado, "
            sql_acumula = sql_acumula &   " COUNT(DISTINCT CASE WHEN a.area_atuacao = '"                  & _
                                                      atuacao_id & "'  AND ta.status = 'REPROVADO' THEN a.cod_aluno END) as atuacao_reprovado, "
            sql_acumula = sql_acumula &   " COUNT(DISTINCT CASE WHEN a.area_atuacao = '"                  & _
                                                      atuacao_id & "'  AND efetivo = 'sim' THEN a.cod_aluno END) as atuacao_efetivo, "
            sql_acumula = sql_acumula &   " COUNT(DISTINCT CASE WHEN a.area_atuacao = '"                  & _
                                                      atuacao_id & "'  THEN a.cod_aluno END) as atuacao_todos "
            '==============<  FROM ALUNO - JOIN - WHERE (filtros)  >==============
            sql_acumula = sql_acumula &   " FROM aluno AS a "
            sql_acumula = sql_acumula &   " JOIN turma_aluno AS ta ON ta.cod_aluno = a.cod_aluno "
            sql_acumula = sql_acumula &   " JOIN turmas AS t ON t.id_turma = ta.id_turma "
            sql_acumula = sql_acumula &   " WHERE t.siga_projeto=2 "
            sql_acumula = sql_acumula &   sql_filtro

            sql_acumuladores = sql_inicio + sql_acumula
            RS1.Open (sql_acumuladores)
%>
            <tr class="c<%=c%>">
                <td><b><% Response.Write( atuacao_desc ) %></b>                                              </td>
                <td align="center">     <% Response.Write(RS1("ATUACAO")) %>                               </td>
                <td align="center">     <%  percentual = ( RS1("ATUACAO") / RS1("TOTAL_ALUNOS") ) * 100
                                            percentual = round (percentual, 2)
                                            Response.Write ( percentual )      %>                       </td>
                <td align="center">     <%  Response.Write( RS1("ATUACAO_REPROVADO") )  %>                       </td>
                <td align="center">     <%  Response.Write( RS1("ATUACAO_APROVADO") )   %>                       </td>
                <td align="center"> -                                                                   </td>
                <td align="center"> -                                                                   </td>
                <td align="center">    <%  Response.Write( RS1("ATUACAO_EFETIVO") ) %>                   </td>
            </tr>
<%          RS1.Close
            c= 1 -c
            RS.MoveNext
        wend
        RS.Close
%>


<%
' xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        '==============<  ACUMULADOR POR TIPO DE ENTIDADE  >==============
%>
            <tr class="c0" height="20">  <td colspan=8>  </td></tr>
            <tr class="c1"><td colspan=8 align="left"><span style="font-weight: bold">Entidades</span></td></tr>
<%
        sql_inicio = ""
        sql_inicio = sql_inicio & "SELECT  COUNT (DISTINCT(a.cod_aluno)) as total_geral, "
        sql_inicio = sql_inicio & " COUNT(DISTINCT a.cod_aluno) as total_alunos, "

        sql_entidade = "SELECT ID_TIPO_ENTIDADE, DESCRICAO FROM TIPO_ENTIDADE"
        RSSIM.Open(sql_entidade)

        c = 0
        while not RSSIM.EOF
            sql_acumula = ""
            tipo_enti = RSSIM("ID_TIPO_ENTIDADE")
            desc_enti = RSSIM("DESCRICAO")

            sql_acumula = sql_acumula &   " COUNT(DISTINCT CASE WHEN a.tipoenti = '"                  & _
                                                      tipo_enti & "'  THEN a.cod_aluno END) as tipo_enti, "
            sql_acumula = sql_acumula &   " COUNT(DISTINCT CASE WHEN a.tipoenti = '"                  & _
                                                      tipo_enti & "'  AND ta.status = 'APROVADO' THEN a.cod_aluno END) as tipo_enti_aprovado, "
            sql_acumula = sql_acumula &   " COUNT(DISTINCT CASE WHEN a.tipoenti = '"                  & _
                                                      tipo_enti & "'  AND ta.status = 'REPROVADO' THEN a.cod_aluno END) as tipo_enti_reprovado, "
            sql_acumula = sql_acumula &   " COUNT(DISTINCT CASE WHEN a.tipoenti = '"                  & _
                                                      tipo_enti & "'  AND efetivo = 'sim' THEN a.cod_aluno END) as tipo_enti_efetivo, "
            sql_acumula = sql_acumula &   " COUNT(DISTINCT CASE WHEN a.tipoenti = '"                  & _
                                                      tipo_enti & "'  THEN a.cod_aluno END) as tipo_enti_todos "
            '==============<  FROM ALUNO - JOIN - WHERE (filtros)  >==============
            sql_acumula = sql_acumula &   " FROM aluno AS a "
            sql_acumula = sql_acumula &   " JOIN turma_aluno AS ta ON ta.cod_aluno = a.cod_aluno "
            sql_acumula = sql_acumula &   " JOIN turmas AS t ON t.id_turma = ta.id_turma "
            sql_acumula = sql_acumula &   " WHERE t.siga_projeto=2 "
            sql_acumula = sql_acumula &   sql_filtro

            sql_acumuladores = sql_inicio + sql_acumula

            RS1.Open (sql_acumuladores)
%>
            <tr class="c<%=c%>">
                <td><b><% Response.Write( desc_enti ) %></b>                                                </td>
                <td align="center">     <%  Response.Write(RS1("TIPO_ENTI")) %>                             </td>
                <td align="center">     <%  percentual = ( RS1("TIPO_ENTI") / RS1("TOTAL_ALUNOS") ) * 100
                                            percentual = round (percentual, 2)
                                            Response.Write ( percentual )      %>                           </td>
                <td align="center">     <%  Response.Write( RS1("TIPO_ENTI_REPROVADO") )  %>                </td>
                <td align="center">     <%  Response.Write( RS1("TIPO_ENTI_APROVADO") )   %>                </td>
                <td align="center"> -                                                                       </td>
                <td align="center"> -                                                                       </td>
                <td align="center">    <%  Response.Write( RS1("TIPO_ENTI_EFETIVO") ) %>                    </td>
            </tr>
<%
            RS1.Close
            c = 1 - c
            RSSIM.MoveNext
        wend
        RSSIM.Close
' xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx




' xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        '==============<  ACUMULADOR POR CURSO  >==============
%>
            <tr class="c0" height="20">  <td colspan=8>  </td></tr>
            <tr class="c1"><td colspan=8 align="left"><span style="font-weight: bold">Cursos</span></td></tr>
<%
        sql_inicio = ""
        sql_inicio = sql_inicio & "SELECT  COUNT (DISTINCT(a.cod_aluno)) as total_geral, "
        sql_inicio = sql_inicio & " COUNT(DISTINCT a.cod_aluno) as total_alunos, "

        sql_curso = "SELECT COD_CURSO,TITULO FROM CURSO WHERE SIGA_PROJETO="&SIGA_PROJETO&" ORDER BY TITULO"

        RS.Open(sql_curso)

        c = 0
        while not RS.EOF
            sql_acumula = ""
            cod_curso = RS("COD_CURSO")
            titulo    = RS("TITULO")

            sql_acumula = sql_acumula &   " COUNT(DISTINCT CASE WHEN ta.cod_curso = '"                  & _
                                                      cod_curso & "'  THEN a.cod_aluno END) as tot_cod_curso, "
            sql_acumula = sql_acumula &   " COUNT(DISTINCT CASE WHEN ta.cod_curso = '"                  & _
                                                      cod_curso & "'  AND ta.status = 'APROVADO' THEN a.cod_aluno END) as cod_curso_aprovado, "
            sql_acumula = sql_acumula &   " COUNT(DISTINCT CASE WHEN ta.cod_curso = '"                  & _
                                                      cod_curso & "'  AND ta.status = 'REPROVADO' THEN a.cod_aluno END) as cod_curso_reprovado, "
            sql_acumula = sql_acumula &   " COUNT(DISTINCT CASE WHEN ta.cod_curso = '"                  & _
                                                      cod_curso & "'  AND efetivo = 'sim' THEN a.cod_aluno END) as cod_curso_efetivo, "
            sql_acumula = sql_acumula &   " COUNT(DISTINCT CASE WHEN ta.cod_curso = '"                  & _
                                                      cod_curso & "'  THEN a.cod_aluno END) as cod_curso_todos "
            '==============<  FROM ALUNO - JOIN - WHERE (filtros)  >==============
            sql_acumula = sql_acumula &   " FROM aluno AS a "
            sql_acumula = sql_acumula &   " JOIN turma_aluno AS ta ON ta.cod_aluno = a.cod_aluno "
            sql_acumula = sql_acumula &   " JOIN turmas AS t ON t.id_turma = ta.id_turma "
            sql_acumula = sql_acumula &   " WHERE t.siga_projeto=2 "
            sql_acumula = sql_acumula &   sql_filtro

            sql_acumuladores = sql_inicio + sql_acumula

            RS1.Open (sql_acumuladores)
%>
            <tr class="c<%=c%>">
                <td><b><% Response.Write( titulo ) %></b>                                                </td>
                <td align="center">     <%  Response.Write(RS1("TOT_COD_CURSO")) %>                             </td>
                <td align="center">     <%  percentual = ( RS1("TOT_COD_CURSO") / RS1("TOTAL_ALUNOS") ) * 100
                                            percentual = round (percentual, 2)
                                            Response.Write ( percentual )      %>                           </td>
                <td align="center">     <%  Response.Write( RS1("COD_CURSO_REPROVADO") )  %>                </td>
                <td align="center">     <%  Response.Write( RS1("COD_CURSO_APROVADO") )   %>                </td>
                <td align="center"> -                                                                       </td>
                <td align="center"> -                                                                       </td>
                <td align="center">    <%  Response.Write( RS1("COD_CURSO_EFETIVO") ) %>                    </td>
            </tr>
<%
            RS1.Close
            c = 1 - c
            RS.MoveNext
        wend
        RS.Close
' xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx


















' xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        '==============<  ACUMULADOR POR ESTADO  >==============
%>
            <tr class="c0" height="20">  <td colspan=8>  </td></tr>
            <tr class="c1"><td colspan=8 align="left"><span style="font-weight: bold">Estados</span></td></tr>
<%
        sql_inicio = ""
        sql_inicio = sql_inicio & "SELECT  COUNT (DISTINCT(a.cod_aluno)) as total_geral, "
        sql_inicio = sql_inicio & " COUNT(DISTINCT a.cod_aluno) as total_alunos, "

        sql_estado = "SELECT COD_UF_IBGE, NOME_UF FROM UF ORDER BY NOME_UF"
        RSSIM.Open(sql_estado)

        c = 0
        while not RSSIM.EOF
            sql_acumula = ""
            cod_uf  = RSSIM("COD_UF_IBGE")
            nome_uf = RSSIM("NOME_UF")

            sql_acumula = sql_acumula &   " COUNT(DISTINCT CASE WHEN a.cod_uf_ibge = '"                  & _
                                                      cod_uf & "'  THEN a.cod_aluno END) as cod_uf, "
            sql_acumula = sql_acumula &   " COUNT(DISTINCT CASE WHEN a.cod_uf_ibge = '"                  & _
                                                      cod_uf & "'  AND ta.status = 'APROVADO' THEN a.cod_aluno END) as cod_uf_aprovado, "
            sql_acumula = sql_acumula &   " COUNT(DISTINCT CASE WHEN a.cod_uf_ibge = '"                  & _
                                                      cod_uf & "'  AND ta.status = 'REPROVADO' THEN a.cod_aluno END) as cod_uf_reprovado, "
            sql_acumula = sql_acumula &   " COUNT(DISTINCT CASE WHEN a.cod_uf_ibge = '"                  & _
                                                      cod_uf & "'  AND efetivo = 'sim' THEN a.cod_aluno END) as cod_uf_efetivo, "
            sql_acumula = sql_acumula &   " COUNT(DISTINCT CASE WHEN a.cod_uf_ibge = '"                  & _
                                                      cod_uf & "'  THEN a.cod_aluno END) as cod_uf_todos "
            '==============<  FROM ALUNO - JOIN - WHERE (filtros)  >==============
            sql_acumula = sql_acumula &   " FROM aluno AS a "
            sql_acumula = sql_acumula &   " JOIN turma_aluno AS ta ON ta.cod_aluno = a.cod_aluno "
            sql_acumula = sql_acumula &   " JOIN turmas AS t ON t.id_turma = ta.id_turma "
            sql_acumula = sql_acumula &   " WHERE t.siga_projeto=2 "
            sql_acumula = sql_acumula &   sql_filtro

            sql_acumuladores = sql_inicio + sql_acumula

            RS1.Open (sql_acumuladores)
%>
            <tr class="c<%=c%>">
                <td><b><% Response.Write( nome_uf ) %></b>                                                </td>
                <td align="center">     <%  Response.Write(RS1("COD_UF")) %>                             </td>
                <td align="center">     <%  percentual = ( RS1("COD_UF") / RS1("TOTAL_ALUNOS") ) * 100
                                            percentual = round (percentual, 2)
                                            Response.Write ( percentual )      %>                           </td>
                <td align="center">     <%  Response.Write( RS1("COD_UF_REPROVADO") )  %>                </td>
                <td align="center">     <%  Response.Write( RS1("COD_UF_APROVADO") )   %>                </td>
                <td align="center"> -                                                                       </td>
                <td align="center"> -                                                                       </td>
                <td align="center">    <%  Response.Write( RS1("COD_UF_EFETIVO") ) %>                    </td>
            </tr>
<%
            RS1.Close
            c = 1 - c
            RSSIM.MoveNext
        wend
        RSSIM.Close

' xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        '==============<  ACUMULADOR POR MUNICÍPIO  >==============
%>
            <tr class="c0" height="20">  <td colspan=8>  </td></tr>
            <tr class="c1"><td colspan=8 align="left"><span style="font-weight: bold">Municípios</span></td></tr>
<%
        sql_inicio = ""
        sql_inicio = sql_inicio & "SELECT  COUNT (DISTINCT(a.cod_aluno)) as total_geral, "
        sql_inicio = sql_inicio & " COUNT(DISTINCT a.cod_aluno) as total_alunos, "

        sql_municipio = "SELECT M.COD_UF_IBGE, M.COD_MUNI_IBGE, M.NOME_MUNI, U.SIGLA_UF     "       & _
                        "       FROM MUNICIPIOS AS M                                        "       & _
                        "       JOIN UF AS U ON U.COD_UF_IBGE = M.COD_UF_IBGE               "       & _
                        "       ORDER BY M.NOME_MUNI"
        RSSIM.Open(sql_municipio)

        c = 0
        while not RSSIM.EOF
            sql_acumula = ""
            cod_uf    = RSSIM("COD_UF_IBGE")
            cod_muni  = RSSIM("COD_MUNI_IBGE")
            nome_muni = RSSIM("NOME_MUNI")
            sigla_uf  = RSSIM("SIGLA_UF")

            sql_acumula = sql_acumula &   " COUNT(DISTINCT CASE WHEN a.cod_uf_ibge = '"                   & _
                                                      cod_uf & "' AND a.cod_muni_ibge= '" & cod_muni & "' THEN a.cod_aluno END) as muni, "
            sql_acumula = sql_acumula &   " COUNT(DISTINCT CASE WHEN a.cod_uf_ibge = '"                   & _
                                                      cod_uf & "' AND a.cod_muni_ibge= '" & cod_muni & "' AND ta.status = 'APROVADO' THEN a.cod_aluno END) as muni_aprovado, "
            sql_acumula = sql_acumula &   " COUNT(DISTINCT CASE WHEN a.cod_uf_ibge = '"                   & _
                                                      cod_uf & "' AND a.cod_muni_ibge= '" & cod_muni & "' AND ta.status = 'REPROVADO' THEN a.cod_aluno END) as muni_reprovado, "
            sql_acumula = sql_acumula &   " COUNT(DISTINCT CASE WHEN a.cod_uf_ibge = '"                   & _
                                                      cod_uf & "' AND a.cod_muni_ibge= '" & cod_muni & "' AND efetivo = 'sim' THEN a.cod_aluno END) as muni_efetivo, "
            sql_acumula = sql_acumula &   " COUNT(DISTINCT CASE WHEN a.cod_uf_ibge = '"                   & _
                                                      cod_uf & "' AND a.cod_muni_ibge= '" & cod_muni & "' THEN a.cod_aluno END) as muni_todos "
            '==============<  FROM ALUNO - JOIN - WHERE (filtros)  >==============
            sql_acumula = sql_acumula &   " FROM aluno AS a "
            sql_acumula = sql_acumula &   " JOIN turma_aluno AS ta ON ta.cod_aluno = a.cod_aluno "
            sql_acumula = sql_acumula &   " JOIN turmas AS t ON t.id_turma = ta.id_turma "
            sql_acumula = sql_acumula &   " WHERE t.siga_projeto=2 "
            sql_acumula = sql_acumula &   sql_filtro

            sql_acumuladores = sql_inicio + sql_acumula

            RS1.Open (sql_acumuladores)

            if ( RS1("MUNI") <> 0 ) then
%>
                <tr class="c<%=c%>">
                    <td><b><% Response.Write( nome_muni  & " - " & sigla_uf ) %></b>                       </td>
                    <td align="center">     <%  Response.Write(RS1("MUNI")) %>                             </td>
                    <td align="center">     <%  percentual = ( RS1("MUNI") / RS1("TOTAL_ALUNOS") ) * 100
                                                percentual = round (percentual, 2)
                                                Response.Write ( percentual )      %>                      </td>
                    <td align="center">     <%  Response.Write( RS1("MUNI_REPROVADO") )  %>                </td>
                    <td align="center">     <%  Response.Write( RS1("MUNI_APROVADO") )   %>                </td>
                    <td align="center"> -                                                                  </td>
                    <td align="center"> -                                                                  </td>
                    <td align="center">    <%  Response.Write( RS1("MUNI_EFETIVO") ) %>                    </td>
                </tr>
<%
            c = 1 - c
            end if
            RS1.Close
            RSSIM.MoveNext
        wend
        RSSIM.Close


' xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

    end if

    ' ============================<  FINAL DOS ACUMULADORES  >=========================
%>

        </table>
        <br><br><br><br>
    </div>
</div>
</body>
</html>



