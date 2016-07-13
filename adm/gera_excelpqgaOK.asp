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
<!-- #INCLUDE FILE="../library/fErroMsg.asp" -->
<!-- #INCLUDE FILE="../library/fData.asp" -->
<!-- #INCLUDE FILE="../library/vFormaPgt.asp" -->
<%
Set RS1 = Server.CreateObject("ADODB.Recordset")
RS1.CursorType = 0
RS1.ActiveConnection = Con


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

msql = "SELECT A.COD_DEFICIENCIA,A.tipoenti,A.TELEFONE_PESSOAL,A.TELEFONE_ENTIDADE,A.CARGO as CARGO_ALUNO, "            &  _
       "A.SETOR as SETOR_ALUNO,A.COD_UF_ENTI,A.COD_MUNI_ENTI,A.EMAIL_ENTI,A.ENDERECO_ENTI,A.COD_ENTI,A.CEP_ENTI, "      &  _
       "A.TEL_DDI_ENTI,A.TEL_DDd_ENTI,A.TEL_ENTI,A.NOME,CPF AS CPF,ID_TIPO,ID_NUM,DT_NASCIMENTO AS DT_NASCIMENTO, "     &  _
       "A.NOME_SOCIAL,A.EXPECTATIVAS,A.COMO_SOUBE,A.ATUACAO_BIOMA,A.TEM_ATUACAO_BIOMA,A.EFETIVO, "                      &  _
       "A.COD_ESCOLARIDADE, "                                                                                           &  _
       "SEXO,isNull(R.DESCRICAO,'') AS RACA,P.NOME AS PAIS,"                                                            &  _
       "EMAIL,ENDERECO,CEP,isNull(COD_MUNI_IBGE,0) AS COD_MUNI_IBGE,isNull(COD_UF_IBGE,0) AS COD_UF_IBGE, "             &  _
       "TEL_DDI,TEL_DDD,TEL,FAX_DDI,FAX_DDD,FAX,E.DESCRICAO AS ESCOLARIDADE,FORMACAO,POS.DESCRICAO AS POS, "            &  _
       "POS AS POS_AREA,NEWSLETTER,isNull((SELECT SUM(VALOR) FROM PAGAMENTO  "                                          &  _
       "WHERE COD_ALUNO=C.COD_ALUNO AND ID_TURMA=C.ID_TURMA),0) AS VALOR_PAGO,"                                         &  _
       "C.DT_CADASTRO,isNull((SELECT MAX(DT_PGT) FROM PAGAMENTO  "                                                      &  _
       "WHERE COD_ALUNO=C.COD_ALUNO AND COD_CURSO=C.COD_CURSO),'') AS DT_PGT,"                                          &  _
       "C.APROVADO,C.CARGO,C.SETOR,C.TEL_DDI_ENTI,C.TEL_DDD_ENTI,C.TEL_ENTI, "                                          &  _
       "C.STATUS,C.EMAIL_ENTI,C.ENDERECO_ENTI,C.CEP_ENTI,C.FORMA_PGT FROM TURMA_ALUNO C  "                              &  _
       "JOIN ALUNO A ON C.COD_ALUNO=A.COD_ALUNO  "                                                                      &  _
       "LEFT JOIN ESCOLARIDADE E ON A.COD_ESCOLARIDADE=E.COD_ESCOLARIDADE  "                                            &  _
       "LEFT JOIN RACA R ON A.COD_RACA=R.COD_RACA  "                                                                    &  _
       "JOIN PAIS P ON A.COD_PAIS=P.COD_PAIS  "                                                                         &  _
       "LEFT JOIN POS ON A.COD_POS=POS.COD_POS WHERE C.COD_ALUNO IN ("&sel&") AND "&msql

Response.ContentType = "application/vnd.ms-excel"
Response.AddHeader "Content-Disposition","attachment;filename=planilha.xls" & fn

