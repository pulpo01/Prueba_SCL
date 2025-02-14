CREATE OR REPLACE PACKAGE BODY PV_ACTIVADESACTIVASS_PG AS


PROCEDURE PV_INICIOSS_PR (
                          EV_NUMABONADO       IN  VARCHAR2, -- Numero de Abonado
                          EV_NUMCELULAROLD    IN  VARCHAR2, -- Celular Viejo
                          EV_NUMCELULARNEW    IN  VARCHAR2, -- Celular Nuevo
                          EV_CODACTABO        IN  VARCHAR2, -- ACTUACION
                          EV_CODOOSS          IN  VARCHAR2, -- Codigo OOSS
                          EV_CLASEACT         IN  VARCHAR2, -- SS ACTIVAR
                          EV_CLASEDES         IN  VARCHAR2, -- SS DESACTIVAR
                          EV_SUMACARGOS       IN  VARCHAR2, -- Valor de Cargos
                          EV_SALDOABO         IN  VARCHAR2, -- Saldo Abonado (Prepago)
                          EV_USUARIO          IN  VARCHAR2, -- Usuario
                          EV_BDATOS           IN  VARCHAR2, -- Base de Datos
                          EV_CODMODULO        IN  VARCHAR2, -- por GC
                          EV_NUMTAREA         IN  VARCHAR2, -- por GC
                          EV_INDFLAG          IN  VARCHAR2, -- FLAG DE INSERCION (1=SI, 0=NO)
                          EV_FECEJEC          IN  VARCHAR2, -- FECHA DE EJECUCION DEL SS
                          EV_FECPROG          IN  VARCHAR2, -- FECHA DE PROGRAMACION DEL SS
                          SV_NUMOOSS          OUT VARCHAR2, -- OOSS cuando SS es Activado
                          SV_CODERROR         OUT VARCHAR2,
                          SV_MENERROR         OUT VARCHAR2,
                          SV_ORAERROR         OUT VARCHAR2
                         )
IS
   VN_NUMTRANSAC	  GE_CARGOS.NUM_TRANSACCION%TYPE;
   VV_NOMTABLA		  VARCHAR2(50);
   VV_NOMTABLAABO	  VARCHAR2(12);
   VN_CODCLIENTE	  GA_ABOCEL.COD_CLIENTE%TYPE;
   VN_NUMCELULAR	  GA_ABOCEL.NUM_CELULAR%TYPE;
   VV_CODPLANSERV	  GA_ABOCEL.COD_PLANSERV%TYPE;
   VN_CODPRODUCTO     GA_ABOCEL.COD_PRODUCTO%TYPE;
   VN_CODCUENTA	      GA_ABOCEL.COD_CUENTA%TYPE;
   VN_NUMOOSS         PV_IORSERV.NUM_OS%TYPE;
   VV_CLASEACT		  PV_CAMCOM.CLASE_SERVICIO_ACT%TYPE;
   VV_CLASEDES		  PV_CAMCOM.CLASE_SERVICIO_ACT%TYPE;
   VV_APLICASALDO	  GED_PARAMETROS.VAL_PARAMETRO%TYPE;
   VN_DIASPROG		  NUMBER;
   EN_NUMABONADO	  GA_ABOCEL.NUM_ABONADO%TYPE;
   EN_NUMCELULAROLD   GA_ABOCEL.NUM_CELULAR%TYPE;
   EN_NUMCELULARNEW   GA_ABOCEL.NUM_CELULAR%TYPE;
   VV_FECPROG         VARCHAR2(255);
   FIN EXCEPTION;
