CREATE OR REPLACE PACKAGE BODY Gsm_Rangos_Prefijos AS

PROCEDURE  ORDENA_RANGOS_IMSI (V_SOLICITUD IN GSM_CABSOL_SIMCARD_TO.NUM_SEQ_SOLICITUD%TYPE
 ) IS

 --------------------------------------------------------------------------------------------
-- Funci¢n Ordena rangos de prefijo ICC
-- Autor   : Maritza Tapia A
-- Fecha   : 10 Enero de 2003
---------------------------------------------------------------------------------------------
        ERROR_PROCESO_GENERAL_IMSI      EXCEPTION;
     V_GLOSA_ERROR              VARCHAR2(30);
         V_SIMCARD                      GSM_SIMCARD_TO.NUM_SIMCARD%TYPE;
         V_SIMCARDF                             GSM_SIMCARD_TO.NUM_SIMCARD%TYPE;
         V_SECUENCIA                    GSM_SIMCARD_TO.NUM_SIMCARD%TYPE;
         V_SECUENCIA1                   GSM_SIMCARD_TO.NUM_SIMCARD%TYPE;
         V_PREFIJO                              GSM_PREFIJO_TO.COD_PREFIJO%TYPE;
         V_MAXIMO                               GSM_RANGOS_PREFIJOS_TO.NUM_VALOR_MAXIMO %TYPE;
         V_MINIMO               GSM_RANGOS_PREFIJOS_TO.NUM_VALOR_MINIMO%TYPE;
         IMSIR                                  GSM_DET_SIMCARD_TO.VAL_CAMPO%TYPE;
         V_INTERVALO    NUMBER(19):=0 ;
     V_PARAM_SALIDA VARCHAR2(2000) := '';
         V_PREFIJO1             VARCHAR2(11) := NULL;
         V_SIGUE                BOOLEAN;
         J                  NUMBER(19):=0;
         VP_SQLCODE     VARCHAR2(100);
         VP_SQLERRM             VARCHAR2(100);
         V_PREFIJO_GENERADO NUMBER(3);

---------------------------------------------------------------------------------------------
-- CURSOR : Recupera prefijos asociados a una solicitud
---------------------------------------------------------------------------------------------

         CURSOR  SIMCARD IS
        SELECT DISTINCT E.COD_PREFIJO, SUBSTR(F.VAL_CAMPO,LENGTH(D.COD_PREFIJO_GENERADO)+1) AS CAMPO, F.VAL_CAMPO,  D.COD_CAMPO
         FROM  GSM_SIMCARD_TO A,
           GSM_DETSOL_SIMCARD_TO B,
           GSM_CAMPOS_TO      C,
           GSM_PREFIJO_TO    D,
           GSM_RANGOS_PREFIJOS_TO E,
           GSM_DET_SIMCARD_TO F
         WHERE    A.NUM_SEQ_SOLICITUD = V_SOLICITUD AND
                      F.NUM_SIMCARD = A.NUM_SIMCARD AND
                      F.COD_CAMPO = C.COD_CAMPO AND
                      B.NUM_SEQ_SOLICITUD = A.NUM_SEQ_SOLICITUD AND
                      B.COD_CAMPO = C.COD_CAMPO     AND
                      C.IND_TABLA ='P'           AND
                      D.COD_PREFIJO = B.VAL_CAMPO AND
                      E.COD_PREFIJO = D.COD_PREFIJO AND
                          B.COD_CAMPO <> 'ICC'
         ORDER BY       1,2;

BEGIN
---------------------------------------------------------------------------------------------
-- Validaci¢n  parametros de entrada
---------------------------------------------------------------------------------------------
        IF V_SOLICITUD IS NULL OR V_SOLICITUD = '' THEN
                V_GLOSA_ERROR := 'ERROR, Parametro de entrada, Usuario';
                RAISE ERROR_PROCESO_GENERAL_IMSI;
                        V_SIGUE:=FALSE;
        END IF;

        FOR R IN SIMCARD
        LOOP

---------------------------------------------------------------------------------------------
-- MODIFICA IMSIR
---------------------------------------------------------------------------------------------


    V_PREFIJO := R.COD_PREFIJO;
        V_SECUENCIA := R.CAMPO;
                IF R.COD_CAMPO = 'IMSIR' THEN
                         BEGIN
                                UPDATE GSM_IMSIR_TO SET COD_ESTADO = 'N',
                                                                                FEC_ACTUALIZACION = SYSDATE
                                WHERE NUM_IMSIR   = R.VAL_CAMPO       AND
                                          COD_PREFIJO = R.COD_PREFIJO;
                 EXCEPTION
                           WHEN OTHERS THEN
                                        RAISE_APPLICATION_ERROR (-20001,'ORDENA_RANGOS_IMSI  :GSM_IMSIR_TO  <'  || R.VAL_CAMPO  ||'>' ||   TO_CHAR(SQLCODE) || ' ' ||SQLERRM );

                         END;
        END IF;


---------------------------------------------------------------------------------------------
-- ORDENA PREFIJOS
---------------------------------------------------------------------------------------------




            IF V_PREFIJO <> V_PREFIJO1 THEN
            IF J <> 0 AND V_PREFIJO1 <> NULL THEN
                          IF V_MAXIMO IS NULL OR V_MAXIMO = '' THEN
                               V_MAXIMO := V_SECUENCIA1;
                                   Gsm_Rangos_Prefijos.INSERT_RANGOS_PREFIJO(V_PREFIJO1,V_MAXIMO, V_MINIMO, V_INTERVALO);
                                   V_INTERVALO := 0;
                                   V_MAXIMO := NULL;
                          END IF;
                        END IF;
                END IF;

            IF V_INTERVALO = 0 THEN
            V_MINIMO := V_SECUENCIA;
            V_SECUENCIA1 := V_SECUENCIA;
                        V_PREFIJO1 := V_PREFIJO;
            V_INTERVALO := V_INTERVALO + 1;
            J := J + 1;
        ELSE
            IF (V_SECUENCIA - V_SECUENCIA1) = 1 THEN
                V_SECUENCIA1 := V_SECUENCIA;
                V_INTERVALO := V_INTERVALO + 1;
            ELSE
                V_MAXIMO := V_SECUENCIA1;
                                Gsm_Rangos_Prefijos.INSERT_RANGOS_PREFIJO(V_PREFIJO1,V_MAXIMO, V_MINIMO, V_INTERVALO);
                                V_INTERVALO := 0;
                IF V_PREFIJO = V_PREFIJO1 THEN
                     J := J + 1;
                                         V_MINIMO := V_SECUENCIA;
                     V_SECUENCIA1 := V_SECUENCIA;
                                ELSE
                                    V_PREFIJO1 := V_PREFIJO;
                                        V_MINIMO := V_SECUENCIA;
                                        V_SECUENCIA1 := V_SECUENCIA;
                                        V_INTERVALO := V_INTERVALO + 1;
                                        V_MAXIMO := NULL;
                END IF;
            END IF;
        END IF;
        END LOOP;
        IF V_MAXIMO IS NULL OR V_MAXIMO = '' THEN
                V_MAXIMO := V_SECUENCIA1;
                Gsm_Rangos_Prefijos.INSERT_RANGOS_PREFIJO(V_PREFIJO1,V_MAXIMO, V_MINIMO, V_INTERVALO);
    END IF;

    EXCEPTION
        WHEN ERROR_PROCESO_GENERAL_IMSI THEN
          RAISE_APPLICATION_ERROR (-20002,'ORDENA_RANGOS_IMSI  : ERROR_PROCESO_GENERAL ' ||V_GLOSA_ERROR );
        WHEN NO_DATA_FOUND THEN
                  RAISE_APPLICATION_ERROR (-20003,'ORDENA_RANGOS_IMSI  : ' || TO_CHAR(SQLCODE) || ' ' ||SQLERRM );
        WHEN OTHERS THEN
                  RAISE_APPLICATION_ERROR (-20004,'ORDENA_RANGOS_IMSI  : ' || TO_CHAR(SQLCODE) || ' ' ||SQLERRM );
