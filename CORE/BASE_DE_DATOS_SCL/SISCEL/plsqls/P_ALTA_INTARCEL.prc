CREATE OR REPLACE PROCEDURE        P_Alta_Intarcel
(VP_ABONADO IN NUMBER,
 VP_INDACREC IN VARCHAR2,
 VP_CLIENTE IN NUMBER,
 VP_PLEXSYS IN NUMBER,
 VP_IMPLIMCONS IN NUMBER,
 VP_CELDA IN VARCHAR2,
 VP_TIPPLANTARIF IN VARCHAR2,
 VP_PLANTARIF IN VARCHAR2,
 VP_SERIE IN VARCHAR2,
 VP_CELULAR IN NUMBER,
 VP_CELULAR_PLEX IN NUMBER,
 VP_CARGOBASICO IN VARCHAR2,
 VP_CICLO IN NUMBER,
 VP_PLANSERV IN VARCHAR2,
 VP_GRPSERV IN VARCHAR2,
 VP_EMPRESA IN NUMBER,
 VP_HOLDING IN NUMBER,
 VP_PORTADOR IN NUMBER,
 VP_PROCALTA IN NUMBER,
 VP_AGENTE IN NUMBER,
 VP_FECALTA IN DATE,
 VP_FECSYS IN DATE,
 VP_PROC IN OUT VARCHAR2,
 VP_TABLA IN OUT VARCHAR2,
 VP_ACT IN OUT VARCHAR2,
 VP_SQLCODE IN OUT VARCHAR2,
 VP_SQLERRM IN OUT VARCHAR2,
 VP_ERROR IN OUT VARCHAR2,
 VP_VAR7 IN VARCHAR2 := NULL,
 VP_ACTABO IN VARCHAR2 := NULL
)
IS
--
-- *************************************************************
-- * procedimiento      : P_Alta_Intarcel
-- * Descripcisn        : Procedimiento que inserta datos en la tabla de interfase
-- *                      Abonados/Tarificacion para el procesamiento de estos.
-- * Fecha de creacisn  :
-- * Responsable        : CRM
--            Los posibles retornos del procedimiento son :
--                - '0' Actualizaciones realizadas correctamente
--                - '4' Error en el proceso
-- *************************************************************
--
--
  V_FRIENDS             GA_INTARCEL.IND_FRIENDS%TYPE;
  V_DIASESP             GA_INTARCEL.IND_DIASESP%TYPE;
  V_FYFCEL              GA_DATOSGENER.COD_FYFCEL%TYPE;
  V_DIASESPCEL          GA_DATOSGENER.COD_DIASESPCEL%TYPE;
  V_CLIENTE_AG          VE_VENDEDORES.COD_CLIENTE%TYPE;
  V_CICLO               GE_CLIENTES.COD_CICLO%TYPE;
  V_PLANCOM             GA_INTARCEL.COD_PLANCOM%TYPE;
  V_TIPCOMIS            GA_VENTAS.COD_TIPCOMIS%TYPE;
  V_PLANTARIF           GA_ABOCEL.COD_PLANTARIF%TYPE;
  V_TIPPLANTARIF        GA_INTARCEL.TIP_PLANTARIF%TYPE;
  V_CARGOBASICO         GA_INTARCEL.COD_CARGOBASICO%TYPE;
  V_CLIENTE             GA_INTARCEL.COD_CLIENTE%TYPE;
  V_GRUPO               GA_INTARCEL.COD_GRUPO%TYPE;
  VP_FECBAJA            GA_INTARCEL.FEC_HASTA%TYPE;
  VP_FECBAJARECHAZO     GA_INTARCEL.FEC_HASTA%TYPE;
  VP_FECALTARECHAZO     GA_INTARCEL.FEC_DESDE%TYPE;
  VAR1                  GA_ABOCEL.NUM_ABONADO%TYPE;
  V_FECRECDOCUM         GA_ABOCEL.FEC_RECDOCUM%TYPE;
  IND_VALOR             NUMBER;
  IND_INTARCEL          NUMBER;
  V_FECAUX              NUMBER;
  V_PLANTARIF_DEALER    GED_PARAMETROS.VAL_PARAMETRO%TYPE;
  V_CARGOBASICO_DEALER  GED_PARAMETROS.VAL_PARAMETRO%TYPE;
  V_PLANTARIF_DIRECTO   GED_PARAMETROS.VAL_PARAMETRO%TYPE;
  V_CARGOBASICO_DIRECTO GED_PARAMETROS.VAL_PARAMETRO%TYPE;
  V_NUMHORAS            GED_PARAMETROS.VAL_PARAMETRO%TYPE;
  V_INDCOBRO            GA_CAUSAREC.IND_COBRO%TYPE;
  V_CLIENTE_INTERNO     GED_PARAMETROS.VAL_PARAMETRO%TYPE;
  V_VTA_EXTERNA         VE_TIPCOMIS.IND_VTA_EXTERNA%TYPE;
  V_ALTA                GA_ABOCEL.FEC_ALTA%TYPE;
  V_BAJA                GA_ABOCEL.FEC_BAJA%TYPE;
  V_USO_DESTINO         GA_ABOCEL.COD_USO%TYPE;

  VP_VAR7_A             GAD_ORIDESUSO.COD_MODULO%TYPE;
  VP_ACTABO_A           GAD_ORIDESUSO.COD_ACTABO%TYPE;
  V_NUM_IMSI            GA_INTARCEL.NUM_IMSI%TYPE;
  V_NUM_SERIE           GA_ABOCEL.NUM_SERIE%TYPE;
  V_TECNOLOGIA 		GA_ABOCEL.COD_TECNOLOGIA%TYPE;
  V_TECNOLOGIA_GSM 	GA_ABOCEL.COD_TECNOLOGIA%TYPE;
  V_PARAMFECHA          VARCHAR2(20);
  V_PARAMHORA          VARCHAR2(20);
  --Inicio incidencia RA-200603130907 se declara variable para guardar valor de fecha rescatado desde
  -- la GA_ABOCEL campo FEC_ACTCEN [PAAA 26-04-2006, soporte]
  V_FEC_ACTCEN VARCHAR2(20);
  --Fin incidencia RA-200603130907

  ERROR_PROCESO EXCEPTION;
  -- Tol sin integracion JPB-01-2003
   vErrorAplic VARCHAR2(100);
   vErrorGlosa VARCHAR2(100);
   vErrorOra VARCHAR2(100);
   vErrorOraGlosa VARCHAR2(100);
   vTrace VARCHAR2(100);
   V_PLANSERV GA_INTARCEL.COD_PLANSERV%TYPE; -- COL|34726|15/03/2007|SAQL

