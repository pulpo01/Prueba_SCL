CREATE OR REPLACE PROCEDURE        PV_PRC_REGULARIZA_INDEM(vp_error    out varchar2,
                                                                  vp_mensaje  out varchar2
                              )
IS
  -- Regulariza a los abonados el nuevo campo en donde si la alta es mayor al
  --     04/04/2001 es escalonada y anteriores es standard
  --

  --Declaracion de Variables


  -- Variables Constantes
  cnsStandard   number:=0;
  cnsEscalonada number:=1;

BEGIN

        UPDATE GA_ABOCEL
            SET COD_INDEMNIZACION = cnsEscalonada
          WHERE COD_SITUACION not in ('BAA','BAP')
            AND FEC_ALTA >= TO_DATE('11-04-2001','DD-MM-YYYY');

        UPDATE GA_ABOCEL
            SET COD_INDEMNIZACION = cnsStandard
          WHERE COD_SITUACION not in ('BAA','BAP')
            AND FEC_ALTA < TO_DATE('11-04-2001','DD-MM-YYYY');


EXCEPTION
                 WHEN OTHERS THEN
                          ROLLBACK;
                          vp_error := TO_CHAR(SQLCODE);
                          vp_mensaje := SQLERRM;
END;
/
SHOW ERRORS
