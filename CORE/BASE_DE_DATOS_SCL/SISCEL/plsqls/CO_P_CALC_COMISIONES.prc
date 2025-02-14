CREATE OR REPLACE PROCEDURE CO_P_CALC_COMISIONES
(	vp_secuencia_co		IN	VARCHAR2,
	vp_deuda		IN	VARCHAR2,
	vp_cliente		IN	NUMBER,
	vp_oripago      	IN  	NUMBER,      /*XC-200407290177 02-08-2004 PRM */
	vp_numsecuenci   	IN  	NUMBER,      /*XC-200407290177 02-08-2004 PRM */
	vp_tipdocum      	IN  	NUMBER,      /*XC-200407290177 02-08-2004 PRM */
	vp_numcompago    	IN  	NUMBER,      /*XC-200407290177 02-08-2004 PRM */
	vp_retorno		OUT	NUMBER
)
IS
/*    Funcion        :Invocar PL de Comisiones segun Entidad de Cobranza             			*/
/*    Autor          :Rodrigo Maturana D.                                            			*/
/*    Fecha          :13/05/2002                                                     			*/
/*    Modificaciones :18/06/2002 17/03/2003(rmaturana) Si NO_DATA_FOUND inserta en			*/
/*	  				 CO_TRANSACINTER con valores en 0 (Cero)  		  	*/
/*					 :06/09/2002 (RMaturana) Errores se insertan en CO_TRANSACINTER	*/
/*	  Ult.Paso Pruduc:06/09/2002 (MPR --> Puerto Rico)	  	 	  			*/
/*	  		   		 :06/09/2002 (TMC --> Chile) 					*/
/*	                 :24/06/2002 (TMC --> BREGO)		    	 	  			*/
/*	  		   		 :12/06/2002 (DEIMOS)						*/
/*    Modificacion   : 02/08/2004 XC-200407290177  PRM  se agregan parametros        			*/


	V_PROC 		VARCHAR2(50);
	V_STR		VARCHAR2(255);
	v_secuencia_co	VARCHAR2(20);
	v_deuda		VARCHAR2(20);
	v_cliente	NUMBER;
	v_retorno	NUMBER;
	v_Mensaje	VARCHAR(255);
	--v_Txt_Param	VARCHAR(50);
	v_Txt_Param     VARCHAR(500); /*XC-200407290177 02-08-2004 PRM */
	v_oripago       NUMBER;       /*XC-200407290177 02-08-2004 PRM */
	v_numsecuenci   NUMBER;       /*XC-200407290177 02-08-2004 PRM */
	v_tipdocum      NUMBER;       /*XC-200407290177 02-08-2004 PRM */
	v_numcompago    NUMBER;       /*XC-200407290177 02-08-2004 PRM */
