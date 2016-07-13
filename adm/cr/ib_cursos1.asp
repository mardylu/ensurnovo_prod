<%

    Response.AddHeader "Access-Control-Allow-Origin" , "*"
    Response.AddHeader "Access-Control-Allow-Methods" , "GET, PUT, POST, DELETE, OPTIONS"

'    Response.ContentType = 'application/json'
'   Response.Write "{ ""request"": ""failed"", ""prompt"": """ & prompt & """ }"
    Response.Write "ASP - Voltei do cursos1.asp - Deu certo"


'    header('Access-Control-Allow-Origin: *');
'    header('Access-Control-Allow-Methods: GET, PUT, POST, DELETE, OPTIONS');

'    echo json_encode("Voltei do cursos_eng.php");

%>

