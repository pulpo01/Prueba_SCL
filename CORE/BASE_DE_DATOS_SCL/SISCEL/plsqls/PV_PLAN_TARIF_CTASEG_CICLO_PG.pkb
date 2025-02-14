CREATE OR REPLACE PACKAGE BODY PV_PLAN_TARIF_CTASEG_CICLO_PG AS

--PV_PLAN_TARIF_CTASEG_CICLO_PG v1.0 //CREACION POR PROYECTO CPU
--PV_PLAN_TARIF_CTASEG_CICLO_PG v1.1 //RRG 04-12-2008  72899 COL - CPU
--PV_PLAN_TARIF_CTASEG_CICLO_PG v1.2 //COL-72899|09-12-2008|GEZ
--PV_PLAN_TARIF_CTASEG_CICLO_PG v1.3 //COL-72899|23-12-2008|SAQL-EV-PMY
--PV_PLAN_TARIF_CTASEG_CICLO_PG v1.4 //COL-75957|19-01-2009|GEZ
--PV_PLAN_TARIF_CTASEG_CICLO_PG v1.5 -- COL 77090|02-02-2009|SAQL

PROCEDURE PV_ACT_CAMB_COMERC_CICLO_PR
(
    pnCodCliente IN NUMBER,
    pnNumAbonado IN NUMBER,
    pnIndNumeracion IN NUMBER,
    pvCodActabo IN VARCHAR2,
    pdFecDesde IN DATE,
    pv_cod_plantarif IN VARCHAR2,
    pvErrorAplic OUT VARCHAR2,
    pvErrorGlosa OUT VARCHAR2,
    pvErrorOra OUT VARCHAR2,
    pvErrorOraGlosa OUT VARCHAR2,
    pvTrace OUT VARCHAR2)
IS
-- PL/SQL Specification
--
-- *************************************************************
-- * procedimiento      : PV_ACTUALIZA_CAMB_COMERC_CICLO_PR
-- * Descripcion        : Informa al tazador online sobre cambios producidos en
-- *                      los planes tarifarios.
-- * Fecha de creacion  : 01-09-2008 11:00
-- * Responsable        : Area Postventa (*)
-- *************************************************************
--
    wl_cod_tiplan    TA_PLANTARIF.TIP_PLANTARIF%TYPE;

BEGIN
    pvErrorAplic := 'TRUE';
    pvErrorGlosa := ' ';
    pvErrorOra := ' ';
    pvErrorOraGlosa := ' ';
    pvTrace := ' ';

    if pnNumAbonado<>0 then

        SELECT cod_tiplan
        INTO   wl_cod_tiplan
        FROM   ta_plantarif a
        WHERE  a.cod_producto = 1
               AND a.cod_plantarif = pv_cod_plantarif;

        IF (GE_FN_DEVVALPARAM('GA', 1, 'IND_TOL') = 'S') AND
           (GE_FN_DEVVALPARAM('GA', 1, 'TIPOHIBRIDO') <> wl_cod_tiplan)
        THEN
            INSERT INTO GA_INTARCEL_ACCIONES_TO
                (
                 COD_CLIENTE,
                 NUM_ABONADO,
                 IND_NUMERO,
                 FEC_DESDE,
                 COD_ACTABO,
                 NOM_USUARORA,
                 FEC_INGRESO
                )
            VALUES
                (
                 pnCodCliente,
                 pnNumAbonado,
                 pnIndNumeracion,
                 pdFecDesde,
                 pvCodActabo,
                 USER,
                 SYSDATE
                );
        END IF;

    end if;

EXCEPTION
    WHEN OTHERS THEN
        pvErrorAplic := 'FALSE';
        pvErrorGlosa := 'fallo insercion de GA_INTARCEL_ACCIONES_TO';
        pvErrorOra := TO_CHAR(SQLCODE);
        pvErrorOraGlosa := SQLERRM;

END PV_ACT_CAMB_COMERC_CICLO_PR;

