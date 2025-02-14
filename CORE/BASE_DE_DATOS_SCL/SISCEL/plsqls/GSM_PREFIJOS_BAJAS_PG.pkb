CREATE OR REPLACE PACKAGE BODY Gsm_Prefijos_Bajas_Pg IS
-- *************************************************************
-- * Paquete            : GSM_PREFIJOS_BAJAS_PG
-- * Descripcisn        : Proceso de Recuperacin de prefijos
-- * Fecha de creacisn  : Agosto 2004
-- * Responsable        : LABQ
-- *************************************************************




FUNCTION GSM_INS_GSM_PROCESOS_TO_FN ( ED_fec_inicial IN DATE, ED_fec_final IN DATE, EN_cod_uso  IN NUMBER,
                                                                          EN_cant_registros IN NUMBER,   SV_msgerror  OUT VARCHAR2) RETURN BOOLEAN
IS
BEGIN

   INSERT INTO GSM_PROCESOS_TO
   VALUES(GSM_RECUP_PREFIJOS_SQ.NEXTVAL, ED_fec_inicial, ED_fec_final, EN_cod_uso, EN_cant_registros, SYSDATE,  USER);

          if SQL%ROWCOUNT = 0 then

             SV_msgerror := 'ERROR: Al insertar en tabla GSM_PROCESOS_TO';

                 RETURN FALSE;
          else
                 SV_msgerror := 'Tabla GSM_PROCESOS_TO actualizada con tramo de fechas procesadas';
         RETURN TRUE;
          end if;

     DBMS_OUTPUT.PUT_LINE(SV_msgerror);

EXCEPTION

        WHEN OTHERS THEN
                 SV_msgerror := 'Error en Insert tabla GSM_PROCESOS_TO:'||SQLERRM;
                 RETURN FALSE;
END;


FUNCTION GSM_UPD_GSM_SIMCARD_TO_FN ( EV_num_simcard IN VARCHAR2, EV_cod_estado  IN VARCHAR2,   SV_msgerror OUT VARCHAR2) RETURN BOOLEAN
IS
BEGIN

     UPDATE GSM_SIMCARD_TO A
         SET    A.cod_estado = EV_cod_estado,
                    A.fec_actualizacion = SYSDATE
     WHERE  A.num_simcard  = EV_num_simcard
     AND EXISTS ( SELECT 1
                              FROM   gsm_estados_td
                              WHERE  tip_estado = 0   -- actualiza solo las que no estan en estado de baja
                              AND        cod_modulo = a.cod_modulo
                              AND    cod_estado = a.cod_estado );

          if SQL%ROWCOUNT = 0 then

             SV_msgerror := 'ERROR: no existe la simcard('|| EV_num_simcard ||')';

                 RETURN FALSE;
          else
                 SV_msgerror := 'simcard actualizada('|| EV_num_simcard ||')';
         RETURN TRUE;
          end if;

     DBMS_OUTPUT.PUT_LINE(SV_msgerror);

EXCEPTION

        WHEN NO_DATA_FOUND THEN
                 SV_msgerror := '(1)NO ENCONTRADO ESTADO : '||EV_cod_estado||' NUM_SIMCARD :'||EV_num_simcard ||'ERROR :'||SQLERRM;
                 RETURN FALSE;
        WHEN OTHERS THEN
                 SV_msgerror := '(2)ERROR EN UPDATE TABLA GSM_SIMCARD_TO: '||SQLERRM;
                 RETURN FALSE;
END;
---*************************************************************************************

PROCEDURE GSM_SIMCARD_ESTADOS_TO_PR (GV_retorno IN OUT VARCHAR2) IS

GV_num_serie                            GA_ABOCEL.num_serie%TYPE;
VG_num_simcard                          GSM_SIMCARD_TO.num_simcard%TYPE;
GN_val_numerico                         FAD_PARAMETROS.val_numerico%TYPE;
GD_sysdate                                      GA_ABOAMIST.fec_baja%TYPE;
GN_cod_uso                                      AL_USOS.COD_USO%TYPE;

/* variables que permiten guardar la fecha del proceso anterior cuando este ha sido interrumpido */
GD_fec_inicial_pospre_old   GA_ABOAMIST.fec_baja%TYPE;
GD_fec_final_pospre_old         GA_ABOAMIST.fec_baja%TYPE;

