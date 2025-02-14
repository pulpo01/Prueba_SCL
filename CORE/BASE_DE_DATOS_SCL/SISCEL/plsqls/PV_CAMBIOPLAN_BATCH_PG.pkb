CREATE OR REPLACE PACKAGE BODY Pv_Cambioplan_Batch_Pg IS

-- pv_cambioplan_batch_pg v1.01 //*Incidencia XO-200606021119 02-06-2006*/
-- pv_cambioplan_batch_pg v1.02 //Inicio modificacion by SAQL/Soporte 29/08/2006 - CO-2006081700334
-- pv_cambioplan_batch_pg v1.03 //COL-37481|15-02-2007|GEZ
-- pv_cambioplan_batch_pg v1.04 //Inicio COl-38908|23/03/2007|jjr*/
-- pv_cambioplan_batch_pg v1.05 //INI COL-42762|31-07-2007|PCR
-- pv_cambioplan_batch_pg v1.06 //RRG 43737 03-09-2007 COL
-- pv_cambioplan_batch_pg v1.07 //RRG 45898 23-11-2007 COL
-- pv_cambioplan_batch_pg v1.08 //INC. COL 64502|10-04-2008|SAQL
-- pv_cambioplan_batch_pg v1.09 //64502 col|18-04-2008|EFR
-- pv_cambioplan_batch_pg v1.10 //71929/ 18-10-2008/EFR
-- pv_cambioplan_batch_pg v1.11 //COL-71988|19-10-2008|Orlando Cabezas
-- pv_cambioplan_batch_pg v1.12 //INI COL|71991|18-10-2008|SAQL
-- pv_cambioplan_batch_pg v1.13 //COL-72030|28-10-2008|DVG
-- pv_cambioplan_batch_pg v1.14 //COL 72226|29-10-2008|SAQL
-- pv_cambioplan_batch_pg v1.15 //COL 73515|26-11-2008|SAQL
-- pv_cambioplan_batch_pg v1.16 //COL 73515|12-12-2008|GEZ
-- pv_cambioplan_batch_pg v1.17 //COL  74651|17-12-2008|GEZ-RRG

--CN_Version_Body VARCHAR2(10):='01.18.00';--COL-73376|21-01-2008|GEZ
-- CN_Version_Body VARCHAR2(10):='01.19.00';--COL-76605|27-01-2008|JJR.-
CN_Version_Body VARCHAR2(10):='01.20.00'; -- COL-77090|27-01-2008|SAQL

--INI COL-73376|21-01-2008|GEZ
FUNCTION pv_version_body_fn RETURN VARCHAR2 IS

BEGIN
		 RETURN CN_Version_Body;
END;

FUNCTION pv_version_header_fn RETURN VARCHAR2 IS

BEGIN
		 RETURN CN_Version_Header;
END;

--FIN COL-73376|21-01-2008|GEZ

 -- INI COL 73515|12-12-2008|GEZ

PROCEDURE pv_cambio_plan_abo_pr(
   EN_NumOS    IN          pv_iorserv.num_os%TYPE,
   SV_Estado   out NOCOPY  VARCHAR2,
   SV_Proc     out NOCOPY  VARCHAR2,
   SN_CodMsg   out NOCOPY  NUMBER,
   SN_Evento   out NOCOPY  NUMBER,
   SV_Tabla    out NOCOPY  vARCHAR2,
   SV_Act      out NOCOPY  VARCHAR2,
   SV_Code     out NOCOPY  VARCHAR2,
   SV_Errm     out NOCOPY  VARCHAR2
) IS
   LD_FecEjec        DATE;
   LN_Cant           NUMBER;
   LN_CantFecCorte   NUMBER;
   LN_CantFecFut     NUMBER;
   LV_ErrorAplic     VARCHAR2(1000);
   LV_ErrorGlosa     VARCHAR2(1000);
   LV_Trace          VARCHAR2(1000);
   LV_UsoHibrido     ged_parametros.val_parametro%TYPE;
   LV_TiPlanHib      ged_parametros.val_parametro%TYPE;
   LV_CodOs          pv_iorserv.cod_os%TYPE;
   LN_CodCiclfact    fa_ciclfact.cod_ciclfact%TYPE;
   LV_CodPlanNuevo   ta_plantarif.cod_plantarif%TYPE;
   LV_CodPlanActual  ta_plantarif.cod_plantarif%TYPE;
   LV_CodCargoBasico ta_plantarif.cod_cargobasico%TYPE;
   LV_CodTiplanNue   ta_plantarif.cod_tiplan%TYPE;
   LN_NumDiasNuevo   ta_plantarif.num_dias%TYPE;
   LN_NumAbonado     ga_abocel.num_abonado%TYPE;
   LN_CodCiclo       ga_abocel.cod_ciclo%TYPE;
   LN_CodCliente     ga_abocel.cod_cliente%TYPE;
   LV_TipPlan        ga_abocel.tip_plantarif%TYPE;
   LV_UsoActual      ga_abocel.cod_uso%TYPE;
   LN_Grupo          ga_abocel.cod_empresa%TYPE;
   LN_IndFriends     ga_intarcel.ind_friends%TYPE;
   LN_IndNumero      ga_intarcel.ind_numero%TYPE;
   LN_IndDiasesp     ga_intarcel.ind_diasesp%TYPE;
   LV_CodCelda       ga_intarcel.cod_celda%TYPE;
   LV_NumSerie       ga_intarcel.num_serie%TYPE;
   LN_NumCelular     ga_intarcel.num_celular%TYPE;
   LN_CodPlanCom     ga_intarcel.cod_plancom%TYPE;
   LV_CodPlanServ    ga_intarcel.cod_planserv%TYPE;
   LV_CodGrpServ     ga_intarcel.cod_grpserv%TYPE;
   LN_CodGrupo       ga_intarcel.cod_grupo%TYPE;
   LN_CodPortador    ga_intarcel.cod_portador%TYPE;
   LN_CodUso         ga_intarcel.cod_uso%TYPE;
   LV_NumImsi        ga_intarcel.num_imsi%TYPE;
   LV_NumMinMdn      ga_intarcel.num_min_mdn%TYPE;
   LN_ImpLimite      ga_intarcel.imp_limconsumo%TYPE;
   LV_CodLimcons     ga_limite_cliabo_to.cod_limcons%TYPE;
   LV_DesError       VARCHAR2(1000);
   LV_Sql            VARCHAR2(2000);
   LV_MensajeError   VARCHAR2(2000);
   LV_Codtecnologia  ga_abocel.cod_tecnologia%TYPE; --Inc.- 76605|COL|28/01/2009|JJR.-
   ERROR_CICLO       EXCEPTION;
   ERROR_PROCESO     EXCEPTION;
   ERROR_ACCIONES    EXCEPTION;
