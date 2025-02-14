CREATE OR REPLACE PROCEDURE PV_INS_MOV_ABOLIMCONS_PR (
EN_NUM_TRANSACCION IN GA_TRANSACABO.NUM_TRANSACCION%TYPE,
ET_COD_CLIENTE     IN GA_ABOCEL.COD_CLIENTE%TYPE,
EN_ABONO           IN NUMBER,
EV_USUARIO         IN VARCHAR2,
EV_BDATOS          IN VARCHAR2,
EV_MODULO          IN PV_IORSERV.COD_MODULO%TYPE,
EN_NUMTAR          IN VARCHAR2,
EV_COD_OOSS        IN VARCHAR2,
EN_ABONADO         IN GA_ABOCEL.NUM_ABONADO%TYPE
)  IS
/*
<DOCUMENTACIóN
  TIPODOC = "Procedimiento">
   <ELEMENTO
      NOMBRE = "PV_INS_MOV_LIMCONS_PR"
      LENGUAJE="PL/SQL"
      FECHA CREACIóN="01-03-2007"
      CREADO POR="Gonzalo Salas Paillao"
      FECHA MODIFICACION=""
      MODIFICADO POR=""
      AMBIENTE DESARROLLO="BD">
      <RETORNO> </RETORNO>
      <DESCRIPCIóN>EVALUCION PA HACE CAMBIOS DE LIMITE DE CONSUMO(ATLANTIDA)</DESCRIPCIóN>
      <PARáMETROS>
         <ENTRADA>
            <PARAM NOM="ET_COD_CLIENTE" TIPO="NUMBER"CODIGO DEL CLIENTE</PARAM>
            <PARAM NOM="EN_LIMITE_NUEVO" TIPO="NUMBER"NUEVO LIMITE</PARAM>
            <PARAM NOM="EV_USUARIO" TIPO="VARCHAR2"NOMBRE DE USUARIO </PARAM>
            <PARAM NOM="EV_BDATOS" TIPO="VARCHAR2"BASE DE DATOS </PARAM>
            <PARAM NOM="EV_MODULO" TIPO="VARCHAR2"MODULO GESTOR</PARAM>
            <PARAM NOM="EN_NumTar" TIPO="NUMBER"NUMERO TAREA </PARAM>
         </ENTRADA>
         <SALIDA>
         </SALIDA>
      </PARáMETROS>
   </ELEMENTO>
</DOCUMENTACIóN>
*/
/*****************************************************************************/
   SV_LIMITEUSU                       TOL_LIMITE_TD.IMP_LIMITE%TYPE;
   V_DIFERENCIA                       NUMBER;
   V_SEQ                              NUMBER;
   V_VALORABONO                       NUMBER;
   V_NUM_CELULAR                      GA_ABOCEL.NUM_CELULAR%TYPE;
   V_TIP_PLANTARIF                    GA_ABOCEL.TIP_PLANTARIF%TYPE;
   V_COD_PLANTARIF                    GA_ABOCEL.COD_PLANTARIF%TYPE;
   V_COD_CUENTA                       GA_ABOCEL.COD_CUENTA%TYPE;
   V_COD_LIMCONS                      GA_LIMITE_CLIABO_TO.COD_LIMCONS%TYPE;
--    V_FINCICLO        DATE;
   V_FECHA_ICC                        DATE;
   V_NUM_ABONADO                      NUMBER;

   EV_STRERROR                        GA_TRANSACABO.DES_CADENA%TYPE;
   EV_STRCODERROR                     NUMBER;

   V_COD_RETORNO                      GA_TRANSACABO.COD_RETORNO%TYPE;
   V_DES_CADENA                       GA_TRANSACABO.DES_CADENA%TYPE;

   V_COD_ACTABO                       GA_ACTABO.COD_ACTABO%TYPE;
   V_COD_ACTCEN                       GA_ACTABO.COD_ACTABO%TYPE;
   CV_PARAM_CODACTABO                 CONSTANT VARCHAR2(20) := 'CAMB_O_ABONO_LIM_CON';
   V_COD_TIPLAN                       TA_PLANTARIF.COD_TIPLAN%TYPE;

   VN_NUM_TRANSACCION_TOL             GA_TRANSACABO.NUM_TRANSACCION%TYPE;
   VN_NUM_TRANSACCION_BATCH           GA_TRANSACABO.NUM_TRANSACCION%TYPE;

   V_VALOR                            NUMBER;

   V_SYSDATE                          DATE;

   EN_EsAtlantida                     NUMBER;

        LV_formatofec2                   ged_parametros.val_parametro%TYPE;
        LV_formatofec7                   ged_parametros.val_parametro%TYPE;
        LV_fecIngresoMov                 VARCHAR2(20);
        CN_cod_producto                  CONSTANT NUMBER(1):=1;

   ERROR_PROCESO EXCEPTION;


