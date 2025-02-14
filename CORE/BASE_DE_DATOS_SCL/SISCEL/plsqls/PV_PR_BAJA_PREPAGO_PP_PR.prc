CREATE OR REPLACE PROCEDURE PV_PR_BAJA_PREPAGO_PP_PR
(
  EN_transaccion  IN VARCHAR2,
  EN_abonado       IN VARCHAR2,
  EV_actabo        IN VARCHAR2,
  EV_usuario       IN VARCHAR2,
  EV_causa         IN VARCHAR2,
  EN_saldo         IN NUMBER
)

IS
   -- PROCEDIMIENTO QUE REALIZA LA BAJA DEL ABONADO PREPAGO
   GN_producto           GE_PRODUCTOS.cod_producto%TYPE;
   GN_num_abocel         GE_CLIENTES.num_abocel%TYPE;
   GV_abonado            GA_ABOCEL.num_abonado%TYPE;
   GV_actabo            GAD_ORIDESUSO.cod_actabo%TYPE;
   GN_num_movimiento     ICC_MOVIMIENTO.num_movimiento%TYPE;
   sFormatoFecha           GED_PARAMETROS.val_parametro%TYPE;
   sFormatoHora         GED_PARAMETROS.val_parametro%TYPE;
   GV_actabo1              ICC_MOVIMIENTO.cod_actabo%TYPE;
   GV_tiplan               TA_PLANTARIF.cod_tiplan%TYPE;
   GV_causa             NUMBER:= 0;
   GN_vigencia          NUMBER:= 1;
   LN_CANTIDAD_GA_CELNUM_USO NUMBER(2):= 1;
   GV_situac            VARCHAR2(5);
   GD_fecsys             DATE;
   --CONSTANTES
   CV_nompara           GED_PARAMETROS.nom_parametro%TYPE :='BAJA_MAS_DEVOLUCION';
   CV_nompara1          GED_PARAMETROS.cod_modulo%TYPE    :='GA';
   CV_nompara2          GED_PARAMETROS.nom_parametro%TYPE :='FORMATO_SEL2';
   CV_nompara3          GED_PARAMETROS.nom_parametro%TYPE :='FORMATO_SEL7';
   -- CONTROL DE ERRORES
   GV_error1            VARCHAR2(1);    --4 0 CERO
   GV_cadena            GA_TRANSACABO.DES_CADENA%TYPE; --CADENA COMPUESTA CON LOS DATOS QUE SE INSERTARAN EN GA_TRANSACABO
   --SALIDA DE ERROR_PROCESO
   GV_proc              GA_TRANSACABO.DES_CADENA%TYPE;
   GV_tabla              VARCHAR2(50);
   GV_Act               VARCHAR2(1);
   GV_sqlerrm            VARCHAR2(60):= '';
   GV_sqlcode            VARCHAR2(15):= '';
   --ENTRADA DE ERROR EN LA ICC_MOVIMIENTO
   GV_error             VARCHAR2(25);
   --FORMATO


   /* Declaramos variables para el Abonado */
   GV_numabonado        VARCHAR2(50);
   GV_situacion         VARCHAR2(50);
   GV_cliente           VARCHAR2(50);
   GV_central           VARCHAR2(50);
   GV_celular           VARCHAR2(50);
   GV_tipoterminal      VARCHAR2(50);
   GV_serie             VARCHAR2(25);
   GV_modventa          VARCHAR2(50);
   GV_procequi          VARCHAR2(50);
   GV_numcontrato       VARCHAR2(50);
   GV_numanexo          VARCHAR2(50);
   GV_codpenaliza       VARCHAR2(50);
   GV_penalizacion      VARCHAR2(50);
   GV_fincontrato       VARCHAR2(50);
   GV_cuenta             VARCHAR2(50);
   GV_tecnologia        VARCHAR2(50);
   GV_imei              VARCHAR2(50);
   GV_plantarifario     VARCHAR2(3);
-- XO-200510100835 Inicio : Responsable cambio : Zenen Muñoz H. : fecha:11-10-2005 :  Desc:  Declara variable de paso para indicador de teléfono*
   GV_IND_TELEFONO      NUMBER(1);
-- Fin Cambio Incidencia XO-200510100835

--INICIO MA-45289|06-12-2007|JJR *******************************************************
   NINDLN           GA_CAUSABAJA.IND_LN%TYPE; --MA-45289|06-12-2007|JJR
   PARAMETRO         VARCHAR2(1); --MA-45289|06-12-2007|JJR
   GV_TRANSAC         GA_TRANSACABO.NUM_TRANSACCION%TYPE := 0;-- P-COL-06054 Y.O.
   DATO_CAUSA         NUMBER;     --MA-45289|06-12-2007|JJR
   COD_CAUSA_PL     VARCHAR(2); --MA-45289|06-12-2007|JJR
   sCodGSM             GA_ABOCEL.COD_TECNOLOGIA%TYPE;
   nNumError        NUMBER (2);