BEGIN
   VP_PROC := 'P_ALTA_INTARCEL';
   VP_TABLA := 'GA_DATOSGENER';
   VP_ACT := 'S';
   V_PLANSERV := VP_PLANSERV; -- COL|34726|15/03/2007|SAQL

   --TMM-04026 Ini
   V_TECNOLOGIA_GSM := GE_FN_DEVVALPARAM('GA',1,'GRUPO_TEC_GSM');
   --TMM-04026 Fin

   --SPZ 24-05-2003
   IF VP_ABONADO <> 0 THEN

	   SELECT NUM_SERIE, COD_TECNOLOGIA
	   INTO  V_NUM_SERIE, V_TECNOLOGIA
	   FROM  GA_ABOCEL
	   WHERE NUM_ABONADO = VP_ABONADO;

	   --TMM-04026 Ini
	   IF GA_APROVISIONAR_CENTRAL_PG.PV_GRUPO_TECNOLOGICO_FN(V_TECNOLOGIA) = V_TECNOLOGIA_GSM THEN
	        SELECT FRECUPERSIMCARD_FN(V_NUM_SERIE, 'IMSI') INTO V_NUM_IMSI FROM DUAL;
	   END IF;
	   --TMM-04026 Fin

   ELSE

       V_NUM_IMSI := '';

   END IF;

   IF VP_ABONADO <> 0 THEN
      BEGIN
         SELECT DECODE(FEC_BAJA,NULL,TO_DATE('31-12-3000','DD-MM-YYYY'),FEC_BAJA) INTO V_BAJA FROM GA_ABOCEL WHERE NUM_ABONADO =        VP_ABONADO;
      EXCEPTION
         WHEN OTHERS THEN
                     V_BAJA := TO_DATE('31-12-3000','DD-MM-YYYY');
      END;
          IF VP_VAR7 IS NULL THEN
                 VP_VAR7_A := 'GA';
          ELSE
             VP_VAR7_A:=VP_VAR7;
          END IF;
          IF VP_ACTABO IS NULL THEN
                 VP_ACTABO_A := 'AV';
          ELSE
             VP_ACTABO_A:=VP_ACTABO;
          END IF;

      P_Ga_Usosmigracion(VP_CELULAR,VP_ABONADO,V_BAJA,V_USO_DESTINO,V_ALTA, VP_VAR7_A, VP_ACTABO_A);

          IF V_ALTA IS NULL THEN
                 V_ALTA := VP_FECSYS;
          END IF;


   ELSE
          /* CAMBIO ABONADO CERO POR ANULA BAJA */
      BEGIN

