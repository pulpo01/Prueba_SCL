CREATE OR REPLACE PROCEDURE        GA_P_DUPLICAABO
(
  VP_TRANSAC    IN VARCHAR2,
  VP_CLIENTENEW IN VARCHAR2 ,
  VP_ABONADONEW IN VARCHAR2 ,
  VP_CLIENTEOLD IN VARCHAR2 ,
  VP_ABONADOOLD IN VARCHAR2 ,
  VP_CUENTANEW  IN VARCHAR2,
  VP_SUBCUENTANEW IN VARCHAR2,
  VP_USUARIONEW   IN VARCHAR2,
  VP_PRODUCTO IN VARCHAR2
)
IS
-- Procedimiento que realiza el traspaso entre dos clientes para abonados
-- Supertelefono
--
--
V_SQLCODE  VARCHAR2(1088);
V_SQLERRM  VARCHAR2(1088);
V_ERROR  VARCHAR2(1);
V_CLIENTENEW GE_CLIENTES.COD_CLIENTE%TYPE;
V_ABONADONEW GA_ABOCEL.NUM_ABONADO%TYPE;
V_CLIENTEOLD GE_CLIENTES.COD_CLIENTE%TYPE;
V_ABONADOOLD GA_ABOCEL.NUM_ABONADO%TYPE;
V_CUENTANEW  GA_ABOCEL.COD_CUENTA%TYPE;
V_SUBCUENTANEW GA_ABOCEL.COD_SUBCUENTA%TYPE;
V_USUARIONEW GA_ABOCEL.COD_USUARIO%TYPE;
V_CADENA VARCHAR2(255);
V_CAUTRAS GA_CAUSABAJA.COD_CAUSABAJA%TYPE;
V_CUENTA GA_ABOCEL.COD_CUENTA%TYPE;
V_SUBCUENTA GA_ABOCEL.COD_SUBCUENTA%TYPE;
V_USUARIO GA_ABOCEL.COD_USUARIO%TYPE;
-- V_TERMINAL NUMBER(8); -- Se modifica por Proyecto 15 Digitos -- PARP
V_TERMINAL GA_ABOCEL.NUM_CELULAR%TYPE;
V_CICLO GA_ABOCEL.COD_CICLO%TYPE;
V_FECSYS DATE ;
V_INDFACT GA_ABOCEL.IND_FACTUR%TYPE;
V_CICLONEW FA_CICLOS.COD_CICLO%TYPE;
V_CREDMOR GA_ABOCEL.COD_CREDMOR%TYPE;
V_PREFIJO    VARCHAR2(3);
V_COD_USO    NUMBER(3);
ERROR_PROCESO EXCEPTION;
BEGIN
 V_ERROR := '0';
 V_CLIENTENEW := TO_NUMBER(VP_CLIENTENEW);
 V_ABONADONEW := TO_NUMBER(VP_ABONADONEW);
 V_CLIENTEOLD := TO_NUMBER(VP_CLIENTEOLD);
 V_ABONADOOLD := TO_NUMBER(VP_ABONADOOLD);
 V_CUENTANEW  := TO_NUMBER(VP_CUENTANEW);
 V_SUBCUENTANEW := VP_SUBCUENTANEW;
 V_USUARIONEW   := TO_NUMBER(VP_USUARIONEW);
-- EN PRIMER LUGAR HA DE CREARSE EL NUEVO CLIENTE PARA STM
--SELECCIONAMOS EL CICLO PARA stm
 SELECT COD_CICLO INTO V_CICLONEW FROM GE_CLIENTES
 WHERE COD_CLIENTE = V_CLIENTENEW;
