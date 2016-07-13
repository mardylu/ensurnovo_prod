<%
If session("key_plc")<>"ok" and session("key_plp")<>"ok" Then Response.Redirect "logout.asp"


p=request("p")
if p<>"1" and session("key_plc")<>"ok" then Response.Redirect "logout.asp"

Server.ScriptTimeout = 900

Response.Buffer = true
Response.Expires = 0
Response.Clear
%>
<!-- #INCLUDE FILE="../library/parametros.asp" -->
<!-- #INCLUDE FILE="../library/conOpen.asp" -->
<!-- #INCLUDE FILE="../library/conOpenSIM.asp" -->
<!-- #INCLUDE FILE="../library/conOpenCR.asp" -->
<!-- #INCLUDE FILE="../library/fErroMsg.asp" -->
<!-- #INCLUDE FILE="../library/fData.asp" -->
<!-- #INCLUDE FILE="../library/vFormaPgt.asp" -->
<%
Set RS1 = Server.CreateObject("ADODB.Recordset")
RS1.CursorType = 0
RS1.ActiveConnection = Con

Set RS2 = Server.CreateObject("ADODB.Recordset")
RS2.CursorType = 0
RS2.ActiveConnection = Con

function simnao(vlr,sexo)
    if vlr then
        if sexo then
            simnao = "Masc"
        else
            simnao = "Sim"
        end if
    else
        if sexo then
            simnao = "Fem"
        else
            simnao = "Não"
        end if
    end if
end function

' msql = Request.Form("msql")
' sel = request.Form("sel")

msql = request("msql")
sel  = request("sel")

if len(sel)=0 then erroMsg("Selecionar ao menos um aluno")
msql = Replace(msql,"WHERE ","WHERE COD_ALUNO IN ("&sel&") AND ")
msql = Replace(msql,"COD_ESCOLARIDADE","A.COD_ESCOLARIDADE")

'   ALUNO           as  A
'   TURMA_ALUNO     as  C
'   ESCOLARIDADE    as  E
'   RACA            as  R
'   PAIS            as  P
'   AREA_ATUACAO    as  T
'   POS             as  POS