--FIN MA-45289|06-12-2007|JJR ***********************************************************

   vNumSerie               GA_ABOCEL.NUM_SERIE%TYPE;
   vNumSerieMec            GA_ABOCEL.NUM_SERIEMEC%TYPE;
   vCodOperador            TA_DATOSGENER.COD_OPERADOR%TYPE;
   GV_SERIEMEC             GA_ABOCEL.NUM_SERIEMEC%TYPE;
   vNumCelular             GA_ABOCEL.NUM_CELULAR%TYPE;

   ERROR_PROCESO EXCEPTION;



BEGIN --0

        GV_abonado  := TO_NUMBER(EN_abonado);
        GV_actabo   := EV_actabo;
        GV_proc     := 'PV_PR_BAJA_PREPAGO_PP_PR';
        GN_producto := 1;
        GV_error1   := '4';
        nNumError   := 0;--Operacion Exitosa MA-45289|06-12-2007|JJR

           BEGIN --10
        sFormatoFecha := SP_FN_FORMATOFECHA(CV_nompara2);
        GD_fecsys     := SYSDATE;

        GV_sqlcode := -20211;

        SELECT COUNT(1)
        INTO   GV_causa
        FROM   GED_PARAMETROS a
              ,GA_CAUSABAJA   b
        WHERE  a.nom_parametro = CV_nompara
        AND    a.cod_modulo    = CV_nompara1
        AND    a.cod_producto  = GN_producto
        AND    a.cod_producto  = b.cod_producto
        AND    a.val_parametro = b.cod_causabaja
        AND    b.cod_causabaja = EV_causa
        AND    b.ind_vigencia  = GN_vigencia;

        IF GV_causa > 0 THEN
           GV_situac :='BAA';
           ELSE IF GV_causa = 0 THEN
           GV_situac :='BAP';
           ELSE
            RAISE ERROR_PROCESO;
           END IF;
        END IF;

          EXCEPTION
             WHEN OTHERS THEN
               GV_sqlcode := -20212;
               GV_sqlerrm := SUBSTR(SQLERRM,1,60);   --COL-69461|22-08-2008|DVG
               RAISE ERROR_PROCESO;
        END; --10

           /* Obtenemos Datos del Abonado */
        BEGIN --1

            SELECT  num_abonado --2
                   ,cod_situacion
                   ,cod_cliente
                   ,cod_central
                   ,num_celular
                   ,tip_terminal
                   ,num_serie
                   ,cod_modventa
                   ,ind_procequi
                   ,' '
                   ,' '
                   ,cod_cuenta
                   ,cod_tecnologia
                   ,num_imei
                   ,cod_plantarif
-- XO-200510100835 Inicio : Responsable cambio : Zenen Muñoz H. : fecha:11-10-2005 :  Desc:  Recupera campo Indicador de teléfono de Abonado Prepago*
                   ,IND_TELEFONO
                   ,NUM_SERIEMEC
-- Fin Cambio Incidencia XO-200510100835
            INTO    GV_numabonado
                   ,GV_situacion
                   ,GV_cliente
                   ,GV_central
                   ,GV_celular
                   ,GV_tipoterminal
                   ,GV_serie
                   ,GV_modventa
                   ,GV_procequi
                   ,GV_numcontrato
                   ,GV_numanexo
                   ,GV_cuenta
                   ,GV_tecnologia
                   ,GV_imei
                   ,GV_plantarifario
-- XO-200510100835 Inicio : Responsable cambio : Zenen Muñoz H. : fecha:11-10-2005 :  Desc:  Graba campo Indicador de teléfono de Abonado Prepago*
                   ,GV_IND_TELEFONO
                   ,GV_SERIEMEC
-- Fin Cambio Incidencia XO-200510100835
            FROM    GA_ABOAMIST
            WHERE   num_abonado = GV_ABONADO
            FOR UPDATE NOWAIT;
            GV_tabla := 'GA_ABOAMIST';
            EXCEPTION --2
                WHEN NO_DATA_FOUND THEN
                BEGIN --4

                        SELECT  num_abonado --3
                               ,cod_situacion
                               ,cod_cliente
                               ,cod_central
                               ,num_celular
                               ,tip_terminal
                               ,num_serie
                               ,cod_modventa
                               ,ind_procequi
                               ,' '
                               ,' '
                               ,cod_cuenta
                               ,cod_tecnologia
                               ,num_imei
                               ,cod_plantarif
-- XO-200510100835 Inicio : Responsable cambio : Zenen Muñoz H. : fecha:11-10-2005 :  Desc:  Recupera campo Indicador de teléfono de Abonado Contrato*
                               ,-1 -- este campo no se utiliza para contrato
