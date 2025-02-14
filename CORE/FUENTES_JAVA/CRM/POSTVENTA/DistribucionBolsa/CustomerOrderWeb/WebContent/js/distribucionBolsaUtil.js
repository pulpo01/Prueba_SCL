	var cantidadElementos = 0;
	function cambiaValores()
	{
        if(document.forms[0].minutesToAssign == null)
        {
         	alert('No existe bolsa para asignar');
        }
        else if(!isArray(document.forms[0].minutesToAssign))	//esto sucede cuando solo existe una linea
        {
			aux = document.forms[0].minutesToAssign.value;
			document.forms[0].minutesToAssign.value = document.forms[0].conversion.value;
			document.forms[0].conversion.value = aux;
			
			document.forms[0].minutosTotal.value = document.forms[0].minutesToAssign.value;
        }
        else
      	{
			for( i = 0 ; i < document.forms[0].minutesToAssign.length ; i++ )
			{
				aux = document.forms[0].minutesToAssign[i].value;
				document.forms[0].minutesToAssign[i].value = document.forms[0].conversion[i].value;
				document.forms[0].conversion[i].value = aux;
			}
			
			Suma();
		}
	}
	
	
	
      function Suma(){
        var suma = 0;
        var j = 0;
        var sumar = "+";
        var cero = 0;
        
        try
        {
         if (document.forms[0].unidadesA[0].checked || document.forms[0].unidadesA[1].checked){                  
	        for( j = 0 ; j < document.forms[0].minutesToAssign.length ; j++ ){        	
	           //if(IsNumeric(document.forms[0].minutesToAssign[j].value)){ RRG PAN 20-03-2008 62582
			   if(!isNaN(document.forms[0].minutesToAssign[j].value)){ // RRG  PAN 20-03-2008 62582
	               suma = parseInt(suma) + parseInt(document.forms[0].minutesToAssign[j].value);
	               if (document.forms[0].unidadesA[0].checked){
	                   if(suma > parseInt(document.forms[0].unidadesLibres.value)){
	                       alert("la suma de los valores no pueden superar "+document.forms[0].unidadesLibres.value);	                       
	                       suma = parseInt(suma) - parseInt(document.forms[0].minutesToAssign[j].value);
	                       document.forms[0].minutesToAssign[j].value="0";
	                       document.forms[0].conversion[j].value="0";
	                   }             
	               }
	               else if(document.forms[0].unidadesA[1].checked){
	                   if (suma > 100){
	                       alert("la suma de los valores no pueden superar el 100%");	                       
	                       suma = parseInt(suma) - parseInt(document.forms[0].minutesToAssign[j].value);
	                       document.forms[0].minutesToAssign[j].value="0";
	                       document.forms[0].conversion[j].value="0";
	                   }               
	               }                                            
	           }
	           else
	           {
	               if(document.forms[0].minutesToAssign[j].value != ""){   
   	   	           	   alert(document.forms[0].minutesToAssign[j].value)		
	                   document.forms[0].minutesToAssign[j].value = "0";
	                   document.forms[0].conversion[j].value="0";
	                   alert("debe ingresar solo numeros");
	               }
	           }           
	        }                           
	        document.forms[0].minutosTotal.value = suma;
	     }
	     else{
	        //alert("debe selecionar Unidades o Porcentaje");	     	 
	        
	        for( j=0 ; j< document.forms[0].minutesToAssign.length ; j++ ){
                document.forms[0].minutesToAssign[j].value = "0";
                document.forms[0].conversion[j].value="0";
            }
            document.forms[0].minutosTotal.value = "0";
	     }
	   } catch( myError ) {
	   		alert( myError.name + ': ' + myError.message );
	   }

    }


	function ValidaSuma(index)
	{
		var conversion = 0;
		
		if(isArray(document.forms[0].minutesToAssign))
		{
			obj = document.forms[0].minutesToAssign[index];
			var val = obj.value;
		
			if(val != "0")
			{
				while(val.length > 0 && val.substring(0,1) == "0" && val != "0")
					val = val.substring(1,val.length)
			}
			
			if(IsNumeric(val))
			{
	             if (document.forms[0].unidadesA[0].checked){
	                 conversion = Math.abs(parseInt(val * 100 / document.forms[0].unidadesLibres.value));
	                 document.forms[0].conversion[index].value = conversion;
	             }
	             else if (document.forms[0].unidadesA[1].checked){
	             	conversion = Math.abs(parseInt((document.forms[0].unidadesLibres.value * val) / 100));
	             	document.forms[0].conversion[index].value = conversion;
	             }
	        }
			obj.value = val;
			Suma();
		}
		else
		{
			Bolsa1();
		}
	}
	
	

      
      function validaguardar(distribucion){  
      	  if(distribucion == 'dc'){
      	      if(!(distribucionCompleta == 'true')){
	      	  	muestraError(msgErrorFaltaDist);
	      	  	return;
	      	  }
	      	  //document.getElementById("opcion").value = "guardarDistribucionBolsa";//"desplegarDistribucion";
	      	  document.forms[0].accion.value='ingresarComentarios';//'guardarDistribucionBolsa';
	      	  document.forms[0].submit();  
      	  }else if(document.forms[0].unidadesA[0].checked){
              if (parseInt(document.forms[0].minutosTotal.value) == parseInt(document.forms[0].unidadesLibres.value)){
                  //document.getElementById("opcion").value = "aceptarDistribucion";
                  document.forms[0].accion.value='aceptarDistribucion';
                  document.forms[0].submit();                                        
              }
              else{
                  //alert("La suma Distribucion debe ser igual a la cantidad de minutos disponibles");
                  alert("Debe distribuir la totalidad de la bolsa");
              }  
          }
          else if(document.forms[0].unidadesA[1].checked){
              if (parseInt(document.forms[0].minutosTotal.value) == 100){
              	  if(isArray(document.forms[0].minutesToAssign))
                  	cambiaPrcMin();
                  //document.getElementById("opcion").value = "aceptarDistribucion";	
                  document.forms[0].accion.value='aceptarDistribucion';
                  document.forms[0].submit();
              }
              else{
                  alert("El porcentaje Distribucion debe ser igual al 100%");                              
              }
          }
          else{
              alert("debe selecionar Unidades o Porcentaje");
          }
      }
      
      function cambiaPrcMin(){
      
         var j = 0;
         var suma = 0;
         
      	 for( j=1 ; j< document.forms[0].minutesToAssign.length ; j++ ){
      	 	document.forms[0].minutesToAssign[j-1].value = Math.abs(parseInt(parseInt(document.forms[0].unidadesLibres.value) * parseInt(document.forms[0].minutesToAssign[j-1].value)/ 100));
      	 	suma = suma + parseInt(document.forms[0].minutesToAssign[j-1].value)
      	 }
      	 document.forms[0].minutesToAssign[document.forms[0].minutesToAssign.length-1].value = parseInt(document.forms[0].unidadesLibres.value) - suma;
      	 document.forms[0].unidadesA[0].checked = true;
      	 Suma();
      }
      
      // INICIO 62582 RRG PAN 20-03-2008
      // si cliente tiene mas de 100 abonados el porcentaje de distribucion es menor a cero (0)
      // por lo que usar ParseInt NO SIRVE
      // se procede a cambiar a parseFloat y a redondear con 2 decimales
      function redondeo2decimales(numero)
	  {
			var original=parseFloat(numero);
			var result=Math.round(original*100)/100 ;
			return result;
	  }
	  // FIN 62582 RRG PAN 20-03-2008

      function disEquitativa(){
         var promedio = 0;
         var promedio2 = 0;
         var conversion = 0;	//Se utiliza para calcular la transformación de las unidades libres a porcentaje o unidades segun corresponda
         var conversion2 = 0;	//excedente de conversion
         var j=0;
         var total=0;
                  
         if (document.forms[0].unidadesA[0].checked || document.forms[0].unidadesA[1].checked){
         	 if(document.forms[0].minutesToAssign == null)
         	 {
         	 	alert('No existe bolsa para asignar');
         	 }
         	 else if(!isArray(document.forms[0].minutesToAssign))	//esto sucede cuando solo existe una linea
         	 {
         	 	Bolsa1();
         	 }
         	 else
         	 {
	         	 total = document.forms[0].minutesToAssign.length;
	         	 
	             if (document.forms[0].unidadesA[0].checked){
	             	 promedio = Math.abs(parseInt(parseInt(document.forms[0].unidadesLibres.value) / total));
	             	 promedio2 = parseInt(document.forms[0].unidadesLibres.value) - (promedio * (total-1));
	             	 //conversion = Math.abs(parseInt(100 / total));  // RRG 62582 RRG PAN 20-03-2008
	             	 conversion = Math.abs(parseFloat(100 / total));  // RRG 62582 RRG PAN 20-03-2008
	             	 //conversion2 = 100 - (conversion * (total-1));
	             	 conversion2 = (promedio2 * 100) / document.forms[0].unidadesLibres.value;
	             	 conversion2 = redondeo2decimales(conversion2) // RRG 62582 RRG PAN 20-03-2008
	             	 conversion = redondeo2decimales(conversion); // RRG 62582 RRG PAN 20-03-2008
	             }
	             else if (document.forms[0].unidadesA[1].checked){
	                 //promedio = Math.abs(parseInt(100 / total)) RRG 62582 RRG PAN 20-03-2008
	                 promedio = Math.abs(parseFloat(100 / total)) // RRG 62582 RRG PAN 20-03-2008
	                 
	                 //promedio2 = redondeo2decimales(100 - (promedio * (total-1)));
	                 
	                 promedio = redondeo2decimales(promedio) // RRG 62582 RRG PAN 20-03-2008
	                 
	                 conversion = Math.abs(parseInt(parseInt(document.forms[0].unidadesLibres.value) / total)); // RRG 62582
	                 //conversion = redondeo2decimales(Math.abs(parseFloat(parseFloat(document.forms[0].unidadesLibres.value) / total))); // RRG 62582 RRG PAN 20-03-2008
	                 conversion2 = parseInt(document.forms[0].unidadesLibres.value) - (conversion * (total-1));
	                 
	                 promedio2 = parseFloat((conversion2 * 100) / document.forms[0].unidadesLibres.value);
	                 
	             }
	             
	             //alert("promedio:" + promedio);
				 //alert("conversion:" + conversion);
	             	 
	             for( j=1 ; j< total ; j++ ){
	             	document.forms[0].minutesToAssign[j-1].value = promedio;
	                document.forms[0].conversion[j-1].value = conversion;
	             }         
	
				//alert("promedio2:" + promedio2);
				//alert("conversion2:" + conversion2);
	
	             document.forms[0].minutesToAssign[j-1].value = promedio2;
	             document.forms[0].conversion[j-1].value = conversion2;
	             
	             Suma();
             }
         }
	     else{
	        alert("debe selecionar Unidades o Porcentaje");	     	 
	     }
         
      }
          
      function Bolsa1()
      {
      	if (document.forms[0].unidadesA[0].checked){
	      	document.forms[0].minutesToAssign.value = document.forms[0].unidadesLibres.value;
	      	document.forms[0].conversion.value = 100;
	     }else{
	      	document.forms[0].minutesToAssign.value = 100;
	      	document.forms[0].conversion.value = document.forms[0].unidadesLibres.value;	     	
	     }
	     
	     document.forms[0].minutosTotal.value = document.forms[0].minutesToAssign.value;
      }  
      
      
	  function isArray(a) {
	     return cantidadElementos > 1;
	  }
	  
	  function isObject(a) 
	  {
	     return (typeof a == 'object' && !!a) || isFunction(a);
	  }
	  
	  function isFunction(a) 
	  {
	      return typeof a == 'function';
	  }
            
      function IsNumeric(sText){
         var ValidChars = "0123456789";
         var IsNumber=true;
         var Char;
         
         if (sText == null){
         	IsNumber = false;
         }
         
         for (i = 0; i < sText.length && IsNumber == true; i++){ 
            Char = sText.charAt(i); 
            if (ValidChars.indexOf(Char) == -1){
               IsNumber = false;
            }
         }
                  
         if(sText==""){
            IsNumber = false;
         }                  
         return IsNumber;
      }