END ORDENA_RANGOS_IMSI;



PROCEDURE  ORDENA_RANGOS_ICC (V_SOLICITUD IN GSM_CABSOL_SIMCARD_TO.NUM_SEQ_SOLICITUD%TYPE
 ) IS

 --------------------------------------------------------------------------------------------
-- Funci¢n Ordena rangos de prefijo ICC
-- Autor   : Maritza Tapia A
-- Fecha   : 10 Enero de 2003
---------------------------------------------------------------------------------------------
        ERROR_PROCESO_GENERAL_ICC  EXCEPTION;
     V_GLOSA_ERROR              VARCHAR2(30);
         V_SIMCARD                      GSM_SIMCARD_TO.NUM_SIMCARD%TYPE;
         V_SIMCARDF                             GSM_SIMCARD_TO.NUM_SIMCARD%TYPE;
         V_SECUENCIA                    GSM_SIMCARD_TO.NUM_SIMCARD%TYPE;
         V_SECUENCIA1                   GSM_SIMCARD_TO.NUM_SIMCARD%TYPE;
         V_PREFIJO                              GSM_PREFIJO_TO.COD_PREFIJO%TYPE;
         V_MAXIMO                               GSM_RANGOS_PREFIJOS_TO.NUM_VALOR_MAXIMO %TYPE;
         V_MINIMO               GSM_RANGOS_PREFIJOS_TO.NUM_VALOR_MINIMO%TYPE;
         V_INTERVALO    NUMBER(19):=0 ;
     V_PARAM_SALIDA VARCHAR2(2000) := '';
         V_PREFIJO1             VARCHAR2(11) := NULL;
         V_SIGUE                BOOLEAN;
         J                  NUMBER(19):=0;
         VP_SQLCODE     VARCHAR2(100);
         VP_SQLERRM             VARCHAR2(100);
         V_PREFIJO_GENERADO NUMBER(3);

---------------------------------------------------------------------------------------------
-- CURSOR : Recupera el num_simcard asociada a una solicitud
---------------------------------------------------------------------------------------------

         CURSOR  SIMCARD IS
         SELECT  NUM_SIMCARD
         FROM    GSM_SIMCARD_TO
         WHERE   NUM_SEQ_SOLICITUD = V_SOLICITUD
         ORDER BY NUM_SIMCARD ASC;

BEGIN
---------------------------------------------------------------------------------------------
-- Validaci¢n  parametros de entrada
---------------------------------------------------------------------------------------------
        IF V_SOLICITUD IS NULL OR V_SOLICITUD = '' THEN
                V_GLOSA_ERROR := 'ERROR ORDENA_RANGOS_ICC : Parametro de entrada, Usuario';
                RAISE ERROR_PROCESO_GENERAL_ICC ;
                        V_SIGUE:=FALSE;
        END IF;

        BEGIN
                SELECT DISTINCT LENGTH(C.COD_PREFIJO_GENERADO) + 1, C.COD_PREFIJO
                INTO   V_PREFIJO_GENERADO, V_PREFIJO
                FROM   GSM_DETSOL_SIMCARD_TO B, GSM_PREFIJO_TO C
                WHERE B.COD_CAMPO = 'ICC'
                AND   B.NUM_SEQ_SOLICITUD=V_SOLICITUD
                AND   B.VAL_CAMPO = C.COD_PREFIJO;
                EXCEPTION
                WHEN NO_DATA_FOUND THEN
                        V_GLOSA_ERROR := 'ERROR ORDENA_RANGOS_ICC : No Se encuentran valores para el prefijo (ICC) para la solicitud  ' || V_SOLICITUD ;
                        RAISE  ERROR_PROCESO_GENERAL_ICC;
        END;


        FOR R IN SIMCARD
        LOOP
---------------------------------------------------------------------------------------------
-- OBTIENE PREFIJO Y PREFIJO GENERADO DE UNA SIMCARD
---------------------------------------------------------------------------------------------
                        V_SECUENCIA:= SUBSTR(SUBSTR(R.NUM_SIMCARD, V_PREFIJO_GENERADO),0, LENGTH(SUBSTR(R.NUM_SIMCARD, V_PREFIJO_GENERADO))-1);
                        IF V_PREFIJO <> V_PREFIJO1 THEN
                                IF J <> 0 AND V_PREFIJO1 <> NULL THEN
                                        IF V_MAXIMO IS NULL OR V_MAXIMO = '' THEN
                                                V_MAXIMO := V_SECUENCIA1;
                                                Gsm_Rangos_Prefijos.INSERT_RANGOS_PREFIJO(V_PREFIJO,V_MAXIMO, V_MINIMO, V_INTERVALO);
                                        END IF;
                                END IF;
                        END IF;

                        IF V_INTERVALO = 0 THEN
                                V_MINIMO := V_SECUENCIA;
                                V_SECUENCIA1 := V_SECUENCIA;
                                V_PREFIJO1 := V_PREFIJO;
                                V_INTERVALO := V_INTERVALO + 1;
                                J := J + 1;
                        ELSE
            IF (V_SECUENCIA - V_SECUENCIA1) = 1 THEN
                V_SECUENCIA1 := V_SECUENCIA;
                V_INTERVALO := V_INTERVALO + 1;
            ELSE
                V_MAXIMO := V_SECUENCIA1;
                                Gsm_Rangos_Prefijos.INSERT_RANGOS_PREFIJO(V_PREFIJO,V_MAXIMO, V_MINIMO, V_INTERVALO);
                                V_INTERVALO := 0;
                IF V_PREFIJO = V_PREFIJO1 THEN
                     J := J + 1;
                                         V_MINIMO := V_SECUENCIA;
                     V_SECUENCIA1 := V_SECUENCIA;
                END IF;
            END IF;
        END IF;
        END LOOP;
        IF V_MAXIMO IS NULL OR V_MAXIMO = '' THEN
       V_MAXIMO := V_SECUENCIA1;
           Gsm_Rangos_Prefijos.INSERT_RANGOS_PREFIJO(V_PREFIJO,V_MAXIMO, V_MINIMO, V_INTERVALO);
    END IF;

    EXCEPTION
    WHEN ERROR_PROCESO_GENERAL_ICC  THEN
                                                   RAISE_APPLICATION_ERROR (-20005,'ORDENA_RANGOS_ICC  : ERROR_PROCESO_GENERAL ' ||V_GLOSA_ERROR );
         WHEN OTHERS THEN
                                                           RAISE_APPLICATION_ERROR (-20006,'ORDENA_RANGOS_ICC  : ' || TO_CHAR(SQLCODE) || ' ' ||SQLERRM );