--********************duplicar abonado******************
-- DUPLICAR FILA PARA GA_ABOCEL
 BEGIN
 IF VP_PRODUCTO = '1' THEN
                 INSERT INTO GA_ABOCEL (
                   NUM_ABONADO,
                   NUM_CELULAR,
                   COD_PRODUCTO,
                   COD_CLIENTE,
                   COD_CUENTA,
                   COD_SUBCUENTA,
                   COD_USUARIO,
                   COD_REGION,
                   COD_PROVINCIA,
                   COD_CIUDAD,
                   COD_CELDA,
                   COD_CENTRAL,
                   COD_USO,
                   COD_SITUACION,
                   IND_PROCALTA,
                   IND_PROCEQUI,
                   COD_VENDEDOR,
                   COD_VENDEDOR_AGENTE,
                   TIP_PLANTARIF,
                   TIP_TERMINAL,
                   COD_PLANTARIF,
                   COD_CARGOBASICO,
                   COD_PLANSERV,
                   COD_LIMCONSUMO,
                   NUM_SERIE,
                   NUM_SERIEHEX,
                   NOM_USUARORA,
                   FEC_ALTA,
                   NUM_PERCONTRATO ,
                   COD_ESTADO,
                   NUM_SERIEMEC,
                   COD_HOLDING,
                   COD_EMPRESA,
                   COD_GRPSERV,
                   IND_SUPERTEL,
                   NUM_TELEFIJA,
                   COD_OPREDFIJA,
                   COD_CARRIER,
                   IND_PREPAGO,
                   IND_PLEXSYS,
                   COD_CENTRAL_PLEX,
                   NUM_CELULAR_PLEX,
                   NUM_VENTA,
                   COD_MODVENTA,
                   COD_TIPCONTRATO,
                   NUM_CONTRATO,
                   NUM_ANEXO,
                   FEC_CUMPLAN,
                   COD_CREDMOR,
                   COD_CREDCON,
                   COD_CICLO,
                   IND_FACTUR,
                   IND_SUSPEN,
                   IND_REHABI,
                   IND_INSGUIAS,
                   FEC_FINCONTRA,
                   FEC_RECDOCUM,
                   FEC_CUMPLIMEN,
                   FEC_ACEPVENTA,
                   FEC_ACTCEN,
                   FEC_BAJA,
                   FEC_BAJACEN,
                   FEC_ULTMOD,
                   COD_CAUSABAJA,
                   NUM_PERSONAL,
                   IND_SEGURO,
                   CLASE_SERVICIO,
                   PERFIL_ABONADO,
                   NUM_MIN )
                            SELECT
                   V_ABONADONEW,
                   NUM_CELULAR,
                   COD_PRODUCTO,
                   V_CLIENTENEW,
                   V_CUENTANEW,
                   V_SUBCUENTANEW,
                   V_USUARIONEW,
                   COD_REGION,
                   COD_PROVINCIA,
                   COD_CIUDAD,
                   COD_CELDA,
                   COD_CENTRAL,
                   COD_USO,
                   COD_SITUACION,
                   IND_PROCALTA,
                   IND_PROCEQUI,
                   COD_VENDEDOR,
                   COD_VENDEDOR_AGENTE,
                   TIP_PLANTARIF,
                   TIP_TERMINAL,
                   COD_PLANTARIF,
                   COD_CARGOBASICO,
                   COD_PLANSERV,
                   COD_LIMCONSUMO,
                   NUM_SERIE,
                   NUM_SERIEHEX,
                   NOM_USUARORA,
                   FEC_ALTA,
                   NUM_PERCONTRATO ,
                   COD_ESTADO,
                   NUM_SERIEMEC,
                   COD_HOLDING,
                   COD_EMPRESA,
                   COD_GRPSERV,
                   IND_SUPERTEL,
                   NUM_TELEFIJA,
                   COD_OPREDFIJA,
                   COD_CARRIER,
                   IND_PREPAGO,
                   IND_PLEXSYS,
                   COD_CENTRAL_PLEX,
                   NUM_CELULAR_PLEX,
                   NUM_VENTA,
                   COD_MODVENTA,
                   COD_TIPCONTRATO,
                   NUM_CONTRATO,
                   NUM_ANEXO,
                   FEC_CUMPLAN,
                   COD_CREDMOR,
                   COD_CREDCON,
                   V_CICLONEW,
                   IND_FACTUR,
                   IND_SUSPEN,
                   IND_REHABI,
                   IND_INSGUIAS,
                   FEC_FINCONTRA,
                   FEC_RECDOCUM,
                   FEC_CUMPLIMEN,
                   FEC_ACEPVENTA,
                   FEC_ACTCEN,
                   FEC_BAJA,
                   FEC_BAJACEN,
                   FEC_ULTMOD,
                   COD_CAUSABAJA,
                   NUM_PERSONAL,
                   IND_SEGURO,
                   CLASE_SERVICIO,
                   PERFIL_ABONADO,
                   NUM_MIN
                            FROM GA_ABOCEL
                            WHERE NUM_ABONADO = V_ABONADOOLD;
        ELSIF VP_PRODUCTO = '2' THEN --DUPLICA ABOBEEP
                INSERT INTO GA_ABOBEEP (
                NUM_ABONADO,
                NUM_BEEPER,
                COD_PRODUCTO,
                COD_CLIENTE,
                COD_CUENTA,
                COD_SUBCUENTA,
                COD_USUARIO,
                TIP_SUSCRIPCION,
                COD_CENTRAL,
                COD_USO ,
                IND_TIPSERVBEEP,
                TIP_COBERTURA,
                COD_NODO,
                COD_FRECUENCIA,
                COD_SITUACION,
                IND_PROCALTA,
                IND_PROCEQUI,
                COD_VENDEDOR,
                COD_VENDEDOR_AGENTE ,
                TIP_PLANTARIF,
                COD_PLANTARIF,
                COD_CARGOBASICO,
                COD_PLANSERV ,
                COD_LIMCONSUMO,
                CAP_CODE ,
                NOM_USUARORA,
                FEC_ALTA,
                NUM_PERCONTRATO,
                COD_PROTOCOLO,
                NUM_VELOCIDAD,
                COD_ESTADO,
                NUM_SERIE,
                NUM_SERIEMEC,
                COD_HOLDING,
                COD_EMPRESA,
                COD_GRPSERV,
                NUM_VENTA,
                COD_MODVENTA,
                COD_TIPCONTRATO,
                NUM_CONTRATO,
                NUM_ANEXO,
                FEC_CUMPLAN,
                COD_CREDMOR,
                COD_CREDCON,
                COD_CICLO,
                IND_FACTUR,
                IND_SUSPEN,
                IND_REHABI,
                IND_SEGURO,
                FEC_FINCONTRA,
                FEC_RECDOCUM,
                FEC_CUMPLIMEN,
                FEC_ACEPVENTA,
                FEC_ACTCEN,
                FEC_BAJA,
                FEC_BAJACEN,
                FEC_ULTMOD,
                COD_CAUSABAJA,
                CLASE_SERVICIO,
                PERFIL_ABONADO)
          SELECT
                V_ABONADONEW,
                NUM_BEEPER,
                COD_PRODUCTO,
                V_CLIENTENEW,
        V_CUENTANEW,
                V_SUBCUENTANEW,
                V_USUARIONEW,
                TIP_SUSCRIPCION,
                COD_CENTRAL,
                COD_USO ,
                IND_TIPSERVBEEP,
                TIP_COBERTURA,
                COD_NODO,
                COD_FRECUENCIA,
                COD_SITUACION,
                IND_PROCALTA,
                IND_PROCEQUI,
                COD_VENDEDOR,
                COD_VENDEDOR_AGENTE ,
                TIP_PLANTARIF,
                COD_PLANTARIF,
                COD_CARGOBASICO,
                COD_PLANSERV ,
                COD_LIMCONSUMO,
                CAP_CODE ,
                NOM_USUARORA,
                FEC_ALTA,
                NUM_PERCONTRATO,
                COD_PROTOCOLO,
                NUM_VELOCIDAD,
                COD_ESTADO,
                NUM_SERIE,
                NUM_SERIEMEC,
                COD_HOLDING,
                COD_EMPRESA,
                COD_GRPSERV,
                NUM_VENTA,
                COD_MODVENTA,
                COD_TIPCONTRATO,
                NUM_CONTRATO,
                NUM_ANEXO,
                FEC_CUMPLAN,
                COD_CREDMOR,
                COD_CREDCON,
                V_CICLONEW,
                IND_FACTUR,
                IND_SUSPEN,
                IND_REHABI,
                IND_SEGURO,
                FEC_FINCONTRA,
                FEC_RECDOCUM,
                FEC_CUMPLIMEN,
                FEC_ACEPVENTA,
                FEC_ACTCEN,
                FEC_BAJA,
                FEC_BAJACEN,
                FEC_ULTMOD,
                COD_CAUSABAJA,
                CLASE_SERVICIO,
                PERFIL_ABONADO FROM GA_ABOBEEP
                WHERE NUM_ABONADO = V_ABONADOOLD;
                --DUPLICA GA_SUSCBEEP
                INSERT INTO GA_SUSCBEEP (
                        NUM_ABONADO,
                        TS,ID,CC,TP,PRO,VEL,FRE,COB,NOM,GM1,GM2,GM3,GM4,
                        GM5,RUT,STA,MARP,MODP,NSER,TCUE)
                SELECT
