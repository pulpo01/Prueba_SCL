CREATE OR REPLACE PROCEDURE CO_P_COMIS_EXT_PTR
(	   v_secuencia IN  VARCHAR2
	   ,v_pago 	   IN  NUMBER
	   ,v_cliente  IN  NUMBER
	   ,v_retorno  OUT NUMBER
)
IS
/*    Funcion        :Calcular Comisiones Ent.Cobranza de Puerto Rico	             */
/*    Autor          :Ricardo Salazar	                                             */
/*    Fecha          :06/05/2002                                                     */
/*    Modificaciones :14/05/2002 (rmaturan)											 */
/*	  				 			 Comentarios explicativos y consideracion de dias 	 */
/*								 comisionables por la Entidad de Cobranza 	 	  	 */
/*					  27/05/2002 (rmaturan)	   	   	  		  	 					 */
/*					  			 Redondeo segun operadora							 */
/*					  03/07/2002 (rmaturan) 										 */
/*                               Cambio en Query de CO_GTOS_COBRANZA porque TO_NUMBER*/
/*								 no funciona en el WHERE.			 				 */
/*								 Redondear v_porcentaje								 */
/*                    11/07/2002 Cambio en calculo de comisiones, ahora es segun     */
/*					  			 monto Pagado el que es buscado en la Matriz		 */
/*					  12/07/2002 COD_MOVIMIENTO <> 'R' en CO_COBEXTERNA				 */
/*					  06/09/2002 Se Saca EXEPTION ERROR_PROCESO						 */
/*					  19/05/2003 (HQuezada) Se modifica consulta que obtiene Entidad */
/*					             para que no haga referencia a CO_MOROSOS            */
/*	  Ult.Paso Pruduc:15/07/2002 (HELENA --> Puerto Rico  	 	  					 */
/*	                 :24/06/2002 (TMC --> BREGO)		  	 	  					 */
/*	  		   		 :12/06/2002 (DEIMOS)											 */
/*					 :06/09/2002 (MPR -->Produccion Pto.Rico)						 */

v_saldo_total       NUMBER(14,4)  := 0;
v_PorcAplicado      NUMBER(7,4)   := 0;
--v_porcentaje        VARCHAR2(3)     := 0;
v_porcentaje        NUMBER(7,4)   := 0;
v_ruteo			    NUMBER(2)     := 0;
v_gls_error		    VARCHAR2(255);
v_monto_interes		NUMBER(14,4)  := 0;
v_cod_entidad       VARCHAR2(5);
v_pago_res			NUMBER(14,4)  := 0;
v_fec_comisionable	DATE;
v_err_comision		VARCHAR2(50)  := '';
v_dia_comisionables NUMBER;
iDecimal            NUMBER(2); --Decimales por Operadora.

--ERROR_PROCESO EXCEPTION;

BEGIN
    v_retorno := 0;

	v_ruteo := 1;
	v_retorno := 1;

	--************************************************
	--OBTENER DECIMALES POR OPERADORA.
	--************************************************

	v_gls_error := 'SELECT GE_PAC_DECIMALES.PARAM_GENERAL';

	SELECT GE_PAC_GENERAL.PARAM_GENERAL('num_decimal')
    INTO   iDecimal
    FROM   DUAL;

	v_gls_error := 'Select CO_ENTCOB';

	--************************************************
	--OBTENER ENTIDAD DE COBRANZA ASOCIADA AL CLIENTE.
	--************************************************

	SELECT B.COD_ENTIDAD
	INTO v_cod_entidad
	FROM  CO_COBEXTERNA B,	CO_ENTCOB  C
	WHERE B.COD_CLIENTE = v_cliente
	AND B.COD_ENTIDAD = C.COD_ENTIDAD
	AND B.COD_MOVIMIENTO NOT IN( 'B', 'R')
	AND B.COD_ENVIO NOT IN( 'B', 'R')
	AND C.TIP_ENTIDAD = 'E';

    --DBMS_OUTPUT.PUT_LINE('v_cod_entidad : '||v_cod_entidad);

    v_ruteo := 2;
	v_retorno := 2;
	v_gls_error := 'Select CO_COBEXTERNA';

	--**********************************
	--OBTENER MAXIMA FECHA COMISIONABLE.
	--**********************************

	--12/07/2002 (R.Maturana) Se agrego COD_MOVIMIENTO <> 'R'.

	SELECT DISTINCT (FEC_INGRESO + DIA_PRORROCOM + DIA_COMISIONABLES),DIA_COMISIONABLES
	INTO v_fec_comisionable, v_dia_comisionables
	FROM CO_COBEXTERNA EXT,GE_CLIENTES CLI,CO_ENTCOB ENT
	WHERE CLI.COD_CLIENTE = v_cliente
		  AND EXT.NUM_IDENT 	= CLI.NUM_IDENT
		  AND EXT.COD_TIPIDENT  = CLI.COD_TIPIDENT
	AND EXT.COD_MOVIMIENTO NOT IN( 'B', 'R')
	AND EXT.COD_ENVIO NOT IN( 'B', 'R')
		  AND EXT.COD_ENTIDAD   = ENT.COD_ENTIDAD
		  --SOPORTE 26-04-2003
		  AND CLI.COD_CLIENTE   = EXT.COD_CLIENTE;

	--********************************************
	--VER SI CORRESPONDE CALCULO.
	--v_dia_comisionables = 0 --> sin restriccion.
	--********************************************

	IF (v_fec_comisionable < SYSDATE) AND v_dia_comisionables <> 0 THEN
	   v_PorcAplicado:=0;
	   v_ruteo:=3;
	   v_err_comision :='(Sobrepaso dias comisionables)';