END ORDENA_RANGOS_ICC;

PROCEDURE  INSERT_RANGOS_PREFIJO (
PREFIJO IN GSM_PREFIJO_TO.COD_PREFIJO%TYPE,
MAXIMO  IN GSM_RANGOS_PREFIJOS_TO.NUM_VALOR_MAXIMO %TYPE,
MINIMO  IN GSM_RANGOS_PREFIJOS_TO.NUM_VALOR_MINIMO%TYPE,
INTERVALO IN GSM_RANGOS_PREFIJOS_TO.NUM_VALOR_INTERVALO%TYPE ) IS
V_INTERVALO  NUMBER(19);
VP_SQLCODE     VARCHAR2(100);
VP_SQLERRM              VARCHAR2(100);
BEGIN
        IF (MAXIMO = MINIMO) THEN
            V_INTERVALO := 1;
        ELSE
                V_INTERVALO := (MAXIMO - MINIMO) + 1;
        END IF;


                 INSERT INTO GSM_RANGOS_PREFIJOS_TO (
                                          COD_PREFIJO,
                                          NUM_SECUENCIA,
                                          NUM_VALOR_MINIMO,
                                          NUM_VALOR_MAXIMO,
                                          NUM_VALOR_INTERVALO,
                                          FEC_ACTUALIZACION,
                                          COD_USUARIO )
                                          VALUES
                                          ( PREFIJO,
                                                GSM_SEQ_RANGOS_SQ.NEXTVAL,
                                                MINIMO,
                                                MAXIMO,
                                                V_INTERVALO,
                                                SYSDATE,
                                                USER);
   EXCEPTION
     WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR (-20007,'INSERT_RANGOS_PREFIJO  : ' || TO_CHAR(SQLCODE) || ' ' ||SQLERRM );
END INSERT_RANGOS_PREFIJO;

PROCEDURE  INSERTA_RANGOS_SOLICITUD (V_SOLICITUD IN GSM_CABSOL_SIMCARD_TO.NUM_SEQ_SOLICITUD%TYPE
 ) IS

 --------------------------------------------------------------------------------------------
-- Funci¢n Ordena rangos de prefijo ICC
-- Autor   : Maritza Tapia A
-- Fecha   : 10 Enero de 2003
---------------------------------------------------------------------------------------------
     Error_Proceso_General  EXCEPTION;
     V_GLOSA_ERROR              VARCHAR2(30);
         V_SIMCARD                      GSM_SIMCARD_TO.NUM_SIMCARD%TYPE;
         V_SIMCARDF                             GSM_SIMCARD_TO.NUM_SIMCARD%TYPE;
         V_SECUENCIA                    GSM_SIMCARD_TO.NUM_SIMCARD%TYPE;
         V_SECUENCIA1                   GSM_SIMCARD_TO.NUM_SIMCARD%TYPE;
         V_PREFIJO                              GSM_PREFIJO_TO.COD_PREFIJO%TYPE;
         PREFIJO1                               GSM_PREFIJO_TO.COD_PREFIJO%TYPE;
         V_MAXIMO                               GSM_RANGOS_PREFIJOS_TO.NUM_VALOR_MAXIMO %TYPE;
         V_MINIMO               GSM_RANGOS_PREFIJOS_TO.NUM_VALOR_MINIMO%TYPE;
         V_MAXIMO1                              NUMBER(19):= 0;
         V_MINIMO1              NUMBER(19):= 0;
         V_INTERVALO    NUMBER(19):=0 ;
     V_PARAM_SALIDA VARCHAR2(2000) := '';
         V_PREFIJO1             VARCHAR2(11) := NULL;
         V_SIGUE                BOOLEAN;
         J                  NUMBER(19):=0;
         VP_SQLCODE     VARCHAR2(100);
         VP_SQLERRM             VARCHAR2(100);
         V_PREFIJO_GENERADO NUMBER(3);

---------------------------------------------------------------------------------------------
-- CURSOR : Recupera el num_simcard asociada a una solicitud
---------------------------------------------------------------------------------------------

         CURSOR PREFIJO IS
         SELECT A.COD_PREFIJO FROM (
                SELECT DISTINCT E.COD_PREFIJO
                FROM   GSM_SIMCARD_TO A,
                       GSM_DETSOL_SIMCARD_TO B,
                       GSM_CAMPOS_TO      C,
                       GSM_PREFIJO_TO    D,
                       GSM_RANGOS_PREFIJOS_TO E,
                       GSM_DET_SIMCARD_TO F
                WHERE   A.NUM_SEQ_SOLICITUD = V_SOLICITUD AND
                                F.NUM_SIMCARD = A.NUM_SIMCARD AND
                                F.COD_CAMPO = C.COD_CAMPO AND
                                B.NUM_SEQ_SOLICITUD = A.NUM_SEQ_SOLICITUD AND
                                B.COD_CAMPO = C.COD_CAMPO     AND
                                C.IND_TABLA ='P'           AND
                                D.COD_PREFIJO = B.VAL_CAMPO AND
                                E.COD_PREFIJO = D.COD_PREFIJO
                UNION
                SELECT DISTINCT  C.COD_PREFIJO
                FROM   GSM_SIMCARD_TO A, GSM_DETSOL_SIMCARD_TO B, GSM_PREFIJO_TO C
                WHERE  A.NUM_SEQ_SOLICITUD = V_SOLICITUD
                AND    A.NUM_SEQ_SOLICITUD = B.NUM_SEQ_SOLICITUD
                AND    B.COD_CAMPO = 'ICC'
                AND    B.VAL_CAMPO = C.COD_PREFIJO) A;

                CURSOR DETALLE_PREFIJO IS
                SELECT COD_PREFIJO,
                       NUM_VALOR_MINIMO,
                   NUM_VALOR_MAXIMO
                FROM GSM_RANGOS_PREFIJOS_TO
                WHERE COD_PREFIJO = PREFIJO1
                AND   NUM_VALOR_INTERVALO <> 0
                ORDER BY NUM_VALOR_MINIMO;