BEGIN

   EV_STRERROR       := '';
   EV_STRCODERROR    := 0;
   V_NUM_ABONADO     := EN_ABONADO;
   V_SYSDATE := SYSDATE;


   IF NVL(EN_ABONO,0) = 0 THEN
            EV_STRCODERROR := 0;
                EV_STRERROR := 'ABONO VALOR 0 ES INCORRECTO.';
        RAISE ERROR_PROCESO;
   END IF;

   SELECT GA_SEQ_TRANSACABO.NEXTVAL INTO  VN_NUM_TRANSACCION_TOL  FROM   DUAL;

   -- REVISION DE ABONOS EN EL PERIODO.
   V_VALORABONO := PV_TOTALABONOSPERIODO_FN(ET_COD_CLIENTE, NULL);

   PV_ABONO_LC_PR( VN_NUM_TRANSACCION_TOL , V_NUM_ABONADO, ET_COD_CLIENTE, EN_ABONO);

   SELECT COD_RETORNO, DES_CADENA
   INTO   V_COD_RETORNO, V_DES_CADENA
   FROM   GA_TRANSACABO
   WHERE  NUM_TRANSACCION = VN_NUM_TRANSACCION_TOL;

   IF V_COD_RETORNO <> 0 THEN
                EV_STRERROR := 'Error en PV_ABONO_LC_PR (PV_INS_MOV_LIMCONS_PR)'||SUBSTR(SQLERRM,1,70);
                EV_STRCODERROR := 6;
                RAISE ERROR_PROCESO;
   END IF;

   IF V_NUM_ABONADO != 0 THEN
            EV_STRCODERROR := 0;
                EV_STRERROR := 'LC a nivel de Abonado.';
        RAISE ERROR_PROCESO;
   END IF;


   EN_ESATLANTIDA := PV_OBTIENEINFO_ATLANTIDA_PG.PV_CLIENTEESATLANTIDA_FN(ET_COD_CLIENTE);

   IF EN_ESATLANTIDA != 1 THEN
            EV_STRCODERROR := 0;
                EV_STRERROR := 'CLIENTE NO ES ATLÁNTIDA.';
        RAISE ERROR_PROCESO;
   END IF;

   V_NUM_CELULAR := 0;
   V_COD_CUENTA  := 0;
   V_NUM_ABONADO := 0;

   BEGIN
           SELECT NUM_ABONADO, NUM_CELULAR
           INTO   V_NUM_ABONADO, V_NUM_CELULAR
           FROM   GA_ABOCEL
           WHERE  COD_CLIENTE = ET_COD_CLIENTE
           AND    COD_SITUACION = 'AAA'
           AND    ROWNUM = 1;
   EXCEPTION
       WHEN NO_DATA_FOUND THEN
                EV_STRERROR := 'Error al buscar abonado.';
                        EV_STRCODERROR := 1;
                        RAISE ERROR_PROCESO;
           WHEN OTHERS THEN
                EV_STRERROR := 'Error: '||SUBSTR(SQLERRM,1,70);
                        EV_STRCODERROR := 1;
                        RAISE ERROR_PROCESO;
   END;

   BEGIN
      SELECT C.COD_PLANTARIF, C.COD_LIMCONS
      INTO   V_COD_PLANTARIF, V_COD_LIMCONS
      FROM   GA_LIMITE_CLIABO_TO C
      WHERE  C.COD_CLIENTE = ET_COD_CLIENTE
          AND    C.NUM_ABONADO = 0
      AND    SYSDATE BETWEEN C.FEC_DESDE AND NVL(FEC_HASTA, SYSDATE);
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
           EV_STRERROR := 'Error, No existe información de LC (GA_LIMITE_CLIABO_TO).';
                   EV_STRCODERROR := 1;
                   RAISE ERROR_PROCESO;
      WHEN OTHERS THEN
           EV_STRERROR := 'Error Obtención de LC Cliente - '||SUBSTR(SQLERRM,1,70);
                   EV_STRCODERROR := 1;
                   RAISE ERROR_PROCESO;
   END;

   BEGIN
      SELECT A.IMP_LIMITE
      INTO   SV_LIMITEUSU --V_IMP_LIMITE ANTERIOR
      FROM   TOL_LIMITE_TD A
      WHERE  A.COD_LIMCONS = V_COD_LIMCONS
      AND    V_SYSDATE BETWEEN A.FEC_DESDE AND NVL(A.FEC_HASTA, V_SYSDATE);
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
           EV_STRERROR := 'Error, No existe información Importe LC (TOL_LIMITE_TD).';
                   EV_STRCODERROR := 2;
                   RAISE ERROR_PROCESO;
      WHEN OTHERS THEN
           EV_STRERROR := 'Error Obtención de Importe LC Cliente - '||SUBSTR(SQLERRM,1,70);
                   EV_STRCODERROR := 2;
                   RAISE ERROR_PROCESO;
   END;


   -- OBTENCION DE COD_ACTABO...
        BEGIN
           SELECT COD_TIPLAN, TIP_PLANTARIF INTO V_COD_TIPLAN, v_TIP_PLANTARIF
           FROM TA_PLANTARIF
           WHERE COD_PLANTARIF = V_COD_PLANTARIF;
        EXCEPTION
        WHEN NO_DATA_FOUND THEN
           EV_STRERROR := 'Error no existe plan tarifario.';
           EV_STRCODERROR := 3;
           RAISE ERROR_PROCESO;
        WHEN OTHERS THEN
           EV_STRERROR := 'Error en SELECT a TA_PLANTARIF - '||SUBSTR(SQLERRM,1,70);
           EV_STRCODERROR := 3;
           RAISE ERROR_PROCESO;
        END;

        BEGIN
           SELECT A.VALOR_TEXTO   INTO V_COD_ACTABO
           FROM GA_PARAMETROS_SIMPLES_VW A
           WHERE A.NOM_PARAMETRO = CV_PARAM_CODACTABO;