--------------------------------------------------------------------------------------
PROCEDURE PV_PLAN_TARIF_CTASEG_CICLO_PR(
   EV_PRODUCTO    IN NUMBER  ,
   EV_CLIENTE     IN NUMBER  ,
   EV_ABONADO     IN NUMBER  ,
   EV_TIPPLAN     IN VARCHAR2,
   EV_PLANTARIF   IN VARCHAR2,
   EV_CICLO       IN NUMBER  ,
   EV_FECSYS      IN DATE    ,
   EV_EMPRESA     IN NUMBER  ,
   EV_HOLDING     IN NUMBER  ,
   EV_TIPPLANTANT IN VARCHAR2,
   EV_GRUPO       IN NUMBER  ,
   SV_PROC        IN OUT NOCOPY VARCHAR2,
   SV_TABLA       IN OUT NOCOPY VARCHAR2,
   SV_ACT         IN OUT NOCOPY VARCHAR2,
   SV_SQLCODE     IN OUT NOCOPY VARCHAR2,
   SV_SQLERRM     IN OUT NOCOPY VARCHAR2,
   SV_ERROR       IN OUT NOCOPY VARCHAR2
   , EV_ACTABO    IN VARCHAR2 DEFAULT NULL -- COL|77090|30-01-2009|SAQL
)
/*
   <Documentación TipoDoc = "Procedure">>
   <Elemento
      Nombre = "PV_PLAN_TARIF_CTASEG_CICLO_PR"
      Lenguaje="PL/SQL"
      Fecha="19-02-2008"
      Versión="La del package"
      Diseñador= " Orlando Cabezas"
      Programador="Nicolás Contreras"
      Ambiente Desarrollo="BD">
   <Retorno>N/A</Retorno>>
   <Descripción>realiza apertura o termino de vigencia en tablas GA_INTARCEL </Descripción>>
   <Parámetros>
      <Entrada>
         <param nom="EV_PRODUCTO" Tipo="numerico"></param>>
         <param nom="EV_CLIENTE" Tipo="numerico"></param>>
         <param nom="EV_ABONADO" Tipo="numerico"></param>>
         <param nom="EV_TIPPLAN" Tipo="STRING"></param>>
         <param nom="EV_PLANTARIF" Tipo="STRING"></param>>
         <param nom="EV_CICLO" Tipo="numerico"></param>>
         <param nom="EV_FECSYS" Tipo="date"></param>>
         <param nom="EV_EMPRESA" Tipo="numerico"></param>>
         <param nom="EV_HOLDING" Tipo="numerico"></param>>
         <param nom="EV_TIPPLANTANT" Tipo="STRING"></param>>
         <param nom="EV_GRUPO" Tipo="numerico"></param>>
         <param nom="EV_ACTABO" Tipo="STRING"></param>>
      </Entrada>
      <Salida>
         <param nom="SV_PROC"    Tipo="string">Mensaje DE PROCESO</param>>
         <param nom="SV_TABLA"   Tipo="string">Mensaje DE TABLA</param>>
         <param nom="SV_ACT"     Tipo="string">Mensaje DE ACCION</param>>
         <param nom="SV_SQLCODE" Tipo="string">Mensaje de Retorno ORA</param>>
         <param nom="SV_SQLERRM" Tipo="string">Mensaje de Retorno error Ora</param>>
         <param nom="SV_ERROR "  Tipo="string">codigo de Retorno</param>>
      </Salida>
   </Parámetros>
   </Elemento>
   </Documentación>
*/
IS
   FEC_DESDE_LOG   		   			   GA_INTARCEL.FEC_DESDE%TYPE;
   FEC_HASTA_LOG   					   GA_INTARCEL.FEC_HASTA%TYPE;
   COD_PLANTARIF_LOG 					GA_INTARCEL.COD_PLANTARIF%TYPE;
   LV_FECHADCF                        GA_INTARCEL.FEC_DESDE%TYPE;
   LV_FECHADLL                         GA_INTARCEL.FEC_DESDE%TYPE;
   LV_FECHAD               GA_INTARCEL.FEC_DESDE%TYPE;
   LV_FECHA                GA_INTARCEL.FEC_DESDE%TYPE;
   LV_ROWID                CHAR(18);
   LV_INDCAR               NUMBER(1) := 0;
   LV_INDLLA               NUMBER(1) := 0;
   LV_NCANTIDAD    GA_aBOCEL.NUM_CELULAR%TYPE;
   LV_FYF                  GA_aBOCEL.NUM_CELULAR%TYPE;
   LV_CLIENTE              GA_INTARCEL.COD_CLIENTE%TYPE;
   LV_ABONADO              GA_INTARCEL.NUM_ABONADO%TYPE;
   LV_NUMERO               GA_INTARCEL.IND_NUMERO%TYPE;
   LV_FECDESDE     GA_INTARCEL.FEC_DESDE%TYPE;
   LV_FECHASTA     GA_INTARCEL.FEC_HASTA%TYPE;
   LV_LIMCONSUMO   GA_INTARCEL.IMP_LIMCONSUMO%TYPE;
   LV_FRIENDS              GA_INTARCEL.IND_FRIENDS%TYPE;
   LV_DIASESP              GA_INTARCEL.IND_DIASESP%TYPE;
   LV_CELDA                GA_INTARCEL.COD_CELDA%TYPE;
   LV_TIPPLANTARIF GA_INTARCEL.TIP_PLANTARIF%TYPE;
   LV_SERIE                GA_INTARCEL.NUM_SERIE%TYPE;
   LV_SERIE_DEC    GA_ABOCEL.NUM_SERIE%TYPE;
   LV_SERIETRUNK   GA_INTARTRUNK.NUM_SERIE%TYPE;
   LV_SERIETREK    GA_INTARTREK.NUM_SERIE%TYPE;
   LV_CELULAR              GA_INTARCEL.NUM_CELULAR%TYPE;
   LV_CARGOBASICO  GA_INTARCEL.COD_CARGOBASICO%TYPE;
   LV_CICLO                GA_INTARCEL.COD_CICLO%TYPE;
   LV_PLANCOM              GA_INTARCEL.COD_PLANCOM%TYPE;
   LV_PLANSERV     GA_INTARCEL.COD_PLANSERV%TYPE;
   LV_GRPSERV              GA_INTARCEL.COD_GRPSERV%TYPE;
   LV_VAR_GRUPO    GA_INTARCEL.COD_GRUPO%TYPE;
   LV_GRUPO                GA_INTARCEL.COD_GRUPO%TYPE;
   LV_PORTADOR     GA_INTARCEL.COD_PORTADOR%TYPE;
   LV_PLANTARIF    TA_PLANTARIF.COD_PLANTARIF%TYPE;
   LV_CAPCODE              GA_INTARBEEP.CAP_CODE%TYPE;
   LV_BEEPER               GA_INTARBEEP.NUM_BEEPER%TYPE;
   LV_RADIO                GA_INTARTRUNK.NUM_RADIO%TYPE;
   LV_MAN                  GA_INTARTREK.NUM_MAN%TYPE;
   LV_CICLFACT     FA_CICLFACT.COD_CICLFACT%TYPE;
   LV_PLANTANT     GA_FINCICLO.TIP_PLANTANT%TYPE := NULL;
   LV_GRUPANT              GA_FINCICLO.COD_GRUPANT%TYPE := NULL;
   LV_VAR1                 GA_ABOCEL.NUM_ABONADO%TYPE;
   LV_DIAS                 TA_PLANTARIF.NUM_DIAS%TYPE;
   LV_USO                  GA_INTARCEL.COD_USO%TYPE;
   LV_AUX                  NUMBER;
   LV_FEC_AUX              DATE;
   LV_NUM_IMSI     GA_INTARCEL.NUM_IMSI%TYPE;
   LV_TECNOLOGIA   GA_ABOCEL.COD_TECNOLOGIA%TYPE;
   LV_TECNOLOGIA_GSM GA_ABOCEL.COD_TECNOLOGIA%TYPE;
   LV_USODESTINO     GA_INTARCEL.COD_USO%TYPE;
   LV_COD_TIPPLAN    TA_PLANTARIF.COD_TIPLAN%TYPE;
   LV_COD_TIPLAN     TA_PLANTARIF.COD_TIPLAN%TYPE;
   LV_TIPPLAN        TA_PLANTARIF.COD_TIPLAN%TYPE;
   LV_des_error      ge_errores_pg.DesEvent;
   LV_sSql                   ge_errores_pg.vQuery;
   LV_ESTADO         PV_IORSERV.cod_estado%TYPE;
   LV_NUM_OOSS       PV_IORSERV.NUM_OS%TYPE;
   LV_NUM_ABONADO    GA_ABOCEL.NUM_ABONADO%TYPE;
   LV_COD_LIMCOSUMO  GA_LIMITE_CLIABO_TO.COD_LIMCONS%TYPE;
   LV_ERRORAplic     VARCHAR2(100);
   LV_ERRORGlosa     VARCHAR2(100);
   LV_ERROROra       VARCHAR2(100);
   LV_ERROROraGlosa  VARCHAR2(100);
   Lv_Trace                  VARCHAR2(100);
   LV_COUNT          number(2);
   LV_FEC_DESDE_ANT  DATE;
   LV_INTENTO_MAX    VARCHAR2(3);
   LV_FEC_DESDE2     VARCHAR2(30);
   LV_FEC_DESDE      DATE;
   LV_sCodUsoActual  ga_intarcel.cod_uso%TYPE;
   LV_sCodUsoHibrido ged_parametros.val_parametro%TYPE;
   LV_sCodUsoPostPago   ged_parametros.val_parametro%TYPE;
   LV_COD_PLANTARIF_NUE PV_PARAM_ABOCEL.COD_PLANTARIF_NUE%TYPE;
   eo_limite_consumo PV_LIMITE_CONSUMO_QT := PV_INICIA_ESTRUCTURAS_PG.PV_LIMITE_CONSUMO_QT_FN;
   SN_COD_RETORNO NUMBER;
   SV_MENS_RETORNO VARCHAR2(200);
   SN_NUM_EVENTO NUMBER;
   ERROR_PROCESO        EXCEPTION;
   ERROR_INTARCEL       EXCEPTION;
   TODO_OK              EXCEPTION;
   --INI COL-72899|09-12-2008|GEZ
   LV_CodPlanAct				  ga_abocel.cod_plantarif%TYPE;
   LV_UsoPlanDest				 ga_abocel.cod_uso%TYPE;
   LV_UsoPrepago				 ga_abocel.cod_uso%TYPE;
   LV_TiplanPostpago			 ta_plantarif.cod_tiplan%TYPE;
   LV_TiplanPrepago			 ta_plantarif.cod_tiplan%TYPE;
   LV_TiplanHibrido			   ta_plantarif.cod_tiplan%TYPE;
   ERROR_LIMITE        		EXCEPTION;
   --FIN COL-72899|09-12-2008|GEZ

   LV_COD_ACTABO  VARCHAR2(3); -- COL|77090|30-01-2009|SAQL

   CURSOR C1 is
      SELECT ROWID,COD_CLIENTE,NUM_ABONADO,IND_NUMERO,
      FEC_DESDE,FEC_HASTA,IMP_LIMCONSUMO,
      IND_FRIENDS,IND_DIASESP,COD_CELDA,
      TIP_PLANTARIF,COD_PLANTARIF,NUM_SERIE,
      NUM_CELULAR,COD_CARGOBASICO,COD_CICLO,
      COD_PLANCOM,COD_PLANSERV,COD_GRPSERV,
      COD_GRUPO,COD_PORTADOR,COD_USO
      FROM GA_INTARCEL
      WHERE COD_CLIENTE = EV_CLIENTE
      AND NUM_ABONADO = EV_ABONADO
      AND FEC_DESDE = LV_FECHA;