--         SELECT MIN(fec_alta) INTO V_ALTA
--         FROM   ga_abocel
--         WHERE  cod_cliente = VP_CLIENTE
--         AND    cod_situacion NOT IN ('BAA','BAP');
--         IF v_alta IS NULL THEN
            BEGIN
                   SELECT MIN(fec_desde) INTO V_ALTA
                                   FROM   GA_INTARCEL
                                   WHERE  cod_cliente = VP_CLIENTE AND
                               SYSDATE BETWEEN fec_desde AND fec_hasta;
                                   IF v_alta IS NULL THEN
                                      VP_ERROR := '4';
                                      RAISE ERROR_PROCESO;
                                   END IF;
                           EXCEPTION
                               WHEN OTHERS THEN
                                        VP_ERROR := '4';
                                RAISE ERROR_PROCESO;
                           END;
--        END IF;
          EXCEPTION
           WHEN OTHERS THEN
              RAISE ERROR_PROCESO;
      END;

          SELECT COD_USO INTO V_USO_DESTINO
          FROM GA_ABOCEL
          WHERE cod_cliente = VP_CLIENTE
          AND cod_situacion NOT IN ('BAA','BAP') AND ROWNUM = 1;
   END IF;
   -- INI COL|34726|14/03/2007|SAQL-RRG
   IF VP_ABONADO = 0 AND V_USO_DESTINO <> 4 THEN
      V_USO_DESTINO := 4;
   END IF;
   IF VP_ABONADO = 0 AND VP_PLANSERV <> '02' THEN
      V_PLANSERV := '02';
   END IF;
   -- FIN COL|34726|14/03/2007|SAQL-RRG
   SELECT COD_FYFCEL,COD_DIASESPCEL INTO V_FYFCEL,V_DIASESPCEL
   FROM GA_DATOSGENER;
   VP_TABLA := 'GA_SERVSUPLABO';
   BEGIN
      SELECT IND_FAMILIAR INTO V_FRIENDS
          FROM TA_PLANTARIF
          WHERE COD_PRODUCTO = 1 AND COD_PLANTARIF IN
          (SELECT COD_PLANTARIF FROM GA_ABOCEL WHERE NUM_ABONADO = VP_ABONADO)
          AND ROWNUM = 1;
          IF V_FRIENDS <> 0 THEN
                 V_FRIENDS:= 1;
          END IF;
   EXCEPTION
          WHEN NO_DATA_FOUND THEN
            -- INI COL|34726|14/03/2007|SAQL-RRG
            IF VP_ABONADO = 0 THEN
               /*
               BEGIN
                  SELECT A.IND_FF INTO V_FRIENDS
                  FROM TA_PLANES_FRECUENTES A, TA_PLANTARIF B
                  WHERE A.COD_PRODUCTO = 1
                  AND A.COD_PLANTARIF = VP_PLANTARIF
                  AND SYSDATE BETWEEN A.FEC_DESDE AND NVL(A.FEC_HASTA, SYSDATE)
                  AND A.COD_PRODUCTO=B.COD_PRODUCTO
                  AND A.COD_PLANTARIF=B.COD_PLANTARIF;
               EXCEPTION
                  WHEN NO_DATA_FOUND THEN
                     BEGIN
                        SELECT IND_FAMILIAR INTO V_FRIENDS
                        FROM TA_PLANTARIF
                        WHERE COD_PRODUCTO = 1
                        AND COD_PLANTARIF = VP_PLANTARIF;
                     EXCEPTION
                        WHEN NO_DATA_FOUND THEN
                           V_FRIENDS := 0;
                     END;
               END;
            ELSE */
            -- FIN COL|34726|14/03/2007|SAQL-RRG
              --V_FRIENDS := 0;
              V_FRIENDS := 1;
            END IF; -- COL|34726|14/03/2007|SAQL-RRG
          WHEN OTHERS THEN
              VP_ERROR := '4';
              RAISE ERROR_PROCESO;
   END;
   BEGIN
      IND_VALOR := 3;
      SELECT NUM_ABONADO INTO VAR1
      FROM GA_SERVSUPLABO
      WHERE NUM_ABONADO = VP_ABONADO
            AND COD_SERVICIO = V_DIASESPCEL
            AND IND_ESTADO < IND_VALOR;
      V_DIASESP := 1;
   EXCEPTION
               WHEN NO_DATA_FOUND THEN
                    V_DIASESP := 0;
               WHEN OTHERS THEN
                    VP_ERROR := '4';
                    RAISE ERROR_PROCESO;
   END;

   VP_FECBAJA := TO_DATE('31-12-3000','DD-MM-YYYY');
   V_TIPPLANTARIF := 'I';
   IND_INTARCEL := 0;
   V_GRUPO:= VP_EMPRESA;

   IF VP_INDACREC = 'R' THEN
      VP_TABLA := 'GED_PARAMETROS';
      SELECT VAL_PARAMETRO INTO V_PLANTARIF_DEALER FROM GED_PARAMETROS
      WHERE  NOM_PARAMETRO = 'COD_PLANREC_VDEALER'
             AND COD_PRODUCTO = 1
             AND COD_MODULO = 'GA';
      VP_TABLA := 'GED_PARAMETROS';
      SELECT VAL_PARAMETRO INTO V_CARGOBASICO_DEALER FROM GED_PARAMETROS
      WHERE  NOM_PARAMETRO = 'COD_CAREC_VDEALER'
             AND COD_PRODUCTO = 1
             AND COD_MODULO = 'GA';
      VP_TABLA := 'GED_PARAMETROS';
      SELECT VAL_PARAMETRO INTO V_PLANTARIF_DIRECTO FROM GED_PARAMETROS
      WHERE  NOM_PARAMETRO = 'COD_PLANREC_VDIRECTO'
             AND COD_PRODUCTO = 1
             AND COD_MODULO = 'GA';
      VP_TABLA := 'GED_PARAMETROS';
      SELECT VAL_PARAMETRO INTO V_CARGOBASICO_DIRECTO FROM GED_PARAMETROS
      WHERE  NOM_PARAMETRO = 'COD_CAREC_VDIRECTO'
             AND COD_PRODUCTO = 1
             AND COD_MODULO = 'GA';
      VP_TABLA := 'GED_PARAMETROS';
      SELECT VAL_PARAMETRO/24 INTO V_NUMHORAS FROM GED_PARAMETROS
      WHERE  NOM_PARAMETRO = 'NUM_HORAS'
             AND COD_PRODUCTO = 1
             AND COD_MODULO = 'GA';
      IND_VALOR := 0;
      VP_FECBAJA := VP_FECSYS;
      VP_TABLA := 'GA_ABOCEL';
      SELECT  B.COD_TIPCOMIS INTO V_TIPCOMIS
      FROM  GA_ABOCEL A,GA_VENTAS B
      WHERE   A.COD_CLIENTE = VP_CLIENTE
              AND A.NUM_ABONADO = VP_ABONADO
              AND A.NUM_VENTA = B.NUM_VENTA;
      VP_TABLA:= 'VE_TIPCOMIS';
      SELECT  IND_VTA_EXTERNA
      INTO V_VTA_EXTERNA
      FROM  VE_TIPCOMIS
      WHERE   COD_TIPCOMIS = V_TIPCOMIS;
      VP_TABLA := 'GED_PARAMETROS';
      SELECT VAL_PARAMETRO INTO V_CLIENTE_INTERNO FROM GED_PARAMETROS
      WHERE NOM_PARAMETRO = 'COD_CLIENTEINTERNO'
      AND COD_PRODUCTO = 1
      AND COD_MODULO = 'GA';
      VP_TABLA := 'GA_CAUSAREC';
      SELECT  IND_COBRO
      INTO V_INDCOBRO
      FROM GA_CAUSAREC
      WHERE COD_CAUSAREC =(SELECT COD_CAUSAREC
                           FROM GA_ABOCEL A, GA_VENTAS B
                           WHERE A.NUM_VENTA=B.NUM_VENTA
                           AND A.NUM_ABONADO=VP_ABONADO);
      VP_TABLA := 'VE_VENDEDORES';
      SELECT COD_CLIENTE
      INTO V_CLIENTE_AG
      FROM VE_VENDEDORES
      WHERE  COD_VENDEDOR = VP_AGENTE;
          V_PLANTARIF:= VP_PLANTARIF;
      V_CARGOBASICO:=VP_CARGOBASICO;
      IF V_INDCOBRO=1 THEN     --Indicador de cobro Verdadero
              IF (V_VTA_EXTERNA=1) THEN   --Indicador de VentaExterna
                          -- Es distribuidor
                                  V_PLANTARIF:=V_PLANTARIF_DEALER;
                          V_CARGOBASICO:=V_CARGOBASICO_DEALER;
                  END IF;
          V_FECAUX := VP_FECBAJA - VP_FECALTA;
          V_CLIENTE := V_CLIENTE_AG;
          IF (V_FECAUX > V_NUMHORAS) THEN    -- Rechazo efectuado en permodo mayor a 48 Horas
          BEGIN
                         -- Se deben ingresar dos registros el primero asociado al vendedor y otro interno
                         -- CLIENTE DEL VENDEDOR
                   V_CLIENTE := V_CLIENTE_AG;
                       VP_ACT := 'S';
                   VP_TABLA := 'GE_CLIENTES';
                   SELECT COD_CICLO
                           INTO V_CICLO
                           FROM GE_CLIENTES
                           WHERE  COD_CLIENTE = V_CLIENTE;
                   VP_TABLA := 'GA_CLIENTE_PCOM0';
                   SELECT COD_PLANCOM
                           INTO V_PLANCOM
                           FROM GA_CLIENTE_PCOM
                   WHERE  COD_CLIENTE = V_CLIENTE
               AND VP_FECSYS BETWEEN FEC_DESDE AND NVL(FEC_HASTA,VP_FECSYS);
                   VP_FECBAJARECHAZO := VP_FECALTA + V_NUMHORAS;
              INSERT INTO GA_INTARCEL (COD_CLIENTE,NUM_ABONADO,IND_NUMERO,FEC_DESDE,FEC_HASTA,IMP_LIMCONSUMO,
              IND_FRIENDS,IND_DIASESP,COD_CELDA,TIP_PLANTARIF,COD_PLANTARIF,NUM_SERIE,
              NUM_CELULAR,COD_CARGOBASICO,COD_CICLO,COD_PLANCOM,COD_PLANSERV,COD_GRPSERV,
              COD_GRUPO,COD_PORTADOR,COD_USO,NUM_IMSI)
                  VALUES (V_CLIENTE,VP_ABONADO,IND_VALOR,V_ALTA,VP_FECBAJARECHAZO,VP_IMPLIMCONS,V_FRIENDS,V_DIASESP,
              VP_CELDA,'I',V_PLANTARIF,VP_SERIE,VP_CELULAR,V_CARGOBASICO,V_CICLO,V_PLANCOM,
              -- VP_PLANSERV,VP_GRPSERV,V_GRUPO,VP_PORTADOR,V_USO_DESTINO, V_NUM_IMSI); -- COL|34726|15/03/2007|SAQL
              V_PLANSERV,VP_GRPSERV,V_GRUPO,VP_PORTADOR,V_USO_DESTINO,V_NUM_IMSI); -- COL|34726|15/03/2007|SAQL

                                IF VP_ACTABO IS NOT NULL
                                THEN
                                        PV_ACTUALIZA_CAMB_COMERC_PR(V_CLIENTE,
                                                                VP_ABONADO,
                                                                                                IND_VALOR,
                                                                                                VP_ACTABO,
                                                                                                V_ALTA,
                                                                                                vErrorAplic,
                                                                                                vErrorGlosa,
                                                                                                vErrorOra,
                                                                                                vErrorOraGlosa,
                                                                                                vTrace);
                                        IF vErrorAplic = 'FALSE'
                                        THEN
                                                VP_ERROR := '4';
                                                RAISE ERROR_PROCESO;
                                        END IF;
                                END IF;
              -- CLiente Interno y Plan Interno
                   V_FECAUX := VP_FECBAJA - VP_FECALTA;
                   V_CLIENTE := TO_NUMBER(V_CLIENTE_INTERNO);
                           V_PLANTARIF:=V_PLANTARIF_DIRECTO;
                   VP_FECALTARECHAZO := VP_FECBAJARECHAZO + (1/(24*60*60));
                           VP_ACT := 'S';
                   VP_TABLA := 'GE_CLIENTES';
                   SELECT COD_CICLO
                           INTO V_CICLO
                           FROM GE_CLIENTES
                           WHERE  COD_CLIENTE = V_CLIENTE;
                   VP_TABLA := 'GA_CLIENTE_PCOM1';
                   SELECT COD_PLANCOM
                           INTO V_PLANCOM
                           FROM GA_CLIENTE_PCOM
                   WHERE  COD_CLIENTE = V_CLIENTE
               AND VP_FECSYS BETWEEN FEC_DESDE AND NVL(FEC_HASTA,VP_FECSYS);
               INSERT INTO GA_INTARCEL (COD_CLIENTE,NUM_ABONADO,IND_NUMERO,FEC_DESDE,FEC_HASTA,IMP_LIMCONSUMO,
               IND_FRIENDS,IND_DIASESP,COD_CELDA,TIP_PLANTARIF,COD_PLANTARIF,NUM_SERIE,
               NUM_CELULAR,COD_CARGOBASICO,COD_CICLO,COD_PLANCOM,COD_PLANSERV,COD_GRPSERV,COD_GRUPO,COD_PORTADOR, COD_USO,NUM_IMSI)
                   VALUES (V_CLIENTE,VP_ABONADO,IND_VALOR,VP_FECALTARECHAZO,VP_FECBAJA,VP_IMPLIMCONS,V_FRIENDS,V_DIASESP,
               VP_CELDA,'I',V_PLANTARIF,VP_SERIE,VP_CELULAR,V_CARGOBASICO,V_CICLO,V_PLANCOM,
               -- VP_PLANSERV,VP_GRPSERV,V_GRUPO,VP_PORTADOR,V_USO_DESTINO, V_NUM_IMSI); -- COL|34726|15/03/2007|SAQL
               V_PLANSERV,VP_GRPSERV,V_GRUPO,VP_PORTADOR,V_USO_DESTINO, V_NUM_IMSI); -- COL|34726|15/03/2007|SAQL

                                IF VP_ACTABO IS NOT NULL
                                THEN
                                        PV_ACTUALIZA_CAMB_COMERC_PR(V_CLIENTE,
                                                                VP_ABONADO,
                                                                                                IND_VALOR,
                                                                                                VP_ACTABO,
                                                                                                VP_FECALTARECHAZO,
                                                                                                vErrorAplic,
                                                                                                vErrorGlosa,
                                                                                                vErrorOra,
                                                                                                vErrorOraGlosa,
                                                                                                vTrace);
                                        IF vErrorAplic = 'FALSE'
                                        THEN
                                                VP_ERROR := '4';
                                                RAISE ERROR_PROCESO;
                                        END IF;
                                END IF;

                  EXCEPTION
                     WHEN NO_DATA_FOUND THEN
                           VP_ERROR := '4';
                           RAISE ERROR_PROCESO;
                     WHEN OTHERS THEN
                           VP_ERROR := '4';
                           RAISE ERROR_PROCESO;
          END;
          ELSE  --Hora < 48
                  BEGIN
                       -- Cliente vendedor
                   V_CLIENTE := V_CLIENTE_AG;
                           VP_ACT := 'S';
                   VP_TABLA := 'GE_CLIENTES';
                   SELECT COD_CICLO
                       INTO V_CICLO
                       FROM GE_CLIENTES
                       WHERE  COD_CLIENTE = V_CLIENTE;
                   VP_TABLA := 'GA_CLIENTE_PCOM2';
                   SELECT COD_PLANCOM
                       INTO V_PLANCOM
                       FROM GA_CLIENTE_PCOM
                   WHERE  COD_CLIENTE = V_CLIENTE
               AND VP_FECSYS BETWEEN FEC_DESDE AND NVL(FEC_HASTA,VP_FECSYS);
               INSERT INTO GA_INTARCEL (COD_CLIENTE,NUM_ABONADO,IND_NUMERO,FEC_DESDE,FEC_HASTA,IMP_LIMCONSUMO,
               IND_FRIENDS,IND_DIASESP,COD_CELDA,TIP_PLANTARIF,COD_PLANTARIF,NUM_SERIE,
               NUM_CELULAR,COD_CARGOBASICO,COD_CICLO,COD_PLANCOM,COD_PLANSERV,COD_GRPSERV,
               COD_GRUPO,COD_PORTADOR, COD_USO,NUM_IMSI)
                   VALUES (V_CLIENTE,VP_ABONADO,IND_VALOR,V_ALTA,VP_FECBAJA,VP_IMPLIMCONS,V_FRIENDS,V_DIASESP,
               VP_CELDA,'I',V_PLANTARIF,VP_SERIE,VP_CELULAR,V_CARGOBASICO,V_CICLO,V_PLANCOM,
               --VP_PLANSERV,VP_GRPSERV,V_GRUPO,VP_PORTADOR,V_USO_DESTINO, V_NUM_IMSI); -- COL|34726|15/03/2007|SAQL
               V_PLANSERV,VP_GRPSERV,V_GRUPO,VP_PORTADOR,V_USO_DESTINO, V_NUM_IMSI); -- COL|34726|15/03/2007|SAQL

                                IF VP_ACTABO IS NOT NULL
                                THEN
                                        PV_ACTUALIZA_CAMB_COMERC_PR(V_CLIENTE,
                                                                VP_ABONADO,
                                                                                                IND_VALOR,
                                                                                                VP_ACTABO,
                                                                                                V_ALTA,
                                                                                                vErrorAplic,
                                                                                                vErrorGlosa,
                                                                                                vErrorOra,
                                                                                                vErrorOraGlosa,
                                                                                                vTrace);
                                        IF vErrorAplic = 'FALSE'
                                        THEN
                                                VP_ERROR := '4';
                                                RAISE ERROR_PROCESO;
                                        END IF;
                                END IF;

                  EXCEPTION
                    WHEN NO_DATA_FOUND THEN
                 VP_ERROR := '4';
                 RAISE ERROR_PROCESO;
                    WHEN OTHERS THEN
                 VP_ERROR := '4';
                 RAISE ERROR_PROCESO;
                  END;
          END IF;  -- Existe ind_cobro.
      ELSE  --Ind Cobro = False
          BEGIN
                   V_FECAUX := VP_FECBAJA - VP_FECALTA;
                   V_CLIENTE := TO_NUMBER(V_CLIENTE_INTERNO);
                           V_PLANTARIF:=V_PLANTARIF_DIRECTO;
               VP_FECALTARECHAZO := VP_FECBAJARECHAZO + (1/(24*60*60));
                           VP_ACT := 'S';
                   VP_TABLA := 'GE_CLIENTES';
                   SELECT COD_CICLO
                           INTO V_CICLO
                           FROM GE_CLIENTES
                           WHERE  COD_CLIENTE = V_CLIENTE;
                   VP_TABLA := 'GA_CLIENTE_PCOM3';
                   SELECT COD_PLANCOM
                           INTO V_PLANCOM
                           FROM GA_CLIENTE_PCOM
                   WHERE  COD_CLIENTE = V_CLIENTE
               AND VP_FECSYS BETWEEN FEC_DESDE AND NVL(FEC_HASTA,VP_FECSYS);
                           VP_TABLA := 'INTARCEL';
               VP_ACT:='I';
               INSERT INTO GA_INTARCEL (COD_CLIENTE,NUM_ABONADO,IND_NUMERO,FEC_DESDE,FEC_HASTA,IMP_LIMCONSUMO,
               IND_FRIENDS,IND_DIASESP,COD_CELDA,TIP_PLANTARIF,COD_PLANTARIF,NUM_SERIE,
               NUM_CELULAR,COD_CARGOBASICO,COD_CICLO,COD_PLANCOM,COD_PLANSERV,COD_GRPSERV,COD_GRUPO,COD_PORTADOR, COD_USO,NUM_IMSI)
                   VALUES (V_CLIENTE,VP_ABONADO,IND_VALOR,V_ALTA,VP_FECBAJA,VP_IMPLIMCONS,V_FRIENDS,V_DIASESP,
               VP_CELDA,'I',V_PLANTARIF,VP_SERIE,VP_CELULAR,V_CARGOBASICO,V_CICLO,V_PLANCOM,
               --VP_PLANSERV,VP_GRPSERV,V_GRUPO,VP_PORTADOR,V_USO_DESTINO, V_NUM_IMSI); -- COL|34726|15/03/2007|SAQL
               V_PLANSERV,VP_GRPSERV,V_GRUPO,VP_PORTADOR,V_USO_DESTINO, V_NUM_IMSI); -- COL|34726|15/03/2007|SAQL

                                IF VP_ACTABO IS NOT NULL
                                THEN
                                        PV_ACTUALIZA_CAMB_COMERC_PR(V_CLIENTE,
                                                                VP_ABONADO,
                                                                                                IND_VALOR,
                                                                                                VP_ACTABO,
                                                                                                V_ALTA,
                                                                                                vErrorAplic,
                                                                                                vErrorGlosa,
                                                                                                vErrorOra,
                                                                                                vErrorOraGlosa,
                                                                                                vTrace);
                                        IF vErrorAplic = 'FALSE'
                                        THEN
                                                VP_ERROR := '4';
                                                RAISE ERROR_PROCESO;
                                        END IF;
                                END IF;

          EXCEPTION
                WHEN NO_DATA_FOUND THEN
                     VP_ERROR := '4';
                     RAISE ERROR_PROCESO;
                WHEN OTHERS THEN
                     VP_ERROR := '4';
                     RAISE ERROR_PROCESO;
      END;
      END IF;

   ELSE
   -- ****ACEPTACION*******
        BEGIN
            V_CLIENTE := VP_CLIENTE;
                V_CICLO := VP_CICLO;
                VP_ACT := 'S';
        VP_TABLA := 'GA_CLIENTE_PCOM4';

                SELECT COD_PLANCOM  INTO V_PLANCOM
                FROM GA_CLIENTE_PCOM
                WHERE  COD_CLIENTE = VP_CLIENTE
                AND VP_FECSYS BETWEEN FEC_DESDE AND NVL(FEC_HASTA,VP_FECSYS);

                --Inicio incidencia RA-200603130907 se grega SQL para rescatar la fecha contenida en el campo
		--FEC_ACTCEN ya que es la que se requiere quede en la tabla GA_INTARCEL campo FEC_DESDE [PAAA 26-04-2006, soporte]
		-- Inicio modificacion by SAQL/Soporte 07/07/2006 - CO-200607050216
		IF VP_ABONADO <> 0 THEN
		   -- INICIO 118280 20/09/2012
		   --SELECT TO_CHAR(FEC_ACTCEN,'DD-MM-YYYY HH:MI:SS')
		   SELECT TO_CHAR(FEC_ACTCEN,'DD-MM-YYYY HH24:MI:SS')
		   -- FIN 118280 20/09/2012
		   INTO  V_FEC_ACTCEN
		   FROM  GA_ABOCEL
		   WHERE NUM_ABONADO = VP_ABONADO;
		ELSE
		-- INICIO 118280 20/09/2012
		  -- V_FEC_ACTCEN := to_char(NVL(VP_FECSYS,SYSDATE),'DD-MM-YYYY HH:MI:SS');
		   V_FEC_ACTCEN := to_char(NVL(VP_FECSYS,SYSDATE),'DD-MM-YYYY HH24:MI:SS');
		-- FIN 118280 20/09/2012
         V_PLANCOM := 1; -- COL|34726|14/03/2007|SAQL-RRR
		END IF;
		-- Fin modificacion by SAQL/Soporte 07/07/2006 - CO-200607050216
		--Fin incidencia RA-200603130907

                V_PLANTARIF := VP_PLANTARIF;
                V_CARGOBASICO := VP_CARGOBASICO;
                IND_VALOR := 0;

                VP_ACT := 'I';
        VP_TABLA := 'GA_INTARCEL'||VP_ACTABO;

                INSERT INTO GA_INTARCEL (COD_CLIENTE,NUM_ABONADO,IND_NUMERO,
                   FEC_DESDE,FEC_HASTA,IMP_LIMCONSUMO,
                           IND_FRIENDS,IND_DIASESP,COD_CELDA,
                           TIP_PLANTARIF,COD_PLANTARIF,NUM_SERIE,
                           NUM_CELULAR,COD_CARGOBASICO,COD_CICLO,
                           COD_PLANCOM,COD_PLANSERV,COD_GRPSERV,
                           COD_GRUPO,COD_PORTADOR,COD_USO,NUM_IMSI)
                   VALUES (V_CLIENTE,VP_ABONADO,IND_VALOR,
                   	  --Inicio incidencia RA-200603130907
                          -- V_ALTA,VP_FECBAJA,VP_IMPLIMCONS,
		          -- INICIO 118280 20/09/2012
                          --TO_DATE(V_FEC_ACTCEN, 'DD-MM-YYYY HH:MI:SS') ,VP_FECBAJA,VP_IMPLIMCONS,
			  TO_DATE(V_FEC_ACTCEN, 'DD-MM-YYYY HH24:MI:SS') ,VP_FECBAJA,VP_IMPLIMCONS,
			  -- FIN 118280 20/09/2012
                          --Fin incidencia RA-200603130907
                           V_FRIENDS,V_DIASESP,VP_CELDA,
                   VP_TIPPLANTARIF,V_PLANTARIF,VP_SERIE,
                           VP_CELULAR,V_CARGOBASICO,V_CICLO,
                           -- V_PLANCOM,VP_PLANSERV,VP_GRPSERV, -- COL|34726|15/03/2007|SAQL
                           V_PLANCOM,V_PLANSERV,VP_GRPSERV, -- COL|34726|15/03/2007|SAQL
                           V_GRUPO,'1',V_USO_DESTINO,V_NUM_IMSI);

                IF VP_ACTABO IS NOT NULL
                THEN

                SELECT VAL_PARAMETRO
                INTO V_PARAMFECHA
		FROM GED_PARAMETROS
                WHERE NOM_PARAMETRO IN ('FORMATO_SEL2');


				SELECT VAL_PARAMETRO
                INTO  V_PARAMHORA
	        FROM GED_PARAMETROS
                WHERE NOM_PARAMETRO IN ('FORMATO_SEL7');





                        PV_ACTUALIZA_CAMB_COMERC_PR(V_CLIENTE,
                                                VP_ABONADO,
                                                                                IND_VALOR,
                                                                                VP_ACTABO,
                                                                                TO_DATE(V_FEC_ACTCEN, V_PARAMFECHA || ' ' ||  V_PARAMHORA  ),
                                                                                vErrorAplic,
                                                                                vErrorGlosa,
                                                                                vErrorOra,
                                                                                vErrorOraGlosa,
                                                                                vTrace);
                        IF vErrorAplic = 'FALSE'
                        THEN
                                VP_ERROR := '4';
                                RAISE ERROR_PROCESO;
                        END IF;
                END IF;
        EXCEPTION
                WHEN OTHERS THEN
             VP_ERROR := '4';
                         VP_SQLERRM := SQLERRM;
             RAISE ERROR_PROCESO;
        END;
  END IF;

  IF VP_ABONADO <> 0 THEN
    BEGIN
           VP_TABLA := 'TA_ACUMABONADO';
       IND_VALOR := 0;
       INSERT INTO TA_ACUMABONADO (NUM_ABONADO,FEC_ALTA,SEG_CONSUMOS)
                          VALUES (VP_ABONADO,VP_FECALTA,IND_VALOR);
    EXCEPTION
       WHEN OTHERS THEN
           IF SQLCODE = -1 THEN
              IND_VALOR := 0;
              UPDATE TA_ACUMABONADO
              SET SEG_CONSUMOS = IND_VALOR
              WHERE NUM_ABONADO = VP_ABONADO;
           ELSE
              VP_ERROR := '4';
              RAISE ERROR_PROCESO;
           END IF;
    END;
  END IF;


  VP_PROC := 'P_ALTA_INTARCEL';
EXCEPTION
      WHEN NO_DATA_FOUND THEN
           NULL;
      WHEN OTHERS THEN
           VP_SQLCODE := SQLCODE;
           VP_SQLERRM := SQLERRM;
           VP_ERROR := '4';
END;
/
SHOW ERRORS