/* Linea temporalmente comentada.. solo para pruebas
           AND A. COD_OPERADORA = GE_FN_OPERADORA_SCL();
*/
        EXCEPTION
        WHEN NO_DATA_FOUND THEN
           EV_STRERROR := 'Error NO EXISTE PARAMETRO GA_PARAMETROS_SIMPLES_VW - '||CV_PARAM_CODACTABO;
           EV_STRCODERROR := 4;
           RAISE ERROR_PROCESO;
        WHEN OTHERS THEN
           EV_STRERROR := 'Error en SELECT a GA_PARAMETROS_SIMPLES_VW - '||SUBSTR(SQLERRM,1,70);
           EV_STRCODERROR := 4;
           RAISE ERROR_PROCESO;
        END;

        BEGIN
           SELECT COD_ACTABO   INTO V_COD_ACTABO
           FROM   PV_ACTABO_TIPLAN
           WHERE  COD_TIPMODI = V_COD_ACTABO
           AND    COD_TIPLAN = V_COD_TIPLAN;
        EXCEPTION
        WHEN NO_DATA_FOUND THEN
             V_COD_ACTABO := V_COD_ACTABO;
        WHEN OTHERS THEN
           EV_STRERROR := 'Error PV_ACTABO_TIPLAN - '||SUBSTR(SQLERRM,1,70);
           EV_STRCODERROR := 5;
           RAISE ERROR_PROCESO;
        END;

------------------

      V_VALORABONO := V_VALORABONO + EN_ABONO + SV_LIMITEUSU; -- ABONOS PERÍODO + ABONO ACTUAL + IMPORTE LC ACTUAL CLIENTE

          BEGIN

                 SELECT GA_SEQ_TRANSACABO.NEXTVAL
                 INTO   VN_NUM_TRANSACCION_BATCH
             FROM   DUAL;

         SELECT val_parametro INTO LV_formatofec2
         FROM ged_parametros
         WHERE cod_producto = CN_cod_producto
         AND cod_modulo = 'GE'
         AND nom_parametro = 'FORMATO_SEL2';

         SELECT val_parametro INTO LV_formatofec7
         FROM ged_parametros
         WHERE cod_producto = CN_cod_producto
         AND cod_modulo = 'GE'
         AND nom_parametro = 'FORMATO_SEL7';

         LV_fecIngresoMov := TO_CHAR(V_SYSDATE ,LV_formatofec2 || ' ' || LV_formatofec7);

