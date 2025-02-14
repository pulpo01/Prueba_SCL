CREATE OR REPLACE PACKAGE BODY GE_Scheduler_PG AS

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE GE_CierreColaSch_PR(enProceso  IN fa_intqueueproc.cod_proceso%TYPE,
                                      enAplic    IN fa_intqueueproc.cod_aplic%TYPE,
                                      enModgener IN fa_intqueueproc.cod_modgener%TYPE
                                      )
    /*
    <DOC>
        <NOMBRE>      AL_CierreColaSch_PR        </NOMBRE>
        <FECHACREA>   27-09-2004                 </FECHACREA>
        <MODULO>      LOGISTICA                  </MODULO>
        <AUTOR>       Servicios Compartidos      </AUTOR>
        <VERSION>     1.0.0                      </VERSION>
        <DESCRIPCION> Cierre Cola Scheduler      </DESCRIPCION>
        <FECHAMOD>    21-09-2004                 </FECHAMOD>
        <DESCMOD>     Cierre Cola Scheduler      </DESCMOD>
        <ParamEntr>   enProceso: Proceso         </ParamEntr>
        <ParamEntr>   enAplic: Aplicacion        </ParamEntr>
        <ParamEntr>   enModgener: Modulo Geenral </ParamEntr>
    </DOC>
    */
    AS
        PRAGMA AUTONOMOUS_TRANSACTION;

            cnUno  PLS_INTEGER := 1;
            cnNull PLS_INTEGER := NULL;

    BEGIN

        UPDATE FA_INTQUEUEPROC SET
                cod_estado = cnUno,
                pid_proceso = cnNull
            WHERE cod_aplic = enAplic
            AND cod_modgener = enModgener
            AND cod_proceso = enProceso;

        COMMIT;

    END GE_CierreColaSch_PR;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

END GE_Scheduler_PG;
/
SHOW ERRORS
