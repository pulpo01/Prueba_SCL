CREATE OR REPLACE PROCEDURE GA_ES_ABONADO_PREPAGO_PR (
        V_PARAM_ENTRADA IN  VARCHAR2,
		bRESULTADO      OUT NOCOPY  VARCHAR2,
		vMENSAJE        OUT NOCOPY  GA_TRANSACABO.DES_CADENA%TYPE)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GA_ES_ABONADO_PREPAGO_PR"
      Lenguaje="PL/SQL"
      Fecha="29-06-2005"
      Versión="1.0"
      Diseñador=""Fernando García E."
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Valida si el abonado es prepagp</Descripción>
      <Parametros>
         <Entrada>
            <param nom="V_PARAM_ENTRADA" Tipo="CARACTER"> String con parámetros de entrada </param>
         </Entrada>
         <Salida>
            <param nom="bRESULTADO"     Tipo="CARACTER"> Resultado de la validación</param>
            <param nom="vMENSAJE"    Tipo="CARACTER"> Mensaje de Retorno</param>
         </Salida>
      </Parametros>
   </Elemento>
</Documentación>
*/
IS
CV_version	        	CONSTANT  VARCHAR2(10):='1.0';
STRING GE_TABTYPE_VCH2ARRAY:= GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
nResultado  number(1);
CV_prepago			    CONSTANT ged_codigos.cod_valor%TYPE:='1';

BEGIN
   bRESULTADO := NULL;
   vMENSAJE := NULL;
   GE_PAC_ArregloPR.GE_PR_RetornaArreglo(V_PARAM_ENTRADA, STRING);

   SELECT 1
   INTO nResultado
   FROM GA_ABOAMIST prepago, TA_PLANTARIF planes, GED_CODIGOS codigos
   WHERE prepago.num_celular = TO_NUMBER(STRING(1))
   AND prepago.cod_situacion != 'BAA'
   AND prepago.cod_plantarif = planes.cod_plantarif
   AND codigos.cod_modulo = 'GE'
   AND codigos.nom_tabla='TA_PLANTARIF'
   AND codigos.nom_columna='COD_TIPLAN'
   AND codigos.cod_valor=CV_prepago
   AND planes.cod_producto=1
   AND planes.cod_tiplan=codigos.cod_valor;

   IF nResultado = 1 THEN
      bRESULTADO := 'TRUE';
	  vMENSAJE := 'El abonado es prepago';
   END IF;
EXCEPTION
   WHEN NO_DATA_FOUND THEN
        bRESULTADO := 'FALSE';
	    vMENSAJE := 'El abonado no es prepago';
   WHEN OTHERS THEN
        bRESULTADO := 'FALSE';
	    vMENSAJE := SUBSTR('No fue posible determinar si el abonado es prepago |' || SQLERRM,1,250);
END GA_ES_ABONADO_PREPAGO_PR;
/
SHOW ERRORS
