#!/usr/bin/php -q
<?php

    set_time_limit(0);
    require('phpagi.php');
 
    $agi = new AGI();

    $calleridnum    = $agi->request['agi_callerid'];
    $callerid       = $agi->request['agi_callerid'];
    $callidname     = $agi->request['agi_calleridname'];
    $phoneno        = $agi->request['agi_dnid'];
    $channel        = $agi->request['agi_channel'];
    $uniqueid       = $agi->request['agi_uniqueid'];


    //$agi->stream_file($uniqueid);
    

    //contesto
    

    $agi->answer();
    $tiempoDeEspera = 5000;
    $digitosPin = 12;

  //  $agi->exec('DIAL', "SIP/une/4819289");

    ///$agi->exec('GOTO', "traductor,s,1");
    //$agi->exec_goto('traductor,s,1');

            
    //$agi->set_variable('CALLERID', '43202031');

    $url = 'http://104.131.89.133/';

                                            
    // $agi->stream_file('traductores/ESPANOL/pininvalido');



    function obtenerTelefonos($lang){
        $url = 'http://104.131.89.133/languages/'.$lang.'/phones.json';
        $respuesta = json_decode(file_get_contents($url));
        return $respuesta;  
    }
    




    function disponible($codigo){

        $url = 'http://104.131.89.133/codes/consulta?code='.$codigo;
        $respuesta = json_decode(file_get_contents($url));
       // foreach($respuesta[0] as $key=>$value) { $fields_string .= $key.'='.$value.'&'; }
        

        
        $respuesta = $respuesta[0];
      
      

        if($respuesta->blank == "-1"){
            $respuesta = "-1";
        }else{
              $total = $respuesta->disponible;

            $respuesta  =  floor($total/60);
        }

        return $respuesta;
 
    }



    foreach ($obtenerTelefonos(1) as $key => $value) {
        $agi->exec('DIAL', "SIP/servicom/03".$value->phone.",10,gHCL(360000:360000:0000)");  
    }
      


  //  $agi->exec_dial("SIP/4444141,100,HCL(10000:10000:0000)");


 // $agi->exec('DIAL', 'SIP/1021'.",30,gHCL(10000:10000:0000)");

   // $callduration = $agi->get_variable("ANSWEREDTIME");  
    //foreach($callduration as $key=>$value) { $fields_string .= $key.'='.$value.'&'; }
    //file_get_contents('http://webdaniel.info/nethexa/?'.$fields_string);

    //$agi->exec('Dial("SIP/1021,60,HCL(5:5:0000)")');
    //$agi->stream_file('traductores/ESPANOL/Gracias_por_llamar_a_nuestra_compañia');


       // $agi->get_data('traductores/saludo', $tiempoDeEspera, 1);

      // $agi->exec_dial("SIP/une/033104452509,HCL(5:5:0000)");

        //$agi->exec("set_context($context)");
       





       
        //$agi->exec("ResetCDR");
       // $callduration = $agi->get_variable("ANSWEREDTIME"); 

       // $callduration = $agi->get_variable("CDR(billsec)"); 

      ///  foreach($callduration as $key=>$value) { $fields_string .= $key.'='.$value.'&'; }


       


         // file_get_contents('http://webdaniel.info/nethexa/?'.$fields_string);
 
        


 



    $cuenta = 1;
