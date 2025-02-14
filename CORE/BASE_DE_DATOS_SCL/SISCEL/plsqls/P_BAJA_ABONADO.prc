CREATE OR REPLACE PROCEDURE SISCEL.P_Baja_Abonado
(                                VP_PRODUCTO IN                 NUMBER,
                 VP_CLIENTE  IN                 NUMBER,
                 VP_ABONADO  IN                 NUMBER,
                 VP_CICLO        IN             NUMBER,
                 VP_FECSYS       IN             DATE,
                 VP_PROC         IN OUT         VARCHAR2,
                 VP_TABLA        IN OUT         VARCHAR2,
                 VP_ACT          IN OUT         VARCHAR2,
                 VP_SQLCODE  IN OUT     VARCHAR2,
                 VP_SQLERRM  IN OUT     VARCHAR2,
                 VP_ERROR        IN OUT         VARCHAR2)
IS
--
-- Procedimiento que refleja la baja de abonados marcando fecha fin vigencia
-- en las tablas de interfase con tarificacion y facturacion
-- Ademas permite dar de baja servicios suplementarios en Base de Dato
--            Los posibles retornos del procedimiento son :
--                - '0' Actualizaciones realizadas correctamente
--                - '4' Error en el proceso
--

--P_BAJA_ABONADO v1.0 //ahott 19-04-2004 TM-200404150626
--P_BAJA_ABONADO v1.1 //COL-72424|03-11-2008|GEZ
--P_BAJA_ABONADO v1.2 //COL-72424|27-11-2008|GEZ
--P_BAJA_ABONADO v1.3   COL-72424|19-12-2008|SAQL
--P_BAJA_ABONADO v1.4   COL 76338|19-01-2009|SAQL

   CURSOR C1 IS
   SELECT ROWID
   FROM GA_SERVSUPLABO
   WHERE NUM_ABONADO = VP_ABONADO
   AND IND_ESTADO < 3;

   V_ROWID                                       ROWID;
   V_CICLFACT                            GA_INFACCEL.COD_CICLFACT%TYPE;
   V_ESTADO_BAJACEN              NUMBER;
   V_IND_ACTUAC                          NUMBER;
   IND_VALOR                             NUMBER;
   V_VIGENTE_INTAR                       NUMBER;
   V_FLAG_ERROR                          VARCHAR2(1);
   ERROR_PROCESO                         EXCEPTION;
   --Inicio ahott 19-04-2004 TM-200404150626
   V_FECHADCF                    GA_INTARCEL.FEC_DESDE%TYPE;
   V_FECHADLL                            GA_INTARCEL.FEC_DESDE%TYPE;
   V_FECHAD                              GA_INTARCEL.FEC_DESDE%TYPE;
   V_FECHA                                       GA_INTARCEL.FEC_DESDE%TYPE;
   V_INDCAR                              NUMBER(1) := 0;
   V_INDLLA                              NUMBER(1) := 0;
   VAR1                                          GA_ABOCEL.NUM_ABONADO %TYPE;
   V_NUMERO                              GA_INTARCEL.IND_NUMERO%TYPE;
   vErrorAplic                           VARCHAR2(100);
   vErrorGlosa                           VARCHAR2(100);
   vErrorOra                             VARCHAR2(100);
   vErrorOraGlosa                        VARCHAR2(100);
   vTrace                                        VARCHAR2(100);
   LN_NUM_OS                     PV_IORSERV.NUM_OS%TYPE;
   LV_fECHA_aux                  GA_INTARCEL.FEC_DESDE%TYPE;
   LV_fECHA                      GA_INTARCEL.FEC_DESDE%TYPE;
   ld_fec_desdellam_ant          GA_INTARCEL.FEC_DESDE%TYPE;
   lv_cod_ciclfact_aux           FA_CICLFACT.COD_CICLFACT%TYPE;
   VP_FECSYS_aux                 GA_INTARCEL.FEC_DESDE%TYPE;
   V_FECHAD_HASTA                GA_INTARCEL.FEC_DESDE%TYPE;

   --Fin ahott 19-04-2004 TM-200404150626

   --INI COL-72424|03-11-2008|GEZ
   LNEsOOSSProg                         NUMBER; --0: no es programada, 1: es programada
   LVCodOSBajaAbo                       ged_parametros.val_parametro%TYPE;
   LVCodOSBajaOpta                      ged_parametros.val_parametro%TYPE;
   LVCodOSSolicBaja                     ged_parametros.val_parametro%TYPE;

   LVFecCorteBajaAbo            ged_parametros.val_parametro%TYPE;
   LVFecCorteBajaOpta           ged_parametros.val_parametro%TYPE;
   LVFecCorteSolicBaja          ged_parametros.val_parametro%TYPE;

   LVMaxIntentosOOSS            ged_parametros.val_parametro%TYPE;

   LVCodOsBaja                          pv_iorserv.cod_os%TYPE;
   LDFecBaja                            DATE;
   LVCodPlan                            ga_abocel.cod_plantarif%TYPE;

   LD_FecProg                           pv_iorserv.fh_ejecucion%TYPE;

   --FIN COL-72424|03-11-2008|GEZ