/* Variables proceso POSPAGO */
GN_val_hibernacion_pos          AL_USOS.num_dias_hibernacion%TYPE;
GN_num_dias_hibernacion_pos     AL_USOS.num_dias_hibernacion%TYPE;
GD_fec_inicial_pos                      CO_ACCIONES.fec_estado%TYPE;
GD_fec_final_pos                        CO_ACCIONES.fec_estado%TYPE;
GD_fec_final_new_pos            CO_ACCIONES.fec_estado%TYPE;
GN_cant_registros_pos           GSM_PROCESOS_TO.CANT_REGISTROS%TYPE;

/* Variables proceso PREPAGO */
GN_num_dias_hibernacion_pre     AL_USOS.num_dias_hibernacion%TYPE;
GD_fec_inicial_pre                      GA_ABOAMIST.fec_baja%TYPE;
GD_fec_final_pre                        GA_ABOAMIST.fec_baja%TYPE;
GD_fec_final_new_pre            GA_ABOAMIST.fec_baja%TYPE;

GN_cant_registros_pre           GSM_PROCESOS_TO.CANT_REGISTROS%TYPE;
SV_msgerror                                     VARCHAR2(255);


ERROR_PROCESO_GENERAL EXCEPTION;

/* Obtiene los abonados de un cliente que se dieron de Baja */
CURSOR CUR_PRE IS
 SELECT num_serie
 FROM   GA_ABOAMIST
 WHERE  cod_situacion = 'BAA'
 AND    cod_causabaja = '90'
 AND    cod_tecnologia = 'GSM'
 AND    fec_baja BETWEEN GD_fec_inicial_pre + (1/(60*60*24)) AND GD_fec_final_new_pre; --GD_fec_final_new_pre=( SYSDATE - GN_val_hibernacion_pre )


/* Cursor que Obtiene los clientes con la fecha efectiva de la Baja */
CURSOR CUR_POS IS
SELECT cod_cliente
FROM   CO_ACCIONES
WHERE  cod_rutina = 'BAJA'
AND    cod_estado = 'EJE'
AND    fec_estado BETWEEN GD_fec_inicial_pos + (1/(60*60*24)) AND GD_fec_final_new_pos; /*GD_fec_final_new_pos=( SYSDATE - GN_val_hibernacion_pos ) */

-- Cursor

   CURSOR CUR_ABOCEL(GD_Cliente GA_ABOAMIST.cod_cliente%TYPE ) IS
        SELECT num_serie
        FROM   GA_ABOCEL
        WHERE    cod_cliente           =  GD_Cliente
                        AND    cod_situacion      = 'BAA'
                        AND    cod_causabaja  =  '90'
                        AND    cod_tecnologia  = 'GSM'
                        AND    COD_USO = 2;

Cur_ACCIONES      CUR_POS%ROWTYPE;
Cur_PREPAGO       CUR_PRE%ROWTYPE;