-- Fin Cambio Incidencia XO-200510100835
                               ,NUM_SERIEMEC
                        INTO    GV_numabonado
                               ,GV_situacion
                               ,GV_cliente
                               ,GV_central
                               ,GV_celular
                               ,GV_tipoterminal
                               ,GV_serie
                               ,GV_modventa
                               ,GV_procequi
                               ,GV_numcontrato
                               ,GV_numanexo
                               ,GV_cuenta
                               ,GV_tecnologia
                               ,GV_imei
                               ,GV_plantarifario
-- XO-200510100835 Inicio : Responsable cambio : Zenen Muñoz H. : fecha:11-10-2005 :  Desc:  Graba campo Indicador de teléfono de Abonado Prepago*
                               ,GV_IND_TELEFONO
-- Fin Cambio Incidencia XO-200510100835
                               ,GV_SERIEMEC
                        FROM    GA_ABOCEL
                        WHERE   num_abonado = GV_abonado
                          FOR UPDATE NOWAIT;

                                BEGIN
                                   SELECT C.cod_penaliza
                                   INTO   GV_codpenaliza
                                   FROM   GA_CONTCTA B
                                        ,GA_PERCONTRATO C
                                   WHERE  B.cod_cuenta      = GV_cuenta
                                   AND    B.num_contrato(+) = GV_numcontrato
                                   AND    B.num_anexo(+)    = GV_numanexo
                                   AND    B.cod_tipcontrato = C.cod_tipcontrato(+)
                                   AND    B.num_meses       = C.num_meses(+)
                                   AND    B.cod_producto    = C.cod_producto(+);

                                EXCEPTION
                                             WHEN NO_DATA_FOUND THEN
                                                    GV_codpenaliza := '';
                                             WHEN OTHERS THEN
                                       GV_sqlcode := -20213;
                                                    GV_sqlerrm := SUBSTR(SQLERRM,1,60);   --COL-69461|22-08-2008|DVG
                                                    RAISE ERROR_PROCESO;
                                END;

                                BEGIN

                                   SELECT d.cod_penaliza,TO_CHAR(a.fec_fincontrato,sFormatoFecha)
                                   INTO   GV_penalizacion
                                        ,GV_fincontrato
                                   FROM   GA_PERCONTRATO d
                                        ,GA_TIPOSEGURO  c
                                        ,GA_SEGURABO    a
                                   WHERE  a.num_abonado      = GV_numabonado
                                   AND    a.fec_fincontrato >= GD_fecsys
                                   AND    d.cod_producto     = c.cod_producto
                                   AND    c.cod_tipsegu      = a.cod_tipsegu
                                   AND    d.cod_tipcontrato  = c.cod_tipcontrato;

                                EXCEPTION
                                               WHEN NO_DATA_FOUND THEN
                                                    GV_penalizacion := '';
                                                    GV_fincontrato  := '';
                                               WHEN OTHERS THEN
                                           GV_sqlcode := -20214;
                                                    GV_sqlerrm := SUBSTR(SQLERRM,1,60);   --COL-69461|22-08-2008|DVG
                                                    RAISE ERROR_PROCESO;

                                END;

                               GV_proc  := 'ACTUALIZA FECHA VIGENCIA ABONADO';
                               GV_tabla := 'GA_INTARCEL';
                               GV_Act   := 'U';

                                  UPDATE GA_INTARCEL
                               SET    fec_hasta  = GD_fecsys
                               WHERE  num_abonado= GV_abonado
                               AND    cod_cliente= GV_cliente
                               AND    fec_hasta  = (SELECT MAX(fec_hasta)
                               FROM   GA_INTARCEL
                               WHERE  num_abonado= GV_abonado
                               AND    GD_fecsys >= fec_desde
                               AND    GD_fecsys <= fec_hasta);

                               GV_proc  := 'ACTUALIZA FECHA VIGENCIA ABONADO';
                               GV_tabla := 'GA_INFACCEL';
                               GV_Act   := 'U';

                               UPDATE GA_INFACCEL
                               SET    fec_baja   = GD_fecsys
                               WHERE  num_abonado= GV_abonado
                               AND    cod_cliente= GV_cliente
                               AND    fec_baja   = (SELECT MAX(fec_baja)
                               FROM   GA_INTARCEL
                               WHERE  num_abonado= GV_abonado
                               AND    GD_fecsys >= fec_alta
                               AND    GD_fecsys <= fec_baja );

                               GV_tabla := 'GA_ABOCEL';

                        EXCEPTION --3
                            WHEN NO_DATA_FOUND THEN
                 GV_sqlcode := -20219;
                                 RAISE ERROR_PROCESO;

                            WHEN OTHERS THEN
                 GV_sqlcode := -20215;
                 GV_sqlerrm := SUBSTR(SQLERRM,1,60);   --COL-69461|22-08-2008|DVG
                                 RAISE ERROR_PROCESO;

                 END;--4

            WHEN OTHERS THEN --2
            GV_sqlcode := -20216;
            GV_sqlerrm := SUBSTR(SQLERRM,1,60);   --COL-69461|22-08-2008|DVG
                        RAISE ERROR_PROCESO;
       END;--1

          BEGIN
                UPDATE  GA_ABOAMIST
                SET     cod_situacion = GV_situac
                       ,fec_baja      = GD_fecsys
                       ,fec_ultmod    = GD_fecsys
                       ,cod_causabaja = EV_causa
                WHERE   num_abonado   = GV_abonado;

                   EXCEPTION
                WHEN NO_DATA_FOUND THEN

                 BEGIN

                    UPDATE  GA_ABOCEL
                    SET     cod_situacion = GV_situac
                           ,fec_baja      = GD_fecsys
                           ,fec_ultmod    = GD_fecsys
                           ,cod_causabaja = EV_causa
                    WHERE   num_abonado   = GV_abonado;

                        EXCEPTION
                       WHEN OTHERS THEN
                    GV_sqlcode := -20217;
                                 GV_sqlerrm := SUBSTR(SQLERRM,1,60);   --COL-69461|22-08-2008|DVG
                                 RAISE ERROR_PROCESO;
                 END;
           WHEN OTHERS THEN
            GV_sqlcode := -20218;
            GV_sqlerrm := SUBSTR(SQLERRM,1,60);   --COL-69461|22-08-2008|DVG
                    RAISE ERROR_PROCESO;
          END;

           IF GV_causa > 0 THEN
              --dbms_output.PUT_LINE('ABONADO  =' || GV_numabonado);

              IF LTRIM(RTRIM(GV_numabonado)) ='' OR GV_numabonado IS NULL THEN
                  GV_sqlcode := -20219;
                  RAISE ERROR_PROCESO;
              END IF;

              GV_tabla := 'GA_SERVSUPLABO';
              GV_Act   := 'U';
               -- Servicios Suplementarios del Abonado
               UPDATE GA_SERVSUPLABO
               SET    fec_bajabd = GD_fecsys,
                      IND_ESTADO = 5
               WHERE  num_abonado = GV_abonado
               AND    ind_estado < 3;

              GV_error1:= '0';    --aqui se marca que no sea error  y en el raise que deje todo hasta aqui
              GV_proc  := 'DEVOLUCION DE KIT BAJA ABONADO EXITOSO';
              GV_sqlcode := '';
              GV_sqlerrm := '';
              RAISE ERROR_PROCESO;

           END IF;

              --dbms_output.PUT_LINE('PASO 4  = CONCIERNE A PUNTUAL O MASIVA' );
           GV_proc  := 'RESCATO NUMEROS DE ABONADOS DEL CLIENTE';
           GV_Act   := 'S';
              BEGIN --7
              SELECT num_abocel
              INTO   GN_num_abocel
              FROM   GE_CLIENTES
              WHERE  cod_cliente = GV_cliente;

              GV_proc  := 'RESTO ABONADO A NUMERO DE ABONADOS DEL CLIENTE';
              GV_Act   := 'U';
              IF GN_num_abocel > 0 THEN
                 UPDATE GE_CLIENTES
                 SET    num_abocel = NUM_ABOCEL - 1
                 WHERE  cod_cliente = GV_cliente;
              END IF;

           EXCEPTION
              WHEN NO_DATA_FOUND THEN
                   GN_num_abocel := '';
              WHEN OTHERS THEN
           GV_sqlcode := -20080;
           GV_sqlerrm := SUBSTR(SQLERRM,1,60);   --COL-69461|22-08-2008|DVG
                   RAISE ERROR_PROCESO;
           END; --7

            BEGIN --8
              SELECT cod_tiplan
              INTO   GV_tiplan
              FROM   TA_PLANTARIF
              WHERE  cod_plantarif = GV_plantarifario
              AND    cod_producto  = GN_producto;

           EXCEPTION
              WHEN NO_DATA_FOUND THEN
                   GV_sqlcode := -20090;
                   RAISE ERROR_PROCESO;
              WHEN OTHERS THEN
           GV_sqlcode := -20100;
           GV_sqlerrm := SUBSTR(SQLERRM,1,60);   --COL-69461|22-08-2008|DVG
                   RAISE ERROR_PROCESO;
           END; -- 8

            BEGIN --9
              SELECT cod_actabo
              INTO   GV_actabo1
              FROM   PV_ACTABO_TIPLAN
              WHERE  cod_tipmodi = EV_actabo
              AND    cod_tiplan  = GV_tiplan;

           EXCEPTION
              WHEN NO_DATA_FOUND THEN
                   GV_actabo1 := EV_actabo;
              WHEN OTHERS THEN
           GV_sqlcode := -20110;
           GV_sqlerrm := SUBSTR(SQLERRM,1,60);   --COL-69461|22-08-2008|DVG
                   RAISE ERROR_PROCESO;
           END; --9
