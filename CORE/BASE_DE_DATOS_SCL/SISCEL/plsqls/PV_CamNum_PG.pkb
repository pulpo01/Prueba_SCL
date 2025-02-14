CREATE OR REPLACE PACKAGE BODY PV_CamNum_PG IS

--PV_CamNum_PG v1.1 COL-42472|19-07-2007|GEZ

PROCEDURE PV_CNUM_CABECERA_ODBC (
                                 sNumTransaccion IN VARCHAR2,
                                 sNomTablaAbo    IN VARCHAR2,
                                 sNumAbonado     IN VARCHAR2,
                                 sNumCelular     IN VARCHAR2,
                                 sRegNue         IN VARCHAR2,
                                 sProvNUe        IN VARCHAR2,
                                 sCiudNue        IN VARCHAR2,
                                 sCeldNue        IN VARCHAR2,
                                 sCentNue        IN VARCHAR2,
                                 sUsoNue         IN VARCHAR2,
                                 sNumMinMdnNue   IN VARCHAR2,
                                 sIdUser         IN VARCHAR2,
                                 sCodProducto    IN VARCHAR2,
                                 sInsertaMov     IN VARCHAR2,
                                 sActualiAbo     IN VARCHAR2,
                                 sCod_Actabo     IN VARCHAR2
                                )
------------------------------------------------------------------------
--Cabecera o pl pricipal (ODBC) que es llamado para realizar la OOSS de
--cambio de número.
--Retorna los siguientes valores:
--0: Sin errores.
--1: Error al realizar la selección automática del número.
--2: Error durante la carga inicial de datos.
--3: Error al actualizar los datos del abonado.
--4: Error al insertar la modificación del abonado.
--5: Error al insertar en la tabla de números reutilizables.
--6: Error al ejecutar el proceso de cambio de central.
--7: Error al insertar el movimiento.
--8: Error al ejecutar el proceso de cambio de número.
--9: Error al ejecutar el proceso verificación de autenticación.
------------------------------------------------------------------------
IS
   sError      VARCHAR2(1);
   sGlosa      VARCHAR2(255);
   sOraGlosa   VARCHAR2(255);
   sNumMov     VARCHAR2(9);
BEGIN
   sError := '0';
   sGlosa := '';
   PV_CNUM_CABECERA_ADO(sNomTablaAbo, sNumAbonado, sNumCelular, sRegNue, sProvNUe, sCiudNue, sCeldNue, sCentNue, sUsoNue, sNumMinMdnNue, sIdUser,
                        sCodProducto, sInsertaMov, sActualiAbo, sCod_Actabo, sNumMov, sError, sGlosa, sOraGlosa);
   INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
   VALUES (
           sNumTransaccion, --NUM_TRANSACCION
           sError, --COD_RETORNO
           SUBSTR('/' || sNumMov || '/' || sGlosa || '/' || sOraGlosa,1,255)--DES_CADENA
          );
   EXCEPTION
   WHEN OTHERS THEN
      sOraGlosa := SUBSTR(SQLERRM,1,255);
      INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
      VALUES (
              sNumTransaccion, --NUM_TRANSACCION
              sError, --COD_RETORNO
              SUBSTR('/' || sGlosa || '/' || sOraGlosa,1,255)--DES_CADENA
             );
END PV_CNUM_CABECERA_ODBC;



PROCEDURE PV_CNUM_CABECERA_ADO (
                                sNomTablaAbo    IN VARCHAR2,
                                sNumAbonado     IN VARCHAR2,
                                sNumCelular     IN VARCHAR2,
                                sRegNue         IN VARCHAR2,
                                sProvNUe        IN VARCHAR2,
                                sCiudNue        IN VARCHAR2,
                                sCeldNue        IN VARCHAR2,
                                sCentNue        IN VARCHAR2,
                                sUsoNue         IN VARCHAR2,
                                sNumMinMdnNue   IN VARCHAR2,
                                sIdUser         IN VARCHAR2,
                                sCodProducto    IN VARCHAR2,
                                sInsertaMov     IN VARCHAR2,
                                sActualiAbo     IN VARCHAR2,
                                sCod_Actabo     IN VARCHAR2,
                                sNumMov        OUT NOCOPY VARCHAR2,
                                sError         OUT NOCOPY VARCHAR2,
                                sGlosa         OUT NOCOPY VARCHAR2,
                                sOraGlosa      OUT NOCOPY VARCHAR2
                               )
------------------------------------------------------------------------
--Cabecera o pl pricipal (ADO) que es llamado para realizar la OOSS de
--cambio de número.
--Retorna los siguientes valores:
--0: Sin errores.
--1: Error al realizar la selección automática del número.
--2: Error durante la carga inicial de datos.
--3: Error al actualizar los datos del abonado.
--4: Error al insertar la modificación del abonado.
--5: Error al insertar en la tabla de números reutilizables.
--6: Error al ejecutar el proceso de cambio de central.
--7: Error al insertar el movimiento.
--8: Error al ejecutar el proceso de cambio de número.
--9: Error al ejecutar el proceso verificación de autenticación.
------------------------------------------------------------------------
IS
   sNomTablaFrec      VARCHAR2(30);
   sSql               VARCHAR2(250);
   nExiste            NUMBER(1);
   nNumCelOrig        NUMBER(15);
   nNumCelular        NUMBER(15);
   sCelular           VARCHAR2(15);
   sRegOrig           VARCHAR2(3);
   sProvOrig          VARCHAR2(5);
   sCiudOrig          VARCHAR2(5);
   sCeldOrig          VARCHAR2(7);
   sCentOrig          VARCHAR2(3);
   sCodCentNue        VARCHAR2(3);
   nCodUsoOrig        NUMBER(2);
   nCodUsoOrig2       NUMBER(2);
   sCodUsoNue         NUMBER(2);
   sNumMinOrig        VARCHAR2(3);
   sNumMinNue         VARCHAR2(3);
   sNumMinMdnOrig     VARCHAR2(10);
   sNumMinMdnNvo      VARCHAR2(10);
   sCodSubalmOrig     VARCHAR2(5);
   sCodSubalmNue      VARCHAR2(5);
   nCodCatOrig        NUMBER(2);
   nCodCatNue         NUMBER(2);
   sCodCatNue         VARCHAR2(2);
   sFecBaja           DATE;
   sTipTermOrig       VARCHAR2(1);
   sCodTiplan         VARCHAR2(5);
   sClaseServicio     VARCHAR2(255);
   sTecnologia        VARCHAR2(7);
   sNumImei           VARCHAR2(20);
   sNumSerieHexOrig   VARCHAR2(8);
   sNumSerieOrig      VARCHAR2(25);
   sCodActabo         VARCHAR2(2);
   nNumAbonado        VARCHAR2(8);
   sNumCelOrig        VARCHAR2(15);
   sTabla             VARCHAR2(2);
   sProcequiOrig      VARCHAR2(1);