--
      --  ENVIO DE MOVIMIENTO A CENTRAL PARA ACTUALIZACION INMEDIATA.
         PV_OOSS_BATCH_HIBRIDO_PG.PV_INSCRIBE_OOSS_PR(
         VN_NUM_TRANSACCION_BATCH,    -- EN_TRANSACABO         IN  GA_TRANSACABO.NUM_TRANSACCION%TYPE,
         V_NUM_CELULAR,         -- EN_NUM_CELULAR        IN  NUMBER,
         EV_COD_OOSS,           -- EV_COD_OOSS -- 10669...
         EV_USUARIO,            -- EV_USUARIO            IN  VARCHAR2,
         V_NUM_ABONADO,         -- EN_NUM_ABONADO        IN  NUMBER,
         ET_COD_CLIENTE,        -- EN_COD_CLIENTE
         V_COD_ACTABO,          -- EV_COD_ACTABO           IN  GA_ACTABO.COD_ACTABO%TYPE, -- 1157...
         EV_BDATOS,             -- EV_BDATOS             IN  VARCHAR2,
         V_TIP_PLANTARIF,       -- EV_TIP_PLANTARIF      IN  PV_PARAM_ABOCEL.TIP_PLANTARIF%TYPE,
         V_COD_PLANTARIF,       -- EV_COD_PLANTARIF      IN  PV_PARAM_ABOCEL.COD_PLANTARIF%TYPE,
         0,                     -- EN_NUM_VENTA          IN  PV_CAMCOM.NUM_VENTA%TYPE,
         V_COD_CUENTA,          -- EN_COD_CUENTA         IN  PV_CAMCOM.COD_CUENTA%TYPE,
         LV_fecIngresoMov, ---V_SYSDATE,             -- ED_FECPROG
         V_VALORABONO,          -- CARGA                 IN  PV_MOVIMIENTO.CARGA%TYPE,
         null,                  -- EV_TSUBJETO           IN  PV_IORSERV.TIP_SUBSUJETO%TYPE,
                 --INI 41837 pagc 03-07-2007
         --'C',                  -- EV_SUJETO             IN  PV_IORSERV.TIP_SUJETO%TYPE,
                 'A',
                 --fin
                 EV_MODULO,             -- EV_MODULO             IN  PV_IORSERV.COD_MODULO%TYPE,
         nvl(EN_NUMTAR,0)       -- EN_NUMTAR             IN  PV_IORSERV.ID_GESTOR%TYPE
         );

         SELECT COD_RETORNO INTO V_COD_RETORNO
         FROM GA_TRANSACABO
         WHERE NUM_TRANSACCION = VN_NUM_TRANSACCION_BATCH;

         IF V_COD_RETORNO <> 0 THEN
                    EV_STRERROR := 'Error en pv_ooss_batch_hibrido_pg.PV_INSCRIBE_OOSS_PR'||SUBSTR(SQLERRM,1,70);
                        EV_STRCODERROR := 7;
                        RAISE ERROR_PROCESO;
         END IF;

       EXCEPTION
         WHEN NO_DATA_FOUND THEN
            EV_STRERROR := 'ndf-Error en PV_INS_MOV_ABOCONS_PR (PV_INSCRIBE_OOSS_PR) - '||SUBSTR(SQLERRM,1,70);
                        EV_STRCODERROR := 7;
                        RAISE ERROR_PROCESO;
         WHEN OTHERS THEN
            EV_STRERROR := 'o-Error en PV_INS_MOV_ABOCONS_PR (PV_INSCRIBE_OOSS_PR) - '||SUBSTR(SQLERRM,1,70);
                        EV_STRCODERROR := 8;
                        RAISE ERROR_PROCESO;
       END;

       RAISE ERROR_PROCESO;

EXCEPTION
   WHEN ERROR_PROCESO THEN
      IF EV_STRCODERROR <> '0' THEN
          ROLLBACK;
      END IF;

      INSERT INTO GA_TRANSACABO (NUM_TRANSACCION,
                                COD_RETORNO,
                                DES_CADENA)
                         VALUES (EN_NUM_TRANSACCION,
                                 EV_STRCODERROR,
                                 EV_STRERROR);
END PV_INS_MOV_ABOLIMCONS_PR;
/
SHOW ERRORS