-- XO-200510100835 Inicio : Responsable cambio : Zenen Muñoz H. : fecha:11-10-2005 :  Desc:  Controla que el terminal se encuentra bloqueado, con indicador = 6 y no se puede volver a bloquear*
       IF GV_IND_TELEFONO <> 6 THEN -- El terminal ya se encuentra bloqueado, no se puede volver a bloquear
-- Fin Cambio Incidencia XO-200510100835
           PV_PRC_INS_MOVIMIENTO_PR(EN_transaccion,GV_abonado,GV_actabo1,EV_usuario,0,EV_causa,'',GN_num_movimiento,GV_sqlcode,GV_sqlerrm,GV_error);

           IF TO_NUMBER(GV_sqlcode) <> 1 THEN
                 GV_sqlcode := -20120;
                 RAISE ERROR_PROCESO;
           END IF;

-- XO-200510100835 Inicio : Responsable cambio : Zenen Muñoz H. : fecha:11-10-2005 :  Desc:  Fin IF para controlar el terminal que se encuentre bloqueado*
          END IF;
-- Fin Cambio Incidencia XO-200510100835

           BEGIN
               -- Servicios Suplementarios del Abonado
               UPDATE GA_SERVSUPLABO
               SET    fec_bajabd =GD_fecsys,
                      IND_ESTADO = 5
               WHERE  num_abonado = GV_abonado
               AND    ind_estado < 3;
               EXCEPTION
               WHEN OTHERS THEN
           GV_sqlcode := -20130;
           GV_sqlerrm := SUBSTR(SQLERRM,1,60);   --COL-69461|22-08-2008|DVG
                   RAISE ERROR_PROCESO;
           END;

           LN_CANTIDAD_GA_CELNUM_USO:=0;
           BEGIN

                SELECT  COUNT(1)
                INTO LN_CANTIDAD_GA_CELNUM_USO
                FROM GA_CELNUM_USO  A
                WHERE a.cod_producto = GN_producto
                AND GV_celular  = a.NUM_DESDE;

                IF LN_CANTIDAD_GA_CELNUM_USO > 0 THEN

                       BEGIN

                               INSERT INTO GA_CELNUM_REUTIL
                               (num_celular,cod_subalm,cod_producto,cod_central,cod_cat,cod_uso,fec_baja,ind_equipado)
                              (SELECT GV_celular
                               ,a.cod_subalm
                               ,a.cod_producto
                               ,a.cod_central
                               ,a.cod_cat
                               ,a.cod_uso
                               , GD_fecsys
                               , 1
                                FROM GA_CELNUM_USO a
                                WHERE a.cod_producto = GN_producto
                                AND GV_celular  = a.NUM_DESDE);


                        --AND GV_celular >= a.num_desde    --AND GV_celular <= a.num_hasta);
                        EXCEPTION
                                  WHEN OTHERS THEN
                               GV_sqlcode := -20140;
                               GV_sqlerrm := SUBSTR(SQLERRM,1,60);   --COL-69461|22-08-2008|DVG
                                       RAISE ERROR_PROCESO;
                        END;

                ELSE

                         BEGIN

                               INSERT INTO GA_CELNUM_REUTIL
                               (num_celular,cod_subalm,cod_producto,cod_central,cod_cat,cod_uso,fec_baja,ind_equipado)
                              (SELECT GV_celular
                               ,a.cod_subalm
                               ,a.cod_producto
                               ,a.cod_central
                               ,a.cod_cat
                               ,a.cod_uso
                               , GD_fecsys
                               , 1
                                FROM GA_CELNUM_USO a
                                WHERE a.cod_producto = GN_producto
                                --AND GV_celular  = a.NUM_HASTA);
                                AND GV_celular  between a.NUM_DESDE and a.NUM_HASTA);-- CR-192242|04-03-2013|JHA

                        --AND GV_celular >= a.num_desde    --AND GV_celular <= a.num_hasta);
                        EXCEPTION
                                  WHEN OTHERS THEN
                               GV_sqlcode := -20140;
                               GV_sqlerrm := SUBSTR(SQLERRM,1,60);   --COL-69461|22-08-2008|DVG
                                       RAISE ERROR_PROCESO;
                        END;



                END IF;


           EXCEPTION

                    WHEN NO_DATA_FOUND THEN


                    BEGIN

                               INSERT INTO GA_CELNUM_REUTIL
                               (num_celular,cod_subalm,cod_producto,cod_central,cod_cat,cod_uso,fec_baja,ind_equipado)
                              (SELECT GV_celular
                               ,a.cod_subalm
                               ,a.cod_producto
                               ,a.cod_central
                               ,a.cod_cat
                               ,a.cod_uso
                               , GD_fecsys
                               , 1
                                FROM GA_CELNUM_USO a
                                WHERE a.cod_producto = GN_producto
                                --AND GV_celular  = a.NUM_HASTA);
                                AND GV_celular  between a.NUM_DESDE and a.NUM_HASTA);-- CR-192242|04-03-2013|JHA


                        --AND GV_celular >= a.num_desde    --AND GV_celular <= a.num_hasta);
                    EXCEPTION
                                  WHEN OTHERS THEN
                               GV_sqlcode := -20140;
                               GV_sqlerrm := SUBSTR(SQLERRM,1,60);   --COL-69461|22-08-2008|DVG
                                       RAISE ERROR_PROCESO;
                    END;


           END;

            --INICIO MA-45289|06-12-2007|JJR
            BEGIN
               SELECT IND_LN
               INTO nIndLn
               FROM GA_CAUSABAJA
               WHERE COD_PRODUCTO=GN_producto
               AND COD_CAUSABAJA=EV_causa;
             EXCEPTION
             WHEN OTHERS THEN
           GV_sqlcode := -20150;
           GV_sqlerrm := SUBSTR(SQLERRM,1,60);   --COL-69461|22-08-2008|DVG
                   RAISE ERROR_PROCESO;
             END;

             IF nIndLn=1 THEN

                 --BEGIN
                --    SELECT VALOR_NUMERICO
                --    INTO   PARAMETRO
                --        FROM   PV_PARAMETROS_SIMPLES_VW
                --        WHERE  NOM_PARAMETRO = 'FLAG_SERIE_NEGATIVA';
                --    EXCEPTION
                --     WHEN OTHERS THEN
                -- GV_sqlcode := -20160;
                -- GV_sqlerrm := SUBSTR(SQLERRM,1,60);   --COL-69461|22-08-2008|DVG
                --            RAISE ERROR_PROCESO;
                --     END;



                 --BEGIN

                --    SELECT 1, CODIGO_INTERNO
                --        INTO DATO_CAUSA ,COD_CAUSA_PL
                --    FROM AL_CODIGO_EXTERNO
                --    WHERE CODIGO_EXTERNO = EV_CAUSA AND TIP_CODIGO = '10011';
                --EXCEPTION
                 --WHEN OTHERS THEN
                --    GV_sqlcode := -20170;
                --   GV_sqlerrm := SUBSTR(SQLERRM,1,60);   --COL-69461|22-08-2008|DVG
                --           RAISE ERROR_PROCESO;
                 --END;

                 --sCodGSM := GE_FN_DEVVALPARAM('GA',1,'GRUPO_TEC_GSM');

                  --IF sCodGSM = GA_APROVISIONAR_CENTRAL_PG.PV_GRUPO_TECNOLOGICO_FN(GV_tecnologia) THEN
                --           GV_serie := GV_imei;
                  --END IF;

                 --SELECT "GA_SEQ_TRANSACABO".NEXTVAL INTO GV_TRANSAC FROM DUAL;

                --IF dato_causa = 1  THEN

                --    IF PARAMETRO = '1' THEN

                --        PV_SERIES_NEGATIVAS_PG.PV_SERIES_NEGATIVAS_PR( GV_TRANSAC , GV_serie , 'I' , GV_ABONADO , COD_CAUSA_PL , 'PLBA' );

                --       SELECT DES_CADENA INTO nNumError FROM GA_TRANSACABO WHERE NUM_TRANSACCION = GV_TRANSAC;

                --        IF nNumError <> 0 THEN
                --           GV_sqlcode := -20180;
                --                              GV_sqlerrm := SUBSTR(SQLERRM,1,60);   --COL-69461|22-08-2008|DVG
                --                              RAISE ERROR_PROCESO;
               --         END IF;

                --     END IF;
                 --END IF;

                 vNumSerie:=GV_serie;
                 vNumCelular:=GV_celular;
                 vNumSerieMec:=GV_SERIEMEC;

                 SELECT COD_OPERADOR
                 INTO  vCodOperador
                 FROM TA_DATOSGENER;


                 INSERT INTO GA_LNCELU (NUM_SERIE, IND_PROCEQUI, NUM_SERIEMEC, COD_OPERADOR,
                        NUM_CELULAR,NUM_ABONADO, COD_CLIENTE, FEC_ALTA, COD_FABRICANTE,COD_ARTICULO)
                        SELECT vNumSerie,A.IND_PROCEQUI,vNumSerieMec,vCodOperador,vNumCelular,GV_abonado,
                        GV_cliente,SYSDATE,C.COD_FABRICANTE,A.COD_ARTICULO
                        FROM GA_EQUIPABOSER A, AL_ARTICULOS C
                        WHERE A.NUM_ABONADO=GV_abonado
                        AND A.NUM_SERIE=vNumSerie
                        AND A.FEC_ALTA =(SELECT MAX(FEC_ALTA)
                                         FROM GA_EQUIPABOSER B
                                         WHERE A.NUM_ABONADO=B.NUM_ABONADO
                                         AND A.NUM_SERIE=B.NUM_SERIE
                                        )
                       AND A.COD_ARTICULO=C.COD_ARTICULO;

            END IF;
            --FIN MA-45289|06-12-2007|JJR
            GV_error1:= '0';
         RAISE ERROR_PROCESO;

    EXCEPTION
    WHEN ERROR_PROCESO THEN
       IF GV_sqlcode = -20211 THEN
          GV_proc    := 'SELECCION DE CAUSA';
          GV_tabla   := 'GED_PARAMETROS';
          GV_Act     := 'S';
          GV_sqlerrm := 'NO ENCUENTRA CAUSA DE BAJA EN (GED_PARAMETROS)';
       ELSIF GV_sqlcode = -20212 THEN
          GV_proc    := 'SELECCION DE CAUSA';
          GV_tabla   := 'GED_PARAMETROS';
          GV_Act     := 'S';
          --GV_sqlerrm := SUBSTR(SQLERRM,1,60);   COL-69461|22-08-2008|DVG
       ELSIF GV_sqlcode = -20213 THEN
          GV_proc    := 'OBTIENE DATOS PENALIZACION';
          GV_tabla   := 'GA_PERCONTRATO';
          GV_Act     := 'S';
          --GV_sqlerrm := SUBSTR(SQLERRM,1,60);  COL-69461|22-08-2008|DVG
       ELSIF GV_sqlcode = -20214 THEN
          GV_proc    := 'OBTIENE DATOS PENALIZACION';
          GV_tabla   := 'GA_PERCONTRATO';
          GV_Act     := 'S';
          --GV_sqlerrm := SUBSTR(SQLERRM,1,60);   COL-69461|22-08-2008|DVG
       ELSIF GV_sqlcode = -20215 THEN
          GV_proc    := 'OBTIENE DATOS ABONADO';
          GV_tabla   := 'GA_ABOCEL';
          GV_Act     :='S';
          --GV_sqlerrm := SUBSTR(SQLERRM,1,60);   COL-69461|22-08-2008|DVG
       ELSIF GV_sqlcode = -20216 THEN
          GV_proc    := 'OBTIENE DATOS ABONADO';
          GV_tabla   := 'GA_ABOAMIST';
          GV_Act     := 'S';
          --GV_sqlerrm := SUBSTR(SQLERRM,1,60);    COL-69461|22-08-2008|DVG
       ELSIF GV_sqlcode = -20217 THEN
          GV_proc    := 'ACTUALIZA DATOS DEL ABONADO';
          GV_tabla   := 'GA_ABOCEL';
          GV_Act     := 'U';
          --GV_sqlerrm := SUBSTR(SQLERRM,1,60);     COL-69461|22-08-2008|DVG
       ELSIF GV_sqlcode = -20218 THEN
          GV_proc    := 'ACTUALIZA DATOS DEL ABONADO';
          GV_tabla   := 'GA_ABOAMIST';
          GV_Act     := 'U';
          --GV_sqlerrm := SUBSTR(SQLERRM,1,60);    COL-69461|22-08-2008|DVG
       ELSIF GV_sqlcode = -20219 THEN
          GV_Act   := 'S';
          GV_tabla := 'GA_ABOCEL';
          GV_sqlerrm := 'NO ENCUENTRA DATOS DEL ABONADO POSTPAGO';
       ELSIF GV_sqlcode = -20080 THEN
          GV_tabla   := 'GE_CLIENTES';
          --GV_sqlerrm := SUBSTR(SQLERRM,1,60);    COL-69461|22-08-2008|DVG
       ELSIF GV_sqlcode = -20090 THEN
          GV_proc  := 'OBTIENE COD_TIPLAN';
          GV_tabla := 'TA_PLANTARIF';
          GV_Act   := 'S';
          GV_sqlerrm := 'NO ENCUENTRA CODIGO DE TIPO PLAN TARIFARIO';
       ELSIF GV_sqlcode = -20100 THEN
          GV_proc  := 'OBTIENE COD_TIPLAN';
          GV_tabla := 'TA_PLANTARIF';
          GV_Act   := 'S';
          --GV_sqlerrm := SUBSTR(SQLERRM,1,60);    COL-69461|22-08-2008|DVG
       ELSIF GV_sqlcode = -20110 THEN
          GV_proc    := 'OBTIENE ACTABO';
          GV_tabla   := 'PV_ACTABO_TIPLAN';
          GV_Act     := 'S';
          --GV_sqlerrm := SUBSTR(SQLERRM,1,60);     --COL-69461|22-08-2008|DVG
       ELSIF GV_sqlcode = -20120 THEN
          GV_proc  := 'GENERA MOVIMIENTO';
          GV_tabla := 'ICC_MOVIMIENTO';
          GV_Act   := 'I';
          GV_sqlerrm := 'GENERACION MOVIMIENTO (PV_PRC_INS_MOVIMIENTO_PR)';
       ELSIF GV_sqlcode = -20130 THEN
          GV_proc    := 'ACTUALIZA SERVICIOS SUPLEMENTARIOS DEL ABONADO';
          GV_tabla   := 'GA_SERVSUPLABO';
          GV_Act     := 'U';
          --GV_sqlerrm := SUBSTR(SQLERRM,1,60);  COL-69461|22-08-2008|DVG
       ELSIF GV_sqlcode = -20140 THEN
          GV_proc    := 'INSERTA NUMERO DE CELULAR PARA SER REUTILIZABLE';
          GV_tabla   := 'GA_CELNUM_REUTIL';
          GV_Act     := 'I';
          --GV_sqlerrm := SUBSTR(SQLERRM,1,60);    COL-69461|22-08-2008|DVG
      ELSIF GV_sqlcode = -20150 THEN --MA-45289
          GV_proc    := 'ERROR, AL OBTENER INDICADOR DE LISTA NEGRA';
          GV_tabla   := 'GA_CAUSABAJA';
          GV_Act     := 'S';
          --GV_sqlerrm := SUBSTR(SQLERRM,1,60);    COL-69461|22-08-2008|DVG
      ELSIF GV_sqlcode = -20160 THEN --MA-45289
          GV_proc    := 'ERROR, AL BUSCAR EN PV_PARAMETROS_SIMPLES_VW';
          GV_tabla   := 'PV_PARAMETROS_SIMPLES_VW';
          GV_Act     := 'S';
          --GV_sqlerrm := SUBSTR(SQLERRM,1,60);   COL-69461|22-08-2008|DVG
      ELSIF GV_sqlcode = -20170 THEN --MA-45289
          --GV_proc    := 'ERROR, AL BUSCAR EN AL_CODIGO_EXTERNO NO EXISTE LA CAUSA';
          GV_proc    := 'ERROR, NO EXISTE LA CAUSA EN AL_CODIGO_EXTERNO';   /* COL-69199|08-08-2008|DVG */
          GV_tabla   := 'AL_CODIGO_EXTERNO';
          GV_Act     := 'S';
          --GV_sqlerrm := SUBSTR(SQLERRM,1,60);       COL-69461|22-08-2008|DVG
      ELSIF GV_sqlcode = -20180 THEN --MA-45289
          --GV_proc    := 'ERROR, AL INSERTAR PV_SERIES_NEGATIVAS_PG.PV_SERIES_NEGATIVAS_PR';
          GV_proc    := 'ERROR, AL INSERTAR EN PV_SERIES_NEGATIVAS_PG';   /* COL-69199|08-08-2008|DVG */
          GV_tabla   := 'PV_SERIES_NEGATIVAS_PG.PV_SERIES_NEGATIVAS_PR';
          GV_Act     := 'I';
          --GV_sqlerrm := SUBSTR(SQLERRM,1,60);     COL-69461|22-08-2008|DVG
       END IF;
       IF GV_causa = 0 THEN
                IF GV_error1 <> '0' THEN
                ROLLBACK;
                   INSERT INTO GA_ERRORES
                   (cod_producto,cod_actabo,codigo,fec_error,nom_proc,nom_tabla,cod_act,cod_sqlcode,cod_sqlerrm)
                   VALUES
            --    (GN_producto,GV_actabo,EN_abonado,GD_fecsys,GV_proc,GV_tabla,GV_Act,GV_sqlcode,GV_sqlerrm);
            (GN_producto,GV_actabo,EN_abonado,GD_fecsys,SUBSTR(GV_proc,1,50),SUBSTR(GV_tabla,1,50),GV_Act,GV_sqlcode,SUBSTR(GV_sqlerrm,1,60));  /* COL-69199|08-08-2008|DVG */
                    GV_error1 := 4;
                END IF;

                INSERT INTO GA_TRANSACABO
                (num_transaccion,cod_retorno,des_cadena)
                VALUES (EN_transaccion,GV_error1,NULL);
         ELSE
             IF GV_error1 <> '0' THEN
                GV_cadena :='|'|| GV_tabla ||'|'|| GV_Act ||'|'|| GV_sqlcode ||'|'|| GV_sqlerrm ||'|';
                GV_cadena:= SUBSTR(GV_cadena,1,255);
                GV_error1 := 4;

                 INSERT INTO GA_TRANSACABO
                (Num_transaccion, cod_retorno, des_cadena)
                 VALUES (EN_transaccion,GV_error1,GV_cadena);
             ELSE
                 GV_cadena:= SUBSTR(GV_cadena,1,255);
             END IF;
        END IF;

    WHEN OTHERS THEN
       GV_cadena := '|'|| GV_tabla ||'|'|| GV_Act ||'|'|| TO_CHAR(SQLCODE) ||'|'|| SQLERRM ||'|';
       GV_cadena := SUBSTR(GV_cadena,1,255);
       INSERT INTO GA_TRANSACABO (num_transaccion, cod_retorno, des_cadena)
       VALUES (EN_transaccion,GV_error1,GV_cadena);

END PV_PR_BAJA_PREPAGO_PP_PR;
/
SHOW ERRORS