msql = "SELECT A.COD_DEFICIENCIA, "                                                                                         &  _
       " A.COD_ALUNO as CODIGO_ALUNO, "                                                                                     &  _
       " A.tipoenti, "                                                                                                      &  _
       " A.TELEFONE_PESSOAL,  "                                                                                             &  _
       " A.TELEFONE_ENTIDADE, "                                                                                             &  _
       " A.CARGO as CARGO_ALUNO,  "                                                                                         &  _
       " A.SETOR as SETOR_ALUNO, "                                                                                          &  _
       " A.COD_UF_ENTI, "                                                                                                   &  _
       " A.COD_MUNI_ENTI, "                                                                                                 &  _
       " A.EMAIL_ENTI, "                                                                                                    &  _
       " A.ENDERECO_ENTI, "                                                                                                 &  _
       " A.COD_ENTI, "                                                                                                      &  _
       " A.CEP_ENTI, "                                                                                                      &  _
       " A.TEL_DDI_ENTI, "                                                                                                  &  _
       " A.TEL_DDD_ENTI, "                                                                                                  &  _
       " A.TEL_ENTI, "                                                                                                      &  _
       " A.E_CNPJ,     "                                                                                                    &  _
       " A.E_WWW,     "                                                                                                     &  _
       " A.NOME,     "                                                                                                      &  _
       " CPF AS CPF, "                                                                                                      &  _
       " ID_TIPO, "                                                                                                         &  _
       " ID_NUM, "                                                                                                          &  _
       " DT_NASCIMENTO AS DT_NASCIMENTO, "                                                                                  &  _
       " A.NOME_SOCIAL, "                                                                                                   &  _
       " A.EXPECTATIVAS, "                                                                                                  &  _
       " A.COMO_SOUBE, "                                                                                                    &  _
       " A.ATUACAO_BIOMA, "                                                                                                 &  _
       " A.TEM_ATUACAO_BIOMA, "                                                                                             &  _
       " A.AREA_ATUACAO, "                                                                                                  &  _
       " A.EFETIVO, "                                                                                                       &  _
       " A.ORIGEM, "                                                                                                        &  _
       " A.COD_ESCOLARIDADE, "                                                                                              &  _
       " SEXO, "                                                                                                            &  _
       " isNull(R.DESCRICAO,'') AS RACA, "                                                                                  &  _
       " P.NOME AS PAIS,"                                                                                                   &  _
       " EMAIL, "                                                                                                           &  _
       " ENDERECO, "                                                                                                        &  _
       " CEP, "                                                                                                             &  _
       " isNull(COD_MUNI_IBGE,0) AS COD_MUNI_IBGE, "                                                                        &  _
       " isNull(COD_UF_IBGE,0) AS COD_UF_IBGE, "                                                                            &  _
       " TEL_DDI, "                                                                                                         &  _
       " TEL_DDD, "                                                                                                         &  _
       " TEL, "                                                                                                             &  _
       " FAX_DDI, "                                                                                                         &  _
       " FAX_DDD, "                                                                                                         &  _
       " FAX, "                                                                                                             &  _
       " E.DESCRICAO AS ESCOLARIDADE, "                                                                                     &  _
       " FORMACAO, "                                                                                                        &  _
       " POS.DESCRICAO AS POS, "                                                                                            &  _
       " POS AS POS_AREA, "                                                                                                 &  _
       " T.ATUACAO, "                                                                                                       &  _
       " NEWSLETTER, "                                                                                                      &  _
       " isNull((SELECT SUM(VALOR) FROM PAGAMENTO WHERE COD_ALUNO=C.COD_ALUNO AND ID_TURMA=C.ID_TURMA),0) AS VALOR_PAGO, "  &  _
       " C.DT_CADASTRO, "                                                                                                   &  _
       " isNull((SELECT MAX(DT_PGT) FROM PAGAMENTO WHERE COD_ALUNO=C.COD_ALUNO AND COD_CURSO=C.COD_CURSO),'') AS DT_PGT, "  &  _
       " C.APROVADO, "                                                                                                      &  _
       " C.CARGO, "                                                                                                         &  _
       " C.SETOR, "                                                                                                         &  _
       " C.TEL_DDI_ENTI, "                                                                                                  &  _
       " C.TEL_DDD_ENTI, "                                                                                                  &  _
       " C.TEL_ENTI, "                                                                                                      &  _
       " C.STATUS, "                                                                                                        &  _
       " C.EMAIL_ENTI, "                                                                                                    &  _
       " C.ENDERECO_ENTI, "                                                                                                 &  _
       " C.CEP_ENTI, "                                                                                                      &  _
       " C.TERMO_COMPROMISSO, "                                                                                             &  _
       " C.FORMA_PGT FROM TURMA_ALUNO C  "                                                                                  &  _
       " JOIN ALUNO A ON C.COD_ALUNO=A.COD_ALUNO  "                                                                         &  _
       " LEFT JOIN ESCOLARIDADE E ON A.COD_ESCOLARIDADE=E.COD_ESCOLARIDADE  "                                               &  _
       " LEFT JOIN RACA R ON A.COD_RACA=R.COD_RACA  "                                                                       &  _
       " LEFT JOIN AREA_ATUACAO T ON T.ID_ATUACAO=A.AREA_ATUACAO  "                                                         &  _
       " JOIN PAIS P ON A.COD_PAIS=P.COD_PAIS  "                                                                            &  _
       " LEFT JOIN POS ON A.COD_POS=POS.COD_POS WHERE C.COD_ALUNO IN ("&sel&") AND "&msql

Response.ContentType = "application/vnd.ms-excel"
Response.AddHeader "Content-Disposition","attachment;filename=planilha.xls" & fn

