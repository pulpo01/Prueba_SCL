CREATE OR REPLACE procedure PV_CAMBIOPLANSERV_PREPAGO
(
  VP_TRANSACCION                IN VARCHAR2 ,
  VP_ACTABO                             IN VARCHAR2 ,
  VP_PRODUCTO                   IN NUMBER ,
  VP_ABONADO                    IN NUMBER ,
  VP_CLIENTE                    IN NUMBER ,
  VP_COD_PLANSERV               IN VARCHAR2 ,
  VP_NUMIMSI                    IN VARCHAR2 )IS

-- Procedimiento de Actualizacion e Insercion de parametros en la tabla GA_INTARCEL
V_TRANSAC GA_TRANSACABO.NUM_TRANSACCION%TYPE;
V_IMP_LIMCONSUMO TA_LIMCONSUMO.IMP_LIMCONSUMO%TYPE;
V_COD_PLANCOM GA_CLIENTE_PCOM.COD_PLANCOM%TYPE;
V_FEC_DESDE GA_INTARCEL.FEC_DESDE%TYPE;
V_EXISTE_FECHA NUMBER;
V_FECSYS DATE;
V_ERROR VARCHAR2(1) := '0';
V_PROC VARCHAR2(50);
V_SQLCODE VARCHAR2(15);
V_SQLERRM VARCHAR2(70);
V_TABLA VARCHAR2(50);
V_ACT VARCHAR2(1);
ERROR_PROCESO EXCEPTION;
BEGIN

     V_TRANSAC := TO_NUMBER(VP_TRANSACCION);

         SELECT SYSDATE INTO V_FECSYS FROM DUAL;

         SELECT IMP_LIMCONSUMO INTO V_IMP_LIMCONSUMO
     FROM   TA_LIMCONSUMO
         WHERE  COD_PRODUCTO = 1
         AND    COD_LIMCONSUMO = '1';

         V_EXISTE_FECHA:=1;

         SELECT MAX(FEC_DESDE)
         INTO   V_FEC_DESDE
         FROM   GA_INTARCEL
         WHERE  COD_CLIENTE = VP_CLIENTE
         AND    NUM_ABONADO = VP_ABONADO;

         IF V_FEC_DESDE IS NULL THEN
                 V_EXISTE_FECHA:=0;
         END IF;

         -- ACTUALIZA
     IF V_EXISTE_FECHA=1 THEN
                UPDATE GA_INTARCEL
                SET    FEC_HASTA = SYSDATE
                WHERE  COD_CLIENTE = VP_CLIENTE
                AND    NUM_ABONADO = VP_ABONADO
                AND    FEC_DESDE   = V_FEC_DESDE;
     END IF;

         SELECT COD_PLANCOM INTO V_COD_PLANCOM
         FROM   GA_CLIENTE_PCOM
         WHERE  COD_CLIENTE = VP_CLIENTE
         AND    SYSDATE BETWEEN FEC_DESDE AND NVL(FEC_HASTA, SYSDATE)
         AND ROWNUM = 1;

         IF V_COD_PLANCOM IS NULL THEN
             RAISE ERROR_PROCESO;
         END IF;

         BEGIN
            INSERT INTO GA_INTARCEL
                        (COD_CLIENTE,NUM_ABONADO,IND_NUMERO,FEC_DESDE,FEC_HASTA,IMP_LIMCONSUMO,
                     IND_FRIENDS,IND_DIASESP,COD_CELDA,TIP_PLANTARIF,COD_PLANTARIF,NUM_SERIE,
                     NUM_CELULAR,COD_CARGOBASICO,COD_CICLO,COD_PLANCOM,COD_PLANSERV,COD_GRPSERV,
                                 COD_GRUPO,COD_PORTADOR,COD_USO,NUM_IMSI)
            SELECT   COD_CLIENTE,NUM_ABONADO,0 IND_NUMERO,SYSDATE FEC_DESDE,TO_DATE('31-12-3000','DD-MM-YYYY') FEC_HASTA,
                         V_IMP_LIMCONSUMO, 0 FRIENDS,0 IND_DIASESP,NVL(COD_CELDA,0),TIP_PLANTARIF,COD_PLANTARIF,NUM_SERIEHEX,
                     NUM_CELULAR,COD_CARGOBASICO,COD_CICLO,V_COD_PLANCOM,VP_COD_PLANSERV,NVL(COD_GRPSERV,0),COD_EMPRESA COD_GRUPO,
                                 NULL,COD_USO,VP_NUMIMSI
             FROM    GA_ABOAMIST
             WHERE   NUM_ABONADO = VP_ABONADO;
         EXCEPTION
                 WHEN OTHERS THEN
                         RAISE ERROR_PROCESO;
         END;


         BEGIN
                 UPDATE GA_ABOAMIST
                 SET    COD_PLANSERV=VP_COD_PLANSERV
                 WHERE  NUM_ABONADO = VP_ABONADO;
         EXCEPTION
             WHEN NO_DATA_FOUND THEN
                          RAISE ERROR_PROCESO;
         END;

         V_ERROR := '0';
         RAISE ERROR_PROCESO;

EXCEPTION
   WHEN ERROR_PROCESO THEN
        IF V_ERROR <> '0' THEN
           ROLLBACK;
           INSERT INTO GA_ERRORES
                      (COD_PRODUCTO,
                       COD_ACTABO,
                       CODIGO,
                       FEC_ERROR,
                       NOM_PROC,
                       NOM_TABLA,
                       COD_ACT,
                       COD_SQLCODE,
                       COD_SQLERRM)
               VALUES (VP_PRODUCTO,
                       VP_ACTABO,
                       VP_ABONADO,
                       V_FECSYS,
                       V_PROC,
                       V_TABLA,
                       V_ACT,
                       V_SQLCODE,
                       SUBSTR(V_SQLERRM,1,60));
           COMMIT;
           V_ERROR := 4;
        END IF;
        INSERT INTO GA_TRANSACABO (NUM_TRANSACCION,
                                   COD_RETORNO,
                                   DES_CADENA)
                           VALUES (V_TRANSAC,
                                   V_ERROR,
                                   NULL);
END;
/
SHOW ERRORS