BEGIN
   SV_CODERROR:='0';
   SV_MENERROR:='0';
   SV_ORAERROR:='0';
   --
   SELECT DECODE(EV_FECPROG,'0',NULL,EV_FECPROG) INTO VV_FECPROG FROM DUAL;
   --
   EN_NUMABONADO    := TO_NUMBER(EV_NUMABONADO);    -- Numero de Abonado
   EN_NUMCELULAROLD := TO_NUMBER(EV_NUMCELULAROLD);	-- Celular CDMA
   EN_NUMCELULARNEW := TO_NUMBER(EV_NUMCELULARNEW);	-- Celular GSM
   --
   -- OBTENEMOS NRO.TRANSACCION
   SELECT GA_SEQ_TRANSACABO.NEXTVAL
   INTO   VN_NUMTRANSAC
   FROM   DUAL;
   --
   -- OBTENEMOS INFORMACION DEL ABONADO
   BEGIN
      VV_NOMTABLAABO   := 'GA_ABOCEL' ;
      SELECT COD_CLIENTE,COD_PLANSERV,COD_PRODUCTO,COD_CUENTA
      INTO VN_CODCLIENTE,VV_CODPLANSERV,VN_CODPRODUCTO,VN_CODCUENTA
      FROM GA_ABOCEL
      WHERE  NUM_ABONADO = EN_NUMABONADO;
      EXCEPTION
	  WHEN NO_DATA_FOUND THEN
         BEGIN
            VV_NOMTABLAABO:='GA_ABOAMIST';
            SELECT COD_CLIENTE,COD_PLANSERV,COD_PRODUCTO,COD_CUENTA
            INTO VN_CODCLIENTE,VV_CODPLANSERV,VN_CODPRODUCTO,VN_CODCUENTA
            FROM   GA_ABOAMIST
            WHERE  NUM_ABONADO = EN_NUMABONADO;
            EXCEPTION
            WHEN OTHERS THEN
               SV_CODERROR := '9';
               SV_MENERROR := 'Error, al seleccionar desde GA_ABOAMIST';
               VV_NOMTABLA:='GA_ABOAMIST';
               RAISE FIN;
         END;
      WHEN OTHERS THEN
         SV_CODERROR := '9';
         SV_MENERROR := 'Error, al seleccionar desde GA_ABOCEL';
         VV_NOMTABLA:='GA_ABOCEL';
         RAISE FIN;
   END;
   --
   IF SV_CODERROR != '0' THEN
      RAISE FIN;
   END IF;
   --
   -- OBTENEMOS NRO.OSSS
   SELECT CI_SEQ_NUMOS.NEXTVAL
   INTO   VN_NUMOOSS
   FROM   DUAL;
   SV_NUMOOSS := to_char(VN_NUMOOSS);
   --
   select decode(EV_CLASEACT,'0', null, EV_CLASEACT) into VV_CLASEACT from dual;
   select decode(EV_CLASEDES,'0', null, EV_CLASEDES) into VV_CLASEDES from dual;
   --
   -- ACTIVAMOS SS
   PV_INSOS_INS_PVIORSERV (
                           TO_CHAR(VN_NUMOOSS),     -- Nro.OOSS
                           EV_CODOOSS,              -- OOSS Servicio Suplementario
                           TO_CHAR(VN_CODPRODUCTO), -- Producto
                           EV_FECEJEC,              -- Fecha Ejecucion OOSS
                           VV_FECPROG,              -- Fecha Programacion OOSS
                           EV_USUARIO,              -- Usuario
                           EV_CODMODULO,            -- por GC, (POR DEFECTO ' ')
                           EV_NUMTAREA,             -- por GC, (POR DEFECTO '0')
                           SV_CODERROR,
                           SV_MENERROR,
                           SV_ORAERROR
                          );
   --
   IF SV_CODERROR != '0' THEN
	   RAISE FIN;
       SV_ORAERROR:='AQUI';
   END IF;
   --
   PV_INSOS_INS_PVERECORRIDO (
                              TO_CHAR(VN_NUMOOSS),     -- Nro.OOSS
                              SV_CODERROR,
                              SV_MENERROR,
                              SV_ORAERROR
                             );
   --
   IF SV_CODERROR != '0' THEN
	   RAISE FIN;
   END IF;
   --
   IF EV_INDFLAG = '1' THEN
      PV_INSOS_INS_PVPROG (
                           TO_CHAR(VN_NUMOOSS),    -- Nro.OOSS
                           VV_FECPROG,             -- Fecha Programacion OOSS
                           EV_USUARIO,             -- Usuario
                           SV_CODERROR,
                           SV_MENERROR,
                           SV_ORAERROR
                          );
   END IF;
   --
   IF SV_CODERROR != '0' THEN
	   RAISE FIN;
   END IF;
   --
   PV_INSOS_INS_PVMOVIMIENTOS (
                               TO_CHAR(VN_NUMOOSS),    -- Nro.OOSS
                               EV_CODACTABO,           -- Actuacion
                               EV_SUMACARGOS,          -- Suma Cargos
                               SV_CODERROR,
                               SV_MENERROR,
                               SV_ORAERROR
                              );
   --
   IF SV_CODERROR != '0' THEN
	   RAISE FIN;
   END IF;
   --
   PV_INSOS_INS_PVCAMCOM (
                          TO_CHAR(VN_NUMOOSS),     -- Nro.OOSS
                          EV_NUMABONADO,           -- Numero de Abonado
                          EV_NUMCELULARNEW,        -- Numero de Celular
                          TO_CHAR(VN_CODCLIENTE),  -- Cliente
                          TO_CHAR(VN_CODCUENTA),   -- Cuenta
                          TO_CHAR(VN_CODPRODUCTO), -- Producto
                          EV_BDATOS,               -- Base de Datos
                          TO_CHAR(VN_NUMTRANSAC),  -- Nro. Transaccion
                          EV_CODACTABO,            -- Actuacion
                          VV_FECPROG,              -- Fecha Programacion OOSS
                          VV_CLASEACT,             -- SS a Activar
                          VV_CLASEDES,             -- SS a Desactivar
                          '1',                     -- Ind.Central
                          SV_CODERROR,
                          SV_MENERROR,
                          SV_ORAERROR
                         );
   --
   IF SV_CODERROR != '0' THEN
	   RAISE FIN;
   END IF;
   --
   PV_INSOS_UPD_PVIORSERV (
                           TO_CHAR(VN_NUMOOSS),    -- Nro.OOSS
                           VV_CLASEDES,            -- SS a Desactivar
                           EV_CODACTABO,           -- Actuacion
                           SV_CODERROR,
                           SV_MENERROR,
                           SV_ORAERROR
                          );
   --
   IF SV_CODERROR != '0' THEN
	   RAISE FIN;
   END IF;
   --
   PV_INSOS_UPD_PVERECORRIDO (
                              TO_CHAR(VN_NUMOOSS),    -- Nro.OOSS
                              SV_CODERROR,
                              SV_MENERROR,
                              SV_ORAERROR
                             );
   --
   IF SV_CODERROR != '0' THEN
	   RAISE FIN;
   END IF;
   --
   SV_CODERROR:='0';
   SV_MENERROR:='0';
   SV_ORAERROR:='0';
   --
   EXCEPTION
   WHEN FIN THEN
      NULL;
      SV_NUMOOSS := '0';
   WHEN OTHERS THEN
      SV_NUMOOSS := '0';
      SV_MENERROR   := SQLERRM;
      SV_ORAERROR   := SQLERRM;
