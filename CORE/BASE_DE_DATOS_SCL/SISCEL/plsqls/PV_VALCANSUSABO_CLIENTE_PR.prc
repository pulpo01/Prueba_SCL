CREATE OR REPLACE PROCEDURE PV_VALCANSUSABO_CLIENTE_PR(
    	  EV_v_param_entrada IN  VARCHAR2,
          EV_bRESULTADO      OUT NOCOPY VARCHAR2,
          EV_vMENSAJE        OUT NOCOPY GA_TRANSACABO.DES_CADENA%TYPE
) IS
/*
<Documentacion TipoDoc = "Procedure">
   <Elemento
      Nombre = "PV_VALCANSUSABO_CLIENTE_PR"
      Fecha modificacion=" "
      Fecha creacion="10-09-2007"
      Programador="Orlando Cabezas"
      Diseñador="Orlando Cabezas"
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripcion>Procedimiento que verifica si existe OoSs pendiente</Descripcion>
      <Parametros>
         <Entrada>
             <param nom="EV_v_param_entrada" Tipo="CARACTER">Registro de la tabla FA_CARGOS_REC_TO</param>
         </Entrada>
         <Salida>
            <param nom="EV_bRESULTADO" Tipo="CARACTER">Retorno del procedimiento TRUE o FALSE</param>
            <param nom="EV_vMENSAJE" Tipo="CARACTER">Cadena de Parametros Devueltos por la Transaccion; Separador = "/"</param>
         </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
     string GE_TABTYPE_VCH2ARRAY:= GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');

---- parametros reales de entrada --------------

     LN_nCLIENTE    GA_ABOCEL.COD_CLIENTE%TYPE;

------------------------------------------------

     LN_vCantidad         NUMBER(9);
	 LN_vCantidad2        NUMBER(9);


BEGIN

     GE_PAC_ArregloPR.GE_PR_RetornaArreglo(EV_v_param_entrada, string);
     LN_nCLIENTE       := -1;
     LN_nCLIENTE       := TO_NUMBER(string(6));

     EV_bRESULTADO  := 'TRUE';
     EV_vMENSAJE    := 'OK';
     LN_vCantidad   := 0;


         SELECT COUNT(1) INTO LN_vCantidad
         FROM GA_ABOCEL
         WHERE cod_cliente = LN_nCLIENTE
		 AND cod_situacion NOT IN ('BAA','BAP','TAP');

		 SELECT COUNT(1) INTO LN_vCantidad2
         FROM GA_ABOCEL
         WHERE cod_cliente = LN_nCLIENTE
		 AND cod_situacion IN ('SAA','STP');

	     If (LN_vCantidad = LN_vCantidad2) Then
	        EV_bRESULTADO := 'FALSE';
                EV_vMENSAJE   := 'LA TOTALIDAD DE LOS ABONADOS SE ENCUENTRA SUSPENDIDOS';
	     End If;

END;
/
SHOW ERRORS