BEGIN
   DBMS_OUTPUT.Put_Line('dentro de PV_CAMBIO_PLAN_ABO_PR');

   SV_Estado  :='3';
   SV_Proc := 'PV_CAMBIO_PLAN_ABO_PR';
   SN_CodMsg := 0;
   SN_Evento := 0;
   SV_Code := '0';
   SV_Errm := '0';

   SV_Tabla := 'IORSERV-CAMCOM';
   SV_Act := 'S';
   SELECT a.fh_ejecucion, a.cod_os, b.num_abonado, b.cod_cliente
   INTO LD_FecEjec, LV_CodOs, LN_NumAbonado, LN_CodCliente
   FROM pv_iorserv a,pv_camcom b
   WHERE a.num_os = EN_NumOS
   AND b.num_os = a.num_os;

   SV_Tabla := 'GA_ABOCEL';
   SV_Act := 'S';
   --  SELECT cod_ciclo,cod_plantarif,cod_uso,cod_empresa       --Inc.- 76605|COL|28/01/2009|JJR.-
   --  INTO     LN_CodCiclo,LV_CodPlanActual,LV_UsoActual,LN_Grupo --Inc.- 76605|COL|28/01/2009|JJR.-
   SELECT cod_ciclo,cod_plantarif,cod_uso,cod_empresa,cod_tecnologia    --Inc.- 76605|COL|28/01/2009|JJR.-
   INTO LN_CodCiclo,LV_CodPlanActual,LV_UsoActual,LN_Grupo, LV_Codtecnologia --Inc.- 76605|COL|28/01/2009|JJR.-
   FROM ga_abocel
   WHERE num_abonado = LN_NumAbonado;

   SV_Tabla := 'FA_CICLFACT';
   SV_Act := 'S';

   SELECT COUNT(1) INTO LN_Cant
   FROM fa_ciclfact
   WHERE cod_ciclo = LN_CodCiclo
   AND fec_desdellam = LD_FecEjec
   AND ind_facturacion = 0;

   IF LN_Cant=0 THEN
      RAISE ERROR_CICLO;
   ELSE
      --BUSCO DATOS DEL NUEVO PLAN
      SV_Tabla := 'PV_PARAM_ABOCEL';
      SV_Act := 'S';
      SELECT cod_plantarif INTO LV_CodPlanNuevo
      FROM pv_param_abocel
      WHERE num_os = EN_NumOS;

      --LIMITE - IMPORTE DEL LIMITE
      SV_Tabla := 'LIMITE_PLAN-LIMITE';
      SV_Act := 'S';
      -- INI COL 73515|12-12-2008|SAQL
      /*
      SELECT  a.cod_limcons,b.imp_limite
      INTO  LV_CodLimcons,LN_ImpLimite
      FROM    tol_limite_plan_td a,tol_limite_td b
      WHERE  a.cod_plantarif=LV_CodPlanNuevo
      AND      a.ind_default='S'
      AND   SYSDATE BETWEEN a.fec_desde and NVL(a.fec_hasta,SYSDATE)
      AND   b.cod_limcons=a.cod_limcons
      AND   SYSDATE BETWEEN b.fec_desde and NVL(b.fec_hasta,SYSDATE);
      */
      -- FIN COL

      --DATOS DEL PLAN
      SV_Tabla := 'TA_PLANTARIF';
      SV_Act := 'S';
      -- Inicio Inc. 76605|COL|27/01/2009|JJR.-
      /*SELECT  tip_plantarif,cod_cargobasico,cod_tiplan,num_dias
      INTO     LV_TipPlan ,LV_CodCargoBasico,LV_CodTiplanNue,LN_NumDiasNuevo
      FROM   ta_plantarif
      WHERE cod_plantarif=LV_CodPlanNuevo;
      */
      SELECT a.tip_plantarif, a.cod_cargobasico, a.cod_tiplan,num_dias, b.cod_planserv
      INTO LV_TipPlan ,LV_CodCargoBasico,LV_CodTiplanNue,LN_NumDiasNuevo,LV_CodPlanServ
      FROM ta_plantarif a, ga_plantecplserv b
      WHERE a.cod_plantarif = LV_CodPlanNuevo
      AND a.cod_plantarif = b.cod_plantarif
      and a.cod_producto  = b.cod_producto
      and b.cod_tecnologia = LV_Codtecnologia;

      UPDATE GA_ABOCEL
      SET cod_planserv = LV_CodPlanServ
      WHERE num_abonado = LN_NumAbonado;

      -- Fin Inc. 76605|COL|27/01/2009|JJR.-

      -- INI COL 73515
      IF LV_CodTiplanNue = GE_FN_DEVVALPARAM('GA',1,'TIPOPOSTPAGO')  THEN
         SELECT a.cod_limcons,b.imp_limite
         INTO LV_CodLimcons,LN_ImpLimite
         FROM tol_limite_plan_td a,tol_limite_td b
         WHERE  a.cod_plantarif = LV_CodPlanNuevo
         AND a.ind_default = 'S'
         AND SYSDATE BETWEEN a.fec_desde and NVL(a.fec_hasta,SYSDATE)
         AND b.cod_limcons = a.cod_limcons
         AND SYSDATE BETWEEN b.fec_desde and NVL(b.fec_hasta,SYSDATE);
      ELSE
         LV_CodLimcons := '-1';
         LN_ImpLimite := 0;
      END IF;
      -- FIN COL 73515

      --PLAN FRECUENTE
      LN_IndFriends := 0;
      SV_Tabla := 'TA_PLANES_FRECUENTES';
      SV_Act := 'S';
      SELECT COUNT(1)
      INTO LN_Cant
      FROM ta_planes_frecuentes
      WHERE cod_plantarif = LV_CodPlanNuevo;

      IF LN_Cant>0 THEN
         LN_IndFriends:=1;
      END IF;

      --VERIFICO SI TIENE UN REGISTRO DEL MISMO FECHA DE INICIO
      SV_Tabla := 'GA_INTARCELA';
      SV_Act := 'S';
      SELECT COUNT(1) INTO LN_Cant
      FROM ga_intarcel
      WHERE cod_cliente = LN_CodCliente
      AND num_abonado = LN_NumAbonado
      AND fec_desde = LD_FecEjec;
      IF  LN_Cant = 0 THEN
         --REGISTRO CAMBIO DE PLAN A CICLO INTARCEL
         SV_Tabla := 'GA_INTARCELB';
         SV_Act := 'S';
         --     SELECT ind_numero, ind_diasesp, cod_celda, num_serie, num_celular, cod_plancom, cod_planserv --Inc. 76605|COL|27/01/2009|JJR.-
         SELECT ind_numero, ind_diasesp, cod_celda, num_serie, num_celular, cod_plancom, --Inc. 76605|COL|27/01/2009|JJR.-
         cod_grpserv, cod_grupo, cod_portador, cod_uso, num_imsi, num_min_mdn
         --     INTO LN_IndNumero, LN_IndDiasesp, LV_CodCelda, LV_NumSerie, LN_NumCelular, LN_CodPlanCom, LV_CodPlanServ --Inc. 76605|COL|27/01/2009|JJR.-
         INTO LN_IndNumero, LN_IndDiasesp, LV_CodCelda, LV_NumSerie, LN_NumCelular, LN_CodPlanCom, --Inc. 76605|COL|27/01/2009|JJR.-
         LV_CodGrpServ, LN_CodGrupo, LN_CodPortador, LN_CodUso, LV_NumImsi, LV_NumMinMdn
         FROM ga_intarcel
         WHERE cod_cliente = LN_CodCliente
         AND num_abonado = LN_NumAbonado
         AND SYSDATE BETWEEN fec_desde and fec_hasta;

         SV_Tabla := 'GA_INTARCELC';
         SV_Act := 'U';
         UPDATE ga_intarcel
         SET fec_hasta = LD_FecEjec-1/86400
         WHERE cod_cliente = LN_CodCliente
         AND num_abonado = LN_NumAbonado
         AND SYSDATE BETWEEN fec_desde and fec_hasta;

         SV_Tabla := 'GA_INTARCELD';
         SV_Act := 'I';
         INSERT INTO ga_intarcel (
            cod_cliente, num_abonado, ind_numero, fec_desde, fec_hasta,
            imp_limconsumo, ind_friends, ind_diasesp, cod_celda, tip_plantarif,
            cod_plantarif, num_serie, num_celular, cod_cargobasico, cod_ciclo,
            cod_plancom, cod_planserv, cod_grpserv, cod_grupo, cod_portador,
            cod_uso, num_imsi, num_min_mdn
         ) VALUES (
            LN_CodCliente, LN_NumAbonado, LN_IndNumero, LD_FecEjec, TO_DATE('31-12-3000','dd-mm-yyyy'),
            LN_ImpLimite, LN_IndFriends, LN_IndDiasesp, LV_CodCelda, LV_TipPlan,
            LV_CodPlanNuevo, LV_NumSerie, LN_NumCelular, LV_CodCargoBasico, LN_CodCiclo,
            LN_CodPlanCom, LV_CodPlanServ, LV_CodGrpServ, LN_CodGrupo, LN_CodPortador,
            LN_CodUso, LV_NumImsi, LV_NumMinMdn
         );

         --GA_INTARCEL_ACCIONES_TO
         IF LV_CodOs IN ('10020','10022','10029') THEN
            BEGIN
               SV_Tabla := 'GA_INTARCEL_ACCIONES_TO';
               SV_Act := 'S';
               SELECT COUNT(1) INTO LN_Cant
               FROM ga_intarcel_acciones_to
               WHERE cod_cliente = LN_CodCliente
               AND num_abonado = LN_NumAbonado
               AND fec_desde = LD_FecEjec
               AND cod_actabo = 'CT';
            EXCEPTION
               WHEN NO_DATA_FOUND THEN
                  LN_Cant := 0;
               WHEN OTHERS THEN
                  LN_Cant := -1;
            END;
            IF LN_Cant = 0 THEN
               SV_Tabla := 'PV_ACTUALIZA_CAMB_COMERC_PR';
               SV_Act := 'P';
               Pv_Actualiza_Camb_Comerc_Pr(LN_CodCliente, LN_NumAbonado, '0', 'CT', LD_FecEjec, LV_ErrorAplic, LV_ErrorGlosa, SV_Code, SV_Errm, LV_Trace);
               IF LV_ErrorAplic = 'FALSE' THEN
                  SV_Estado := '5';
                  RAISE ERROR_ACCIONES;
               END IF;
            END IF;
         END IF;

         --LIMITE DE CONSUMO
         IF LV_CodOs='10020' THEN
            SV_Tabla := 'GA_LIMITE_CLIABO_TOA';
            SV_Act := 'S';
            UPDATE ga_limite_cliabo_to
            SET fec_hasta = LD_FecEjec-1/86400
            WHERE cod_cliente = LN_CodCliente
            AND num_abonado = LN_NumAbonado
            AND SYSDATE BETWEEN fec_desde and NVL(fec_hasta,SYSDATE)
            AND cod_plantarif = LV_CodPlanActual;
            If LV_CodLimcons<>'-1' THEN
               SV_Tabla := 'GA_LIMITE_CLIABO_TOB';
               SV_Act := 'I';
               INSERT INTO ga_limite_cliabo_to (
                  cod_cliente, num_abonado, cod_limcons, fec_desde, fec_hasta,
                  nom_usuarora, fec_asignacion, cod_plantarif
               ) VALUES (
                  LN_CodCliente, LN_NumAbonado, LV_CodLimcons, LD_FecEjec, NULL,
                  USER, SYSDATE, LV_CodPlanNuevo
               );
            END IF;
         END IF;
      ELSE
         SV_Tabla := 'GA_INTARCELE';
         SV_Act := 'S';
         UPDATE ga_intarcel
         SET cod_plantarif = LV_CodPlanNuevo
         ,cod_cargobasico=LV_CodCargoBasico
         --,imp_limconsumo=LV_CodCargoBasico  --COL-74651|17-12-2008|GEZ
         ,imp_limconsumo=LN_ImpLimite     --COL-74651|17-12-2008|GEZ
         ,cod_planserv=LV_CodPlanServ --Inc.76605|COL|28/01/2009|JJR.-
         WHERE cod_cliente = LN_CodCliente
         AND num_abonado = LN_NumAbonado
         AND fec_desde = LD_FecEjec;
         IF LV_CodOs='10020' THEN
            IF LV_CodLimcons<>'-1' THEN
               SV_Tabla := 'GA_LIMITE_CLIABO_TOC';
               SV_Act := 'S';
               SELECT COUNT(1)
               INTO LN_Cant
               FROM ga_limite_cliabo_to
               WHERE cod_cliente = LN_CodCliente
               AND num_abonado = LN_NumAbonado
               AND cod_plantarif = LV_CodPlanActual
               AND fec_desde = LD_FecEjec;
               IF LN_Cant=0 THEN
                  --LIMITE DE CONSUMO
                  SV_Tabla := 'GA_LIMITE_CLIABO_TOD';
                  SV_Act := 'U';
                  UPDATE ga_limite_cliabo_to
                  SET fec_hasta = LD_FecEjec-1/86400
                  WHERE cod_cliente = LN_CodCliente
                  AND num_abonado = LN_NumAbonado
                  AND SYSDATE BETWEEN fec_desde and NVL(fec_hasta,SYSDATE)
                  AND cod_plantarif = LV_CodPlanActual;

                  SV_Tabla := 'GA_LIMITE_CLIABO_TOE';
                  SV_Act := 'I';
                  INSERT INTO ga_limite_cliabo_to (
                     cod_cliente, num_abonado, cod_limcons, fec_desde, fec_hasta,
                     nom_usuarora, fec_asignacion, cod_plantarif
                  ) VALUES (
                     LN_CodCliente, LN_NumAbonado, LV_CodLimcons, LD_FecEjec, NULL,
                     USER, SYSDATE, LV_CodPlanNuevo
                  );
               ELSE
                  SV_Tabla := 'GA_LIMITE_CLIABO_THA';
                  SV_Act := 'I';
                  INSERT INTO ga_limite_cliabo_th
                  (cod_cliente, num_abonado, cod_limcons, cod_plantarif, fec_desde, fec_historico, fec_hasta, nom_usuarora, fec_asignacion, cod_causa_hist, est_aplica_tol, fec_aplica_tol)
                  SELECT cod_cliente, num_abonado, cod_limcons, cod_plantarif, fec_desde, SYSDATE, fec_hasta, nom_usuarora, fec_asignacion, 'CT_LC', est_aplica_tol, fec_aplica_tol
                  FROM ga_limite_cliabo_to
                  WHERE cod_cliente = LN_CodCliente
                  AND num_abonado = LN_NumAbonado
                  AND cod_plantarif = LV_CodPlanActual
                  AND fec_desde = LD_FecEjec;

                  SV_Tabla := 'GA_LIMITE_CLIABO_TOF';
                  SV_Act := 'D';
                  DELETE ga_limite_cliabo_to
                  WHERE cod_cliente = LN_CodCliente
                  AND num_abonado = LN_NumAbonado
                  AND cod_plantarif = LV_CodPlanActual
                  AND fec_desde = LD_FecEjec;

                  SV_Tabla := 'GA_LIMITE_CLIABO_TOG';
                  SV_Act := 'I';
                  INSERT INTO ga_limite_cliabo_to
                  (cod_cliente, num_abonado, cod_limcons, fec_desde, fec_hasta, nom_usuarora, fec_asignacion, cod_plantarif)
                  VALUES
                  (LN_CodCliente,LN_NumAbonado,LV_CodLimcons,LD_FecEjec,NULL,USER,SYSDATE,LV_CodPlanNuevo);
               END IF; --IF LN_Cant=0 THEN tiene un limite a futuro
            END IF;
         END IF; --OOSS 10020
         -- INI COL|77090|30-01-2009|SAQL
         BEGIN
            SV_Tabla := 'GA_INTARCEL_ACCIONES_TO';
            SV_Act := 'S';
            SELECT COUNT(1) INTO LN_Cant
            FROM ga_intarcel_acciones_to
            WHERE cod_cliente = LN_CodCliente
            AND num_abonado = LN_NumAbonado
            AND fec_desde = LD_FecEjec
            AND cod_actabo = 'CT';
         EXCEPTION
            WHEN NO_DATA_FOUND THEN
               LN_Cant := 0;
            WHEN OTHERS THEN
               LN_Cant := -1;
         END;
         IF LN_Cant = 0 THEN
            SV_Tabla := 'PV_ACTUALIZA_CAMB_COMERC_PR';
            SV_Act := 'P';
            Pv_Actualiza_Camb_Comerc_Pr(LN_CodCliente, LN_NumAbonado, '0', 'CT', LD_FecEjec, LV_ErrorAplic, LV_ErrorGlosa, SV_Code, SV_Errm, LV_Trace);
            IF LV_ErrorAplic = 'FALSE' THEN
               SV_Estado := '5';
               RAISE ERROR_ACCIONES;
            END IF;
         END IF;
         -- FIN COL|77090|30-01-2009|SAQL
      END IF;--VERIFICO SI TIENE UN REGISTRO DEL MISMO FECHA DE INICIO

      --REVISION ABONADO CERO
      IF LV_CodOs in ('10022','10029') THEN
         --VERIFICO SI TIENE UN REGISTRO DEL MISMO FECHA DE INICIO
         SV_Tabla := 'GA_INTARCELF';
         SV_Act := 'S';
         SELECT COUNT(1)
         INTO LN_Cant
         FROM ga_intarcel
         WHERE cod_cliente = LN_CodCliente
         AND num_abonado = 0
         AND fec_desde = LD_FecEjec
         AND cod_plantarif = LV_CodPlanActual;
         IF LN_Cant=0 THEN
            SV_Tabla := 'GA_INTARCELG';
            SV_Act := 'S';
            SELECT COUNT(1)
            INTO LN_Cant
            FROM ga_intarcel
            WHERE cod_cliente = LN_CodCliente
            AND num_abonado = 0
            AND fec_desde = LD_FecEjec
            AND cod_plantarif = LV_CodPlanNuevo;
            IF LN_Cant = 0 THEN
               --REGISTRO CAMBIO DE PLAN A CICLO INTARCEL
               SV_Tabla := 'GA_INTARCELH';
               SV_Act := 'S';
               SELECT ind_numero, ind_diasesp, cod_celda, num_serie, num_celular, cod_plancom, cod_planserv
               , cod_grpserv, cod_grupo, cod_portador, cod_uso, num_imsi, num_min_mdn
               INTO LN_IndNumero, LN_IndDiasesp, LV_CodCelda, LV_NumSerie, LN_NumCelular, LN_CodPlanCom, LV_CodPlanServ
               , LV_CodGrpServ, LN_CodGrupo, LN_CodPortador, LN_CodUso, LV_NumImsi, LV_NumMinMdn
               FROM ga_intarcel
               WHERE cod_cliente = LN_CodCliente
               AND num_abonado = 0
               AND SYSDATE BETWEEN fec_desde and fec_hasta;

               SV_Tabla := 'GA_INTARCELI';
               SV_Act := 'U';
               UPDATE ga_intarcel
               SET fec_hasta = LD_FecEjec-1/86400
               WHERE cod_cliente = LN_CodCliente
               AND num_abonado = 0
               AND SYSDATE BETWEEN fec_desde and fec_hasta;

               SV_Tabla := 'GA_INTARCELJ';
               SV_Act := 'I';
               -- Inicio Inc. 76605|COL|27/01/2009|JJR.-
               SELECT b.cod_planserv
               INTO LV_CodPlanServ
               FROM ta_plantarif a, ga_plantecplserv b
               WHERE a.cod_plantarif = LV_CodPlanNuevo
               AND a.cod_plantarif = b.cod_plantarif
               and a.cod_producto = b.cod_producto
               and b.cod_tecnologia = LV_Codtecnologia;
               /* abonado cero
               UPDATE GA_ABOCEL
               SET cod_planserv = LV_CodPlanServ
               WHERE num_abonado = LN_NumAbonado;
               */
               -- Fin Inc. 76605|COL|27/01/2009|JJR.-

               INSERT INTO ga_intarcel
               (cod_cliente, num_abonado, ind_numero, fec_desde, fec_hasta, imp_limconsumo, ind_friends, ind_diasesp, cod_celda, tip_plantarif
               , cod_plantarif, num_serie, num_celular, cod_cargobasico, cod_ciclo, cod_plancom, cod_planserv
               , cod_grpserv, cod_grupo, cod_portador, cod_uso, num_imsi, num_min_mdn)
               VALUES(LN_CodCliente,0,LN_IndNumero,LD_FecEjec,TO_DATE('31-12-3000','dd-mm-yyyy'),LN_ImpLimite,LN_IndFriends, LN_IndDiasesp, LV_CodCelda,LV_TipPlan
               ,LV_CodPlanNuevo, LV_NumSerie, LN_NumCelular,LV_CodCargoBasico,LN_CodCiclo, LN_CodPlanCom, LV_CodPlanServ
               , LV_CodGrpServ, LN_CodGrupo, LN_CodPortador, 4, LV_NumImsi, LV_NumMinMdn);

               BEGIN
                  SV_Tabla := 'GA_INTARCEL_ACCIONES_TO';
                  SV_Act := 'S';
                  SELECT COUNT(1)
                  INTO     LN_Cant
                  FROM    ga_intarcel_acciones_to
                  WHERE  cod_cliente     = LN_CodCliente
                  AND      num_abonado = 0
                  AND      fec_desde      = LD_FecEjec
                  AND      cod_actabo    = 'CT';
               EXCEPTION
                  WHEN NO_DATA_FOUND THEN
                     LN_Cant := 0;
                  WHEN OTHERS THEN
                     LN_Cant := -1;
               END;
               IF LN_Cant = 0 THEN
                  SV_Tabla := 'PV_ACTUALIZA_CAMB_COMERC_PR';
                  SV_Act := 'P';
                  Pv_Actualiza_Camb_Comerc_Pr(LN_CodCliente,0, '0', 'CT', LD_FecEjec, LV_ErrorAplic, LV_ErrorGlosa, SV_Code, SV_Errm, LV_Trace);
                  IF LV_ErrorAplic = 'FALSE' THEN
                     SV_Estado := '5';
                     RAISE ERROR_ACCIONES;
                  END IF;
               END IF;
               --LIMITE DE CONSUMO
               SV_Tabla := 'GA_LIMITE_CLIABO_TOH';
               SV_Act := 'U';
               UPDATE ga_limite_cliabo_to
               SET fec_hasta = LD_FecEjec-1/86400
               WHERE cod_cliente = LN_CodCliente
               AND num_abonado = 0
               AND SYSDATE BETWEEN fec_desde and NVL(fec_hasta,SYSDATE)
               AND cod_plantarif = LV_CodPlanActual;

               SV_Tabla := 'GA_LIMITE_CLIABO_TOI';
               SV_Act := 'I';
               INSERT INTO ga_limite_cliabo_to
               (cod_cliente, num_abonado, cod_limcons, fec_desde, fec_hasta, nom_usuarora, fec_asignacion, cod_plantarif)
               VALUES
               (LN_CodCliente,0,LV_CodLimcons,LD_FecEjec,NULL,USER,SYSDATE,LV_CodPlanNuevo);
            END IF;
         ELSE
            --ACTUALIZO INTARCEL
            SV_Tabla := 'GA_INTARCELK';
            SV_Act := 'U';
            UPDATE ga_intarcel
            SET      cod_plantarif=LV_CodPlanNuevo
            ,cod_cargobasico=LV_CodCargoBasico
            --,imp_limconsumo=LV_CodCargoBasico --COL-74651|17-12-2008|GEZ
            ,imp_limconsumo=LN_ImpLimite      --COL-74651|17-12-2008|GEZ
            WHERE cod_cliente     = LN_CodCliente
            AND     num_abonado = 0
            AND     fec_desde       = LD_FecEjec;

            SV_Tabla := 'GA_LIMITE_CLIABO_TOJ';
            SV_Act := 'S';
            SELECT COUNT(1)
            INTO     LN_Cant
            FROM   ga_limite_cliabo_to
            WHERE cod_cliente     = LN_CodCliente
            AND     num_abonado = 0
            AND     cod_plantarif   = LV_CodPlanActual
            AND     fec_desde       = LD_FecEjec;
            IF LN_Cant=0 THEN
               --LIMITE DE CONSUMO
               SV_Tabla := 'GA_LIMITE_CLIABO_TOK';
               SV_Act := 'U';
               UPDATE ga_limite_cliabo_to
               SET      fec_hasta=LD_FecEjec-1/86400
               WHERE cod_cliente     = LN_CodCliente
               AND     num_abonado = 0
               AND     SYSDATE BETWEEN fec_desde and NVL(fec_hasta,SYSDATE)
               AND     cod_plantarif=LV_CodPlanActual;

               SV_Tabla := 'GA_LIMITE_CLIABO_TOL';
               SV_Act := 'I';
               INSERT INTO ga_limite_cliabo_to
               (cod_cliente, num_abonado, cod_limcons, fec_desde, fec_hasta, nom_usuarora, fec_asignacion, cod_plantarif)
               VALUES
               (LN_CodCliente,0,LV_CodLimcons,LD_FecEjec,NULL,USER,SYSDATE,LV_CodPlanNuevo);
            ELSE
               SV_Tabla := 'GA_LIMITE_CLIABO_THB';
               SV_Act := 'I';
               INSERT INTO ga_limite_cliabo_th
               (cod_cliente, num_abonado, cod_limcons, cod_plantarif, fec_desde, fec_historico, fec_hasta, nom_usuarora, fec_asignacion, cod_causa_hist, est_aplica_tol, fec_aplica_tol)
               SELECT cod_cliente, num_abonado, cod_limcons, cod_plantarif, fec_desde, SYSDATE, fec_hasta, nom_usuarora, fec_asignacion, 'CT_LC', est_aplica_tol, fec_aplica_tol
               FROM ga_limite_cliabo_to
               WHERE cod_cliente     = LN_CodCliente
               AND     num_abonado = 0
               AND     cod_plantarif   = LV_CodPlanActual
               AND     fec_desde       = LD_FecEjec;

               SV_Tabla := 'GA_LIMITE_CLIABO_TOM';
               SV_Act := 'D';
               DELETE ga_limite_cliabo_to
               WHERE cod_cliente = LN_CodCliente
               AND num_abonado = 0
               AND cod_plantarif = LV_CodPlanActual
               AND fec_desde = LD_FecEjec;

               SV_Tabla := 'GA_LIMITE_CLIABO_TON';
               SV_Act := 'I';
               INSERT INTO ga_limite_cliabo_to
               (cod_cliente, num_abonado, cod_limcons, fec_desde, fec_hasta, nom_usuarora, fec_asignacion, cod_plantarif)
               VALUES
               (LN_CodCliente,0,LV_CodLimcons,LD_FecEjec,NULL,USER,SYSDATE,LV_CodPlanNuevo);
            END IF;
         END IF;
      END IF;--FIN REVISION DE ABONADO CERO

      --COMANDO DE CAMBIO DE PLAN HIBRIDO->HIBRIDO
      SV_TABLA := 'GE_FN_DEVVALPARAM1';
      SV_ACT := 'F';
      LV_UsoHibrido  := GE_FN_DEVVALPARAM('GA', 1, 'USO_HIBRIDO_GSM_TDMA');

      SV_TABLA := 'GE_FN_DEVVALPARAM2';
      SV_ACT := 'F';
      LV_TiPlanHib:= GE_FN_DEVVALPARAM('GA', 1, 'TIP_PLAN_HIBRIDO');

      IF LV_UsoActual = LV_UsoHibrido AND LV_CodTiplanNue = LV_TiPlanHib THEN
         SV_Tabla := 'PV_ICC_CAMBIOPLAN_HIB_PR';
         SV_Act:='P';
         PV_ICC_CAMBIOPLAN_HIB_PR(LN_NumAbonado,LV_CodPlanNuevo,SV_Code,SV_Errm,SV_Estado,LV_ErrorGlosa,SV_Tabla,SV_Act,SN_Evento);
         IF SV_Estado <> '3' THEN
            RAISE ERROR_PROCESO;
         END IF;
      END IF;

      --INSCRIPCION DE GA_FINCICLO
      SELECT cod_ciclfact
      INTO LN_CodCiclfact
      FROM fa_ciclfact
      WHERE cod_ciclo = LN_CodCiclo
      AND fec_desdellam = LD_FecEjec;

      SELECT COUNT(1)
      INTO LN_Cant
      FROM ga_finciclo
      WHERE cod_cliente = LN_CodCliente
      AND num_abonado = LN_NumAbonado
      AND cod_ciclfact = LN_CodCiclfact ;

      IF LN_Cant>0 THEN
         UPDATE ga_finciclo
         SET tip_plantarif        = LV_TipPlan,
         cod_plantarif      = LV_CodPlanNuevo,
         cod_cargobasico = LV_CodCargoBasico
         WHERE cod_cliente    = LN_NumAbonado
         AND     num_abonado= LN_CodCliente
         AND     cod_ciclfact    =  LN_CodCiclfact ;
      ELSE
         INSERT INTO ga_finciclo (cod_cliente,cod_ciclfact,num_abonado,cod_producto,tip_plantarif,cod_plantarif,cod_cargobasico,
         cod_grupo,fec_desdellam,tip_plantant,cod_grupant,num_dias)
         VALUES (LN_CodCliente, LN_CodCiclfact ,LN_NumAbonado,1,LV_TipPlan,LV_CodPlanNuevo,LV_CodCargoBasico,LN_Grupo,
         LD_FecEjec,NULL,NULL,LN_NumDiasNuevo);
      END IF;
   END IF; --LN_Cant=0 THEN COINCIDE LA FECHA DE EJECUCION CON FECHA DE CORTE DE CICLO
EXCEPTION
   WHEN ERROR_ACCIONES THEN
      SV_Estado :='4';
      SN_CodMsg :=0;
      SN_Evento:=0;
   WHEN ERROR_CICLO THEN
      --SV_Estado :='5';     --COL-73376|21-01-2008|GEZ
      SV_Estado :='6';       --COL-73376|21-01-2008|GEZ
      SV_Code  :='0';
      SV_Errm  :='0';
      --SN_CodMsg := 505; --COL-73376|21-01-2008|GEZ
      SN_CodMsg := 200;  --COL-73376|21-01-2008|GEZ
      IF NOT ge_errores_pg.mensajeerror(SN_CodMsg, LV_MensajeError) THEN
         LV_MensajeError := 'Error No Clasificado';
      END IF;
      LV_DesError := 'pv_cambio_plan_abo_pr(' || EN_NumOs ||')';
      LV_DesError :=LV_DesError ||'-T:'||SV_Tabla;
      LV_DesError :=LV_DesError ||'('||SV_Act||')';
      LV_DesError :=LV_DesError ||'-'|| SV_Errm;
      SN_Evento := ge_errores_pg.grabarpl( SN_Evento,'PV',LV_MensajeError,'1.0',USER,'PV_CAMBIO_PLAN_ABO_PR', LV_Sql, SN_CodMsg, LV_DesError);
   WHEN OTHERS THEN
      SV_Estado :='4';
      SV_Code  :=SQLCODE;
      SV_Errm  :=SQLERRM;
      SN_CodMsg := 925;
      IF NOT ge_errores_pg.mensajeerror(SN_CodMsg, LV_MensajeError) THEN
         LV_MensajeError := 'Error No Clasificado';
      END IF;
      LV_DesError := 'pv_cambio_plan_abo_pr(' || EN_NumOs ||')';
      LV_DesError :=LV_DesError ||'-T:'||SV_Tabla;
      LV_DesError :=LV_DesError ||'('||SV_Act||')';
      LV_DesError :=LV_DesError ||'-'|| SV_Errm;
      SN_Evento := ge_errores_pg.grabarpl( SN_Evento,'PV',LV_MensajeError,'1.0',USER,'PV_CAMBIO_PLAN_ABO_PR',LV_Sql,SN_CodMsg,LV_DesError);
END;
 --FIN COL 73515|12-12-2008|GEZ

PROCEDURE PV_ABOPLAN_EMP_BATCH_PR(EN_PRODUCTO     IN GA_ABOCEL.COD_PRODUCTO%TYPE,
                              EN_NUM_ABONADO  IN ga_abocel.NUM_ABONADO%TYPE,
                              EN_EMPRESA      IN GA_ABOCEL.COD_EMPRESA%TYPE,
                              EV_PLANTARIF    IN GA_ABOCEL.COD_PLANTARIF%TYPE,
                              EV_FECSYS       IN DATE,
                              SV_PROC         IN OUT NOCOPY VARCHAR2 ,
                              SV_TABLA        IN OUT NOCOPY VARCHAR2 ,
                              SV_ACT          IN OUT NOCOPY VARCHAR2 ,
                              SV_SQLCODE      IN OUT NOCOPY VARCHAR2 ,
                              SV_SQLERRM      IN OUT NOCOPY VARCHAR2 ,
                              SV_ERROR        OUT NOCOPY VARCHAR2,
                              SN_cod_retorno  OUT NOCOPY GE_ERRORES_PG.CodError,
                              SV_mens_retorno OUT NOCOPY GE_ERRORES_PG.MsgError,
                              SN_num_evento   OUT NOCOPY GE_ERRORES_PG.Evento)

/*
VERSION 1.0 --64502 col|18-04-2008|EFR
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_ABOPLAN_EMP_BATCH_PR"
      Lenguaje="PL/SQL"
      Fecha="17-04-2006"
      Versión="1.0"
      Diseñador="Manuel Acevedo M"
          Programador="Orlando Cabezas B"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
              <Descripción></Descripción>
       <Parámetros>
         <Entrada>
                        <param nom="EN_PRODUCTO"           Tipo="NUMERICO">Numero de producto</param>
                        <param nom="EN_NUM_ABONADO"        Tipo="NUMERICO">abonado</param>
                        <param nom="EN_EMPRESA"            Tipo="NUMERICO">codigo empresa</param>
                        <param nom="EV_PLANTARIF"          Tipo="CARACTER">Plan Tarifario </param>
                        <param nom="EV_FECSYS"             Tipo="DATE">fecha sistema</param>

         </Entrada>
         <Salida>
            <param nom="SV_PROC"    Tipo="CARACTER">PROCESO</param>
            <param nom="SV_TABLA"   Tipo="CARACTER">TABLA</param>
            <param nom="SV_ACT"     Tipo="CARACTER">ACCION SOBRE LA TABLA</param>
            <param nom="SV_SQLCODE"    Tipo="CARACTER">Codigo ORACLE</param>
            <param nom="SV_SQLERRM"   Tipo="CARACTER">Mensaje ORACLE</param>
            <param nom="SV_ERROR"     Tipo="CARACTER">RETORNO</param>
            <param nom="SN_cod_retorno"    Tipo="NUMERICO">Codigo error de negocio Retornado</param>
            <param nom="SV_mens_retorno"   Tipo="CARACTER">Mensaje error de negocio Retornado</param>
            <param nom="SN_num_evento"     Tipo="ge_errores_pg.Evento">Nro de evento</param>
         </Salida>
      </Parámetros>
  </Elemento>
</Documentación>
*/

                               IS