if p="1" then
    Response.Write "<TABLE><tr>  <td><b>Nome</b></td>"                           &   _
                                "<td><b>CPF</b></td>"                            &   _
                                "<td><b>Nome Social</b></td>"                    &   _
                                "<td><b>Sexo</b></td>"                           &   _
                                "<td><b>Raça</b></td>"                           &   _
                                "<td><b>Nascimento</b></td>"                     &   _
                                "<td><b>Cod Deficiência</b></td>"                &   _
                                "<td><b>Tel</b></td>"                            &   _
                                "<td><b>Fax</b></td> "                           &   _
                                "<td><b>E-mail</b></td>"                         &   _
                                "<td><b>UF IBGE</b></td>"                        &   _
                                "<td><b>MUNI IBGE</b></td>"                      &   _
                               "<td><b>GEO-MUNI</b></td>"                       &   _

                                "<td><b>Tipo Instituição</b>"                    &   _
                                "</td><td><b>Instituição</b></td>"               &   _
                                "<td><b>Cod Instituição</b></td>"                &   _
                                "<td><b>UF-ENTI</b></td>"                        &   _
                                "<td><b>MUNI-ENTI</b></td>"                      &   _
                                "<td><b>GEO-ENTI</b></td>"                       &   _

                                "<td><b>Prioridade</b></td>"                     &   _
                                "<td><b>Município do Bioma</b></td>"             &   _
                                "<td><b>País</b></td>"                           &   _
                                "<td><b>UF</b></td>"                             &   _
                                "<td><b>Município</b></td>"                      &   _
                                "<td><b>Endereço</b></td>"                       &   _
                                "<td><b>CEP</b></td>"                            &   _
                                "<td><b>Escolaridade</b></td>"                   &   _
                                "<td><b>Nome do curso</b></td>"                  &   _
                                "<td><b>Pós</b></td>"                            &   _
                                "<td><b>Área da pós</b></td>"                    &   _
                                "<td><b>Nome do curso</b></td>"                  &   _
                                "<td><b>Pós</b></td>"                            &   _
                                "<td><b>Vínculo</b></td>"                        &   _
                                "<td><b>CNPJ</b></td>"                           &   _
                                "<td><b>TipoEnti</b></td>"                       &   _
                                "<td><b>Setor</b></td>"                          &   _
                                "<td><b>Cargo</b></td>"                          &   _
                                "<td><b>Área de atuacao</b></td>"                &   _
                                "<td><b>Servidor Efetivo</b></td>"               &   _
                                "<td><b>Tel inst.</b></td>"                      &   _
                                "<td><b>Email inst.</b></td>"                    &   _
                                "<td><b>UF Inst.</b></td>"                       &   _
                                "<td><b>Município Inst.</b></td>"                &   _
                                "<td><b>Endereco Inst.</b></td>"                 &   _
                                "<td><b>CEP Inst.</b></td>"                      &   _
                                "<td><b>Site da Instituição</b></td>"            &   _
                                "<td><b>Expectativas</b></td>"                   &   _
                                "<td><b>Como Soube</b></td>"                     &   _
                                "<td><b>Outros</b></td>"                         &   _
                                "<td><b>Atuacao Bioma</b></td>"                  &   _
                                "<td><b>Tem atuacao no Bioma</b></td>"           &   _
                                "<td><b>Termo de Compromisso</b></td>"           &   _
                                "<td><b>Quantidade de Cursos</b></td>"           &   _
                                "<td><b>Origem</b></td>"                         &   _

                                "</tr>"
