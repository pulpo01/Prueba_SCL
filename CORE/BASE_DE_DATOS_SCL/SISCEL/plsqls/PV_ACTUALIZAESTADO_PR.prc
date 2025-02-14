CREATE OR REPLACE PROCEDURE PV_ACTUALIZAESTADO_PR(
   TV_modulo	  ICC_MOVIMIENTO.cod_modulo%TYPE,
   TV_tecnologia  AL_TECNOLOGIA.cod_tecnologia%TYPE,
   TN_movimiento  ICC_MOVIMIENTO.num_movimiento%TYPE,
   TN_estado1	  ICC_INTERFAZ_CONSULTAS_TO.cod_estado%TYPE
   )
IS
/*
<NOMBRE>	: PV_ACTUALIZAESTADO_PR</NOMBRE>
<FECHACREA>	: 05/04/2004 <FECHACREA/>
<MODULO >	: Gestion Abonados </MODULO >
<AUTOR >    : Patricio Gallegos C. </AUTOR >
<VERSION >    	: 1.0 </VERSION >
<DESCRIPCION> : Actuliza estado del movimiento en las tablas de postventa. </DESCRIPCION>
<FECHAMOD >    : DD/MM/YYYY </FECHAMOD >
<DESCMOD >     : Breve descripcion de Modificacion </DESCMOD >
<ParamEnt >  : numero del abonado (TN_num_abonado),
		       Codigo de tenologia (TV_tecnologia),
			   Numero movimiento (TN_movimiento),
			   Estado movimiento (TN_estado) </ParamEnt>
<ParamSal >  : </ParamSal>
*/
TN_estado 	 ICC_INTERFAZ_CONSULTAS_TO.cod_estado%TYPE;
BEGIN
	 IF TV_modulo ='GA' AND TV_tecnologia IS NOT NULL AND TN_movimiento IS NOT NULL THEN
	 	IF NOT PV_SEQTRXPLATAF_FN(TV_tecnologia) THEN

				 IF TN_estado1 IS NULL THEN--Si viene nulo ingresa estado ejecutado por default
				 	 BEGIN
					 	  TN_estado:=TO_NUMBER(GE_PAC_GENERAL.PARAM_GENERAL('COD_EST_TRX_EJEC'));
					 EXCEPTION
					 		  WHEN OTHERS THEN
							  	   TN_estado:=0;
					 END;
				 ELSE
				 	 TN_estado:=TN_estado1;
				 END IF;

				UPDATE CI_ORSERV SET cod_estado = TN_estado
				WHERE NUM_MOVIMIENTO = TN_movimiento
				AND cod_estado != TN_estado;

				IF SQL%NOTFOUND  THEN

					 UPDATE PV_MOVIMIENTOS SET COD_ESTADO = TN_estado
					 WHERE NUM_MOVIMIENTO = TN_movimiento
					 AND cod_estado != TN_estado;

				END IF;

		END IF;
	 END IF;
END;
/
SHOW ERRORS
