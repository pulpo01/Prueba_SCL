CREATE OR REPLACE PROCEDURE PV_INS_MOV_LIMCONS_PR (
EN_NUM_TRANSACCION    IN GA_TRANSACABO.NUM_TRANSACCION%TYPE,
ET_COD_CLIENTE        IN GA_ABOCEL.COD_CLIENTE%TYPE,
EN_LIMITE_NUEVO       IN NUMBER,
EV_USUARIO            IN VARCHAR2,
EV_BDATOS             IN VARCHAR2,
EV_MODULO             IN PV_IORSERV.COD_MODULO%TYPE,
EN_NumTar             IN VARCHAR2,
EV_COD_OOSS           IN VARCHAR2,
EN_COD_CICLO          IN GE_CLIENTES.COD_CLIENTE%TYPE,
EV_NUEVO_LC               IN TOL_LIMITE_TD.COD_LIMCONS%TYPE
)  IS
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_INS_MOV_LIMCONS_PR"
      Lenguaje="PL/SQL"
      Fecha creación="01-03-2007"
      Creado por="Gonzalo Salas Paillao"
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno> </Retorno>
      <Descripción>Evalucion pa hace Cambios de limite de consumo(Atlantida)</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="ET_COD_CLIENTE" Tipo="NUMBER"Codigo del cliente</param>
            <param nom="EN_LIMITE_NUEVO" Tipo="NUMBER"Nuevo limite</param>
            <param nom="EV_USUARIO" Tipo="VARCHAR2"Nombre de usuario </param>
            <param nom="EV_BDATOS" Tipo="VARCHAR2"Base de datos </param>
            <param nom="EV_MODULO" Tipo="VARCHAR2"Modulo gestor</param>
            <param nom="EN_NumTar" Tipo="NUMBER"Numero Tarea </param>
            <param nom="EV_COD_OOSS" Tipo="VARCHAR2"Numero de Orden de Servicio </param>;
         </Entrada>
         <Salida>
            <param nom="EV_StrError" Tipo="VARCHAR2"Contiene un string de salida </param>;
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
/*****************************************************************************/
   SV_LIMITEUSU      TOL_LIMITE_TD.IMP_LIMITE%TYPE;
   V_DIFERENCIA      NUMBER;
   V_SEQ             NUMBER;
   v_ValorAbono      number;
   v_num_celular     ga_abocel.num_celular%TYPE;
   v_TIP_PLANTARIF   ga_abocel.TIP_PLANTARIF%TYPE;
   v_COD_PLANTARIF   ga_abocel.COD_PLANTARIF%TYPE;
   v_COD_CUENTA      ga_abocel.COD_CUENTA%TYPE;
   v_COD_LIMCONS     ga_limite_cliabo_to.COD_LIMCONS%TYPE;
   v_FinCiclo        date;
   V_SYSDATE         DATE;
   V_FECHA_ICC           DATE;
   V_NUM_ABONADO     NUMBER;

   EV_StrError       GA_TRANSACABO.DES_CADENA%TYPE;
   EV_StrCodError    NUMBER;

   EN_EsAtlantida    NUMBER;

   v_valor           number;
   v_cod_retorno     GA_TRANSACABO.COD_RETORNO%TYPE;
   v_des_cadena      GA_TRANSACABO.DES_CADENA%TYPE;

   v_cod_actabo      ga_actabo.cod_actabo%TYPE;
   v_COD_ACTCEN      GA_ACTABO.COD_ACTABO%TYPE;
   CV_param_codactabo CONSTANT VARCHAR2(20) := 'CAMB_O_ABONO_LIM_CON';
   v_cod_tiplan      TA_PLANTARIF.cod_tiplan%TYPE;

   VN_NUM_TRANSACCION_TOL    GA_TRANSACABO.NUM_TRANSACCION%TYPE;
   VN_NUM_TRANSACCION_BATCH  GA_TRANSACABO.NUM_TRANSACCION%TYPE;

        LV_formatofec2                   ged_parametros.val_parametro%TYPE;
        LV_formatofec7                   ged_parametros.val_parametro%TYPE;
        LV_fecIngresoMov                 VARCHAR2(20);
        CN_cod_producto                  CONSTANT NUMBER(1):=1;

   ERROR_PROCESO EXCEPTION;