BEGIN

        GN_cod_uso := 2;

        /* asigna fecha de proceso una sola vez para calculo de rango de fechas inicio - final */
        GD_sysdate := SYSDATE;

        /* registra la cantidad de SIMCARDS  procesadas para la recuperacion de prefijos de baja*/
        GN_cant_registros_pos := 0;
        GN_cant_registros_pre := 0;

        /**********************           Recuperacion de prefijos Pospago                 **********************/

        /* Se obtiene el Maximo de dmas que cobranza puede reversar la Baja en forma automatica */
        SELECT val_numerico
        INTO   GN_val_numerico
        FROM fad_parametros
        WHERE cod_modulo = 'CO'
        AND cod_parametro = 2;

        /* Se obtiene el nzmero de dias destinados para la Hibernacisn */
        SELECT num_dias_hibernacion
        INTO   GN_num_dias_hibernacion_pos
        FROM AL_USOS
        WHERE COD_USO = 2;

        /* Calcula el total de dias considerados en la hibernacion + los dias por el cual cobranza podria
    realizar una reversa en forma automatica */
        GN_val_hibernacion_pos := GN_val_numerico + GN_num_dias_hibernacion_pos;

        /* Obtiene el rango final de fecha considerado en el ultimo proceso ejecutado para la actualizacion
        del estado de las SimCard (fec_estado) en la tabla GSM_SIMCARD_TO */
        SELECT  MAX(fec_inicial), MAX(fec_final)
        INTO    GD_fec_inicial_pospre_old, GD_fec_final_pos
        FROM    GSM_PROCESOS_TO
        WHERE   COD_USO = 2;

        /* si no existe una fecha final o fecha de ultimo proceso, significa que este nunca se ha ejecutado
        de esta forma se asigna una fecha inicial minima para considerar el total de tarjetas dadas de baja.*/
        IF  GD_fec_final_pos IS NULL THEN
                GD_fec_inicial_pos := TO_DATE('01-01-1980','dd-mm-yyyy');
        ELSE
                /* si ya existe una fecha final o fecha de ultima ejecucion, el nuevo rango de fecha a considerar, sera
            posterior al ultimo proceso  */
                GD_fec_inicial_pos := GD_fec_final_pos + (1/(60*60*24));
                GD_fec_final_pospre_old := GD_fec_final_pos;
        END IF;


        /* el rango final de fecha a ser considerado sera la fecha de ejecucion del proceso Menos los dias calculados
        como parte de la Hibernacion  GN_val_hibernacion_pos */
        GD_fec_final_new_pos   := (GD_sysdate - GN_val_hibernacion_pos);

        SV_msgerror := '';
        OPEN Cur_Pos;
        LOOP
           FETCH Cur_Pos INTO Cur_ACCIONES;
           EXIT WHEN Cur_Pos%NOTFOUND;

                   --Obtiene los abonados de un cliente que se dieron de Baja */
                   FOR rReg IN CUR_ABOCEL  (CUR_ACCIONES.cod_cliente) LOOP

              IF (GSM_UPD_GSM_SIMCARD_TO_FN(rReg.NUM_SERIE, 'BG', SV_msgerror)) THEN
                                 GN_cant_registros_pos := GN_cant_registros_pos + 1;
                          ELSE
                                 dbms_output.put_line('Error :Pospago : Numero de SimCard :'||rReg.NUM_SERIE ||' no encontrado actualizado en GSM_SIMCARD_TO ');
                      END IF;
                   END LOOP;
        END LOOP;

        /* Registra la fecha del ultimo proceso ejecutado segun USO ( POSPAGO) y rango de fechas procesado */
    IF ( NOT GSM_INS_GSM_PROCESOS_TO_FN(GD_fec_inicial_pos, GD_fec_final_new_pos, GN_cod_uso, GN_cant_registros_pos, SV_msgerror)) THEN
                dbms_output.put_line('Error :Pospago No es posible registrar fecha de ultimo proceso, Fecha Inicial :' || TO_CHAR(GD_fec_inicial_pos,'dd-mm-yyyy hh24:mi:ss') || ' Fecha Final : '||  TO_CHAR(GD_fec_final_new_pos,'dd-mm-yyyy hh24:mi:ss'));
        END IF;

    COMMIT;

        /**********************           Recuperacion de prefijos Prepago                 **********************/

        GN_cod_uso := 3;
    /* Se obtiene el nzmero de dias destinados para la Hibernacisn PREPAGO */
        SELECT num_dias_hibernacion
        INTO   GN_num_dias_hibernacion_pre
        FROM   AL_USOS
        WHERE  COD_USO = 3;

   /* el rango final de fecha a ser considerado sera la fecha de ejecucion del proceso Menos los dias calculados
        como parte de la Hibernacion  GN_val_hibernacion_pos */
        GD_fec_final_new_pre   := (GD_sysdate - GN_num_dias_hibernacion_pre);

        /* Obtiene el rango final de fecha considerado en el ultimo proceso ejecutado para la actualizacion
        del estado de las SimCard (fec_estado) en la tabla GSM_SIMCARD_TO */
        SELECT  MAX(fec_inicial), MAX(fec_final)
        INTO    GD_fec_inicial_pospre_old, GD_fec_final_pre
        FROM    GSM_PROCESOS_TO
        WHERE   COD_USO = 3;

        /* si no existe una fecha final o fecha de ultimo proceso, significa que este nunca se ha ejecutado
        de esta forma se asigna una fecha inicial minima para considerar el total de tarjetas dadas de baja.*/
        IF  GD_fec_final_pre IS NULL THEN
                GD_fec_inicial_pre := TO_DATE('01-01-1980','dd-mm-yyyy');
        ELSE
                /* si ya existe una fecha final o fecha de ultima ejecucion, el nuevo rango de fecha a considerar, sera
            posterior al ultimo proceso  */
                GD_fec_inicial_pre := GD_fec_final_pre + (1/(60*60*24));
                GD_fec_final_pospre_old := GD_fec_final_pre;
        END IF;

        SV_msgerror := '';

        OPEN Cur_Pre;
        LOOP
           FETCH Cur_Pre INTO Cur_PREPAGO;
           EXIT WHEN Cur_Pre%NOTFOUND;

           /* Actualiza estado de SimCard en estado de baja a 'BR' Baja de Recuperacisn de Prefijos Pre-Pago */
       IF (GSM_UPD_GSM_SIMCARD_TO_FN(Cur_PREPAGO.NUM_SERIE, 'BR', SV_msgerror) ) THEN
              GN_cant_registros_pre := GN_cant_registros_pre + 1;
           ELSE
                  dbms_output.put_line('Error :Prepago Prepago : Numero de SimCard :'||Cur_PREPAGO.NUM_SERIE||' no encontrado actualizado en GSM_SIMCARD_TO ');
           END IF;

        END LOOP;

        /* Registra la fecha del ultimo proceso ejecutado segun USO ( PREPAGO) y rango de fechas procesado */
    IF (NOT  GSM_INS_GSM_PROCESOS_TO_FN(GD_fec_inicial_pre, GD_fec_final_new_pre, GN_cod_uso, GN_cant_registros_pre, SV_msgerror) ) THEN
       dbms_output.put_line('Error :Prepago No es posible registrar fecha de ultimo proceso, Fecha Inicial :' || TO_CHAR(GD_fec_inicial_pre,'dd-mm-yyyy hh24:mi:ss') || ' Fecha Final : '||  TO_CHAR(GD_fec_final_new_pre,'dd-mm-yyyy hh24:mi:ss'));
        END IF;

    COMMIT;

   EXCEPTION
      WHEN Error_Proceso_General THEN
                   /* Registra la fecha del ultimo proceso ejecutado segun USO ( PREPAGO) y rango de fechas procesado */
                   IF ( NOT GSM_INS_GSM_PROCESOS_TO_FN(GD_fec_inicial_pospre_old, GD_fec_final_pospre_old, GN_cod_uso, GN_cant_registros_pos, SV_msgerror) ) THEN
                          dbms_output.put_line('Error :Prepago No es posible registrar fecha de ultimo proceso, Fecha Inicial :' || TO_CHAR(GD_fec_inicial_pospre_old,'dd-mm-yyyy hh24:mi:ss') || ' Fecha Final : '||  TO_CHAR(GD_fec_final_pospre_old,'dd-mm-yyyy hh24:mi:ss'));
                   END IF;
                   GV_retorno := 'GSM_SIMCARD_ESTADOS_TO_PR : ' ;
                   COMMIT;
           WHEN OTHERS THEN
                   /* Registra la fecha del ultimo proceso ejecutado segun USO ( PREPAGO) y rango de fechas procesado */
               IF ( NOT GSM_INS_GSM_PROCESOS_TO_FN(GD_fec_inicial_pospre_old, GD_fec_final_pospre_old, GN_cod_uso, GN_cant_registros_pos, SV_msgerror) ) THEN
                          dbms_output.put_line('Error : No es posible registrar fecha de ultimo proceso, Fecha Inicial :' || TO_CHAR(GD_fec_inicial_pospre_old,'dd-mm-yyyy hh24:mi:ss') || ' Fecha Final : '||  TO_CHAR(GD_fec_final_pospre_old,'dd-mm-yyyy hh24:mi:ss'));
                   END IF;
                   GV_retorno := 'GSM_SIMCARD_ESTADOS_TO_PR ERROR : '||SQLERRM || ' ' || SQLCODE;
               COMMIT;

 END GSM_SIMCARD_ESTADOS_TO_PR;


END Gsm_Prefijos_Bajas_Pg;
/
SHOW ERRORS