BEGIN
---------------------------------------------------------------------------------------------
-- Validaci¢n  parametros de entrada
---------------------------------------------------------------------------------------------
        IF V_SOLICITUD IS NULL OR V_SOLICITUD = '' THEN
                    V_GLOSA_ERROR := 'ERROR GSM_ORDENA_RANGOS_FN: Parametro de entrada, Usuario';
                        RAISE ERROR_PROCESO_GENERAL;
                        V_SIGUE:=FALSE;
        END IF;


        FOR R IN PREFIJO
        LOOP
        EXIT WHEN PREFIJO%NOTFOUND;
        PREFIJO1 := R.COD_PREFIJO;
        V_MINIMO := 0;
                 FOR M IN DETALLE_PREFIJO
                                 LOOP
                                            IF V_MINIMO = 0 THEN
                                                    Gsm_Rangos_Prefijos.DELETE_RANGOS_PREFIJO(R.COD_PREFIJO);
                                            V_MINIMO := M.NUM_VALOR_MINIMO;
                                            V_MAXIMO := M.NUM_VALOR_MAXIMO;
                                        ELSE
                                                    IF (M.NUM_VALOR_MINIMO - V_MAXIMO) = 1 THEN
                                                V_MAXIMO := M.NUM_VALOR_MAXIMO;
                                            ELSE
                                                                Gsm_Rangos_Prefijos.INSERT_RANGOS_PREFIJO(R.COD_PREFIJO,V_MAXIMO, V_MINIMO, V_INTERVALO);
                                                V_MINIMO := M.NUM_VALOR_MINIMO;
                                                    V_MAXIMO := M.NUM_VALOR_MAXIMO;
                                            END IF;
                                        END IF;
                                 END LOOP;
                                 Gsm_Rangos_Prefijos.INSERT_RANGOS_PREFIJO(R.COD_PREFIJO,V_MAXIMO, V_MINIMO, V_INTERVALO);
        END LOOP;
    EXCEPTION
     WHEN OTHERS THEN
                        RAISE_APPLICATION_ERROR (-20008,'INSERTA_RANGOS_SOLICITUD : ' || TO_CHAR(SQLCODE) || ' ' ||SQLERRM );
END INSERTA_RANGOS_SOLICITUD;

PROCEDURE  DELETE_RANGOS_PREFIJO (
PREFIJO IN GSM_PREFIJO_TO.COD_PREFIJO%TYPE
) IS
 VP_SQLCODE     VARCHAR2(100);
 VP_SQLERRM             VARCHAR2(100);
        BEGIN
                 DELETE FROM GSM_RANGOS_PREFIJOS_TO
                 WHERE COD_PREFIJO = PREFIJO;
    EXCEPTION
     WHEN OTHERS THEN
                         RAISE_APPLICATION_ERROR (-20009,'DELETE_RANGOS_PREFIJO : ' || TO_CHAR(SQLCODE) || ' ' ||SQLERRM );
END DELETE_RANGOS_PREFIJO;


PROCEDURE  ELIMINA_SIMCARD (V_SOLICITUD IN GSM_CABSOL_SIMCARD_TO.NUM_SEQ_SOLICITUD%TYPE
 ) IS


BEGIN
       DELETE GSM_SIMCARD_TO WHERE NUM_SEQ_SOLICITUD = V_SOLICITUD;

    EXCEPTION
     WHEN OTHERS THEN
                         RAISE_APPLICATION_ERROR (-20010,'ELIMINA_SIMCARD : ' || TO_CHAR(SQLCODE) || ' ' ||SQLERRM );

END ELIMINA_SIMCARD;

PROCEDURE GSM_RANGOS_SIMCARD (V_SIMCARD IN GSM_SIMCARD_TO.NUM_SIMCARD%TYPE
 ) IS

 --------------------------------------------------------------------------------------------
-- Funci¢n Ordena rangos de prefijo ICC
-- Autor   : Maritza Tapia A
-- Fecha   : 17 Enero de 2003
---------------------------------------------------------------------------------------------
        ERROR_PROCESO_G_RSIMCARD   EXCEPTION;
     V_GLOSA_ERROR              VARCHAR2(30);
         V_SECUENCIA                    GSM_SIMCARD_TO.NUM_SIMCARD%TYPE;
         V_SOLICITUD                    GSM_SIMCARD_TO.NUM_SEQ_SOLICITUD%TYPE;
         V_PREFIJO                              GSM_PREFIJO_TO.COD_PREFIJO%TYPE;
         V_MAXIMO                               GSM_RANGOS_PREFIJOS_TO.NUM_VALOR_MAXIMO %TYPE;
         V_MINIMO               GSM_RANGOS_PREFIJOS_TO.NUM_VALOR_MINIMO%TYPE;
         IMSIR                                  GSM_DET_SIMCARD_TO.VAL_CAMPO%TYPE;
         V_INTERVALO    NUMBER(19):=0 ;
         V_SIGUE                BOOLEAN := TRUE;
         J                  NUMBER(19):=0;
         VP_SQLCODE     VARCHAR2(100);
         VP_SQLERRM             VARCHAR2(100);
         V_PREFIJO_GENERADO NUMBER(3);

---------------------------------------------------------------------------------------------
-- CURSOR : Recupera prefijos asociados a una solicitud
---------------------------------------------------------------------------------------------

         CURSOR  SIMCARD IS
        SELECT DISTINCT E.COD_PREFIJO, SUBSTR(F.VAL_CAMPO,LENGTH(D.COD_PREFIJO_GENERADO)+1) AS CAMPO, F.VAL_CAMPO, F.COD_CAMPO, B.NUM_SEQ_SOLICITUD
         FROM  GSM_SIMCARD_TO A,
           GSM_DETSOL_SIMCARD_TO B,
           GSM_CAMPOS_TO      C,
           GSM_PREFIJO_TO    D,
           GSM_RANGOS_PREFIJOS_TO E,
           GSM_DET_SIMCARD_TO F
         WHERE    A.NUM_SIMCARD = V_SIMCARD AND
                      F.NUM_SIMCARD = A.NUM_SIMCARD AND
                      F.COD_CAMPO = C.COD_CAMPO AND
                      B.NUM_SEQ_SOLICITUD = A.NUM_SEQ_SOLICITUD AND
                      B.COD_CAMPO = C.COD_CAMPO     AND
                      C.IND_TABLA ='P'           AND
                      D.COD_PREFIJO = B.VAL_CAMPO AND
                      E.COD_PREFIJO = D.COD_PREFIJO AND
                          B.COD_CAMPO <> 'ICC'
         ORDER BY       1,2;

BEGIN
---------------------------------------------------------------------------------------------
-- Validaci¢n  parametros de entrada
---------------------------------------------------------------------------------------------
        IF V_SIMCARD IS NULL OR V_SIMCARD = '' THEN
                    V_GLOSA_ERROR := 'ERROR RANGOS_SIMCARD: Parametro de entrada, Nø de Simcard';
                        RAISE ERROR_PROCESO_G_RSIMCARD ;
                        V_SIGUE:=FALSE;
        END IF;

        FOR R IN SIMCARD
        LOOP
            V_PREFIJO := R.COD_PREFIJO;
                V_SECUENCIA := R.CAMPO;
---------------------------------------------------------------------------------------------
-- MODIFICA IMSIR
---------------------------------------------------------------------------------------------
                IF R.COD_CAMPO ='IMSIR' THEN
                                 BEGIN
                                 UPDATE GSM_IMSIR_TO SET COD_ESTADO = 'N'
                         WHERE NUM_IMSIR =  R.VAL_CAMPO;

                         EXCEPTION
                                   WHEN OTHERS THEN
                                                                V_GLOSA_ERROR := 'ERROR UPDATE GSM_IMSIR_TO '|| R.VAL_CAMPO;
                                                                RAISE ERROR_PROCESO_G_RSIMCARD ;

                                 END;
                END IF;
