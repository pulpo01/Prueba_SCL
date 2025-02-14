CREATE OR REPLACE PROCEDURE GA_P_TRASPASO_STM(VP_CLIENTENEW IN VARCHAR2,
                                              VP_ABONADONEW IN VARCHAR2,
                                              VP_CLIENTEOLD IN VARCHAR2,
                                              VP_ABONADOOLD IN VARCHAR2,
                           VP_PROC IN OUT VARCHAR2,
                                              VP_TABLA IN OUT VARCHAR2,
                                              VP_ACT IN OUT VARCHAR2,
                                              VP_SQLCODE IN OUT VARCHAR2,
                                              VP_SQLERRM IN OUT VARCHAR2,
                                              VP_ERROR IN OUT VARCHAR2)
IS
-- Procedimiento que realiza el traspaso entre dos clientes para abonados
-- Supertelefono
--
--
V_CLIENTENEW GE_CLIENTES.COD_CLIENTE%TYPE;
V_ABONADONEW GA_ABOCEL.NUM_ABONADO%TYPE;
V_CLIENTEOLD GE_CLIENTES.COD_CLIENTE%TYPE;
V_ABONADOOLD GA_ABOCEL.NUM_ABONADO%TYPE;
V_CADENA VARCHAR2(255);
V_CAUTRAS GA_CAUSABAJA.COD_CAUSABAJA%TYPE;
V_CUENTA GA_ABOCEL.COD_CUENTA%TYPE;
V_SUBCUENTA GA_ABOCEL.COD_SUBCUENTA%TYPE;
V_USUARIO GA_ABOCEL.COD_USUARIO%TYPE;
V_TERMINAL NUMBER(8);
V_CICLO GA_ABOCEL.COD_CICLO%TYPE;
V_FECSYS DATE ;
V_INDFACT GA_ABOCEL.IND_FACTUR%TYPE;
V_CICLONEW FA_CICLOS.COD_CICLO%TYPE;
V_CREDMOR GA_ABOCEL.COD_CREDMOR%TYPE;
ERROR_PROCESO EXCEPTION;
BEGIN
        V_CLIENTENEW := TO_NUMBER(VP_CLIENTENEW);
        V_ABONADONEW := TO_NUMBER(VP_ABONADONEW);
        V_CLIENTEOLD := TO_NUMBER(VP_CLIENTEOLD);
        V_ABONADOOLD := TO_NUMBER(VP_ABONADOOLD);
-- EN PRIMER LUGAR HA DE CREARSE EL NUEVO CLIENTE PARA STM
--SELECCIONAMOS EL CICLO PARA stm
        SELECT COD_CICLO INTO V_CICLONEW FROM GA_CTC_DEFVENTA
        WHERE IND_TIPVENTA = 'S';
