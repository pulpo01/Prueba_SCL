CREATE OR REPLACE procedure GA_P_PRIMERHOLDING
(VP_ABONADO       IN            NUMBER,
 VP_PRODUCTO      IN            NUMBER,
 VP_TIPPLANTARIF  IN        VARCHAR2,
 VP_HOLDING       IN OUT        NUMBER,
 VP_FECSYS                IN            DATE,
 VP_PROC                  IN OUT        VARCHAR2,
 VP_TABLA                 IN OUT        VARCHAR2,
 VP_ACT                   IN OUT        VARCHAR2,
 VP_SQLCODE       IN OUT        VARCHAR2,
 VP_SQLERRM       IN OUT        VARCHAR2,
 VP_ERROR                 IN OUT        VARCHAR2,
 VP_ACTABO                IN            VARCHAR2:=NULL)

IS
-- PL/SQL Specification
--
-- *************************************************************
-- * procedimiento      : GA_P_PRIMERHOLDING
-- * Descripcisn        : pl que comprueba si al aceptar un abonado es holding y no tiene abonados
-- *                      dados de alta aun, en ese caso actualiza la tabla de interfase  abonado  0
-- *                      para que sea tomado en cuenta por facturacion
-- * Fecha de creacisn  : 14-01-2003 16:23
-- * Responsable        : Area VENTAS (*)
-- * Versión:  1.1
-- *************************************************************
--
--