---------------------------------------------------------------------------------------------
-- INSERTA PREFIJOS
---------------------------------------------------------------------------------------------
            IF (V_SIGUE = TRUE) THEN
              V_INTERVALO := 0;
                  Gsm_Rangos_Prefijos.INSERT_RANGOS_PREFIJO(V_PREFIJO,V_SECUENCIA, V_SECUENCIA, V_INTERVALO);
                END IF;

  END LOOP;


---------------------------------------------------------------------------------------------
-- INSERTA ICC
---------------------------------------------------------------------------------------------

            BEGIN
                SELECT DISTINCT LENGTH(C.COD_PREFIJO_GENERADO) + 1, C.COD_PREFIJO, A.NUM_SEQ_SOLICITUD
                INTO   V_PREFIJO_GENERADO, V_PREFIJO, V_SOLICITUD
                           FROM   GSM_SIMCARD_TO A, GSM_DETSOL_SIMCARD_TO B, GSM_PREFIJO_TO C
                           WHERE  A.NUM_SIMCARD = V_SIMCARD
                           AND    A.NUM_SEQ_SOLICITUD = B.NUM_SEQ_SOLICITUD
                           AND    B.COD_CAMPO = 'ICC'
                           AND    B.VAL_CAMPO = C.COD_PREFIJO;
                           EXCEPTION
                           WHEN NO_DATA_FOUND THEN
                                V_GLOSA_ERROR := 'ERROR SELECT GSM_SIMCARD_TO/GSM_DETSOL_SIMCARD_TO/GSM_PREFIJO_TO '|| V_SIMCARD;
                                RAISE  ERROR_PROCESO_G_RSIMCARD;
                END;

        V_SECUENCIA:= SUBSTR(SUBSTR(V_SIMCARD, V_PREFIJO_GENERADO),0, LENGTH(SUBSTR(V_SIMCARD, V_PREFIJO_GENERADO))-1);
---------------------------------------------------------------------------------------------
-- INSERTA PREFIJOS
---------------------------------------------------------------------------------------------
            IF (V_SIGUE = TRUE) THEN
                        V_INTERVALO := 0;
                                Gsm_Rangos_Prefijos.INSERT_RANGOS_PREFIJO(V_PREFIJO,V_SECUENCIA, V_SECUENCIA, V_INTERVALO);
                END IF;

        IF (V_SIGUE = TRUE) THEN
                                Gsm_Rangos_Prefijos.INSERTA_RANGOS_SOLICITUD(V_SOLICITUD);
                END IF;

    EXCEPTION
        WHEN ERROR_PROCESO_G_RSIMCARD  THEN
                        RAISE_APPLICATION_ERROR (-20011,'GSM_RANGOS_SIMCARD : ERROR_PROCESO_GENERAL ' ||V_GLOSA_ERROR );
     WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR (-20012,'GSM_RANGOS_SIMCARD : ' || TO_CHAR(SQLCODE) || ' ' ||SQLERRM );

END GSM_RANGOS_SIMCARD;

PROCEDURE  INSERTA_IMSIR (PREFIJOGENERADO IN VARCHAR2, RANGO_MIN IN NUMBER,
RANGO_MAX IN NUMBER, M_SPREFIJOGENERADO IN NUMBER,M_ILARGOIMSIR IN NUMBER  ) IS

 --------------------------------------------------------------------------------------------
-- Funci¢n Inserta rangos IMSIR
-- Autor   : Maritza Tapia A
-- Fecha   : 6 de Febrero de 2003
---------------------------------------------------------------------------------------------
     ERROR_PROCESO_GENERAL  EXCEPTION;
     V_GLOSA_ERROR              VARCHAR2(30);
     V_RETORNO                          VARCHAR2(60);
         V_SECUENCIA                    GSM_SIMCARD_TO.NUM_SIMCARD%TYPE;
         V_SECUENCIA1                   GSM_SIMCARD_TO.NUM_SIMCARD%TYPE;
         V_PREFIJO                              GSM_PREFIJO_TO.COD_PREFIJO%TYPE;
         V_MAXIMO                               GSM_RANGOS_PREFIJOS_TO.NUM_VALOR_MAXIMO %TYPE;
         V_MINIMO               GSM_RANGOS_PREFIJOS_TO.NUM_VALOR_MINIMO%TYPE;
         IMSIR                                  VARCHAR2(19);
         RELLENA                                NUMBER(19);
         V_COD_PREFIJO          GSM_PREFIJO_TO.COD_PREFIJO%TYPE;
         SVALOR         NUMBER(19);
         SRELLENO               VARCHAR2(19);
         V_INTERVALO    NUMBER(19):=0 ;
         ILARGO                 NUMBER(19);
     V_PARAM_SALIDA VARCHAR2(2000) := '';
         V_PREFIJO1             VARCHAR2(11) := NULL;
         V_SIGUE                BOOLEAN;
         J                  NUMBER(19):=0;
         I                  NUMBER(19):=1;
         M                              NUMBER(19);
         VP_SQLCODE     VARCHAR2(100);
         VP_SQLERRM             VARCHAR2(100);
         V_PREFIJO_GENERADO NUMBER(3);
         VARIABLE      GSM_DET_SIMCARD_TO.VAL_CAMPO%TYPE;



--------------------------------------------------------------------------------------------
-- CURSOR : Recupera prefijos asociados
--------------------------------------------------------------------------------------------
                CURSOR DETALLE_PREFIJO IS
                SELECT COD_PREFIJO,
                       NUM_VALOR_MINIMO,
                   NUM_VALOR_MAXIMO
                FROM GSM_RANGOS_PREFIJOS_TO
                WHERE COD_PREFIJO = PREFIJOGENERADO
                AND   NUM_VALOR_INTERVALO <> 0
                ORDER BY NUM_VALOR_MINIMO;
---------------------------------------------------------------------------------------------
-- Validaci¢n  parametros de entrada
---------------------------------------------------------------------------------------------
BEGIN
        IF PREFIJOGENERADO IS NULL OR PREFIJOGENERADO = '' THEN
                    V_GLOSA_ERROR := 'ERROR INSERTA_IMSIR: Parametro de entrada, prefijo generado';
                        RAISE ERROR_PROCESO_GENERAL;
                        V_SIGUE:=FALSE;
        END IF;

        I:= RANGO_MIN;
        LOOP
                M := 0;
                SRELLENO := '0';
                VARIABLE := NULL;
                SVALOR := I;
                ILARGO := M_ILARGOIMSIR - LENGTH(M_SPREFIJOGENERADO);
            IF (ILARGO - LENGTH(SVALOR) > 0) THEN
                RELLENA := ILARGO - LENGTH(SVALOR);
                        LOOP
                            M := M + 1;
                                VARIABLE := VARIABLE || SRELLENO ;
                                EXIT WHEN M = RELLENA;
                        END LOOP;
                VARIABLE := VARIABLE || SVALOR ;
            ELSE
                VARIABLE := SVALOR;
            END IF;
                IMSIR := M_SPREFIJOGENERADO || VARIABLE;

                V_COD_PREFIJO := NULL;

                                BEGIN
                                                        SELECT B.COD_PREFIJO INTO   V_COD_PREFIJO
                                                        FROM   GSM_IMSIR_TO A, GSM_PREFIJO_TO B
                                                        WHERE  NUM_IMSIR = IMSIR AND    A.COD_PREFIJO = B.COD_PREFIJO;
                                                        EXCEPTION
                                                        WHEN NO_DATA_FOUND THEN
                                                                                        V_COD_PREFIJO := NULL;
                                END;

                                IF (V_COD_PREFIJO IS NULL OR V_COD_PREFIJO =  '') THEN
                                                BEGIN
                                                        INSERT INTO GSM_IMSIR_TO ( COD_PREFIJO,  NUM_IMSIR)
                                                        VALUES (PREFIJOGENERADO,        IMSIR);

                                                        EXCEPTION
                                                        WHEN OTHERS THEN
                                                                                V_RETORNO := 'ERROR AL INSERTAR EN GSM_IMSIR_TO ';
                                                                                RAISE  ERROR_PROCESO_GENERAL;

                                                END;
                                                Gsm_Rangos_Prefijos.INSERT_RANGOS_PREFIJO(PREFIJOGENERADO,I, I, I);
                                END IF;
                                EXIT WHEN I = RANGO_MAX;
                                I := I + 1;
        END LOOP;