else
    Response.Write "<TABLE><tr> <td><b>Nome</b></td>"                            &   _
                               "<td><b>CPF</b></td>"                             &   _
                               "<td><b>Nome Social</b></td>"                     &   _
                               "<td><b>Sexo</b></td>"                            &   _
                               "<td><b>Raça</b></td>"                            &   _
                               "<td><b>Nascimento</b></td>"                      &   _
                               "<td><b>Cod Deficiência</b></td>"                 &   _
                               "<td><b>Tel</b></td>"                             &   _
                               "<td><b>Fax</b></td>"                             &   _
                               "<td><b>E-mail</b></td>"                          &   _
                               "<td><b>UF IBGE</b></td>"                         &   _
                               "<td><b>MUNI IBGE</b></td>"                       &   _
                               "<td><b>GEO-MUNI</b></td>"                        &   _
                                "<td><b>Prioridade</b></td>"                     &   _
                                "<td><b>Município do Bioma</b></td>"             &   _
                               "<td><b>País</b></td>"                            &   _
                               "<td><b>UF</b></td>"                              &   _
                               "<td><b>Município</b></td>"                       &   _
                               "<td><b>Endereço</b></td>"                        &   _
                               "<td><b>CEP</b></td>"                             &   _
                               "<td><b>Escolaridade</b></td>"                    &   _
                               "<td><b>Nome do curso</b></td>"                   &   _
                               "<td><b>Pós</b></td>"                             &   _
                               "<td><b>Área da pós</b></td>"                     &   _
                               "<td><b>Vínculo</b></td>"                         &   _
                               "<td><b>Instituição</b></td>"                     &   _
                               "<td><b>CNPJ</b></td>"                            &   _
                               "<td><b>Tipo Instituição</b></td>"                &   _
                               "<td><b>Cod Instituição</b></td>"                 &   _
                               "<td><b>Setor</b></td>"                           &   _
                               "<td><b>TipoEnti</b></td>"                        &   _
                               "<td><b>Cargo</b></td>"                           &   _
                               "<td><b>Área de atuacao</b></td>"                 &   _
                               "<td><b>Servidor Efetivo</b></td>"                &   _
                               "<td><b>Tel inst.</b></td>"                       &   _
                               "<td><b>Email inst.</b></td>"                     &   _
                               "<td><b>UF-ENTI</b></td>"                         &   _
                               "<td><b>MUNI-ENTI</b></td>"                       &   _
                               "<td><b>GEO-ENTI</b></td>"                        &   _
                               "<td><b>UF Inst.</b></td>"                        &   _
                               "<td><b>Município Inst.</b></td>"                 &   _
                               "<td><b>Endereco Inst.</b></td>"                  &   _
                               "<td><b>CEP Inst.</b></td>"                       &   _
                               "<td><b>Site da Instituição</b></td>"             &   _
                               "<td><b>Expectativas</b></td>"                    &   _
                               "<td><b>Como Soube</b></td>"                      &   _
                               "<td><b>Outros</b></td>"                          &   _
                               "<td><b>Atuacao Bioma</b></td>"                   &   _
                               "<td><b>Tem atuacao no Bioma</b></td>"            &   _
                               "<td><b>Termo de Compromisso</b></td>"            &   _
                               "<td><b>Quantidade de Cursos</b></td>"            &   _
                               "<td><b>Valor pago</b></td>"                      &   _
                               "<td><b>Data cadastro</b></td>"                   &   _
                               "<td><b>Data últ. pgt</b></td>"                   &   _
                               "<td><b>Forma Pgt.</b></td>"                      &   _
                               "<td><b>Aprovado</b></td>"                        &   _
                               "<td><b>Origem</b></td>"                          &   _

                               "</tr>"
end if

'    Response.Write "msql: " & msql
'    Response.End

RS.Open msql
WHILE NOT RS.EOF

    enti = ""
    muni = ""
    uf = ""
    CARGO = ""
    SETOR = ""
    desc = ""
    CNPJ_EDITADO = ""
    cod_enti_uf_ibge   = ""
    cod_enti_muni_ibge = ""
    cod_enti_uf_ibge   = RS("COD_UF_ENTI")
    cod_enti_muni_ibge = RS("COD_MUNI_ENTI")
    COD_DEFICIENCIA    = RS("COD_DEFICIENCIA")
    if ( RS("CARGO_ALUNO") <> "") then CARGO = RS("CARGO_ALUNO")  end if
    if ( RS("SETOR_ALUNO") <> "") then SETOR = RS("SETOR_ALUNO")  end if

    TEL_DDI_PESSOAL = ""
    TEL_DDD_PESSOAL = ""
    TEL_NUM_PESSOAL = ""
    if ( len(RS("TELEFONE_PESSOAL")) > 0 )  then
        TEL_DDI_PESSOAL = mid(RS("TELEFONE_PESSOAL"),1,4)
        TEL_DDD_PESSOAL = mid(RS("TELEFONE_PESSOAL"),5,4)
        TEL_NUM_PESSOAL = mid(RS("TELEFONE_PESSOAL"),9,10)
    end if

    TEL_DDI_ENTIDADE = ""
    TEL_DDD_ENTIDADE = ""
    TEL_NUM_ENTIDADE = ""
    if ( len(RS("TELEFONE_ENTIDADE")) > 0 )  then
        TEL_DDI_ENTIDADE = mid(RS("TELEFONE_ENTIDADE"),1,4)
        TEL_DDD_ENTIDADE = mid(RS("TELEFONE_ENTIDADE"),5,4)
        TEL_NUM_ENTIDADE = mid(RS("TELEFONE_ENTIDADE"),9,10)
    end if