V_ABONADONEW,
                        TS,ID,CC,TP,PRO,VEL,FRE,COB,NOM,GM1,GM2,GM3,GM4,
                        GM5,RUT,STA,MARP,MODP,NSER,TCUE
                FROM GA_SUSCBEEP
                WHERE NUM_ABONADO = V_ABONADOOLD;
        ELSIF VP_PRODUCTO = '4' THEN --DUPLICA ABOTREK
         INSERT INTO GA_ABOTREK (
                NUM_ABONADO,NUM_MAN ,COD_PRODUCTO,COD_CLIENTE,
                COD_CUENTA,COD_SUBCUENTA,COD_USUARIO,COD_APLICACION,
                IND_TIPSUSC,COD_CENTRAL,COD_USO,COD_SITUACION,
                IND_PROCALTA,IND_PROCEQUI,COD_VENDEDOR,COD_VENDEDOR_AGENTE,
                TIP_PLANTARIF,COD_PLANTARIF ,COD_CARGOBASICO,COD_PLANSERV,
                COD_LIMCONSUMO,        NOM_USUARORA,FEC_ALTA,NUM_PERCONTRATO,
                COD_ESTADO,        TIP_TERMINAL,NUM_SERIE,        COD_VERSION,COD_MODELO ,
                NUM_SERIEMEC,TIP_SUSCFIJA,DIR_X25 ,COD_HOLDING,COD_EMPRESA,
                COD_GRPSERV,NUM_VENTA,COD_MODVENTA,COD_TIPCONTRATO,NUM_CONTRATO,
                NUM_ANEXO,FEC_CUMPLAN,COD_CREDMOR,COD_CREDCON,COD_CICLO,
                IND_FACTUR,IND_SUSPEN,IND_REHABI,IND_INSGUIAS,FEC_FINCONTRA,
                FEC_ACEPVENTA,FEC_ACTCEN,FEC_BAJA ,        FEC_BAJACEN,FEC_ULTMOD,
                COD_CAUSABAJA,IND_SEGURO,CLASE_SERVICIO,PERFIL_ABONADO)
         SELECT
                V_ABONADONEW,NUM_MAN ,COD_PRODUCTO,V_CLIENTENEW,
                V_CUENTANEW,V_SUBCUENTANEW,V_USUARIONEW,COD_APLICACION,
                IND_TIPSUSC,COD_CENTRAL,COD_USO,COD_SITUACION,
                IND_PROCALTA,IND_PROCEQUI,COD_VENDEDOR,COD_VENDEDOR_AGENTE,
                TIP_PLANTARIF,COD_PLANTARIF ,COD_CARGOBASICO,COD_PLANSERV,
                COD_LIMCONSUMO,        NOM_USUARORA,FEC_ALTA,NUM_PERCONTRATO,
                COD_ESTADO,        TIP_TERMINAL,NUM_SERIE,        COD_VERSION,COD_MODELO ,
                NUM_SERIEMEC,TIP_SUSCFIJA,DIR_X25 ,COD_HOLDING,COD_EMPRESA,
                COD_GRPSERV,NUM_VENTA,COD_MODVENTA,COD_TIPCONTRATO,NUM_CONTRATO,
                NUM_ANEXO,FEC_CUMPLAN,COD_CREDMOR,COD_CREDCON,COD_CICLO,
                IND_FACTUR,IND_SUSPEN,IND_REHABI,IND_INSGUIAS,FEC_FINCONTRA,
                FEC_ACEPVENTA,FEC_ACTCEN,FEC_BAJA ,        FEC_BAJACEN,FEC_ULTMOD,
                COD_CAUSABAJA,IND_SEGURO,CLASE_SERVICIO,PERFIL_ABONADO
         FROM GA_ABOTREK
         WHERE NUM_ABONADO = V_ABONADOOLD;
        END IF;
        EXCEPTION
         WHEN OTHERS THEN
            V_SQLCODE :=SQLCODE;
            V_SQLERRM :=SQLERRM;
            V_ERROR := '4';
      RAISE ERROR_PROCESO;
        END;
