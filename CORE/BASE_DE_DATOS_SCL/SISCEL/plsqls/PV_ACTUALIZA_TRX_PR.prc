CREATE OR REPLACE PROCEDURE          "PV_ACTUALIZA_TRX_PR" (
	   SV_error		OUT VARCHAR2,
	   SV_desError		OUT VARCHAR2
)
/*
<NOMBRE>	: PV_ACTUALIZA_TRX_PR.</NOMBRE>
<FECHACREA>	: 01/04/2004 <FECHACREA/>
<MODULO >	: Gestion Abonados </MODULO >
<AUTOR >    	: Patricio Gallegos C. </AUTOR >
<VERSION >    	: 1.0 </VERSION >
<DESCRIPCION> 	: Actualiza estado del movimiento en tablas CI_ORSERV o PV_MOVIMIENTOS segun corresponda </DESCRIPCION>
<DESCRIPCION> 	: y borra dicho movimiento de la tabla  ICC_INTERFAZ_CONSULTAS_TO </DESCRIPCION>
<FECHAMOD >     : DD/MM/YYYY </FECHAMOD >
<DESCMOD >      : Breve descripcion de Modificacion </DESCMOD >
<ParamSal >  	: SV_error,SV_desError </ParamSal>
*/
IS

  TN_codEstPend		ICC_INTERFAZ_CONSULTAS_TO.cod_estado%TYPE:=TO_NUMBER(GE_FN_DEVVALPARAM('GA',1,'COD_EST_TRX_PEND'));--Pendiente
  TN_CodEstEjec		ICC_INTERFAZ_CONSULTAS_TO.cod_estado%TYPE:=to_number(GE_FN_DEVVALPARAM('GA',1,'COD_EST_TRX_EJEC'));
  TN_CodEstError	ICC_INTERFAZ_CONSULTAS_TO.cod_estado%TYPE:=to_number(GE_FN_DEVVALPARAM('GA',1,'COD_EST_TRX_ERRO'));
  TN_CodEstRech		ICC_INTERFAZ_CONSULTAS_TO.cod_estado%TYPE:=to_number(GE_FN_DEVVALPARAM('GA',1,'COD_EST_TRX_RECH'));
  TN_NumMovimiento	ICC_MOVIMIENTO.num_movimiento%TYPE;

   --Cursor con TRXs GSM que estan ejecutadas, con error o rechazadas --
   CURSOR recu_mov_trx IS
   SELECT DISTINCT(a.num_movimiento)
   FROM   ICC_INTERFAZ_CONSULTAS_TO a
   WHERE  a.cod_estado NOT IN (TN_codEstPend)
   AND NOT EXISTS (SELECT 1
			 FROM ICC_INTERFAZ_CONSULTAS_TO b
			 WHERE a.num_movimiento = b.num_movimiento
			 AND b.cod_estado=TN_codEstPend)
   AND NOT EXISTS (SELECT 1
			 FROM ICC_MOVIMIENTO c
			 WHERE a.num_movimiento = c.num_movimiento);

PROCEDURE DEL_ICC_INTERFAZ(
		  TN_NumMov	ICC_MOVIMIENTO.num_movimiento%TYPE,
		  TN_Estado ICC_INTERFAZ_CONSULTAS_TO.cod_estado%TYPE)
IS
	TV_codos  		CI_ORSERV.cod_os%TYPE;
	TN_abonado  	CI_ORSERV.cod_inter%TYPE;
	SV_error		number(15);
	SV_deserror	    varchar(250);
	ERR_REST_CPP   	exception;