LV_CICLO GA_ABOCEL.COD_CICLO%TYPE;
LV_DIAS TA_PLANTARIF.NUM_DIAS%TYPE;
LV_CARGOBASICO TA_PLANTARIF.COD_CARGOBASICO%TYPE;
LV_TIPPLAN TA_PLANTARIF.TIP_PLANTARIF%TYPE;
LV_FECHADLL FA_CICLFACT.FEC_DESDELLAM%TYPE;
LV_CICLFACT FA_CICLFACT.COD_CICLFACT%TYPE;
LV_ABONADO GA_ABOCEL.NUM_ABONADO%TYPE;
LV_CLIENTE GA_ABOCEL.COD_CLIENTE%TYPE;
LV_PLANANT GA_ABOCEL.COD_PLANTARIF%TYPE;
LV_TIP_PLANANT GA_ABOCEL.COD_PLANTARIF%TYPE;
LV_des_error         GE_ERRORES_PG.DesEvent;
  sSql                 GE_ERRORES_PG.vQuery;

LV_ROWID ROWID;
CURSOR ABCEL IS
 SELECT NUM_ABONADO,COD_CLIENTE,COD_PLANTARIF,TIP_PLANTARIF
 FROM GA_ABOCEL
 WHERE COD_EMPRESA=EN_EMPRESA
 AND NUM_ABONADO= EN_NUM_ABONADO
 AND COD_SITUACION IN ('AOP','AOA','CVA','RDA','ATP','ATA','SAO','SAT','SCV',
 'SRD','AOS','ATS','CVS','RDS','RAO','RAT','RCV','RRD');
BEGIN
  SV_PROC:='PV_ABOPLAN_EMP_BATCH_PR';
  SV_TABLA:='GA_EMPRESA';
  SV_ACT:='S';
  SN_cod_retorno   := 0;
  SV_mens_retorno  := 'OK';
  SN_num_evento          := 0;
  ssql :='' ;


  SELECT A.COD_CICLO
  INTO LV_CICLO
  FROM GE_CLIENTES A, GA_EMPRESA B
  WHERE A.COD_CLIENTE=B.COD_CLIENTE
  AND B.COD_EMPRESA=EN_EMPRESA;

  SV_TABLA:='TA_PLANTARIF';
  SV_ACT:='S';

  SELECT NUM_DIAS,COD_CARGOBASICO,TIP_PLANTARIF
  INTO LV_DIAS,LV_CARGOBASICO,LV_TIPPLAN
  FROM TA_PLANTARIF
  WHERE COD_PRODUCTO = EN_PRODUCTO
  AND COD_PLANTARIF = EV_PLANTARIF;

  SV_TABLA:='FA_CICLFACT';
  SV_ACT:='S';

	  SELECT FEC_DESDELLAM,COD_CICLFACT
	  INTO LV_FECHADLL,LV_CICLFACT
	  FROM FA_CICLFACT
	  WHERE COD_CICLO = LV_CICLO
	  AND TRUNC(TO_DATE(EV_FECSYS,'DD-MM-YYYY')) <= TRUNC(FEC_DESDELLAM)
	  AND IND_FACTURACION = 0
	  AND ROWNUM = 1;

  IF EN_PRODUCTO=1 THEN
    OPEN ABCEL;
  END IF;

  LOOP

		    IF EN_PRODUCTO=1 THEN
		        SV_TABLA:='CUR.ABCEL';
		        SV_ACT:='S';

			   FETCH ABCEL INTO LV_ABONADO,LV_CLIENTE,LV_PLANANT,LV_TIP_PLANANT;
		        EXIT WHEN ABCEL%NOTFOUND;
		    END IF;

		    BEGIN
		                SV_TABLA := 'GA_FINCICLO';
		                SV_ACT := 'S';
		                SELECT ROWID
		                INTO LV_ROWID
		                FROM GA_FINCICLO
		                WHERE COD_CLIENTE = LV_CLIENTE
		                AND NUM_ABONADO = LV_ABONADO
		                AND COD_CICLFACT = LV_CICLFACT;
		                   SV_ACT := 'U';
		                       UPDATE GA_FINCICLO
		                       SET TIP_PLANTARIF = LV_TIPPLAN,
		                           COD_PLANTARIF = EV_PLANTARIF,
		                           COD_CARGOBASICO = LV_CARGOBASICO,
		                           COD_GRUPO = EN_EMPRESA,
		                           FEC_DESDELLAM = DECODE(FEC_DESDELLAM,NULL,LV_FECHADLL,
		                                            FEC_DESDELLAM),
		                           TIP_PLANTANT = LV_TIP_PLANANT,
		                           COD_GRUPANT = EN_EMPRESA,
		                           NUM_DIAS = LV_DIAS
		                WHERE ROWID = LV_ROWID;
		                SV_ERROR:='0';
		    EXCEPTION
		      WHEN NO_DATA_FOUND THEN
		        BEGIN
		           SV_ACT := 'I';
		           INSERT INTO GA_FINCICLO (COD_CLIENTE,COD_CICLFACT,NUM_ABONADO,COD_PRODUCTO,
		           TIP_PLANTARIF,COD_PLANTARIF,COD_CARGOBASICO,COD_GRUPO,FEC_DESDELLAM,
		           TIP_PLANTANT,COD_GRUPANT,NUM_DIAS)
		           VALUES (LV_CLIENTE,LV_CICLFACT,LV_ABONADO,EN_PRODUCTO,LV_TIPPLAN,
		           EV_PLANTARIF,LV_CARGOBASICO,EN_EMPRESA,LV_FECHADLL,LV_TIP_PLANANT,EN_EMPRESA,
		           LV_DIAS);
		           --V_ERROR:='0';
		        EXCEPTION
		           WHEN OTHERS THEN
		              SV_SQLCODE := SQLCODE;
		              SV_SQLERRM := SQLERRM;
		              SV_ERROR:='4';
		               SV_mens_retorno:= CV_error_no_clasif;
		      LV_des_error:='PV_ABOPLAN_EMP_BATCH_PR(' || EN_PRODUCTO || EN_NUM_ABONADO ||EN_EMPRESA || EV_PLANTARIF ||EV_FECSYS || ')';
		      SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
		     'PV_CAMBIOPLAN_BATCH_PG.PV_ABOPLAN_EMP_BATCH_PR', sSql, SQLCODE, LV_des_error );

		        END;
		      WHEN OTHERS THEN
		         SV_SQLCODE := SQLCODE;
		         SV_SQLERRM := SQLERRM;
		         SV_ERROR:='4';
		          SV_mens_retorno:= CV_error_no_clasif;
		      LV_des_error:='PV_ABOPLAN_EMP_BATCH_PR(' || EN_PRODUCTO || EN_NUM_ABONADO ||EN_EMPRESA || EV_PLANTARIF ||EV_FECSYS || ')';
		      SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
		     'PV_CAMBIOPLAN_BATCH_PG.PV_ABOPLAN_EMP_BATCH_PR', sSql, SQLCODE, LV_des_error );

		    END;
  END LOOP;

  IF EN_PRODUCTO=1 THEN
    CLOSE ABCEL;
  END IF;

  SV_ERROR:='0';

EXCEPTION

   WHEN NO_DATA_FOUND THEN
		     SV_SQLCODE := SQLCODE;
		     SV_SQLERRM := SQLERRM;
		     SV_ERROR:='4';
		      SV_mens_retorno:= CV_error_no_clasif;
		      LV_des_error:='PV_ABOPLAN_EMP_BATCH_PR(' || EN_PRODUCTO || EN_NUM_ABONADO ||EN_EMPRESA || EV_PLANTARIF ||EV_FECSYS || ')';
		      SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
		     'PV_CAMBIOPLAN_BATCH_PG.PV_ABOPLAN_EMP_BATCH_PR', sSql, SQLCODE, LV_des_error );



END  PV_ABOPLAN_EMP_BATCH_PR;



PROCEDURE PV_ELIM_GA_FINCICLO_PEND_PR(EV_MOVIMIENTO   IN VARCHAR2,
                                        EN_NUM_OS       IN NUMBER ,
                                        EV_COD_OS       IN VARCHAR2,
                                        EV_FECSYS       IN OUT NOCOPY VARCHAR2 ,
                                        EN_CLIENTE      IN NUMBER ,
                                        EN_NUM_ABONADO  IN NUMBER ,
                                        SV_SQLCODE      IN OUT NOCOPY VARCHAR2 ,
                                        SV_SQLERRM      IN OUT NOCOPY VARCHAR2 ,
                                        SV_ERROR        IN OUT NOCOPY VARCHAR2,
                                        SN_cod_retorno  OUT NOCOPY GE_ERRORES_PG.CodError,
                                        SV_mens_retorno OUT NOCOPY GE_ERRORES_PG.MsgError,
                                        SN_num_evento   OUT NOCOPY GE_ERRORES_PG.Evento )


/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_ELIM_GA_FINCICLO_PEND_PR"
      Lenguaje="PL/SQL"
      Fecha="17-04-2006"
      Versión="1.0"
      Diseñador="Manuel Acevedo M"
          Programador="Orlando Cabezas B"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
              <Descripción></Descripción>
       <Parámetros>
         <Entrada>
                        <param nom="EV_MOVIMIENTO"         Tipo="CARACTER">MOVIMIENTO</param>
                        <param nom="EN_NUM_OS"     Tipo="NUMERICO">Numero OOSS</param>
                        <param nom="EV_COD_OS"     Tipo="CARACTER">CODIGO OOSS</param>
                        <param nom="EV_FECSYS"     Tipo="CARACTER">FECHA SYSTEMA</param>
                        <param nom="EN_CLIENTE"            Tipo="NUMERICO">CLIENTE </param>
                        <param nom="EN_NUM_ABONADO"                Tipo="NUMERICO">ABONADO</param>

         </Entrada>
         <Salida>
            <param nom="SV_SQLCODE"    Tipo="CARACTER">Codigo ORACLE</param>
            <param nom="SV_SQLERRM"   Tipo="CARACTER">Mensaje ORACLE</param>
            <param nom="SV_ERROR"     Tipo="CARACTER">RETORNO</param>
            <param nom="SN_cod_retorno"    Tipo="NUMERICO">Codigo error de negocio Retornado</param>
            <param nom="SV_mens_retorno"   Tipo="CARACTER">Mensaje error de negocio Retornado</param>
            <param nom="SN_num_evento"     Tipo="ge_errores_pg.Evento">Nro de evento</param>
         </Salida>
      </Parámetros>
  </Elemento>
</Documentación>
*/

IS

  LV_COD_ESTADO   PV_IORSERV.COD_ESTADO%TYPE;
  LV_FH_EJECUCION date;
  LN_MAX_INTENTOS PV_IORSERV.NUM_INTENTOS%TYPE;
  LN_MOVIMIENTO   NUMBER;
  LV_OBS_DETALLE  PV_PARAM_ABOCEL.OBS_DETALLE%TYPE;
  LN_CICLFACT_AUX GA_FINCICLO.COD_CICLFACT%TYPE;
  LN_IPOS         NUMBER;
  LV_des_error         GE_ERRORES_PG.DesEvent;
  sSql                 GE_ERRORES_PG.vQuery;


BEGIN

    SV_SQLCODE :='';
    SV_SQLERRM :='';
    SV_ERROR   :='4';
    SN_cod_retorno   := 0;
    SV_mens_retorno  := 'OK';
    SN_num_evento        := 0;
    ssql :='' ;

    IF  ((EV_COD_OS  ='10022') OR (EV_COD_OS  ='10029'))  THEN

            SELECT B.OBS_DETALLE
                INTO
                LV_OBS_DETALLE
                FROM  PV_CAMCOM A,PV_PARAM_ABOCEL B
                WHERE
                A.NUM_OS      = EN_NUM_OS AND
                A.NUM_OS      = B.NUM_OS  AND
                A.NUM_ABONADO = EN_NUM_ABONADO ;

                --LN_IPOS := INSTR(LV_OBS_DETALLE,' ');
                --SELECT INSTR(LV_OBS_DETALLE,'') INTO LN_IPOS  FROM DUAL;
                --LN_CICLFACT_AUX :=SUBSTR(LV_OBS_DETALLE,1,LN_IPOS-1);
        LN_CICLFACT_AUX :=LV_OBS_DETALLE;
                DELETE GA_FINCICLO
                WHERE
                NUM_ABONADO  = EN_NUM_ABONADO AND
                COD_CLIENTE  = EN_CLIENTE AND
                COD_CICLFACT = LN_CICLFACT_AUX;

        END IF;

        SV_ERROR      :='0';
        LN_MOVIMIENTO :=TO_NUMBER(EV_MOVIMIENTO);

        IF LN_MOVIMIENTO IS NOT NULL THEN
                        INSERT INTO GA_TRANSACABO (NUM_TRANSACCION,COD_RETORNO,DES_CADENA)
                VALUES (LN_MOVIMIENTO,0,NULL);
        END IF;


EXCEPTION
      WHEN NO_DATA_FOUND  THEN

               SV_SQLCODE := SQLCODE;
           SV_SQLERRM := SQLERRM;
           SV_ERROR := '4';
          WHEN OTHERS  THEN
               SV_SQLCODE := SQLCODE;
           SV_SQLERRM := SQLERRM;
           SV_ERROR := '4';

                   IF LN_MOVIMIENTO IS NOT NULL THEN
                        INSERT INTO GA_TRANSACABO (NUM_TRANSACCION,COD_RETORNO,DES_CADENA)
                VALUES (LN_MOVIMIENTO,4,NULL);
                   END IF;


        SV_mens_retorno:= CV_error_no_clasif;
           LV_des_error:='PV_ELIM_GA_FINCICLO_PEND_PR(' || EV_MOVIMIENTO || EN_NUM_OS ||EV_COD_OS || EV_FECSYS || EN_CLIENTE || EN_NUM_ABONADO || ')';
           SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
           'PV_CAMBIOPLAN_BATCH_PG.PV_ELIM_GA_FINCICLO_PEND_PR', sSql, SQLCODE, LV_des_error );



END PV_ELIM_GA_FINCICLO_PEND_PR;

PROCEDURE PV_MODIFICA_EMPRESA_BATCH_PR(EN_PRODUCTO     IN NUMBER ,
                                   EN_EMPRESA      IN NUMBER ,
                                   EV_PLANTARIF    IN VARCHAR2 ,
                                   EN_CICLO        IN NUMBER ,
                                   EN_NUM_ABONADO  IN NUMBER ,
                                   EN_NUM_OS       IN NUMBER ,
                                   --SV_FECSYS       IN OUT NOCOPY varchar2 ,
                                   SV_PROC         IN OUT NOCOPY VARCHAR2 ,
                                   SV_TABLA        IN OUT NOCOPY VARCHAR2 ,
                                   SV_ACT          IN OUT NOCOPY VARCHAR2 ,
                                   SV_SQLCODE      IN OUT NOCOPY VARCHAR2 ,
                                   SV_SQLERRM      IN OUT NOCOPY VARCHAR2 ,
                                   SV_ERROR        IN OUT NOCOPY VARCHAR2 ,
                                   SN_cod_retorno  OUT NOCOPY GE_ERRORES_PG.CodError,
                                   SV_mens_retorno OUT NOCOPY GE_ERRORES_PG.MsgError,
                                   SN_num_evento   OUT NOCOPY GE_ERRORES_PG.Evento)

/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_MODIFICA_EMPRESA_BATCH_PR"
      Lenguaje="PL/SQL"
      Fecha="17-04-2006"
      Versión="1.0"
      Diseñador="Manuel Acevedo M"
          Programador="Orlando Cabezas B"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
              <Descripción></Descripción>
       <Parámetros>
         <Entrada>
                        <param nom="EN_PRODUCTO"           Tipo="NUMERICO">PRODUCTO</param>
                        <param nom="EN_EMPRESA"            Tipo="NUMERICO">CODIGO EMPRESA </param>
                        <param nom="EV_PLANTARIF"          Tipo="CARACTER">PLAN</param>
                        <param nom="EN_CICLO"      Tipo="NUMERICO">CICLO </param>
                        <param nom="EN_NUM_ABONADO"                Tipo="NUMERICO">ABONADO</param>
                        <param nom="EN_NUM_OS"             Tipo="NUMERICO">NUMERO OOSS</param>
         </Entrada>
         <Salida>
          <param nom="SV_PROC"    Tipo="CARACTER">PROCESO</param>
            <param nom="SV_TABLA"   Tipo="CARACTER">TABLA</param>
            <param nom="SV_ACT"     Tipo="CARACTER">ACCION SOBRE LA TABLA</param>
                       <param nom="SV_SQLCODE"    Tipo="CARACTER">Codigo ORACLE</param>
            <param nom="SV_SQLERRM"   Tipo="CARACTER">Mensaje ORACLE</param>
            <param nom="SV_ERROR"     Tipo="CARACTER">RETORNO</param>
            <param nom="SN_cod_retorno"    Tipo="NUMERICO">Codigo error de negocio Retornado</param>
            <param nom="SV_mens_retorno"   Tipo="CARACTER">Mensaje error de negocio Retornado</param>
            <param nom="SN_num_evento"     Tipo="ge_errores_pg.Evento">Nro de evento</param>
         </Salida>
      </Parámetros>
  </Elemento>
</Documentación>
*/

IS
--
-- Procedimiento que refleja los cambios y efectividad de los nuevos
-- planes tarifarios y/o ciclos de facturacion del holding en las tablas
-- de interfase con Tarificacion
--
--            Los posibles retornos del procedimiento son :
--                - '0' Actualizaciones realizadas correctamente
--                - '4' Error en el proceso
--
   LV_PRODUCTO GA_ABOCEL.COD_PRODUCTO%TYPE;
   LV_FECSYS_AUX DATE;
   LV_FECSYS  DATE;

   LV_ABONADO GA_INTARCEL.NUM_ABONADO%TYPE;
   LV_CLIENTE GA_INTARCEL.COD_CLIENTE%TYPE;
   LV_CICLO GA_INTARCEL.COD_CICLO%TYPE;
   LV_INDFACT GA_ABOCEL.IND_FACTUR%TYPE;

   SN_COD_CLIENTE GA_ABOCEL.COD_CLIENTE%TYPE; --- RRG 45898 23-11-2007 COL

     LV_des_error         GE_ERRORES_PG.DesEvent;
  sSql                 GE_ERRORES_PG.vQuery;
 CURSOR CCEL IS
   SELECT COD_CLIENTE,NUM_ABONADO,COD_CICLO
     FROM GA_INTARCEL
    WHERE TIP_PLANTARIF = 'E'
      AND COD_GRUPO = EN_EMPRESA
          AND NUM_ABONADO = EN_NUM_ABONADO
      AND IND_NUMERO = 0
      AND LV_FECSYS_AUX BETWEEN FEC_DESDE
   AND FEC_HASTA
   and COD_CLIENTE = SN_COD_CLIENTE; --- RRG 45898 23-11-2007 COL

   ERROR_PROCESO EXCEPTION;

   ERROR_CICLO 		   EXCEPTION;--COL-73376|21-01-2008|GEZ