END PV_INICIOSS_PR;


PROCEDURE PV_INSOS_INS_PVIORSERV (
                                  EV_NUMOOSS        IN  VARCHAR2, -- Nro.OOSS
                                  EV_CODOOSS        IN  VARCHAR2, -- OOSS Servicio Suplementario
                                  EV_CODPRODUCTO    IN  VARCHAR2, -- Producto
                                  EV_FECHAEJEC      IN  VARCHAR2, -- Fecha Ejecucion OOSS
                                  EV_FECHAPROG      IN  VARCHAR2, -- Fecha Programacion OOSS
                                  EV_USUARIO        IN  VARCHAR2, -- Usuario
                                  EV_CODMODULO      IN  VARCHAR2, -- por GC, POR DEFECTO ' '
                                  EV_NUMTAREA       IN  VARCHAR2, -- por GC, POR DEFECTO '0'
                                  SV_CODERROR       OUT VARCHAR2,
                                  SV_MENERROR       OUT VARCHAR2,
                                  SV_ORAERROR       OUT VARCHAR2
                                 )
IS
   EN_NUMOOSS         NUMBER;
   VV_DESCRIPCION     CI_TIPORSERV.DESCRIPCION%TYPE;
   VV_TIPPROCESA      CI_TIPORSERV.TIP_PROCESA%TYPE;
   VV_CODMODGENER     CI_TIPORSERV.COD_MODGENER%TYPE;
   EN_CODPRODUCTO     NUMBER;
   VV_STATUS          PV_IORSERV.STATUS%TYPE;
   ED_FECHAEJEC	  	  DATE;
   ED_FECHAPROG	  	  DATE;
   VN_CODESTADO       PV_ERECORRIDO.COD_ESTADO%TYPE;
   VN_NUMOSF          PV_IORSERV.NUM_OSF%TYPE;
   VV_TIPSUBSUJETO    PV_IORSERV.TIP_SUBSUJETO%TYPE;
   VV_TIPSUJETO       PV_IORSERV.TIP_SUJETO%TYPE;
   VV_PATHFILE        PV_IORSERV.PATH_FILE%TYPE;
   VV_NUMFILE         PV_IORSERV.NFILE%TYPE;
   EN_NUMTAREA        NUMBER;