--DUPLICAR CLIENTE
        INSERT INTO GE_CLIENTES (
                COD_CLIENTE  ,
                NOM_CLIENTE,
                COD_TIPIDENT,
                NUM_IDENT,
                COD_CALCLIEN,
                IND_SITUACION,
                FEC_ALTA ,
                IND_FACTUR,
                IND_TRASPASO,
                IND_AGENTE,
                FEC_ULTMOD,
                NUM_FAX,
                IND_MANDATO ,
                NOM_USUARORA,
                IND_ALTA,
                COD_CUENTA,
                IND_ACEPVENT,
                COD_ABC,
                COD_123,
                COD_ACTIVIDAD,
                COD_PAIS,
                TEF_CLIENTE1,
                NUM_ABOCEL,
                TEF_CLIENTE2,
                NUM_ABOBEEP,
                IND_DEBITO,
                NUM_ABOTRUNK,
                COD_PROSPECTO,
                NUM_ABOTREK,
                COD_SISPAGO,
                NOM_APECLIEN1,
                NOM_EMAIL,
                NUM_ABORENT,
                NOM_APECLIEN2,
                NUM_ABOROAMING,
                FEC_ACEPVENT,
                IMP_STOPDEBIT,
                COD_BANCO,
                COD_SUCURSAL,
                IND_TIPCUENTA,
                COD_TIPTARJETA,
                NUM_CTACORR,
                NUM_TARJETA,
                FEC_VENCITARJ,
                COD_BANCOTARJ,
                COD_TIPIDTRIB,
                NUM_IDENTTRIB,
                COD_TIPIDENTAPOR ,
                NUM_IDENTAPOR,
                NOM_APODERADO,
                COD_OFICINA,
                FEC_BAJA,
                COD_COBRADOR,
                COD_PINCLI,
                COD_CICLO,
                NUM_CELULAR,
                IND_TIPPERSONA)
          SELECT
                V_CLIENTENEW  ,
                NOM_CLIENTE || '(STM)',
                COD_TIPIDENT,
                NUM_IDENT,
                COD_CALCLIEN,
                IND_SITUACION,
                FEC_ALTA ,
                IND_FACTUR,
                IND_TRASPASO,
                IND_AGENTE,
                FEC_ULTMOD,
                NUM_FAX,
                IND_MANDATO ,
                NOM_USUARORA,
                IND_ALTA,
                COD_CUENTA,
                IND_ACEPVENT,
                COD_ABC,
                COD_123,
                COD_ACTIVIDAD,
                COD_PAIS,
                TEF_CLIENTE1,
                0,
                TEF_CLIENTE2,
                0,
                IND_DEBITO,
                0,
                COD_PROSPECTO,
                0,
                COD_SISPAGO,
                NOM_APECLIEN1,
                NOM_EMAIL,
                NUM_ABORENT,
                NOM_APECLIEN2,
                NUM_ABOROAMING,
                FEC_ACEPVENT,
                IMP_STOPDEBIT,
                COD_BANCO,
                COD_SUCURSAL,
                IND_TIPCUENTA,
                COD_TIPTARJETA,
                NUM_CTACORR,
                NUM_TARJETA,
                FEC_VENCITARJ,
                COD_BANCOTARJ,
                COD_TIPIDTRIB,
                NUM_IDENTTRIB,
                COD_TIPIDENTAPOR ,
                NUM_IDENTAPOR,
                NOM_APODERADO,
                COD_OFICINA,
                FEC_BAJA,
                COD_COBRADOR,
                COD_PINCLI,
                V_CICLONEW,
                NUM_CELULAR,
                IND_TIPPERSONA
          FROM GE_CLIENTES
          WHERE COD_CLIENTE = V_CLIENTEOLD;
--DUPLICAMOS RESPONSABLES DE CLIENTES
         BEGIN
                INSERT INTO GA_RESPCLIENTES (
                        COD_CLIENTE,
                        NUM_ORDEN ,
                        COD_TIPIDENT,
                        NUM_IDENT,
                        NOM_RESPONSABLE)
                SELECT
                        V_CLIENTENEW,
                        NUM_ORDEN ,
                        COD_TIPIDENT,
                        NUM_IDENT,
                        NOM_RESPONSABLE
                FROM GA_RESPCLIENTES
                WHERE COD_CLIENTE = V_CLIENTEOLD;
         EXCEPTION
                        WHEN OTHERS THEN
                           VP_SQLCODE :=SQLCODE;
                           VP_SQLERRM :=SQLERRM;
                           VP_ERROR := '4';
                           RAISE ERROR_PROCESO;
         END;
--DUPLICAMOS LAS DIRECCIONES DEL CLIENTE
         BEGIN
                INSERT INTO GA_DIRECCLI(
                        COD_CLIENTE,
                        COD_TIPDIRECCION,
                        COD_DIRECCION)
                SELECT
                        V_CLIENTENEW,
                        COD_TIPDIRECCION,
                        COD_DIRECCION
                FROM GA_DIRECCLI
                WHERE COD_CLIENTE = V_CLIENTEOLD;
         EXCEPTION
                 WHEN OTHERS THEN
                           VP_SQLCODE :=SQLCODE;
                           VP_SQLERRM :=SQLERRM;
                           VP_ERROR := '4';
                           RAISE ERROR_PROCESO;
         END;
--DUPLICAR CATEGORIA IMPOSITIVA
         BEGIN
                INSERT INTO GE_CATIMPCLIENTES(
                COD_CLIENTE,
                FEC_DESDE,
                FEC_HASTA,
                COD_CATIMPOS)
             SELECT
                V_CLIENTENEW,
                FEC_DESDE,
                FEC_HASTA,
                COD_CATIMPOS
             FROM GE_CATIMPCLIENTES
             WHERE COD_CLIENTE = V_CLIENTEOLD;
         EXCEPTION
                WHEN OTHERS THEN
                           VP_SQLCODE :=SQLCODE;
                           VP_SQLERRM :=SQLERRM;
                           VP_ERROR := '4';
                           RAISE ERROR_PROCESO;
         END;
