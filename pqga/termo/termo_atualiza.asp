<!-- #INCLUDE FILE="../includes/parametros.asp" -->
<!-- #INCLUDE FILE="../includes/conOpen.asp" -->

<%
    cod_aluno = request("cod_aluno")
    id_turma  = request("id_turma")
    aceito    = request("aceito")

    if (aceito = "aceito") then
        con.execute "UPDATE TURMA_ALUNO set TERMO_COMPROMISSO='1' WHERE COD_ALUNO='" & cod_aluno & "' AND id_turma='" & id_turma & "'"
    end if
%>


        <html>
        <head>
        <style>
        p {
            font-family: Arial, Helvetica, sans-serif;
            font-size: 12px;
        }
        </style>
        </head>
        <body lang=PT-BR link=blue vlink=purple style='tab-interval:35.4pt'>
        <div class=WordSection1>
        <p ></p>
        <table border=1 cellpadding=8 width='90%'>
         <tr>
          <td width=573 valign=top>
          <p>
            <table width='100%'>
                <tr>
                    <td align='left'  width='50%'><img width=269 height=108 src='http://cursos.ibam.org.br/pqga/images/Email_PQGA_logo01.png'></td>
                    <td align='right' width='50%'><img width=164 height=90 src='http://cursos.ibam.org.br/pqga/images/Email_PQGA_logo02.jpg'></td>
                </tr>
            </table>
          </p>
          </td>
         </tr>
         <tr>
          <td width=573 valign=top>
          <p><br>
                <%
                    if (aceito = "aceito") then
                        Response.Write "Seu aceite no Termo de Compromisso foi enviado. Sua participação na turma está confirmada. " &  _
                                       "Você receberá um e-mail assim que a turma iniciar.</p>"
                    else
                        Response.Write "OBRIGADO POR EFETUAR A PRÉ-INSCRIÇÃO. SUA INSCRIÇÃO SÓ SERÁ EFETIVADA APÓS O ACEITE DO TERMO DE COMPROMISSO</p>"
                    end if
                %>
          </td>
         </tr>
         <tr>
          <td width=573 valign=top>
          <p>Mais informações <a href='http://amazonia-ibam.org.br' target='_blank' title='Este link externo irá abrir em nova janela'><b>clique
          aqui</b></a> ou pelo email <a href='mailto:pqga-ead@ibam.org.br' target='_blank' title='Este link externo irá abrir em nova janela'>
          <b>pqga-ead@ibam.org.br</b></a> | (21) 2536-9774 </p>
          </td>
         </tr>
        </table>
        <p></p>
        </div>
        </body>
        </html>