BEGIN
   SV_CODERROR:= '0';
   SV_MENERROR:= '0';
   --
   EN_NUMOOSS := TO_NUMBER(EV_NUMOOSS);
   EN_CODPRODUCTO := TO_NUMBER(EV_CODPRODUCTO);
   VV_STATUS:='en proceso';
   ED_FECHAEJEC := TO_DATE(EV_FECHAEJEC,'DD/MM/YYYY HH24:MI:SS');
   ED_FECHAPROG := TO_DATE(EV_FECHAPROG,'DD/MM/YYYY HH24:MI:SS');
   VN_CODESTADO:=10;
   VN_NUMOSF:=0;
   VV_TIPSUBSUJETO := '';
   VV_TIPSUJETO := 'A';
   VV_PATHFILE	:='';
   VV_NUMFILE :='';
   EN_NUMTAREA := TO_NUMBER(EV_NUMTAREA);
   --
   SELECT DESCRIPCION,TIP_PROCESA,COD_MODGENER
   INTO   VV_DESCRIPCION,VV_TIPPROCESA,VV_CODMODGENER
   FROM   CI_TIPORSERV
   WHERE  COD_OS = EV_CODOOSS;
   --
   INSERT INTO PV_IORSERV(NUM_OS,COD_OS,NUM_OSPADRE,DESCRIPCION,FECHA_ING,PRODUCTO,
                          USUARIO,STATUS,TIP_PROCESA,FH_EJECUCION,COD_ESTADO,COD_MODGENER,NUM_OSF,
                          TIP_SUBSUJETO,TIP_SUJETO,PATH_FILE,NFILE,COD_MODULO,ID_GESTOR)
   VALUES (EN_NUMOOSS,EV_CODOOSS,NULL,VV_DESCRIPCION,ED_FECHAEJEC,EN_CODPRODUCTO,
           EV_USUARIO,VV_STATUS,VV_TIPPROCESA,ED_FECHAPROG,VN_CODESTADO,VV_CODMODGENER,VN_NUMOSF,
           VV_TIPSUBSUJETO,VV_TIPSUJETO,VV_PATHFILE,VV_NUMFILE,EV_CODMODULO,EN_NUMTAREA);
   --
   EXCEPTION
   WHEN OTHERS THEN
      SV_CODERROR := '1';
      SV_MENERROR := 'Error, No se pudo insertar datos en tabla PV_IORSERV';
      SV_ORAERROR := SQLERRM;
END PV_INSOS_INS_PVIORSERV;


PROCEDURE PV_INSOS_INS_PVERECORRIDO (
                                     EV_NUMOOSS        IN  VARCHAR2, -- Nro.OOSS
                                     SV_CODERROR       OUT VARCHAR2,
                                     SV_MENERROR       OUT VARCHAR2,
                                     SV_ORAERROR       OUT VARCHAR2
                                    )
IS
   EN_NUMOOSS         NUMBER;
   VN_CODESTADO       PV_ERECORRIDO.COD_ESTADO%TYPE;
   VV_DESESTADOC      FA_INTESTADOC.DES_ESTADOC%TYPE;
   VV_CODAPLIC        FA_INTESTADOC.COD_APLIC%TYPE;
   VN_CODESTADOC      FA_INTESTADOC.COD_ESTADOC%TYPE;
   VN_TIPESTADO       PV_ERECORRIDO.TIP_ESTADO%TYPE;
