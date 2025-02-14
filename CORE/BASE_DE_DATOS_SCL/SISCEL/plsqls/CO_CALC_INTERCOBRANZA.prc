CREATE OR REPLACE PROCEDURE CO_CALC_INTERCOBRANZA
(	 vp_secuencia_co 	IN VARCHAR2
	,vp_deuda 		IN VARCHAR2
	,vp_cliente 		IN NUMBER
	,vp_oripago      	IN NUMBER   /*XC-200407290177 02-08-2004 PRM */
	,vp_numsecuenci  	IN NUMBER   /*XC-200407290177 02-08-2004 PRM */
	,vp_tipdocum     	IN NUMBER   /*XC-200407290177 02-08-2004 PRM */
	,vp_numcompago   	IN NUMBER   /*XC-200407290177 02-08-2004 PRM */
	,vp_retorno 		OUT NUMBER
)IS
/*    Funcion        :Calcular Comisiones Emp.Cobranza TMC			 	             */
/*    Autor          :Jorge Lizama		                                             */
/*    Fecha          :?																 */
/*    Modificaciones :13/05/2002 (rasalaza) calculo segun Entidad de Cobranza		 */
/*	  				 27/05/2002 (rmaturana) Decimales por Operadora no ROUND		 */
/*					 			vp_monto y vp_monto_tramo de 14 a 14,4				 */
/*					 29/10/2002	(maranda)vp_nocobext para controlar error en caso de */
/*					 			no tener entidada de cobranza externa el cliente     */
/*                   31/10/2002 (rmaturana) se saca vp_nocobext y se llama a 		 */
/*					 			ERROR_PROCESO al fallar validacion de cod_entidad	 */
/*	  Ult.Paso Pruduc:24/06/2002 (TMC --> BREGO)		  	 	  					 */
/*	  		   		 :31/10/2002 (DEIMOS)											 */
/*	  		   		 :31/10/2002 (TMC --> Produccion)								 */

/*     Modificacion  :02/08/2004 XC-200407290177 PRM  Se agrega validacion de        */
/*                               inmunidad.                                          */

usuario				VARCHAR2(30);
fecha				VARCHAR(10);
vp_error			NUMBER(2) 	  := 0;
vp_porcentaje		NUMBER(8,5)   := 0;
vp_cod_moneda		VARCHAR2(3);
vp_monto_cobr		NUMBER(24,10) := 0;
vp_monto			NUMBER(14,4)	  := 0;
vp_monto_tramo		NUMBER(14,4)    := 0;
vp_deuda_conversion	NUMBER(24,10) := 0;
vp_saldo			NUMBER(24,10) := 0;
--vp_ruteo                      NUMBER(2)     := 0;   /*XC-200407290177 02-08-2004 PRM */
vp_cantidad			NUMBER(1)     := 0;
vp_gls_error	      VARCHAR2(255);
vp_cod_entidad        VARCHAR2(5);
--vp_nocobext         NUMBER(1)     :=0;
/** rri **/
vp_cambio	      GE_CONVERSION.CAMBIO%TYPE;
vp_cliente_inmune     CO_INMUNIDAD.COD_CLIENTE%TYPE;  /*XC-200407290177 02-08-2004 PRM */

iDecimal            NUMBER(2); --Decimales por Operadora.

CURSOR	c_gtos_cobranza(entidad VARCHAR2) IS
SELECT	TRAMO_DESDE,
		TRAMO_HASTA,
		PORC_APLICADO
FROM	CO_GTOS_COBRANZA
WHERE	SYSDATE BETWEEN FEC_VIGENCIA_DD_DH AND FEC_VIGENCIA_HH_DH
AND COD_ENTIDAD = entidad
ORDER BY TRAMO_DESDE;