' Response.Write("uf1"&cod_enti_uf_ibge)
' Response.Write("muni1"&cod_enti_muni_ibge)
' Response.end

    if not isNull(RS("COD_ENTI")) then
        RSSIM.Open "SELECT E.ID_TIPO_ENTIDADE,NOME,isNull(SIGLA_UF,'') AS SIGLA_UF,isNull(NOME_MUNI,'') AS NOME_MUNI, "   &  _
                   " T.DESCRICAO AS TIPO_INSTITUICAO FROM ENTIDADES E "                                                   &  _
                   " LEFT JOIN MUNICIPIOS M ON E.COD_MUNI_IBGE=M.COD_MUNI_IBGE AND E.COD_UF_IBGE=M.COD_UF_IBGE "          &  _
                   " LEFT JOIN UF ON E.COD_UF_IBGE=UF.COD_UF_IBGE "                                                       &  _
                   " LEFT JOIN TIPO_ENTIDADE T ON T.ID_TIPO_ENTIDADE=E.ID_TIPO_ENTIDADE WHERE COD_ENTI="&RS("COD_ENTI")
        if NOT RSSIM.EOF then
            enti=RSSIM("NOME")
            codenti=RS("COD_ENTI")
            if Len(RSSIM("SIGLA_UF"))>0 and Len(RSSIM("NOME_MUNI"))>0 then
                muni = RSSIM("NOME_MUNI")
                uf = RSSIM("SIGLA_UF")
//                enti = enti & " ("&muni&"/"&uf&")"
                desc = RSSIM("TIPO_INSTITUICAO")
            else
                muni = "Estrangeiro"
                uf = "Estrangeiro"
            end if
        end if
        RSSIM.Close
    end if

    if RS("COD_UF_IBGE")>0 and RS("COD_MUNI_IBGE")>0 then
        RSSIM.Open "SELECT SIGLA_UF,NOME_MUNI FROM MUNICIPIOS M JOIN UF ON M.COD_UF_IBGE=UF.COD_UF_IBGE WHERE M.COD_UF_IBGE="&RS("COD_UF_IBGE")&" AND M.COD_MUNI_IBGE="&RS("COD_MUNI_IBGE")
        if NOT RSSIM.EOF then
            ufresid=RSSIM(0)
            muniresid=RSSIM(1)
        end if
        RSSIM.Close
    end if

    CPF=mid(RS("CPF"),1,3)&"."&mid(RS("CPF"),4,3)&"."&mid(RS("CPF"),7,3)&"-"&mid(RS("CPF"),10,2)

    CNPJ_EDITADO = ""
    CNPJ_EDITADO = RS("E_CNPJ")
    if ( len(CNPJ_EDITADO) > 0 )   then
        CNPJ_EDITADO = replace(CNPJ_EDITADO, ".", "")
        CNPJ_EDITADO = replace(CNPJ_EDITADO, "/", "")
        CNPJ_EDITADO = replace(CNPJ_EDITADO, "-", "")
        CNPJ_EDITADO = mid(CNPJ_EDITADO,1,2)&"."&mid(CNPJ_EDITADO,3,3)&"."&mid(CNPJ_EDITADO,6,3)&"/"&mid(CNPJ_EDITADO,9,4)&"-"&mid(CNPJ_EDITADO,13,2)
    end if