BEGIN
   LV_COD_ACTABO := NVL(EV_ACTABO,'CT'); -- COL|77090|30-01-2009|SAQL
   SV_PROC := 'PV_Plan_Tarifario_ctaseg_ciclo_PR ';
   DBMS_OUTPUT.Put_Line('PASO X' );
   --INI COL-72899|09-12-2008|GEZ
   LV_sCodUsoHibrido     := GE_FN_DEVVALPARAM('GA', 1, 'USO_HIBRIDO_GSM_TDMA');
   -- LV_sCodUsoPostPago  := GE_FN_DEVVALPARAM('GA', 1, 'USO_POSTPAGO_GSM_DMA'); -- COL 72899|20-12-2008|SAQL
   LV_sCodUsoPostPago  := GE_FN_DEVVALPARAM('GA', 1, 'TIPOPOSTPAGO'); -- COL 72899|20-12-2008|SAQL
   LV_UsoPrepago		   := GE_FN_DEVVALPARAM('GA', 1, 'USO_PREPAGO');
   LV_TiplanPostpago	  := GE_FN_DEVVALPARAM('GA', 1, 'TIPOPOSTPAGO');
   LV_TiplanPrepago	  := GE_FN_DEVVALPARAM('GA', 1, 'TIPOPREPAGO');
   LV_TiplanHibrido        := GE_FN_DEVVALPARAM('GA', 1, 'TIPOHIBRIDO');
   --FIN COL-72899|09-12-2008|GEZ

   --INI-OCB-COL-MIX-06003
   SV_TABLA := 'GA_INTARCEL';
   SV_ACT := 'S';
   SELECT cod_uso INTO LV_sCodUsoActual
   FROM ga_intarcel
   WHERE cod_cliente = EV_CLIENTE
   AND num_abonado = EV_ABONADO
   AND SYSDATE BETWEEN fec_desde AND fec_hasta;

   DBMS_OUTPUT.Put_Line('PASO X2' );

   --INI COL-72899|09-12-2008|GEZ
   --SELECT COD_USO INTO LV_USO
   SELECT cod_uso,cod_plantarif INTO LV_USO,LV_CodPlanAct
   --FIN COL-72899|09-12-2008|GEZ
   FROM GA_ABOCEL WHERE NUM_ABONADO=EV_ABONADO;

   DBMS_OUTPUT.Put_Line('PASO X3' );

   IF LV_USODESTINO IS NULL THEN
      LV_USO:=LV_USO;
   ELSE
      LV_USO:=LV_USODESTINO;
   END IF;
   --FIN-OCB-COL-MIX-06003

   SV_TABLA := 'FA_CICLFACT';
   SV_ACT := 'S';
   LV_AUX := 0;

   SELECT MIN(FEC_DESDELLAM)
   INTO LV_FECHADCF
   FROM FA_CICLFACT
   WHERE COD_CICLO = EV_CICLO
   AND TRUNC(EV_FECSYS) < TRUNC(FEC_DESDELLAM)
   AND IND_FACTURACION = LV_AUX ;

   DBMS_OUTPUT.Put_Line('PASO X4' );

   SELECT FEC_DESDELLAM,COD_CICLFACT
   INTO LV_FECHADLL,LV_CICLFACT
   FROM FA_CICLFACT
   WHERE COD_CICLO = EV_CICLO
   AND TRUNC(EV_FECSYS) < TRUNC(FEC_DESDELLAM)
   AND IND_FACTURACION = LV_AUX
   AND ROWNUM = 1;

   DBMS_OUTPUT.Put_Line('PASO X5' );

   SV_TABLA := 'TA_PLANTARIF';
   SV_ACT := 'S';
   BEGIN
      --SELECT NUM_DIAS,COD_CARGOBASICO	   			  				 							--COL-72899|09-12-2008|GEZ
      --INTO LV_DIAS,LV_CARGOBASICO																     --COL-72899|09-12-2008|GEZ
      SELECT NUM_DIAS,COD_CARGOBASICO,decode(cod_tiplan,LV_TiplanPostpago,LV_sCodUsoPostPago,LV_TiplanPrepago,LV_UsoPrepago,LV_TiplanHibrido,LV_sCodUsoHibrido)			   --COL-72899|09-12-2008|GEZ
      INTO LV_DIAS,LV_CARGOBASICO,LV_UsoPlanDest														 --COL-72899|09-12-2008|GEZ
      FROM TA_PLANTARIF
      WHERE COD_PRODUCTO = EV_PRODUCTO
      AND COD_PLANTARIF = EV_PLANTARIF;
   EXCEPTION
      WHEN OTHERS THEN
         SV_ERROR := '4';
         RAISE ERROR_PROCESO;
   END;

   SV_TABLA := 'GA_INTARCEL';
   LV_TECNOLOGIA_GSM := GE_FN_DEVVALPARAM('GA',1,'GRUPO_TEC_GSM');
   IF EV_ABONADO <> 0 THEN
      SELECT NUM_SERIE, COD_TECNOLOGIA
      INTO LV_SERIE_DEC, LV_TECNOLOGIA
      FROM GA_ABOCEL
      WHERE NUM_ABONADO = EV_ABONADO;
      IF GA_APROVISIONAR_CENTRAL_PG.PV_GRUPO_TECNOLOGICO_FN(LV_TECNOLOGIA) = LV_TECNOLOGIA_GSM THEN
         SELECT FRECUPERSIMCARD_FN(LV_SERIE_DEC, 'IMSI') INTO LV_NUM_IMSI FROM DUAL;
      END IF;
   END IF;

   DBMS_OUTPUT.Put_Line('PASO X6' );

   BEGIN
      SELECT NUM_ABONADO
      INTO lv_VAR1
      FROM GA_INTARCEL
      WHERE COD_CLIENTE = EV_CLIENTE
      AND NUM_ABONADO = EV_ABONADO
      AND FEC_DESDE   = LV_FECHADCF;
      LV_INDCAR := 1;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         LV_INDCAR := 0;
      WHEN TOO_MANY_ROWS THEN
         LV_INDCAR := 1;
      WHEN OTHERS THEN
         SV_ERROR := '4';
         RAISE ERROR_PROCESO;
   END;

   BEGIN
      SELECT NUM_ABONADO
      INTO LV_VAR1
      FROM GA_INTARCEL
      WHERE COD_CLIENTE = EV_CLIENTE
      AND NUM_ABONADO = EV_ABONADO
      AND FEC_DESDE   = LV_FECHADLL;
      LV_INDLLA := 1;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         LV_INDLLA := 0;
      WHEN TOO_MANY_ROWS THEN
         LV_INDLLA := 1;
      WHEN OTHERS THEN
         SV_ERROR := '4';
         RAISE ERROR_PROCESO;
   END;

   IF LV_INDCAR = 0 AND LV_INDLLA = 0 THEN
      BEGIN
         LV_AUX := 1;
         SELECT FEC_DESDE
         INTO LV_FECHAD
         FROM GA_INTARCEL
         WHERE COD_CLIENTE = EV_CLIENTE
         AND NUM_ABONADO = EV_ABONADO
         AND EV_FECSYS BETWEEN FEC_DESDE
         AND FEC_HASTA
         AND ROWNUM = LV_AUX;
         LV_FECHA := LV_FECHAD;
      EXCEPTION
         WHEN OTHERS THEN
            SV_ERROR := '4';
            RAISE ERROR_PROCESO;
      END;
   ELSIF LV_INDLLA <> 0 THEN
      SV_ACT := 'U';
      IF EV_TIPPLAN = 'E' OR EV_TIPPLAN = 'H' THEN
         LV_VAR_GRUPO := EV_GRUPO;
      ELSIF EV_TIPPLAN = 'I' THEN
         LV_VAR_GRUPO := NULL;
      END IF;
      UPDATE GA_INTARCEL
      SET TIP_PLANTARIF = EV_TIPPLAN,
      COD_PLANTARIF = EV_PLANTARIF,
      COD_CARGOBASICO = LV_CARGOBASICO,
      COD_GRUPO = LV_VAR_GRUPO,
      NUM_IMSI = LV_NUM_IMSI
      WHERE COD_CLIENTE = EV_CLIENTE
      AND NUM_ABONADO = EV_ABONADO
      AND FEC_DESDE >= LV_FECHADCF;
      SV_ERROR := '0';
      RAISE ERROR_PROCESO;
   ELSIF LV_INDCAR <> 0 THEN
      IF LV_FECHADLL >= LV_FECHADCF THEN
         LV_FECHA := LV_FECHADCF;
      ELSE
         LV_FECHA := LV_FECHAD;
      END IF;
   END IF;
   SV_TABLA := 'C1';
   SV_ACT := 'O';
   OPEN C1;
   LOOP
      SV_TABLA := 'C1';
      SV_ACT := 'F';
      FETCH C1 INTO LV_ROWID,LV_CLIENTE,LV_ABONADO,LV_NUMERO, LV_FECDESDE,LV_FECHASTA,LV_LIMCONSUMO,
      LV_FRIENDS,LV_DIASESP,LV_CELDA, LV_TIPPLANTARIF,LV_PLANTARIF,LV_SERIE,
      LV_CELULAR,LV_CARGOBASICO,LV_CICLO,LV_PLANCOM,LV_PLANSERV,LV_GRPSERV,
      LV_GRUPO,LV_PORTADOR,LV_USO;
      EXIT WHEN C1%NOTFOUND;

      DBMS_OUTPUT.Put_Line('PASO X7' );

      --INI-OCB-COL-MIX-06003
      SV_TABLA := 'TA_PLANTARIF 1';
      SV_ACT := 'S';
      SELECT COD_CARGOBASICO INTO LV_CARGOBASICO
      FROM TA_PLANTARIF
      WHERE COD_PLANTARIF = EV_PLANTARIF
      AND COD_PRODUCTO =  1;

      LV_FRIENDS:=0;

      SV_TABLA := 'GA_SERVSUPLABO-GA_GRUPOS_SERVSUP 1';
      SV_ACT := 'S';

      SELECT COUNT(*)
      INTO LV_FYF
      FROM GA_SERVSUPLABO A, GA_GRUPOS_SERVSUP B
      WHERE A.NUM_ABONADO = LV_ABONADO
      AND A.COD_SERVICIO = B.COD_SERVICIO
      AND B.COD_GRUPO='FYFCEL'
      AND SYSDATE BETWEEN FEC_DESDE AND NVL(FEC_HASTA,SYSDATE)
      AND A.IND_ESTADO < 3;

      IF LV_FYF > 0 THEN
         LV_FRIENDS:=1;
      END IF;
      BEGIN
         SV_TABLA := 'TA_PLANES_FRECUENTES';
         SV_ACT := 'S';
         SELECT COUNT(1) INTO LV_NCANTIDAD
         FROM TA_PLANES_FRECUENTES
         WHERE COD_PLANTARIF = EV_PLANTARIF
         AND SYSDATE BETWEEN FEC_DESDE AND FEC_HASTA;
         IF LV_NCANTIDAD > 0 THEN
            LV_FRIENDS := 1;
         ELSE
            LV_FRIENDS := 0;
         END IF;
      EXCEPTION
         WHEN OTHERS THEN
            LV_FRIENDS := 0;
      END;
      SV_TABLA := 'GA_PLANTECPLSERV';
      SV_ACT := 'S';
      SELECT COD_PLANSERV INTO LV_PLANSERV
      FROM GA_PLANTECPLSERV
      WHERE COD_PLANTARIF = EV_PLANTARIF
      AND COD_TECNOLOGIA = LV_TECNOLOGIA;
      BEGIN
         SV_TABLA := 'TOL_LIMITE_PLAN_TD';
         SV_ACT := 'S';
         SELECT B.IMP_LIMITE INTO LV_LIMCONSUMO
         FROM TOL_LIMITE_PLAN_TD A, TOL_LIMITE_TD B
         WHERE A.COD_PLANTARIF = EV_PLANTARIF
         AND A.COD_LIMCONS = B.COD_LIMCONS
         AND SYSDATE BETWEEN A.FEC_DESDE AND A.FEC_HASTA
         AND A.IND_DEFAULT = 'S';
      EXCEPTION
         WHEN NO_DATA_FOUND THEN
            LV_LIMCONSUMO := 0;
      END;
      SV_TABLA := 'TA_PLANTARIF';
      SV_ACT := 'S';
      SELECT DECODE(COD_TIPLAN,GE_FN_DEVVALPARAM('GA','1','TIPOHIBRIDO'),'TRUE','FALSE')
      INTO LV_COD_TIPLAN
      FROM TA_PLANTARIF
      WHERE COD_PLANTARIF = EV_PLANTARIF;
      IF LV_COD_TIPLAN = 'TRUE' THEN
         LV_LIMCONSUMO := 0;
      END IF;
      SV_TABLA := 'TA_PLANTARIF-TOL_LIMITE_TD';
      SV_ACT := 'S';
      IF LV_LIMCONSUMO IS NULL THEN
         SELECT B.IMP_LIMITE
         INTO LV_LIMCONSUMO
         FROM TA_PLANTARIF A, TOL_LIMITE_TD B
         WHERE A.COD_PLANTARIF=EV_PLANTARIF
         AND A.COD_PRODUCTO =  1
         AND B.COD_LIMCONS=A.COD_LIMCONSUMO
         AND sysdate BETWEEN b.fec_desde and b.fec_hasta;
      END IF;
      --FIN-OCB-COL-MIX-06003
      IF LV_FECHA = LV_FECHADCF THEN
         IF LV_FECHADCF = LV_FECHADLL THEN
            SV_TABLA := 'GA_INTARCEL';
            SV_ACT := 'U';
            IF LV_TIPPLAN = 'E' OR LV_TIPPLAN = 'H' THEN
               LV_VAR_GRUPO := EV_GRUPO;
            ELSIF LV_TIPPLAN = 'I' THEN
               LV_VAR_GRUPO := NULL;
            END IF;
            UPDATE GA_INTARCEL
            SET TIP_PLANTARIF = LV_TIPPLAN,
            COD_PLANTARIF = EV_PLANTARIF,
            COD_CARGOBASICO = LV_CARGOBASICO,
            COD_GRUPO = LV_VAR_GRUPO,NUM_IMSI=LV_NUM_IMSI
            WHERE ROWID = LV_ROWID;
         ELSIF LV_FECHADCF < LV_FECHADLL THEN
            SV_TABLA := 'GA_INTARCEL';
            SV_ACT := 'U';
            IF LV_TIPPLAN = 'E' OR LV_TIPPLAN = 'H' THEN
               LV_VAR_GRUPO := EV_GRUPO;
            ELSIF LV_TIPPLAN = 'I' THEN
               LV_VAR_GRUPO := NULL;
            END IF;
            LV_FEC_AUX := LV_FECHADLL - (1/(24*60*60));
            UPDATE GA_INTARCEL
            SET FEC_HASTA = LV_FEC_AUX
            WHERE ROWID = LV_ROWID;
            SV_TABLA := 'GA_INTARCEL';
            SV_ACT := 'I';

            INSERT INTO GA_INTARCEL (
               COD_CLIENTE,NUM_ABONADO,IND_NUMERO, FEC_DESDE,FEC_HASTA,IMP_LIMCONSUMO,
               IND_FRIENDS,IND_DIASESP,COD_CELDA, TIP_PLANTARIF,COD_PLANTARIF,NUM_SERIE,
               NUM_CELULAR,COD_CARGOBASICO,COD_CICLO, COD_PLANCOM,COD_PLANSERV,COD_GRPSERV,
               COD_GRUPO,COD_PORTADOR,COD_USO,NUM_IMSI
            ) VALUES (
               LV_CLIENTE,LV_ABONADO,LV_NUMERO, LV_FECHADLL,LV_FECHASTA,LV_LIMCONSUMO, --OCB
               LV_FRIENDS,LV_DIASESP,LV_CELDA, EV_TIPPLAN,EV_PLANTARIF,LV_SERIE,
               LV_CELULAR,LV_CARGOBASICO,LV_CICLO, LV_PLANCOM,LV_PLANSERV,LV_GRPSERV,LV_VAR_GRUPO,
               --LV_PORTADOR,LV_USO,LV_NUM_IMSI);            --COL-72899|18-12-2008|GEZ
               LV_PORTADOR,LV_UsoPlanDest,LV_NUM_IMSI);   		 --COL-72899|18-12-2008|GEZ

            -- PV_ACT_CAMB_COMERC_CICLO_PR(LV_CLIENTE,LV_ABONADO,LV_NUMERO,'CT',LV_FECHADLL,EV_PLANTARIF,LV_ErrorAplic, LV_ErrorGlosa,LV_ErrorOra,LV_ErrorOraGlosa,LV_Trace); -- COL 77090|02-02-2009|SAQL
            PV_ACT_CAMB_COMERC_CICLO_PR(LV_CLIENTE,LV_ABONADO,LV_NUMERO,LV_COD_ACTABO,LV_FECHADLL,EV_PLANTARIF,LV_ErrorAplic, LV_ErrorGlosa,LV_ErrorOra,LV_ErrorOraGlosa,LV_Trace); -- COL 77090|02-02-2009|SAQL
            IF LV_ErrorAplic = 'FALSE' THEN
               SV_ERROR := '4';
               RAISE ERROR_PROCESO;
            END IF;
            --INI-OCB-COL-MIX-06003
            --LV_sCodUsoHibrido  := GE_FN_DEVVALPARAM('GA', 1, 'USO_HIBRIDO_GSM_TDMA');								 --COL-72899|09-12-2008|GEZ
            IF TO_CHAR(LV_sCodUsoActual)=LV_sCodUsoPostPago AND  TO_CHAR(LV_USO)=LV_sCodUsoHibrido THEN
               SV_TABLA := 'GA_INTARCEL_ACCIONES_TO';
               SV_ACT := 'I';
               INSERT INTO GA_INTARCEL_ACCIONES_TO(
                  COD_CLIENTE,NUM_ABONADO,IND_NUMERO,FEC_DESDE,COD_ACTABO,NOM_USUARORA,FEC_INGRESO
               ) VALUES (
                  LV_CLIENTE,LV_ABONADO,LV_NUMERO,LV_FECHADLL, 'BA',USER,SYSDATE);
            END IF;
            --FIN-OCB-COL-MIX-06003
         END IF;
      ELSE
         SV_TABLA := 'GA_INTARCEL';
         SV_ACT := 'U';
         LV_FEC_AUX := LV_FECHADLL - (1/(24*60*60));
         UPDATE GA_INTARCEL
         SET FEC_HASTA = LV_FEC_AUX
         WHERE ROWID = LV_ROWID;
         IF LV_INDCAR <> 0 THEN
            SV_TABLA := 'GA_INTARCEL';
            SV_ACT := 'I';
            IF LV_TIPPLAN = 'E' OR LV_TIPPLAN = 'H' THEN
               LV_VAR_GRUPO := EV_GRUPO;
            ELSIF LV_TIPPLAN = 'I' THEN
               LV_VAR_GRUPO := NULL;
            END IF;
            INSERT INTO GA_INTARCEL(
               COD_CLIENTE,NUM_ABONADO,IND_NUMERO,FEC_DESDE,FEC_HASTA,IMP_LIMCONSUMO,
               IND_FRIENDS,IND_DIASESP,COD_CELDA, TIP_PLANTARIF,COD_PLANTARIF,NUM_SERIE,
               NUM_CELULAR,COD_CARGOBASICO,COD_CICLO, COD_PLANCOM,COD_PLANSERV,COD_GRPSERV,
               COD_GRUPO,COD_PORTADOR,COD_USO,NUM_IMSI
            ) VALUES (
               LV_CLIENTE,LV_ABONADO,LV_NUMERO,LV_FECHADLL,LV_FECHADCF - (1/(24*60*60)),
               LV_LIMCONSUMO,LV_FRIENDS,LV_DIASESP,LV_CELDA,EV_TIPPLAN,EV_PLANTARIF,LV_SERIE,
               LV_CELULAR,LV_CARGOBASICO,LV_CICLO,LV_PLANCOM,LV_PLANSERV,LV_GRPSERV,
               --LV_VAR_GRUPO,LV_PORTADOR,LV_USO,LV_NUM_IMSI);            --COL-72899|18-12-2008|GEZ
               LV_VAR_GRUPO,LV_PORTADOR,LV_UsoPlanDest,LV_NUM_IMSI);	 	     --COL-72899|18-12-2008|GEZ

            -- PV_ACT_CAMB_COMERC_CICLO_PR(LV_CLIENTE,LV_ABONADO,LV_NUMERO,'CT',LV_FECHADLL,EV_PLANTARIF,LV_ERRORAplic,LV_ERRORGlosa,LV_ERROROra,LV_ERROROraGlosa,LV_Trace); -- COL 77090|02-02-2009|SAQL
            PV_ACT_CAMB_COMERC_CICLO_PR(LV_CLIENTE,LV_ABONADO,LV_NUMERO,LV_COD_ACTABO,LV_FECHADLL,EV_PLANTARIF,LV_ERRORAplic,LV_ERRORGlosa,LV_ERROROra,LV_ERROROraGlosa,LV_Trace); -- COL 77090|02-02-2009|SAQL
            IF Lv_ErrorAplic = 'FALSE' THEN
               SV_ERROR := '4';
               RAISE ERROR_PROCESO;
            END IF;
            --INI-OCB-COL-MIX-06003
            --LV_sCodUsoHibrido  := GE_FN_DEVVALPARAM('GA', 1, 'USO_HIBRIDO_GSM_TDMA');  --COL-72899|09-12-2008|GEZ
            IF TO_CHAR(LV_sCodUsoActual)=LV_sCodUsoPostPago AND  TO_CHAR(LV_USO)=LV_sCodUsoHibrido THEN
               SV_TABLA := 'GA_INTARCEL_ACCIONES_TO';
               SV_ACT := 'I';
               INSERT INTO GA_INTARCEL_ACCIONES_TO(
                  COD_CLIENTE,NUM_ABONADO,IND_NUMERO,FEC_DESDE,COD_ACTABO,NOM_USUARORA,FEC_INGRESO
               ) VALUES (
                  LV_CLIENTE,LV_ABONADO,LV_NUMERO,LV_FECHADLL,'BA',USER,SYSDATE);
            END IF;
            --FIN-OCB-COL-MIX-06003

            SV_TABLA := 'GA_INTARCEL';
            SV_ACT := 'U';
            UPDATE GA_INTARCEL
            SET TIP_PLANTARIF = EV_TIPPLAN,
            COD_PLANTARIF = EV_PLANTARIF,
            COD_CARGOBASICO = LV_CARGOBASICO,
            COD_GRUPO = LV_VAR_GRUPO,NUM_IMSI = LV_NUM_IMSI
            WHERE COD_CLIENTE = LV_CLIENTE
            AND NUM_ABONADO = LV_ABONADO
            AND FEC_DESDE = LV_FECHADCF;
         ELSE
            SV_TABLA := 'GA_INTARCEL';
            SV_ACT := 'I';
            IF LV_TIPPLAN = 'E' OR LV_TIPPLAN = 'H' THEN
               LV_VAR_GRUPO := EV_GRUPO;
            ELSIF LV_TIPPLAN = 'I' THEN
               LV_VAR_GRUPO := NULL;
            END IF;
            INSERT INTO GA_INTARCEL(
               COD_CLIENTE,NUM_ABONADO,IND_NUMERO,FEC_DESDE,FEC_HASTA,IMP_LIMCONSUMO,
               IND_FRIENDS,IND_DIASESP,COD_CELDA,TIP_PLANTARIF,COD_PLANTARIF,NUM_SERIE,
               NUM_CELULAR,COD_CARGOBASICO,COD_CICLO,COD_PLANCOM,COD_PLANSERV,COD_GRPSERV,
               COD_GRUPO,COD_PORTADOR,COD_USO,NUM_IMSI
            ) VALUES (
               LV_CLIENTE,LV_ABONADO,LV_NUMERO,LV_FECHADLL,LV_FECHASTA,LV_LIMCONSUMO,--ocb
               LV_FRIENDS,LV_DIASESP,LV_CELDA,EV_TIPPLAN,EV_PLANTARIF,LV_SERIE,
               LV_CELULAR,LV_CARGOBASICO,LV_CICLO,LV_PLANCOM,LV_PLANSERV,LV_GRPSERV,LV_VAR_GRUPO,
               --LV_PORTADOR,LV_USO,LV_NUM_IMSI);   --COL-72899|18-12-2008|GEZ
               LV_PORTADOR,LV_UsoPlanDest,LV_NUM_IMSI);   --COL-72899|18-12-2008|GEZ

            -- PV_ACT_CAMB_COMERC_CICLO_PR(LV_CLIENTE,LV_ABONADO,LV_NUMERO,'CT',LV_FECHADLL,EV_PLANTARIF,LV_ERRORAplic,LV_ERRORGlosa,LV_ERROROra,LV_ERROROraGlosa,LV_Trace); -- COL 77090|02-02-2009|SAQL
            PV_ACT_CAMB_COMERC_CICLO_PR(LV_CLIENTE,LV_ABONADO,LV_NUMERO,LV_COD_ACTABO,LV_FECHADLL,EV_PLANTARIF,LV_ERRORAplic,LV_ERRORGlosa,LV_ERROROra,LV_ERROROraGlosa,LV_Trace); -- COL 77090|02-02-2009|SAQL
            IF LV_ERRORAplic = 'FALSE' THEN
               SV_ERROR := '4';
               RAISE ERROR_PROCESO;
            END IF;
            --INI-OCB-COL-MIX-06003
            --LV_sCodUsoHibrido  := GE_FN_DEVVALPARAM('GA', 1, 'USO_HIBRIDO_GSM_TDMA');							  --COL-72899|09-12-2008|GEZ
            IF TO_CHAR(LV_sCodUsoActual)=LV_sCodUsoPostPago AND TO_CHAR(LV_USO)=LV_sCodUsoHibrido THEN
               SV_TABLA := 'GA_INTARCEL_ACCIONES_TO';
               SV_ACT := 'I';
               INSERT INTO GA_INTARCEL_ACCIONES_TO(
                  COD_CLIENTE,NUM_ABONADO,IND_NUMERO,FEC_DESDE,COD_ACTABO,NOM_USUARORA,FEC_INGRESO
               ) VALUES (
                  LV_CLIENTE,LV_ABONADO,LV_NUMERO,LV_FECHADLL,'BA',USER,SYSDATE
               );
            END IF;
         END IF;
      END IF;
   END LOOP;
   SV_TABLA := 'C1';
   SV_ACT := 'C';
   CLOSE C1;
   IF EV_TIPPLANTANT = 'H' THEN
      IF EV_TIPPLANTANT <> EV_TIPPLAN THEN
         IF EV_TIPPLANTANT <> 'I' THEN
            LV_PLANTANT := EV_TIPPLANTANT;
            LV_GRUPANT := EV_EMPRESA;
         END IF;
      ELSE
         IF EV_GRUPO <> EV_HOLDING THEN
            LV_PLANTANT := EV_TIPPLANTANT;
            LV_GRUPANT := EV_HOLDING;
         ELSE
            LV_PLANTANT := NULL;
            LV_GRUPANT := NULL;
         END IF;
      END IF;
   ELSIF EV_TIPPLANTANT = 'E' THEN
      IF EV_TIPPLANTANT <> EV_TIPPLAN THEN
         IF EV_TIPPLANTANT <> 'I' THEN
            LV_PLANTANT := EV_TIPPLANTANT;
            LV_GRUPANT := EV_HOLDING;
         END IF;
      ELSE
         IF EV_GRUPO <> EV_HOLDING THEN
            LV_PLANTANT := EV_TIPPLANTANT;
            LV_GRUPANT := EV_EMPRESA;
         ELSE
            LV_PLANTANT := NULL;
            LV_GRUPANT := NULL;
         END IF;
      END IF;
   END IF;
   FEC_DESDE_LOG:= SYSDATE;
   FEC_HASTA_LOG:=SYSDATE;
   COD_PLANTARIF_LOG:=NULL;
   BEGIN
      SELECT FEC_DESDE,FEC_HASTA ,COD_PLANTARIF
      INTO FEC_DESDE_LOG,FEC_HASTA_LOG ,COD_PLANTARIF_LOG
      FROM GA_INTARCEL
      WHERE NUM_ABONADO = EV_ABONADO
      AND cod_cliente = EV_CLIENTE --COL-75957|19-01-2009|GEZ
      AND SYSDATE BETWEEN FEC_DESDE AND FEC_HASTA
      AND FEC_HASTA < TO_DATE ('31-12-3000','DD-MM-YYYY');
   EXCEPTION
      WHEN OTHERS THEN
         NULL;
   END ;
   IF ge_log_pg.debug_activo THEN
      ge_log_pg.DEBUG( 'PV_PLAN_TARIF_CTASEG_CICLO_PR - FEC_DESDE'||FEC_DESDE_LOG );
      ge_log_pg.DEBUG( 'PV_PLAN_TARIF_CTASEG_CICLO_PR - FEC_HASTA'||FEC_HASTA_LOG  );
      ge_log_pg.DEBUG( 'PV_PLAN_TARIF_CTASEG_CICLO_PR - COD_PLANTARIF'||COD_PLANTARIF_LOG );
      ge_log_pg.DEBUG( 'PV_PLAN_TARIF_CTASEG_CICLO_PR - ABONADO'||EV_ABONADO );
   END IF;
   BEGIN
      SELECT FEC_DESDE,FEC_HASTA ,COD_PLANTARIF
      INTO FEC_DESDE_LOG,FEC_HASTA_LOG ,COD_PLANTARIF_LOG
      FROM GA_INTARCEL
      WHERE NUM_ABONADO = EV_ABONADO
      AND cod_cliente = EV_CLIENTE		 				   	  				--COL-75957|19-01-2009|GEZ
      AND TRUNC(FEC_HASTA) = TO_DATE ('31-12-3000','DD-MM-YYYY');
   EXCEPTION
      WHEN OTHERS THEN
         NULL;
   END ;
   IF ge_log_pg.debug_activo THEN
      ge_log_pg.DEBUG( 'PV_PLAN_TARIF_CTASEG_CICLO_PR - FEC_DESDE'||FEC_DESDE_LOG );
      ge_log_pg.DEBUG( 'PV_PLAN_TARIF_CTASEG_CICLO_PR - FEC_HASTA'||FEC_HASTA_LOG  );
      ge_log_pg.DEBUG( 'PV_PLAN_TARIF_CTASEG_CICLO_PR - COD_PLANTARIF'||COD_PLANTARIF_LOG );
      ge_log_pg.DEBUG( 'PV_PLAN_TARIF_CTASEG_CICLO_PR - ABONADO'||EV_ABONADO );
   END IF;
   eo_limite_consumo.SUJETO              := EV_ABONADO;
   eo_limite_consumo.TIP_SUJETO          := 'A';
   eo_limite_consumo.FEC_DES             :=TO_CHAR(LV_FECHADCF,'DD/MM/YYYY')||' 00:00:00';
   eo_limite_consumo.FEC_HAS             := '*';							 		   --- 72899  14-11-2008 col RRG
   --eo_limite_consumo.FEC_HAS             := LV_FEC_AUX; 						 		   --- 72899  14-11-2008 col RRG
   eo_limite_consumo.COD_ACTABO          := 'PI';									   --- 72899  14-11-2008 col RRG
   --eo_limite_consumo.COD_ACTABO          := 'PH';   									   --- 72899  14-11-2008 col RRG
   eo_limite_consumo.COD_PLANTARIF_NUEVO := EV_PLANTARIF;
   eo_limite_consumo.tipo_movimiento     := '*';
   eo_limite_consumo.cod_producto        :=  1;
   --- INICIO RRG 04-12-2008  72899 COL - CPU
   if EV_TIPPLAN = 'I' AND EV_TIPPLANTANT = 'H' then
      eo_limite_consumo.FEC_HAS             := LV_FEC_AUX;
      eo_limite_consumo.COD_ACTABO          := 'PH';
      eo_limite_consumo.tipo_movimiento	 := 'NCT';
   end if;
   if EV_TIPPLAN = 'H' AND EV_TIPPLANTANT = 'I' then
      eo_limite_consumo.FEC_HAS             := LV_FEC_AUX;
      eo_limite_consumo.COD_ACTABO      := 'PO';
      eo_limite_consumo.tipo_movimiento  := 'CTN';
   end if;
   --- FIN RRG 04-12-2008  72899 COL - CPU
   SN_COD_RETORNO := NULL;
   SV_MENS_RETORNO := NULL;
   SN_NUM_EVENTO := NULL;
   IF ge_log_pg.debug_activo THEN
      ge_log_pg.DEBUG( 'PV_ESPEC_PROVISIONAMIENTO_PG.PV_ACTUALIZA_LIMITE_CONSUMO_PR- eo_limite_consumo.FEC_DES '|| eo_limite_consumo.FEC_DES  );
   END IF;
   PV_ESPEC_PROVISIONAMIENTO_PG.PV_ACTUALIZA_LIMITE_CONSUMO_PR ( EO_LIMITE_CONSUMO, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO );
   IF SN_COD_RETORNO >0 THEN
      SV_ERROR := '4';
      DBMS_OUTPUT.Put_Line('SV_MENS_RETORNO:'||SV_MENS_RETORNO );
      RAISE ERROR_PROCESO;
   END IF;
   BEGIN
      SELECT FEC_DESDE,FEC_HASTA ,COD_PLANTARIF
      INTO FEC_DESDE_LOG,FEC_HASTA_LOG ,COD_PLANTARIF_LOG
      FROM GA_INTARCEL
      WHERE NUM_ABONADO = EV_ABONADO
      AND cod_cliente = EV_CLIENTE		 				   	  				--COL-75957|19-01-2009|GEZ
      AND SYSDATE BETWEEN FEC_DESDE AND FEC_HASTA
      AND FEC_HASTA < TO_DATE ('31-12-3000','DD-MM-YYYY');
   EXCEPTION
      WHEN OTHERS THEN
         NULL;
   END ;
   IF ge_log_pg.debug_activo THEN
      ge_log_pg.DEBUG( 'PV_PLAN_TARIF_CTASEG_CICLO_PR2 - FEC_DESDE'||FEC_DESDE_LOG );
      ge_log_pg.DEBUG( 'PV_PLAN_TARIF_CTASEG_CICLO_PR2 - FEC_HASTA'||FEC_HASTA_LOG  );
      ge_log_pg.DEBUG( 'PV_PLAN_TARIF_CTASEG_CICLO_PR2 - COD_PLANTARIF'||COD_PLANTARIF_LOG );
      ge_log_pg.DEBUG( 'PV_PLAN_TARIF_CTASEG_CICLO_PR2 - ABONADO'||EV_ABONADO );
   END IF;
   BEGIN
      SELECT FEC_DESDE,FEC_HASTA ,COD_PLANTARIF
      INTO FEC_DESDE_LOG,FEC_HASTA_LOG ,COD_PLANTARIF_LOG
      FROM GA_INTARCEL
      WHERE NUM_ABONADO = EV_ABONADO
      AND cod_cliente=EV_CLIENTE		 				   	  				--COL-75957|19-01-2009|GEZ
      AND TRUNC(FEC_HASTA) = TO_DATE ('31-12-3000','DD-MM-YYYY');
   EXCEPTION
      WHEN OTHERS THEN
         NULL;
   END ;
   IF ge_log_pg.debug_activo THEN
      ge_log_pg.DEBUG( 'PV_PLAN_TARIF_CTASEG_CICLO_PR2 - FEC_DESDE'||FEC_DESDE_LOG );
      ge_log_pg.DEBUG( 'PV_PLAN_TARIF_CTASEG_CICLO_PR2 - FEC_HASTA'||FEC_HASTA_LOG  );
      ge_log_pg.DEBUG( 'PV_PLAN_TARIF_CTASEG_CICLO_PR2 - COD_PLANTARIF'||COD_PLANTARIF_LOG );
      ge_log_pg.DEBUG( 'PV_PLAN_TARIF_CTASEG_CICLO_PR2 - ABONADO'||EV_ABONADO );
   END IF;
   SV_ERROR := '0';
   RAISE ERROR_PROCESO;