ERROR_PROCESO EXCEPTION;
BEGIN
	/*XC-200407290177 02-08-2004 PRM  Verifica inmunidad*/
	vp_retorno := 0;
	BEGIN
		SELECT UNIQUE COD_CLIENTE
		INTO vp_cliente_inmune
		FROM CO_INMUNIDAD
		WHERE COD_CLIENTE = vp_cliente
		AND SYSDATE BETWEEN FEC_DESDE AND FEC_HASTA;
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			vp_cliente_inmune := 0;
	END;

	if vp_cliente_inmune = 0 then  /*Cliente no es inmune*/ /*XC-200407290177 02-08-2004 PRM */
		vp_gls_error := '';
		usuario := '';

		--vp_ruteo := 1;  /*XC-200407290177 02-08-2004 PRM */
		vp_retorno := 1;
		vp_gls_error := 'Select usuario.';

		SELECT	USER,RTRIM( TO_CHAR( SYSDATE, 'dd-mm-yyyy' ) )
		INTO    usuario,fecha
		FROM   	DUAL;

		vp_gls_error := 'SELECT GE_PAC_DECIMALES.PARAM_GENERAL';

		SELECT GE_PAC_GENERAL.PARAM_GENERAL('num_decimal')
    		INTO   iDecimal
    		FROM   DUAL;

		--vp_ruteo := 2;  /*XC-200407290177 02-08-2004 PRM */
		vp_retorno := 2;
		vp_gls_error := 'Select rescata entidad.';

    		BEGIN

			SELECT B.COD_ENTIDAD
			INTO vp_cod_entidad
			--FROM CO_MOROSOS A, CO_COBEXTERNA B,   CO_ENTCOB  C
			FROM GE_CLIENTES A, CO_COBEXTERNA B,    CO_ENTCOB  C  /*XC-200407290177 02-08-2004 PRM */
			WHERE A.COD_CLIENTE = vp_cliente
			AND A.NUM_IDENT = B.NUM_IDENT
			AND A.COD_TIPIDENT = B.COD_TIPIDENT
			AND B.COD_MOVIMIENTO NOT IN( 'B', 'R')
			AND B.COD_ENVIO NOT IN( 'B', 'R')
			AND A.COD_TIPIDENT = B.COD_TIPIDENT
			AND B.COD_ENTIDAD = C.COD_ENTIDAD
			AND C.TIP_ENTIDAD = 'E';

	    	EXCEPTION
	    		WHEN NO_DATA_FOUND THEN
				 --inconsistencia entre co_morosos y co_cobexterna
			 	vp_retorno := 0;
			 	--vp_gls_error := 'Ok.';
			 	vp_gls_error := 'NO SE ENCONTRO ENTIDAD PARA CLIENTE '|| vp_cliente || ' - DEUDA ' ||vp_deuda; /*XC-200407290177 02-08-2004 PRM */
			 	vp_porcentaje := 0;
			 	vp_monto := 0;
			 	vp_monto_tramo := 0;
			 	--sale de la PL registrnado Por_tramo = 0 y Mto_interes = 0
			 	RAISE ERROR_PROCESO;
		END;

   		--vp_ruteo := 3;  /*XC-200407290177 02-08-2004 PRM */
		vp_retorno := 3;
		vp_gls_error := 'Select co_gtos_cobranza.';

		SELECT	COD_MONEDA
		INTO	vp_cod_moneda
		FROM	CO_GTOS_COBRANZA
		WHERE	SYSDATE BETWEEN FEC_VIGENCIA_DD_DH AND FEC_VIGENCIA_HH_DH
		AND     COD_ENTIDAD = vp_cod_entidad
		AND		ROWNUM <= 1;

		--vp_ruteo := 4;  /*XC-200407290177 02-08-2004 PRM */
		vp_retorno := 4;
		vp_gls_error := 'Select ge_conversion.';

		SELECT	A.CAMBIO
		INTO	vp_cambio
		FROM	GE_CONVERSION A
		WHERE	A.COD_MONEDA = vp_cod_moneda
		AND		A.FEC_DESDE <= SYSDATE
		AND		A.FEC_HASTA >= SYSDATE;

    		vp_deuda_conversion := TO_NUMBER( vp_deuda ) / vp_cambio;
		vp_monto_cobr := 0;
		vp_monto_tramo := 0;
		vp_saldo := vp_deuda_conversion;
		vp_error := 5;
		vp_retorno := 5;
		vp_gls_error := 'Calculo interes.';

		FOR rReg IN c_gtos_cobranza(vp_cod_entidad) LOOP
			IF vp_deuda_conversion > rReg.tramo_hasta THEN
				vp_monto_cobr := ( ( rReg.tramo_hasta - rReg.tramo_desde ) * ( rReg.porc_aplicado / 100 ) );
				vp_saldo := vp_saldo - ( rReg.tramo_hasta - rReg.tramo_desde );
			ELSE
				IF vp_deuda_conversion >= rReg.tramo_desde THEN
					vp_monto_cobr := ( vp_saldo * ( rReg.porc_aplicado / 100 ) );
				ELSE
					vp_monto_cobr := 0;
				END IF;

				vp_monto := vp_monto_cobr * vp_cambio;

				IF rREG.tramo_desde = 0 or rREG.tramo_desde = 10.0001 THEN
					vp_monto_tramo := ( vp_saldo ) * vp_cambio ;
				ELSE
					vp_monto_tramo := ( vp_saldo - 0.0001 ) * vp_cambio ;
				END IF;

				vp_porcentaje :=  rReg.porc_aplicado;

				--INSERT INTO CO_TRANSACINTER ( NUM_TRANSACCION, POR_TRAMO, COD_RETORNO, DES_CADENA, MTO_PAGO, MTO_INTERES )
				--VALUES ( TO_NUMBER( vp_secuencia_co ), vp_porcentaje, vp_ruteo, vp_gls_error, GE_PAC_GENERAL.REDONDEA(vp_monto_tramo, iDecimal, 0), GE_PAC_GENERAL.REDONDEA(vp_monto, iDecimal, 0) );
				/*XC-200407290177 02-08-2004 PRM */
				INSERT INTO CO_TRANSACINTER ( NUM_TRANSACCION, POR_TRAMO, COD_RETORNO, DES_CADENA, MTO_PAGO, MTO_INTERES, COD_ORIPAGO, COD_CLIENTE, NUM_SECUENCI, COD_TIPDOCUM, NUM_COMPAGO )
				VALUES ( TO_NUMBER( vp_secuencia_co ), vp_porcentaje, vp_retorno, vp_gls_error, GE_PAC_GENERAL.REDONDEA(vp_monto_tramo, iDecimal, 0), GE_PAC_GENERAL.REDONDEA(vp_monto, iDecimal, 0), vp_oripago, vp_cliente, vp_numsecuenci, vp_tipdocum, vp_numcompago );
				EXIT;
			END IF;

			vp_monto := vp_monto_cobr * vp_cambio ;

			IF rReg.tramo_desde = 0 then
				vp_monto_tramo := ( rReg.tramo_hasta - rReg.tramo_desde ) * vp_cambio ;
			ELSE
				vp_monto_tramo := ( rReg.tramo_hasta - ( rReg.tramo_desde - 0.0001 ) ) * vp_cambio;
			END IF;

			vp_porcentaje :=  rReg.porc_aplicado;

			--INSERT INTO CO_TRANSACINTER ( NUM_TRANSACCION, POR_TRAMO, COD_RETORNO, DES_CADENA, MTO_PAGO,MTO_INTERES )
			--VALUES ( TO_NUMBER( vp_secuencia_co ), vp_porcentaje, vp_ruteo, vp_gls_error, GE_PAC_GENERAL.REDONDEA(vp_monto_tramo, iDecimal, 0), GE_PAC_GENERAL.REDONDEA(vp_monto, iDecimal, 0) );
			/*XC-200407290177 02-08-2004 PRM */
			INSERT INTO CO_TRANSACINTER ( NUM_TRANSACCION, POR_TRAMO, COD_RETORNO, DES_CADENA, MTO_PAGO, MTO_INTERES, COD_ORIPAGO, COD_CLIENTE, NUM_SECUENCI, COD_TIPDOCUM, NUM_COMPAGO )
			VALUES ( TO_NUMBER( vp_secuencia_co ), vp_porcentaje, vp_retorno, vp_gls_error, GE_PAC_GENERAL.REDONDEA(vp_monto_tramo, iDecimal, 0), GE_PAC_GENERAL.REDONDEA(vp_monto, iDecimal, 0), vp_oripago, vp_cliente, vp_numsecuenci, vp_tipdocum, vp_numcompago );
		END LOOP;

		--vp_ruteo := 0;  /*XC-200407290177 02-08-2004 PRM */
		vp_retorno := 0;
		/**vp_porcentaje := 0;**/
		vp_gls_error := 'Ok.';
		vp_porcentaje := 0;
		vp_monto := 0;
		vp_monto_tramo := 0;
		/**vp_monto := ROUND((vp_monto_cobr * vp_cambio) * 1.18);**/
		/**vp_monto := ROUND(vp_monto_cobr * vp_cambio) ;**/
	else	/*XC-200407290177 02-08-2004 PRM */
		/*Cliente es inmune*/
		vp_retorno := 0;
		vp_gls_error := 'El cliente es inmune, cod_cliente: '||vp_cliente;
		vp_porcentaje := 0;
		vp_monto := 0;
		vp_monto_tramo := 0;
	end if;

	RAISE ERROR_PROCESO;
	EXCEPTION
		WHEN ERROR_PROCESO THEN
			/**if vp_ruteo != 0 then
				exit;
			end if;**/
			--INSERT INTO CO_TRANSACINTER ( NUM_TRANSACCION, POR_TRAMO, COD_RETORNO, DES_CADENA, MTO_PAGO,MTO_INTERES )
		   	--VALUES ( TO_NUMBER( vp_secuencia_co ), vp_porcentaje, vp_ruteo, vp_gls_error, GE_PAC_GENERAL.REDONDEA(vp_monto_tramo, iDecimal, 0), GE_PAC_GENERAL.REDONDEA(vp_monto, iDecimal, 0) );
			/*XC-200407290177 02-08-2004 PRM */
			INSERT INTO CO_TRANSACINTER ( NUM_TRANSACCION, POR_TRAMO, COD_RETORNO, DES_CADENA, MTO_PAGO, MTO_INTERES, COD_ORIPAGO, COD_CLIENTE, NUM_SECUENCI, COD_TIPDOCUM, NUM_COMPAGO )
			VALUES ( TO_NUMBER( vp_secuencia_co ), vp_porcentaje, vp_retorno, vp_gls_error, GE_PAC_GENERAL.REDONDEA(vp_monto_tramo, iDecimal, 0), GE_PAC_GENERAL.REDONDEA(vp_monto, iDecimal, 0), vp_oripago, vp_cliente, vp_numsecuenci, vp_tipdocum, vp_numcompago );
		WHEN DUP_VAL_ON_INDEX THEN
			--ROLLBACK;
		   	--INSERT INTO CO_TRANSACINTER ( NUM_TRANSACCION, POR_TRAMO, COD_RETORNO, DES_CADENA, MTO_PAGO,MTO_INTERES )
		   	--VALUES ( TO_NUMBER( vp_secuencia_co ), vp_porcentaje, vp_ruteo, vp_gls_error, GE_PAC_GENERAL.REDONDEA(vp_monto_tramo, iDecimal, 0), GE_PAC_GENERAL.REDONDEA(vp_monto, iDecimal, 0) );
			/*XC-200407290177 02-08-2004 PRM */
			INSERT INTO CO_TRANSACINTER ( NUM_TRANSACCION, POR_TRAMO, COD_RETORNO, DES_CADENA, MTO_PAGO, MTO_INTERES, COD_ORIPAGO, COD_CLIENTE, NUM_SECUENCI, COD_TIPDOCUM, NUM_COMPAGO )
			VALUES ( TO_NUMBER( vp_secuencia_co ), vp_porcentaje, vp_retorno, vp_gls_error, GE_PAC_GENERAL.REDONDEA(vp_monto_tramo, iDecimal, 0), GE_PAC_GENERAL.REDONDEA(vp_monto, iDecimal, 0), vp_oripago, vp_cliente, vp_numsecuenci, vp_tipdocum, vp_numcompago );
		WHEN NO_DATA_FOUND THEN
			--ROLLBACK;
		   	--INSERT INTO CO_TRANSACINTER ( NUM_TRANSACCION, POR_TRAMO, COD_RETORNO, DES_CADENA, MTO_PAGO,MTO_INTERES )
		   	--VALUES ( TO_NUMBER( vp_secuencia_co ), vp_porcentaje, vp_ruteo, vp_gls_error, GE_PAC_GENERAL.REDONDEA(vp_monto_tramo, iDecimal, 0), GE_PAC_GENERAL.REDONDEA(vp_monto, iDecimal, 0) );
			/*XC-200407290177 02-08-2004 PRM */
			INSERT INTO CO_TRANSACINTER ( NUM_TRANSACCION, POR_TRAMO, COD_RETORNO, DES_CADENA, MTO_PAGO, MTO_INTERES, COD_ORIPAGO, COD_CLIENTE, NUM_SECUENCI, COD_TIPDOCUM, NUM_COMPAGO )
			VALUES ( TO_NUMBER( vp_secuencia_co ), vp_porcentaje, vp_retorno, vp_gls_error, GE_PAC_GENERAL.REDONDEA(vp_monto_tramo, iDecimal, 0), GE_PAC_GENERAL.REDONDEA(vp_monto, iDecimal, 0), vp_oripago, vp_cliente, vp_numsecuenci, vp_tipdocum, vp_numcompago );
		WHEN OTHERS THEN
			--ROLLBACK;
		   	--INSERT INTO CO_TRANSACINTER ( NUM_TRANSACCION, POR_TRAMO, COD_RETORNO, DES_CADENA, MTO_PAGO,MTO_INTERES )
		   	--VALUES ( TO_NUMBER( vp_secuencia_co ), vp_porcentaje, vp_ruteo, vp_gls_error, GE_PAC_GENERAL.REDONDEA(vp_monto_tramo, iDecimal, 0), GE_PAC_GENERAL.REDONDEA(vp_monto, iDecimal, 0) );
			/*XC-200407290177 02-08-2004 PRM */
			INSERT INTO CO_TRANSACINTER ( NUM_TRANSACCION, POR_TRAMO, COD_RETORNO, DES_CADENA, MTO_PAGO, MTO_INTERES, COD_ORIPAGO, COD_CLIENTE, NUM_SECUENCI, COD_TIPDOCUM, NUM_COMPAGO )
			VALUES ( TO_NUMBER( vp_secuencia_co ), vp_porcentaje, vp_retorno, vp_gls_error, GE_PAC_GENERAL.REDONDEA(vp_monto_tramo, iDecimal, 0), GE_PAC_GENERAL.REDONDEA(vp_monto, iDecimal, 0), vp_oripago, vp_cliente, vp_numsecuenci, vp_tipdocum, vp_numcompago );
END CO_CALC_INTERCOBRANZA;
/
SHOW ERRORS