--DUPLICAR PLAN COMERCIAL
         BEGIN
                INSERT INTO GA_CLIENTE_PCOM(
                        COD_CLIENTE ,
                        COD_PLANCOM,
                        FEC_DESDE,
                        NOM_USUARORA,
                        FEC_HASTA)
                SELECT
                        V_CLIENTENEW ,
                        COD_PLANCOM,
                        FEC_DESDE,
                        NOM_USUARORA,
                        FEC_HASTA
                FROM GA_CLIENTE_PCOM
                WHERE COD_CLIENTE = V_CLIENTEOLD;
         EXCEPTION
                WHEN OTHERS THEN
                           VP_SQLCODE :=SQLCODE;
                           VP_SQLERRM :=SQLERRM;
                           VP_ERROR := '4';
                           RAISE ERROR_PROCESO;
         END;
--********************duplicar abonado******************
-- DUPLICAR FILA PARA GA_ABOCEL
     BEGIN
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
                        COD_TECNOLOGIA,
                        NUM_IMEI )
            SELECT
                        V_ABONADONEW,
                        NUM_CELULAR,
                        COD_PRODUCTO,
                        V_CLIENTENEW,
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
                        COD_TECNOLOGIA,
                        NUM_IMEI
            FROM GA_ABOCEL
            WHERE NUM_ABONADO = V_ABONADOOLD;
        EXCEPTION
                WHEN OTHERS THEN
                   VP_SQLCODE :=SQLCODE;
                   VP_SQLERRM :=SQLERRM;
                   VP_ERROR := '4';
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
                   VP_SQLCODE :=SQLCODE;
                   VP_SQLERRM :=SQLERRM;
                   VP_ERROR := '4';
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
                   VP_SQLCODE :=SQLCODE;
                   VP_SQLERRM :=SQLERRM;
                   VP_ERROR := '4';
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
                   VP_SQLCODE :=SQLCODE;
                   VP_SQLERRM :=SQLERRM;
                   VP_ERROR := '4';
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
                   VP_SQLCODE :=SQLCODE;
                   VP_SQLERRM :=SQLERRM;
                   VP_ERROR := '4';
                   RAISE ERROR_PROCESO;
        END;