BEGIN
   sError := '0';
   sGlosa := '';
   sCodCentNue := sCentNue;
   sCodUsoNue := sUsoNue;
   sCelular := sNumCelular;
   sNumMov := '0';
   IF sNumCelular = '0' THEN
      PV_CNUM_CELNUM_AUTO_ADO (sCeldNue, sCodSubalmNue, sCodCentNue, sCod_Actabo, sCodUsoNue, sCelular,
                               sTabla, sCodCatNue, sFecBaja, sError, sGlosa, sOraGlosa);
      nCodCatNue := to_NUMBER(sCodCatNue);
   END IF;
   IF sError = '0' THEN
      PV_CNUM_CARGA_INICIAL (sNumAbonado, sNomTablaAbo, sCelular, nNumCelOrig, sRegOrig, sProvOrig, sCiudOrig, sCeldOrig,
                             sCentOrig, nCodUsoOrig, sNumMinOrig, sNumMinMdnOrig, sNumMinNue, sCodSubalmOrig, nCodCatOrig,
                             nCodUsoOrig2, sTipTermOrig, sCodTiplan, sTecnologia, sNumImei, sNumSerieHexOrig, sNumSerieOrig,
                             nNumAbonado, nNumCelular, sNumCelOrig, sCodActabo, sProcequiOrig, sClaseServicio,sError, sGlosa, sOraGlosa);
   END IF;
   IF sError = '0' THEN
      PV_CNUM_ACT_ABONADO (sRegNue, sProvnue, sCiudNue, sCeldNue, sCodCentNue, nNumCelular, nNumCelOrig, sCodUsoNue,
                           sNumMinNue, sNumMinMdnNue, nNumAbonado, sNomTablaAbo, sActualiAbo, sError, sGlosa, sOraGlosa);
   END IF;
   IF sError = '0' AND sActualiAbo = 'SI' THEN
      PV_CNUM_INS_MODABOCEL (nNumAbonado, sRegOrig, sRegNue, sProvOrig, sProvNue, sCiudOrig, sCiudNue, sCeldOrig,
                             sCeldNue, sCentOrig, sCodCentNue, nNumCelOrig, nNumCelular, nCodUsoOrig, sCodUsoNue,
                             sNumMinOrig, sNumMinNue, sNumMinMdnOrig, sNumMinMdnNue, sIdUser, sError, sGlosa, sOraGlosa);
   END IF;
   IF sError = '0' THEN
     --DBMS_OUTPUT.PUT_LINE(TO_CHAR(nNumCelOrig));
      PV_CNUM_INS_REUTIL (nNumCelOrig, sCodSubalmOrig, sCentOrig, nCodCatOrig, nCodUsoOrig, nCodUsoOrig2, sError, sGlosa, sOraGlosa);
   END IF;

   IF sError = '0' AND sCentOrig != sCodCentNue THEN
      PV_CNUM_EJEC_CAMBCEN (sNumAbonado, sTipTermOrig, sCodCentNue, sClaseServicio, sError, sGlosa, sOraGlosa);
   END IF;

   IF sError = '0' AND sInsertaMov = 'SI' THEN
      PV_CNUM_INS_MOVIMIENTO (sCodTiplan, nNumAbonado, sIdUser, sCentOrig, sCentNue, nNumCelOrig, nNumCelular, sNumSerieHexOrig,
                              sNumSerieOrig, sClaseServicio, sTipTermOrig, sNumMinOrig, sNumMinNue, sTecnologia, sNumImei,
                              sCodActabo, sNumMov, sError, sGlosa, sOraGlosa);
   END IF;
   IF sError = '0' THEN
      PV_CNUM_EJEC_CAMBIO_NUMERO (sCodActabo, sNumAbonado, sNumCelular, sNomTablaAbo, sError, sGlosa, sOraGlosa);
   END IF;
   IF sError = '0' THEN
      PV_CNUM_AUTENTICACION (sNumSerieOrig, sProcequiOrig, nCodUsoOrig, sError, sGlosa, sOraGlosa);
   END IF;
   EXCEPTION
   WHEN OTHERS THEN
      sOraGlosa := SUBSTR(SQLERRM,1,255);
END PV_CNUM_CABECERA_ADO;



PROCEDURE PV_CNUM_CELNUM_AUTO_ODBC (
                                    sNumTransaccion IN VARCHAR2,
                                    sCeldNue        IN VARCHAR2,
                                    sCentNue        IN VARCHAR2,
                                    sCodUsoNue      IN VARCHAR2,
                                    sCod_Actabo     IN VARCHAR2
                                   )
IS
   sCodSubalmNue  VARCHAR2(5);
   sNumCelular    VARCHAR2(15);
   sTabla         VARCHAR2(1);
   sCodCatNue     VARCHAR2(2);
   sFecBaja       VARCHAR2(30);
   sError         VARCHAR2(1);
   sGlosa         VARCHAR2(255);
   sOraGlosa      VARCHAR2(255);
   sCadena        VARCHAR2(255);
BEGIN
   sError := '0';
   sGlosa := '';
   PV_CNUM_CELNUM_AUTO_ADO (sCeldNue, sCentNue, sCodUsoNue, sCod_Actabo, sCodSubalmNue, sNumCelular, sTabla, sCodCatNue, sFecBaja,
                            sError, sGlosa, sOraGlosa);
   if sError = '0' then
      sCadena := '/'||sNumCelular||
                 '/'||sTabla||
                 '/'||sCodCatNue||
                 '/'||sFecBaja;
      INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
      VALUES (
              sNumTransaccion, --NUM_TRANSACCION
              '0', --COD_RETORNO
              sCadena  --DES_CADENA
             );
   else
      INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
      VALUES (
              sNumTransaccion, --NUM_TRANSACCION
              '1', --COD_RETORNO
              SUBSTR('/' || sGlosa || '/' || sOraGlosa,1,255) --DES_CADENA
             );
   end if;
   EXCEPTION
   WHEN OTHERS THEN
      sOraGlosa := SUBSTR(SQLERRM,1,255);
      INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
      VALUES (
              sNumTransaccion, --NUM_TRANSACCION
              '1', --COD_RETORNO
              SUBSTR('/' || sGlosa || '/' || sOraGlosa,1,255) --DES_CADENA
             );
END PV_CNUM_CELNUM_AUTO_ODBC;



PROCEDURE PV_CNUM_CELNUM_AUTO_ADO (
                                   sCeldNue       IN VARCHAR2,
                                   sCentNue       IN VARCHAR2,
                                   sCodUsoNue     IN VARCHAR2,
                                   sCod_Actabo    IN VARCHAR2,
                                   sCodSubalmNue OUT NOCOPY VARCHAR2,
                                   sNumCelular   OUT NOCOPY VARCHAR2,
                                   sTabla        OUT NOCOPY VARCHAR2,
                                   sCodCatNue    OUT NOCOPY VARCHAR2,
                                   sFecBaja      OUT NOCOPY VARCHAR2,
                                   sError        OUT NOCOPY VARCHAR2,
                                   sGlosa        OUT NOCOPY VARCHAR2,
                                   sOraGlosa     OUT NOCOPY VARCHAR2
                                  )
IS
   nNumTransaccion NUMBER(9);
   sNumTransaccion VARCHAR2(9);
   sNumAbonado VARCHAR2(8);
   sCadena VARCHAR2(255);
   sRet1 VARCHAR2(255);
   sRet2 VARCHAR2(255);
   sRet3 VARCHAR2(255);
   sRet4 VARCHAR2(255);
   sRet5 VARCHAR2(255);
   sRet6 VARCHAR2(255);
   sRet7 VARCHAR2(255);
   sRet8 VARCHAR2(255);
   sRet9 VARCHAR2(255);
BEGIN
   SELECT GA_SEQ_TRANSACABO.NEXTVAL INTO nNumTransaccion FROM DUAL;
   sNumTransaccion := TO_CHAR(nNumTransaccion);
   --
   --dbms_output.PUT_LINE('PASO 1' );
   SELECT COD_SUBALM INTO sCodSubalmNue FROM GE_CELDAS WHERE COD_CELDA=sCeldNue;
   --
   --dbms_output.PUT_LINE('PASO 2' );
   p_numeracion_automatica(sNumTransaccion, sCod_Actabo, sCodSubalmNue, sCentNue, sCodUsoNue);
   --
   --dbms_output.PUT_LINE('PASO 2.5' );

   SELECT TO_CHAR(COD_RETORNO), DES_CADENA INTO sError, sCadena
   FROM GA_TRANSACABO WHERE NUM_TRANSACCION = nNumTransaccion;
   --

   --dbms_output.PUT_LINE('PASO 3' );
   IF sError = '0' THEN
      PV_CNUM_RESCATA_CADENA (sCadena, '/', sRet1, sRet2, sRet3, sRet4, sRet5, sRet6, sRet7, sRet8, sRet9);
      sNumCelular := sRet2;
      sTabla      := sRet3;
      sCodCatNue  := sRet4;
      IF sRet5 IS NULL THEN
                 sFecBaja    := '';
          ELSE
                  sFecBaja    := sRet5;
          END IF;
      sError      := '0';
      sGlosa      := '';
      sOraGlosa   := '';
   ELSE
      sError    := '1';
      sGlosa := 'Error al cargar el nuevo número de celular.';
      sOraGlosa := '';
   END IF;
   --
   EXCEPTION
   WHEN OTHERS THEN
      sError    := '1';
      sGlosa    := 'Error al cargar el nuevo número de celular.';
      sOraGlosa := SUBSTR(SQLERRM,1,255);