' Response.Write("uf2"&cod_enti_uf_ibge)
' Response.Write("muni2"&cod_enti_muni_ibge)

    if (len(cod_enti_muni_ibge)=5) then geocod_enti= cod_enti_uf_ibge&cod_enti_muni_ibge
    if (len(cod_enti_muni_ibge)=4) then geocod_enti= cod_enti_uf_ibge&"0"&cod_enti_muni_ibge
    if (len(cod_enti_muni_ibge)=3) then geocod_enti= cod_enti_uf_ibge&"00"&cod_enti_muni_ibge
    if (len(cod_enti_muni_ibge)=2) then geocod_enti= cod_enti_uf_ibge&"000"&cod_enti_muni_ibge
    if (len(cod_enti_muni_ibge)=1) then geocod_enti= cod_enti_uf_ibge&"0000"&cod_enti_muni_ibge

' Response.Write("uf3 - "&cod_enti_uf_ibge)
' Response.Write("muni3 - "&cod_enti_muni_ibge)
' Response.Write("GEO - "&geocod_enti)


    if (len(RS("COD_MUNI_IBGE"))=5) then geocod_muni= RS("COD_UF_IBGE")&RS("COD_MUNI_IBGE")
    if (len(RS("COD_MUNI_IBGE"))=4) then geocod_muni= RS("COD_UF_IBGE")&"0"&RS("COD_MUNI_IBGE")
    if (len(RS("COD_MUNI_IBGE"))=3) then geocod_muni= RS("COD_UF_IBGE")&"00"&RS("COD_MUNI_IBGE")
    if (len(RS("COD_MUNI_IBGE"))=2) then geocod_muni= RS("COD_UF_IBGE")&"000"&RS("COD_MUNI_IBGE")
    if (len(RS("COD_MUNI_IBGE"))=1) then geocod_muni= RS("COD_UF_IBGE")&"0000"&RS("COD_MUNI_IBGE")

    if ( RS("tipoenti") <> 21 ) then vinculo = "sim"  else vinculo = "não"  end if

    sql_cr = "SELECT prioridade FROM cen_bioma_cidade WHERE cod_uf_ibge='" & RS("COD_UF_IBGE") & "' AND cod_muni_ibge='" & RS("COD_MUNI_IBGE") & "'"

    RSCR.Open sql_cr
    if RSCR.eof   then
        prioridade = ""
        muni_bioma = "não"
    else
        prioridade = RSCR("PRIORIDADE")
        muni_bioma = "sim"
    end if
    RSCR.Close

    sql_qtde = "SELECT COUNT (a.COD_ALUNO) AS QTDE FROM TURMA_ALUNO  as a"   _
                                            & " LEFT JOIN CURSO as b ON a.cod_curso=b.cod_curso "   _
                                            & " WHERE b.SIGA_PROJETO=2 AND a.COD_ALUNO="&RS("CODIGO_ALUNO")    _
                                            & " AND a.enturmado='E'"

'    Response.Write "sql qtde: " & sql_qtde  & "<br>"
'    Response.End

    RS2.Open sql_qtde
    if RS2.eof   then
        te_qtde = 0
    else
        te_qtde = RS2("QTDE")
    end if
    RS2.Close