do{
    //$result =  $agi->get_data('traductores/saludo', $tiempoDeEspera, 1);
    $result =  $agi->get_data('traductores/saludo', $tiempoDeEspera, 1);
        $cuenta++;
        if($cuenta == 5){
            $agi->hangup();
        }

    if($result['result'] > 0 && $result['result'] < 4){

    }else{
        $result['result']="";
    }




}while($result['result']=="");
    


    //ingreso por español
    if($result['result'] == 1){

        $cuenta = 1;
        do{

            //aqui se pone el audio donde dice 1 para ingles, 2 para español
            $opcion =  $agi->get_data('traductores/seleccione_idioma', $tiempoDeEspera, 1);
            $cuenta++;
            if($cuenta == 5){
                $agi->hangup();
            }

        }while($opcion['result']=="");



        $phone = $opcion['result']+1;
        

        $cuenta = 1;
        do{
            $pin =  $agi->get_data('traductores/ESPANOL/Ingrese_su_codigo_pin', $tiempoDeEspera, $digitosPin);
            $cuenta++;
            if($cuenta == 5){
                $agi->hangup();
            }
        }while($pin['result']=="");
         

        if($pin['result'] == '00'){
            $agi->stream_file('traductores/ESPANOL/Gracias_por_llamar_a_nuestra_compania');  
            $agi->hangup();
        }else{

            $saldo = disponible($pin['result']);

            do{
                $pin =  $agi->get_data('traductores/ESPANOL/pininvalido', $tiempoDeEspera, $digitosPin);
                $saldo = disponible($pin['result']);
            }while($saldo == "-1");

    
            //TIENE SALDO
            $agi->stream_file('traductores/ESPANOL/Su_saldo_es');
            $agi->stream_file('traductores/ESPANOL/'.$saldo.'_minutos');
            $cuenta = $opcion['result']+1;
            do{
                $continuar =  $agi->get_data('traductores/ESPANOL/Presione_asterisco_para_iniciar_la_traduccion', $tiempoDeEspera, 1);
                $cuenta++;
                if($cuenta == 5){
                    $agi->hangup();
                }
            }while($continuar['result']=="");
            
            
            if($continuar['result'] == '*'){

                $phone = obtenerTelefonos($phone);
                $time = 60000*$saldo;
                $antesDeLlamada = time();


               //Parce aqui se cambia los datos
                $agi->exec('DIAL', "SIP/servicom/03".$phone.",10,gHCL(".$time.":".$time.":0000)");
                $callduration = $agi->get_variable("ANSWEREDTIME"); 


                $despuesDeLlamada = time();
                $tiempodellamada = $despuesDeLlamada - $antesDeLlamada;

                $tiempodellamada = $tiempodellamada-10;
                foreach($callduration as $key=>$value) { $fields_string .= $key.'='.$value.'&'; }
                file_get_contents('http://104.131.89.133/codes/adduse?code='.$pin['result'].'&time='.$tiempodellamada.'&idioma=1');

            }

        }        
    }
    





     //Ingreso por ingles
    if($result['result'] == 2){  

        $cuenta = 1;
        do{
            $pin =  $agi->get_data('traductores/INGLES/Enter_your_PIN_CODE', $tiempoDeEspera, $digitosPin);
            $cuenta++;
            if($cuenta == 5){
                $agi->hangup();
            }
        }while($pin['result']=="");
         

        if($pin['result'] == '00'){
            $agi->stream_file('traductores/INGLES/Gracias_por_llamar_a_nuestra_compañia');
            $agi->hangup();
            
        }else{  
            $saldo =disponible($pin['result']);
            
            do{
                $pin =  $agi->get_data('traductores/ESPANOL/pininvalido', $tiempoDeEspera, $digitosPin);
                $saldo = disponible($pin['result']);
            }while($saldo == "-1");





                //TIENE SALDO
                $agi->stream_file('traductores/INGLES/Your_balance_is');
                $agi->stream_file('traductores/INGLES/'.$saldo.'_minutes');



                $cuenta = 1;
                do{
                    $continuar =  $agi->get_data('traductores/INGLES/Press_asterisk_to_start_your_translation', $tiempoDeEspera, 1);
                    $cuenta++;
                    if($cuenta == 5){
                        $agi->hangup();
                    }
                }while($continuar['result']=="");
                
                
                if($continuar['result'] == '*'){

                    $phone = obtenerTelefonos(2);
                    $time = 60000*$saldo;
                    $antesDeLlamada = time();

                    $agi->exec('DIAL', "SIP/servicom/03".$phone.",30,gHCL(".$time.":".$time.":0000)");
                    $callduration = $agi->get_variable("ANSWEREDTIME"); 


                    $despuesDeLlamada = time();
                    $tiempodellamada = $despuesDeLlamada - $antesDeLlamada;

                    $tiempodellamada = $tiempodellamada-10;
                    foreach($callduration as $key=>$value) { $fields_string .= $key.'='.$value.'&'; }
                    file_get_contents('http://104.131.89.133/codes/adduse?code='.$pin['result'].'&time='.$tiempodellamada.'&idioma=2');


                        
                        
                }
            

        }
          
    }





     //Ingreso por frances
    if($result['result'] == 3){  

        $cuenta = 1;
        do{
            $pin =  $agi->get_data('traductores/FRANCES/Entrez_votre_code_pin', $tiempoDeEspera, $digitosPin);
            $cuenta++;
            if($cuenta == 5){
                $agi->hangup();
            }
        }while($pin['result']=="");
         $agi->stream_file($pin['result']);



        if($pin['result'] == '00'){
            $agi->stream_file('traductores/ESPANOL/Gracias_por_llamar_a_nuestra_compañia');
            $agi->hangup();
            
        }else{    


            $saldo =disponible($pin['result']);


            do{
                $pin =  $agi->get_data('traductores/ESPANOL/pininvalido', $tiempoDeEspera, $digitosPin);
                $saldo = disponible($pin['result']);
            }while($saldo == "-1");
      
                //TIENE SALDO
                $agi->stream_file('traductores/FRANCES/Votre_solde_est');
                $agi->stream_file('traductores/FRANCES/'.$saldo.'_minutos');



                $cuenta = 1;
                do{
                    $continuar =  $agi->get_data('traductores/FRANCES/appuvez_sur_asterisco_pour_lancer_la_traduction', $tiempoDeEspera, 1);
                    $cuenta++;
                    if($cuenta == 5){
                        $agi->hangup();
                    }
                }while($continuar['result']=="");
                
                
                if($continuar['result'] == '*'){
                        $phone = obtenerTelefonos(3);
                        $time = 60000*$saldo;
                        $antesDeLlamada = time();

                        $agi->exec('DIAL', "SIP/servicom/03".$phone.",30,gHCL(".$time.":".$time.":0000)");
                        $callduration = $agi->get_variable("ANSWEREDTIME"); 


                        $despuesDeLlamada = time();
                        $tiempodellamada = $despuesDeLlamada - $antesDeLlamada;

                       // $tiempodellamada = $tiempodellamada-10;
                        foreach($callduration as $key=>$value) { $fields_string .= $key.'='.$value.'&'; }
                        file_get_contents('http://104.131.89.133/codes/adduse?code='.$pin['result'].'&time='.$tiempodellamada.'&idioma=3');



                }
            

        }
          
    }







    //Ingreso por PORTUGUES
    if($result['result'] == 4){  

        $cuenta = 1;
        do{
            $pin =  $agi->get_data('traductores/PORTUGUES/Favor_digitar_seu_codigo_pin', $tiempoDeEspera, $digitosPin);
            $cuenta++;
            if($cuenta == 5){
                $agi->hangup();
            }
        }while($pin['result']=="");
         





        if($pin['result'] == '00'){
            $agi->stream_file('traductores/ESPANOL/Gracias_por_llamar_a_nuestra_compañia');
            $agi->hangup();
            
        }else{  


            $saldo =disponible($pin['result']);
            do{
                $pin =  $agi->get_data('traductores/ESPANOL/pininvalido', $tiempoDeEspera, $digitosPin);
                $saldo = disponible($pin['result']);
            }while($saldo == "-1");


                //TIENE SALDO
                $agi->stream_file('traductores/PORTUGUES/Seu_saudo_e');
                $agi->stream_file('traductores/PORTUGUES/'.$saldo.'_minutos');



                $cuenta = 1;
                do{
                    $continuar =  $agi->get_data('traductores/PORTUGUES/Por_favor_presiona_australinea_para_iniciar_a_traducao', $tiempoDeEspera, 1);
                    $cuenta++;
                    if($cuenta == 5){
                        $agi->hangup();
                    }
                }while($continuar['result']=="");
                
                
                if($continuar['result'] == '*'){
                    $phone = obtenerTelefonos(4);
                    $time = 60000*$saldo;
                    $antesDeLlamada = time();
                    $agi->exec('DIAL', "SIP/servicom/03".$phone.",30,gHCL(".$time.":".$time.":0000)");
                    $callduration = $agi->get_variable("ANSWEREDTIME"); 
                    $despuesDeLlamada = time();
                    $tiempodellamada = $despuesDeLlamada - $antesDeLlamada;
                   // $tiempodellamada = $tiempodellamada-10;
                    foreach($callduration as $key=>$value) { $fields_string .= $key.'='.$value.'&'; }
                    file_get_contents('http://104.131.89.133/codes/adduse?code='.$pin['result'].'&time='.$tiempodellamada.'&idioma=4');


                }
            

        }
          
    }



    //Ingreso por ITALIANO
    if($result['result'] == 5){  

        $cuenta = 1;
        do{
            $pin =  $agi->get_data('traductores/ITALIANO/Inserisca_il_codice_pin', $tiempoDeEspera, $digitosPin);
            
            $cuenta++;
            if($cuenta == 5){
                $agi->hangup();
            }
        }while($pin['result']=="");
         $agi->stream_file($pin['result']);



        if($pin['result'] == '00'){
            $agi->stream_file('traductores/ESPANOL/Gracias_por_llamar_a_nuestra_compañia');
            $agi->hangup();
            
        }else{ 


            $saldo =disponible($pin['result']);
            do{
                $pin =  $agi->get_data('traductores/ESPANOL/pininvalido', $tiempoDeEspera, $digitosPin);
                $saldo = disponible($pin['result']);
            }while($saldo == "-1");

      
                //TIENE SALDO
                $agi->stream_file('traductores/ITALIANO/Il_suo_saldo_e');
                $agi->stream_file('traductores/ITALIANO/'.$saldo.'_minutos');


                $cuenta = 1;
                do{
                    $continuar =  $agi->get_data('traductores/ITALIANO/Prema_asterisco_per_iniziare_la_traduzione', $tiempoDeEspera, 1);
                    $cuenta++;
                    if($cuenta == 5){
                        $agi->hangup();
                    }
                }while($continuar['result']=="");
                
                
                if($continuar['result'] == '*'){
                    $phone = obtenerTelefonos(5);
                    $time = 60000*$saldo;
                    $antesDeLlamada = time();
                    $agi->exec('DIAL', "SIP/servicom/03".$phone.",30,gHCL(".$time.":".$time.":0000)");
                    $callduration = $agi->get_variable("ANSWEREDTIME"); 
                    $despuesDeLlamada = time();
                    $tiempodellamada = $despuesDeLlamada - $antesDeLlamada;
                   // $tiempodellamada = $tiempodellamada-10;
                    foreach($callduration as $key=>$value) { $fields_string .= $key.'='.$value.'&'; }
                    file_get_contents('http://104.131.89.133/codes/adduse?code='.$pin['result'].'&time='.$tiempodellamada.'&idioma=5');



                }

            

        }
          
    }






    

//TERMINO





    //  //$agi->stream_file($result['result']);
     

    // $result = $agi->wait_for_digit(-1);


    //  $agi->stream_file('traductores/ESPANOL/Presione_1_para_español');
    //  $agi->stream_file('traductores/INGLES/Press_2_for_english');
    //  $agi->stream_file('traductores/FRANCES/Pour_le_francais_chaisir_le_3');
    //  $agi->stream_file('traductores/PORTUGUES/Presione_4_para_portugues');
    //  $agi->stream_file('traductores/ITALIANO/Prema_5_per_italiano');
    


  // do{
  //   $agi->stream_file('ESP/Bienvenido_a_la_linea_de_traductores_en_tiempo_real&'.
  //           'ESP/Presione_1_para_español&'.
  //           'ENG/Press_2_for_english&'.
  //           'FRA/Pour_le_francais_chaisir_le_3&'.
  //           'POR/Presione_4_para_portugues&'.
  //           'ITA/Prema_5_per_italiano');



  //   $result = $agi->get_data('beep', 3000, 20);
  //   var_dump($result);
  //   $agi->text2wav("You entered $keys");
  //   } 
  //   while($keys != '111');


  //   $agi->text2wav('Goodbye');
  //   $agi->hangup();