END PV_CNUM_CELNUM_AUTO_ADO;



PROCEDURE PV_CNUM_CARGA_INICIAL (
                                 sNumAbonado       IN NUMBER,
                                 sNomTablaAbo      IN VARCHAR2,
                                 sNumCelular       IN NUMBER,
                                 nNumCelOrig      OUT NOCOPY NUMBER,
                                 sRegOrig         OUT NOCOPY VARCHAR2,
                                 sProvOrig        OUT NOCOPY VARCHAR2,
                                 sCiudOrig        OUT NOCOPY VARCHAR2,
                                 sCeldOrig        OUT NOCOPY VARCHAR2,
                                 sCentOrig        OUT NOCOPY VARCHAR2,
                                 nCodUsoOrig      OUT NOCOPY NUMBER,
                                 sNumMinOrig      OUT NOCOPY VARCHAR2,
                                 sNumMinMdnOrig   OUT NOCOPY VARCHAR2,
                                 sNumMinNue       OUT NOCOPY VARCHAR2,
                                 sCodSubalmOrig   OUT NOCOPY VARCHAR2,
                                 nCodCatOrig      OUT NOCOPY NUMBER,
                                 nCodUsoOrig2     OUT NOCOPY NUMBER,
                                 sTipTermOrig     OUT NOCOPY VARCHAR2,
                                 sCodTiplan       OUT NOCOPY VARCHAR2,
                                 sTecnologia      OUT NOCOPY VARCHAR2,
                                 sNumImei         OUT NOCOPY VARCHAR2,
                                 sNumSerieHexOrig OUT NOCOPY VARCHAR2,
                                 sNumSerieOrig    OUT NOCOPY VARCHAR2,
                                 nNumAbonado      OUT NOCOPY NUMBER,
                                 nNumCelular      OUT NOCOPY NUMBER,
                                 sNumCelOrig      OUT NOCOPY VARCHAR2,
                                 sCodActabo       OUT NOCOPY VARCHAR2,
                                 sProcequiOrig    OUT NOCOPY VARCHAR2,
                                 sClaseServicio   OUT NOCOPY VARCHAR2,
                                 sError        IN OUT NOCOPY VARCHAR2,
                                 sGlosa        IN OUT NOCOPY VARCHAR2,
                                 sOraGlosa     IN OUT NOCOPY VARCHAR2
                                )
IS
   sSql VARCHAR2(500);
   nExiste NUMBER;
   sCodPlan VARCHAR2(3);
BEGIN
   nNumAbonado := TO_NUMBER(sNumAbonado);
   nNumCelular := TO_NUMBER(sNumCelular);
   nNumCelOrig := TO_NUMBER(sNumCelOrig);
   --
   --sSql := 'SELECT COUNT(1) ';
   --sSql := sSql || 'FROM ' || sNomTablaAbo || ' ';
   --sSql := sSql || 'WHERE NUM_CELULAR = ' || sNumCelular;
   --EXECUTE IMMEDIATE sSql INTO nExiste;
   nExiste := 0;
   IF nExiste > 0 THEN
      sError := '2';
      sGlosa    := 'El número de celular ' || sNumCelular || ' ha sido reservado por otro usuario.';
      sOraGlosa := '';
   ELSE
      IF sNomTablaAbo = 'GA_ABOCEL' THEN
         SELECT NUM_CELULAR, COD_REGION, COD_PROVINCIA, COD_CIUDAD, COD_CELDA, COD_CENTRAL, COD_USO, NUM_MIN, NUM_MIN_MDN, TIP_TERMINAL, COD_TECNOLOGIA, NUM_IMEI, NUM_SERIEHEX, NUM_SERIE, IND_PROCEQUI, COD_PLANTARIF,PERFIL_ABONADO
         INTO nNumCelOrig, sRegOrig, sProvOrig, sCiudOrig, sCeldOrig, sCentOrig, nCodUsoOrig, sNumMinOrig, sNumMinMdnOrig, sTipTermOrig, sTecnologia, sNumImei, sNumSerieHexOrig, sNumSerieOrig, sProcequiOrig, sCodPlan,sClaseServicio
         FROM GA_ABOCEL
         WHERE NUM_ABONADO = nNumAbonado;
      ELSIF sNomTablaAbo = 'GA_ABOAMIST' THEN
         SELECT NUM_CELULAR, COD_REGION, COD_PROVINCIA, COD_CIUDAD, COD_CELDA, COD_CENTRAL, COD_USO, NUM_MIN, NUM_MIN_MDN, TIP_TERMINAL, COD_TECNOLOGIA, NUM_IMEI, NUM_SERIEHEX, NUM_SERIE, IND_PROCEQUI, COD_PLANTARIF,PERFIL_ABONADO
         INTO nNumCelOrig, sRegOrig, sProvOrig, sCiudOrig, sCeldOrig, sCentOrig, nCodUsoOrig, sNumMinOrig, sNumMinMdnOrig, sTipTermOrig, sTecnologia, sNumImei, sNumSerieHexOrig, sNumSerieOrig, sProcequiOrig, sCodPlan,sClaseServicio
         FROM GA_ABOAMIST
         WHERE NUM_ABONADO = nNumAbonado;
      ELSE
         sError := '2';
         sGlosa    := 'La tabla del abonado ' || sNomTablaAbo || ' es incorrecta.';
         sOraGlosa := '';
      END IF;
      --
      IF sError = '0' THEN
         --SELECT AL_FN_PREFIJO_NUMERO(sNumCelular) INTO sNumMinNue FROM DUAL;
         sNumMinNue:= AL_FN_PREFIJO_NUMERO(sNumCelular);
         --
         SELECT COD_SUBALM, COD_CAT, COD_USO
         INTO sCodSubalmOrig, nCodCatOrig, nCodUsoOrig2
         FROM GA_CELNUM_USO
         WHERE COD_PRODUCTO=1
           AND nNumCelOrig BETWEEN NUM_DESDE AND NUM_HASTA;
         --
         --sSql := 'SELECT COD_PLANTARIF FROM ' || sNomTablaAbo || ' ';
         --sSql := sSql || 'WHERE NUM_ABONADO = ' || nNumAbonado;
         --EXECUTE IMMEDIATE sSql INTO sCodPlan;
         --
         SELECT COD_TIPLAN INTO sCodTiplan
         FROM TA_PLANTARIF
         WHERE COD_PRODUCTO = 1 AND COD_PLANTARIF = sCodPlan;
         --
         SELECT DECODE(COUNT(1),0,'CN','1') INTO sCodActabo
         FROM PV_ACTABO_TIPLAN
         WHERE COD_TIPMODI = 'CN'
           AND COD_TIPLAN = sCodTiplan;
         IF sCodActabo = '1' THEN
            SELECT COD_ACTABO INTO sCodActabo
            FROM PV_ACTABO_TIPLAN
            WHERE COD_TIPMODI = 'CN'
              AND COD_TIPLAN = sCodTiplan;
         ELSE
            sError := '2';
            sGlosa    := 'Error al cargar los datos iniciales.';
            sOraGlosa := SUBSTR(SQLERRM,1,255);
         END IF;
      END IF;
   END IF;
   EXCEPTION
   WHEN OTHERS THEN
      sError := '2';
      sGlosa    := 'Error al cargar los datos iniciales.';
      sOraGlosa := SUBSTR(SQLERRM,1,255);
END PV_CNUM_CARGA_INICIAL;