BEGIN
   SV_CODERROR:= '0';
   SV_MENERROR:= '0';
   --
   EN_NUMOOSS := TO_NUMBER(EV_NUMOOSS);
   VN_CODESTADO:=10;
   VV_CODAPLIC:='PVA';
   VN_CODESTADOC:=10;
   VN_TIPESTADO:=1;
   --
   SELECT DES_ESTADOC INTO   VV_DESESTADOC
   FROM FA_INTESTADOC
   WHERE COD_APLIC   = VV_CODAPLIC
     AND COD_ESTADOC = VN_CODESTADOC;
   --
   INSERT INTO PV_ERECORRIDO(NUM_OS,COD_ESTADO,DESCRIPCION,TIP_ESTADO,FEC_INGESTADO)
   VALUES(EN_NUMOOSS,VN_CODESTADO,VV_DESESTADOC,VN_TIPESTADO,SYSDATE);
   --
   EXCEPTION
   WHEN OTHERS THEN
      SV_CODERROR:= '2';
      SV_MENERROR:= 'Error, No se pudo insertar datos en tabla PV_ERECORRIDO';
      SV_ORAERROR := SQLERRM;
END PV_INSOS_INS_PVERECORRIDO;


PROCEDURE PV_INSOS_INS_PVPROG (
                               EV_NUMOOSS        IN  VARCHAR2, -- Nro.OOSS
                               EV_FECHAPROG      IN  VARCHAR2, -- Fecha Programacion OOSS
                               EV_USUARIO        IN  VARCHAR2, -- Usuario
                               SV_CODERROR       OUT VARCHAR2,
                               SV_MENERROR       OUT VARCHAR2,
                               SV_ORAERROR       OUT VARCHAR2
                              )
IS
   EN_NUMOOSS         NUMBER;
   ED_FECHAPROG       DATE;
BEGIN
   SV_CODERROR:= '0';
   SV_MENERROR:= '0';
   --
   EN_NUMOOSS := TO_NUMBER(EV_NUMOOSS);
   ED_FECHAPROG := TO_DATE(EV_FECHAPROG,'DD/MM/YYYY HH24:MI:SS');
   --
   IF ED_FECHAPROG IS NOT NULL THEN
      INSERT INTO PV_PROG(NUM_OS,F_PRORROGA,USUARIO)
      VALUES(EN_NUMOOSS,ED_FECHAPROG,EV_USUARIO);
   END IF;
   --
   EXCEPTION
   WHEN OTHERS THEN
      SV_CODERROR := '3';
      SV_MENERROR := 'Error, No se pudo insertar datos en tabla PV_PROG';
      SV_ORAERROR := SQLERRM;
END PV_INSOS_INS_PVPROG;


PROCEDURE PV_INSOS_INS_PVMOVIMIENTOS (
                                      EV_NUMOOSS        IN  VARCHAR2, -- Nro.OOSS
                                      EV_CODACTABO      IN  VARCHAR2, -- Actuacion
                                      EV_SUMACARGOS     IN  VARCHAR2, -- Suma Cargos
                                      SV_CODERROR       OUT VARCHAR2,
                                      SV_MENERROR       OUT VARCHAR2,
                                      SV_ORAERROR       OUT VARCHAR2
                                     )
IS
   EN_NUMOOSS         NUMBER;
   VN_ORDCOMANDO      PV_MOVIMIENTOS.ORD_COMANDO%TYPE;
   VN_INDESTADO       PV_MOVIMIENTOS.IND_ESTADO%TYPE;
   EN_SUMACARGOS      NUMBER;
BEGIN
   SV_CODERROR:= '0';
   SV_MENERROR:= '0';
   --
   EN_NUMOOSS := TO_NUMBER(EV_NUMOOSS);
   VN_ORDCOMANDO:=1;
   VN_INDESTADO :=1;
   EN_SUMACARGOS := TO_NUMBER(EV_SUMACARGOS);
   --
   INSERT INTO PV_MOVIMIENTOS(NUM_OS,ORD_COMANDO,COD_ACTABO,IND_ESTADO,CARGA)
   VALUES(EN_NUMOOSS,VN_ORDCOMANDO,EV_CODACTABO,VN_INDESTADO,EN_SUMACARGOS);
   --
   EXCEPTION
   WHEN OTHERS THEN
      SV_CODERROR:= '4';
      SV_MENERROR:= 'Error, No se pudo insertar datos en tabla PV_MOVIMIENTOS';