--DUPLICAR GA_SUSPREHABO
        BEGIN
  INSERT INTO GA_SUSPREHABO(
   NUM_ABONADO,
   COD_SERVICIO  ,
   FEC_SUSPBD   ,
   COD_PRODUCTO ,
   NUM_TERMINAL ,
   NOM_USUARORA ,
   COD_MODULO   ,
   TIP_REGISTRO ,
   COD_CAUSUSP  ,
   TIP_SUSP     ,
   COD_SERVSUPL ,
   COD_NIVEL    ,
   FEC_SUSPCEN  ,
   FEC_REHABD   ,
   FEC_REHACEN  ,
   COD_CARGOBASICO ,
   COD_OPERADOR    ,
   IND_SINIESTRO   ,
   NUM_PETICION )
    SELECT
   V_ABONADONEW,
   COD_SERVICIO  ,
   FEC_SUSPBD   ,
   COD_PRODUCTO ,
   NUM_TERMINAL ,
   NOM_USUARORA ,
   COD_MODULO   ,
   TIP_REGISTRO ,
   COD_CAUSUSP  ,
   TIP_SUSP     ,
   COD_SERVSUPL ,
   COD_NIVEL    ,
   FEC_SUSPCEN  ,
   FEC_REHABD   ,
   FEC_REHACEN  ,
   COD_CARGOBASICO ,
   COD_OPERADOR    ,
   IND_SINIESTRO   ,
   NUM_PETICION
                 FROM GA_SUSPREHABO
                 WHERE  NUM_ABONADO = V_ABONADOOLD  ;
        EXCEPTION
                WHEN NO_DATA_FOUND THEN
        NULL;
  WHEN OTHERS THEN
            V_SQLCODE :=SQLCODE;
            V_SQLERRM :=SQLERRM;
            V_ERROR := '4';
      RAISE ERROR_PROCESO;
        END;
