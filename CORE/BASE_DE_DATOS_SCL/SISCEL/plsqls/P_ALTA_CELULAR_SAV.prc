CREATE OR REPLACE PROCEDURE P_ALTA_CELULAR_SAV(
  VP_ABONADO IN NUMBER ,
  VP_CLASEABO IN VARCHAR2 ,
  VP_FECSYS IN DATE )
IS
--
-- Procedimiento de Actualizacion de parametros en la tabla de abonados
-- de la red celular al activarles desde la venta en terreno.
--
   V_PROCED     VARCHAR2(25) := NULL;
   V_NUM_VENTA  GA_ABOCEL.NUM_VENTA%TYPE;

BEGIN
   V_PROCED := 'P_ALTA_CELULAR_SAV';

   UPDATE GA_ABOCEL
      SET COD_SITUACION  = 'AAA',
          FEC_ACTCEN     = VP_FECSYS,
          PERFIL_ABONADO = VP_CLASEABO
    WHERE NUM_ABONADO    = VP_ABONADO;

	--Luego del UPDATE a la fecha de activacion --
	--1? Obtener n? de venta, mediante el n? de abonado (que es el dato que tenemos) --
	--2? Ejecutar el PL de procesos omitidos. --

	SELECT NUM_VENTA
	  INTO V_NUM_VENTA
	  FROM GA_ABOCEL
	 WHERE NUM_ABONADO = VP_ABONADO;

	VE_EJECUTA_PROCOMI_PR( V_NUM_VENTA );


EXCEPTION
   WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR (-20207,V_PROCED||' '||SQLERRM);
END;
/
SHOW ERRORS