EXCEPTION
   --INI COL-72899|09-12-2008|GEZ
   WHEN ERROR_LIMITE THEN
      SV_SQLERRM:='E:'||SN_NUM_EVENTO||'-'||SV_SQLERRM;
      P_INSERTA_ERRORES(1,'LR',TO_NUMBER(EV_ABONADO),SYSDATE,SV_PROC,SV_TABLA,SV_ACT,SV_SQLCODE,SV_SQLERRM);
      --FIN COL-72899|09-12-2008|GEZ
   WHEN ERROR_PROCESO THEN
      IF SV_ERROR = '0' THEN
         /* BEGIN
            SV_TABLA := 'GA_FINCICLO';
            SV_ACT := 'S';
            SELECT ROWID
            INTO LV_ROWID
            FROM GA_FINCICLO
            WHERE COD_CLIENTE = EV_CLIENTE
            AND NUM_ABONADO   = EV_ABONADO
            AND COD_CICLFACT  = LV_CICLFACT;

            SV_TABLA := 'GA_FINCICLO';
            SV_ACT := 'U';

            IF EV_TIPPLAN = 'E' OR EV_TIPPLAN = 'H' THEN
               LV_VAR_GRUPO := EV_GRUPO;
            ELSIF EV_TIPPLAN = 'I' THEN
               LV_VAR_GRUPO := NULL;
            END IF;

            UPDATE GA_FINCICLO
            SET TIP_PLANTARIF = EV_TIPPLAN,
            COD_PLANTARIF     = EV_PLANTARIF,
            COD_CARGOBASICO = LV_CARGOBASICO,
            COD_GRUPO = LV_VAR_GRUPO,
            FEC_DESDELLAM = DECODE(FEC_DESDELLAM,NULL,LV_FECHADLL,
            FEC_DESDELLAM),
            TIP_PLANTANT = LV_PLANTANT,
            COD_GRUPANT = LV_GRUPANT,
            NUM_DIAS = LV_DIAS
            WHERE ROWID = LV_ROWID;
         EXCEPTION
            WHEN NO_DATA_FOUND THEN
               SV_TABLA := 'GA_FINCICLO';
               SV_ACT := 'I';
               IF EV_TIPPLAN = 'E' OR EV_TIPPLAN = 'H' THEN
                  LV_VAR_GRUPO := EV_GRUPO;
               ELSIF EV_TIPPLAN = 'I' THEN
                  LV_VAR_GRUPO := NULL;
               END IF;
               INSERT INTO GA_FINCICLO (
                  COD_CLIENTE, COD_CICLFACT, NUM_ABONADO, COD_PRODUCTO, TIP_PLANTARIF,
                  COD_PLANTARIF, COD_CARGOBASICO, COD_GRUPO, FEC_DESDELLAM, TIP_PLANTANT,
                  COD_GRUPANT, NUM_DIAS
               ) VALUES (
                  EV_CLIENTE, LV_CICLFACT, EV_ABONADO, 1, EV_TIPPLAN,
                  EV_PLANTARIF, LV_CARGOBASICO, LV_VAR_GRUPO, LV_FECHADLL, LV_PLANTANT,
                  LV_GRUPANT, LV_DIAS
               );
            WHEN OTHERS THEN
               SV_SQLCODE := SQLCODE;
               SV_SQLERRM := SQLERRM;
               SV_ERROR := '4';
         END;*/
         null;
      ELSE
         IF SV_ERROR = '4' THEN
            SV_SQLCODE := SQLCODE;
            SV_SQLERRM := SQLERRM;
            SV_ERROR := '4';
         ELSE
            IF SV_SQLCODE IS NULL THEN
               SV_SQLCODE := SQLCODE;
               SV_SQLERRM := SQLERRM;
            END IF;
         END IF;
      END IF;
   WHEN OTHERS THEN
      SV_SQLCODE := SQLCODE;
       --SV_SQLERRM := SQLERRM;                 --COL-72899|23-12-2008|SAQL-EV-PMY
       SV_SQLERRM := SUBSTR(SQLERRM, 1, 200);   --COL-72899|23-12-2008|SAQL-EV-PMY
       SV_ERROR := '4';
END PV_PLAN_TARIF_CTASEG_CICLO_PR;

END PV_PLAN_TARIF_CTASEG_CICLO_Pg;
/
SHOW ERRORS