--DUPLICAMOS GA_SERVSUPLABO
        BEGIN
  INSERT INTO GA_SERVSUPLABO(
    NUM_ABONADO ,
    COD_SERVICIO ,
    FEC_ALTABD   ,
    COD_SERVSUPL ,
    COD_NIVEL    ,
    COD_PRODUCTO ,
    NUM_TERMINAL ,
    NOM_USUARORA ,
    IND_ESTADO   ,
    FEC_ALTACEN  ,
    FEC_BAJABD   ,
    FEC_BAJACEN  ,
    COD_CONCEPTO ,
    NUM_DIASNUM  )
                SELECT
                                V_ABONADONEW ,
    COD_SERVICIO ,
    FEC_ALTABD   ,
    COD_SERVSUPL ,
    COD_NIVEL    ,
    COD_PRODUCTO ,
    NUM_TERMINAL ,
    NOM_USUARORA ,
    IND_ESTADO   ,
    FEC_ALTACEN  ,
    FEC_BAJABD   ,
    FEC_BAJACEN  ,
    COD_CONCEPTO ,
    NUM_DIASNUM
               FROM  GA_SERVSUPLABO
               WHERE NUM_ABONADO = V_ABONADOOLD;
        EXCEPTION
                WHEN NO_DATA_FOUND THEN
        NULL;
  WHEN OTHERS THEN
            V_SQLCODE :=SQLCODE;
            V_SQLERRM :=SQLERRM;
            V_ERROR := '4';
      RAISE ERROR_PROCESO;
        END;
--DUPLICAR SEGURABO
        BEGIN
                INSERT INTO GA_SEGURABO (
    NUM_ABONADO   ,
    FEC_ALTA      ,
    COD_PRODUCTO  ,
    NUM_TERMINAL  ,
    NUM_SERIE     ,
    COD_TIPSEGU   ,
    NUM_CONTRATO  ,
    NUM_ANEXO     ,
    NUM_PERIODO   ,
    FEC_FINCONTRATO,
    NOM_USUARORA)
               SELECT
               V_ABONADONEW  ,
    FEC_ALTA      ,
    COD_PRODUCTO  ,
    NUM_TERMINAL  ,
    NUM_SERIE     ,
    COD_TIPSEGU   ,
    NUM_CONTRATO  ,
    NUM_ANEXO     ,
    NUM_PERIODO   ,
    FEC_FINCONTRATO,
    NOM_USUARORA
                FROM GA_SEGURABO
                WHERE  NUM_ABONADO = V_ABONADOOLD;
        EXCEPTION
                WHEN NO_DATA_FOUND THEN
        NULL;
  WHEN OTHERS THEN
            V_SQLCODE :=SQLCODE;
            V_SQLERRM :=SQLERRM;
            V_ERROR := '4';
      RAISE ERROR_PROCESO;
        END;