if p="1" then
    Response.Write "<TABLE><tr>  <td><b>Nome</b></td>"                           &   _
                                "<td><b>Tipo Instituição</b>"                    &   _
                                "</td><td><b>Instituição</b></td>"               &   _
                                "<td><b>Cod Instituição</b></td>"                &   _
                                "<td><b>UF-ENTI</b></td>"                        &   _
                                "<td><b>MUNI-ENTI</b></td>"                      &   _
                                "<td><b>GEO-ENTI</b></td>"                       &   _
                                "<td><b>UF IBGE</b></td>"                        &   _
                                "<td><b>MUNI IBGE</b></td>"                      &   _
                                "<td><b>GEO-MUNI</b></td>"                       &   _
                                "<td><b>Setor</b></td>"                          &   _
                                "<td><b>TipoEnti</b></td>"                       &   _
                                "<td><b>Cargo</b></td>"                          &   _
                                "<td><b>Endereco Inst.</b></td>"                 &   _
                                "<td><b>UF Inst.</b></td>"                       &   _
                                "<td><b>Município Inst.</b></td>"                &   _
                                "<td><b>CEP Inst.</b></td>"                      &   _
                                "<td><b>Tel inst.</b></td>"                      &   _
                                "<td><b>Email inst.</b></td>"                    &   _
                                "<td><b>Endereço</b></td>"                       &   _
                                "<td><b>Município</b></td>"                      &   _
                                "<td><b>UF</b></td>"                             &   _
                                "<td><b>CEP</b></td>"                            &   _
                                "<td><b>Tel</b></td>"                            &   _
                                "<td><b>Fax</b></td> "                           &   _
                                "<td><b>E-mail</b></td>"                         &   _
                                "<td><b>Escolaridade</b></td>"                   &   _
                                "<td><b>Nome do curso</b></td>"                  &   _
                                "<td><b>Sexo</b></td>"                           &   _
                                "<td><b>Nascimento</b></td>"                     &   _
                                "<td><b>Raça</b></td>"                           &   _
                                "<td><b>CPF</b></td>"                            &   _
                                "<td><b>País</b></td>"                           &   _
                                "<td><b>Pós</b></td>"                            &   _
                                "<td><b>Área da pós</b></td>"                    &   _
                                "<td><b>Servidor Efetivo</b></td>"               &   _
                                "<td><b>Cod Deficiência</b></td>"                &   _
                                "<td><b>Nome Social</b></td>"                    &   _
                                "<td><b>Expectativas</b></td>"                   &   _
                                "<td><b>Como Soube</b></td>"                     &   _
                                "<td><b>Atuacao Bioma</b></td>"                  &   _
                                "<td><b>Tem atuacao no Bioma</b></td>"           &   _
                                "</tr>"
else
    Response.Write "<TABLE><tr> <td><b>Nome</b></td>"                            &   _
                               "<td><b>Tipo Instituição</b></td>"                &   _
                               "<td><b>Instituição</b></td>"                     &   _
                               "<td><b>Cod Instituição</b></td>"                 &   _
                               "<td><b>UF-ENTI</b></td>"                         &   _
                               "<td><b>MUNI-ENTI</b></td>"                       &   _
                               "<td><b>GEO-ENTI</b></td>"                        &   _
                               "<td><b>UF IBGE</b></td>"                         &   _
                               "<td><b>MUNI IBGE</b></td>"                       &   _
                               "<td><b>GEO-MUNI</b></td>"                        &   _
                               "<td><b>Setor</b></td>"                           &   _
                               "<td><b>TipoEnti</b></td>"                        &   _
                               "<td><b>Cargo</b></td>"                           &   _
                               "<td><b>Endereco Inst.</b></td>"                  &   _
                               "<td><b>UF Inst.</b></td>"                        &   _
                               "<td><b>Município Inst.</b></td>"                 &   _
                               "<td><b>CEP Inst.</b></td>"                       &   _
                               "<td><b>Tel inst.</b></td>"                       &   _
                               "<td><b>Email inst.</b></td>"                     &   _
                               "<td><b>Endereço</b></td>"                        &   _
                               "<td><b>Município</b></td>"                       &   _
                               "<td><b>UF</b></td>"                              &   _
                               "<td><b>CEP</b></td>"                             &   _
                               "<td><b>Tel</b></td>"                             &   _
                               "<td><b>Fax</b></td>"                             &   _
                               "<td><b>E-mail</b></td>"                          &   _
                               "<td><b>Escolaridade</b></td>"                    &   _
                               "<td><b>Nome do curso</b></td>"                   &   _
                               "<td><b>Sexo</b></td>"                            &   _
                               "<td><b>Nascimento</b></td>"                      &   _
                               "<td><b>Raça</b></td>"                            &   _
                               "<td><b>CPF</b></td>"                             &   _
                               "<td><b>País</b></td>"                            &   _
                               "<td><b>Pós</b></td>"                             &   _
                               "<td><b>Área da pós</b></td>"                     &   _
                               "<td><b>Servidor Efetivo</b></td>"                &   _
                               "<td><b>Valor pago</b></td>"                      &   _
                               "<td><b>Data cadastro</b></td>"                   &   _
                               "<td><b>Data últ. pgt</b></td>"                   &   _
                               "<td><b>Forma Pgt.</b></td>"                      &   _
                               "<td><b>Aprovado</b></td>"                        &   _
                               "<td><b>Cod Deficiência</b></td>"                 &   _
                               "<td><b>Nome Social</b></td>"                     &   _
                               "<td><b>Expectativas</b></td>"                    &   _
                               "<td><b>Como Soube</b></td>"                      &   _
                               "<td><b>Atuacao Bioma</b></td>"                   &   _
                               "<td><b>Tem atuacao no Bioma</b></td>"            &   _
                               "</tr>"