PROCEDURE PV_CNUM_ACT_ABONADO (
                               sRegNue         IN VARCHAR2,
                               sProvnue        IN VARCHAR2,
                               sCiudNue        IN VARCHAR2,
                               sCeldNue        IN VARCHAR2,
                               sCenNue         IN VARCHAR2,
                               nNumCelular     IN NUMBER,
                               nNumCelOrig     IN NUMBER,
                               sCodUsoNue      IN VARCHAR2,
                               sNumMinNue      IN VARCHAR2,
                               sNumMinMdnNvo   IN VARCHAR2,
                               nNumAbonado     IN NUMBER,
                               sNomTablaAbo    IN VARCHAR2,
                               sActualiAbo     IN VARCHAR2,
                               sError      IN OUT NOCOPY VARCHAR2,
                               sGlosa      IN OUT NOCOPY VARCHAR2,
                               sOraGlosa   IN OUT NOCOPY VARCHAR2
                              )
IS
   nCenNue number;
   nCodUsoNue number;
   sNumCelAnt VARCHAR2(20);
   sNumCelNue VARCHAR2(20);
BEGIN
   nCenNue := to_number(sCenNue);
   nCodUsoNue := to_number(sCodUsoNue);
   sNumCelAnt := to_char(nNumCelOrig);
   sNumCelNue := to_char(nNumCelular);
   --dbms_output.put_line('('||sRegNue||')('||sProvnue||')('||sCiudNue||')('||sCeldNue||')('||sCenNue||')('||nNumCelular||')('||to_char(nNumCelOrig)||')('||sCodUsoNue||')('||sNumMinNue||')('||sNumMinMdnNvo||')('||to_char(nNumAbonado)||')('||sNomTablaAbo||')('||sActualiAbo||')');
   IF sActualiAbo = 'SI' THEN
      IF sNomTablaAbo = 'GA_ABOCEL' THEN
         UPDATE GA_ABOCEL
         SET  COD_SITUACION = 'CNP',
              FEC_ULTMOD = SYSDATE,
              COD_REGION =  sRegNue,
              COD_PROVINCIA = sProvnue,
              COD_CIUDAD = sCiudNue,
              COD_CELDA = sCeldNue,
              COD_CENTRAL = nCenNue,
              NUM_CELULAR = nNumCelular,
              COD_USO = nCodUsoNue,
              COD_CENTRAL_PLEX = NULL,
              NUM_CELULAR_PLEX = NULL,
              IND_PLEXSYS = 0,
              NUM_MIN = sNumMinNue,
              NUM_MIN_MDN = sNumMinMdnNvo
         WHERE NUM_ABONADO = nNumAbonado;
      ELSIF sNomTablaAbo = 'GA_ABOAMIST' THEN
         UPDATE GA_ABOAMIST
         SET  COD_SITUACION = 'CNP',
              FEC_ULTMOD = SYSDATE,
              COD_REGION =  sRegNue,
              COD_PROVINCIA = sProvnue,
              COD_CIUDAD = sCiudNue,
              COD_CELDA = sCeldNue,
              COD_CENTRAL = nCenNue,
              NUM_CELULAR = nNumCelular,
              COD_USO = nCodUsoNue,
              COD_CENTRAL_PLEX = NULL,
              NUM_CELULAR_PLEX = NULL,
              IND_PLEXSYS = 0,
              NUM_MIN = sNumMinNue,
              NUM_MIN_MDN = sNumMinMdnNvo
         WHERE NUM_ABONADO = nNumAbonado;
      ELSE
         sError := '3';
         sGlosa    := 'Error al actualizar los datos del abonado (1).';
         sOraGlosa := '';
      END IF;
   ELSIF sActualiAbo = 'NO' THEN
      IF sNomTablaAbo = 'GA_ABOCEL' THEN
         UPDATE GA_ABOCEL
         SET  FEC_ULTMOD = SYSDATE,
              COD_REGION =  sRegNue,
              COD_PROVINCIA = sProvnue,
              COD_CIUDAD = sCiudNue,
              COD_CELDA = sCeldNue,
              COD_CENTRAL = nCenNue,
              NUM_CELULAR = nNumCelular,
              COD_USO = nCodUsoNue,
              COD_CENTRAL_PLEX = NULL,
              NUM_CELULAR_PLEX = NULL,
              IND_PLEXSYS = 0,
              NUM_MIN = sNumMinNue,
              NUM_MIN_MDN = sNumMinMdnNvo
         WHERE NUM_ABONADO = nNumAbonado;
      ELSIF sNomTablaAbo = 'GA_ABOAMIST' THEN
         UPDATE GA_ABOAMIST
         SET  FEC_ULTMOD = SYSDATE,
              COD_REGION =  sRegNue,
              COD_PROVINCIA = sProvnue,
              COD_CIUDAD = sCiudNue,
              COD_CELDA = sCeldNue,
              COD_CENTRAL = nCenNue,
              NUM_CELULAR = nNumCelular,
              COD_USO = nCodUsoNue,
              COD_CENTRAL_PLEX = NULL,
              NUM_CELULAR_PLEX = NULL,
              IND_PLEXSYS = 0,
              NUM_MIN = sNumMinNue,
              NUM_MIN_MDN = sNumMinMdnNvo
         WHERE NUM_ABONADO = nNumAbonado;
      ELSE
         sError := '3';
         sGlosa    := 'Error al actualizar los datos del abonado (2).';
         sOraGlosa := '';
      END IF;
   ELSE
      sError := '3';
      sGlosa    := 'Error al actualizar los datos del abonado (3).';
      sOraGlosa := '';
   END IF;
   IF sError = '0' THEN
      UPDATE GA_SERVSUPLABO SET NUM_TERMINAL = nNumCelular
      WHERE NUM_ABONADO = nNumAbonado
        AND IND_ESTADO <> 4;

      --UPDATE GA_NUMESPABO
      --SET NUM_TELEFESP = nNumCelular
      --WHERE NUM_TELEFESP = nNumCelOrig;

      --UPDATE PPT_NUMEROFRECUENTE
      --SET NUM_FRECUENTE = nNumCelular
      --WHERE NUM_FRECUENTE = nNumCelOrig;

          --INI COL-42472|19-07-2007|GEZ
          /*
      UPDATE GA_NUMESPABO
      SET    NUM_TELEFESP = sNumCelNue
      WHERE  NUM_TELEFESP = sNumCelAnt;*/

          INSERT INTO GA_NUMESPABO
          (NUM_ABONADO, NUM_TELEFESP, NUM_DIASNUM, TIP_FRECUENTE)
          SELECT NUM_ABONADO, sNumCelNue, NUM_DIASNUM, TIP_FRECUENTE
          FROM   GA_NUMESPABO
          WHERE  NUM_TELEFESP = sNumCelAnt;

          DELETE GA_NUMESPABO
          WHERE  NUM_TELEFESP = sNumCelAnt;

          --FIN COL-42472|19-07-2007|GEZ

      UPDATE PPT_NUMEROFRECUENTE
      SET    NUM_FRECUENTE = sNumCelNue
      WHERE  NUM_FRECUENTE = sNumCelAnt;

   END IF;
   EXCEPTION
   WHEN OTHERS THEN
      sError := '3';
      sGlosa    := 'Error al actualizar los datos del abonado (4).';
      sOraGlosa := SUBSTR(SQLERRM,1,255);
END PV_CNUM_ACT_ABONADO;



PROCEDURE PV_CNUM_INS_MODABOCEL (
                                 sNumAbonado    IN VARCHAR2,
                                 sRegOrig       IN VARCHAR2,
                                 sRegNue        IN VARCHAR2,
                                 sProvOrig      IN VARCHAR2,
                                 sProvNue       IN VARCHAR2,
                                 sCiudOrig      IN VARCHAR2,
                                 sCiudNue       IN VARCHAR2,
                                 sCeldOrig      IN VARCHAR2,
                                 sCeldNue       IN VARCHAR2,
                                 sCentOrig      IN VARCHAR2,
                                 sCentNue       IN VARCHAR2,
                                 nNumCelOrig    IN NUMBER,
                                 nNumCelular    IN NUMBER,
                                 nCodUsoOrig    IN NUMBER,
                                 nCodUsoNue     IN NUMBER,
                                 sNumMinOrig    IN VARCHAR2,
                                 sNumMinNue     IN VARCHAR2,
                                 sNumMinMdnOrig IN VARCHAR2,
                                 sNumMinMdnNue  IN VARCHAR2,
                                 sIdUser        IN VARCHAR2,
                                 sError     IN OUT NOCOPY VARCHAR2,
                                 sGlosa     IN OUT NOCOPY VARCHAR2,
                                 sOraGlosa  IN OUT NOCOPY VARCHAR2
                                )