'    Response.Write "Prioridade: " & prioridade
'    Response.Write "sql cr: " & sql_cr

    if p="1" then
        Response.Write "<tr><td>"&RS("NOME")&"</td>"                                                     &   _
                            "<td>"&CPF&"</td>"                                                           &   _
                            "<td>"&RS("NOME_SOCIAL")&"</td>"                                             &   _
                            "<td>"&simnao(RS("SEXO"),true)&"</td>"                                       &   _
                            "<td>"&RS("RACA")&"</td>"                                                    &   _
                            "<td>"&formataData(RS("DT_NASCIMENTO"))&"</td>"                              &   _
                            "<td>"&RS("COD_DEFICIENCIA")&"</td>"                                         &   _
                            "<td>"&TEL_DDI_PESSOAL&" "&TEL_DDD_PESSOAL&" "&TEL_NUM_PESSOAL&"</td>"       &   _
                            "<td>("&RS("FAX_DDI")&"-"&RS("FAX_DDD")&") "&RS("FAX")&"</td>"               &   _
                            "<td>"&RS("EMAIL")&"</td>"                                                   &   _
                            "<td>"&RS("COD_UF_IBGE")&"</td>"                                             &   _
                            "<td>"&RS("COD_MUNI_IBGE")&"</td>"                                           &   _
                            "<td>"&geocod_muni&"</td>"                                                   &   _

                            "<td>"&desc&"</td>"                                                          &   _
                            "<td>"&codenti&"</td>"                                                       &   _
                            "<td>"&cod_enti_uf_ibge&"</td>"                                              &   _
                            "<td>"&cod_enti_muni_ibge&"</td>"                                            &   _
                            "<td>"&geocod_enti&"</td>"                                                   &   _

                            "<td>"&prioridade&"</td>"                                                    &   _
                            "<td>"&muni_bioma&"</td>"                                                    &   _
                            "<td>"&RS("PAIS")&"</td>"                                                    &   _
                            "<td>"&ufresid&"</td>"                                                       &   _
                            "<td>"&muniresid&"</td>"                                                     &   _
                            "<td>"&RS("ENDERECO")&"</td>"                                                &   _
                            "<td>"&RS("CEP")&"</td>"                                                     &   _
                            "<td>"&RS("ESCOLARIDADE")&"</td>"                                            &   _
                            "<td>"&RS("FORMACAO")&"</td>"                                                &   _
                            "<td>"&RS("POS")&"</td>"                                                     &   _
                            "<td>"&RS("POS_AREA")&"</td>"                                                &   _

                            "<td>"&vinculo&"</td>"                                                       &   _


                            "<td>"&CNPJ_EDITADO&"</td>"                                                  &   _
                            "<td>"&RS("tipoenti")&"</td>"                                                &   _
                            "<td>"&SETOR&"</td>"                                                         &   _
                            "<td>"&CARGO&"</td>"                                                         &   _
                            "<td>"&RS("ATUACAO")&"</td>"                                                 &   _
                            "<td>"&RS("EFETIVO")&"</td>"                                                 &   _
                            "<td>"&TEL_DDI_ENTIDADE&" "&TEL_DDD_ENTIDADE&" "&TEL_NUM_ENTIDADE&"</td>"    &   _
                            "<td>"&RS("EMAIL_ENTI")&"</td>"                                              &   _
                            "<td>"&uf&"</td>"                                                            &   _
                            "<td>"&muni&"</td>"                                                          &   _
                            "<td>"&RS("ENDERECO_ENTI")&"</td>"                                           &   _
                            "<td>"&RS("CEP_ENTI")&"</td>"                                                &   _
                            "<td>"&RS("E_WWW")&"</td>"                                                   &   _
                            "<td>"&RS("EXPECTATIVAS")&"</td>"                                            &   _
                            "<td>"&RS("SELECAO_COMO_SOUBE")&"</td>"                                      &   _
                            "<td>"&RS("COMO_SOUBE")&"</td>"                                              &   _
                            "<td>"&RS("ATUACAO_BIOMA")&"</td>"                                           &   _
                            "<td>"&RS("TEM_ATUACAO_BIOMA")&"</td>"                                       &   _
                            "<td>"&RS("TERMO_COMPROMISSO")&"</td>"                                       &   _
                            "<td>"&te_qtde&"</td>"                                                       &   _
                            "<td>"&RS("ORIGEM")&"</td>"                                                  &   _

                            "</tr>"
    else
        Response.Write "<tr><td>"&RS("NOME")&"</td>"                                                         &   _
                            "<td>"&CPF&"</td>"                                                               &   _
                            "<td>"&RS("NOME_SOCIAL")&"</td>"                                                 &   _
                            "<td>"&simnao(RS("SEXO"),true)&"</td>"                                           &   _
                            "<td>"&RS("RACA")&"</td>"                                                        &   _
                            "<td>"&formataData(RS("DT_NASCIMENTO"))&"</td>"                                  &   _
                            "<td>"& COD_DEFICIENCIA &"</td>"                                                 &   _
                            "<td>"&TEL_DDI_PESSOAL&" "&TEL_DDD_PESSOAL&" "&TEL_NUM_PESSOAL&"</td>"           &   _
                            "<td>("&RS("FAX_DDI")&"-"&RS("FAX_DDD")&") "&RS("FAX")&"</td>"                   &   _
                            "<td>"&RS("EMAIL")&"</td>"                                                       &   _
                            "<td>"&RS("COD_UF_IBGE")&"</td>"                                                 &   _
                            "<td>"&RS("COD_MUNI_IBGE")&"</td>"                                               &   _
                            "<td>"&geocod_muni&"</td>"                                                       &   _
                            "<td>"&prioridade&"</td>"                                                        &   _
                            "<td>"&muni_bioma&"</td>"                                                        &   _
                            "<td>"&RS("PAIS")&"</td>"                                                        &   _
                            "<td>"&ufresid&"</td>"                                                           &   _
                            "<td>"&muniresid&"</td>"                                                         &   _
                            "<td>"&RS("ENDERECO")&"</td>"                                                    &   _
                            "<td>"&RS("CEP")&"</td>"                                                         &   _
                            "<td>"&RS("ESCOLARIDADE")&"</td>"                                                &   _
                            "<td>"&RS("FORMACAO")&"</td>"                                                    &   _
                            "<td>"&RS("POS")&"</td>"                                                         &   _
                            "<td>"&RS("POS_AREA")&"</td>"                                                    &   _
                            "<td>"&vinculo&"</td>"                                                           &   _
                            "<td>"&enti&"</td>"                                                              &   _
                            "<td>"&CNPJ_EDITADO&"</td>"                                                      &   _
                            "<td>"&desc&"</td>"                                                              &   _
                            "<td>"&codenti&"</td>"                                                           &   _
                            "<td>"&SETOR&"</td>"                                                             &   _
                            "<td>"&RS("tipoenti")&"</td>"                                                    &   _
                            "<td>"&CARGO&"</td>"                                                             &   _
                            "<td>"&RS("ATUACAO")&"</td>"                                                     &   _
                            "<td>"&RS("EFETIVO")&"</td>"                                                     &   _
                            "<td>"&TEL_DDI_ENTIDADE&" "&TEL_DDD_ENTIDADE&" "&TEL_NUM_ENTIDADE&"</td>"        &   _
                            "<td>"&RS("EMAIL_ENTI")&"</td>"                                                  &   _
                            "<td>"&cod_enti_uf_ibge&"</td>"                                                  &   _
                            "<td>"&cod_enti_muni_ibge&"</td>"                                                &   _
                            "<td>"&geocod_enti&"</td>"                                                       &   _
                            "<td>"&uf&"</td>"                                                                &   _
                            "<td>"&muni&"</td>"                                                              &   _
                            "<td>"&RS("ENDERECO_ENTI")&"</td>"                                               &   _
                            "<td>"&RS("CEP_ENTI")&"</td>"                                                    &   _
                            "<td>"&RS("E_WWW")&"</td>"                                                       &   _
                            "<td>"&RS("EXPECTATIVAS")&"</td>"                                                &   _
                            "<td>"&RS("COMO_SOUBE")&"</td>"                                                  &   _
                            "<td>"&RS("COMO_SOUBE")&"</td>"                                                  &   _
                            "<td>"&RS("ATUACAO_BIOMA")&"</td>"                                               &   _
                            "<td>"&RS("TEM_ATUACAO_BIOMA")&"</td>"                                           &   _
                            "<td>"&RS("TERMO_COMPROMISSO")&"</td>"                                           &   _
                            "<td>"&te_qtde&"</td>"                                                           &   _
                            "<td>"&RS("VALOR_PAGO")&"</td>"                                                  &   _
                            "<td>"&formataData(RS("DT_CADASTRO"))&"</td>"                                    &   _
                            "<td>"&formataData(RS("DT_PGT"))&"</td>"                                         &   _
                            "<td>"&aFormaPgt(RS("FORMA_PGT"))&"</td>"                                        &   _
                            "<td>"&RS("STATUS")&"</td>"                                                      &   _
                            "<td>"&RS("ORIGEM")&"</td>"                                                      &   _

                          "</tr>"
    end if


    RS.MoveNext
WEND

RS.Close
conClose
conCloseSIM
conCloseCR
Response.Write "</TABLE>"
Server.ScriptTimeout = 900
%>