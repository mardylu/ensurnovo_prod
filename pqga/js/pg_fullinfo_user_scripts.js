(function()
{
 "use strict";
 /*
   hook up event handlers 
 */
 function register_event_handlers()
 {


        /* button  #btn_esqueci_voltar */
    $(document).on("click", "#btn_esqueci_voltar", function(evt)
    {
         activate_page("#mainpage"); 
    });
    
        /* button  #btn_esqueciminhasenha */
    $(document).on("click", "#btn_esqueciminhasenha", function(evt)
    {
         activate_page("#pg_esquecisenha"); 
    });
    
        /* button  #btn_voltartrocasenha */
    $(document).on("click", "#btn_voltartrocasenha", function(evt)
    {
         activate_page("#mainpage"); 
    });
    
        /* button  #btn_trocarsenha */
    $(document).on("click", "#btn_trocarsenha", function(evt)
    {
         activate_page("#pg_trocasenha"); 
    });
    
    }
 document.addEventListener("app.Ready", register_event_handlers, false);
})();