END PV_INSOS_INS_PVMOVIMIENTOS;


PROCEDURE PV_INSOS_INS_PVCAMCOM (
                                 EV_NUMOOSS        IN  VARCHAR2, -- Nro.OOSS
                                 EV_NUMABONADO     IN  VARCHAR2, -- Numero de Abonado
                                 EV_NUMCELULAR     IN  VARCHAR2, -- Numero de Celular
                                 EV_CODCLIENTE     IN  VARCHAR2, -- Cliente
                                 EV_CODCUENTA      IN  VARCHAR2, -- Cuenta
                                 EV_CODPRODUCTO    IN  VARCHAR2, -- Producto
                                 EV_BDATOS         IN  VARCHAR2, -- Base de Datos
                                 EV_NUMTRANS       IN  VARCHAR2, -- Nro. Transaccion
                                 EV_CODACTABO      IN  VARCHAR2, -- Actuacion
                                 EV_FECHAPROG      IN  VARCHAR2, -- Fecha Programacion OOSS
                                 EV_CLASEACT       IN  VARCHAR2, -- SS a Activar
                                 EV_CLASEDES       IN  VARCHAR2, -- SS a Desactivar
                                 EV_INDCENTRAL     IN  VARCHAR2, -- Ind.Central
                                 SV_CODERROR       OUT VARCHAR2,
                                 SV_MENERROR       OUT VARCHAR2,
                                 SV_ORAERROR       OUT VARCHAR2
                                )
IS
   EN_NUMOOSS         NUMBER;
   EN_NUMABONADO      NUMBER;
   EN_NUMCELULAR      NUMBER;
   EN_CODCLIENTE      NUMBER;
   EN_CODCUENTA       NUMBER;
   EN_CODPRODUCTO     NUMBER;
   EN_NUMTRANS        NUMBER;
   ED_FECHAPROG       DATE;
   EN_INDCENTRAL      NUMBER;
BEGIN
   SV_CODERROR:= '0';
   SV_MENERROR:= '0';
   --
   EN_NUMOOSS := TO_NUMBER(EV_NUMOOSS);
   EN_NUMABONADO := TO_NUMBER(EV_NUMABONADO);
   EN_NUMCELULAR := TO_NUMBER(EV_NUMCELULAR);
   EN_CODCLIENTE := TO_NUMBER(EV_CODCLIENTE);
   EN_CODCUENTA := TO_NUMBER(EV_CODCUENTA);
   EN_CODPRODUCTO := TO_NUMBER(EV_CODPRODUCTO);
   EN_NUMTRANS := TO_NUMBER(EV_NUMTRANS);
   ED_FECHAPROG := TO_DATE(EV_FECHAPROG,'DD/MM/YYYY HH24:MI:SS');
   EN_INDCENTRAL := TO_NUMBER(EV_INDCENTRAL);
   --
   INSERT INTO PV_CAMCOM(NUM_OS,NUM_ABONADO,NUM_CELULAR,COD_CLIENTE,COD_CUENTA,
                         COD_PRODUCTO,BDATOS,NUM_VENTA,NUM_TRANSACCION,NUM_FOLIO,NUM_CUOTAS,
                         NUM_PROCESO,COD_ACTABO,FH_ANULA,CAT_TRIBUT,COD_ESTADOC,COD_CAUSAELIM,
                         FEC_VENCIMIENTO,CLASE_SERVICIO_ACT,CLASE_SERVICIO_DES,IND_CENTRAL_SS,
                         IND_PORTABLE,TIP_TERMINAL,TIP_SUSP_AVSINIE,PREF_PLAZA)
   VALUES(EN_NUMOOSS,EN_NUMABONADO,EN_NUMCELULAR,EN_CODCLIENTE,EN_CODCUENTA,
          EN_CODPRODUCTO,EV_BDATOS,NULL,EN_NUMTRANS,NULL,NULL,
          0,EV_CODACTABO,NULL,NULL,0,NULL,
          ED_FECHAPROG,EV_CLASEACT,EV_CLASEDES,EN_INDCENTRAL,
          0,NULL,NULL,NULL);
   --
   EXCEPTION
   WHEN OTHERS THEN
      SV_CODERROR:= '5';
      SV_MENERROR:= 'Error, No se pudo insertar datos en tabla PV_CAMCOM';