BEGIN

  UPDATE CI_ORSERV
  SET cod_estado = TN_Estado
  WHERE num_movimiento = TN_NumMov
  AND cod_estado!=TN_Estado;

  IF NOT SQL%FOUND THEN
	  UPDATE PV_MOVIMIENTOS
	  SET cod_estado = TN_Estado
	  WHERE num_movimiento = TN_NumMov
	  AND cod_estado!=TN_Estado;
  END IF;

  IF TN_Estado IN (TN_CodEstError,TN_CodEstRech) THEN

	 SELECT cod_os,cod_inter
	 INTO TV_codos,TN_abonado
	 FROM CI_ORSERV
	 WHERE num_movimiento = TN_NumMov;

	 IF  TV_codos = GE_FN_DEVVALPARAM('GA',1,'COD_OS_CPP') THEN
  	 	 PV_RESTAURADOR_PLAN_PP_PR(TN_abonado,SV_error,SV_deserror);--CALL Restaurador Cambio de Plan tarifario Prepago
		 IF SV_error!=0 THEN
		   	RAISE ERR_REST_CPP;
		 END IF;
	 END IF;

  END IF;



  DELETE ICC_INTERFAZ_CONSULTAS_TO
  WHERE num_movimiento = TN_NumMov;

  COMMIT;

EXCEPTION
  WHEN ERR_REST_CPP THEN
  	   dbms_output.put_line('Error en PL PV_RESTAURADOR_PLAN_PP_PR : ');
  	   dbms_output.put_line(SV_deserror);
  	   ROLLBACK;
  WHEN OTHERS THEN
   	   ROLLBACK;
END DEL_ICC_INTERFAZ;

BEGIN
      OPEN recu_mov_trx;
      LOOP
         FETCH recu_mov_trx INTO TN_NumMovimiento;
		 EXIT WHEN recu_mov_trx%NOTFOUND;
/*		 BEGIN
		 	 --Valida si existe al menos 1 secuencia pendiente --
			 SELECT num_movimiento INTO TN_NumMovimiento
			 FROM ICC_INTERFAZ_CONSULTAS_TO
			 WHERE num_movimiento = TN_NumMovimiento
			 AND cod_estado in (TN_codEstPend);
		 EXCEPTION
		 	 WHEN NO_DATA_FOUND THEN -- No existen secuencias pendientes*/
			 BEGIN
			 	  -- BORRAR CON ERROR --
			 	  SELECT num_movimiento INTO TN_NumMovimiento
				  FROM ICC_INTERFAZ_CONSULTAS_TO
				  WHERE num_movimiento = TN_NumMovimiento
			 	  AND COD_ESTADO = TN_CodEstError
				  AND ROWNUM=1; --Al menos una con error --

				  DEL_ICC_INTERFAZ(TN_NumMovimiento,TN_CodEstError);

			EXCEPTION
				  WHEN NO_DATA_FOUND THEN --
				  BEGIN
				 	  --BORRAR TRX RECHAZADAS ---
				 	  SELECT num_movimiento INTO TN_NumMovimiento
					  FROM ICC_INTERFAZ_CONSULTAS_TO
					  WHERE num_movimiento = TN_NumMovimiento
				 	  AND COD_ESTADO = TN_CodEstRech
					  AND ROWNUM=1; --al menos uno con rechazo --

					  DEL_ICC_INTERFAZ(TN_NumMovimiento,TN_CodEstRech);

	              EXCEPTION
				  	  WHEN NO_DATA_FOUND THEN
					  	  BEGIN
						 	  -- BORRAR TRX EJECUTADAS --
						 	  SELECT num_movimiento INTO TN_NumMovimiento
							  FROM ICC_INTERFAZ_CONSULTAS_TO
							  WHERE num_movimiento = TN_NumMovimiento
						 	  AND COD_ESTADO NOT IN (TN_CodEstEjec);

						  EXCEPTION
				  	  	  		WHEN NO_DATA_FOUND THEN
									 DEL_ICC_INTERFAZ(TN_NumMovimiento,TN_CodEstEjec);
								WHEN OTHERS THEN
									 ROLLBACK;
						  END;
					  WHEN OTHERS THEN
					  	  ROLLBACK;
				  END;
				  WHEN OTHERS THEN
				  	  ROLLBACK;
			END;
/*			WHEN OTHERS THEN
				 ROLLBACK;
		END;*/
	 END LOOP;
	 CLOSE recu_mov_trx;

     SV_error := '0';
	 SV_desError := 'OK';
EXCEPTION
	 WHEN OTHERS THEN
	 	  ROLLBACK;
	 	  SV_error :=  SUBSTR(SQLCODE,1,15);
          SV_desError := SUBSTR(SQLERRM,1,255);
END PV_ACTUALIZA_TRX_PR;
/
SHOW ERRORS