--DUPLICAR NUMESPABO
        BEGIN
  INSERT INTO GA_NUMESPABO (
   NUM_ABONADO,
   NUM_TELEFESP,
   NUM_DIASNUM )
                SELECT
   V_ABONADONEW,
   NUM_TELEFESP,
   NUM_DIASNUM
                FROM GA_NUMESPABO
  WHERE NUM_ABONADO = V_ABONADOOLD;
        EXCEPTION
                WHEN NO_DATA_FOUND THEN
        NULL;
  WHEN OTHERS THEN
            V_SQLCODE :=SQLCODE;
            V_SQLERRM :=SQLERRM;
            V_ERROR := '4';
      RAISE ERROR_PROCESO;
        END;
--DUPLICAR MODABOCEL
        BEGIN
                IF VP_PRODUCTO = '1' THEN
                  INSERT INTO GA_MODABOCEL(
                   NUM_ABONADO, COD_TIPMODI, FEC_MODIFICA , NOM_USUARORA,NUM_CELULAR  ,
                   COD_REGION,COD_PROVINCIA , COD_CIUDAD, COD_CELDA,COD_CENTRAL,
                   COD_USO ,TIP_PLANTARIF ,TIP_TERMINAL ,COD_PLANTARIF ,COD_CARGOBASICO,
                   COD_PLANSERV,COD_LIMCONSUMO ,NUM_SERIE,NUM_SERIEHEX,NUM_SERIEMEC ,
                   COD_HOLDING ,COD_EMPRESA ,COD_GRPSERV ,NUM_TELEFIJA ,COD_OPREDFIJA ,
                   IND_SUPERTEL,COD_CARRIER  ,IND_PLEXSYS  ,COD_CENTRAL_PLEX ,NUM_CELULAR_PLEX ,
                   COD_CREDMOR, COD_CREDCON ,COD_CICLO,IND_FACTUR,IND_SUSPEN,IND_REHABI,IND_INSGUIAS ,
                   NUM_PERSONAL ,COD_CAUSA, NUM_MIN   )
                               SELECT
                   V_ABONADONEW,COD_TIPMODI,FEC_MODIFICA ,NOM_USUARORA  ,
                   NUM_CELULAR,COD_REGION,COD_PROVINCIA ,COD_CIUDAD,
                   COD_CELDA,COD_CENTRAL,COD_USO,TIP_PLANTARIF ,TIP_TERMINAL  ,
                   COD_PLANTARIF,COD_CARGOBASICO,COD_PLANSERV,COD_LIMCONSUMO ,
                   NUM_SERIE,NUM_SERIEHEX,NUM_SERIEMEC ,COD_HOLDING ,
                   COD_EMPRESA,COD_GRPSERV ,NUM_TELEFIJA ,COD_OPREDFIJA ,
                   IND_SUPERTEL,COD_CARRIER,IND_PLEXSYS  ,COD_CENTRAL_PLEX ,
                   NUM_CELULAR_PLEX, COD_CREDMOR,COD_CREDCON ,COD_CICLO     ,
                   IND_FACTUR,IND_SUSPEN,IND_REHABI ,IND_INSGUIAS ,
                   NUM_PERSONAL,COD_CAUSA, V_PREFIJO
                   FROM GA_MODABOCEL
                    WHERE NUM_ABONADO = V_ABONADOOLD;
                 ELSIF VP_PRODUCTO = '2' THEN
                   INSERT INTO GA_MODABOBEEP (
                        NUM_ABONADO,COD_TIPMODI,FEC_MODIFICA,NOM_USUARORA,
                        NUM_BEEPER,        COD_CENTRAL,COD_USO,IND_TIPSERVBEEP,
                        TIP_COBERTURA,COD_NODO,COD_FRECUENCIA,COD_PROTOCOLO,
                        NUM_VELOCIDAD,TIP_PLANTARIF,COD_PLANTARIF,COD_CARGOBASICO,
                        COD_PLANSERV,COD_LIMCONSUMO,CAP_CODE,NUM_SERIE,
                        NUM_SERIEMEC,COD_HOLDING,COD_EMPRESA,COD_GRPSERV,
                        COD_CREDMOR,COD_CREDCON,COD_CICLO,IND_FACTUR,
                        IND_SUSPEN,IND_REHABI,COD_CAUSA)
           SELECT
                        V_ABONADONEW,COD_TIPMODI,FEC_MODIFICA,NOM_USUARORA,
                        NUM_BEEPER,        COD_CENTRAL,COD_USO,IND_TIPSERVBEEP,
                        TIP_COBERTURA,COD_NODO,COD_FRECUENCIA,COD_PROTOCOLO,
                        NUM_VELOCIDAD,TIP_PLANTARIF,COD_PLANTARIF,COD_CARGOBASICO,
                        COD_PLANSERV,COD_LIMCONSUMO,CAP_CODE,NUM_SERIE,
                        NUM_SERIEMEC,COD_HOLDING,COD_EMPRESA,COD_GRPSERV,
                        COD_CREDMOR,COD_CREDCON,COD_CICLO,IND_FACTUR,
                        IND_SUSPEN,IND_REHABI,COD_CAUSA
                   FROM GA_MODABOBEEP
                   WHERE NUM_ABONADO = V_ABONADOOLD;
                 ELSIF VP_PRODUCTO = '4' THEN
                        INSERT INTO GA_MODABOTREK (
                        NUM_ABONADO,COD_TIPMODI,FEC_MODIFICA,NOM_USUARORA,
                          NUM_MAN ,COD_APLICACION,COD_CENTRAL,COD_USO,
                        TIP_PLANTARIF,COD_PLANTARIF,COD_CARGOBASICO,
                        COD_PLANSERV,COD_LIMCONSUMO,TIP_TERMINAL,
                        NUM_SERIE,NUM_SERIEMEC,COD_VERSION,COD_MODELO,
                        TIP_SUSCFIJA,DIR_X25,COD_HOLDING,COD_EMPRESA,
                        COD_GRPSERV,FEC_CUMPLAN,COD_CREDMOR,COD_CREDCON,
                        COD_CICLO,IND_FACTUR,IND_SUSPEN,IND_REHABI,
                        COD_CAUSA)
                        SELECT
                                V_ABONADONEW,COD_TIPMODI,FEC_MODIFICA,NOM_USUARORA,
                          NUM_MAN ,COD_APLICACION,COD_CENTRAL,COD_USO,
                        TIP_PLANTARIF,COD_PLANTARIF,COD_CARGOBASICO,
                        COD_PLANSERV,COD_LIMCONSUMO,TIP_TERMINAL,
                        NUM_SERIE,NUM_SERIEMEC,COD_VERSION,COD_MODELO,
                        TIP_SUSCFIJA,DIR_X25,COD_HOLDING,COD_EMPRESA,
                        COD_GRPSERV,FEC_CUMPLAN,COD_CREDMOR,COD_CREDCON,
                        COD_CICLO,IND_FACTUR,IND_SUSPEN,IND_REHABI,
                        COD_CAUSA
                        FROM GA_MODABOTREK
                        WHERE NUM_ABONADO = V_ABONADOOLD;
                 END IF;
        EXCEPTION
                WHEN NO_DATA_FOUND THEN
        NULL;
  WHEN OTHERS THEN
            V_SQLCODE :=SQLCODE;
            V_SQLERRM :=SQLERRM;
            V_ERROR := '4';
      RAISE ERROR_PROCESO;
        END;