END PV_INSOS_INS_PVCAMCOM;


PROCEDURE PV_INSOS_UPD_PVIORSERV (
                                  EV_NUMOOSS        IN  VARCHAR2, -- Nro.OOSS
                                  EV_CLASEDES       IN  VARCHAR2, -- SS a Desactivar
                                  EV_CODACTABO      IN  VARCHAR2, -- Actuacion
                                  SV_CODERROR       OUT VARCHAR2,
                                  SV_MENERROR       OUT VARCHAR2,
                                  SV_ORAERROR       OUT VARCHAR2
                                 )
IS
   EN_NUMOOSS         NUMBER;
   VV_SSENRUTA        VARCHAR(6);
   VV_CODACTABO       VARCHAR(2);
   VV_CODNIVEL		  VARCHAR(4);
   VV_CODSERVSUPL	  VARCHAR(2);
BEGIN
   SV_CODERROR:= '0';
   SV_MENERROR:= '0';

   EN_NUMOOSS := TO_NUMBER(EV_NUMOOSS);
   SELECT VAL_PARAMETRO INTO VV_CODSERVSUPL
     FROM GED_PARAMETROS
    WHERE NOM_PARAMETRO = 'SS_ENRUTA';

   SELECT LTRIM(TO_CHAR(COD_NIVEL,'0999')) INTO VV_CODNIVEL
     FROM GA_SERVSUPL
    WHERE COD_SERVSUPL = VV_CODSERVSUPL
      AND COD_PRODUCTO = 1;

   VV_SSENRUTA:=VV_CODSERVSUPL||VV_CODNIVEL;
   VV_CODACTABO:='SS';
   --
   UPDATE PV_IORSERV
   SET STATUS='Proceso exitoso'
   WHERE  NUM_OS= EN_NUMOOSS;
   --
   IF EV_CLASEDES = VV_SSENRUTA AND EV_CODACTABO = VV_CODACTABO THEN
      -- Solo para SS Enrutamiento de Llamada
      UPDATE PV_IORSERV
      SET    TIP_PROCESA=9
      WHERE  NUM_OS= EN_NUMOOSS;
   END IF;
   --
   EXCEPTION
   WHEN OTHERS THEN
      SV_CODERROR:= '6';
      SV_MENERROR:= 'Error, No se pudo actualizar datos en tabla PV_IORSERV';
END PV_INSOS_UPD_PVIORSERV;


PROCEDURE PV_INSOS_UPD_PVERECORRIDO (
                                     EV_NUMOOSS        IN  VARCHAR2, -- Nro.OOSS
                                     SV_CODERROR       OUT VARCHAR2,
                                     SV_MENERROR       OUT VARCHAR2,
                                     SV_ORAERROR       OUT VARCHAR2
                                    )
IS
   EN_NUMOOSS         NUMBER;
BEGIN
   SV_CODERROR:= '0';
   SV_MENERROR:= '0';
   --
   EN_NUMOOSS := TO_NUMBER(EV_NUMOOSS);
   --
   UPDATE PV_ERECORRIDO
   SET DESCRIPCION='PROC. INSCRIPCION EN INTERFAZ',
       TIP_ESTADO=3
   WHERE  NUM_OS= EN_NUMOOSS;
   --
   EXCEPTION
   WHEN OTHERS THEN
      SV_CODERROR:= '7';
      SV_MENERROR:= 'Error, No se pudo actualizar datos en tabla PV_ERECORRIDO';
END PV_INSOS_UPD_PVERECORRIDO;


END PV_ACTIVADESACTIVASS_PG;
/
SHOW ERRORS
