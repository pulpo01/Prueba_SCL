CREATE OR REPLACE PACKAGE BODY PV_PROCESO_PG IS

 PROCEDURE PV_ACTUALIZA_BAJA_ALTA_SS_PR
 (
   VP_PRODUCTO IN NUMBER ,
   VP_ABONADO  IN NUMBER ,
   VP_CLASEABO IN VARCHAR2)
 IS
 --
 --
 --
 --
    V_PROCED         VARCHAR2(30) := NULL;
    V_CLASESERVICIO  GA_ABOCEL.CLASE_SERVICIO%TYPE;
    V_SERVNIVEL      VARCHAR2(6);
    V_SERVSUPL       GA_SERVSUPLABO.COD_SERVSUPL%TYPE;
    V_NIVEL          GA_SERVSUPLABO.COD_NIVEL%TYPE;

    LV_CodOS          pv_iorserv.cod_os%type; --codigo de la ooss
    LV_COUNT_AUX      NUMBER;
    n_ciclo           ga_abocel.cod_ciclo%type;
    LV_FECHA_BAJA     varchar2(25);
    LV_FECHA_ALTA     varchar2(25);

 BEGIN
       BEGIN

          V_PROCED := 'PV_ACTUALIZA_BAJA_ALTA_SS_PR';
              
          SELECT B.COD_OS INTO LV_CodOS
          FROM PV_CAMCOM A, PV_IORSERV B, PV_MOVIMIENTOS C
          WHERE A.NUM_ABONADO = VP_ABONADO
          AND C.COD_SERVICIO = VP_CLASEABO
          AND A.NUM_OS = C.NUM_OS
          AND A.NUM_OS = (SELECT MAX(D.NUM_OS) FROM PV_MOVIMIENTOS D WHERE D.NUM_OS = A.NUM_OS AND D.COD_SERVICIO = VP_CLASEABO)
          AND B.NUM_OS = A.NUM_OS;

       EXCEPTION
          WHEN NO_DATA_FOUND THEN
               LV_CodOS := '-1';
       END;

       LV_COUNT_AUX := 0;
       SELECT COUNT(1) INTO LV_COUNT_AUX
       FROM   GED_CODIGOS
       WHERE  COD_MODULO  = 'GA'
       AND    NOM_TABLA   = 'PV_CONVERSION_SERVSUP_TD'
       AND    NOM_COLUMNA = 'NOM_USUARIO'
       AND    COD_VALOR  IN (LV_CodOS);

       IF (LV_COUNT_AUX = 1) THEN
          BEGIN
             SELECT a.cod_ciclo
             INTO   n_ciclo
             FROM   GA_ABOCEL a
             WHERE  a.NUM_ABONADO = VP_ABONADO;
             EXCEPTION
                 WHEN NO_DATA_FOUND THEN
                      n_ciclo := -1;
          END;

          BEGIN
             SELECT TO_CHAR(FEC_DESDELLAM-1/86400,'DD-MM-YYYY HH24:MI:SS')  ,TO_CHAR(FEC_DESDELLAM,'DD-MM-YYYY')
             INTO   LV_FECHA_BAJA, LV_FECHA_ALTA
             FROM   FA_CICLFACT
             WHERE  COD_CICLO = n_ciclo
             AND    SYSDATE BETWEEN FEC_DESDELLAM AND FEC_HASTALLAM;
             EXCEPTION
                 WHEN NO_DATA_FOUND THEN
                     LV_FECHA_BAJA := '-1';
                     LV_FECHA_ALTA := '-1';
          END;

          IF (LV_FECHA_BAJA != '-1' AND LV_FECHA_ALTA != '-1' AND LV_FECHA_BAJA IS NOT NULL AND LV_FECHA_ALTA IS NOT NULL) THEN
              V_CLASESERVICIO := VP_CLASEABO;
              LOOP
                 V_SERVNIVEL := SUBSTR (V_CLASESERVICIO, 1, 6);
                 EXIT WHEN V_SERVNIVEL IS NULL;
                 V_CLASESERVICIO := SUBSTR(V_CLASESERVICIO, INSTR(V_CLASESERVICIO, V_SERVNIVEL) + 6);
                 V_SERVSUPL := SUBSTR(V_SERVNIVEL,1,2);
                 V_NIVEL    := SUBSTR(V_SERVNIVEL,3,4);
                 IF V_NIVEL <> 0 THEN
                    -- ACTUALIZA FECHA DE ALTA SERVICIO NUEVO A CICLO
                    UPDATE GA_SERVSUPLABO
                    SET FEC_ALTABD  = TO_DATE(LV_FECHA_ALTA, 'DD-MM-YYYY HH24:MI:SS')
                      , FEC_BAJABD  = NULL
                      , FEC_BAJACEN = NULL
                    WHERE NUM_ABONADO = VP_ABONADO
                    AND  COD_SERVSUPL = V_SERVSUPL
                    AND  COD_NIVEL    = V_NIVEL
                    AND  IND_ESTADO   in (1, 2);
                 ELSE
                    -- ACTUALIZA FECHA DE BAJA SERVICIO A CICLO
                    UPDATE GA_SERVSUPLABO
                    SET FEC_BAJABD = TO_DATE(LV_FECHA_BAJA, 'DD-MM-YYYY HH24:MI:SS')
                    WHERE NUM_ABONADO   = VP_ABONADO
                    AND   COD_SERVSUPL  = V_SERVSUPL
                    AND   COD_NIVEL    <> V_NIVEL
                    AND   FEC_BAJABD    > TO_DATE(LV_FECHA_BAJA, 'DD-MM-YYYY HH24:MI:SS')
                    AND   IND_ESTADO   in (3, 4);
                 END IF;
              END LOOP;
          END IF;     
       END IF;
 EXCEPTION
    WHEN OTHERS THEN
          RAISE_APPLICATION_ERROR (-20205,V_PROCED||' '||SQLERRM);

 END PV_ACTUALIZA_BAJA_ALTA_SS_PR;

END PV_PROCESO_PG; 
/
SHOW ERRORS