end if

'    Response.Write "msql: " & msql
'    Response.End

RS.Open msql
WHILE NOT RS.EOF

    enti = ""
    muni = ""
    uf = ""
    cod_enti_uf_ibge   = ""
    cod_enti_muni_ibge = ""
    cod_enti_uf_ibge   = RS("COD_UF_ENTI")
    cod_enti_muni_ibge = RS("COD_MUNI_ENTI")
    COD_DEFICIENCIA    = RS("COD_DEFICIENCIA")
    if ( RS("CARGO_ALUNO") <> "") then CARGO = RS("CARGO_ALUNO")  end if
    if ( RS("SETOR_ALUNO") <> "") then SETOR = RS("SETOR_ALUNO")  end if


    if ( len(RS("TELEFONE_PESSOAL")) > 0 )  then
        TEL_DDI_PESSOAL = mid(RS("TELEFONE_PESSOAL"),1,4)
        TEL_DDD_PESSOAL = mid(RS("TELEFONE_PESSOAL"),5,4)
        TEL_NUM_PESSOAL = mid(RS("TELEFONE_PESSOAL"),9,10)
    end if

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

    if p="1" then
        Response.Write "<tr><td>"&RS("NOME")&"</td>"                                                     &   _
                            "<td>"&desc&"</td>"                                                          &   _
                            "<td>"&enti&"</td>"                                                          &   _
                            "<td>"&codenti&"</td>"                                                       &   _
                            "<td>"&cod_enti_uf_ibge&"</td>"                                              &   _
                            "<td>"&cod_enti_muni_ibge&"</td>"                                            &   _
                            "<td>"&geocod_enti&"</td>"                                                   &   _
                            "<td>"&RS("COD_UF_IBGE")&"</td>"                                             &   _
                            "<td>"&RS("COD_MUNI_IBGE")&"</td>"                                           &   _
                            "<td>"&geocod_muni&"</td>"                                                   &   _
                            "<td>"&SETOR&"</td>"                                                         &   _
                            "<td>"&RS("tipoenti")&"</td>"                                                &   _
                            "<td>"&CARGO&"</td>"                                                         &   _
                            "<td>"&RS("ENDERECO_ENTI")&"</td>"                                           &   _
                            "<td>"&uf&"</td>"                                                            &   _
                            "<td>"&muni&"</td>"                                                          &   _
                            "<td>"&RS("CEP_ENTI")&"</td>"                                                &   _
                            "<td>"&TEL_DDI_ENTIDADE&" "&TEL_DDD_ENTIDADE&" "&TEL_NUM_ENTIDADE&"</td>"    &   _
                            "<td>"&RS("EMAIL_ENTI")&"</td>"                                              &   _
                            "<td>"&RS("ENDERECO")&"</td>"                                                &   _
                            "<td>"&muniresid&"</td>"                                                     &   _
                            "<td>"&ufresid&"</td>"                                                       &   _
                            "<td>"&RS("CEP")&"</td>"                                                     &   _
                            "<td>"&TEL_DDI_PESSOAL&" "&TEL_DDD_PESSOAL&" "&TEL_NUM_PESSOAL&"</td>"       &   _
                            "<td>("&RS("FAX_DDI")&"-"&RS("FAX_DDD")&") "&RS("FAX")&"</td>"               &   _
                            "<td>"&RS("EMAIL")&"</td>"                                                   &   _
                            "<td>"&RS("ESCOLARIDADE")&"</td>"                                            &   _
                            "<td>"&RS("FORMACAO")&"</td>"                                                &   _
                            "<td>"&simnao(RS("SEXO"),true)&"</td>"                                       &   _
                            "<td> "&formataData(RS("DT_NASCIMENTO"))&"</td>"                             &   _
                            "<td>"&RS("RACA")&"</td>"                                                    &   _
                            "<td> "&CPF&"</td>"                                                          &   _
                            "<td>"&RS("PAIS")&"</td>"                                                    &   _
                            "<td>"&RS("POS")&"</td>"                                                     &   _
                            "<td>"&RS("POS_AREA")&"</td>"                                                &   _
                            "<td>"&RS("EFETIVO")&"</td>"                                                 &   _
                            "<td>"&RS("COD_DEFICIENCIA")&"</td>"                                         &   _
                            "<td>"&RS("NOME_SOCIAL")&"</td>"                                             &   _
                            "<td>"&RS("EXPECTATIVAS")&"</td>"                                            &   _
                            "<td>"&RS("COMO_SOUBE")&"</td>"                                              &   _
                            "<td>"&RS("ATUACAO_BIOMA")&"</td>"                                           &   _
                            "<td>"&RS("TEM_ATUACAO_BIOMA")&"</td>"                                       &   _
                            "</tr>"
    else
        Response.Write "<tr><td>"&RS("NOME")&"</td>"                                                         &   _
                            "<td>"&desc&"</td>"                                                              &   _
                            "<td>"&enti&"</td>"                                                              &   _
                            "<td>"&codenti&"</td>"                                                           &   _
                            "<td>"&cod_enti_uf_ibge&"</td>"                                                  &   _
                            "<td>"&cod_enti_muni_ibge&"</td>"                                                &   _
                            "<td>"&geocod_enti&"</td>"                                                       &   _
                            "<td>"&RS("COD_UF_IBGE")&"</td>"                                                 &   _
                            "<td>"&RS("COD_MUNI_IBGE")&"</td>"                                               &   _
                            "<td>"&geocod_muni&"</td>"                                                       &   _
                            "<td>"&SETOR&"</td>"                                                             &   _
                            "<td>"&RS("tipoenti")&"</td>"                                                    &   _
                            "<td>"&CARGO&"</td>"                                                             &   _
                            "<td>"&RS("ENDERECO_ENTI")&"</td>"                                               &   _
                            "<td>"&uf&"</td>"                                                                &   _
                            "<td>"&muni&"</td>"                                                              &   _
                            "<td>"&RS("CEP_ENTI")&"</td>"                                                    &   _
                            "<td>"&TEL_DDI_ENTIDADE&" "&TEL_DDD_ENTIDADE&" "&TEL_NUM_ENTIDADE&"</td>"        &   _
                            "<td>"&RS("EMAIL_ENTI")&"</td>"                                                  &   _
                            "<td>"&RS("ENDERECO")&"</td>"                                                    &   _
                            "<td>"&muniresid&"</td>"                                                         &   _
                            "<td>"&ufresid&"</td>"                                                           &   _
                            "<td>"&RS("CEP")&"</td>"                                                         &   _
                            "<td>"&TEL_DDI_PESSOAL&" "&TEL_DDD_PESSOAL&" "&TEL_NUM_PESSOAL&"</td>"           &   _
                            "<td>("&RS("FAX_DDI")&"-"&RS("FAX_DDD")&") "&RS("FAX")&"</td>"                   &   _
                            "<td>"&RS("EMAIL")&"</td>"                                                       &   _
                            "<td>"&RS("ESCOLARIDADE")&"</td>"                                                &   _
                            "<td>"&RS("FORMACAO")&"</td>"                                                    &   _
                            "<td>"&simnao(RS("SEXO"),true)&"</td>"                                           &   _
                            "<td> "&formataData(RS("DT_NASCIMENTO"))&"</td>"                                 &   _
                            "<td>"&RS("RACA")&"</td>"                                                        &   _
                            "<td> "&CPF&"</td>"                                                              &   _
                            "<td>"&RS("PAIS")&"</td>"                                                        &   _
                            "<td>"&RS("POS")&"</td>"                                                         &   _
                            "<td>"&RS("POS_AREA")&"</td>"                                                    &   _
                            "<td>"&RS("EFETIVO")&"</td>"                                                     &   _
                            "<td>"&RS("VALOR_PAGO")&"</td>"                                                  &   _
                            "<td> "&formataData(RS("DT_CADASTRO"))&"</td>"                                   &   _
                            "<td> "&formataData(RS("DT_PGT"))&"</td>"                                        &   _
                            "<td> "&aFormaPgt(RS("FORMA_PGT"))&"</td>"                                       &   _
                            "<td>"&RS("STATUS")&"</td>"                                                      &   _
                            "<td>" & COD_DEFICIENCIA &"</td>"                                                &   _
                            "<td>"&RS("NOME_SOCIAL")&"</td>"                                                 &   _
                            "<td>"&RS("EXPECTATIVAS")&"</td>"                                                &   _
                            "<td>"&RS("COMO_SOUBE")&"</td>"                                                  &   _
                            "<td>"&RS("ATUACAO_BIOMA")&"</td>"                                               &   _
                            "<td>"&RS("TEM_ATUACAO_BIOMA")&"</td>"                                           &   _
                            "</tr>"
    end if


    RS.MoveNext
WEND

RS.Close
conClose
conCloseSIM
Response.Write "</TABLE>"
Server.ScriptTimeout = 900
%>