---------------------------------------------------------------------------------------------
-- ORDENA PREFIJOS
---------------------------------------------------------------------------------------------
        V_MINIMO := -1;
    FOR K IN DETALLE_PREFIJO
        LOOP
            EXIT WHEN DETALLE_PREFIJO%NOTFOUND;
                    IF V_MINIMO = -1 THEN
                                Gsm_Rangos_Prefijos.DELETE_RANGOS_PREFIJO(PREFIJOGENERADO);
                    V_MINIMO := K.NUM_VALOR_MINIMO;
                    V_MAXIMO := K.NUM_VALOR_MAXIMO;
                ELSE
                    IF (K.NUM_VALOR_MINIMO - V_MAXIMO) = 1 THEN
                        V_MAXIMO := K.NUM_VALOR_MAXIMO;
                    ELSE
                                                IF V_MAXIMO IS NOT NULL THEN
                                                   Gsm_Rangos_Prefijos.INSERT_RANGOS_PREFIJO(PREFIJOGENERADO,V_MAXIMO, V_MINIMO, V_INTERVALO);
                                                END IF;
                        V_MINIMO := K.NUM_VALOR_MINIMO;
                        V_MAXIMO := K.NUM_VALOR_MAXIMO;
                    END IF;
                END IF;

         END LOOP;
                 IF V_MAXIMO IS NOT NULL THEN
                        Gsm_Rangos_Prefijos.INSERT_RANGOS_PREFIJO(PREFIJOGENERADO,V_MAXIMO, V_MINIMO, V_INTERVALO);
                 END IF;

    EXCEPTION
     WHEN ERROR_PROCESO_GENERAL THEN
                                                                RAISE_APPLICATION_ERROR (-20013,V_RETORNO);
     WHEN OTHERS THEN
                                                                RAISE_APPLICATION_ERROR (-20014,'INSERTA_IMSIR: '||'-'||SQLERRM,TRUE);
END INSERTA_IMSIR;

FUNCTION GENERADORARCHIVO (p_prefijo IN GSM_PREFIJO_TO.COD_PREFIJO%TYPE , p_total IN VARCHAR2, p_valor_minimo  IN VARCHAR2, v_num_solicitud IN GSM_CABSOL_SIMCARD_TO.NUM_SEQ_SOLICITUD%TYPE)  RETURN VARCHAR2
IS
/* ********************************************************************************************* */
/* Autor   : Maritza Tapia A                                                                                                                                     */
/* Fecha   : 30 Diciembre de 2003                                                                                                                                */
/* ********************************************************************************************* */
     Error_Proceso_General  EXCEPTION;
     V_GLOSA_ERROR              VARCHAR2(30);
         VP_SQLCODE     VARCHAR2(100);
         VP_SQLERRM             VARCHAR2(100);
         resultado      VARCHAR2(100);
         v_indice       NUMBER(2):=0 ;

BEGIN

           Gsm_Rangos_Prefijos.BUSCA_IMSIR(v_indice, p_prefijo, p_total, p_valor_minimo, v_num_solicitud, resultado);
           IF  resultado IS NULL OR resultado = '' THEN
                resultado := 'NAK';
           END IF;
           RETURN resultado;

    EXCEPTION
         WHEN Error_Proceso_General THEN
          RAISE_APPLICATION_ERROR (-20015,SQLERRM );

         WHEN OTHERS THEN
          RAISE_APPLICATION_ERROR (-20016,'ERRROR VALIDA_IMSI_IMSIR: '|| TO_CHAR(SQLCODE) ||' ' || SQLERRM);
END GENERADORARCHIVO;


FUNCTION GENERA_IMSIR (v_prefijo IN GSM_PREFIJO_TO.COD_PREFIJO%TYPE , v_total IN VARCHAR2, v_num_solicitud IN GSM_CABSOL_SIMCARD_TO.NUM_SEQ_SOLICITUD%TYPE)  RETURN VARCHAR2

IS
/* ********************************************************************************************* */
/* Autor   : Maritza Tapia A                                                                                                                                     */
/* Fecha   : 28 Noviembre de 2003                                                                                                                                */
/* ********************************************************************************************* */
     Error_Proceso_General  EXCEPTION;
     V_GLOSA_ERROR              VARCHAR2(30);
         VP_SQLCODE     VARCHAR2(100);
         VP_SQLERRM             VARCHAR2(100);
         v_paso                 NUMBER(18):=0 ;
         v_lenimsir     NUMBER(8):=0 ;
         v_indice       NUMBER(2):=1 ;
         v_valor_minimo NUMBER(18):=0 ;
         v_resultado    VARCHAR2(100);
         resultado      VARCHAR2(512);
         x_resultado      VARCHAR2(1024);
         v_cod_prefijo  GSM_PREFIJO_TO.COD_PREFIJO%TYPE;
         v_des_prefijo  GSM_PREFIJO_TO.NOM_PREFIJO%TYPE;

/* ********************************************************************************************* */
/*                          CURSOR PARA PREFIJO                                                                                                  */
/* ********************************************************************************************* */

        CURSOR  Prefijo (TN_total  GSM_RANGOS_PREFIJOS_TO.NUM_VALOR_INTERVALO%TYPE)   IS
        SELECT DISTINCT A.COD_PREFIJO AS Prefijo, A.NOM_PREFIJO AS nom_prefijo
        FROM GSM_PREFIJO_TO a, GSM_RANGOS_PREFIJOS_TO b
        WHERE A.COD_ESTADO = '1'
        AND A.cod_campo = 'IMSIR'
        AND a.COD_PREFIJO = b.COD_PREFIJO
        AND b.NUM_VALOR_INTERVALO >= TN_total;

BEGIN