BEGIN
   SV_PROC := 'PV_MODIFICA_EMPRESA_BATCH_PR';
   SN_cod_retorno   := 0;
   SV_mens_retorno  := 'OK';
   SN_num_evento         := 0;
   ssql :='' ;
   LV_FECSYS  :=SYSDATE;

      LV_FECSYS_AUX:=LV_FECSYS ;
          --to_date(SV_FECSYS,'DD-MM-YYYY HH24:MI:SS');
          SV_ERROR := '4';
        --  SV_TABLA :='5';
 -- SV_ACT:='6';
        --   SV_SQLCODE := '3';
  --      SV_SQLERRM := '2';
  --      SV_ERROR := '4';


     -- INICIO RRG 45898 COL 23-11-2007
     select cod_cliente
         into SN_COD_CLIENTE
         from ga_abocel where num_abonado = EN_NUM_ABONADO;
         -- FIN RRG 45898 COL 23-11-2007

     PV_VALIDA_OOSS_BATCH_PEND_PR('',EN_NUM_OS,'',SV_SQLCODE,SV_SQLERRM,SV_ERROR,SN_cod_retorno,SV_mens_retorno, SN_num_evento);

      IF EV_PLANTARIF IS NOT NULL THEN

         PV_ABOPLAN_EMP_BATCH_PR(EN_PRODUCTO,EN_NUM_ABONADO,EN_EMPRESA,EV_PLANTARIF,LV_FECSYS_AUX,SV_PROC,
         SV_TABLA,SV_ACT,SV_SQLCODE,SV_SQLERRM,SV_ERROR,SN_cod_retorno,SV_mens_retorno, SN_num_evento);

		 IF SV_ERROR <> '0' THEN

					 SV_ERROR := '4';
					 RAISE ERROR_PROCESO;

         END IF;

      END IF;

      IF EN_CICLO IS NOT NULL THEN
         SV_TABLA := 'GA_ABOCEL';
         SV_ACT := 'U';
         UPDATE GA_ABOCEL SET COD_CICLO = EN_CICLO
         WHERE COD_EMPRESA = EN_EMPRESA
                 AND NUM_ABONADO = EN_NUM_ABONADO
         AND COD_SITUACION IN ('AOP','AOA','CVA','RDA','ATP','ATA','SAO','SAT',
        'SCV','SRD','AOS','ATS','CVS','RDS','RAO','RAT','RCV','RRD');
      END IF;
      SV_TABLA := 'CCEL';
      SV_ACT := 'O';
      OPEN CCEL;
      LOOP
         SV_ACT := 'F';
         FETCH CCEL INTO LV_CLIENTE,LV_ABONADO,LV_CICLO;
         EXIT WHEN CCEL%NOTFOUND;
         IF EV_PLANTARIF IS NOT NULL THEN

			DBMS_OUTPUT.Put_Line('antes de plan_tarifario');

            PV_PLAN_TARIFARIO_batch_PR (EN_PRODUCTO,LV_CLIENTE,LV_ABONADO,
                              'E',EV_PLANTARIF,LV_CICLO,EN_NUM_OS,
         EN_EMPRESA,NULL,'E',EN_EMPRESA,
         SV_PROC,SV_TABLA,SV_ACT,SV_SQLCODE,
         SV_SQLERRM,SV_ERROR,SN_cod_retorno,SV_mens_retorno, SN_num_evento);
            IF SV_ERROR <> '0' THEN
         SV_ERROR := '4';
         RAISE ERROR_PROCESO;
            END IF;
         END IF;
         IF EN_CICLO IS NOT NULL THEN
                      P_CAMBIO_CICLO (EN_PRODUCTO,LV_CLIENTE,LV_ABONADO,
                      EN_CICLO,LV_CICLO,LV_FECSYS_AUX,
                      SV_PROC,SV_TABLA,SV_ACT,SV_SQLCODE,
                      SV_SQLERRM,SV_ERROR);
                    IF SV_ERROR <> '0' THEN
                       SV_ERROR := '4';
                       RAISE ERROR_PROCESO;
            END IF;
                                --**********
                                SELECT IND_FACTUR INTO LV_INDFACT FROM GA_ABOCEL
                                        WHERE NUM_ABONADO = LV_ABONADO;
                                IF LV_INDFACT = 1 THEN
                                    P_ACTUALIZA_CICLOCLI (LV_ABONADO,EN_CICLO,SV_PROC,SV_TABLA,
                                     SV_ACT,SV_SQLCODE,SV_SQLERRM,SV_ERROR);
                                    IF SV_ERROR <> '0' THEN
                                       SV_ERROR := '4';
                                       RAISE ERROR_PROCESO;
                                    END IF;
                                    SV_PROC := 'P_INTERFASES_CELULAR';
                             ELSE
                                    P_ACTUALIZA_NOCICLOCLI (LV_ABONADO,LV_CICLO,SV_PROC,SV_TABLA,
                                       SV_ACT,SV_SQLCODE,SV_SQLERRM,SV_ERROR);
                                    IF SV_ERROR <> '0' THEN
                                       SV_ERROR := '4';
                                       RAISE ERROR_PROCESO;
                                    END IF;
                                    SV_PROC := 'P_INTERFASES_CELULAR';
                             END IF;
        --**********
        END IF;
      END LOOP;
      SV_TABLA := 'CCEL';
      SV_ACT := 'C';
      CLOSE CCEL;
EXCEPTION

   WHEN ERROR_PROCESO THEN
        SV_SQLCODE := SQLCODE;
        SV_SQLERRM := SQLERRM;
        SV_ERROR := '4';

           SV_mens_retorno:= CV_error_no_clasif;
           LV_des_error:='PV_MODIFICA_EMPRESA_BATCH_PR(' || EN_PRODUCTO || EN_EMPRESA ||EV_PLANTARIF || EN_CICLO  || EN_NUM_ABONADO || EN_NUM_OS ||')';
           SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
           'PV_CAMBIOPLAN_BATCH_PG.PV_MODIFICA_EMPRESA_BATCH_PR', sSql, SQLCODE, LV_des_error );

   WHEN OTHERS THEN
        SV_SQLCODE := SQLCODE;
        SV_SQLERRM := SQLERRM;
        SV_ERROR := '4';


           SV_mens_retorno:= CV_error_no_clasif;
           LV_des_error:='PV_MODIFICA_EMPRESA_BATCH_PR(' || EN_PRODUCTO || EN_EMPRESA ||EV_PLANTARIF || EN_CICLO  || EN_NUM_ABONADO || EN_NUM_OS ||')';
            SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
           'PV_CAMBIOPLAN_BATCH_PG.PV_MODIFICA_EMPRESA_BATCH_PR', sSql, SQLCODE, LV_des_error );

END PV_MODIFICA_EMPRESA_BATCH_PR;

procedure PV_PLAN_TARIFARIO_BATCH_PR(
   EN_PRODUCTO       IN             NUMBER ,
   EN_CLIENTE        IN             NUMBER ,
   EN_ABONADO        IN             NUMBER ,
   EV_TIPPLAN        IN             VARCHAR2 ,
   EV_PLANTARIF      IN             VARCHAR2 ,
   EN_CICLO          IN             NUMBER ,
   --EV_FECSYS       IN             DATE ,
   EN_NUM_OS         IN             NUMBER , -- NUEVO
   EN_EMPRESA        IN             NUMBER ,
   EN_HOLDING        IN             NUMBER ,
   EV_TIPPLANTANT    IN             VARCHAR2,
   EN_GRUPO          IN             NUMBER ,
   SV_PROC           IN OUT NOCOPY  VARCHAR2 ,
   SV_TABLA          IN OUT NOCOPY  VARCHAR2 ,
   SV_ACT            IN OUT NOCOPY  VARCHAR2 ,
   SV_SQLCODE        IN OUT NOCOPY  VARCHAR2,
   SV_SQLERRM        IN OUT NOCOPY  VARCHAR2,
   SV_ERROR          IN OUT NOCOPY  VARCHAR2,
   SN_cod_retorno    OUT NOCOPY     GE_ERRORES_PG.CodError,
   SV_mens_retorno   OUT NOCOPY     GE_ERRORES_PG.MsgError,
   SN_num_evento     OUT NOCOPY     GE_ERRORES_PG.Evento
)
/*
   <Documentación TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_PLAN_TARIFARIO_BATCH_PR"
      Lenguaje="PL/SQL"
      Fecha="17-04-2006"
      Versión="1.0"
      Diseñador="Manuel Acevedo M"
      Programador="Orlando Cabezas B"
      Ambiente Desarrollo="BD">
   <Retorno>NA</Retorno>
   <Descripción></Descripción>
   <Parámetros>
      <Entrada>
         <param nom="EN_PRODUCTO"           Tipo="NUMERICO">PRODUCTO</param>
         <param nom="EN_CLIENTE"            Tipo="NUMERICO">CLIENTE</param>
         <param nom="EN_NUM_ABONADO"                Tipo="NUMERICO">ABONADO</param>
         <param nom="EV_TIPPLAN"           Tipo="CARACTER">TIPO PLAN </param>
         <param nom="EV_PLANTARIF"         Tipo="CARACTER">PLAN </param>
         <param nom="EN_NUM_OS"                    Tipo="NUMERICO">NUMERO OOSS</param>
         <param nom="EN_CICLO"     Tipo="NUMERICO">CICLO </param>
         <param nom="EN_EMPRESA"     Tipo="NUMERICO">CODIGO EMPRESA</param>
         <param nom="EN_HOLDING"            Tipo="NUMERICO">HOLDING </param>
         <param nom="EV_TIPPLANTANT"                Tipo="CARACTER">TIPO PLAN ANTERIOR</param>
         <param nom="EN_GRUPO"              Tipo="NUMERICO">GRUPO OOSS</param>
      </Entrada>
      <Salida>
         <param nom="SV_PROC"    Tipo="CARACTER">PROCESO</param>
         <param nom="SV_TABLA"   Tipo="CARACTER">TABLA</param>
         <param nom="SV_ACT"     Tipo="CARACTER">ACCION SOBRE LA TABLA</param>
         <param nom="SV_SQLCODE"    Tipo="CARACTER">Codigo ORACLE</param>
         <param nom="SV_SQLERRM"   Tipo="CARACTER">Mensaje ORACLE</param>
         <param nom="SV_ERROR"     Tipo="CARACTER">RETORNO</param>
         <param nom="SN_cod_retorno"    Tipo="NUMERICO">Codigo error de negocio Retornado</param>
         <param nom="SV_mens_retorno"   Tipo="CARACTER">Mensaje error de negocio Retornado</param>
         <param nom="SN_num_evento"     Tipo="ge_errores_pg.Evento">Nro de evento</param>
      </Salida>
   </Parámetros>
   </Elemento>
</Documentación>
*/

IS
--
-- *************************************************************
-- * procedimiento      : P_PLAN_TARIFARIO
-- * Descripcisn        : Procedimiento que refleja el cambio y efectividad del nuevo plan tarifario
-- *                      en las tablas de interfase con tarificacion
-- * Fecha de creacisn  :
-- * Responsable        : CRM
--            Los posibles retornos del procedimiento son :
--                - '0' Actualizaciones realizadas correctamente
--                - '4' Error en el proceso
-- *************************************************************
--
--
   LV_FECHADCF            GA_INTARCEL.FEC_DESDE%TYPE;
   LV_FECHADLL            GA_INTARCEL.FEC_DESDE%TYPE;
   LV_FECHAD              GA_INTARCEL.FEC_DESDE%TYPE;
   LV_FECHA               GA_INTARCEL.FEC_DESDE%TYPE;
   LV_ROWID               CHAR(18);
   LV_INDCAR              NUMBER(1) := 0;
   LV_INDLLA              NUMBER(1) := 0;
   LV_FECSYS              DATE;

   --INI 64502 col|18-04-2008|EFR
   --A SOLICITUD DE LA OPERADORA SE REVERSA INC 61183
   --vFormatoSel2     GED_PARAMETROS.VAL_PARAMETRO%TYPE;  --inc. 61183|22/01/2008|COL|jjr.- --64502 col|18-04-2008|EFR
   --FIN 64502 col|18-04-2008|EFR
   CURSOR C1 is
      SELECT ROWID,COD_CLIENTE,NUM_ABONADO,IND_NUMERO, FEC_DESDE,FEC_HASTA,IMP_LIMCONSUMO,
      IND_FRIENDS,IND_DIASESP,COD_CELDA, TIP_PLANTARIF,COD_PLANTARIF,NUM_SERIE,
      NUM_CELULAR,COD_CARGOBASICO,COD_CICLO, COD_PLANCOM,COD_PLANSERV,COD_GRPSERV,
      COD_GRUPO,COD_PORTADOR,COD_USO
      FROM GA_INTARCEL
      WHERE COD_CLIENTE = EN_CLIENTE
      AND NUM_ABONADO = EN_ABONADO
      AND FEC_DESDE = LV_FECHA;
   LV_CLIENTE             GA_INTARCEL.COD_CLIENTE%TYPE;
   LV_ABONADO             GA_INTARCEL.NUM_ABONADO%TYPE;
   LV_NUMERO              GA_INTARCEL.IND_NUMERO%TYPE;
   LV_FECDESDE            GA_INTARCEL.FEC_DESDE%TYPE;
   LV_FECHASTA            GA_INTARCEL.FEC_HASTA%TYPE;
   LV_LIMCONSUMO          GA_INTARCEL.IMP_LIMCONSUMO%TYPE;
   LV_FRIENDS             GA_INTARCEL.IND_FRIENDS%TYPE;
   LV_DIASESP             GA_INTARCEL.IND_DIASESP%TYPE;
   LV_CELDA               GA_INTARCEL.COD_CELDA%TYPE;
   LV_TIPPLANTARIF        GA_INTARCEL.TIP_PLANTARIF%TYPE;
   LV_PLANTARIF           GA_INTARCEL.COD_PLANTARIF%TYPE;
   LV_SERIE               GA_INTARCEL.NUM_SERIE%TYPE;
   LV_SERIE_DEC           GA_ABOCEL.NUM_SERIE%TYPE;
   LV_SERIETRUNK          GA_INTARTRUNK.NUM_SERIE%TYPE;
   LV_SERIETREK           GA_INTARTREK.NUM_SERIE%TYPE;
   LV_CELULAR             GA_INTARCEL.NUM_CELULAR%TYPE;
   LV_CARGOBASICO         GA_INTARCEL.COD_CARGOBASICO%TYPE;
   LV_VP_CARGOBASICO  GA_INTARCEL.COD_CARGOBASICO%TYPE;
   LV_CICLO               GA_INTARCEL.COD_CICLO%TYPE;
   LV_PLANCOM             GA_INTARCEL.COD_PLANCOM%TYPE;
   LV_PLANSERV            GA_INTARCEL.COD_PLANSERV%TYPE;
   LV_GRPSERV             GA_INTARCEL.COD_GRPSERV%TYPE;
   LV_GRUPO               GA_INTARCEL.COD_GRUPO%TYPE;
   LV_VAR_GRUPO           GA_INTARCEL.COD_GRUPO%TYPE;
   LV_PORTADOR            GA_INTARCEL.COD_PORTADOR%TYPE;
   LV_CAPCODE             GA_INTARBEEP.CAP_CODE%TYPE;
   LV_BEEPER              GA_INTARBEEP.NUM_BEEPER%TYPE;
   LV_RADIO               GA_INTARTRUNK.NUM_RADIO%TYPE;
   LV_MAN                         GA_INTARTREK.NUM_MAN%TYPE;
   LV_CICLFACT            FA_CICLFACT.COD_CICLFACT%TYPE;
   LV_PLANTANT            GA_FINCICLO.TIP_PLANTANT%TYPE := NULL;
   LV_GRUPANT             GA_FINCICLO.COD_GRUPANT%TYPE := NULL;
   LV_VAR1                        GA_ABOCEL.NUM_ABONADO%TYPE;
   LV_DIAS                        TA_PLANTARIF.NUM_DIAS%TYPE;
   LV_USO                         GA_INTARCEL.COD_USO%TYPE;
   LV_AUX                         NUMBER;
   LV_FEC_AUX             DATE;
   Ld_FECHA_hasta         DATE;
   LN_FEC_HASTA_AUX       DATE; --COL-71988|19-10-2008|Orlando Cabezas
   LV_NUM_IMSI            GA_INTARCEL.NUM_IMSI%TYPE;
   LV_TECNOLOGIA          GA_ABOCEL.COD_TECNOLOGIA%TYPE;
   LV_TECNOLOGIA_GSM  GA_ABOCEL.COD_TECNOLOGIA%TYPE;
   Ld_FECHA_DESDE         DATE; --COL-71988|19-10-2008|Orlando Cabezas
   COD_LIMCONS_AUX_REG    TOL_LIMITE_TD.COD_LIMCONS%TYPE;
   -- INI.31.06.2006 --
   LV_INDTOL              GED_PARAMETROS.VAL_PARAMETRO%TYPE;
   LN_TXLIMITE            GA_TRANSACABO.NUM_TRANSACCION%TYPE;
   LV_CODOS                       PV_IORSERV.COD_OS%TYPE;
   IMP_LIMITE_AUX_REG     TOL_LIMITE_TD.IMP_LIMITE%TYPE; --COL-71988|19-10-2008|Orlando Cabezas
   LN_CANT_AUX1          NUMBER; --COL-71988|19-10-2008|Orlando Cabezas
   LN_CANT_INT             NUMBER; -- COL 72226|29-10-2008|SAQL
   -- FIN.31.06.2006 --
   ERROR_PROCESO          EXCEPTION;
   LV_vErrorAplic         VARCHAR2(100);
   LV_vErrorGlosa         VARCHAR2(100);
   LV_vErrorOra           VARCHAR2(100);
   LV_vErrorOraGlosa  VARCHAR2(100);
   LV_vTrace          VARCHAR2(100);
   LV_des_error       GE_ERRORES_PG.DesEvent;
   sSql               GE_ERRORES_PG.vQuery;
   LVCodUsoAct            ga_abocel.cod_uso%TYPE;         --COL-37481|15-02-2007|GEZ
   LVCodTiplaNue          ta_plantarif.cod_tiplan%TYPE;   --COL-37481|15-02-2007|GEZ
   LVUsoHibrido           ga_abocel.cod_uso%TYPE;                 --COL-37481|15-02-2007|GEZ
   LVTiPlanHib            ta_plantarif.cod_tiplan%TYPE;   		  --COL-37481|15-02-2007|GEZ
   LN_NUM_OS_AUX          PV_IORSERV.NUM_OS%TYPE; -- 71929/ 18-10-2008/EFR
   LV_COD_CARGOBASICO     TA_CARGOSBASICO.COD_CARGOBASICO%TYPE; -- 71929/ 18-10-2008/EFR
   NUEVO_CAMBIOPLAN          EXCEPTION; --COL-73515|12-12-2008|GEZ
