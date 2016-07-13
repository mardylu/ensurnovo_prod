<%


<!-- #INCLUDE FILE="../../library/parametros.asp" -->
<!-- #INCLUDE FILE="../../library/conOpen.asp" -->

Set RS1 = Server.CreateObject("ADODB.Recordset")
RS1.CursorType = 0
RS1.ActiveConnection = Con

Set RS2 = Server.CreateObject("ADODB.Recordset")
RS2.CursorType = 0
RS2.ActiveConnection = Con

Set RS3 = Server.CreateObject("ADODB.Recordset")
RS3.CursorType = 0
RS3.ActiveConnection = Con


'-----------------------------------------------------------------
' GRAVAÇÃO DO ARQUIVO DE ERROS

Dim objeto, gravaArquivo, sArquivo

Set objeto = CreateObject("Scripting.FileSystemObject")
sArquivo = Server.MapPath ("erros.txt")

Set gravaArquivo = objeto.CreateTextFile(sArquivo ,True)



'-----------------------------------------------------
' FUNÇÃO DE VALIDAÇÃO DO EMAIL

Function EmailValido(email)
Set objRegExp = New RegExp
objRegExp.Pattern = "^[a-z0-9._-]+\@[a-z0-9._-]+\.[a-z]{2,4}$"
objRegExp.IgnoreCase = True
EmailValido = objRegExp.Test(email)
End Function



'-----------------------------------------------------
'Funcao: IsCPF(ByVal intNumero)
'Sinopse: Verifica se o valor passado é um CPF válido
'          Formatos aceitos: XXX.XXX.XXX-XX ou
'                            XXXXXXXXXXXXXX
'Parametro: intNumero
'Retorno: Booleano
'-----------------------------------------------------
Function IsCPF(ByVal intNumero)

' Response.Write(intNumero)
' Response.End

    'Validando o formato do CPF com expressão regular
    Set regEx = New RegExp                            'Cria o Objeto Expressão
    regEx.Pattern = "^(\d{3}\.\d{3}\.\d{3}-\d{2})|(\d{11})$"    ' Expressão Regular
    regEx.IgnoreCase = True                            ' Sensitivo ou não
    regEx.Global = True
    Retorno = RegEx.Test(intNumero)
    Set regEx = Nothing

    'Caso seja verdadeiro posso validar se o CPF é válido
    If Retorno = True Then
        'Validando a sequencia números
        Dim CPF_temp
        CPF_temp            = intNumero
        CPF_temp            = Replace(CPF_temp, ".", "")
        CPF_temp            = Replace(CPF_temp, "-", "")
        CPF_Digito_temp     = Right(CPF_temp, 2)

        'Somando os nove primeiros digitos do CPF
        Soma    = (Clng(Mid(CPF_temp,1,1)) * 10) + (Clng(Mid(CPF_temp,2,1)) * 9) + (Clng(Mid(CPF_temp,3,1)) * 8) + (Clng(Mid(CPF_temp,4,1)) * 7) + (Clng(Mid(CPF_temp,5,1)) * 6) + (Clng(Mid(CPF_temp,6,1)) * 5) + (Clng(Mid(CPF_temp,7,1)) * 4) + (Clng(Mid(CPF_temp,8,1)) * 3) + (Clng(Mid(CPF_temp,9,1)) * 2)
        '----------------------------------
        'Calculando o 1º dígito verificador
        '----------------------------------
        'Pegando o resto da divisão por 11
        Resto    = (Soma Mod 11)

        If Resto = 1 Or Resto = 0 Then
            DigitoHum = 0
        Else
            DigitoHum = Cstr(11-Resto)
        End If
        '----------------------------------
        '----------------------------------
        'Calculando o 2º dígito verificador
        '----------------------------------
        'Somando os 9 primeiros digitos do CPF mais o 1º dígito
        Soma    = (Clng(Mid(CPF_temp,1,1)) * 11) + (Clng(Mid(CPF_temp,2,1)) * 10) + (Clng(Mid(CPF_temp,3,1)) * 9) + (Clng(Mid(CPF_temp,4,1)) * 8) + (Clng(Mid(CPF_temp,5,1)) * 7) + (Clng(Mid(CPF_temp,6,1)) * 6) + (Clng(Mid(CPF_temp,7,1)) * 5) + (Clng(Mid(CPF_temp,8,1)) * 4) + (Clng(Mid(CPF_temp,9,1)) * 3) + (DigitoHum * 2)
        'Pegando o resto da divisão por 11
        Resto    = (Soma Mod 11)

        If Resto = 1 Or Resto = 0 Then
            DigitoDois = 0
        Else
            DigitoDois = Cstr(11-Resto)
        End If
        '----------------------------------
        'Verificando se os digitos são iguais aos digítados.
        DigitoCPF = Cstr(DigitoHum) & Cstr(DigitoDois)
        If Cstr(CPF_Digito_temp) = Cstr(DigitoCPF) Then
            Retorno = True
        Else
            Retorno = False
        End If
    End If
    IsCPF = Retorno
