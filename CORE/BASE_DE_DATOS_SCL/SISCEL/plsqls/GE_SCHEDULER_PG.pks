CREATE OR REPLACE PACKAGE GE_Scheduler_PG IS

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE GE_CierreColaSch_PR (enProceso  IN fa_intqueueproc.cod_proceso%TYPE,
                                   enAplic    IN fa_intqueueproc.cod_aplic%TYPE,
                                   enModgener IN fa_intqueueproc.cod_modgener%TYPE
                                  );

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

END GE_Scheduler_PG;
/
SHOW ERRORS
