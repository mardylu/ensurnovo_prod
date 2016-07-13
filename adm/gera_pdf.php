<?php

    require "./fpdf_php/fpdf.php";

error_reporting(E_ALL);
ini_set('display_errors', 1);

echo "estou aqui";   exit;

    $Ln = 5; //definindo a quebra de linha
    $font = 'Arial';
    $fs_titulos = 12;
    $fs_conteudos = 12;
    $arquivo_texto = file_get_contents("./lerBR.txt");

    $pdf=new FPDF('P','mm','A4');

	    $textopdf = $arquivo_texto;

        $pdf->AddPage();
        $pdf->SetFont($font,'',12);

        $pdf->Image("./img/certificado_frente.jpg", 0,0,300,210,"JPG");

        $pdf->SetFillColor(132, 208, 240);        // FILL com azul do logo
        //	$pdf->Rect(float x, float y, float w, float h [, string style])
        $pdf->Rect(20, 25, 180, 1, F);
        // Posicionamento X=horizontal Y=vertical
        $pdf->SetXY("138","19");
        $pdf->SetFont($font,'',10);
        $pdf->MultiCell(0, 4, "Condomínios  -  Locações  -  Vendas", 10, 120, 'J');
        $pdf->SetFont($font,'',12);

        // Cabeçalho do Documento
        $pdf->SetXY("60","20");
        $pdf->SetFont($font,'B',18);
        $pdf->Write(57,"DECLARAÇÃO DE QUITAÇÃO",1);
        $pdf->SetFont('');

        // Texto que será impresso no documento
        $doc_texto = "Na qualidade de Administradora do Condomínio XX_NOME, situado na XX_ENDER, " .
                  "declaramos para os devidos fins que baseados em nossos registros " .
                  "contábeis durante nossa administração, a unidade acima referenciada " .
                  "está em dia com as quotas condominiais até XX_DATA.";
        // Posicionamento do Texto após ser alterado - MultiCell (largura, altura, texto, borda, alinhamento)
        $pdf->SetXY("30","120");
        $pdf->SetFont($font,'',12);
        //	 $pdf->MultiCell(0, 8, $doc_texto, 10, 120, 'J');
        $pdf->MultiCell(160, 8, $doc_texto, 0, 'J');
        $pdf->SetFont('');

        // Data de geração do documento de quitação
        $pdf->Write(10,"\n\n\n",1);
        $pdf->SetX("30");
        $pdf->SetFont($font,'B',12);
        $pdf->Write(10,$textopdf . "\n\n",1);

        // Linha para assinatura do responsável
        $pdf->Write(10,"\n\n",1);
        $pdf->SetX("30");
        $pdf->SetFont($font,'B',12);
        //	 $pdf->Write(5,"_____________________________________\n",1);
        $pdf->SetX("30");
        $pdf->Write(10,"Atlântida Administradora - Depto Cobrança",1);

        // (Texto a ser impresso: início, altura, texto, borda, quebra de linha)
        //	 $pdf->MultiCell(0, 4, $textopdf, 10, 3, 'J');


        $pdf->AddPage();
        $pdf->SetFont($font,'B',12);
        // (local da imagem, Pos horizontal, Pos vertical, largura, altura)

        $pdf->Image("./img/certificado_verso.jpg", 0,0,300,210,"JPG");

        $pdf->SetXY("80","180");
        $pdf->Ln($Ln);
        $pdf->Write(57,"====< linha >====",1);
        $pdf->Ln($Ln);
        $pdf->SetXY("20","201");
        $pdf->Write(57,====< linha >====,1);
        $pdf->Ln($Ln);
        $pdf->SetXY("20","205");
        $pdf->Write(57,====< linha >====,1);
        $pdf->Ln($Ln);
        $pdf->SetXY("20","209");
        $pdf->Write(57,====< linha >====,1);
        $pdf->Ln($Ln);
        $pdf->SetXY("20","213");
        $pdf->Write(57,====< linha >====,1);
        $pdf->Write(57,====< linha >====,1);
        $pdf->Ln($Ln);
        $pdf->SetXY("20","217");
        $pdf->Write(57,====< linha >====,1);

        $nome_arquivo = "Comunicado_" . date ("YMdHis") . ".pdf";
        $pdf->Output($nome_arquivo,"D");

?>