/* ********************************************************************************************* */
/*  Valida                                                                                                                                                                               */
/* ********************************************************************************************* */

    BEGIN
                SELECT NUM_VALOR_MINIMO
                INTO  v_valor_minimo
                FROM GSM_RANGOS_PREFIJOS_TO
                WHERE NUM_VALOR_INTERVALO >= v_total
                AND COD_PREFIJO = v_prefijo
                ORDER BY NUM_VALOR_INTERVALO ASC;
        EXCEPTION
                WHEN OTHERS THEN
                        RAISE  Error_Proceso_General;
        END;


        FOR rReg IN Prefijo(v_total) LOOP
           v_cod_prefijo :=  rReg.Prefijo;
           v_des_prefijo :=  rReg.nom_prefijo;
           Gsm_Rangos_Prefijos.BUSCA_IMSIR(v_indice, v_cod_prefijo, v_total, v_valor_minimo, v_num_solicitud, v_resultado);
           IF (v_resultado = 'OK') THEN
                  resultado := resultado || v_cod_prefijo || '-' ||v_des_prefijo || '/' ;
           END IF;
        END LOOP;
        IF resultado IS NULL OR resultado = '' THEN
            resultado := 'NAK';
                RETURN    resultado;
        END IF;
    resultado := resultado || ';';
        RETURN  resultado;


    EXCEPTION
         WHEN Error_Proceso_General THEN
          RETURN    'NAK';
         WHEN OTHERS THEN
          RAISE_APPLICATION_ERROR (-20017,'ERRROR VALIDA_IMSI_IMSIR: '||LENGTH(resultado)); -- TO_CHAR(SQLCODE) ||' ' || SQLERRM );
END GENERA_IMSIR;

PROCEDURE BUSCA_IMSIR (p_ind IN NUMBER,
                                                                  p_prefijo IN GSM_PREFIJO_TO.COD_PREFIJO%TYPE ,
                                                                  p_total IN NUMBER,
                                                                  p_valor_minimo  IN VARCHAR2,
                                                                  p_num_solicitud IN GSM_CABSOL_SIMCARD_TO.NUM_SEQ_SOLICITUD%TYPE,
                                                                  resultado OUT VARCHAR2) IS
/* ********************************************************************************************* */
/* Autor   : Maritza Tapia A                                                                                                                                     */
/* Fecha   : 19 Noviembre de 2003                                                                                                                                */
/* ********************************************************************************************* */
     Error_Proceso_General  EXCEPTION;
     V_GLOSA_ERROR              VARCHAR2(30);
         VP_SQLCODE     VARCHAR2(100);
         VP_SQLERRM             VARCHAR2(100);
         v_valor_minimo NUMBER(18):=0;
         v_num_imsir    GSM_IMSIR_TO.NUM_IMSIR%TYPE;
         v_retorno      VARCHAR2(20);
         v_paso                 NUMBER(18):=0;
         v_total_tab    NUMBER(18):=0;
         v_largo                NUMBER(18):=0;
     v_lenght_minimo NUMBER(18):=0;
         v_posicion     NUMBER(18):=0;
         v_lenimsir     NUMBER(18):=0;
         v_lenprefijo   NUMBER(18):=0;
         valor_minimo   VARCHAR2(50):=0;
         prefijo        VARCHAR2(18);
         valor_campo    VARCHAR2(25);
         Largo_Prefijo  VARCHAR2(30);
         Flag           VARCHAR2(3);
         num_largo      NUMBER(10);
         cod_relleno    VARCHAR2(2);

/* ********************************************************************************************* */
/*                          CURSOR PARA GSM_IMSIR_TO                                                                                     */
/* ********************************************************************************************* */
        CURSOR  Imsir IS
        SELECT NUM_IMSIR
        FROM GSM_IMSIR_TO
        WHERE NUM_IMSIR LIKE valor_minimo
        AND   COD_ESTADO = 'N'
        AND   COD_PREFIJO = p_prefijo
        ORDER BY NUM_IMSIR ASC;

        CURSOR BuscaPrefijos IS
        SELECT A.NUM_VALOR_CAMPO AS NUM_VALOR_CAMPO , B.NUM_LARGO AS NUM_LARGO, B.COD_RELLENO AS COD_RELLENO
        FROM GSM_DEFINICION_PREFIJO_TO A, GSM_DOMINIOS_PREFIJOS_TD B
        WHERE A.COD_PREFIJO = p_prefijo
        AND B.COD_PARAMETRO = 'HEADER'
        AND A.COD_CAMPO = B.COD_CAMPO
        ORDER BY A.NUM_SEQ_ORDEN;


/* ********************************************************************************************* */
/*  Recupera el total de imsi que se deben validar rango incial y final                                                  */
/* ********************************************************************************************* */
BEGIN
   Flag := 'OK';

        /** RESCATO PARAMETRO PARA SABER EL LARGO DEL IMSIR*/
    BEGIN
                SELECT CAN_DIG_VALIDAR
                INTO  v_lenimsir
                FROM GSM_CABSOL_SIMCARD_TO
                WHERE NUM_SEQ_SOLICITUD = p_num_solicitud;
        EXCEPTION
                WHEN OTHERS THEN
                        v_retorno := 'No existe rango IMSIR ';
                        RAISE  Error_Proceso_General;
        END;

        BEGIN
                SELECT DES_PARAMETRO
                INTO   v_lenprefijo
                FROM GSM_PARAMETROS_TD
                WHERE COD_IDENTIFICADOR = 'LENPREFIJO'
                AND  COD_PARAMETRO = 'IMSIR';

        EXCEPTION
                WHEN OTHERS THEN
                        v_retorno := 'No existe rango IMSIR ';
                        RAISE  Error_Proceso_General;
        END;



/*** calculo del los numeros a validar ***/

        FOR rPrefijo IN BuscaPrefijos LOOP
                    prefijo     :=  rPrefijo.NUM_VALOR_CAMPO;
                    num_largo   :=  rPrefijo.NUM_LARGO;
                    cod_relleno :=  rPrefijo.COD_RELLENO;
                        IF (num_largo - LENGTH(prefijo) > 0) THEN
                            LOOP
                                EXIT WHEN LENGTH(cod_relleno) = LENGTH(prefijo);
                                            prefijo := cod_relleno || prefijo;
                                END LOOP;
                        END IF;
                    valor_campo := valor_campo || prefijo;
        END LOOP;

        IF LENGTH(p_valor_minimo) < v_lenimsir THEN
     valor_minimo := p_valor_minimo;
         LOOP
                EXIT WHEN LENGTH(valor_minimo) = v_lenimsir;
            valor_minimo := '0' || valor_minimo;
         END LOOP;
             v_posicion := (v_lenprefijo - LENGTH(valor_minimo));
                 valor_minimo := '%' || valor_minimo;

        ELSE
            v_largo := (LENGTH(p_valor_minimo) + 1 )-  v_lenimsir;
/*              v_valor_minimo := substr(p_valor_minimo, v_largo , v_lenimsir);*/
                v_posicion := (v_lenprefijo - v_lenimsir) ;
/*              valor_minimo := '%' || v_valor_minimo;*/
                valor_minimo := '%' || SUBSTR(p_valor_minimo, v_largo , v_lenimsir);
        END IF;
        valor_minimo := valor_campo || valor_minimo;

        Largo_Prefijo := LENGTH(valor_campo) +  v_lenimsir;
    IF Largo_prefijo > v_lenprefijo THEN
                                 Flag := 'NAK';
        END IF;