--GA_P_PRIMERHOLDING, v1.2, COL-43736|22-10-2007|GEZ

      V_CARGOPROOPER             NUMBER(1);  -- PARAMETRO DE PROPORCIONALIDAD GLOBAL POR OPERADORA Inc. RA-200512160337
      V_CLIENTE                          GA_ABOCEL.COD_CLIENTE%TYPE;
      V_CLIENEW                          GA_ABOCEL.COD_CLIENTE%TYPE;
      V_PLEXSYS                          GA_ABOCEL.IND_PLEXSYS%TYPE;
      V_LIMCONSUMO                       GA_ABOCEL.COD_LIMCONSUMO%TYPE;
      V_IMPLICONS                        TA_LIMCONSUMO.IMP_LIMCONSUMO%TYPE;
      V_CELDA                            GA_ABOCEL.COD_CELDA%TYPE;
      V_TIPPLANTARIF             GA_ABOCEL.TIP_PLANTARIF%TYPE;
      V_PLANTARIF                        GA_ABOCEL.COD_PLANTARIF%TYPE;
      V_SERIE                            GA_ABOCEL.NUM_SERIEHEX%TYPE;
      V_CELULAR                          GA_ABOCEL.NUM_CELULAR%TYPE;
      V_CELULAR_PLEX             GA_ABOCEL.NUM_CELULAR_PLEX%TYPE;
      V_CARGOBASICO              GA_ABOCEL.COD_CARGOBASICO%TYPE;
      V_CICLO                            GA_ABOCEL.COD_CICLO%TYPE;
      V_CICLONEW                         GA_ABOCEL.COD_CICLO%TYPE;
      V_PLANCOM                          VE_PLANCOM.COD_PLANCOM%TYPE;
      V_PLANSERV                         GA_ABOCEL.COD_PLANSERV%TYPE;
      V_GRPSERV                          GA_ABOCEL.COD_GRPSERV%TYPE;
      V_EMPRESA                          GA_ABOCEL.COD_EMPRESA%TYPE;
      V_HOLDING                          GA_ABOCEL.COD_HOLDING%TYPE;
      V_PORTADOR                         GA_ABOCEL.COD_CARRIER%TYPE;
      V_PROCALTA                         GA_ABOCEL.IND_PROCALTA%TYPE;
      V_AGENTE                           GA_ABOCEL.COD_VENDEDOR_AGENTE%TYPE;
      V_SUPERTEL                         GA_ABOCEL.IND_SUPERTEL%TYPE;
      V_TELEFIJA                         GA_ABOCEL.NUM_TELEFIJA%TYPE;
      V_FECALTA                          GA_ABOCEL.FEC_ACTCEN%TYPE;
      V_VENTA                            GA_ABOCEL.NUM_VENTA%TYPE;
      V_INDFACT                          GA_ABOCEL.IND_FACTUR%TYPE;
      V_FINCONTRA                        GA_ABOCEL.FEC_FINCONTRA%TYPE;
      V_OPREDFIJA                        GA_ABOCEL.COD_OPREDFIJA%TYPE;
      V_BAJACEN                          GA_ABOCEL.FEC_BAJACEN%TYPE;
      V_BAJA                             GA_ABOCEL.FEC_BAJACEN%TYPE;
      V_CREDMOR                          GA_ABOCEL.COD_CREDMOR%TYPE;
      V_USUARIO                          GA_ABOCEL.COD_USUARIO%TYPE;
      V_ALQUILER                         GA_ABORENT.NUM_ALQUILER%TYPE;
      V_MOVALTA                          GA_ABORENT.NUM_MOVIMIENTO%TYPE;
      V_MOVBAJA                          GA_ABORENT.NUM_MOVBAJA%TYPE;
      V_ORIGEN                           NUMBER;
      V_DESTINO                          NUMBER;
      V_VAR3                             NUMBER;
      V_FECCICLO                         DATE;
      V_OPERADOR                         GA_ABOROACOM.COD_OPERADOR%TYPE;
      V_ROWID                            VARCHAR2(19);
      V_OK                                       NUMBER(1);
      V_CAPCODE                          GA_ABOBEEP.CAP_CODE%TYPE;
      V_BEEPER                           GA_ABOBEEP.NUM_BEEPER%TYPE;
      V_TERMINAL                         GA_ABOCEL.NUM_CELULAR%TYPE;
      V_CICLFACT                         FA_CICLFACT.COD_CICLFACT%TYPE;
      V_PENDIENTE                        NUMBER(1);
      V_ANULTRASPASO             GA_INFACCEL.IND_ACTUAC%TYPE;
      FEC_MIN_INTARCEL           GA_INTARCEL.FEC_DESDE%TYPE;
      FEC_MAX_INTARCEL           GA_INTARCEL.FEC_HASTA%TYPE;
      IND_VALOR                          NUMBER;
      V_FECHA_AUX                        DATE;
      ERROR_PROCESO              EXCEPTION;
      V_CONT                             NUMBER; -- Modificacion by SAQL/Soporte 06/07/2006 - CO-200607050216  (Regulariza GSA/soporte 05/12/2006 - 35874)

  BEGIN
        V_OK := 0;

        -- Inicio RA-200512160337 [mept soporte 21-12-2005]
        VP_PROC := 'GA_P_PRIMERHOLDING';
        VP_TABLA := 'FAD_PARAMETROS';

        SELECT VAL_NUMERICO INTO V_CARGOPROOPER
        FROM FAD_PARAMETROS WHERE COD_PARAMETRO = 303;
        -- Fin RA-200512160337 [mept soporte 21-12-2005]

        BEGIN
           SELECT ROWID
                   INTO V_ROWID
                   FROM GA_ABOCEL
           WHERE TIP_PLANTARIF = VP_TIPPLANTARIF
           AND COD_EMPRESA = VP_HOLDING
           AND NUM_ABONADO <> VP_ABONADO
           AND COD_SITUACION NOT IN ('TVP','AOA','AOP','ATA', 'ATP','RDA','CVA','AOS','ATS','REA','BAA','BAP')
           AND ROWNUM = 1;

                   V_PENDIENTE:=1;
           V_FECHA_AUX := TO_DATE('31-12-3000','DD-MM-YYYY');

        EXCEPTION
           WHEN NO_DATA_FOUND THEN
               V_PENDIENTE:=0;
        END;

        IF V_PENDIENTE =0 THEN
           BEGIN
                  -- Inicio modificacion by SAQL/Soporte 06/07/2006 - CO-200607050216 (Regulariza GSA/soporte 05/12/2006 - 35874)
                  IND_VALOR := 0;
                  VP_PROC := 'GA_P_PRIMERHOLDING';
                  VP_TABLA := 'GA_INTARCEL';
                  VP_ACT := 'S';

                  BEGIN
                   SELECT A.ROWID INTO V_ROWID
                   FROM GA_INTARCEL A, GA_EMPRESA B
                   WHERE A.COD_CLIENTE = B.COD_CLIENTE
                   AND B.COD_EMPRESA = VP_HOLDING
                   AND A.NUM_ABONADO = IND_VALOR
                   AND A.COD_GRUPO = VP_HOLDING
                   AND A.TIP_PLANTARIF = VP_TIPPLANTARIF
                   AND SYSDATE BETWEEN A.FEC_DESDE AND A.FEC_HASTA;
                  EXCEPTION
                   WHEN NO_DATA_FOUND THEN
                                V_OK := 1;
                  END;

                          BEGIN
                   VP_TABLA:='GA_INTARCEL';
                   VP_ACT:='S';

                                   SELECT MAX(A.FEC_HASTA) INTO FEC_MAX_INTARCEL
                   FROM GA_INTARCEL A, GA_EMPRESA B
                   WHERE A.COD_CLIENTE = B.COD_CLIENTE
                   AND B.COD_EMPRESA = VP_HOLDING
                   AND A.NUM_ABONADO = IND_VALOR;
                  EXCEPTION
                   WHEN NO_DATA_FOUND THEN
                                FEC_MAX_INTARCEL := '';
                  END;

                          FEC_MIN_INTARCEL := VP_FECSYS;

                          BEGIN
                   VP_TABLA:='GA_INTARCEL';
                   VP_ACT:='S';

                                   SELECT MIN(A.FEC_DESDE) INTO FEC_MIN_INTARCEL
                   FROM GA_INTARCEL A, GA_EMPRESA B
                   WHERE A.COD_CLIENTE = B.COD_CLIENTE
                   AND B.COD_EMPRESA = VP_HOLDING
                   AND TRUNC(FEC_HASTA)= TO_DATE('31-12-3000','DD-MM-YYYY');

                                   IF FEC_MIN_INTARCEL > VP_FECSYS THEN
                          FEC_MIN_INTARCEL := VP_FECSYS;
                   END IF;
              EXCEPTION
                   WHEN NO_DATA_FOUND THEN
                                FEC_MIN_INTARCEL:=VP_FECSYS;
              END;
                  -- Fin modificacion by SAQL/Soporte 06/07/2006 - CO-200607050216 (Regulariza GSA/soporte 05/12/2006 - 35874)

                          VP_TABLA := 'GA_ABOCEL';
                          VP_ACT := 'S';
                          P_DATOS_ABOCEL(VP_ABONADO,V_CLIENTE,V_PLEXSYS,V_IMPLICONS,
                                                         V_CELDA,V_TIPPLANTARIF,V_PLANTARIF,V_SERIE,V_CELULAR,V_CELULAR_PLEX,V_CARGOBASICO,V_CICLO,
                                                         V_PLANSERV,V_GRPSERV,V_EMPRESA,V_HOLDING,V_PORTADOR,V_PROCALTA,V_AGENTE,V_SUPERTEL,V_TELEFIJA,V_FECALTA,
                                                         V_VENTA,V_INDFACT,V_FINCONTRA,V_BAJACEN,V_BAJA,V_CREDMOR,V_USUARIO,V_OPREDFIJA,VP_PROC,VP_TABLA,
                                                         VP_ACT,VP_SQLCODE,VP_SQLERRM,VP_ERROR);

                          IF VP_ERROR <> '0' THEN
                                VP_ERROR := '4';
                                RAISE ERROR_PROCESO;
                          END IF;

                          IND_VALOR := 0;
                          VP_PROC := 'GA_P_PRIMERHOLDING';
                          VP_TABLA := 'GA_INTARCEL_1';
                          VP_ACT := 'S';

                          SELECT  NVL(MIN(A.FEC_DESDE),SYSDATE) -- incidencia RA-200511250198 30-11-2005
              INTO FEC_MIN_INTARCEL
                          FROM GA_INTARCEL A, GA_EMPRESA B
                          WHERE A.COD_CLIENTE=B.COD_CLIENTE
              AND B.COD_EMPRESA=VP_HOLDING
              AND A.NUM_ABONADO = IND_VALOR
              AND A.COD_GRUPO = VP_HOLDING
              AND A.TIP_PLANTARIF = VP_TIPPLANTARIF
              AND SYSDATE BETWEEN A.FEC_DESDE AND A.FEC_HASTA;

              -- Inicio modificacion by SAQL/Soporte 06/07/2006 - CO-200607050216 (Regulariza GSA/soporte 05/12/2006 - 35874)
              SELECT COUNT(1)  INTO V_CONT
              FROM GA_INTARCEL
              WHERE NUM_ABONADO = 0
              AND COD_CLIENTE = V_CLIENTE
              AND SYSDATE BETWEEN FEC_DESDE AND FEC_HASTA;

                          IF V_CONT = 0 THEN
                   IF VP_ACTABO IS NOT NULL OR VP_ACTABO <> '*' THEN
                      P_ALTA_INTARCEL(0,'A',V_CLIENTE,V_PLEXSYS,V_IMPLICONS,
                      V_CELDA,V_TIPPLANTARIF,V_PLANTARIF,V_SERIE,0,V_CELULAR_PLEX,V_CARGOBASICO,V_CICLO,
                      V_PLANSERV,V_GRPSERV,V_EMPRESA,V_HOLDING,V_PORTADOR,V_PROCALTA,V_AGENTE,FEC_MIN_INTARCEL,
                      FEC_MIN_INTARCEL,VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,VP_SQLERRM,VP_ERROR,VP_ACTABO);
                   ELSE
                      P_ALTA_INTARCEL(0,'A',V_CLIENTE,V_PLEXSYS,V_IMPLICONS,
                      V_CELDA,V_TIPPLANTARIF,V_PLANTARIF,V_SERIE,0,V_CELULAR_PLEX,V_CARGOBASICO,V_CICLO,
                      V_PLANSERV,V_GRPSERV,V_EMPRESA,V_HOLDING,V_PORTADOR,V_PROCALTA,V_AGENTE,FEC_MIN_INTARCEL,
                      FEC_MIN_INTARCEL,VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,VP_SQLERRM,VP_ERROR);
                   END IF;

                               IF VP_ERROR <> '0' THEN
                      VP_ERROR := '4';
                      RAISE ERROR_PROCESO;
                   END IF;

                   VP_PROC := 'GA_P_PRIMERHOLDING';

              END IF;
              -- Fin modificacion by SAQL/Soporte 06/07/2006 - CO-200607050216 (Regulariza GSA/soporte 05/12/2006 - 35874)

                          /*  BETA  para Ecuador */
                          VP_TABLA := 'FA_CICLFACT_1';
                          VP_ACT := 'S';

                          SELECT COD_CICLFACT INTO V_CICLFACT FROM FA_CICLFACT
                          --WHERE COD_CICLO = V_CICLO                                                                                                           --COL-43736|22-10-2007|GEZ
                          WHERE COD_CICLO = (SELECT cod_ciclo FROM ge_clientes WHERE cod_cliente=V_CLIENTE)     --COL-43736|22-10-2007|GEZ
                          AND SYSDATE BETWEEN FEC_DESDELLAM AND FEC_HASTALLAM;

                          VP_TABLA := 'GA_INFACCEL_1';
                          VP_ACT := 'S';

                          SELECT COUNT(1)
                          INTO V_ANULTRASPASO
                          FROM GA_INFACCEL
                          WHERE COD_CLIENTE = V_CLIENTE
                          AND NUM_ABONADO = 0
                          AND COD_CICLFACT = V_CICLFACT
                          AND IND_ACTUAC IN (3,2,5);

                          IF (V_ANULTRASPASO > 0) THEN
                                        VP_ACT := 'U';

                                        UPDATE GA_INFACCEL
                                        SET IND_ACTUAC = DECODE(IND_ACTUAC,3,7,8)
                                        WHERE COD_CLIENTE = V_CLIENTE
                                        AND NUM_ABONADO = 0
                                        AND COD_CICLFACT = V_CICLFACT
                                        AND IND_ACTUAC IN (3,2,5);
                      END IF;

                          VP_ACT := 'I';

                          V_FECHA_AUX := TO_DATE('31-12-3000','DD-MM-YYYY');-- incidencia RA-200511250198 30-11-2005

                          BEGIN

                                   /* Inicio modificacion by SAQL/Soporte 27/06/2006 - CO-200607240253 */
                                   V_CONT := 0;

                                   SELECT COUNT(1) INTO V_CONT
                                   FROM GA_INFACCEL
                                   WHERE NUM_ABONADO = 0
                                   AND COD_CLIENTE = V_CLIENTE
                                   AND COD_CICLFACT = V_CICLFACT;

                                   IF V_CONT = 0 THEN
                                   /* Fin modificacion by SAQL/Soporte 27/06/2006 - CO-200607240253 */

                                          INSERT INTO GA_INFACCEL
                                          (COD_CLIENTE,NUM_ABONADO,COD_CICLFACT,FEC_ALTA,FEC_BAJA,NUM_CELULAR,
                                          IND_ACTUAC,FEC_FINCONTRA,IND_ALTA,IND_DETALLE,IND_FACTUR,IND_CUOTAS,
                                          IND_ARRIENDO,IND_CARGOS,IND_PENALIZA,IND_SUPERTEL,IND_CARGOPRO,
                                          IND_CUENCONTROLADA)
                                          VALUES (V_CLIENTE,0,V_CICLFACT,FEC_MIN_INTARCEL,V_FECHA_AUX,0,1,V_FINCONTRA, 1,0,1,0,0,0,0,0,V_CARGOPROOPER,0);--Inicio incidencia CO-200606300213 NRCA se parametriza campo IND_CARGOPRO
                                   /* Inicio modificacion by SAQL/Soporte 27/07/2006 - CO-200607240253 */
                                   /*Inicio 39426 HPG/24-04-2007 Actualiza abonado cero con cierre de facturacion. */
                                   ELSE

                                          UPDATE GA_INFACCEL
                                          SET IND_ACTUAC = 1,
                                                  FEC_BAJA = V_FECHA_AUX
                                          WHERE COD_CLIENTE = V_CLIENTE
                                          AND NUM_ABONADO = 0
                                          AND COD_CICLFACT = V_CICLFACT
                                          --AND IND_ACTUAC = 7;            --MOD 43054-COL|10-08-2007|EFR
                                          AND IND_ACTUAC IN (6, 7);    --MOD 43054-COL|10-08-2007|EFR

                                   /*Fin 39426 HPG/24-04-2007 */
                                   END IF;
                                   /* Fin modificacion by SAQL/Soporte 27/07/2006 - CO-200607240253 */
                                EXCEPTION
                                WHEN OTHERS THEN
                                                VP_ERROR := '4';
                                                RAISE ERROR_PROCESO;
                                END;

                                BEGIN
                                        VP_TABLA := 'FA_CICLOCLI_1';
                                        VP_ACT := 'S';
                                        IND_VALOR := 0;

                                        SELECT ROWID INTO V_ROWID
                                        FROM FA_CICLOCLI
                                        WHERE COD_CLIENTE = V_CLIENTE
                                        AND NUM_ABONADO = IND_VALOR
                                        AND COD_CICLO = V_CICLO;

                                EXCEPTION
                                WHEN NO_DATA_FOUND THEN
                                                VP_TABLA := 'P_ALTA_CICLOCLI';
                                                VP_ACT := 'I';

                                                P_ALTA_CICLOCLI(VP_PRODUCTO,V_CLIENTE,IND_VALOR,V_CICLO,'A',
                                                                   V_AGENTE,V_CREDMOR,V_USUARIO,FEC_MIN_INTARCEL,
                                                                   VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,VP_SQLERRM,VP_ERROR);

                                                IF VP_ERROR <> '0' THEN
                                                   VP_ERROR := '4';
                                                   RAISE ERROR_PROCESO;
                                                END IF;
                                END;
                                /*   fin beta Ecuador */

           EXCEPTION
              WHEN NO_DATA_FOUND THEN
                   V_OK := 1;
                   -- Validando Fecha Hasta de Abonado 0, dado de baja

                                   BEGIN
                                VP_TABLA:='GA_INTARCEL_2';
                                VP_ACT:='S';

                                                SELECT MAX(A.FEC_HASTA)
                                INTO FEC_MAX_INTARCEL
                                FROM GA_INTARCEL A, GA_EMPRESA B
                                WHERE A.COD_CLIENTE=B.COD_CLIENTE
                                AND B.COD_EMPRESA=VP_HOLDING
                                AND A.NUM_ABONADO=IND_VALOR;
                   EXCEPTION
                                WHEN NO_DATA_FOUND THEN
                                 FEC_MAX_INTARCEL:='';
                   END;

                                   --Buscando minima fecha de alta de abonado 0
                   FEC_MIN_INTARCEL:=VP_FECSYS;

                                   BEGIN
                                VP_TABLA:='GA_INTARCEL_3';
                                VP_ACT:='S';

                                                SELECT MIN(A.FEC_DESDE)
                                INTO FEC_MIN_INTARCEL
                                FROM GA_INTARCEL A, GA_EMPRESA B
                                WHERE A.COD_CLIENTE=B.COD_CLIENTE
                                AND B.COD_EMPRESA=VP_HOLDING
                                AND TRUNC(FEC_HASTA)= TO_DATE('31-12-3000','DD-MM-YYYY');

                                                IF FEC_MIN_INTARCEL > VP_FECSYS THEN
                           FEC_MIN_INTARCEL:=VP_FECSYS;
                                END IF;

                   EXCEPTION
                                WHEN NO_DATA_FOUND THEN
                                 FEC_MIN_INTARCEL:=VP_FECSYS;
                   END;

                                   VP_PROC := 'GA_P_PRIMERHOLDING';
                   V_TERMINAL := V_CELULAR;

                   IF FEC_MIN_INTARCEL < FEC_MAX_INTARCEL THEN

                                           VP_TABLA := 'GA_INTARCEL_4';
                           VP_ACT := 'U';

                           UPDATE GA_INTARCEL SET FEC_HASTA=V_FECHA_AUX
                           WHERE COD_CLIENTE=V_CLIENTE
                           AND NUM_ABONADO=IND_VALOR
                           AND FEC_HASTA=FEC_MAX_INTARCEL;

                   ELSE

                                           IF FEC_MIN_INTARCEL IS NULL THEN
                          FEC_MIN_INTARCEL:=VP_FECSYS;
                           END IF;

                           IF VP_ACTABO IS NOT NULL OR VP_ACTABO <> '' OR VP_ACTABO <> '*' THEN

                                                   VP_TABLA := 'GA_INTARCEL-A';
                           VP_ACT := 'I';

                                                   P_ALTA_INTARCEL(0,'A',V_CLIENTE,V_PLEXSYS,V_IMPLICONS,
                                                          V_CELDA,V_TIPPLANTARIF,V_PLANTARIF,V_SERIE,0,V_CELULAR_PLEX,V_CARGOBASICO,V_CICLO,
                                                          V_PLANSERV,V_GRPSERV,V_EMPRESA,V_HOLDING,V_PORTADOR,V_PROCALTA,V_AGENTE,FEC_MIN_INTARCEL,
                                                          FEC_MIN_INTARCEL,VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,VP_SQLERRM,VP_ERROR,VP_ACTABO);
                           ELSE
                                                   VP_TABLA := 'GA_INTARCEL-B';
                           VP_ACT := 'I';

                                                   P_ALTA_INTARCEL(0,'A',V_CLIENTE,V_PLEXSYS,V_IMPLICONS,
                                                           V_CELDA,V_TIPPLANTARIF,V_PLANTARIF,V_SERIE,0,V_CELULAR_PLEX,V_CARGOBASICO,V_CICLO,
                                                           V_PLANSERV,V_GRPSERV,V_EMPRESA,V_HOLDING,V_PORTADOR,V_PROCALTA,V_AGENTE,FEC_MIN_INTARCEL,
                                                           FEC_MIN_INTARCEL,VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,VP_SQLERRM,VP_ERROR);
                           END IF;

                                           IF VP_ERROR <> '0' THEN
                          VP_ERROR := '4';
                          RAISE ERROR_PROCESO;
                           END IF;
                   END IF;

                                   VP_PROC := 'GA_P_PRIMERHOLDING';

                                   VP_TABLA := 'FA_CICLFACT_2';
                                   VP_ACT := 'S';

                                   SELECT COD_CICLFACT INTO V_CICLFACT FROM FA_CICLFACT
                   --WHERE COD_CICLO = V_CICLO                                                                                                                  --COL-43736|22-10-2007|GEZ
                                   WHERE COD_CICLO = (SELECT cod_ciclo FROM ge_clientes WHERE cod_cliente=V_CLIENTE)    --COL-43736|22-10-2007|GEZ
                   AND SYSDATE BETWEEN FEC_DESDELLAM AND FEC_HASTALLAM;

                                   VP_TABLA := 'GA_INFACCEL_2';
                                   VP_ACT := 'S';

                                   SELECT COUNT(1)
                   INTO V_ANULTRASPASO
                   FROM GA_INFACCEL
                   WHERE COD_CLIENTE = V_CLIENTE
                   AND NUM_ABONADO = 0
                   AND COD_CICLFACT = V_CICLFACT
                   AND IND_ACTUAC IN (3,2,5);

                   IF (V_ANULTRASPASO > 0) THEN
                                          VP_TABLA := 'GA_INFACCEL_3';
                                          VP_ACT := 'U';

                                          UPDATE GA_INFACCEL
                          SET IND_ACTUAC = DECODE(IND_ACTUAC,3,7,8)
                          WHERE COD_CLIENTE = V_CLIENTE
                          AND NUM_ABONADO = 0
                          AND COD_CICLFACT = V_CICLFACT
                          AND IND_ACTUAC IN (3,2,5);
                   END IF;

                                   VP_TABLA := 'GA_INFACCEL_4';
                                   VP_ACT := 'I';

                                   V_FECHA_AUX := TO_DATE('31-12-3000','DD-MM-YYYY'); -- incidencia RA-200511250198 30-11-2005

                                   BEGIN
                                INSERT INTO GA_INFACCEL
                                (COD_CLIENTE,NUM_ABONADO,COD_CICLFACT,FEC_ALTA,FEC_BAJA,NUM_CELULAR,
                                IND_ACTUAC,FEC_FINCONTRA,IND_ALTA,IND_DETALLE,IND_FACTUR,IND_CUOTAS,
                                IND_ARRIENDO,IND_CARGOS,IND_PENALIZA,IND_SUPERTEL,IND_CARGOPRO,
                                IND_CUENCONTROLADA)
                                VALUES (V_CLIENTE,0,V_CICLFACT,FEC_MIN_INTARCEL,V_FECHA_AUX,0,1,V_FINCONTRA, 1,0,1,0,0,0,0,0,V_CARGOPROOPER,0); -- RA-200512160337 [mept soporte 21-12-2005]
                                   EXCEPTION
                                        WHEN OTHERS THEN
                                         VP_ERROR := '4';
                                                         RAISE ERROR_PROCESO;
                                   END;

                                   BEGIN

                                                VP_TABLA := 'FA_CICLOCLI_2';
                                                VP_ACT := 'S';

                                                IND_VALOR := 0;

                                                SELECT ROWID INTO V_ROWID
                                                FROM FA_CICLOCLI
                                                WHERE COD_CLIENTE = V_CLIENTE
                                                AND NUM_ABONADO = IND_VALOR
                                                AND COD_CICLO = V_CICLO;
                                   EXCEPTION
                                        WHEN NO_DATA_FOUND THEN
                                                         VP_TABLA := 'P_ALTA_CICLOCLI';
                                                         VP_ACT := 'I';

                                                         P_ALTA_CICLOCLI(VP_PRODUCTO,V_CLIENTE,0,V_CICLO,'A',
                                 V_AGENTE,V_CREDMOR,V_USUARIO,FEC_MIN_INTARCEL,
                                 VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,VP_SQLERRM,VP_ERROR);

                                                         IF VP_ERROR <> '0' THEN
                                                VP_ERROR := '4';
                                                RAISE ERROR_PROCESO;
                                         END IF;
                                   END;
           WHEN OTHERS THEN
                VP_ERROR := '4';
                RAISE ERROR_PROCESO;
           END;

        END IF;
 EXCEPTION
     WHEN ERROR_PROCESO THEN

                  IF VP_ERROR = '4' THEN
             VP_SQLCODE      := SQLCODE;
             VP_SQLERRM      := SQLERRM;
          END IF;

     WHEN OTHERS THEN
          VP_ERROR        := '4';
          VP_SQLCODE      := SQLCODE;
          VP_SQLERRM      := SQLERRM;
END;
/
SHOW ERRORS
