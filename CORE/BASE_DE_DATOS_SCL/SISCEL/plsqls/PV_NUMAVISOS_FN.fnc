CREATE OR REPLACE FUNCTION PV_NUMAVISOS_FN(EN_num_cel IN ICC_MOVIMIENTO.NUM_CELULAR%TYPE )
RETURN VARCHAR2
IS
/*
<NOMBRE>	: PV_NUMAVISOS_FN</NOMBRE>
<FECHACREA>	: 14/07/2004 <FECHACREA/>
<MODULO >	: Post VENTA </MODULO >
<AUTOR >    : Maritza Tapia A. </AUTOR >
<VERSION >  : 1.0 </VERSION >
<DESCRIPCION> : Funcion que recibe numero de celular y devuelve cantidad de avisos . </DESCRIPCION>
<FECHAMOD >   : DD/MM/YYYY </FECHAMOD>
<DESCMOD >    : Breve descripcion de Modificacion </DESCMOD >
<ParamEnt >  : Numero de Celular(EN_num_cel)   :</ParamEnt>
<ParamSal >  :  </ParamSal>
*/

    SV_out STRING(512);
    error_proceso EXCEPTION;
  BEGIN
  	    SELECT cant_avisos INTO SV_out
	    FROM PV_UMBRAL_TO
	    WHERE num_celular = EN_num_cel;

        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;

    RETURN SV_out;

  EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR PV_NUMAVISOS_FN, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR PV_NUMAVISOS_FN, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
END;
/
SHOW ERRORS
