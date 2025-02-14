CREATE OR REPLACE PROCEDURE PV_ins_err_transaccion_PR (EN_transaccion   ga_transacabo.NUM_TRANSACCION%TYPE,
                                                                         EN_retorno       ga_transacabo.COD_RETORNO%TYPE,
                                                                         EN_cadena        ga_transacabo.DES_CADENA%TYPE
                                                                        )

IS

LV_v_verror                     VARCHAR2(255);
CN_20010 CONSTANT number := 20010;

PRAGMA AUTONOMOUS_TRANSACTION;

BEGIN


          INSERT INTO GA_TRANSACABO(NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
                             VALUES(EN_transaccion,EN_retorno,EN_cadena);

          COMMIT;

EXCEPTION
                 WHEN OTHERS THEN
                      LV_v_verror := SUBSTR(SQLERRM,1,255);
                          RAISE_APPLICATION_ERROR(CN_20010, LV_v_verror );

END PV_ins_err_transaccion_PR;
/
SHOW ERRORS