BEGIN

   V_SYSDATE := SYSDATE;

   EV_STRERROR := NULL;
   EV_STRCODERROR := 0;


   EN_ESATLANTIDA := PV_OBTIENEINFO_ATLANTIDA_PG.PV_CLIENTEESATLANTIDA_FN(ET_COD_CLIENTE);

   IF EN_ESATLANTIDA != 1 THEN
            EV_STRCODERROR := 0;
                EV_STRERROR := 'CLIENTE NO ES ATLÁNTIDA.';
        RAISE ERROR_PROCESO;
   END IF;

   BEGIN
           SELECT MIN(FEC_DESDELLAM)
           INTO   V_FINCICLO
           FROM   FA_CICLFACT
       WHERE  COD_CICLO = EN_COD_CICLO
       AND    SYSDATE <= FEC_DESDELLAM
       AND    IND_FACTURACION =0 ;
   EXCEPTION
       WHEN NO_DATA_FOUND THEN
                EV_STRERROR := 'Error al buscar próxima ciclo de facturacion.';
                        EV_STRCODERROR := 1;
                        RAISE ERROR_PROCESO;
           WHEN OTHERS THEN
                EV_STRERROR := 'Error: '||SUBSTR(SQLERRM,1,70);
                        EV_STRCODERROR := 1;
                        RAISE ERROR_PROCESO;
   END;

   IF V_FINCICLO IS NULL THEN
                EV_STRERROR := 'Error al buscar próxima ciclo de facturacion.';
                        EV_STRCODERROR := 2;
                        RAISE ERROR_PROCESO;
   END IF;

   V_NUM_CELULAR := 0;
   V_COD_CUENTA  := 0;
   V_NUM_ABONADO := 0;

   BEGIN
           SELECT NUM_ABONADO, NUM_CELULAR, COD_PLANTARIF
           INTO   V_NUM_ABONADO, V_NUM_CELULAR, V_COD_PLANTARIF
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
      SELECT C.COD_LIMCONS
      INTO   V_COD_LIMCONS
      FROM   GA_LIMITE_CLIABO_TO C
      WHERE  C.COD_CLIENTE = ET_COD_CLIENTE
          AND    C.NUM_ABONADO = 0
      AND    V_SYSDATE BETWEEN C.FEC_DESDE AND NVL(FEC_HASTA, V_SYSDATE);

           BEGIN
              SELECT A.IMP_LIMITE
              INTO   SV_LIMITEUSU --V_IMP_LIMITE ANTERIOR
              FROM TOL_LIMITE_TD A
              WHERE A.COD_LIMCONS = V_COD_LIMCONS
              AND V_SYSDATE BETWEEN A.FEC_DESDE AND NVL(A.FEC_HASTA, V_SYSDATE);
           EXCEPTION
              WHEN NO_DATA_FOUND THEN
                   EV_STRERROR := 'Error, No existe información Importe LC (TOL_LIMITE_TD).';
                           EV_STRCODERROR := 4;
                           RAISE ERROR_PROCESO;
              WHEN OTHERS THEN
                   EV_STRERROR := 'Error Obtención de Importe LC Cliente - '||SUBSTR(SQLERRM,1,70);
                           EV_STRCODERROR := 4;
                           RAISE ERROR_PROCESO;
           END;


   EXCEPTION
      WHEN NO_DATA_FOUND THEN
          --No existe limite de consumo configurado para el periodo actual --
           SV_LIMITEUSU := 0;
      WHEN OTHERS THEN
           EV_STRERROR := 'Error Obtención de LC Cliente - '||SUBSTR(SQLERRM,1,70);
                   EV_STRCODERROR := 3;
                   RAISE ERROR_PROCESO;
   END;

   IF EN_LIMITE_NUEVO = SV_LIMITEUSU THEN
            EV_StrCodError := 0;
                EV_StrError := 'NO HAY CAMBIO DE IMPORTE DE LC';
        RAISE ERROR_PROCESO;
   END IF;


        -- REVISION DE ABONOS EN EL PERIODO.
        BEGIN
          V_VALORABONO := PV_TOTALABONOSPERIODO_FN(ET_COD_CLIENTE, NULL);
        EXCEPTION
          WHEN OTHERS THEN
          EV_STRERROR := 'Error en PV_TOTALABONOSPERIODO_FN (PV_INS_MOV_LIMCONS_PR)'||SUBSTR(SQLERRM,1,70);
                  EV_StrCodError := 5;
                  RAISE ERROR_PROCESO;
        END;


        BEGIN
           SELECT COD_TIPLAN, TIP_PLANTARIF   INTO V_COD_TIPLAN, v_TIP_PLANTARIF
           FROM TA_PLANTARIF
           WHERE COD_PLANTARIF = V_COD_PLANTARIF;
        EXCEPTION
        WHEN NO_DATA_FOUND THEN
           EV_STRERROR := 'Error no existe plan tarifario.';
           EV_STRCODERROR := 6;
           RAISE ERROR_PROCESO;
        WHEN OTHERS THEN
           EV_STRERROR := 'Error en SELECT a TA_PLANTARIF ('||v_cod_plantarif||')- '||SUBSTR(SQLERRM,1,70);
           EV_STRCODERROR := 6;
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
           EV_STRCODERROR := 6;
           RAISE ERROR_PROCESO;
        WHEN OTHERS THEN
           EV_STRERROR := 'Error en SELECT a GA_PARAMETROS_SIMPLES_VW - '||SUBSTR(SQLERRM,1,70);
           EV_STRCODERROR := 6;
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
           EV_STRCODERROR := 6;
           RAISE ERROR_PROCESO;
        END;

        V_DIFERENCIA := EN_LIMITE_NUEVO - SV_LIMITEUSU;

    IF V_DIFERENCIA <= 0 THEN                   --  MOVIMIENTO A CICLO
           V_FECHA_ICC := v_FINCICLO;
           V_VALOR := 0;
        ELSE
           V_FECHA_ICC := SYSDATE;
           V_VALOR := V_DIFERENCIA - V_VALORABONO;  -- ABONO A INCLUIR EN SCL INMEDIATO.
        END IF;

        IF V_VALOR > 0 THEN

           SELECT GA_SEQ_TRANSACABO.NEXTVAL
           INTO   VN_NUM_TRANSACCION_TOL
           FROM   DUAL;

           PV_ABONO_LC_PR( VN_NUM_TRANSACCION_TOL , V_NUM_ABONADO, ET_COD_CLIENTE, V_VALOR);

           SELECT COD_RETORNO, DES_CADENA INTO V_COD_RETORNO, V_DES_CADENA
       FROM GA_TRANSACABO
           WHERE NUM_TRANSACCION = VN_NUM_TRANSACCION_TOL; --EN_NUM_TRANSACCION;

          IF V_COD_RETORNO <> 0 THEN
                EV_STRERROR := 'Error en PV_ABONO_LC_PR (PV_INS_MOV_LIMCONS_PR)'||SUBSTR(SQLERRM,1,70);
                EV_STRCODERROR := 7;
                RAISE ERROR_PROCESO;
          END IF;

        END IF;

    SELECT GA_SEQ_TRANSACABO.NEXTVAL
        INTO   VN_NUM_TRANSACCION_BATCH
        FROM   DUAL;