BEGIN
   SV_PROC := 'PV_PLAN_TARIFARIO_BATCH_PR';
   SN_cod_retorno   := 0;
   SV_mens_retorno  := 'OK';
   SN_num_evento         := 0;
   ssql :='';

   --INI 64502 col|18-04-2008|EFR
   --A SOLICITUD DE LA OPERADORA SE REVERSA INC 61183
   --vFormatoSel2       := ge_fn_devvalparam('GE', 1, 'FORMATO_SEL2'); --inc. 61183|22/01/2008|COL|jjr.-
   --FIN 64502 col|18-04-2008|EFR

   SELECT FH_EJECUCION,COD_OS
   INTO   LV_FECHADCF,LV_CODOS
   FROM   PV_IORSERV
   WHERE  NUM_OS  = EN_NUM_OS;

   SELECT num_serie, cod_tecnologia,cod_uso
   INTO LV_SERIE_DEC, LV_TECNOLOGIA,LVCodUsoAct
   FROM GA_ABOCEL
   WHERE NUM_ABONADO = EN_ABONADO;


   SELECT num_dias,cod_cargobasico,cod_tiplan
   INTO LV_DIAS,LV_VP_CARGOBASICO,LVCodTiplaNue
   FROM TA_PLANTARIF
   WHERE COD_PRODUCTO = EN_PRODUCTO AND COD_PLANTARIF = EV_PLANTARIF;
   -- ini 71929/ 18-10-2008/EFR
   LN_NUM_OS_AUX:= 0;

   BEGIN
      SELECT NUM_OS
      INTO LN_NUM_OS_AUX
      FROM PV_detalle_os_to
      WHERE NUM_OS  = EN_NUM_OS;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         LN_NUM_OS_AUX:= 0;
   END;

   IF ( LN_NUM_OS_AUX = 0) THEN
   -- fin 71929/ 18-10-2008/EFR
      DBMS_OUTPUT.Put_Line('NO ES POR CPU');
      RAISE NUEVO_CAMBIOPLAN;
      BEGIN
         --SV_TABLA := 'FA_CICLFACT';--COL-37481|15-02-2007|GEZ
         --SV_ACT := 'S';                    --COL-37481|15-02-2007|GEZ
         LV_AUX := 0;
         SV_SQLCODE :='0';
         SV_SQLERRM :='0';
         SV_error:='0';
         /*
         SELECT MIN(FEC_DESDELLAM)
         INTO LV_FECHADCF
         FROM FA_CICLFACT
         WHERE COD_CICLO = EN_CICLO
         AND TRUNC(to_date(EV_FECSYS,'DD-MM-YYYY')) <= TRUNC(FEC_DESDELLAM)
         AND IND_FACTURACION = LV_AUX ;
         SELECT FEC_DESDELLAM,COD_CICLFACT
         INTO LV_FECHADLL,LV_CICLFACT
         FROM FA_CICLFACT
         WHERE COD_CICLO = EN_CICLO
         AND TRUNC(to_date(EV_FECSYS,'DD-MM-YYYY')) <= TRUNC(FEC_DESDELLAM)
         AND IND_FACTURACION = LV_AUX
         AND ROWNUM = 1;
         */
         --FIN.MAM PH-200403240059 05.05.2004

         SV_TABLA := 'PV_IORSERV'; --COL-37481|15-02-2007|GEZ
         SV_ACT := 'S';                    --COL-37481|15-02-2007|GEZ
         SELECT FH_EJECUCION,COD_OS
         INTO   LV_FECHADCF,LV_CODOS
         FROM   PV_IORSERV
         WHERE  NUM_OS  = EN_NUM_OS;

         /* INI.AGREGA CORTE LIMITE CONSUMO*/
         LV_INDTOL:= GE_FN_DEVVALPARAM('GE',1,'IND_TOL');
         IF LV_INDTOL = 'S' THEN
            SV_TABLA := 'GA_SEQ_TRANSACABO'; --COL-37481|15-02-2007|GEZ
            SV_ACT := 'S';                                   --COL-37481|15-02-2007|GEZ
            SELECT GA_SEQ_TRANSACABO.NEXTVAL INTO   LN_TXLIMITE FROM   DUAL;
            IF LV_CODOS = '10022' OR LV_CODOS = '10029' THEN
               SV_TABLA := 'PV_OPERA_LIMITE_ODBC_PR1'; --COL-37481|15-02-2007|GEZ
               SV_ACT := 'P';                                              --COL-37481|15-02-2007|GEZ
               -- CAMBIO PLAN EMPRESA O FAMILIAR--
               --PV_OPERA_LIMITE_ODBC_PR(LN_TXLIMITE,EN_CLIENTE,'C',LV_FECHADCF,'*','EC',EV_PLANTARIF,'*'); --INC.61183
               --INI 64502 col|18-04-2008|EFR
               --A SOLICITUD DE LA OPERADORA SE REVERSA INC 61183
               --PV_OPERA_LIMITE_ODBC_PR(LN_TXLIMITE,EN_CLIENTE,'C',TO_CHAR(LV_FECHADCF,vFormatoSel2),'*','EC',EV_PLANTARIF,'*'); --INC.61183
               Pv_Opera_Limite_Odbc_Pr(LN_TXLIMITE,EN_CLIENTE,'C',LV_FECHADCF,'*','EC',EV_PLANTARIF,'*'); --INC.61183
               --FIN 64502 col|18-04-2008|EFR
            ELSIF LV_CODOS = '10020' THEN
               SV_TABLA := 'PV_OPERA_LIMITE_ODBC_PR2'; --COL-37481|15-02-2007|GEZ
               SV_ACT := 'P';                                              --COL-37481|15-02-2007|GEZ
               -- CAMBIO PLAN INDIVIDUAL --
               --PV_OPERA_LIMITE_ODBC_PR(LN_TXLIMITE,EN_ABONADO,'A',LV_FECHADCF,'*','CT',EV_PLANTARIF,'*'); --INC.61183
               --INI 64502 col|18-04-2008|EFR
               --A SOLICITUD DE LA OPERADORA SE REVERSA INC 61183
               --PV_OPERA_LIMITE_ODBC_PR(LN_TXLIMITE,EN_ABONADO,'A',TO_CHAR(LV_FECHADCF,vFormatoSel2),'*','CT',EV_PLANTARIF,'*'); --INC.61183
               Pv_Opera_Limite_Odbc_Pr(LN_TXLIMITE,EN_ABONADO,'A',LV_FECHADCF,'*','CT',EV_PLANTARIF,'*'); --INC.61183
               --FIN 64502 col|18-04-2008|EFR
            END IF;
         END IF;
         /* FIN.AGREGA CORTE LIMITE CONSUMO*/
         /* INI COL|73515|27-10-2008|SAQL */
         SELECT COUNT(1) INTO LN_CANT_INT
         FROM GA_INTARCEL
         WHERE COD_CLIENTE = EN_CLIENTE
         AND NUM_ABONADO = EN_ABONADO
         AND COD_PLANTARIF = EV_PLANTARIF
         AND FEC_DESDE > LV_FECHADCF;
         IF LN_CANT_INT > 0 THEN
            UPDATE GA_INTARCEL SET
            FEC_HASTA = LV_FECHADCF - 1/86400
            WHERE COD_CLIENTE = EN_CLIENTE
            AND NUM_ABONADO = EN_ABONADO
            AND LV_FECHADCF BETWEEN FEC_DESDE AND FEC_HASTA;

            UPDATE GA_INTARCEL SET
            FEC_DESDE = LV_FECHADCF
            WHERE COD_CLIENTE = EN_CLIENTE
            AND NUM_ABONADO = EN_ABONADO
            AND COD_PLANTARIF = EV_PLANTARIF
            AND FEC_DESDE > LV_FECHADCF;
         END IF;
         /* FIN COL|73515|27-10-2008|SAQL */
         LV_FECSYS   := LV_FECHADCF;
         LV_FECHADLL := LV_FECHADCF;

         SV_TABLA := 'FA_CICLFACT'; --COL-37481|15-02-2007|GEZ
         SV_ACT := 'S';                     --COL-37481|15-02-2007|GEZ

         SELECT COD_CICLFACT
         INTO LV_CICLFACT
         FROM FA_CICLFACT
         WHERE COD_CICLO = EN_CICLO
         AND TRUNC(LV_FECSYS) = TRUNC(FEC_DESDELLAM)
         AND IND_FACTURACION = LV_AUX
         AND ROWNUM = 1;

         SV_TABLA := 'TA_PLANTARIF';
         SV_ACT := 'S';
         --INI COL-37481|15-02-2007|GEZ
         --SELECT NUM_DIAS,COD_CARGOBASICO
         --INTO LV_DIAS,LV_VP_CARGOBASICO
         SELECT num_dias,cod_cargobasico,cod_tiplan
         INTO LV_DIAS,LV_VP_CARGOBASICO,LVCodTiplaNue
         --FIN COL-37481|15-02-2007|GEZ
         FROM TA_PLANTARIF
         WHERE COD_PRODUCTO = EN_PRODUCTO AND COD_PLANTARIF = EV_PLANTARIF;
      EXCEPTION
         WHEN OTHERS THEN
            SV_ERROR := '4';
            RAISE ERROR_PROCESO;
      END;
      dbms_output.put_line('EN_PRODUCTO' || EN_PRODUCTO);
      IF EN_PRODUCTO = 1 THEN
         --INI COL-37481|15-02-2007|GEZ
         --SV_TABLA := 'GA_INTARCEL';
         SV_TABLA := 'GE_FN_DEVVALPARAM';
         SV_ACT := 'F';
         --FIN COL-37481|15-02-2007|GEZ
         -- INI TMM_04026
         LV_TECNOLOGIA_GSM := GE_FN_DEVVALPARAM('GA',1,'GRUPO_TEC_GSM'); --GE_FN_DEVVALPARAM('GA',1,'TECNOLOGIA_GSM');
         -- FIN TMM_04026
         IF EN_ABONADO <> 0 THEN
            SV_TABLA := 'GA_ABOCEL';--COL-37481|15-02-2007|GEZ
            SV_ACT := 'S';          --COL-37481|15-02-2007|GEZ
            --INI COL-37481|15-02-2007|GEZ
            --SELECT NUM_SERIE, COD_TECNOLOGIA
            --INTO LV_SERIE_DEC, LV_TECNOLOGIA
            SELECT num_serie, cod_tecnologia,cod_uso
            INTO LV_SERIE_DEC, LV_TECNOLOGIA,LVCodUsoAct
            --FIN COL-37481|15-02-2007|GEZ
            FROM GA_ABOCEL
            WHERE NUM_ABONADO = EN_ABONADO;
            --INI TMM_04026
            IF GA_APROVISIONAR_CENTRAL_PG.PV_GRUPO_TECNOLOGICO_FN(LV_TECNOLOGIA) = LV_TECNOLOGIA_GSM THEN
            --FIN TMM_04026
               --INI COL-37481|15-02-2007|GEZ
               --SV_ACT := 'S4';
               SV_TABLA := 'FRECUPERSIMCARD_FN';
               SV_ACT := 'F';
               --FIN COL-37481|15-02-2007|GEZ
               --SELECT FRECUPERSIMCARD_FN(LV_SERIE_DEC, 'IMSI') INTO LV_NUM_IMSI FROM DUAL;
               LV_NUM_IMSI  := FRECUPERSIMCARD_FN(LV_SERIE_DEC, 'IMSI');
            END IF;
         END IF;
         BEGIN
            SV_TABLA := 'GA_INTARCEL1';--COL-37481|15-02-2007|GEZ
            SV_ACT := 'S';             --COL-37481|15-02-2007|GEZ
            SELECT NUM_ABONADO
            INTO LV_VAR1
            FROM GA_INTARCEL
            WHERE COD_CLIENTE = EN_CLIENTE
            AND NUM_ABONADO = EN_ABONADO
            AND TRUNC(FEC_DESDE)   = TRUNC(LV_FECHADCF);
            LV_INDCAR := 1;
         EXCEPTION
            WHEN NO_DATA_FOUND THEN
               LV_INDCAR := 0;
            WHEN TOO_MANY_ROWS THEN
               LV_INDCAR := 1;
            WHEN OTHERS THEN
               SV_ERROR := '4';
               SV_ACT := 'S7' || LV_FECHADCF;
               RAISE ERROR_PROCESO;
         END;
         BEGIN
            SV_TABLA := 'GA_INTARCEL2';--COL-37481|15-02-2007|GEZ
            SV_ACT := 'S';             --COL-37481|15-02-2007|GEZ
            SELECT NUM_ABONADO
            INTO LV_VAR1
            FROM GA_INTARCEL
            WHERE COD_CLIENTE = EN_CLIENTE
            AND NUM_ABONADO = EN_ABONADO
            AND TRUNC(FEC_DESDE)   = TRUNC(LV_FECHADLL);
            LV_INDLLA := 1;
         EXCEPTION
            WHEN NO_DATA_FOUND THEN
               LV_INDLLA := 0;
            WHEN TOO_MANY_ROWS THEN
               LV_INDLLA := 1;
            WHEN OTHERS THEN
               SV_ERROR := '4';
               SV_ACT := 'S8' || LV_FECHADLL;
               RAISE ERROR_PROCESO;
         END;
         dbms_output.put_line('LV_INDCAR:' || LV_INDCAR);
         dbms_output.put_line('LV_INDLLA:' || LV_INDLLA);
         IF LV_INDCAR = 0 AND LV_INDLLA = 0 THEN
            BEGIN
               LV_AUX := 1;
               SV_TABLA := 'GA_INTARCEL3';--COL-37481|15-02-2007|GEZ
               SV_ACT := 'S';             --COL-37481|15-02-2007|GEZ
               SELECT FEC_DESDE
               INTO LV_FECHAD
               FROM GA_INTARCEL
               WHERE COD_CLIENTE = EN_CLIENTE
               AND NUM_ABONADO = EN_ABONADO
               AND TRUNC(LV_FECSYS) BETWEEN TRUNC(FEC_DESDE) AND TRUNC(FEC_HASTA)
               AND ROWNUM = LV_AUX;
               LV_FECHA := LV_FECHAD;
            EXCEPTION
               WHEN OTHERS THEN
                  SV_ERROR := '4';
                  SV_ACT := 'S9' || LV_FECSYS ||'-'|| EN_CLIENTE || '-'|| EN_ABONADO || '-' || SQLERRM;
                  RAISE ERROR_PROCESO;
            END;
         ELSIF LV_INDLLA <> 0 THEN
            SV_ACT := 'U';
            IF EV_TIPPLAN = 'E' OR EV_TIPPLAN = 'H' THEN
               LV_VAR_GRUPO := EN_GRUPO;
            ELSIF EV_TIPPLAN = 'I' THEN
               LV_VAR_GRUPO := NULL;
            END IF;
            SV_TABLA := 'GA_INTARCEL4';--COL-37481|15-02-2007|GEZ
            SV_ACT := 'U';             --COL-37481|15-02-2007|GEZ
            UPDATE GA_INTARCEL
            SET TIP_PLANTARIF = EV_TIPPLAN,
            COD_PLANTARIF = EV_PLANTARIF,
            COD_CARGOBASICO = LV_VP_CARGOBASICO,
            COD_GRUPO = LV_VAR_GRUPO,
            NUM_IMSI = LV_NUM_IMSI
            WHERE COD_CLIENTE = EN_CLIENTE
            AND NUM_ABONADO = EN_ABONADO
            AND TRUNC(FEC_DESDE) >= TRUNC(LV_FECHADCF);
            -- INI COL|71991|18-10-2008|SAQL
            IF LV_CODOS IN ('10020','10022','10029') THEN
               -- INI COL|72226|29-10-2008|SAQL
               BEGIN
                  SELECT COUNT(1) INTO LN_CANT_INT
                  FROM GA_INTARCEL_ACCIONES_TO
                  WHERE COD_CLIENTE = EN_CLIENTE
                  AND NUM_ABONADO = EN_ABONADO
                  AND FEC_DESDE = LV_FECHADCF
                  AND COD_ACTABO = 'CT';
               EXCEPTION
                  WHEN NO_DATA_FOUND THEN
                     LN_CANT_INT := 0;
                  WHEN OTHERS THEN
                     LN_CANT_INT := -1;
               END;
               IF LN_CANT_INT = 0 THEN
               -- FIN COL|72226|29-10-2008|SAQL
                  Pv_Actualiza_Camb_Comerc_Pr(EN_CLIENTE, EN_ABONADO, '0', 'CT', LV_FECHADCF, LV_vErrorAplic, LV_vErrorGlosa, LV_vErrorOra, LV_vErrorOraGlosa, LV_vTrace);
                  IF LV_vErrorAplic = 'FALSE' THEN
                     SV_ERROR := '4';
                     RAISE ERROR_PROCESO;
                  END IF;
               END IF; -- COL 72226|29-10-2008|SAQL
            END IF;
            -- FIN COL|71991|18-10-2008|SAQL
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
            dbms_output.put_line('Inicio Loop');
            SV_TABLA := 'C1';
            SV_ACT := 'F';
            FETCH C1 INTO LV_ROWID,LV_CLIENTE,LV_ABONADO,LV_NUMERO, LV_FECDESDE,LV_FECHASTA,LV_LIMCONSUMO,
               LV_FRIENDS,LV_DIASESP,LV_CELDA, LV_TIPPLANTARIF,LV_PLANTARIF,LV_SERIE,
               LV_CELULAR,LV_CARGOBASICO,LV_CICLO, LV_PLANCOM,LV_PLANSERV,LV_GRPSERV,
               LV_GRUPO,LV_PORTADOR,LV_USO;
            EXIT WHEN C1%NOTFOUND;
            -- Inicio modificacion by SAQL/Soporte 29/08/2006 - CO-2006081700334
            BEGIN
               SV_TABLA := 'TOL_LIMITE_PLAN_TD-TOL_LIMITE_TD';--COL-37481|15-02-2007|GEZ
               SV_ACT := 'S';                                                 --COL-37481|15-02-2007|GEZ
               SELECT B.IMP_LIMITE INTO LV_LIMCONSUMO
               FROM TOL_LIMITE_PLAN_TD A, TOL_LIMITE_TD B
               WHERE A.COD_LIMCONS = B.COD_LIMCONS
               AND   B.COD_LIMCONS > '0' --- RRG 45898 COL  Para evita full scan
               AND A.IND_DEFAULT = 'S'
               AND SYSDATE BETWEEN A.FEC_DESDE AND A.FEC_HASTA
               AND A.COD_PLANTARIF = EV_PLANTARIF;
            EXCEPTION
               WHEN NO_DATA_FOUND THEN
                  LV_LIMCONSUMO := 0;
            END;
            -- Fin modificacion by SAQL/Soporte 29/08/2006 - CO-2006081700334
            dbms_output.put_line('LV_FECHADCF' || LV_FECHADCF);
            dbms_output.put_line('LV_FECHA' || LV_FECHA);
            IF LV_FECHA = LV_FECHADCF THEN
               IF LV_FECHADCF = LV_FECHADLL THEN
                  SV_TABLA := 'GA_INTARCEL';
                  SV_ACT := 'U';
                  IF EV_TIPPLAN = 'E' OR EV_TIPPLAN = 'H' THEN
                     LV_VAR_GRUPO := EN_GRUPO;
                  ELSIF EV_TIPPLAN = 'I' THEN
                     LV_VAR_GRUPO := NULL;
                  END IF;
                  SV_TABLA := 'GA_INTARCEL5';--COL-37481|15-02-2007|GEZ
                  SV_ACT := 'U';             --COL-37481|15-02-2007|GEZ
                  UPDATE GA_INTARCEL
                  SET TIP_PLANTARIF = EV_TIPPLAN,
                  COD_PLANTARIF = EV_PLANTARIF,
                  COD_CARGOBASICO = LV_VP_CARGOBASICO,
                  COD_GRUPO = LV_VAR_GRUPO,NUM_IMSI=LV_NUM_IMSI
                  WHERE ROWID = LV_ROWID;
                  -- INI COL|71991|18-10-2008|SAQL
                  IF LV_CODOS IN ('10020','10022','10029') THEN
                     -- INI COL|72226|29-10-2008|SAQL
                     BEGIN
                        SELECT COUNT(1) INTO LN_CANT_INT
                        FROM GA_INTARCEL_ACCIONES_TO
                        WHERE COD_CLIENTE = EN_CLIENTE
                        AND NUM_ABONADO = EN_ABONADO
                        AND FEC_DESDE = LV_FECHADCF
                        AND COD_ACTABO = 'CT';
                     EXCEPTION
                        WHEN NO_DATA_FOUND THEN
                           LN_CANT_INT := 0;
                        WHEN OTHERS THEN
                           LN_CANT_INT := -1;
                     END;
                     IF LN_CANT_INT = 0 THEN
                     -- FIN COL|72226|29-10-2008|SAQL
                        Pv_Actualiza_Camb_Comerc_Pr(EN_CLIENTE, EN_ABONADO, '0', 'CT', LV_FECHADCF, LV_vErrorAplic, LV_vErrorGlosa, LV_vErrorOra, LV_vErrorOraGlosa, LV_vTrace);
                        IF LV_vErrorAplic = 'FALSE' THEN
                           SV_ERROR := '4';
                           RAISE ERROR_PROCESO;
                        END IF;
                     END IF; -- COL 72226|29-10-2008|SAQL
                  END IF;
                  -- FIN COL|71991|18-10-2008|SAQL
               ELSIF LV_FECHADCF < LV_FECHADLL THEN
                  SV_TABLA := 'GA_INTARCEL';
                  SV_ACT := 'U';
                  IF EV_TIPPLAN = 'E' OR EV_TIPPLAN = 'H' THEN
                     LV_VAR_GRUPO := EN_GRUPO;
                  ELSIF EV_TIPPLAN = 'I' THEN
                     LV_VAR_GRUPO := NULL;
                  END IF;
                  LV_FEC_AUX := LV_FECHADLL - (1/(24*60*60));
                  SV_TABLA := 'GA_INTARCEL6';--COL-37481|15-02-2007|GEZ
                  SV_ACT := 'U';             --COL-37481|15-02-2007|GEZ
                  UPDATE GA_INTARCEL
                  SET FEC_HASTA = LV_FEC_AUX
                  WHERE ROWID = LV_ROWID;

                  SV_TABLA := 'GA_INTARCEL';
                  SV_ACT := 'I';
                  -- Inicio Inc. 76605|COL|27/01/2009|JJR.-
                  SELECT  b.cod_planserv
                  INTO    LV_PLANSERV
                  FROM   ta_plantarif a, ga_plantecplserv b
                  WHERE a.cod_plantarif= EV_PLANTARIF
                  AND   a.cod_plantarif = b.cod_plantarif
                  and   a.cod_producto  = b.cod_producto
                  and   b.cod_tecnologia = LV_TECNOLOGIA;

                  UPDATE GA_ABOCEL
                  SET cod_planserv = LV_PLANSERV
                  WHERE num_abonado = LV_ABONADO;
                  -- Fin Inc. 76605|COL|27/01/2009|JJR.-

                  INSERT INTO GA_INTARCEL(
                     COD_CLIENTE,NUM_ABONADO,IND_NUMERO,
                     FEC_DESDE,FEC_HASTA,IMP_LIMCONSUMO,
                     IND_FRIENDS,IND_DIASESP,COD_CELDA,
                     TIP_PLANTARIF,COD_PLANTARIF,NUM_SERIE,
                     NUM_CELULAR,COD_CARGOBASICO,COD_CICLO,
                     COD_PLANCOM,COD_PLANSERV,COD_GRPSERV,
                     COD_GRUPO,COD_PORTADOR,COD_USO,NUM_IMSI
                  ) VALUES (
                     LV_CLIENTE,LV_ABONADO,LV_NUMERO,
                     LV_FECHADLL,LV_FECHASTA,LV_LIMCONSUMO,
                     LV_FRIENDS,LV_DIASESP,LV_CELDA,
                     EV_TIPPLAN,EV_PLANTARIF,LV_SERIE,
                     LV_CELULAR,LV_VP_CARGOBASICO,LV_CICLO,
                     LV_PLANCOM,LV_PLANSERV,LV_GRPSERV,LV_VAR_GRUPO,
                     LV_PORTADOR,LV_USO,LV_NUM_IMSI
                  );
                  SV_TABLA := 'PV_ACTUALIZA_CAMB_COMERC_PR1';--COL-37481|15-02-2007|GEZ
                  SV_ACT := 'P';                                         --COL-37481|15-02-2007|GEZ
                  PV_ACTUALIZA_CAMB_COMERC_PR(LV_CLIENTE,LV_ABONADO,LV_NUMERO,'CT',LV_FECHADLL,LV_vErrorAplic,LV_vErrorGlosa,LV_vErrorOra,LV_vErrorOraGlosa,LV_vTrace);
                  IF LV_vErrorAplic = 'FALSE' THEN
                     SV_ERROR := '4';
                     RAISE ERROR_PROCESO;
                  END IF;
               END IF;
            ELSE
               SV_TABLA := 'GA_INTARCEL';
               SV_ACT := 'U';
               LV_FEC_AUX := LV_FECHADLL - (1/(24*60*60));
               SV_TABLA := 'GA_INTARCEL7';--COL-37481|15-02-2007|GEZ
               SV_ACT := 'U';             --COL-37481|15-02-2007|GEZ
               UPDATE GA_INTARCEL
               SET FEC_HASTA = LV_FEC_AUX
               WHERE ROWID = LV_ROWID;
               IF LV_INDCAR <> 0 THEN
                  --SV_TABLA := 'GA_INTARCEL';--COL-37481|15-02-2007|GEZ
                  SV_TABLA := 'GA_INTARCEL8'; --COL-37481|15-02-2007|GEZ
                  SV_ACT := 'I';
                  IF EV_TIPPLAN = 'E' OR EV_TIPPLAN = 'H' THEN
                     LV_VAR_GRUPO := EN_GRUPO;
                  ELSIF EV_TIPPLAN = 'I' THEN
                     LV_VAR_GRUPO := NULL;
                  END IF;
                  -- Inicio Inc. 76605|COL|27/01/2009|JJR.-
                  SELECT  b.cod_planserv
                  INTO    LV_PLANSERV
                  FROM   ta_plantarif a, ga_plantecplserv b
                  WHERE a.cod_plantarif= EV_PLANTARIF
                  AND   a.cod_plantarif = b.cod_plantarif
                  and   a.cod_producto  = b.cod_producto
                  and   b.cod_tecnologia = LV_TECNOLOGIA;

                  UPDATE GA_ABOCEL
                  SET cod_planserv = LV_PLANSERV
                  WHERE num_abonado = LV_ABONADO;
                  -- Fin Inc. 76605|COL|27/01/2009|JJR.-

                  INSERT INTO GA_INTARCEL(
                     COD_CLIENTE,NUM_ABONADO,IND_NUMERO,FEC_DESDE,FEC_HASTA,IMP_LIMCONSUMO,
                     IND_FRIENDS,IND_DIASESP,COD_CELDA,TIP_PLANTARIF,COD_PLANTARIF,NUM_SERIE,
                     NUM_CELULAR,COD_CARGOBASICO,COD_CICLO,COD_PLANCOM,COD_PLANSERV,COD_GRPSERV,
                     COD_GRUPO,COD_PORTADOR,COD_USO,NUM_IMSI
                  ) VALUES (
                     LV_CLIENTE,LV_ABONADO,LV_NUMERO,LV_FECHADLL,LV_FECHADCF - (1/(24*60*60)),
                     LV_LIMCONSUMO,LV_FRIENDS,LV_DIASESP,LV_CELDA,EV_TIPPLAN,EV_PLANTARIF,LV_SERIE,
                     LV_CELULAR,LV_VP_CARGOBASICO,LV_CICLO,LV_PLANCOM,LV_PLANSERV,LV_GRPSERV,
                     LV_VAR_GRUPO,LV_PORTADOR,LV_USO,LV_NUM_IMSI
                  );

                  SV_TABLA := 'PV_ACTUALIZA_CAMB_COMERC_PR2';--COL-37481|15-02-2007|GEZ
                  SV_ACT := 'P';                                         --COL-37481|15-02-2007|GEZ
                  PV_ACTUALIZA_CAMB_COMERC_PR(LV_CLIENTE,LV_ABONADO,LV_NUMERO,'CT',LV_FECHADLL,LV_vErrorAplic,LV_vErrorGlosa,LV_vErrorOra,LV_vErrorOraGlosa,LV_vTrace);
                  IF LV_vErrorAplic = 'FALSE' THEN
                     SV_ERROR := '4';
                     RAISE ERROR_PROCESO;
                  END IF;
                  --SV_TABLA := 'GA_INTARCEL';--COL-37481|15-02-2007|GEZ
                  SV_TABLA := 'GA_INTARCEL9'; --COL-37481|15-02-2007|GEZ
                  SV_ACT := 'U';
                  UPDATE GA_INTARCEL
                  SET TIP_PLANTARIF = EV_TIPPLAN,
                  COD_PLANTARIF = EV_PLANTARIF,
                  COD_CARGOBASICO = LV_VP_CARGOBASICO,
                  COD_GRUPO = LV_VAR_GRUPO,NUM_IMSI = LV_NUM_IMSI
                  WHERE COD_CLIENTE = LV_CLIENTE
                  AND NUM_ABONADO = LV_ABONADO
                  AND TRUNC(FEC_DESDE) = TRUNC(LV_FECHADCF);
               ELSE
                  --SV_TABLA := 'GA_INTARCEL';--COL-37481|15-02-2007|GEZ
                  SV_TABLA := 'GA_INTARCEL10';--COL-37481|15-02-2007|GEZ
                  SV_ACT := 'I';
                  IF EV_TIPPLAN = 'E' OR EV_TIPPLAN = 'H' THEN
                     LV_VAR_GRUPO := EN_GRUPO;
                  ELSIF EV_TIPPLAN = 'I' THEN
                     LV_VAR_GRUPO := NULL;
                  END IF;
                  -- Inicio Inc. 76605|COL|27/01/2009|JJR.-
                  SELECT  b.cod_planserv
                  INTO    LV_PLANSERV
                  FROM   ta_plantarif a, ga_plantecplserv b
                  WHERE a.cod_plantarif= EV_PLANTARIF
                  AND   a.cod_plantarif = b.cod_plantarif
                  and   a.cod_producto  = b.cod_producto
                  and   b.cod_tecnologia = LV_TECNOLOGIA;

                  UPDATE GA_ABOCEL
                  SET cod_planserv = LV_PLANSERV
                  WHERE num_abonado = LV_ABONADO;
                  -- Fin Inc. 76605|COL|27/01/2009|JJR.-

                  INSERT INTO GA_INTARCEL(
                     COD_CLIENTE,NUM_ABONADO,IND_NUMERO,FEC_DESDE,FEC_HASTA,IMP_LIMCONSUMO,
                     IND_FRIENDS,IND_DIASESP,COD_CELDA,TIP_PLANTARIF,COD_PLANTARIF,NUM_SERIE,
                     NUM_CELULAR,COD_CARGOBASICO,COD_CICLO,COD_PLANCOM,COD_PLANSERV,COD_GRPSERV,COD_GRUPO,COD_PORTADOR,COD_USO,NUM_IMSI
                  ) VALUES (
                     LV_CLIENTE,LV_ABONADO,LV_NUMERO,LV_FECHADLL,LV_FECHASTA,LV_LIMCONSUMO,
                     LV_FRIENDS,LV_DIASESP,LV_CELDA,EV_TIPPLAN,EV_PLANTARIF,LV_SERIE,
                     LV_CELULAR,LV_VP_CARGOBASICO,LV_CICLO,LV_PLANCOM,LV_PLANSERV,LV_GRPSERV,LV_VAR_GRUPO,
                     LV_PORTADOR,LV_USO,LV_NUM_IMSI
                  );

                  SV_TABLA := 'PV_ACTUALIZA_CAMB_COMERC_PR3';--COL-37481|15-02-2007|GEZ
                  SV_ACT := 'P';                                         --COL-37481|15-02-2007|GEZ
                  PV_ACTUALIZA_CAMB_COMERC_PR(LV_CLIENTE,LV_ABONADO,LV_NUMERO,'CT',LV_FECHADLL,LV_vErrorAplic,LV_vErrorGlosa,LV_vErrorOra,LV_vErrorOraGlosa,LV_vTrace);
                  IF LV_vErrorAplic = 'FALSE' THEN
                     SV_ERROR := '4';
                     RAISE ERROR_PROCESO;
                  END IF;
               END IF;
            END IF;
         END LOOP;
         SV_TABLA := 'C1';
         SV_ACT := 'C';
         CLOSE C1;
         dbms_output.put_line('Fin Loop');
      END IF;
      --INI 34724|01-03-2007|GEZ
      begin
         SV_TABLA := 'GA_INTARCEL11';
         SV_ACT := 'S';
         DBMS_OUTPUT.PUT_LINE ('SV_TABLA:' || SV_TABLA);
         SELECT IND_NUMERO, FEC_DESDE,FEC_HASTA,IMP_LIMCONSUMO, IND_FRIENDS,IND_DIASESP,COD_CELDA,
         TIP_PLANTARIF,COD_PLANTARIF,NUM_SERIE, NUM_CELULAR,COD_CARGOBASICO,COD_CICLO, COD_PLANCOM,COD_PLANSERV,COD_GRPSERV,
         COD_GRUPO,COD_PORTADOR,COD_USO
         INTO LV_NUMERO, LV_FECDESDE,LV_FECHASTA,LV_LIMCONSUMO, LV_FRIENDS,LV_DIASESP,LV_CELDA,
         LV_TIPPLANTARIF,LV_PLANTARIF,LV_SERIE, LV_CELULAR,LV_CARGOBASICO,LV_CICLO, LV_PLANCOM,LV_PLANSERV,LV_GRPSERV,
         LV_GRUPO,LV_PORTADOR,LV_USO
         FROM GA_INTARCEL
         WHERE NUM_ABONADO = 0
         AND COD_CLIENTE=EN_CLIENTE
         AND SYSDATE BETWEEN FEC_DESDE AND FEC_HASTA;
         IF TRIM(LV_PLANTARIF)<>TRIM(EV_PLANTARIF) THEN
            SV_TABLA := 'GA_INTARCEL12';
            SV_ACT := 'U';
            -- INI COL-42762|31-07-2007|PCR
            LV_FEC_AUX := LV_FECHADLL - (1/(24*60*60));
            -- FIN COL-42762|31-07-2007|PCR
            UPDATE GA_INTARCEL
            SET FEC_HASTA = LV_FEC_AUX
            WHERE NUM_ABONADO=0
            AND COD_CLIENTE=EN_CLIENTE
            AND SYSDATE BETWEEN FEC_DESDE AND FEC_HASTA;

            SV_TABLA := 'GA_INTARCEL13';
            SV_ACT := 'I2';
            --ini 71988/19-10-2008/EFR
            BEGIN
               SV_TABLA := 'TOL_LIMITE_PLAN_TD-TOL_LIMITE_TD';
               SV_ACT := 'S';
               SELECT B.IMP_LIMITE INTO LV_LIMCONSUMO
               FROM TOL_LIMITE_PLAN_TD A, TOL_LIMITE_TD B
               WHERE A.COD_LIMCONS = B.COD_LIMCONS
               AND   B.COD_LIMCONS > '0'
               AND A.IND_DEFAULT = 'S'
               AND SYSDATE BETWEEN A.FEC_DESDE AND A.FEC_HASTA
               AND A.COD_PLANTARIF = EV_PLANTARIF;
            EXCEPTION
               WHEN NO_DATA_FOUND THEN
                  LV_LIMCONSUMO := 0;
            END;
            --fin 71988/19-10-2008/EFR

            -- Inicio Inc. 76605|COL|27/01/2009|JJR.-
            SELECT  b.cod_planserv
            INTO    LV_PLANSERV
            FROM   ta_plantarif a, ga_plantecplserv b
            WHERE  a.cod_plantarif= EV_PLANTARIF
            AND    a.cod_plantarif = b.cod_plantarif
            and    a.cod_producto  = b.cod_producto
            and   b.cod_tecnologia = LV_TECNOLOGIA;

            /* abonado o
            UPDATE GA_ABOCEL
            SET cod_planserv = LV_PLANSERV
            WHERE num_abonado = LN_NumAbonado;
            */
            -- Fin Inc. 76605|COL|27/01/2009|JJR.-

            INSERT INTO GA_INTARCEL (
               COD_CLIENTE,NUM_ABONADO,IND_NUMERO, FEC_DESDE,FEC_HASTA,IMP_LIMCONSUMO,
               IND_FRIENDS,IND_DIASESP,COD_CELDA, TIP_PLANTARIF,COD_PLANTARIF,NUM_SERIE,
               NUM_CELULAR,COD_CARGOBASICO,COD_CICLO, COD_PLANCOM,COD_PLANSERV,COD_GRPSERV,
               COD_GRUPO,COD_PORTADOR,COD_USO,NUM_IMSI
            ) VALUES (
              EN_CLIENTE,0,LV_NUMERO,
               --LV_FEC_AUX,TO_DATE('31-12-3000','DD-MM-YYYY'),LV_LIMCONSUMO, --COL-42762|31-07-2007|PCR
               LV_FECHADLL,TO_DATE('31-12-3000','DD-MM-YYYY'),LV_LIMCONSUMO,
               LV_FRIENDS,LV_DIASESP,LV_CELDA,
               EV_TIPPLAN,TRIM(EV_PLANTARIF),LV_SERIE,
               LV_CELULAR,LV_VP_CARGOBASICO,LV_CICLO,
               LV_PLANCOM,LV_PLANSERV,LV_GRPSERV,LV_VAR_GRUPO,
               LV_PORTADOR,LV_USO,0
            );

            SV_TABLA := 'GA_INTARCEL_ACCIONES_TO';
            SV_ACT := 'I';
            INSERT INTO GA_INTARCEL_ACCIONES_TO (
               COD_CLIENTE,NUM_ABONADO, IND_NUMERO, FEC_DESDE,COD_ACTABO, NOM_USUARORA,FEC_INGRESO
            ) VALUES (
               EN_CLIENTE,0,LV_NUMERO,LV_FECHADLL,'CT',USER,SYSDATE
            );
         END IF;
      EXCEPTION
         WHEN NO_DATA_FOUND THEN
            NULL;
      END;
      --FIN 34724|01-03-2007|GEZ

      --INI COL-37481|15-02-2007|GEZ
      SELECT max(FEC_hasta)
      INTO  Ld_FECHA_hasta
      FROM  GA_INTARCEL
      WHERE COD_CLIENTE = EN_CLIENTE
      AND   NUM_ABONADO = EN_ABONADO;

      -- ini 71929/ 18-10-2008/EFR
      SELECT  COD_CARGOBASICO
      INTO LV_COD_CARGOBASICO
      FROM TA_PLANTARIF
      WHERE  COD_PLANTARIF = EV_PLANTARIF;
      --fin  71929/ 18-10-2008/EFR

      UPDATE GA_INTARCEL
      SET COD_PLANTARIF = EV_PLANTARIF ,
      COD_CARGOBASICO   =  LV_COD_CARGOBASICO -- 71929/ 18-10-2008/EFR
      WHERE COD_CLIENTE = EN_CLIENTE
      AND   NUM_ABONADO = EN_ABONADO
      AND   FEC_HASTA   = Ld_FECHA_hasta;

      --INI COL-71988|19-10-2008|Orlando Cabezas
      SELECT COUNT(1)INTO LN_CANT_AUX1
      FROM GA_INTARCEL
      WHERE COD_CLIENTE       = EN_CLIENTE
      AND   NUM_ABONADO       = EN_ABONADO
      AND   COD_PLANTARIF     = EV_PLANTARIF ;

      IF LN_CANT_AUX1= 2 THEN
         SELECT MAX(FEC_HASTA) INTO LN_FEC_HASTA_AUX
         FROM GA_INTARCEL
         WHERE COD_CLIENTE       = EN_CLIENTE
         AND   NUM_ABONADO       = EN_ABONADO
         AND   COD_PLANTARIF     = EV_PLANTARIF
         AND   FEC_HASTA         < Ld_FECHA_hasta;

         DELETE
         FROM GA_INTARCEL
         WHERE COD_CLIENTE       = EN_CLIENTE
         AND   NUM_ABONADO       = EN_ABONADO
         AND   COD_PLANTARIF     = EV_PLANTARIF
         AND   FEC_HASTA         = LN_FEC_HASTA_AUX;

         UPDATE GA_INTARCEL
         SET FEC_DESDE=LV_FECHADCF
         WHERE COD_CLIENTE       = EN_CLIENTE
         AND   NUM_ABONADO       = EN_ABONADO
         AND   COD_PLANTARIF     = EV_PLANTARIF
         AND   FEC_HASTA         = Ld_FECHA_hasta;
      END IF;

      IF LV_CODOS = '10022' THEN
         SELECT max(FEC_DESDE)
         INTO  Ld_FECHA_DESDE
         FROM  GA_LIMITE_CLIABO_TO
         WHERE COD_CLIENTE       = EN_CLIENTE
         AND   NUM_ABONADO       = 0
         AND   COD_PLANTARIF     = EV_PLANTARIF;


         UPDATE  GA_LIMITE_CLIABO_TO
         SET FEC_HASTA =NULL
         WHERE COD_CLIENTE       = EN_CLIENTE
         AND   NUM_ABONADO       = 0
         AND   COD_PLANTARIF     = EV_PLANTARIF
         AND   FEC_DESDE         = Ld_FECHA_DESDE;


         SELECT max(FEC_HASTA)
         INTO  Ld_FECHA_HASTA
         FROM  GA_INTARCEL
         WHERE COD_CLIENTE       = EN_CLIENTE
         AND   NUM_ABONADO       = 0
         AND   COD_PLANTARIF     = EV_PLANTARIF;

         SELECT  COD_LIMCONS
         INTO COD_LIMCONS_AUX_REG
         FROM TOL_LIMITE_PLAN_TD
         WHERE COD_PLANTARIF     = EV_PLANTARIF
         AND IND_DEFAULT ='S'
         AND SYSDATE BETWEEN FEC_DESDE AND FEC_HASTA;

         SELECT  IMP_LIMITE
         INTO IMP_LIMITE_AUX_REG
         FROM TOL_LIMITE_TD
         WHERE COD_LIMCONS     = COD_LIMCONS_AUX_REG
         AND SYSDATE BETWEEN FEC_DESDE AND FEC_HASTA;


         UPDATE  GA_INTARCEL
         SET IMP_LIMCONSUMO =IMP_LIMITE_AUX_REG
         WHERE COD_CLIENTE       = EN_CLIENTE
         AND   NUM_ABONADO       = 0
         AND   COD_PLANTARIF     = EV_PLANTARIF
         AND   FEC_HASTA         = Ld_FECHA_HASTA;
      END IF;
   END IF;
   IF EN_PRODUCTO = 1 THEN
      SV_TABLA := 'GE_FN_DEVVALPARAM1';
      SV_ACT := 'F';
      LVUsoHibrido  := GE_FN_DEVVALPARAM('GA', 1, 'USO_HIBRIDO_GSM_TDMA');

      SV_TABLA := 'GE_FN_DEVVALPARAM1';
      SV_ACT := 'F';
      LVTiPlanHib:= GE_FN_DEVVALPARAM('GA', 1, 'TIP_PLAN_HIBRIDO');

      dbms_output.put_line ('LVCodUsoAct:' || LVCodUsoAct);
      dbms_output.put_line ('LVCodTiplaNue:' || LVCodTiplaNue);

      IF LVCodUsoAct = LVUsoHibrido AND LVCodTiplaNue= LVTiPlanHib THEN
         SV_TABLA := 'PV_ICC_CAMBIOPLAN_HIB_PR';
         SV_ACT:='P';
         /*Inicio COl-38908|23/03/2007|jjr
         --PV_ICC_CAMBIOPLAN_HIB_PR(EN_ABONADO,EV_PLANTARIF,SV_SQLCODE,SV_SQLERRM,SV_ERROR, -- COL-38908|23/03/2007|jjr
         --                     SV_mens_retorno,SV_TABLA,SV_ACT,SN_num_evento);             -- COL-38908|23/03/2007|jjr

         IF SV_mens_retorno <> 'OK' THEN
            SV_ERROR := '4';
            RAISE ERROR_PROCESO;
         END IF;
         Fin COl-38908|23/03/2007|jjr*/

         --- INICIO RRG 45898 23-11-2007  COL
         --- SE REVERSAN LOS CAMBIOS DE LA INCIDENCIA  38908|
         dbms_output.put_line ('PV_ICC_CAMBIOPLAN_HIB_PR');
         PV_ICC_CAMBIOPLAN_HIB_PR(EN_ABONADO,EV_PLANTARIF,SV_SQLCODE,SV_SQLERRM,SV_ERROR,SV_mens_retorno,SV_TABLA,SV_ACT,SN_num_evento);
         dbms_output.put_line('SV_SQLCODE' || SV_SQLCODE);
         dbms_output.put_line('SV_SQLERRM' || SV_SQLERRM);
         dbms_output.put_line('SV_ERROR' || SV_ERROR);
         dbms_output.put_line('SV_mens_retorno' || SV_mens_retorno);
         dbms_output.put_line('SV_TABLA' || SV_TABLA);
         IF SV_mens_retorno <> 'OK' THEN
            SV_ERROR := '4';
            RAISE ERROR_PROCESO;
         END IF;
         --- FIN RRG 45898 23-11-2007 COL
      END IF;
      --FIN COL-37481|15-02-2007|GEZ
   ELSIF EN_PRODUCTO = 2 THEN
      SV_TABLA := 'GA_INTARBEEP';
      SV_ACT := 'S';
      BEGIN
         SELECT NUM_ABONADO
         INTO LV_VAR1
         FROM GA_INTARBEEP
         WHERE COD_CLIENTE = EN_CLIENTE
         AND NUM_ABONADO = EN_ABONADO
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
         FROM GA_INTARBEEP
         WHERE COD_CLIENTE = EN_CLIENTE
         AND NUM_ABONADO = EN_ABONADO
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
            SELECT FEC_DESDE
            INTO LV_FECHAD
            FROM GA_INTARBEEP
            WHERE COD_CLIENTE = EN_CLIENTE
            AND NUM_ABONADO = EN_ABONADO
            AND LV_FECSYS BETWEEN FEC_DESDE AND FEC_HASTA
            AND ROWNUM = 1;
            LV_FECHA := LV_FECHAD;
         EXCEPTION
            WHEN OTHERS THEN
               SV_ERROR := '4';
               RAISE ERROR_PROCESO;
         END;
      ELSIF LV_INDLLA <> 0 THEN
         SV_TABLA := 'GA_INTARBEEP';
         SV_ACT := 'U';
         IF EV_TIPPLAN = 'E' OR EV_TIPPLAN = 'H' THEN
            LV_VAR_GRUPO := EN_GRUPO;
         ELSIF EV_TIPPLAN = 'I' THEN
            LV_VAR_GRUPO := NULL;
         END IF;
         UPDATE GA_INTARBEEP
         SET TIP_PLANTARIF = EV_TIPPLAN,
         COD_PLANTARIF = EV_PLANTARIF,
         COD_GRUPO = LV_VAR_GRUPO
         WHERE COD_CLIENTE = EN_CLIENTE
         AND NUM_ABONADO = EN_ABONADO
         AND FEC_DESDE >= LV_FECHADLL;
         SV_ERROR := '0';
         RAISE ERROR_PROCESO;
      ELSIF LV_INDCAR <> 0 THEN
         IF LV_FECHADLL >= LV_FECHADCF THEN
            LV_FECHA := LV_FECHADCF;
         ELSE
            LV_FECHA := LV_FECHAD;
         END IF;
      END IF;
      SV_TABLA := 'GA_INTARBEEP';
      SV_ACT := 'S';
      SELECT ROWID,COD_CLIENTE,NUM_ABONADO, FEC_DESDE,FEC_HASTA,IMP_LIMCONSUMO,
      IND_DIASESP,TIP_PLANTARIF,COD_PLANTARIF, CAP_CODE,NUM_BEEPER,COD_CARGOBASICO,
      COD_CICLO,COD_PLANCOM,COD_PLANSERV, COD_GRPSERV,COD_GRUPO
      INTO LV_ROWID,LV_CLIENTE,LV_ABONADO, LV_FECDESDE,LV_FECHASTA,LV_LIMCONSUMO,
      LV_DIASESP,LV_TIPPLANTARIF,LV_PLANTARIF, LV_CAPCODE,LV_BEEPER,LV_CARGOBASICO,
      LV_CICLO,LV_PLANCOM,LV_PLANSERV, LV_GRPSERV,LV_GRUPO
      FROM GA_INTARBEEP
      WHERE COD_CLIENTE = EN_CLIENTE
      AND NUM_ABONADO = EN_ABONADO
      AND FEC_DESDE = LV_FECHA;
      IF LV_FECHA = LV_FECHADCF THEN
         IF LV_FECHADCF = LV_FECHADLL THEN
            SV_TABLA := 'GA_INTARBEEP';
            SV_ACT := 'U';
            IF EV_TIPPLAN = 'E' OR EV_TIPPLAN = 'H' THEN
               LV_VAR_GRUPO := EN_GRUPO;
            ELSIF EV_TIPPLAN = 'I' THEN
               LV_VAR_GRUPO := NULL;
            END IF;
            UPDATE GA_INTARBEEP
            SET TIP_PLANTARIF = EV_TIPPLAN,
            COD_PLANTARIF = EV_PLANTARIF,
            COD_GRUPO = LV_VAR_GRUPO
            WHERE ROWID = LV_ROWID;
         ELSIF LV_FECHADCF < LV_FECHADLL THEN
            SV_TABLA := 'GA_INTARBEEP';
            SV_ACT := 'U';
            SELECT NUM_DIAS,COD_CARGOBASICO
            INTO LV_DIAS,LV_VP_CARGOBASICO
            FROM TA_PLANTARIF
            WHERE COD_PRODUCTO = EN_PRODUCTO AND COD_PLANTARIF = EV_PLANTARIF;
            LV_FEC_AUX := LV_FECHADLL - (1/(24*60*60));
            UPDATE GA_INTARBEEP
            SET FEC_HASTA = LV_FEC_AUX
            WHERE ROWID = LV_ROWID;
            SV_TABLA := 'GA_INTARBEEP';
            SV_ACT := 'I';
            IF EV_TIPPLAN = 'E' OR EV_TIPPLAN = 'H' THEN
               LV_VAR_GRUPO := EN_GRUPO;
            ELSIF EV_TIPPLAN = 'I' THEN
               LV_VAR_GRUPO := NULL;
            END IF;
            INSERT INTO GA_INTARBEEP (
               COD_CLIENTE,NUM_ABONADO,FEC_DESDE,
               FEC_HASTA,IMP_LIMCONSUMO,IND_DIASESP,
               TIP_PLANTARIF,COD_PLANTARIF,CAP_CODE,
               NUM_BEEPER,COD_CARGOBASICO,COD_CICLO,
               COD_PLANCOM,COD_PLANSERV,COD_GRPSERV,
               COD_GRUPO
            ) VALUES (
               LV_CLIENTE,LV_ABONADO,LV_FECHADLL,
               LV_FECHASTA,LV_LIMCONSUMO,LV_DIASESP,
               EV_TIPPLAN,EV_PLANTARIF,LV_CAPCODE,
               LV_BEEPER,LV_CARGOBASICO,LV_CICLO,
               LV_PLANCOM,LV_PLANSERV,LV_GRPSERV,LV_VAR_GRUPO
            );
         END IF;
      ELSE
         SV_TABLA := 'GA_INTARBEEP';
         SV_ACT := 'U';
         LV_FEC_AUX :=  LV_FECHADLL - (1/(24*60*60));
         UPDATE GA_INTARBEEP
         SET FEC_HASTA = LV_FEC_AUX
         WHERE ROWID = LV_ROWID;
         IF LV_INDCAR <> 0 THEN
            SV_TABLA := 'GA_INTARBEEP';
            SV_ACT := 'I';
            IF EV_TIPPLAN = 'E' OR EV_TIPPLAN = 'H' THEN
               LV_VAR_GRUPO := EN_GRUPO;
            ELSIF EV_TIPPLAN = 'I' THEN
               LV_VAR_GRUPO := NULL;
            END IF;
            INSERT INTO GA_INTARBEEP(
               COD_CLIENTE,NUM_ABONADO,FEC_DESDE,
               FEC_HASTA,IMP_LIMCONSUMO,IND_DIASESP,
               TIP_PLANTARIF,COD_PLANTARIF,CAP_CODE,
               NUM_BEEPER,COD_CARGOBASICO,COD_CICLO,
               COD_PLANCOM,COD_PLANSERV,COD_GRPSERV,
               COD_GRUPO
            ) VALUES (
               LV_CLIENTE,LV_ABONADO,LV_FECHADLL,
               LV_FECHADCF - (1/(24*60*60)),LV_LIMCONSUMO,LV_DIASESP,
               EV_TIPPLAN,EV_PLANTARIF,LV_CAPCODE,
               LV_BEEPER,LV_CARGOBASICO,LV_CICLO,
               LV_PLANCOM,LV_PLANSERV,LV_GRPSERV,LV_VAR_GRUPO
            );
            SV_TABLA := 'GA_INTARBEEP';
            SV_ACT := 'U';
            UPDATE GA_INTARBEEP
            SET TIP_PLANTARIF = EV_TIPPLAN,
            COD_PLANTARIF = EV_PLANTARIF,
            COD_CARGOBASICO = LV_VP_CARGOBASICO,
            COD_GRUPO = LV_VAR_GRUPO
            WHERE COD_CLIENTE = LV_CLIENTE
            AND NUM_ABONADO = LV_ABONADO
            AND FEC_DESDE = LV_FECHADCF;
         ELSE
            SV_TABLA := 'GA_INTARBEEP';
            SV_ACT := 'I';
            IF EV_TIPPLAN = 'E' OR EV_TIPPLAN = 'H' THEN
               LV_VAR_GRUPO := EN_GRUPO;
            ELSIF EV_TIPPLAN = 'I' THEN
               LV_VAR_GRUPO := NULL;
            END IF;
            INSERT INTO GA_INTARBEEP(
               COD_CLIENTE,NUM_ABONADO,FEC_DESDE,
               FEC_HASTA,IMP_LIMCONSUMO,IND_DIASESP,
               TIP_PLANTARIF,COD_PLANTARIF,CAP_CODE,
               NUM_BEEPER,COD_CARGOBASICO,COD_CICLO,
               COD_PLANCOM,COD_PLANSERV,COD_GRPSERV,
               COD_GRUPO
            ) VALUES (
               LV_CLIENTE,LV_ABONADO,LV_FECHADLL,
               LV_FECHASTA,LV_LIMCONSUMO,LV_DIASESP,
               EV_TIPPLAN,EV_PLANTARIF,LV_CAPCODE,
               LV_BEEPER,LV_VP_CARGOBASICO,LV_CICLO,
               LV_PLANCOM,LV_PLANSERV,LV_GRPSERV,LV_VAR_GRUPO
            );
         END IF;
      END IF;
   END IF;
   IF ( LN_NUM_OS_AUX = 0) THEN -- 71929/ 18-10-2008/EFR
      IF EV_TIPPLANTANT = 'H' THEN
         IF EV_TIPPLANTANT <> EV_TIPPLAN THEN
            IF EV_TIPPLANTANT <> 'I' THEN
               LV_PLANTANT := EV_TIPPLANTANT;
               LV_GRUPANT := EN_EMPRESA;
            END IF;
         ELSE
            IF EN_GRUPO <> EN_HOLDING THEN
               LV_PLANTANT := EV_TIPPLANTANT;
               LV_GRUPANT := EN_HOLDING;
            ELSE
               LV_PLANTANT := NULL;
               LV_GRUPANT := NULL;
            END IF;
         END IF;
      ELSIF EV_TIPPLANTANT = 'E' THEN
         IF EV_TIPPLANTANT <> EV_TIPPLAN THEN
            IF EV_TIPPLANTANT <> 'I' THEN
               LV_PLANTANT := EV_TIPPLANTANT;
               LV_GRUPANT := EN_HOLDING;
            END IF;
         ELSE
            IF EN_GRUPO <> EN_HOLDING THEN
               LV_PLANTANT := EV_TIPPLANTANT;
               LV_GRUPANT := EN_EMPRESA;
            ELSE
               LV_PLANTANT := NULL;
               LV_GRUPANT := NULL;
            END IF;
         END IF;
      END IF;
      SV_ERROR := '0';
      RAISE ERROR_PROCESO;
   END IF;
   SV_ERROR := '0';