BEGIN
	vp_retorno := 1;

	--v_Txt_Param:= '('||vp_secuencia_co||'-'||vp_deuda||'-'||vp_cliente||')';
	v_Txt_Param:= '('||' Secuencia: '||vp_secuencia_co||' - '||'Deuda: '||vp_deuda; /*XC-200407290177 02-08-2004 PRM */

	SELECT UNIQUE PL_CALCULO
	INTO V_PROC
	--FROM 	CO_MOROSOS M
	FROM 	GE_CLIENTES M     /*XC-200407290177 02-08-2004 PRM */
		,CO_COBEXTERNA C
		,CO_GTOS_COBRANZA E
		,CO_PL_COMISION P
	WHERE M.COD_CLIENTE = vp_cliente
		AND M.NUM_IDENT = C.NUM_IDENT
		AND M.COD_TIPIDENT = C.COD_TIPIDENT
		AND (M.COD_CLIENTE = C.COD_CLIENTE OR C.COD_CLIENTE = 0)
		AND C.COD_ENTIDAD = E.COD_ENTIDAD
		AND E.TIP_COMISION = P.TIP_COMISION
		AND P.FORMA_CALCULO = 'P'
		AND E.NUM_SECUENCI>0;		/*XM-200503040251 RyC CGLagos 04-03-2005. pk_co_gtos_cobranza*/

	--V_STR := 'BEGIN ' || V_PROC || '(:v_secuencia_co,:v_deuda,:v_cliente,:v_retorno); END;';
	/*XC-200407290177 02-08-2004 PRM */
	V_STR := 'BEGIN ' || V_PROC || '(:v_secuencia_co,:v_deuda,:v_cliente,:v_oripago,:v_numsecuenci,:v_tipdocum, :v_numcompago, :v_retorno); END;';

	--EXECUTE IMMEDIATE V_STR USING IN vp_secuencia_co,IN vp_deuda, IN vp_cliente,OUT VP_RETORNO ;
	/*XC-200407290177 02-08-2004 PRM */
	EXECUTE IMMEDIATE V_STR USING IN vp_secuencia_co, IN vp_deuda, IN vp_cliente, IN vp_oripago, IN vp_numsecuenci, IN vp_tipdocum, IN vp_numcompago, OUT VP_RETORNO ;

	vp_retorno := 0;
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			vp_retorno := 0;
			v_Mensaje := 'No se encontro PL_CALCULO para el Cliente '||v_Txt_Param;

			--INSERT INTO CO_TRANSACINTER ( NUM_TRANSACCION, POR_TRAMO, COD_RETORNO, DES_CADENA, MTO_PAGO,MTO_INTERES )
			--VALUES ( TO_NUMBER( vp_secuencia_co ), 0, vp_retorno, v_Mensaje, 0, 0 );
			/*XC-200407290177 02-08-2004 PRM */
			INSERT INTO CO_TRANSACINTER ( NUM_TRANSACCION, POR_TRAMO, COD_RETORNO, DES_CADENA, MTO_PAGO,MTO_INTERES,COD_CLIENTE, COD_ORIPAGO, NUM_SECUENCI, COD_TIPDOCUM, NUM_COMPAGO )
			VALUES ( TO_NUMBER( vp_secuencia_co ), 0, vp_retorno, v_Mensaje, 0, 0, vp_cliente, vp_oripago, vp_numsecuenci, vp_tipdocum, vp_numcompago);
		WHEN OTHERS THEN
			IF SQLCODE = -6550 THEN
				vp_retorno := 11;
				v_Mensaje := 'Procedimiento Almacenado NO EXISTE o Tiene Problemas al ser Ejecutado - ';
				v_Mensaje := v_Mensaje ||v_Txt_Param||V_STR||' - COD.ORACLE: '||SQLCODE||' - DESC.ORACLE: '||SQLERRM;

				--INSERT INTO CO_TRANSACINTER ( NUM_TRANSACCION, POR_TRAMO, COD_RETORNO, DES_CADENA, MTO_PAGO,MTO_INTERES )
				--VALUES ( TO_NUMBER( vp_secuencia_co ), 0, vp_retorno, v_Mensaje, 0, 0 );
				/*XC-200407290177 02-08-2004 PRM */
				INSERT INTO CO_TRANSACINTER ( NUM_TRANSACCION, POR_TRAMO, COD_RETORNO, DES_CADENA, MTO_PAGO,MTO_INTERES,COD_ORIPAGO, COD_CLIENTE, NUM_SECUENCI, COD_TIPDOCUM, NUM_COMPAGO )
				VALUES ( TO_NUMBER( vp_secuencia_co ), 0, vp_retorno, v_Mensaje, 0, 0, vp_cliente, vp_oripago, vp_numsecuenci, vp_tipdocum, vp_numcompago);
			ELSE
				vp_retorno := 12;
				v_Mensaje := v_Txt_Param||V_STR||' - COD.ORACLE: '||SQLCODE||' - DESC.ORACLE: '||SQLERRM;

				--INSERT INTO CO_TRANSACINTER ( NUM_TRANSACCION, POR_TRAMO, COD_RETORNO, DES_CADENA, MTO_PAGO,MTO_INTERES )
				--VALUES ( TO_NUMBER( vp_secuencia_co ), 0, vp_retorno, v_Mensaje, 0, 0 );
				/*XC-200407290177 02-08-2004 PRM */
				INSERT INTO CO_TRANSACINTER ( NUM_TRANSACCION, POR_TRAMO, COD_RETORNO, DES_CADENA, MTO_PAGO,MTO_INTERES,COD_ORIPAGO, COD_CLIENTE, NUM_SECUENCI, COD_TIPDOCUM, NUM_COMPAGO )
				VALUES ( TO_NUMBER( vp_secuencia_co ), 0, vp_retorno, v_Mensaje, 0, 0, vp_cliente, vp_oripago, vp_numsecuenci, vp_tipdocum, vp_numcompago);
			END IF;
END;
/
SHOW ERRORS