--DUPLICAR MODABOCEL
        BEGIN
                INSERT INTO GA_MODABOCEL(
                        NUM_ABONADO,
                        COD_TIPMODI,
                        FEC_MODIFICA ,
                        NOM_USUARORA  ,
                        NUM_CELULAR  ,
                        COD_REGION   ,
                        COD_PROVINCIA ,
                        COD_CIUDAD    ,
                        COD_CELDA     ,
                        COD_CENTRAL   ,
                        COD_USO       ,
                        TIP_PLANTARIF ,
                        TIP_TERMINAL  ,
                        COD_PLANTARIF ,
                        COD_CARGOBASICO,
                        COD_PLANSERV   ,
                        COD_LIMCONSUMO ,
                        NUM_SERIE      ,
                        NUM_SERIEHEX  ,
                        NUM_SERIEMEC ,
                        COD_HOLDING ,
                        COD_EMPRESA ,
                        COD_GRPSERV ,
                        NUM_TELEFIJA ,
                        COD_OPREDFIJA ,
                        IND_SUPERTEL  ,
                        COD_CARRIER  ,
                        IND_PLEXSYS  ,
                        COD_CENTRAL_PLEX ,
                        NUM_CELULAR_PLEX ,
                        COD_CREDMOR     ,
                        COD_CREDCON    ,
                        COD_CICLO     ,
                        IND_FACTUR   ,
                        IND_SUSPEN  ,
                        IND_REHABI ,
                        IND_INSGUIAS ,
                        NUM_PERSONAL ,
                        COD_CAUSA   )
               SELECT
                        V_ABONADONEW,
                        COD_TIPMODI,
                        FEC_MODIFICA ,
                        NOM_USUARORA  ,
                        NUM_CELULAR  ,
                        COD_REGION   ,
                        COD_PROVINCIA ,
                        COD_CIUDAD    ,
                        COD_CELDA     ,
                        COD_CENTRAL   ,
                        COD_USO       ,
                        TIP_PLANTARIF ,
                        TIP_TERMINAL  ,
                        COD_PLANTARIF ,
                        COD_CARGOBASICO,
                        COD_PLANSERV   ,
                        COD_LIMCONSUMO ,
                        NUM_SERIE      ,
                        NUM_SERIEHEX  ,
                        NUM_SERIEMEC ,
                        COD_HOLDING ,
                        COD_EMPRESA ,
                        COD_GRPSERV ,
                        NUM_TELEFIJA ,
                        COD_OPREDFIJA ,
                        IND_SUPERTEL  ,
                        COD_CARRIER  ,
                        IND_PLEXSYS  ,
                        COD_CENTRAL_PLEX ,
                        NUM_CELULAR_PLEX ,
                        COD_CREDMOR     ,
                        COD_CREDCON    ,
                        COD_CICLO     ,
                        IND_FACTUR   ,
                        IND_SUSPEN  ,
                        IND_REHABI ,
                        IND_INSGUIAS ,
                        NUM_PERSONAL ,
                        COD_CAUSA
                 FROM GA_MODABOCEL
                 WHERE NUM_ABONADO = V_ABONADOOLD;
        EXCEPTION
                WHEN NO_DATA_FOUND THEN
                      NULL;
                WHEN OTHERS THEN
                   VP_SQLCODE :=SQLCODE;
                   VP_SQLERRM :=SQLERRM;
                   VP_ERROR := '4';
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
                   VP_SQLCODE :=SQLCODE;
                   VP_SQLERRM :=SQLERRM;
                   VP_ERROR := '4';
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
                                COD_CAUSA,
                                NUM_IMEI )
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
                                COD_CAUSA,
                                NUM_IMEI
              FROM GA_EQUIPABOSER
              WHERE NUM_ABONADO = V_ABONADOOLD;
        EXCEPTION
                WHEN NO_DATA_FOUND THEN
                      NULL;
                WHEN OTHERS THEN
                   VP_SQLCODE :=SQLCODE;
                   VP_SQLERRM :=SQLERRM;
                   VP_ERROR := '4';
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
                   VP_SQLCODE :=SQLCODE;
                   VP_SQLERRM :=SQLERRM;
                   VP_ERROR := '4';
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
                   VP_SQLCODE :=SQLCODE;
                   VP_SQLERRM :=SQLERRM;
                   VP_ERROR := '4';
                   RAISE ERROR_PROCESO;
        END;
--DESPUES DE DUPLICAR LOS REGISTROS PARA EL NUEVO ABONADO
--HAY QUE MODIFICAR LOS DATOS DEL ANTIGUO
        SELECT COD_CAUTRAS INTO V_CAUTRAS FROM GA_DATOSGENER;
        UPDATE GA_ABOCEL SET
                COD_SITUACION = 'BAA',
                FEC_BAJA = SYSDATE,
                FEC_BAJACEN = SYSDATE,
                COD_CAUSABAJA = V_CAUTRAS
        WHERE NUM_ABONADO = V_ABONADOOLD;
--INSERTAR EN GA_TRASPABO
        SELECT  NUM_CELULAR ,
                COD_CUENTA,
                COD_SUBCUENTA,
                COD_USUARIO,
                COD_CICLO,
                SYSDATE,
                IND_FACTUR,
                COD_CREDMOR
        INTO    V_TERMINAL,
                V_CUENTA,
                V_SUBCUENTA,
                V_USUARIO,
                V_CICLO,
                V_FECSYS,
                V_INDFACT,
                V_CREDMOR
        FROM GA_ABOCEL
                WHERE NUM_ABONADO = V_ABONADOOLD;
        INSERT INTO GA_TRASPABO(
                NUM_ABONADO ,
                FEC_MODIFICA ,
                COD_CLIENNUE ,
                COD_CUENTANUE,
                COD_SUBCTANUE,
                COD_USUARNUE ,
                COD_PRODUCTO ,
                NUM_TERMINAL ,
                NUM_ABONADOANT,
                COD_CLIENANT ,
                COD_CUENTAANT,
                COD_SUBCTAANT,
                COD_USUARANT ,
                IND_TRASDEUDA,
                NOM_USUARORA )
        VALUES(
                V_ABONADONEW,
                SYSDATE,
                V_CLIENTENEW,
                V_CUENTA,
                V_SUBCUENTA,
                V_USUARIO,
                1,
                V_TERMINAL,
                V_ABONADOOLD,
                V_CLIENTEOLD,
                V_CUENTA,
                V_SUBCUENTA,
                V_USUARIO,
                2,
                USER);