EXCEPTION
   --INI COL-73515|12-12-2008|GEZ
   WHEN NUEVO_CAMBIOPLAN THEN
      DBMS_OUTPUT.Put_Line('ANTES DE PV_CAMBIO_PLAN_ABO_PR');
      pv_cambio_plan_abo_pr(EN_NUM_OS,SV_ERROR,SV_Proc,SN_cod_retorno,SN_num_evento,SV_Tabla,SV_Act,SV_SQLCODE,SV_SQLERRM);
      IF SV_ERROR='3' THEN
         SV_ERROR:='0';
         SV_SQLCODE:='0';
         SV_SQLERRM:='0';
      ELSE
         IF NOT ge_errores_pg.mensajeerror(SN_cod_retorno, SV_mens_retorno) THEN
            SV_mens_retorno := 'Error No Clasificado';
         END IF;
         SV_SQLERRM:='E:'||SN_num_evento||'-'||SV_SQLERRM;
         P_INSERTA_ERRORES(1,'CT',EN_NUM_OS,SYSDATE,SV_Proc,SV_Tabla,SV_Act,SV_SQLCODE,SV_SQLERRM);
      END IF;
   --FIN COL-73515|12-12-2008|GEZ
   WHEN ERROR_PROCESO THEN
      IF SV_ERROR = '0' THEN
         BEGIN
            SV_TABLA := 'GA_FINCICLO';
            SV_ACT := 'S';
            SELECT ROWID INTO LV_ROWID
            FROM GA_FINCICLO
            WHERE COD_CLIENTE = EN_CLIENTE
            AND NUM_ABONADO = EN_ABONADO
            AND COD_CICLFACT = LV_CICLFACT;

            SV_TABLA := 'GA_FINCICLO';
            SV_ACT := 'U';
            IF EV_TIPPLAN = 'E' OR EV_TIPPLAN = 'H' THEN
               LV_VAR_GRUPO := EN_GRUPO;
            ELSIF EV_TIPPLAN = 'I' THEN
               LV_VAR_GRUPO := NULL;
            END IF;
            UPDATE GA_FINCICLO
            SET TIP_PLANTARIF = EV_TIPPLAN,
            COD_PLANTARIF = EV_PLANTARIF,
            COD_CARGOBASICO = LV_VP_CARGOBASICO,
            COD_GRUPO = LV_VAR_GRUPO,
            FEC_DESDELLAM = DECODE(FEC_DESDELLAM,NULL,LV_FECHADLL,FEC_DESDELLAM),
            TIP_PLANTANT = LV_PLANTANT,
            COD_GRUPANT = LV_GRUPANT,
            NUM_DIAS = LV_DIAS
            WHERE ROWID = LV_ROWID;
         EXCEPTION
            WHEN NO_DATA_FOUND THEN
               SV_TABLA := 'GA_FINCICLO';
               SV_ACT := 'I';
               IF EV_TIPPLAN = 'E' OR EV_TIPPLAN = 'H' THEN
                  LV_VAR_GRUPO := EN_GRUPO;
               ELSIF EV_TIPPLAN = 'I' THEN
                  LV_VAR_GRUPO := NULL;
               END IF;
               INSERT INTO GA_FINCICLO (
                  COD_CLIENTE, COD_CICLFACT, NUM_ABONADO, COD_PRODUCTO, TIP_PLANTARIF,
                  COD_PLANTARIF, COD_CARGOBASICO, COD_GRUPO, FEC_DESDELLAM, TIP_PLANTANT,
                  COD_GRUPANT, NUM_DIAS
               ) VALUES (
                  EN_CLIENTE, LV_CICLFACT, EN_ABONADO, EN_PRODUCTO, EV_TIPPLAN,
                  EV_PLANTARIF, LV_VP_CARGOBASICO, LV_VAR_GRUPO, LV_FECHADLL, LV_PLANTANT,
                  LV_GRUPANT, LV_DIAS
               );
            WHEN OTHERS THEN
               SV_SQLCODE := SQLCODE;
               SV_SQLERRM := SQLERRM;
               SV_ERROR := '4';
               SV_mens_retorno:= CV_error_no_clasif;
               LV_des_error:='PV_PLAN_TARIFARIO_BATCH_PR(' || EN_PRODUCTO || EN_CLIENTE ||EN_ABONADO || EV_TIPPLAN || EV_PLANTARIF || EN_CICLO || LV_FECSYS || EN_EMPRESA || EN_HOLDING ||EV_TIPPLANTANT ||EN_GRUPO || ')';
               SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,'PV_CAMBIOPLAN_BATCH_PG.PV_PLAN_TARIFARIO_BATCH_PR', sSql, SQLCODE, LV_des_error );
         END;
      ELSE
         IF SV_ERROR = '4' THEN
            SV_SQLCODE := SQLCODE;
            SV_SQLERRM := SQLERRM;
            SV_ERROR := '4';
            SV_mens_retorno:= CV_error_no_clasif;
            LV_des_error:='PV_PLAN_TARIFARIO_BATCH_PR(' || EN_PRODUCTO || EN_CLIENTE ||EN_ABONADO || EV_TIPPLAN || EV_PLANTARIF || EN_CICLO || LV_FECSYS || EN_EMPRESA || EN_HOLDING ||EV_TIPPLANTANT ||EN_GRUPO  || ')';
            SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,'PV_CAMBIOPLAN_BATCH_PG.PV_PLAN_TARIFARIO_BATCH_PR', sSql, SQLCODE, LV_des_error );
         ELSE
            IF SV_SQLCODE IS NULL THEN
               SV_SQLCODE := SQLCODE;
               SV_SQLERRM := SQLERRM;
            END IF;
         END IF;
      END IF;
   WHEN OTHERS THEN
      SV_SQLCODE := SQLCODE;
      SV_SQLERRM := SQLERRM;
      SV_ERROR := '4';
      SV_mens_retorno:= CV_error_no_clasif;
      LV_des_error:='PV_PLAN_TARIFARIO_BATCH_PR(' || EN_PRODUCTO || EN_CLIENTE ||EN_ABONADO || EV_TIPPLAN || EV_PLANTARIF || EN_CICLO || LV_FECSYS || EN_EMPRESA || EN_HOLDING ||EV_TIPPLANTANT ||EN_GRUPO || ')';
      SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,'PV_CAMBIOPLAN_BATCH_PG.PV_PLAN_TARIFARIO_BATCH_PR', sSql, SQLCODE, LV_des_error );