End Function















dim arquivocsv,contador,linha,fso,objFile

arquivocsv = "./planilha468.csv"

set fso = createobject("scripting.filesystemobject")
set objFile = fso.opentextfile(server.mappath(arquivocsv))

strimportando = "<table cellpadding=""3"" cellspacing=""1"" border=""1"">"

qtde = 0
soma = 0
Do Until objFile.AtEndOfStream
      linha = split(objFile.ReadLine,";")
      strimportando = strimportando & "<tr>"
    totalregistros = ubound(linha)

    if (qtde > 0 )  then

        erro = ""

        Response.Write (totalregistros)

        id_turma            = linha(0)
        nome                = linha(1)
        pais                = linha(2)
        cpf                 = linha(3)
        dt_nasc             = linha(4)
        sexo                = linha(5)
        raca                = linha(6)
        email               = linha(7)
        endereco            = linha(8)
        cep                 = linha(9)
        uf                  = linha(10)
        municipio           = linha(11)
        telefone            = linha(12)
        escolaridade        = linha(13)
        curso               = linha(14)
        pos                 = linha(15)
        natureza            = linha(16)
        nome_social         = linha(17)
        setor               = linha(18)
        cargo               = linha(19)
        area                = linha(20)
        email_enti          = linha(21)
        tel_enti            = linha(22)
        tipo_enti           = linha(23)
        cnpj_enti           = linha(24)
        nome_enti           = linha(25)
        area_atuacao        = linha(26)
        uf_enti             = linha(27)
        muni_enti           = linha(28)
        endereco_enti       = linha(29)
        cep_enti            = linha(30)
        site                = linha(31)
        expectativa         = linha(32)
        como_soube          = linha(33)
        atuacao             = linha(34)
        info                = linha(35)

' CPF

        cpf = replace(cpf, "-", "")
        cpf = replace(cpf, ".", "")
        cpf = replace(cpf, " ", "")
        ' call IsCPF("aqui o numero de cpf")
        se_cpf_ok = IsCPF(cpf)
        if (se_cpf_ok = false) then
            Response.Write("Tem erro")
            gravaArquivo.WriteLine("Erro: CPF errado." & cpf)
            erro = "sim"
        end if
        if ( len(cpf) < 11 ) then
            gravaArquivo.WriteLine("Erro: CPF com tamanho errado." & cpf)
            erro = "sim"
        end if
        if (se_cpf_ok = true ) then Response.Write("CPF correto")  end if

' Data de Nascimento
        dt_nasc = replace(dt_nasc, " ", "")
        dt_nasc = replace(dt_nasc, "/", "")
        dt_nasc = replace(dt_nasc, "-", "")
        if ( len(dt_nasc) < 7 ) then
            gravaArquivo.WriteLine("Erro: CPF ." & cpf & " - " & "Data inválida" & " - " & dt_nasc)
            dt_nasc = "00000000"
            erro = "sim"
        end if
        if ( len(dt_nasc) = 7 ) then  dt_nasc = "0" & dt_nasc  end if
        dt_nasc_dia = mid(dt_nasc,1,2)
        dt_nasc_mes = mid(dt_nasc,3,2)
        dt_nasc_ano = mid(dt_nasc,5,4)
        if (dt_nasc_dia < 1 ) AND ( dt_nasc_dia > 31 )  then
            gravaArquivo.WriteLine("Erro: CPF ." & cpf & " - " & "Dia inválido" & " - " & dt_nasc)
            erro = "sim"
        end if
        if (dt_nasc_mes < 1 ) AND ( dt_nasc_mes > 12 )  then
            gravaArquivo.WriteLine("Erro: CPF ." & cpf & " - " & "Mês inválido" & " - " & dt_nasc)
            erro = "sim"
        end if
        if (dt_nasc_ano < 1940 ) AND ( dt_nasc_ano > 2000 )  then
            gravaArquivo.WriteLine("Erro: CPF ." & cpf & " - " & "Ano inválido" & " - " & dt_nasc)
            erro = "sim"
        end if

        ' Response.Write (dt_nasc_dia&dt_nasc_mes&dt_nasc_ano)
        ' Response.End