--ACTUALIZAMOS EL NUMERO DE ABONADOS PARA LOS DOS CLIENTES
        UPDATE GE_CLIENTES SET NUM_ABOCEL = NUM_ABOCEL + 1
        WHERE COD_CLIENTE = V_CLIENTENEW;
        UPDATE GE_CLIENTES SET NUM_ABOCEL = NUM_ABOCEL - 1
        WHERE COD_CLIENTE = V_CLIENTEOLD;
--LLAMAMOS A LOS PLs DE TRASPASO
       dbms_output.put_line ('antes de TRASINfac ' );
       GA_P_TRASINFAC_STM (V_CLIENTEOLD,V_ABONADOOLD,V_ABONADONEW,
                            V_CICLO, V_CICLONEW, V_FECSYS,V_CLIENTENEW,VP_PROC,VP_TABLA,VP_ACT,
                            VP_SQLCODE,VP_SQLERRM,VP_ERROR);
               dbms_output.put_line ('Despues de TRASINfac ' || VP_ERROR);
       IF VP_ERROR <> '0' THEN
          VP_ERROR := '4';
          RAISE ERROR_PROCESO;
       END IF;
       VP_PROC := 'P_INTERFASES_CELULAR';
       dbms_output.put_line ('antes de TRASINTAR ');
       GA_P_TRASINTAR_STM (V_CLIENTEOLD,V_ABONADOOLD,V_ABONADONEW,
                            V_CICLO,V_CICLONEW, V_FECSYS,V_CLIENTENEW,VP_PROC,VP_TABLA,
                            VP_ACT,VP_SQLCODE,VP_SQLERRM,VP_ERROR);
               dbms_output.put_line ('Despues de TRASINTAR ' || VP_ERROR);
       IF VP_ERROR <> '0' THEN
          VP_ERROR := '4';
          RAISE ERROR_PROCESO;
       END IF;
       VP_PROC := 'P_INTERFASES_CELULAR';
                       dbms_output.put_line ('antes de ciclocli');
       IF V_INDFACT = 1 THEN
          P_ALTA_CICLOCLI(1,V_CLIENTENEW,V_ABONADONEW,V_CICLO,'A',
                          NULL,V_CREDMOR,V_USUARIO,V_FECSYS, VP_PROC,VP_TABLA,
                          VP_ACT,VP_SQLCODE,VP_SQLERRM,VP_ERROR);
       ELSE
          P_ALTA_NOCICLOCLI(1,V_CLIENTENEW,V_ABONADONEW,V_CICLO,'A',
                            NULL,V_CREDMOR,V_USUARIO,VP_PROC,VP_TABLA,
                             VP_ACT,VP_SQLCODE,VP_SQLERRM,VP_ERROR);
       END IF;
               dbms_output.put_line ('Antes de Ciclocli ' || VP_ERROR);
          IF VP_ERROR <> '0' THEN
             VP_ERROR := '4';
             RAISE ERROR_PROCESO;
          END IF;
          VP_PROC := 'P_INTERFASES_CELULAR';
EXCEPTION
       WHEN ERROR_PROCESO THEN
           IF VP_SQLCODE IS NULL THEN
                VP_SQLCODE := SUBSTR(SQLCODE,1,10);
                VP_SQLERRM := SUBSTR(SQLERRM,1,10);
           END IF;
        dbms_output.put_line ('todo dabuti sin error' || VP_ERROR);
       WHEN OTHERS THEN
                VP_SQLCODE := SUBSTR(SQLCODE,1,10);
                VP_SQLERRM := SUBSTR(SQLERRM,1,10);
           VP_ERROR := '4';
END;
/
SHOW ERRORS