--DUPLICAR GA_EQUIPABONOSER
        BEGIN
              INSERT INTO GA_EQUIPABONOSER(
   NUM_ABONADO  ,
   COD_ARTICULO ,
   FEC_ALTA  ,
   NUM_MOVIMIENTO,
   COD_PRODUCTO ,
   NUM_UNIDADES,
   COD_BODEGA,
   TIP_STOCK,
   COD_USO,
   COD_ESTADO ,
   COD_PAQUETE)
            SELECT
                   V_ABONADONEW  ,
   COD_ARTICULO ,
   FEC_ALTA  ,
   NUM_MOVIMIENTO,
   COD_PRODUCTO ,
   NUM_UNIDADES,
   COD_BODEGA,
   TIP_STOCK,
   COD_USO,
   COD_ESTADO ,
   COD_PAQUETE
            FROM GA_EQUIPABONOSER
            WHERE NUM_ABONADO = V_ABONADOOLD;
        EXCEPTION
                WHEN NO_DATA_FOUND THEN
        NULL;
  WHEN OTHERS THEN
            V_SQLCODE :=SQLCODE;
            V_SQLERRM :=SQLERRM;
            V_ERROR := '4';
      RAISE ERROR_PROCESO;
        END;
--DUPLICAR GA_EQUIPABOSER
        BEGIN
  INSERT INTO GA_EQUIPABOSER(
    NUM_ABONADO,
    NUM_SERIE  ,
    COD_PRODUCTO,
    IND_PROCEQUI,
    FEC_ALTA ,
    IND_PROPIEDAD,
    COD_BODEGA,
    TIP_STOCK ,
    COD_ARTICULO ,
    IND_EQUIACC ,
    COD_MODVENTA,
    TIP_TERMINAL,
    COD_USO,
    COD_CUOTA ,
    COD_ESTADO,
    CAP_CODE,
    COD_PROTOCOLO,
    NUM_VELOCIDAD,
    COD_FRECUENCIA,
    COD_VERSION ,
    NUM_SERIEMEC,
    DES_EQUIPO,
    COD_PAQUETE,
    NUM_MOVIMIENTO,
    COD_CAUSA )
                SELECT
    V_ABONADONEW,
    NUM_SERIE  ,
    COD_PRODUCTO,
    IND_PROCEQUI,
    FEC_ALTA ,
    IND_PROPIEDAD,
    COD_BODEGA,
    TIP_STOCK ,
    COD_ARTICULO ,
    IND_EQUIACC ,
    COD_MODVENTA,
    TIP_TERMINAL,
    COD_USO,
    COD_CUOTA ,
    COD_ESTADO,
    CAP_CODE,
    COD_PROTOCOLO,
    NUM_VELOCIDAD,
    COD_FRECUENCIA,
    COD_VERSION ,
    NUM_SERIEMEC,
    DES_EQUIPO,
    COD_PAQUETE,
    NUM_MOVIMIENTO,
    COD_CAUSA
              FROM GA_EQUIPABOSER
              WHERE NUM_ABONADO = V_ABONADOOLD;
        EXCEPTION
                WHEN NO_DATA_FOUND THEN
        NULL;
  WHEN OTHERS THEN
            V_SQLCODE :=SQLCODE;
            V_SQLERRM :=SQLERRM;
            V_ERROR := '4';
      RAISE ERROR_PROCESO;
        END;