BEGIN

   VP_PROC := 'P_BAJA_ABONADO';
   VP_TABLA := 'FA_CICLFACT';
   VP_ACT := 'S';
   IND_VALOR := 2;
   --Indicador de Baja
   V_IND_ACTUAC := 1;
   --Actuacion Alta
   V_ESTADO_BAJACEN:=5;
   --Estado de baja de servicios supl.

   /*

   SELECT COD_CICLFACT
   INTO V_CICLFACT
   FROM FA_CICLFACT
   WHERE COD_CICLO = VP_CICLO
         AND VP_FECSYS BETWEEN FEC_DESDELLAM AND FEC_HASTALLAM;
   */

   VP_FECSYS_aux:=VP_FECSYS;

   VP_PROC := 'paso 1';
   VP_TABLA := 'FA_CICLFACT';

   --SELECT COD_CICLFACT  , FEC_DESDELLAM-1/86400,FEC_DESDELLAM -- SE OBTIENE FECHA VIGENTE Y SE LE RESTA 1 DIAS        --COL-72424|03-11-2008|GEZ
   --INTO V_CICLFACT, LV_fECHA,LV_fECHA_AUX                                                                                                                                                     --COL-72424|03-11-2008|GEZ
   SELECT COD_CICLFACT  , FEC_DESDELLAM-1/86400,FEC_DESDELLAM,fec_hastallam --COL-72424|03-11-2008|GEZ
   INTO V_CICLFACT, LV_fECHA,LV_fECHA_AUX,LDFecBaja
   FROM FA_CICLFACT
   WHERE COD_CICLO = VP_CICLO
   AND VP_FECSYS BETWEEN FEC_DESDELLAM AND FEC_HASTALLAM;

   VP_PROC := 'paso 2';
   VP_TABLA := 'FA_CICLFACT';

   LN_NUM_OS:= 0;

   -- SE VALIDA PARA ESE ABONADO SI TIENE UNA OOSS PROGRAMADA DE BAJA OPTA PREPAGO;

   BEGIN

           --INI COL-72424|03-11-2008|GEZ

           /*SELECT NUM_OS
       INTO   LN_NUM_OS
       FROM   PV_PARAM_ABOCEL
       WHERE  NUM_ABONADO  = VP_ABONADO
       AND        NUM_OS IN ( SELECT NUM_OS
                                                  FROM   PV_IORSERV
                          WHERE  COD_OS  ='10233'
                                                  AND TRUNC(FECHA_ING) <> TRUNC(FH_EJECUCION));
           */

           LVCodOSBajaAbo        := GE_FN_DEVVALPARAM('GA',1,'CODOS_BAJA_ABONADO');
           LVCodOSBajaOpta       := GE_FN_DEVVALPARAM('GA',1,'CODOS_BAJA_OPTAPREPA');
           LVCodOSSolicBaja   := GE_FN_DEVVALPARAM('GA',1,'CODOS_SOLICITUD_BAJA');

           LVMaxIntentosOOSS := GE_FN_DEVVALPARAM('GA',1,'MAX_INTENTOS');

           VP_TABLA := 'IORSERV-CAMCOM';
           VP_ACT := 'S';
           