END PV_PLAN_TARIFARIO_BATCH_PR;


PROCEDURE PV_VALIDA_OOSS_BATCH_PEND_PR(EV_MOVIMIENTO   IN VARCHAR2,
                                   EN_NUM_OS       IN NUMBER ,
                                   EV_COD_OS       IN VARCHAR2,
                                 --  SV_FECSYS       IN OUT NOCOPY varchar2 ,
                                   SV_SQLCODE      IN OUT NOCOPY VARCHAR2 ,
                                   SV_SQLERRM      IN OUT NOCOPY VARCHAR2 ,
                                   SV_ERROR        IN OUT NOCOPY VARCHAR2 ,
                                   SN_cod_retorno  OUT NOCOPY GE_ERRORES_PG.CodError,
                                   SV_mens_retorno OUT NOCOPY GE_ERRORES_PG.MsgError,
                                   SN_num_evento   OUT NOCOPY GE_ERRORES_PG.Evento )

/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_ELIM_GA_FINCICLO_BATCH_PEND_PR"
      Lenguaje="PL/SQL"
      Fecha="17-04-2006"
      Versión="1.0"
      Diseñador="Manuel Acevedo M"
          Programador="Orlando Cabezas B"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
              <Descripción></Descripción>
       <Parámetros>
         <Entrada>
                        <param nom="EV_MOVIMIENTO"         Tipo="CARACTER">MOVIMIENTO</param>
                        <param nom="EN_NUM_OS"     Tipo="NUMERICO">Numero OOSS</param>
                        <param nom="EV_COD_OS"     Tipo="CARACTER">CODIGO OOSS</param>


         </Entrada>
         <Salida>
            <param nom="SV_SQLCODE"    Tipo="CARACTER">Codigo ORACLE</param>
            <param nom="SV_SQLERRM"   Tipo="CARACTER">Mensaje ORACLE</param>
            <param nom="SV_ERROR"     Tipo="CARACTER">RETORNO</param>
            <param nom="SN_cod_retorno"    Tipo="NUMERICO">Codigo error de negocio Retornado</param>
            <param nom="SV_mens_retorno"   Tipo="CARACTER">Mensaje error de negocio Retornado</param>
            <param nom="SN_num_evento"     Tipo="ge_errores_pg.Evento">Nro de evento</param>
         </Salida>
      </Parámetros>
  </Elemento>
