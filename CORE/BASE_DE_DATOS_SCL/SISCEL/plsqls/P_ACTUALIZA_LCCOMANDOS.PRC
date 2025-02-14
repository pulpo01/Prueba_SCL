CREATE OR REPLACE PROCEDURE P_ACTUALIZA_LCCOMANDOS
( v_num_movimiento     TOL_COMANDO_TD.NUM_MOVIMIENTO%TYPE)
IS

/******************************************************************************
   NAME:       P_ACTUALIZA_LCCOMANDOS
   PURPOSE:    To calculate the desired information.

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        16-01-03             1. Created this procedure.

      Date/Time:       16-01-03 03:59:46 p.m.
      Descripcion: Procedimiento que realiza la actuualizacion de la tabla tol_comando_td
******************************************************************************/
BEGIN

   update tol_comando_td set cod_estado='EJECUTADO'
   where num_movimiento=v_num_movimiento;

EXCEPTION
		 WHEN OTHERS THEN
		      Raise_application_error (-20154, 'Error en UPDATE TOL_COMANDO_TD DE RETORNO '  || to_char(SQLCODE) );


END P_ACTUALIZA_LCCOMANDOS;
/
SHOW ERRORS