IS
BEGIN
   INSERT INTO GA_MODABOCEL (NUM_ABONADO, COD_TIPMODI, FEC_MODIFICA, NOM_USUARORA, COD_REGION, COD_PROVINCIA, COD_CIUDAD, COD_CELDA,
                             COD_CENTRAL, NUM_CELULAR, COD_USO, COD_CENTRAL_PLEX, NUM_CELULAR_PLEX, IND_PLEXSYS, NUM_MIN, NUM_MIN_MDN)
   VALUES (
           sNumAbonado, --NUM_ABONADO
           'CN', --COD_TIPMODI
           SYSDATE, --FEC_MODIFICA
           sIdUser, --NOM_USUARORA
           DECODE(sRegOrig, sRegNue, NULL, sRegOrig), --COD_REGION
           DECODE(sProvOrig, sProvNue, NULL, sProvOrig), --COD_PROVINCIA
           DECODE(sCiudOrig, sCiudNue, NULL, sCiudOrig), --COD_CIUDAD
           DECODE(sCeldOrig, sCeldNue, NULL, sCeldOrig), --COD_CELDA
           DECODE(sCentOrig, sCentNue, NULL, sCentOrig), --COD_CENTRAL
           DECODE(nNumCelOrig, nNumCelular, NULL, nNumCelOrig), --NUM_CELULAR
           DECODE(nCodUsoOrig, nCodUsoNue, NULL, nCodUsoOrig), --COD_USO
           NULL, --COD_CENTRAL_PLEX
           NULL, --NUM_CELULAR_PLEX
           NULL, --IND_PLEXSYS
           DECODE(sNumMinOrig, sNumMinNue, NULL, sNumMinOrig), --NUM_MIN
           DECODE(sNumMinMdnOrig, sNumMinMdnNue, NULL, sNumMinMdnOrig) --NUM_MIN_MDN
          );
   EXCEPTION
   WHEN OTHERS THEN
      sError := '1';
      sGlosa    := 'Error al insertar la modificación del abonado.';
      sOraGlosa := SUBSTR(SQLERRM,1,255);
END PV_CNUM_INS_MODABOCEL;



PROCEDURE PV_CNUM_INS_REUTIL (
                              nNumCelOrig     IN NUMBER,
                              sCodSubalmOrig  IN VARCHAR2,
                              sCentOrig       IN VARCHAR2,
                              nCodCatOrig     IN NUMBER,
                              nCodUsoOrig     IN NUMBER,
                              nCodUsoOrig2    IN NUMBER,
                              sError      IN OUT NOCOPY VARCHAR2,
                              sGlosa      IN OUT NOCOPY VARCHAR2,
                              sOraGlosa   IN OUT NOCOPY VARCHAR2
                             )
IS
BEGIN
   INSERT INTO GA_CELNUM_REUTIL (NUM_CELULAR, COD_SUBALM, COD_PRODUCTO, COD_CENTRAL, COD_CAT, COD_USO, FEC_BAJA, IND_EQUIPADO, USO_ANTERIOR)
   VALUES (
           nNumCelOrig, --NUM_CELULAR
           sCodSubalmOrig, --COD_SUBALM
           1, --COD_PRODUCTO
           sCentOrig, --COD_CENTRAL
           nCodCatOrig, --COD_CAT
           nCodUsoOrig, --COD_USO
           SYSDATE + 1, --FEC_BAJA
           1, --IND_EQUIPADO
           nCodUsoOrig2 --USO_ANTERIOR
          );
   EXCEPTION
   WHEN OTHERS THEN
      sError    := '5';
      sGlosa    := 'Error al insertar el número reutilizable.';
      sOraGlosa := SUBSTR(SQLERRM,1,255);
END PV_CNUM_INS_REUTIL;



PROCEDURE PV_CNUM_EJEC_CAMBCEN (
                                sNumAbonado     IN NUMBER,
                                sTipTermOrig    IN VARCHAR2,
                                sCodCentNue     IN VARCHAR2,
                                sClaseServicio OUT NOCOPY VARCHAR2,
                                sError      IN OUT NOCOPY VARCHAR2,
                                sGlosa      IN OUT NOCOPY VARCHAR2,
                                sOraGlosa   IN OUT NOCOPY VARCHAR2
                               )
IS
   nNumTransaccion NUMBER(9);
   sNumTransaccion VARCHAR2(9);
   sCadena VARCHAR2(255);
   sRet1 VARCHAR2(255);
   sRet2 VARCHAR2(255);
   sRet3 VARCHAR2(255);
   sRet4 VARCHAR2(255);
   sRet5 VARCHAR2(255);
   sRet6 VARCHAR2(255);
   sRet7 VARCHAR2(255);
   sRet8 VARCHAR2(255);
   sRet9 VARCHAR2(255);
BEGIN
   SELECT GA_SEQ_TRANSACABO.NEXTVAL INTO nNumTransaccion FROM DUAL;
   sNumTransaccion := TO_CHAR(nNumTransaccion);
   --
   P_CLOSERV_NUMERO(sNumTransaccion, '1', sNumAbonado, sTipTermOrig, sCodCentNue, '0');
   --
   SELECT TO_CHAR(COD_RETORNO), DES_CADENA INTO sError, sCadena
   FROM GA_TRANSACABO WHERE NUM_TRANSACCION = nNumTransaccion;
   --
   IF sError = '0' THEN
      PV_CNUM_RESCATA_CADENA (sCadena, '/', sRet1, sRet2, sRet3, sRet4, sRet5, sRet6, sRet7, sRet8, sRet9);
      sClaseServicio := sRet2;
   ELSE
      sError    := '6';
      sGlosa    := 'Error al ejecutar el cambio de central.';
      sOraGlosa := '';
   END IF;
   --
   EXCEPTION
   WHEN OTHERS THEN
      sError    := '6';
      sGlosa    := 'Error al ejecutar el cambio de central.';
      sOraGlosa := SUBSTR(SQLERRM,1,255);
END;



PROCEDURE PV_CNUM_INS_MOVIMIENTO (
                                  sCodTiplan        IN VARCHAR2,
                                  nNumAbonado       IN NUMBER,
                                  sIdUser           IN VARCHAR2,
                                  sCentOrig         IN VARCHAR2,
                                  sCentNue          IN VARCHAR2,
                                  nNumCelOrig       IN NUMBER,
                                  nNumCelular       IN NUMBER,
                                  sNumSerieHexOrig  IN VARCHAR2,
                                  sNumSerieOrig     IN VARCHAR2,
                                  sClaseServicio    IN VARCHAR2,
                                  sTipTermOrig      IN VARCHAR2,
                                  sNumMinOrig       IN VARCHAR2,
                                  sNumMinNue        IN VARCHAR2,
                                  sTecnologia       IN VARCHAR2,
                                  sNumImei          IN VARCHAR2,
                                  sCodActabo        IN VARCHAR2,
                                  sNumMov          OUT NOCOPY VARCHAR2,
                                  sError        IN OUT NOCOPY VARCHAR2,
                                  sGlosa        IN OUT NOCOPY VARCHAR2,
                                  sOraGlosa     IN OUT NOCOPY VARCHAR2
                                 )
IS
   nNumMov NUMBER(9);
   sClase VARCHAR2(255);
   nCodActcen NUMBER(5);