</Documentación>
*/
IS

  LN_MAX_INTENTOS PV_IORSERV.NUM_INTENTOS%TYPE;
  LN_NUM_ABONADO  PV_CAMCOM.NUM_ABONADO%TYPE;
  LN_COD_CLIENTE  PV_CAMCOM.COD_CLIENTE%TYPE;
  LN_MOVIMIENTO   NUMBER;
  LN_IPOS         NUMBER;
  LN_CICLFACT_AUX GA_FINCICLO.COD_CICLFACT%TYPE;

  LV_OBS_DETALLE  PV_PARAM_ABOCEL.OBS_DETALLE%TYPE;
  LV_COD_ESTADO   PV_IORSERV.COD_ESTADO%TYPE;
  LV_FH_EJECUCION date;
  LV_FECSYS  date;
  LV_des_error         GE_ERRORES_PG.DesEvent;
  sSql                 GE_ERRORES_PG.vQuery;


BEGIN


   SV_SQLCODE :='0';
   SV_SQLERRM :='0';
   SV_ERROR   :='4';
   SN_cod_retorno   := 0;
   SV_mens_retorno  := 'OK';
   SN_num_evento         := 0;
    ssql :='' ;
        LV_FECSYS:=SYSDATE;

  IF EV_COD_OS is null or trim(EV_COD_OS)= '' THEN
           SELECT FH_EJECUCION,COD_ESTADO
           INTO LV_FH_EJECUCION ,LV_COD_ESTADO
           FROM PV_IORSERV
           WHERE
           NUM_OS               = EN_NUM_OS AND
           TRUNC(FH_EJECUCION)  > TRUNC(LV_FECSYS); /*Incidencia XO-200606021119 02-06-2006*/

           LV_FECSYS := LV_FH_EJECUCION;

           IF (LV_COD_ESTADO <= 210) THEN
               SV_ERROR   :='0';
           END IF;
   ELSE

        SELECT VAL_PARAMETRO
                INTO  LN_MAX_INTENTOS
                FROM GED_PARAMETROS
        WHERE NOM_PARAMETRO = 'MAX_INTENTOS'
        AND COD_PRODUCTO = 1
        AND COD_MODULO = 'GA';

                IF  EV_COD_OS  ='10020' THEN
                        UPDATE PV_IORSERV
                                SET
                                NUM_INTENTOS=LN_MAX_INTENTOS,
                                STATUS = 'CANCELADA'    --COL-72030|28-10-2008|DVG
                                WHERE
                                NUM_OS  = EN_NUM_OS;


                                UPDATE PV_ERECORRIDO
                                SET
                                --TIP_ESTADO=4
                                TIP_ESTADO=5,           --COL-72030|28-10-2008|DVG
                                MSG_ERROR = 'CANCELADA' --COL-72030|28-10-2008|DVG
                                WHERE
                                NUM_OS  = EN_NUM_OS;

                                SELECT A.NUM_ABONADO,A.COD_CLIENTE,B.OBS_DETALLE
                                INTO
                                LN_NUM_ABONADO,LN_COD_CLIENTE,LV_OBS_DETALLE
                                FROM  PV_CAMCOM A,PV_PARAM_ABOCEL B
                                WHERE
                                A.NUM_OS  = EN_NUM_OS AND A.NUM_OS  = B.NUM_OS;

                                --LN_IPOS := INSTR(LV_OBS_DETALLE,'');
                                LN_CICLFACT_AUX :=LV_OBS_DETALLE;

                                begin

                                DELETE GA_FINCICLO
                                WHERE
                                NUM_ABONADO  = LN_NUM_ABONADO AND
                                COD_CLIENTE  = LN_COD_CLIENTE AND
                                COD_CICLFACT = LN_CICLFACT_AUX;

                                exception
                                 WHEN NO_DATA_FOUND  THEN
                      SV_ERROR := '0';
                                end;

                ELSE
                                UPDATE PV_ERECORRIDO A
                                SET
                                --A.TIP_ESTADO = 4       -- COL-72030|28-10-2008|DVG
                                A.TIP_ESTADO = 5,         -- COL-72030|28-10-2008|DVG
                                A.MSG_ERROR = 'CANCELADA'   -- COL-72030|28-10-2008|DVG
                                WHERE
                                A.NUM_OS  IN (SELECT  B.NUM_OS FROM PV_IORSERV B
                                              WHERE
                                                          B.NUM_OS       = EN_NUM_OS  AND
                                              B.COD_OS       = EV_COD_OS);
---         AND TRUNC(B.FH_EJECUCION) = TRUNC(LV_FECSYS)); RRG 43737 03-09-2007 COL


                                UPDATE PV_IORSERV
                                SET
                                NUM_INTENTOS=LN_MAX_INTENTOS,
                                STATUS = 'CANCELADA'    --COL-72030|28-10-2008|DVG
                                WHERE
                                NUM_OS       = EN_NUM_OS  AND
                                COD_OS       = EV_COD_OS;
------                          AND TRUNC(FH_EJECUCION) = TRUNC(LV_FECSYS); RRG 43737 03-09-2007 COL


                END IF;

                SV_ERROR      :='0';
                LN_MOVIMIENTO :=TO_NUMBER(EV_MOVIMIENTO);

                IF LN_MOVIMIENTO IS NOT NULL THEN
                        INSERT INTO GA_TRANSACABO (NUM_TRANSACCION,COD_RETORNO,DES_CADENA)
                VALUES (LN_MOVIMIENTO,0,NULL);
                END IF;

   END IF;

EXCEPTION
      WHEN NO_DATA_FOUND  THEN

               SV_SQLCODE := SQLCODE;
           SV_SQLERRM := SQLERRM;
           SV_ERROR := '1';
          WHEN OTHERS  THEN
               SV_SQLCODE := SQLCODE;
               SV_SQLERRM := SQLERRM;
               SV_ERROR := '1';

           IF LN_MOVIMIENTO IS NOT NULL THEN
                        INSERT INTO GA_TRANSACABO (NUM_TRANSACCION,COD_RETORNO,DES_CADENA)
                VALUES (LN_MOVIMIENTO,4,NULL);
           END IF;

           SV_mens_retorno:= CV_error_no_clasif;
           LV_des_error:='PV_VALIDA_OOSS_BATCH_PEND_PR(' || EV_MOVIMIENTO || EN_NUM_OS ||EV_COD_OS || LV_FECSYS || ')';
           SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
           'PV_CAMBIOPLAN_BATCH_PG .PV_VALIDA_OOSS_BATCH_PEND_PR', sSql, SQLCODE, LV_des_error );


END PV_VALIDA_OOSS_BATCH_PEND_PR;

--INI COL-37481|15-02-2007|GEZ
PROCEDURE PV_ICC_CAMBIOPLAN_HIB_PR(ENNumAbonado         IN                                   NUMBER   ,
                                                                   EVPlanNue            IN                                       VARCHAR2 ,
                                   SV_SQLCODE              OUT NOCOPY            VARCHAR2 ,
                                   SV_SQLERRM              OUT NOCOPY            VARCHAR2 ,
                                   SV_ERROR                OUT NOCOPY            VARCHAR2 ,
                                   SV_mens_retorno         OUT NOCOPY            GE_ERRORES_PG.MsgError,
                                                                   SV_TABLA            OUT NOCOPY                VARCHAR2 ,
                                   SV_ACT              OUT NOCOPY                VARCHAR2 ,
                                                           SN_num_evento           OUT NOCOPY            GE_ERRORES_PG.Evento )

/*
<Documentación
  TipoDoc = "Procedimiento"                >
   <Elemento
      Nombre = "PV_ICC_CAMBIOPLAN_HIB_PR"
      Lenguaje="PL/SQL"
      Fecha="15-02-2007"
      Versión="1.0"
      Diseñador="German Espinoza Zuñiga"
          Programador="German Espinoza Zuñiga"
      Ambiente Desarrollo="SQACOL">
      <Retorno>NA</Retorno>
              <Descripción></Descripción>
       <Parámetros>
         <Entrada>
                        <param nom="ENNumAbonado"         Tipo="NUMERICO">Numero del Abonado</param>
                        <param nom="EVPlanNue"        Tipo="CARACTER">Plan Nuevo</param>
                 </Entrada>
         <Salida>
            <param nom="SV_SQLCODE"       Tipo="CARACTER">Codigo ORACLE</param>
            <param nom="SV_SQLERRM"       Tipo="CARACTER">Mensaje ORACLE</param>
            <param nom="SV_ERROR"         Tipo="CARACTER">RETORNO</param>
            <param nom="SN_cod_retorno"   Tipo="NUMERICO">Codigo error de negocio Retornado</param>
            <param nom="SV_mens_retorno"  Tipo="CARACTER">Mensaje error de negocio Retornado</param>
            <param nom="SN_num_evento"    Tipo="ge_errores_pg.Evento">Nro de evento</param>
         </Salida>
      </Parámetros>
  </Elemento>
</Documentación>
*/

IS
  LVOSCambPlanHib pv_actabo_tiplan.cod_os%TYPE;
  LVTiPlan                pv_actabo_tiplan.cod_tiplan%TYPE;

  LVCodTipModi    ci_tiporserv.cod_tipmodi%TYPE;

  LVCodActabo     ga_actabo.cod_actabo%TYPE;
  LVCodActcen     ga_actabo.cod_actcen%TYPE;

  LVNumSerie      ga_abocel.num_serie%TYPE;
  LVCodTecnologia ga_abocel.cod_tecnologia%TYPE;
  LVTipTerminal   ga_abocel.tip_terminal%TYPE;
  LNCodCentral    ga_abocel.cod_central%TYPE;
  LNNumCelular    ga_abocel.num_celular%TYPE;
  LNNumImei               ga_abocel.num_imei%TYPE;

  LVTecnolGSM     ged_parametros.val_parametro%TYPE;

  LVImsi                  icc_movimiento.imsi%TYPE;
  LNNumMov                icc_movimiento.num_movimiento%TYPE;
  LVNumMin                icc_movimiento.num_min%TYPE;
  LVIcc                   icc_movimiento.icc%TYPE;

  LVSql           GE_ERRORES_PG.vQuery;

   LN_CARGA    ICC_MOVIMIENTO.CARGA%TYPE; -- INC. COL 64502|10-04-2008|SAQL

BEGIN

   SV_SQLCODE           :='0';
   SV_SQLERRM           :='0';
   SV_ERROR             :='4';

   LN_CARGA := NULL; -- INC. COL 64502|10-04-2008|SAQL

   SV_mens_retorno  :='OK';
   SN_num_evento        :=0;

   LVSql                        :='';

   SV_TABLA:='GA_ABOCEL';
   SV_ACT  :='S';
   SV_mens_retorno:= 'Error-Busca datos del abonado';

   LVSql:=' SELECT num_serie,cod_tecnologia,tip_terminal,cod_central,num_celular,num_imei';
   LVSql:=LVSql || ' FROM   ga_abocel';
   LVSql:=LVSql || ' WHERE  num_Abonado='||ENNumAbonado;

   SELECT num_serie,cod_tecnologia,tip_terminal,cod_central,num_celular,num_imei
   INTO   LVNumSerie,LVCodTecnologia,LVTipTerminal,LNCodCentral,LNNumCelular,LNNumImei
   FROM   ga_abocel
   WHERE  num_Abonado=ENNumAbonado;

   SV_TABLA:='GE_FN_DEVVALPARAM1';
   SV_ACT  :='F';
   SV_mens_retorno:= 'Error- Al buscar parametro COD_OS_CPP';

   LVSql:='GE_FN_DEVVALPARAM(GA,1,COD_OS_CPP)';

   LVOSCambPlanHib := ge_fn_devvalparam('GA',1,'COD_OS_CPP');

   SV_TABLA:='GE_FN_DEVVALPARAM2';
   SV_ACT  :='F';
   SV_mens_retorno:= 'Error-Al buscar parametro TIP_PLAN_HIBRIDO';

   LVSql:=' ge_fn_devvalparam(GA,1,TIP_PLAN_HIBRIDO)';

   LVTiPlan := ge_fn_devvalparam('GA',1,'TIP_PLAN_HIBRIDO');

   SV_TABLA:='CI_TIPORSERV';
   SV_ACT  :='S';
   SV_mens_retorno:= 'Error-Al buscar tipo de modificacion e CI_TIPORSERV';

   LVSql:='SELECT cod_tipmodi FROM      ci_tiporserv WHERE  cod_os='||LVOSCambPlanHib;

   SELECT cod_tipmodi
   INTO   LVCodTipModi
   FROM   ci_tiporserv
   WHERE  cod_os=LVOSCambPlanHib;

   SV_TABLA:='PV_ACTABO_TIPLAN';
   SV_ACT  :='S';
   SV_mens_retorno:= 'Error-Al buscar tipo actuacion en PV_ACTABO_TIPLAN';

   LVSql:='SELECT cod_actabo FROM pv_actabo_tiplan WHERE cod_tipmodi='||LVCodTipModi||' AND cod_tiplan='||LVTiPlan||' AND cod_os='||LVOSCambPlanHib;

   SELECT cod_actabo
   INTO   LVCodActabo
   FROM   pv_actabo_tiplan
   WHERE  cod_tipmodi = LVCodTipModi
   AND    cod_tiplan  = LVTiPlan
   AND    cod_os=LVOSCambPlanHib;

   SV_TABLA:='GA_ACTABO';
   SV_ACT  :='S';
   SV_mens_retorno:= 'Error-Al buscar tipo actuacion en GA_ACTABO';

   LVSql:='SELECT cod_actcen FROM ga_actabo WHERE cod_actabo='||LVCodActabo||' AND cod_tecnologia='||LVCodTecnologia||' AND cod_modulo=GA';

   SELECT cod_actcen
   INTO   LVCodActcen
   FROM   ga_actabo
   WHERE  cod_actabo=LVCodActabo
   AND    cod_tecnologia=LVCodTecnologia
   AND    cod_modulo='GA'
   and cod_producto = 1; --- RRG 45898 23-11-2007 COL

   SV_TABLA:='GE_FN_DEVVALPARAM3';
   SV_ACT  :='F';
   SV_mens_retorno:= 'Error-Al buscar parametro TECNOLOGIA_GSM';

   LVSql:='ge_fn_devvalparam(GA,1,TECNOLOGIA_GSM)';

   LVTecnolGSM := ge_fn_devvalparam('GA',1,'TECNOLOGIA_GSM');

   IF LVCodTecnologia=LVTecnolGSM THEN
          LVImsi:=fn_recupera_imsi(LVNumSerie);
          LVIcc:=LVNumSerie;
   ELSE
          LVImsi:=NULL;
          LVIcc:=NULL;
   END IF;

   SV_TABLA:='AL_FN_PREFIJO_NUMERO';
   SV_ACT  :='F';
   SV_mens_retorno:= 'Error-Al buscar prefijo AL_FN_PREFIJO_NUMERO';

   LVSql:='SELECT al_fn_prefijo_numero('||LNNumCelular||') FROM DUAL';

   SELECT al_fn_prefijo_numero(LNNumCelular) INTO LVNumMin FROM DUAL;

   SV_TABLA:='ICC_SEQ_NUMMOV';
   SV_ACT  :='Q';
   SV_mens_retorno:= 'Error-Al seleccionar secuencia ICC_SEQ_NUMMOV';

   LVSql:='SELECT icc_seq_nummov.nextval FROM DUAL';

   SELECT icc_seq_nummov.nextval INTO LNNumMov FROM DUAL;

   -- INI COL|64502|10-04-2008|SAQL
   BEGIN
      SELECT B.IMP_CARGOBASICO INTO LN_CARGA
      FROM TA_PLANTARIF A, TA_CARGOSBASICO B
      WHERE A.COD_PRODUCTO = 1
      AND A.COD_PLANTARIF = EVPlanNue
      AND A.COD_CARGOBASICO = B.COD_CARGOBASICO
      AND A.COD_PRODUCTO = B.COD_PRODUCTO
      AND SYSDATE BETWEEN B.FEC_DESDE AND B.FEC_HASTA;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         LN_CARGA := 0;
      WHEN OTHERS THEN
         LN_CARGA := NULL;
   END;
   -- FIN COL|64502|10-04-2008|SAQL

   SV_TABLA:='ICC_MOVIMIENTO';
   SV_ACT  :='I';
   SV_mens_retorno:= 'Error-Al inscribir el comando';

   LVSql:='INSERT INTO icc_movimiento';
   LVSql:=LVSql || '(num_movimiento,num_abonado,cod_estado,cod_actabo,cod_modulo,cod_actuacion,nom_usuarora,fec_ingreso';
   LVSql:=LVSql || ',CARGA'; -- INC. COL 64502|10-04-2008|SAQL
   LVSql:=LVSql || ',tip_terminal,cod_central,ind_bloqueo,num_celular,num_serie,num_min,plan,tip_tecnologia,imsi,imei,icc)';
   LVSql:=LVSql || 'VALUES';
   LVSql:=LVSql || '('||LNNumMov||','||ENNumAbonado||',1,'||LVCodActabo||',GA,'||LVCodActcen||',USER,SYSDATE';
   LVSql:=LVSql || ','||LN_CARGA; -- INC. COL 64502|10-04-2008|SAQL
   LVSql:=LVSql || ','||LVTipTerminal||','||LNCodCentral||',0,'||LNNumCelular||','||LVNumSerie||','||LVNumMin||','||EVPlanNue||','||LVCodTecnologia;
   LVSql:=LVSql || ','||LVImsi||','||LNNumImei||','||LVIcc||')';

   INSERT INTO icc_movimiento
   ( num_movimiento, num_abonado, cod_estado, cod_actabo, cod_modulo, cod_actuacion, nom_usuarora, fec_ingreso
   ,carga -- INC. COL 64502|10-04-2008|SAQL
   ,tip_terminal, cod_central, ind_bloqueo, num_celular, num_serie, num_min, plan, tip_tecnologia, imsi, imei,icc)
   VALUES
   (LNNumMov,ENNumAbonado,1,LVCodActabo,'GA',LVCodActcen,USER,SYSDATE
   ,LN_CARGA -- INC. COL 64502|10-04-2008|SAQL
   ,LVTipTerminal,LNCodCentral,0,LNNumCelular,LVNumSerie,LVNumMin,EVPlanNue,LVCodTecnologia
   ,LVImsi,LNNumImei,LVIcc);

   SV_SQLCODE           :='0';
   SV_SQLERRM           :='0';
   SV_ERROR             :='3';
   SV_mens_retorno  := 'OK';
   SN_num_evento        := 0;

EXCEPTION
      WHEN OTHERS  THEN
               SV_SQLCODE := SQLCODE;
           SV_SQLERRM := SQLERRM;
           SV_ERROR := '4';

                   SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,'PV_CAMBIOPLAN_BATCH_PG.PV_ICC_CAMBIOPLAN_HIB_PR', LVSql, SV_SQLCODE, SV_SQLERRM);

END PV_ICC_CAMBIOPLAN_HIB_PR;
--FIN COL-37481|15-02-2007|GEZ

END PV_CAMBIOPLAN_BATCH_PG;
/
SHOW ERRORS
