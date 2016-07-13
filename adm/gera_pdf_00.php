<?php

error_reporting(E_ALL);
ini_set('display_errors', 1);

    require "./fpdf_php/fpdf.php";

    $Ln = 5; //definindo a quebra de linha
    $font = 'Arial';
    $fs_titulos = 12;
    $fs_conteudos = 12;
//    $arquivo_texto = file_get_contents("./lerBR.txt");

    // Dados do banco
    $dbhost   = "10.0.0.1";             #Nome do host
    $db       = "ensur_insc_novo2";     #Nome do banco de dados
    $user     = "sqlibam";              #Nome do usuário
    $password = "sql";                  #Senha do usuário

    // Dados da tabela
//    $tabela = "nometabela";    #Nome da tabela
//    $campo1 = "campo1tabela";  #Nome do campo da tabela
//    $campo2 = "campo2tabela";  #Nome de outro campo da tabela

    $conninfo   = array("Database" => $db, "UID" => $user, "PWD" => $password);
    $conn       = sqlsrv_connect($dbhost, $conninfo);

    $instrucaoSQL = "SELECT nome, cpf FROM ALUNO WHERE CPF='38450577772' ORDER BY nome";

    $params = array();
    $options =array("Scrollable" => SQLSRV_CURSOR_KEYSET);
    $consulta = sqlsrv_query($conn, $instrucaoSQL, $params, $options);
    $numRegistros = sqlsrv_num_rows($consulta);

    echo "Esta tabela contém $numRegistros registros!\n<hr>\n";

    if ($numRegistros!=0) {
    	while ($cadaLinha = sqlsrv_fetch_array($consulta, SQLSRV_FETCH_ASSOC)) {
    		echo "$cadaLinha[$campo1] - $cadaLinha[$campo2]\n<br>\n";
    	}
    }


    $pdf=new FPDF('L','mm','A4');

//	    $textopdf = $arquivo_texto;
	    $textopdf = "xxxxxxxxxxxx";

//  CERTIFICADO  FRENTE
// echo "$textopdf Antes da Pag 01<br>";

        $pdf->AddPage();
        $pdf->SetFont($font,'',12);

        $pdf->Image("./img/certificado_frente.jpg", 0,0,300,210,"JPG");

//  CERTIFICADO  VERSO

// echo "$textopdf Antes da Pag 02<br>";
        $pdf->AddPage();
        $pdf->SetX("0","0");
        $pdf->SetY("0","0");
        $pdf->SetFont($font,'',12);
        $pdf->Write(57,"====< linha >====",1);

//  echo "$textopdf Depois da Pag 02<br>";
/*
        $pdf->SetXY("80","180");
        $pdf->Write(57,"====< linha >====",1);
        $pdf->Ln($Ln);
        $pdf->SetXY("20","201");
        $pdf->Write(57,====< linha >====,1);
*/
        $pdf->Image("./img/certificado_verso.jpg", 0,0,300,210,"JPG");

        $nome_arquivo = "Comunicado_" . date ("YMdHis") . ".pdf";
        $pdf->Output($nome_arquivo,"D");

?>