--DUPLICAR GA_DIASABO
        BEGIN
       INSERT INTO GA_DIASABO(
   NUM_ABONADO ,
   COD_PRODUCTO,
   DES_DIAESP ,
   COD_TIPDIA,
   FEC_DIAESP,
   NUM_DIASNUM)
  SELECT
   V_ABONADONEW ,
   COD_PRODUCTO,
   DES_DIAESP ,
   COD_TIPDIA,
   FEC_DIAESP,
   NUM_DIASNUM
  FROM GA_DIASABO
  WHERE NUM_ABONADO = V_ABONADOOLD;
        EXCEPTION
                WHEN NO_DATA_FOUND THEN
        NULL;
  WHEN OTHERS THEN
            V_SQLCODE :=SQLCODE;
            V_SQLERRM :=SQLERRM;
            V_ERROR := '4';
      RAISE ERROR_PROCESO;
        END;
--DUPLICAR FA_ARRIENDO
        BEGIN
                INSERT INTO FA_ARRIENDO(
                                   COD_CLIENTE ,
                                   NUM_ABONADO ,
                                   FEC_DESDE ,
                                   FEC_HASTA ,
                                   COD_CONCEPTO,
                                   COD_PRODUCTO,
                                   COD_ARTICULO,
                                   PRECIO_MES,
                                   COD_MONEDA)
                                                SELECT
                                   V_CLIENTENEW ,
                                   V_ABONADONEW ,
                                   FEC_DESDE ,
                                   FEC_HASTA ,
                                   COD_CONCEPTO,
                                   COD_PRODUCTO,
                                   COD_ARTICULO,
                                   PRECIO_MES,
                                   COD_MONEDA
                FROM FA_ARRIENDO
                WHERE NUM_ABONADO = V_ABONADOOLD;
        EXCEPTION
                WHEN NO_DATA_FOUND THEN
        NULL;
  WHEN OTHERS THEN
            V_SQLCODE :=SQLCODE;
            V_SQLERRM :=SQLERRM;
            V_ERROR := '4';
      RAISE ERROR_PROCESO;
  END;
  RAISE ERROR_PROCESO;
EXCEPTION
        WHEN ERROR_PROCESO THEN
                INSERT INTO GA_TRANSACABO(NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
                VALUES (VP_TRANSAC, TO_NUMBER(V_ERROR), V_SQLERRM);
END;
/
SHOW ERRORS