--
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

         LV_fecIngresoMov := TO_CHAR(V_FECHA_ICC ,LV_formatofec2 || ' ' || LV_formatofec7);

        PV_OOSS_BATCH_HIBRIDO_PG.PV_INSCRIBE_OOSS_PR(
        VN_NUM_TRANSACCION_BATCH,-- EN_TRANSACABO         IN  GA_TRANSACABO.NUM_TRANSACCION%TYPE,
        V_NUM_CELULAR,           -- EN_NUM_CELULAR        IN  NUMBER,
        EV_COD_OOSS ,            -- EV_COD_OOSS 10667
        EV_USUARIO,              -- EV_USUARIO            IN  VARCHAR2,
        V_NUM_ABONADO,           -- EN_NUM_ABONADO        IN  NUMBER,
        ET_COD_CLIENTE,          -- EN_COD_CLIENTE
        V_COD_ACTABO,            -- EV_COD_ACTABO         IN  GA_ACTABO.COD_ACTABO%TYPE,
        EV_BDATOS,               -- EV_BDATOS             IN  VARCHAR2,
        V_TIP_PLANTARIF,         -- EV_TIP_PLANTARIF      IN  PV_PARAM_ABOCEL.TIP_PLANTARIF%TYPE,
        V_COD_PLANTARIF,         -- EV_COD_PLANTARIF      IN  PV_PARAM_ABOCEL.COD_PLANTARIF%TYPE,
        0,                       -- EN_NUM_VENTA          IN  PV_CAMCOM.NUM_VENTA%TYPE,
        V_COD_CUENTA,            -- EN_COD_CUENTA         IN  PV_CAMCOM.COD_CUENTA%TYPE,
        LV_fecIngresoMov, --V_FECHA_ICC,             -- ED_FECPROG
        EN_LIMITE_NUEVO,         -- CARGA                 IN  PV_MOVIMIENTO.CARGA%TYPE,

        --INI. 41837 pagc 03-07-2007
        --'TO',                    -- EV_TSUBJETO           IN  PV_IORSERV.TIP_SUBSUJETO%TYPE,
        NULL,
        --'C',                     -- EV_SUJETO             IN  PV_IORSERV.TIP_SUJETO%TYPE,
        'A',
        --FIN

        EV_MODULO,               -- EV_MODULO             IN  PV_IORSERV.COD_MODULO%TYPE,
        nvl(EN_NUMTAR,0)         -- EN_NUMTAR             IN  PV_IORSERV.ID_GESTOR%TYPE
        );

    BEGIN
                SELECT COD_RETORNO INTO V_COD_RETORNO
                FROM GA_TRANSACABO
                WHERE NUM_TRANSACCION = VN_NUM_TRANSACCION_BATCH;
                IF V_COD_RETORNO <> 0 THEN
                          EV_STRERROR := 'Error en pv_ooss_batch_hibrido_pg.PV_INSCRIBE_OOSS_PR'||SUBSTR(SQLERRM,1,70);
                          EV_STRCODERROR := 8;
                          RAISE ERROR_PROCESO;
                END IF;
        EXCEPTION
                WHEN NO_DATA_FOUND THEN
                  EV_STRERROR := 'ndf-Error en PV_INS_MOV_LIMCONS_PR (PV_INSCRIBE_OOSS_PR) - '||SUBSTR(SQLERRM,1,70);
                  EV_STRCODERROR := 9;
                  RAISE ERROR_PROCESO;
                WHEN OTHERS THEN
                  EV_STRERROR := 'ot-Error en PV_INS_MOV_LIMCONS_PR (PV_INSCRIBE_OOSS_PR) - '||SUBSTR(SQLERRM,1,70);
                  EV_STRCODERROR := 9;
                  RAISE ERROR_PROCESO;
        END;

    RAISE ERROR_PROCESO;

EXCEPTION
   WHEN ERROR_PROCESO THEN
        INSERT INTO GA_TRANSACABO (NUM_TRANSACCION,
                                   COD_RETORNO,
                                   DES_CADENA)
                           VALUES (EN_NUM_TRANSACCION,
                                   EV_STRCODERROR,
                                   EV_STRERROR);

END PV_INS_MOV_LIMCONS_PR;
/
SHOW ERRORS