--	   v_pago_res:=0;
	   v_monto_interes:=0;
	ELSE
		--************************************************
		--SIGNIFICA QUE CORRESPONDE CALCULO DE COMISIONES.
		--************************************************

		--11/07/2002 (R.Maturana) Comision se calcula por tramo de Pago en Matriz.

		--******************************************
		--BUSCAR TRAMO PAGO EN MATRIZ DE COMISIONES.
		--******************************************

		v_ruteo := 4;
		v_retorno := 4;
		v_gls_error := 'Select CO_GTOS_COBRANZA';

		SELECT PORC_APLICADO
		INTO v_PorcAplicado
		FROM (SELECT PORC_APLICADO,TO_NUMBER(TRAMO_DESDE) TRAMO_DESDE,TO_NUMBER(TRAMO_HASTA) TRAMO_HASTA
			 FROM CO_GTOS_COBRANZA G, CO_PL_COMISION P
			 WHERE SYSDATE BETWEEN FEC_VIGENCIA_DD_DH AND FEC_VIGENCIA_HH_DH
			 AND TIP_DATO = 'NUM'
			 AND COD_ENTIDAD = v_cod_entidad
			 AND G.TIP_COMISION = P.TIP_COMISION
			 AND P.FORMA_CALCULO='P')
		WHERE v_pago BETWEEN TRAMO_DESDE AND TRAMO_HASTA;

		--******************
		--CALCULAR COMISION.
		--******************

		v_monto_interes := (v_pago * (v_PorcAplicado / 100));

	END IF;

    v_ruteo := 0;
	v_retorno := 0;

	v_gls_error := 'Calculo Comision PTR '||v_err_comision;

	--***************************************
	--INSERTAR RESULATADO EN CO_TRANSACINTER.
	--***************************************

	INSERT INTO CO_TRANSACINTER
	( NUM_TRANSACCION
	  ,POR_TRAMO
	  ,COD_RETORNO
	  ,DES_CADENA
	  ,MTO_PAGO
	  ,MTO_INTERES )
	VALUES
	( TO_NUMBER( v_secuencia )
	  ,v_PorcAplicado
	  ,v_ruteo
	  ,v_gls_error
	  ,v_pago
	  ,GE_PAC_GENERAL.REDONDEA(v_monto_interes, iDecimal, 0)
	);

--	v_pago_res:= v_pago;

--     v_PorcAplicado:=0;
	 v_ruteo:=0;
	 v_gls_error:='Ok.';
--	 v_pago_res:=0;
--	 v_monto_interes:=0;

--RAISE ERROR_PROCESO;

	EXCEPTION
		WHEN OTHERS THEN
		   v_gls_error := v_gls_error||' - '||SQLERRM;

		   INSERT INTO CO_TRANSACINTER ( NUM_TRANSACCION, POR_TRAMO, COD_RETORNO, DES_CADENA, MTO_PAGO,MTO_INTERES )
           VALUES ( TO_NUMBER( v_secuencia ), v_PorcAplicado, v_ruteo, v_gls_error, v_pago, GE_PAC_GENERAL.REDONDEA(v_monto_interes, iDecimal, 0));

END CO_P_COMIS_EXT_PTR;
/
SHOW ERRORS