/* ********************************************************************************************* */
/*  Valida                                                                                                                                                                               */
/* ********************************************************************************************* */
    IF Flag = 'OK' THEN
                FOR rReg IN Imsir LOOP

                v_num_imsir :=  rReg.NUM_IMSIR;

                        BEGIN
                                SELECT COUNT(NUM_IMSIR) AS TERMINO
                                INTO   v_total_tab
                                FROM GSM_IMSIR_TO
                                WHERE NUM_IMSIR >= v_num_imsir
                                AND NUM_IMSIR <= v_num_imsir + (p_total - 1)
                                AND   COD_ESTADO = 'N'
                                ORDER BY NUM_IMSIR ASC;

                        EXCEPTION
                                WHEN OTHERS THEN
                                         v_retorno := 'No existe rango IMSIR ';
                             RAISE  Error_Proceso_General;
                        END;
                        IF (v_total_tab = p_total) THEN
                           IF (p_ind = 0) THEN
                              resultado := v_num_imsir;
                                  EXIT;
                           ELSE
                                   IF (p_ind = 1) THEN
                                     resultado := 'OK';
                                         EXIT;
                                   ELSE
                                         RAISE  Error_Proceso_General;
                                   END IF;
                           END IF;
                        END IF;
                END LOOP;
        END IF;
    EXCEPTION
         WHEN Error_Proceso_General THEN
          RAISE_APPLICATION_ERROR (-20018, v_retorno);
         WHEN OTHERS THEN
          RAISE_APPLICATION_ERROR (-20019,'ERRROR VALIDA_IMSI_IMSIR: '|| TO_CHAR(SQLCODE) ||' ' || SQLERRM);
END BUSCA_IMSIR;

PROCEDURE AL_BUSCA_DUPLICADOS_PR(en_numsol IN GSM_CABSOL_SIMCARD_TO.NUM_SEQ_SOLICITUD%TYPE)
IS
/*
<Documentación TipoDoc = "AL_BUSCA_DUPLICADOS_PR">
<Elemento Nombre = "AL_BUSCA_DUPLICADOS_PR" Lenguaje="PL/SQL" Fecha="26-06-2007" Versión="1.1.0" Diseñador="C.A.A.D." Programador="C.A.A.D." Ambiente="BD">
<Retorno>NA</Retorno>
<Descripción>Descripción</Descripción>
<Parámetros>
    <Entrada>
        <param nom="EN_NUMSOL" Tipo="STRING">NUMERO DE LA SOLICITUD RECIEN CREADA</param>
    </Entrada>
    <Salida>
    </Salida>
</Parámetros>
</Elemento>
</Documentación>
*/
     ln_cant         NUMBER(2):=0;
     lv_desde        gsm_simcard_to.num_simcard%TYPE;
     lv_hasta        gsm_simcard_to.num_simcard%TYPE;
     lv_glosa_error  VARCHAR2(36);

     CURSOR a_series (en_numsol gsm_simcard_to.num_seq_solicitud%TYPE) IS
     SELECT a.cod_campo imsi, a.val_campo num_imsi, b.cod_campo imsir, b.val_campo num_imsir
     FROM  gsm_det_simcard_to a, gsm_det_simcard_to b, gsm_simcard_to c
     WHERE NVL(a.cod_campo, a.cod_campo)  = 'IMSI'
     AND  NVL(b.cod_campo, b.cod_campo)  = 'IMSIR'
     AND a.num_simcard = c.num_simcard
     AND b.num_simcard = c.num_simcard
     AND c.num_seq_solicitud = en_numsol;
BEGIN

-- Inicio Incidencia 41852 Maria Lorena Rojo L. 26/06/2007
     FOR v_series IN a_series(en_numsol) LOOP

          ln_cant := 0;
          SELECT COUNT(1) INTO ln_cant
          FROM gsm_det_simcard_to
          WHERE val_campo = v_series.num_imsi
          AND cod_campo = v_series.imsi;

          IF ln_cant > 1 THEN
               lv_glosa_error := 'IMSI DIPLICADO ' || v_series.num_imsi;
               RAISE_APPLICATION_ERROR (-20023,'AL_BUSCA_DUPLICADOS_PR IMSI :' || v_series.num_imsi || ', YA ESTA GENERADO');
          END IF;

          SELECT COUNT(1) INTO ln_cant
          FROM gsm_det_simcard_to
          WHERE val_campo = v_series.num_imsir
          AND cod_campo = v_series.imsir;

          IF ln_cant > 1 THEN
               lv_glosa_error := 'IMSIR DIPLICADO ' || v_series.num_imsir;
               RAISE_APPLICATION_ERROR (-20023,'AL_BUSCA_DUPLICADOS_PR IMSIR :' || v_series.num_imsir || ', YA ESTA GENERADO');
          END IF;

     END LOOP;
-- Fin Incidencia 41852
END AL_BUSCA_DUPLICADOS_PR;


--XXXX COTE XXXX
-- PROCEDURE  ACTUALIZA_PREFIJOS (V_SOLICITUD IN GSM_CABSOL_SIMCARD_TO.NUM_SEQ_SOLICITUD%TYPE)
-- IS
--              ERROR_ACTUALIZA_PREFIJOS      EXCEPTION;
--              V_INTERVALO  GSM_RANGOS_PREFIJOS_TO.NUM_VALOR_INTERVALO%TYPE;
--              V_GLOSA_ERROR VARCHAR(128);
--              CURSOR  SOLICITUDES IS
--              SELECT COD_PREFIJO, NUM_VALOR_INICIAL, NUM_VALOR_FINAL
--              FROM GSM_RESERVA_RANGOS_PREFIJOS_TO
--              WHERE NUM_SEQ_SOLICITUD  = V_SOLICITUD;
-- BEGIN
--      V_GLOSA_ERROR:= 'PROBLEMA EN LA LECTURA DEL CURSOR';
--      FOR RegDatos IN SOLICITUDES LOOP
--              V_INTERVALO:= RegDatos.NUM_VALOR_FINAL - RegDatos.NUM_VALOR_INICIAL + 1;
--              Gsm_Rangos_Prefijos.INSERT_RANGOS_PREFIJO(RegDatos.COD_PREFIJO,
--                                                                                                                         RegDatos.NUM_VALOR_FINAL,
--                                                                                                                                                                                                                                 RegDatos.NUM_VALOR_INICIAL,
--                                                                                                                                                                                                                                 V_INTERVALO);
--      END LOOP;
--     EXCEPTION
--         WHEN ERROR_ACTUALIZA_PREFIJOS THEN
--           RAISE_APPLICATION_ERROR (-20020,'ACTUALIZA_PREFIJOS : ERROR_PROCESO_GENERAL ' ||V_GLOSA_ERROR );
--         WHEN NO_DATA_FOUND THEN
--                   RAISE_APPLICATION_ERROR (-20021,'ACTUALIZA_PREFIJOS  : ' || TO_CHAR(SQLCODE) || ' ' ||SQLERRM );
--         WHEN OTHERS THEN
--                   RAISE_APPLICATION_ERROR (-20022,'ACTUALIZA_PREFIJOS  : ' || TO_CHAR(SQLCODE) || ' ' ||SQLERRM );
-- END;


END Gsm_Rangos_Prefijos;
/
SHOW ERRORS