BEGIN
   SELECT COD_ACTCEN INTO nCodActcen
   FROM GA_ACTABO
   WHERE COD_PRODUCTO = 1
     AND COD_ACTABO = sCodActabo
     AND COD_TECNOLOGIA = sTecnologia;
   --
   SELECT ICC_SEQ_NUMMOV.NEXTVAL INTO nNumMov FROM DUAL;
    --
   INSERT INTO ICC_MOVIMIENTO (NUM_MOVIMIENTO, NUM_ABONADO, COD_ESTADO, COD_MODULO, NOM_USUARORA, COD_CENTRAL, COD_CENTRAL_NUE,
                               NUM_CELULAR, NUM_CELULAR_NUE, COD_ACTUACION, FEC_INGRESO, NUM_SERIE, COD_SERVICIOS, TIP_TERMINAL,
                               COD_ACTABO, NUM_MIN, NUM_MIN_NUE, TIP_TECNOLOGIA, IMSI, IMEI, ICC)
   VALUES (
           nNumMov, --NUM_MOVIMIENTO
           nNumAbonado, --NUM_ABONADO
           1, --COD_ESTADO
           'GA', --COD_MODULO
           sIdUser, --NOM_USUARORA
           sCentOrig, --COD_CENTRAL
           sCentNue, --COD_CENTRAL
           nNumCelOrig, --NUM_CELULAR
           nNumCelular, --NUM_CELULAR_NUE
           nCodActcen, --COD_ACTUACION
           SYSDATE, --FEC_INGRESO
           sNumSerieHexOrig, --NUM_SERIE
           sClaseServicio, --COD_SERVICIOS
           sTipTermOrig, --TIP_TERMINAL
           sCodActabo, --COD_ACTABO
           sNumMinOrig, --NUM_MIN
           sNumMinNue, --NUM_MIN_NUE
           sTecnologia, --TIP_TECNOLOGIA
           DECODE(sTecnologia, 'GSM', FN_RECUPERA_IMSI(sNumSerieOrig), NULL), --IMSI
           DECODE(sTecnologia, 'GSM', sNumImei, NULL), --IMEI
           DECODE(sTecnologia, 'GSM', sNumSerieOrig, NULL) --ICC
          );
   sNumMov := to_char(nNumMov);
   --
   EXCEPTION
   WHEN OTHERS THEN
      sError := '7';
      sGlosa    := 'Error al insertar el movimiento.';
      sOraGlosa := SUBSTR(SQLERRM,1,255);
END PV_CNUM_INS_MOVIMIENTO;



PROCEDURE PV_CNUM_EJEC_CAMBIO_NUMERO (
                                      sCodActabo     IN VARCHAR2,
                                      sNumAbonado    IN VARCHAR2,
                                      sNumCelular    IN VARCHAR2,
                                      sNomTablaAbo   IN VARCHAR2,
                                      sError     IN OUT NOCOPY VARCHAR2,
                                      sGlosa     IN OUT NOCOPY VARCHAR2,
                                      sOraGlosa  IN OUT NOCOPY VARCHAR2
                                     )
IS
   V_PRODUCTO GE_PRODUCTOS.COD_PRODUCTO%TYPE;
   V_ABONADO GA_ABOCEL.NUM_ABONADO%TYPE;
   V_ERROR VARCHAR2(1);
   V_FECSYS DATE;
   VP_TABLA VARCHAR2(50);
   VP_ACT VARCHAR2(1);
   V_CLIENTE GA_ABOCEL.COD_CLIENTE%TYPE;
   V_CLIENEW GA_ABOCEL.COD_CLIENTE%TYPE;
   V_PLEXSYS GA_ABOCEL.IND_PLEXSYS%TYPE;
   V_LIMCONSUMO GA_ABOCEL.COD_LIMCONSUMO%TYPE;
   V_IMPLICONS TA_LIMCONSUMO.IMP_LIMCONSUMO%TYPE;
   V_CELDA GA_ABOCEL.COD_CELDA%TYPE;
   V_TIPPLANTARIF GA_ABOCEL.TIP_PLANTARIF%TYPE;
   V_PLANTARIF GA_ABOCEL.COD_PLANTARIF%TYPE;
   V_SERIE GA_ABOCEL.NUM_SERIEHEX%TYPE;
   V_CELULAR GA_ABOCEL.NUM_CELULAR%TYPE;
   V_CELULAR_PLEX GA_ABOCEL.NUM_CELULAR_PLEX%TYPE;
   V_CARGOBASICO GA_ABOCEL.COD_CARGOBASICO%TYPE;
   V_CICLO GA_ABOCEL.COD_CICLO%TYPE;
   V_PLANSERV GA_ABOCEL.COD_PLANSERV%TYPE;
   V_GRPSERV GA_ABOCEL.COD_GRPSERV%TYPE;
   V_EMPRESA GA_ABOCEL.COD_EMPRESA%TYPE;
   V_HOLDING GA_ABOCEL.COD_HOLDING%TYPE;
   V_PORTADOR GA_ABOCEL.COD_CARRIER%TYPE;
   V_PROCALTA GA_ABOCEL.IND_PROCALTA%TYPE;
   V_AGENTE GA_ABOCEL.COD_VENDEDOR_AGENTE%TYPE;
   V_SUPERTEL GA_ABOCEL.IND_SUPERTEL%TYPE;
   V_TELEFIJA GA_ABOCEL.NUM_TELEFIJA%TYPE;
   V_FECALTA GA_ABOCEL.FEC_ACTCEN%TYPE;
   V_VENTA GA_ABOCEL.NUM_VENTA%TYPE;
   V_INDFACT GA_ABOCEL.IND_FACTUR%TYPE;
   V_FINCONTRA GA_ABOCEL.FEC_FINCONTRA%TYPE;
   V_OPREDFIJA GA_ABOCEL.COD_OPREDFIJA%TYPE;
   V_BAJACEN GA_ABOCEL.FEC_BAJACEN%TYPE;
   V_BAJA GA_ABOCEL.FEC_BAJACEN%TYPE;
   V_CREDMOR GA_ABOCEL.COD_CREDMOR%TYPE;
   V_USUARIO GA_ABOCEL.COD_USUARIO%TYPE;
   V_ORIGEN NUMBER(1);
   VP_PROC VARCHAR2(255);
   VP_SQLCODE VARCHAR2(15);
   VP_SQLERRM VARCHAR2(255);
   ERROR_INICIO EXCEPTION;
   ERROR_PROCESO EXCEPTION;