/* INICIO 189932 BRC
           SELECT a.num_os,a.cod_os,DECODE(a.fh_ejecucion,NULL,0,1),a.fh_ejecucion
           INTO   LN_NUM_OS,LVCodOsBaja,LNEsOOSSProg,LD_FecProg
           FROM   pv_iorserv a,pv_camcom b
           WHERE  b.num_abonado=VP_ABONADO
           AND    a.num_os=b.num_os
           AND    a.cod_os IN (LVCodOSBajaAbo,LVCodOSBajaOpta,LVCodOSSolicBaja)
           AND    a.cod_estado=210
           --AND          a.num_intentos<TO_NUMBER(LVMaxIntentosOOSS);  --COL-72424|27-11-2008|GEZ
           AND    NVL(a.num_intentos,0)<TO_NUMBER(LVMaxIntentosOOSS);
  */
                     --COL-72424|27-11-2008|GEZ

           -- IF LNEsOOSSProg = 0 THEN -- COL 72424|19-12-2008|SAQL
           SELECT num_os,cod_os,DECODE(fh_ejecucion,NULL,0,1), fh_ejecucion 
           INTO   LN_NUM_OS,LVCodOsBaja,LNEsOOSSProg,LD_FecProg
            from pv_iorserv
            where num_os in ( select max(a.num_os)
              FROM   pv_iorserv a,pv_camcom b
           WHERE  b.num_abonado=VP_ABONADO
           AND    a.num_os=b.num_os
           AND    a.cod_os IN (LVCodOSBajaAbo,LVCodOSBajaOpta,LVCodOSSolicBaja)
           AND    a.cod_estado=210
           AND    NVL(a.num_intentos,0)<TO_NUMBER(LVMaxIntentosOOSS));
           
           /*FIN 189932 BRC*/
           
		   IF LNEsOOSSProg = 0 OR TRUNC(LD_FecProg) = TRUNC(SYSDATE) THEN
                  LDFecBaja:=SYSDATE;
           ELSE

                   --INI COL-72424|27-11-2008|GEZ
                   SELECT fec_hastallam
                   INTO     LDFecBaja
                   FROM   FA_CICLFACT
                   WHERE COD_CICLO = VP_CICLO
                   AND      NVL(LD_FecProg,SYSDATE) BETWEEN FEC_DESDELLAM AND FEC_HASTALLAM;
                   --FIN COL-72424|27-11-2008|GEZ

                   IF LVCodOsBaja = LVCodOSBajaAbo THEN
                           LVFecCorteBajaAbo     := GE_FN_DEVVALPARAM('GA',1,'FEC_CORTE_BAJA_ABO');

                           IF LVFecCorteBajaAbo='FALSE' THEN
                                  LDFecBaja:=SYSDATE;
                           END IF;
                   ELSIF  LVCodOsBaja = LVCodOSBajaOpta THEN
                           LVFecCorteBajaOpta    := GE_FN_DEVVALPARAM('GA',1,'FEC_CORTE_BAJA_OPTA');

                           IF LVFecCorteBajaOpta='FALSE' THEN
                                  LDFecBaja:=SYSDATE;
                           END IF;
                   ELSIF  LVCodOsBaja = LVCodOSSolicBaja THEN
                           LVFecCorteSolicBaja   := GE_FN_DEVVALPARAM('GA',1,'FEC_CORTE_SOLIC_BAJA');

                           IF LVFecCorteBajaAbo='FALSE' THEN
                                  LDFecBaja:=SYSDATE;
                           END IF;
                   END IF;

           END IF;
           --FIN COL-72424|03-11-2008|GEZ
   EXCEPTION
        WHEN NO_DATA_FOUND THEN
             LN_NUM_OS:= 0;
   END;

   --SI ENCUENTRA SE DEBE  RESETEAR LA FECHA Y ADEMAS CIERRA PERIODO ANTERIOR AL VIGENTE

   IF LN_NUM_OS > 0 THEN  -- SOLO ORIENTADO PARA LAS PROGRAMADAS  A CICLO

       --INI COL-72424|03-11-2008|GEZ
           /*
           VP_FECSYS_aux:=LV_fECHA;
       --VP_FECSYS:=LV_fECHA;

       SELECT MAX(fec_desdellam)
       INTO ld_fec_desdellam_ant
       FROM FA_CICLFACT
       WHERE COD_CICLO         =   VP_CICLO
       AND cod_ciclfact        <> V_CICLFACT
       AND TRUNC(fec_desdellam)<TRUNC(LV_fECHA_aux);

       SELECT cod_ciclfact
       INTO lv_cod_ciclfact_aux
       FROM FA_CICLFACT
       WHERE COD_CICLO         =   VP_CICLO
       AND TRUNC(fec_desdellam)=   TRUNC(ld_fec_desdellam_ant);

       UPDATE GA_INFACCEL
       SET IND_ACTUAC    = IND_VALOR,
           FEC_BAJA      = LV_fECHA
       WHERE COD_CLIENTE = VP_CLIENTE
       AND NUM_ABONADO   = VP_ABONADO
       AND IND_ACTUAC    = V_IND_ACTUAC
       AND COD_CICLFACT  = lv_cod_ciclfact_aux;
           */

           VP_TABLA := 'GA_INFACCELA';
           VP_ACT := 'U';

           UPDATE ga_infaccel
       SET        ind_actuac   = IND_VALOR,
                  fec_baja     = LDFecBaja
       WHERE  cod_cliente  = VP_CLIENTE
       AND        num_abonado  = VP_ABONADO
       AND        ind_actuac   = V_IND_ACTUAC
       AND        cod_ciclfact = V_CICLFACT;

           --FIN COL-72424|03-11-2008|GEZ

   END IF;

   IF VP_PRODUCTO = 1 THEN

      VP_TABLA := 'GA_INTARCEL';
      VP_ACT := 'S';

      SELECT COUNT(*)
      INTO       V_VIGENTE_INTAR
      FROM       GA_INTARCEL
      WHERE  COD_CLIENTE = VP_CLIENTE
      AND        NUM_ABONADO = VP_ABONADO
      AND        VP_FECSYS BETWEEN FEC_DESDE AND FEC_HASTA;

      IF V_VIGENTE_INTAR <= 0 THEN
        V_FLAG_ERROR:='T';
        RAISE ERROR_PROCESO;
      END IF;

      VP_TABLA := 'GA_INTARCEL';
      VP_ACT := 'U';

          --COL-72424|03-11-2008|GEZ
          IF LN_NUM_OS > 0 THEN
                 UPDATE GA_INTARCEL
             SET        FEC_HASTA   = LDFecBaja
             WHERE  COD_CLIENTE = VP_CLIENTE
             AND        NUM_ABONADO = VP_ABONADO
             AND        VP_FECSYS BETWEEN FEC_DESDE AND FEC_HASTA;
          ELSE
          --FIN COL-72424|03-11-2008|GEZ

                  UPDATE GA_INTARCEL
              SET        FEC_HASTA   = VP_FECSYS_aux
              WHERE  COD_CLIENTE = VP_CLIENTE
              AND        NUM_ABONADO = VP_ABONADO
              AND        VP_FECSYS BETWEEN FEC_DESDE AND FEC_HASTA;

          --INI COL-72424|03-11-2008|GEZ
          END IF;

         -- INI COL|76338|19-01-2009|SAQL
         /*
          VP_TABLA := 'GAH_INTARCEL';
          VP_ACT := 'I';

          INSERT INTO gah_intarcel(
          COD_CLIENTE, NUM_ABONADO, IND_NUMERO, FEC_DESDE, FEC_HASTA, IMP_LIMCONSUMO, IND_FRIENDS, IND_DIASESP
          , COD_CELDA, TIP_PLANTARIF, COD_PLANTARIF, NUM_SERIE, NUM_CELULAR, COD_CARGOBASICO, COD_CICLO
          , COD_PLANCOM, COD_PLANSERV, COD_GRPSERV, COD_GRUPO, COD_PORTADOR, COD_USO, FEC_HISTORICO, NUM_IMSI, NUM_MIN_MDN)
          SELECT COD_CLIENTE, NUM_ABONADO, IND_NUMERO, FEC_DESDE, FEC_HASTA, IMP_LIMCONSUMO, IND_FRIENDS, IND_DIASESP
          , COD_CELDA, TIP_PLANTARIF, COD_PLANTARIF, NUM_SERIE, NUM_CELULAR, COD_CARGOBASICO, COD_CICLO
          , COD_PLANCOM, COD_PLANSERV, COD_GRPSERV, COD_GRUPO, COD_PORTADOR, COD_USO, SYSDATE, NUM_IMSI, NUM_MIN_MDN
          FROM ga_intarcel
          WHERE cod_cliente = VP_CLIENTE
      AND num_abonado = VP_ABONADO
      AND fec_desde > VP_FECSYS;
         */
         -- FIN COL|76338|19-01-2009|SAQL
          --FIN COL-72424|03-11-2008|GEZ

      VP_TABLA := 'GA_INTARCEL';
      VP_ACT := 'D';

          DELETE GA_INTARCEL
      WHERE COD_CLIENTE = VP_CLIENTE
      AND NUM_ABONADO = VP_ABONADO
      AND FEC_DESDE > VP_FECSYS;

          --INI COL-72424|03-11-2008|GEZ
          VP_TABLA := 'TOL_CLIENTE_TD';
      VP_ACT := 'D';

          DELETE tol_cliente_td
      WHERE cod_cliente = VP_CLIENTE
      AND       cod_abonado = VP_ABONADO
      AND       fec_ini_vig > VP_FECSYS;

          IF LN_NUM_OS > 0 THEN

                  VP_TABLA := 'GA_ABOCEL';
          VP_ACT   := 'U';

                  UPDATE ga_abocel
                  SET fec_baja=LDFecBaja
          WHERE num_abonado=VP_ABONADO;
          ELSE
          --FIN COL-72424|03-11-2008|GEZ

              VP_TABLA := 'GA_INFACCEL';
              VP_ACT := 'S';

              SELECT COUNT(*)
              INTO V_VIGENTE_INTAR
              FROM GA_INFACCEL
              WHERE COD_CLIENTE = VP_CLIENTE
              AND NUM_ABONADO = VP_ABONADO
              AND IND_ACTUAC = V_IND_ACTUAC
              AND COD_CICLFACT = V_CICLFACT;

              IF V_VIGENTE_INTAR <= 0 THEN
                V_FLAG_ERROR:='F';
                RAISE ERROR_PROCESO;
              END IF;

              VP_TABLA := 'GA_INFACCEL';
              VP_ACT := 'U';

              UPDATE GA_INFACCEL
              SET IND_ACTUAC = IND_VALOR,
              FEC_BAJA =VP_FECSYS_aux
              WHERE COD_CLIENTE = VP_CLIENTE
              AND NUM_ABONADO = VP_ABONADO
              AND IND_ACTUAC = V_IND_ACTUAC
              AND COD_CICLFACT = V_CICLFACT;

                  VP_TABLA := 'GA_ABOCELB'; --COL-72424|03-11-2008|GEZ
          VP_ACT   := 'U';                 --COL-72424|03-11-2008|GEZ

                  UPDATE GA_ABOCEL SET FEC_BAJA=VP_FECSYS_aux
          WHERE NUM_ABONADO=VP_ABONADO;

          END IF; --COL-72424|03-11-2008|GEZ

          -- Inicio ahott 19-04-2004 TM-200404150626

          VP_TABLA := 'FA_CICLFACTC'; --COL-72424|03-11-2008|GEZ
      VP_ACT   := 'S';             --COL-72424|03-11-2008|GEZ

      SELECT MIN(FEC_DESDELLAM)
      INTO V_FECHADLL
      FROM FA_CICLFACT
      WHERE COD_CICLO = VP_CICLO
      AND TRUNC(VP_FECSYS) <= TRUNC(FEC_DESDELLAM)
      AND IND_FACTURACION = 0;

          VP_TABLA := 'FA_CICLFACTD'; --COL-72424|03-11-2008|GEZ
      VP_ACT   := 'S';                --COL-72424|03-11-2008|GEZ

      SELECT SYSDATE,COD_CICLFACT
      INTO V_FECHADCF,V_CICLFACT
      FROM FA_CICLFACT
      WHERE COD_CICLO = VP_CICLO
      AND TRUNC(VP_FECSYS) <= TRUNC(FEC_DESDELLAM)
      AND IND_FACTURACION = 0
      AND FEC_DESDELLAM=V_FECHADLL;

          BEGIN

                 VP_TABLA := 'GA_INTARCELF'; --COL-72424|03-11-2008|GEZ
         VP_ACT   := 'S';                     --COL-72424|03-11-2008|GEZ

         SELECT NUM_ABONADO
         INTO VAR1
         FROM GA_INTARCEL
         WHERE COD_CLIENTE = VP_CLIENTE
         AND NUM_ABONADO = VP_ABONADO
         AND FEC_DESDE   = V_FECHADCF;
         V_INDCAR := 1;
      EXCEPTION
          WHEN NO_DATA_FOUND THEN
               V_INDCAR := 0;
          WHEN TOO_MANY_ROWS THEN
               V_INDCAR := 0;
          WHEN OTHERS THEN
               VP_ERROR := '4';
      END;

      BEGIN

                 VP_TABLA := 'GA_INTARCELG'; --COL-72424|03-11-2008|GEZ
         VP_ACT   := 'S';                     --COL-72424|03-11-2008|GEZ

         SELECT NUM_ABONADO
         INTO   VAR1
         FROM   GA_INTARCEL
         WHERE  COD_CLIENTE = VP_CLIENTE
         AND    NUM_ABONADO = VP_ABONADO
         AND    FEC_DESDE   = V_FECHADLL;

         V_INDLLA := 1;
      EXCEPTION
         WHEN NO_DATA_FOUND THEN
               V_INDLLA := 0;
         WHEN TOO_MANY_ROWS THEN
               V_INDLLA := 1;
         WHEN OTHERS THEN
                   VP_ERROR := '4';
      END;

      IF V_INDCAR = 0 AND V_INDLLA = 0 THEN
              BEGIN
                   VP_TABLA := 'GA_INTARCEL';
                   VP_ACT := 'S';

                   IF LN_NUM_OS = 0 THEN
                       SELECT FEC_DESDE
                       INTO V_FECHAD
                       FROM GA_INTARCEL
                       WHERE COD_CLIENTE = VP_CLIENTE
                       AND NUM_ABONADO = VP_ABONADO
                       AND VP_FECSYS BETWEEN FEC_DESDE
                       AND NVL(FEC_HASTA,VP_FECSYS)
                       AND ROWNUM = 1;
                       V_FECHA := V_FECHAD;
                   ELSE
                       SELECT MAX(FEC_HASTA)
                       INTO V_FECHAD_HASTA
                       FROM GA_INTARCEL
                       WHERE COD_CLIENTE = VP_CLIENTE
                       AND NUM_ABONADO   = VP_ABONADO
                       AND ROWNUM = 1;

                       SELECT MAX(FEC_DESDE)
                       INTO V_FECHAD
                       FROM GA_INTARCEL
                       WHERE COD_CLIENTE = VP_CLIENTE
                       AND NUM_ABONADO   = VP_ABONADO
                       AND FEC_HASTA     = V_FECHAD_HASTA
                       AND ROWNUM = 1;

                       V_FECHA := V_FECHAD;
                   END IF;

              EXCEPTION
                   WHEN OTHERS THEN
                        VP_ERROR := '4';
              END;
      ELSIF V_INDLLA <> 0 THEN
          IF V_FECHADCF >= V_FECHADLL THEN
             V_FECHA := V_FECHADLL;
          ELSE
             V_FECHA := V_FECHAD;
          END IF;
      END IF;

          SELECT IND_NUMERO INTO V_NUMERO
      FROM GA_INTARCEL
      WHERE COD_CLIENTE = VP_CLIENTE
      AND NUM_ABONADO = VP_ABONADO
      AND FEC_DESDE = V_FECHA;

          IF LN_NUM_OS = 0 THEN
            Pv_Actualiza_Camb_Comerc_Pr(VP_CLIENTE,VP_ABONADO,V_NUMERO,'BA',VP_FECSYS,
                                  vErrorAplic,vErrorGlosa,vErrorOra,vErrorOraGlosa,vTrace);

      ELSE
            --PV_ACTUALIZA_CAMB_COMERC_PR(VP_CLIENTE,VP_ABONADO,V_NUMERO,'BA',VP_FECSYS_aux,  --COL-72424|03-11-2008|GEZ
                        Pv_Actualiza_Camb_Comerc_Pr(VP_CLIENTE,VP_ABONADO,V_NUMERO,'BA',LDFecBaja,                --COL-72424|03-11-2008|GEZ
                                  vErrorAplic,vErrorGlosa,vErrorOra,vErrorOraGlosa,vTrace);

      END IF;
      -- Fin ahott 19-04-2004 TM-200404150626


   ELSIF VP_PRODUCTO = 2 THEN
         VP_TABLA := 'GA_INTARBEEP';
         VP_ACT := 'U';
         UPDATE GA_INTARBEEP
         SET FEC_HASTA = VP_FECSYS_aux
         WHERE COD_CLIENTE = VP_CLIENTE
               AND NUM_ABONADO = VP_ABONADO
               AND VP_FECSYS BETWEEN FEC_DESDE AND FEC_HASTA;
         VP_TABLA := 'GA_INTARBEEP';
         VP_ACT := 'D';
         DELETE GA_INTARBEEP
         WHERE COD_CLIENTE = VP_CLIENTE
               AND NUM_ABONADO = VP_ABONADO
               AND FEC_DESDE > VP_FECSYS;
         UPDATE GA_INFACBEEP
         SET IND_ACTUAC = IND_VALOR,
         FEC_BAJA = VP_FECSYS_aux
         WHERE COD_CLIENTE = VP_CLIENTE
               AND NUM_ABONADO = VP_ABONADO
               AND IND_ACTUAC = V_IND_ACTUAC
               AND COD_CICLFACT = V_CICLFACT;
      UPDATE GA_ABOBEEP SET FEC_BAJA=VP_FECSYS
      WHERE NUM_ABONADO=VP_ABONADO;
   END IF;

   VP_TABLA := 'GA_FINCICLO';
   VP_ACT := 'D';

   DELETE GA_FINCICLO
   WHERE COD_CLIENTE = VP_CLIENTE
   AND NUM_ABONADO = VP_ABONADO
   AND COD_PRODUCTO = VP_PRODUCTO;

   VP_PROC := 'P_BAJA_ABONADO';
   VP_TABLA := 'C1';
   VP_ACT := 'O';

   OPEN C1;

   IF LN_NUM_OS > 0 THEN

       LOOP
          VP_TABLA := 'GA_SERVSUPLABO';
          VP_ACT := 'U';

                  FETCH C1 INTO V_ROWID;
          EXIT WHEN C1%NOTFOUND;

                  UPDATE ga_servsuplabo
          --SET FEC_BAJABD =VP_FECSYS_aux,      --COL-72424|03-11-2008|GEZ
                  SET fec_bajabd =LDFecBaja,            --COL-72424|03-11-2008|GEZ
              ind_estado = V_ESTADO_BAJACEN
          WHERE ROWID = V_ROWID;

       END LOOP;

   ELSE
       LOOP
          VP_TABLA := 'GA_SERVSUPLABO';
          VP_ACT := 'U';

                  FETCH C1 INTO V_ROWID;
          EXIT WHEN C1%NOTFOUND;

                  UPDATE GA_SERVSUPLABO
          SET FEC_BAJABD =SYSDATE,
              IND_ESTADO = V_ESTADO_BAJACEN
          WHERE ROWID = V_ROWID;
       END LOOP;

   END IF;

   CLOSE C1;

   --INI COL-72424|03-11-2008|GEZ
   VP_TABLA := 'GA_ABOCEL';
   VP_ACT   := 'S';

   SELECT cod_plantarif
   INTO   LVCodPlan
   FROM   ga_abocel
   WHERE num_abonado=VP_ABONADO;

   VP_TABLA := 'GA_LIMITE_CLIABO_TO';
   VP_ACT   := 'U';

   UPDATE ga_limite_cliabo_to
   SET    fec_hasta     = LDFecBaja
   WHERE  num_abonado   = VP_ABONADO
   AND    cod_cliente   = VP_CLIENTE
   AND    SYSDATE BETWEEN fec_desde AND NVL(fec_hasta,SYSDATE)
   AND    cod_plantarif = LVCodPlan;

   VP_TABLA := 'GA_LIMITE_CLIABO_TH';
   VP_ACT := 'I';

   INSERT INTO ga_limite_cliabo_th
   (cod_cliente, num_abonado, cod_limcons, cod_plantarif, fec_desde, fec_historico
   , fec_hasta, nom_usuarora, fec_asignacion, cod_causa_hist, est_aplica_tol, fec_aplica_tol)
   SELECT cod_cliente, num_abonado, cod_limcons, cod_plantarif, fec_desde, SYSDATE
   , fec_hasta, nom_usuarora, fec_asignacion,'BA', est_aplica_tol, fec_aplica_tol
   FROM ga_limite_cliabo_to
   WHERE  cod_cliente   = VP_CLIENTE
   AND    num_abonado   = VP_ABONADO
   AND    fec_desde     > SYSDATE
   AND    cod_plantarif = LVCodPlan;

   VP_TABLA := 'GA_LIMITE_CLIABO_TO';
   VP_ACT := 'D';

   DELETE ga_limite_cliabo_to
   WHERE  cod_cliente   = VP_CLIENTE
   AND    num_abonado   = VP_ABONADO
   AND    fec_desde     > SYSDATE
   AND    cod_plantarif = LVCodPlan;

   VP_SQLCODE := '0';
   VP_SQLERRM := '0';
   VP_ERROR   := '0';

   --FIN COL-72424|03-11-2008|GEZ

EXCEPTION
   WHEN ERROR_PROCESO THEN

        VP_SQLCODE := SQLCODE;
        VP_ERROR := '4';

        IF V_FLAG_ERROR ='T' THEN
            VP_SQLERRM := 'NO EXISTE PERIODO VIGENTE DE TARIFICACION';
        ELSE
            VP_SQLERRM := 'NO EXISTE PERIODO VIGENTE DE FACTURACION';
        END IF;

   WHEN OTHERS THEN
        VP_SQLCODE := SQLCODE;
        VP_SQLERRM := SQLERRM;
        VP_ERROR := '4';

END;
/
SHOW ERRORS