' SEXO
        if (sexo <> "M" ) AND ( sexo <> "F" )  then
            gravaArquivo.WriteLine("Erro: CPF ." & cpf & " - " & "Sexo inválido" & " - " & sexo)
            erro = "sim"
        end if

' RAÇA
        raca = replace(raca, " ", "")
        if ( len(raca) < 1 ) then
            gravaArquivo.WriteLine("Erro: CPF ." & cpf & " - " & "Raça inválida" & " - " & raca)
            erro = "sim"
        end if
        if ( raca <> "P" ) AND ( raca <> "B" ) AND ( raca <> "N" ) then
            gravaArquivo.WriteLine("Erro: CPF ." & cpf & " - " & "Raça inválida" & " - " & raca)
            erro = "sim"
        end if

' EMAIL
        If EmailValido(Trim(email)) = True Then
            'Aqui o código continua quando o e-mail é valido   - Usar se precisar
        Else
            gravaArquivo.WriteLine("Erro: CPF ." & cpf & " - " & "Email inválido" & " - " & email)
            erro = "sim"
            ' Response.Write ( "Email: " & email )
            ' Response.End
        End If

' ENDEREÇO
        if ( len(endereco) < 4 ) then
            gravaArquivo.WriteLine("Erro: CPF ." & cpf & " - " & "Endereço inválido" & " - " & endereco)
            erro = "sim"
        end if

' CEP
        cep = replace(cep, "-", "")
        cep = replace(cep, ".", "")
        cep = replace(cep, "/", "")
        cep = replace(cep, " ", "")
        if ( len(cep) <> 8 ) then
            gravaArquivo.WriteLine("Erro: CPF ." & cpf & " - " & "CEP inválido" & " - " & cep)
            erro = "sim"
        end if

' UF
        if ( len(uf) <> 2 ) then
            gravaArquivo.WriteLine("Erro: CPF ." & cpf & " - " & "Estado inválido" & " - " & uf)
            erro = "sim"
        end if

' MUNICÍPIO
        if ( len(municipio) < 3 ) then
            gravaArquivo.WriteLine("Erro: CPF ." & cpf & " - " & "Município inválido" & " - " & municipio)
            erro = "sim"
        end if

' TELEFONE
        telefone = replace(telefone, " ", "")
        telefone = replace(telefone, "-", "")
        telefone = replace(telefone, "(", "")
        telefone = replace(telefone, ")", "")
        telefone = replace(telefone, "/", "")
        if ( len(telefone) <> 11 ) then
            gravaArquivo.WriteLine("Erro: CPF ." & cpf & " - " & "Celular inválido" & " - " & telefone)
            erro = "sim"
        end if
        ddd_celular = mid(telefone,1,2)
        num_celular = mid(telefone,3,9)

' ESCOLARIDADE
        escolaridade = replace(escolaridade, " ", "")
        escolaridade = replace(escolaridade, "embranco", "")
        if ( len(escolaridade) < 1 ) then
            escolaridade = 4
        end if
        if ( escolaridade = "EM C" )  then escolaridade = 4 end if
        if ( escolaridade = "NT C" )  then escolaridade = 6 end if
        if ( escolaridade = "ES C" )  then escolaridade = 8 end if
        if ( escolaridade = "ES I" )  then escolaridade = 7 end if
        if ( escolaridade = "EM C/NT I/ES I" )  then escolaridade = 8 end if

        if  ( ( escolaridade <> 4 )  AND  ( escolaridade <> 6 )  AND  ( escolaridade <> 7 )  AND  ( escolaridade <> 8 ) )  then
            escolaridade = 4
        end if

' POS GRADUAÇÃO

        pos = replace(pos, " ", "")
        if ( (len(pos) = 1) AND (pos = "E") )   then    pos = 1   else  pos = 0 end if

' ATUALIZAR BASE DE DADOS

        Response.Write ( "Erro: "&erro&" - " )
        Response.Write ( "Qtde: "&qtde )
        Response.Write ( "id_turma:"&id_turma )
        Response.Write ( "nome:"&nome )
        Response.Write ( "pais:"&pais )
        Response.Write ( "cpf:"&cpf )
        Response.Write (  "<br>" )


        ' Response.End

    end if

    qtde = qtde + 1

Loop

objFile.Close

gravaArquivo.close
set objeto =nothing
set gravaArquivo =nothing

response.Write ("Total de Registros: ")&qtde
%>