BEGIN
   IF sNomTablaAbo = 'GA_ABOCEL' THEN
      V_ORIGEN := 0;
   ELSIF sNomTablaAbo = 'GA_ABOAMIST' THEN
      V_ORIGEN := 3;
   ELSE
      RAISE ERROR_INICIO;
   END IF;
   --
   V_ERROR := '0';
   V_PRODUCTO := 1;
   V_ABONADO := TO_NUMBER(sNumAbonado);
   --SELECT SYSDATE INTO V_FECSYS FROM DUAL;
   V_FECSYS:= SYSDATE;
   VP_PROC := 'PV_CNUM_EJEC_CAMBIO_NUMERO';
   --
   P_Datos_Abocel(V_ABONADO, V_CLIENTE, V_PLEXSYS, V_IMPLICONS, V_CELDA, V_TIPPLANTARIF, V_PLANTARIF, V_SERIE,
                  V_CELULAR, V_CELULAR_PLEX, V_CARGOBASICO, V_CICLO, V_PLANSERV,V_GRPSERV,V_EMPRESA,V_HOLDING,
                  V_PORTADOR, V_PROCALTA, V_AGENTE, V_SUPERTEL, V_TELEFIJA, V_FECALTA, V_VENTA, V_INDFACT,
                  V_FINCONTRA, V_BAJACEN, V_BAJA, V_CREDMOR, V_USUARIO, V_OPREDFIJA, VP_PROC, VP_TABLA, VP_ACT,
                  VP_SQLCODE, VP_SQLERRM,V_ERROR);
   --
   IF V_ERROR <> '0' THEN
      V_ERROR := '8';
      RAISE ERROR_PROCESO;
   END IF;
   VP_PROC := 'PV_CNUM_EJEC_CAMBIO_NUMERO';
   IF V_ORIGEN = 0 THEN /* Cambio numero del home */
      P_Primer_Numero (V_PRODUCTO, V_CLIENTE, V_ABONADO, sNumCelular, V_CICLO, V_CELDA, V_FECSYS, VP_PROC, VP_TABLA, VP_ACT,
                       VP_SQLCODE, VP_SQLERRM, V_ERROR);
      IF V_ERROR <> '0' THEN
         V_ERROR := '8';
         RAISE ERROR_PROCESO;
      END IF;
      VP_PROC := 'PV_CNUM_EJEC_CAMBIO_NUMERO';
   ELSIF V_ORIGEN = 1 THEN /* Cambio del segundo numero */
      P_Segundo_Numero (V_CLIENTE, V_ABONADO, V_CELULAR_PLEX, V_CICLO, V_CELDA, V_FECSYS, VP_PROC, VP_TABLA, VP_ACT,
                        VP_SQLCODE, VP_SQLERRM, V_ERROR);
      IF V_ERROR <> '0' THEN
         V_ERROR := '8';
         RAISE ERROR_PROCESO;
      END IF;
      VP_PROC := 'PV_CNUM_EJEC_CAMBIO_NUMERO';
   ELSIF V_ORIGEN = 2 THEN /* Cambio de las dos numeraciones */
      P_Primer_Numero (V_PRODUCTO, V_CLIENTE, V_ABONADO, sNumCelular, V_CICLO, V_CELDA, V_FECSYS, VP_PROC, VP_TABLA, VP_ACT,
                       VP_SQLCODE, VP_SQLERRM, V_ERROR);
      IF V_ERROR <> '0' THEN
         V_ERROR := '8';
         RAISE ERROR_PROCESO;
      END IF;
      VP_PROC := 'PV_CNUM_EJEC_CAMBIO_NUMERO';
      P_Segundo_Numero (V_CLIENTE, V_ABONADO, V_CELULAR_PLEX, V_CICLO, V_CELDA, V_FECSYS, VP_PROC, VP_TABLA, VP_ACT,
                        VP_SQLCODE, VP_SQLERRM, V_ERROR);
      IF V_ERROR <> '0' THEN
         V_ERROR := '8';
         RAISE ERROR_PROCESO;
      END IF;
      VP_PROC := 'PV_CNUM_EJEC_CAMBIO_NUMERO';
   ELSIF V_ORIGEN = 3 THEN /* Cambio numero del home Prepago */
      P_Tercer_Numero (V_PRODUCTO, V_CLIENTE, V_ABONADO, sNumCelular, V_CICLO, V_CELDA, V_FECSYS, VP_PROC, VP_TABLA, VP_ACT,
                       VP_SQLCODE, VP_SQLERRM, V_ERROR);
      IF V_ERROR <> '0' THEN
         V_ERROR := '8';
         RAISE ERROR_PROCESO;
      END IF;
      VP_PROC := 'PV_CNUM_EJEC_CAMBIO_NUMERO';
   END IF;
   --
   EXCEPTION
   WHEN ERROR_INICIO THEN
      sError     := '8';
      sGlosa     := 'Error al ejecutar el proceso de cambio de número.';
      sOraGlosa  := '';
   WHEN ERROR_PROCESO THEN
      INSERT INTO GA_ERRORES (COD_PRODUCTO, COD_ACTABO, CODIGO, FEC_ERROR, NOM_PROC, NOM_TABLA, COD_ACT, COD_SQLCODE, COD_SQLERRM)
      VALUES (
              V_PRODUCTO,
              sCodActabo,
              V_ABONADO,
              V_FECSYS,
              VP_PROC,
              VP_TABLA,
              VP_ACT,
              VP_SQLCODE,
              SUBSTR(VP_SQLERRM,1,60)
             );
      sError     := '8';
      sGlosa     := 'Error al ejecutar el proceso de cambio de número.';
      sOraGlosa  := '';
   WHEN OTHERS THEN
      sError     := '8';
      sGlosa     := 'Error al ejecutar el proceso de cambio de número.';
      sOraGlosa  := SUBSTR(SQLERRM,1,255);
END PV_CNUM_EJEC_CAMBIO_NUMERO;



PROCEDURE PV_CNUM_AUTENTICACION (
                                 sNumSerieOrig   IN VARCHAR2,
                                 sProcequiOrig   IN VARCHAR2,
                                 nCodUsoOrig     IN NUMBER,
                                 sError      IN OUT NOCOPY VARCHAR2,
                                 sGlosa      IN OUT NOCOPY VARCHAR2,
                                 sOraGlosa   IN OUT NOCOPY VARCHAR2
                                )
IS
   v_actuacion VARCHAR2(2);
   nNumTransaccion NUMBER(9);
   sCadena VARCHAR2(255);
   sRet1 VARCHAR2(255);
   sRet2 VARCHAR2(255);
   sRet3 VARCHAR2(255);
   sRet4 VARCHAR2(255);
   sRet5 VARCHAR2(255);
   sRet6 VARCHAR2(255);
   sRet7 VARCHAR2(255);
   sRet8 VARCHAR2(255);
   sRet9 VARCHAR2(255);
BEGIN
   SELECT GA_SEQ_TRANSACABO.NEXTVAL INTO nNumTransaccion FROM DUAL;
   --
   PV_CNUM_VALAUTENT (nNumTransaccion, sNumSerieOrig, sProcequiOrig, nCodUsoOrig);
   --
   SELECT TO_CHAR(COUNT(1)) INTO sError
   FROM GA_TRANSACABO WHERE NUM_TRANSACCION = nNumTransaccion;
   IF sError != '0' THEN
      SELECT TO_CHAR(COD_RETORNO), DES_CADENA INTO sError, sCadena
      FROM GA_TRANSACABO WHERE NUM_TRANSACCION = nNumTransaccion;
   END IF;
   --
   IF sError = '0' THEN
      sError      := '0';
      sGlosa      := '';
      sOraGlosa   := '';
   ELSE
      sError    := '9';
      sGlosa := 'Error al ejecutar el proceso verificación de autenticación.';
      sOraGlosa := '';
   END IF;
   --
   EXCEPTION
   WHEN OTHERS THEN
      sError     := '9';
      sGlosa     := 'Error al ejecutar el proceso verificación de autenticación.';
      sOraGlosa  := SUBSTR(SQLERRM,1,255);
END PV_CNUM_AUTENTICACION;



PROCEDURE PV_CNUM_VALAUTENT (
                             v_secuencia      IN  ga_transacabo.NUM_TRANSACCION%type,
                             v_numserie       IN  VARCHAR2,
                             v_procedencia    IN  VARCHAR2,
                             v_coduso         IN  ga_abocel.COD_USO%TYPE
                            )
IS

-- CLON DE PV_VALIDA_AUTENTICACION_PR SIN COMMIT
-- Procedimiento que  valida la autenticacion de posvetna, en las distintas operadoras.
-- Creación     : 09-septiembre de 2002
-- Modificación :
-- Autor        : Karem Fernandez Ayala


v_contakeys          NUMBER;
v_contservsupl       NUMBER;
v_cod_operadora      ge_operadora_scl.cod_operadora_scl%type;

v_cod_retorno        ga_transacabo.cod_retorno%type;
v_des_cadena         ga_transacabo.des_cadena%type;
v_cod_uso            ga_abocel.cod_uso%type;
v_ind_usoventa       al_usos.ind_usoventa%type;
v_cod_estado         ict_akeys.cod_estado%type;
v_num_abonado        ga_abocel.num_abonado%type;
v_cod_servsupl       ga_servsupl.cod_servsupl%type;
v_cod_servicio       ga_servsupl.cod_servicio%type;
v_cod_sqlcode        ga_errores.cod_sqlcode%type;
v_cod_sqlerrm        ga_errores.cod_sqlerrm%type;
v_val_parametro      ged_parametros.VAL_PARAMETRO%type;

