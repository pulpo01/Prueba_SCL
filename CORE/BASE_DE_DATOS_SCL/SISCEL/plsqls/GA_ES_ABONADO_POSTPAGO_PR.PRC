CREATE OR REPLACE PROCEDURE GA_ES_ABONADO_POSTPAGO_PR (
        V_PARAM_ENTRADA IN  VARCHAR2,
		bRESULTADO      OUT NOCOPY  VARCHAR2,
		vMENSAJE        OUT NOCOPY  GA_TRANSACABO.DES_CADENA%TYPE)
/*
<Documentaci�n
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GA_ES_ABONADO_POSTPAGO_PR"
      Lenguaje="PL/SQL"
      Fecha="02-05-2005"
      Versi�n="1.0"
      Dise�ador=""Fernando Garc�a E."
      Programador="Fernando Garc�a E."
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripci�n>Valida si el abonado es postpago</Descripci�n>
      <Parametros>
         <Entrada>
            <param nom="V_PARAM_ENTRADA" Tipo="CARACTER"> String con par�metros de entrada </param>
         </Entrada>
         <Salida>
            <param nom="bRESULTADO"     Tipo="CARACTER"> Resultado de la validaci�n</param>
            <param nom="vMENSAJE"    Tipo="CARACTER"> Mensaje de Retorno</param>
         </Salida>
      </Parametros>
   </Elemento>
</Documentaci�n>
*/
IS
CV_version	        	CONSTANT  VARCHAR2(10):='1.0';
STRING GE_TABTYPE_VCH2ARRAY:= GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
nResultado  number(1);
BEGIN
   bRESULTADO := NULL;
   vMENSAJE := NULL;
   GE_PAC_ArregloPR.GE_PR_RetornaArreglo(V_PARAM_ENTRADA, STRING);
   
   begin
       SELECT 1
       INTO nResultado
       FROM GA_ABOCEL postpago
       WHERE postpago.num_celular = TO_NUMBER(STRING(5))
       AND postpago.cod_situacion != 'BAA';
   exception
   when others then
       SELECT 1
       INTO nResultado
       FROM GA_ABOCEL postpago
       WHERE postpago.num_abonado = TO_NUMBER(STRING(5))
       AND postpago.cod_situacion != 'BAA';   
   end;
   
   IF nResultado = 1 THEN
      bRESULTADO := 'TRUE';
	  vMENSAJE := 'El abonado es postpago';
   END IF;
EXCEPTION
   WHEN NO_DATA_FOUND THEN
        bRESULTADO := 'FALSE';
	    vMENSAJE := 'El abonado no es postpago '|| TO_NUMBER(STRING(5));
   WHEN OTHERS THEN
        bRESULTADO := 'FALSE';
	    vMENSAJE := SUBSTR('No fue posible determinar si el abonado es postpago |' || SQLERRM,1,250);
END GA_ES_ABONADO_POSTPAGO_PR;
/ 
SHOW ERRORS
