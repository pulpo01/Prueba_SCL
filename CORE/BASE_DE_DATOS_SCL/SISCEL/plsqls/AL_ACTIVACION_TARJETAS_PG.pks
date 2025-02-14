CREATE OR REPLACE PACKAGE AL_ACTIVACION_TARJETAS_PG IS

  CI_zero CONSTANT PLS_INTEGER :=0;
  CI_uno  CONSTANT PLS_INTEGER :=1;

PROCEDURE AL_GENERA_RANGOS_ORDEN_PR(EN_Num_Orden        IN  al_cabecera_ordenes2.num_orden%TYPE,
                                    EN_NumTransaccion   IN  ga_transacabo.num_transaccion%TYPE
                                    );

END AL_ACTIVACION_TARJETAS_PG;
/