c_retorno0           CONSTANT ga_transacabo.cod_retorno%type := 0; /*  Continua con la PosVenta en MPR-TMC*/
c_retorno1           CONSTANT ga_transacabo.cod_retorno%type := 1; /*  No continua la operacion en Posventa-MPR */
c_retorno2           CONSTANT ga_transacabo.cod_retorno%type := 2; /*  TMC=Inserta Akeys con estado -1 / Act-Des Servicio Suplementario'*/
c_retorno3           CONSTANT ga_transacabo.cod_retorno%type := 3; /*  TMC=Actualiza Akeys en estado 1 / Act-Des Servicio Suplementario'*/
c_retorno4           CONSTANT ga_transacabo.cod_retorno%type := 4; /*  Error Others - No Data Found -- etc */
c_retorno5           CONSTANT ga_transacabo.cod_retorno%type := 5; /*  TMC='Act-Des Servicio Suplementario'*/

BEGIN

         /* Obtenemos operadora */

          v_cod_retorno := c_retorno0;
          v_des_cadena  := 'Obteniendo Código de Operadora';

                  BEGIN
                          SELECT VAL_PARAMETRO
                            INTO  v_val_parametro
                            FROM  GED_PARAMETROS
                           WHERE NOM_PARAMETRO = 'OPER_AUTENTICACION'
                             AND COD_MODULO = 'GA'
                                 AND COD_PRODUCTO = 1;
                  EXCEPTION
                   WHEN NO_DATA_FOUND THEN
                                v_val_parametro := 0;
                  END;


          --SELECT ge_fn_operadora_scl
          --INTO   v_cod_operadora
          --FROM   DUAL;

          v_cod_operadora :=  ge_fn_operadora_scl;

                  IF v_val_parametro <> 1 then
             v_cod_operadora:= '';
                  end if;

          /* Operadora de Puerto Rico */
          /*------------------------------------------------------------------------------------*/
          IF v_cod_operadora = 'MPR' THEN

             v_cod_retorno := c_retorno4;
             v_des_cadena  := 'Buscando Akeys del número de serie';

             BEGIN
                SELECT  cod_estado
                  INTO    v_cod_estado
                  FROM    ict_akeys
                  WHERE   num_esn = v_numserie;

             EXCEPTION
                 WHEN NO_DATA_FOUND THEN
                      v_cod_retorno := c_retorno1;  -- No continua la operacion en MPR
                      v_des_cadena  := 'No tiene autenticación el número de serie';
             END;

             IF (v_cod_estado is not null) THEN
                    v_cod_retorno := c_retorno0;  -- Continua operación en MPR
                    v_des_cadena  := 'Continua operación en Posventa';
             END IF;

             INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
             VALUES                    (v_secuencia, v_cod_retorno, v_des_cadena);

             --COMMIT;


          END IF;


          /* Operadora de Chile */
          /*-------------------------------------------------------------------------------------*/
          IF v_cod_operadora = 'TMC' and v_procedencia = 'I' THEN

             v_cod_retorno := c_retorno4;
             v_des_cadena  := 'Asignando Uso del Abonado';


             v_cod_uso:= v_coduso;

             v_cod_retorno := c_retorno4;
             v_des_cadena  := 'Buscando indicador de uso de venta';

             SELECT  ind_usoventa
               INTO  v_ind_usoventa
               FROM  al_usos
                          WHERE  cod_uso = v_cod_uso;


             IF v_ind_usoventa != 1 THEN

                v_cod_retorno := c_retorno0; -- Indica que según el uso continua la autenticacion (Si es <> 1 no debe validar nada)
                v_des_cadena  := 'Continua operación en Posventa';

             END IF;


             IF v_ind_usoventa = 1 THEN /*Equipo habilitados para autenticar*/

                v_cod_retorno := c_retorno4;
                v_des_cadena  := 'Buscando Código Estado en Tabla Akeys';

                BEGIN
                    SELECT  cod_estado
                    INTO    v_cod_estado
                    FROM    ict_akeys
                    WHERE   num_esn = v_numserie;

                EXCEPTION
                    WHEN NO_DATA_FOUND THEN
                             IF v_procedencia = 'I' THEN
                                v_cod_retorno := c_retorno2; -- Inserta Akeys en la tabla
                                v_des_cadena  := 'Inserta Akeys con estado -1 / Act-Des Servicio Suplementario';
                             END IF;
                END;


                IF (v_cod_estado = 2) or (v_cod_estado = 0) or (v_cod_estado = 1) THEN
                       v_cod_retorno := c_retorno3; -- 'Actualiza Akeys en estado 1 / Act-Des Servicio Suplementario'
                       v_des_cadena  := 'Actualiza Akeys en estado 1 / Act-Des Servicio Suplementario';
                END IF;

                IF (v_cod_estado = -1) THEN
                       v_cod_retorno := c_retorno5; -- / Act-Des Servicio Suplementario
                       v_des_cadena  := 'Act-Des Servicio Suplementario';
                END IF;

             END IF;

             INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
             VALUES                    (v_secuencia, v_cod_retorno, v_des_cadena);

             --COMMIT;


         END IF;

         IF v_cod_operadora = 'TMC' and v_procedencia = 'E' THEN

                        v_cod_retorno := c_retorno0; -- Indica que según el uso continua la autenticacion (Si es <> 1 no debe validar nada)
            v_des_cadena  := 'Continua operación en Posventa';

                INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
                VALUES                    (v_secuencia, v_cod_retorno, v_des_cadena);

                    --COMMIT;

         END IF;


EXCEPTION

      WHEN OTHERS THEN

           INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
           VALUES                                    (v_secuencia    , v_cod_retorno, v_des_cadena);

           v_cod_sqlcode := SQLCODE;
           v_cod_sqlerrm := SQLERRM;

           INSERT INTO GA_ERRORES
           (COD_ACTABO,CODIGO,FEC_ERROR,COD_PRODUCTO,NOM_PROC,NOM_TABLA,COD_ACT,COD_SQLCODE,COD_SQLERRM)
           VALUES
           ('AA', v_secuencia, SYSDATE, 1, 'PV_VALIDA_AUTENTICACION_PR', 'Null', 'N', v_cod_sqlcode, v_cod_sqlerrm);

           --COMMIT;

END;



PROCEDURE PV_CNUM_RESCATA_CADENA (
                                  sCadena in varchar2,
                                  sSeparador in varchar2,
                                  s1 out NOCOPY varchar2,
                                  s2 out NOCOPY varchar2,
                                  s3 out NOCOPY varchar2,
                                  s4 out NOCOPY varchar2,
                                  s5 out NOCOPY varchar2,
                                  s6 out NOCOPY varchar2,
                                  s7 out NOCOPY varchar2,
                                  s8 out NOCOPY varchar2,
                                  s9 out NOCOPY varchar2
                                 )
is
   sCadAux varchar2(255);
   nInd number(10);
begin
   sCadAux := sCadena || sSeparador;
   s1 := '';
   s2 := '';
   s3 := '';
   s4 := '';
   s5 := '';
   s6 := '';
   s7 := '';
   s8 := '';
   s9 := '';
   nInd := 1;
   while length(sCadAux) > 0 loop
      if nInd = 1 then
         s1 := substr(sCadAux,1,instr(sCadAux, sSeparador)-1);
      elsif nInd = 2 then
         s2 := substr(sCadAux,1,instr(sCadAux, sSeparador)-1);
      elsif nInd = 3 then
         s3 := substr(sCadAux,1,instr(sCadAux, sSeparador)-1);
      elsif nInd = 4 then
         s4 := substr(sCadAux,1,instr(sCadAux, sSeparador)-1);
      elsif nInd = 5 then
         s5 := substr(sCadAux,1,instr(sCadAux, sSeparador)-1);
      elsif nInd = 6 then
         s6 := substr(sCadAux,1,instr(sCadAux, sSeparador)-1);
      elsif nInd = 7 then
         s7 := substr(sCadAux,1,instr(sCadAux, sSeparador)-1);
      elsif nInd = 8 then
         s8 := substr(sCadAux,1,instr(sCadAux, sSeparador)-1);
      elsif nInd = 9 then
         s9 := substr(sCadAux,1,instr(sCadAux, sSeparador)-1);
      end if;
      sCadAux := substr(sCadAux, instr(sCadAux, sSeparador)+1);
      nInd := nInd + 1;
   end loop;
END PV_CNUM_RESCATA_CADENA;

END PV_CamNum_PG;
/
SHOW ERRORS
