CREATE OR REPLACE PACKAGE BODY PV_TRASPASO_PG AS
-- PL/SQL Specification
--
-- *************************************************************
-- * Paquete            : PV_TRASPASO_PG
-- * Descripción        : Procedimientos Almacenados para procesar Traspaso de Propiedad en postventa
-- * Fecha de creación  : 13-01-2003 12:18
-- * Responsable        : Area Postventa
-- *************************************************************

--PV_TRASPASO_PG v1.0 -- Inicio modificacion by SAQL/Soporte 31/07/2006 - CO-200607240253 */
--PV_TRASPASO_PG v1.1 -- Modificación - GBM/Soporte - 17-04-2007 - 39428
--PV_TRASPASO_PG v1.2 -- COL-61078|11-01-2008|GEZ
--PV_TRASPASO_PG v1.3 -- COL-72325|09-12-2008|GEZ
--PV_TRASPASO_PG v1.4 -- COL-72325|14-12-2008|JJR
--PV_TRASPASO_PG v1.5 -- COL-72325|15-12-2008|JJR
--PV_TRASPASO_PG v1.6 -- COL 77474|16-02-2009|SAQL

PROCEDURE PV_TRASPASO_PR (
   ncodCliOrig     IN NUMBER,
   nCodCliDest     IN NUMBER,
   ncod_Cuentad    IN NUMBER,
   nNumAbonado     IN NUMBER,
   scod_SubCuentad IN VARCHAR2,
   scod_plantarif  IN VARCHAR2,
   ncod_producto   IN NUMBER,
   susuarora       IN VARCHAR2,
   scod_actabo     IN VARCHAR2,
   ncod_Cuentao    IN NUMBER,
   scodtipcontrato IN VARCHAR2,
   snumcontrato    IN VARCHAR2,
   snum_anexo      IN VARCHAR2,
   scod_usuario    IN VARCHAR2,
   scod_usuariod   IN VARCHAR2,
   stiptraspaso    IN VARCHAR2,
   snum_celular    IN VARCHAR2,
   scod_empresad   IN NUMBER,
   scod_empresa    IN NUMBER,
   scod_subcuenta  IN VARCHAR2,
   scod_limcons    IN VARCHAR2,
   simp_limcons    IN NUMBER,
   serror          OUT VARCHAR2,
   scod_per        OUT VARCHAR2,
   sdes_per        OUT VARCHAR2,
   scod_ora        OUT VARCHAR2,
   sdes_trace      OUT VARCHAR2,
   nCodPlanCo      OUT VARCHAR2
) IS
   nNUM_ABOCEL       GE_CLIENTES.NUM_ABOCEL%TYPE;
   v_cod_cargobasico ta_plantarif.cod_cargobasico%TYPE;
   v_tip_plantarif   ta_plantarif.tip_plantarif%TYPE;
   scodlimcons       tol_limite_plan_td.cod_limcons%TYPE; -- Modificación - GBM/Soporte - 17-04-2007 - 39428
   v_cod_tiplan      ta_plantarif.cod_tiplan%TYPE; -- Modificación - GBM/Soporte - 17-04-2007 - 39428
   stipo_pospago     ged_parametros.val_parametro%TYPE; -- Modificación - GBM/Soporte - 17-04-2007 - 39428

   Vplan_serv        ga_abocel.COD_PLANSERV%type;  --inc.72325 - 13/12/2008-jjr
BEGIN
   -- Los valores de las variables nNumAbonado , nNumAboNuevo deben ser identicas ya que el abonado se mantiene
   serror      := 'NO';
   scod_per    := ' ';
   sdes_per    := ' ';
   scod_ora    := ' ';
   sdes_trace  := ' ';
   nCodPlanCo  := ' ';
   IF serror = 'NO' THEN
      BEGIN
         SELECT NUM_ABOCEL INTO nNUM_ABOCEL
         FROM GE_CLIENTES
         WHERE COD_CLIENTE = nCodCliOrig;
      EXCEPTION
         WHEN NO_DATA_FOUND THEN
            serror:='SI';
            scod_ora := SQLERRM;
            scod_per := '1';
            sdes_per :='El cliente Origen no esta definido como cliente';
            DBMS_OUTPUT.PUT_LINE('MENSAJE    =' || sdes_per);
         WHEN OTHERS  THEN
            serror:='SI';
            scod_ora := SQLERRM;
            scod_per := '5';
            sdes_per :='Error de Acceso';
            DBMS_OUTPUT.PUT_LINE('MENSAJE    =' || sdes_per);
      END;
      IF serror = 'NO' THEN
         BEGIN
            
            SELECT a.cod_cargobasico,a.tip_plantarif, a.cod_tiplan,b.cod_planserv
            INTO v_cod_cargobasico,v_tip_plantarif, v_cod_tiplan, Vplan_serv
            FROM ta_plantarif a, ga_plantecplserv b, ga_abocel c
            WHERE a.cod_plantarif = scod_plantarif
            AND a.cod_producto = ncod_producto
            and b.cod_plantarif = a.cod_plantarif
            and b.cod_producto = a.cod_producto
            and c.num_abonado = nNumAbonado
            and c.cod_tecnologia = b.cod_tecnologia;
            -- FIN COL 72325|15-12-2008|SAQL                                                                      --inc.72325 - 13/12/2008-jjr

            -- Inicio Modificación - GBM/Soporte - 17-04-2007 - 39428
            BEGIN
               SELECT VAL_PARAMETRO
               INTO stipo_pospago
               FROM GED_PARAMETROS
               WHERE NOM_PARAMETRO='TIPOPOSTPAGO'
               AND COD_PRODUCTO=1
               AND COD_MODULO='GA';
            EXCEPTION
               WHEN NO_DATA_FOUND THEN
                  serror:='SI';
                  scod_ora := SQLERRM;
                  scod_per := '215';
                  sdes_per :='Falta Parametro: TIPOPOSTPAGO';
            END;

            IF v_cod_tiplan=stipo_pospago THEN
              
              
               if scod_limcons = '' then
                    scodlimcons:='';
               else
                    scodlimcons:=scod_limcons;
               end if;
              
            ELSE
               scodlimcons:='';
            END IF;
            -- Fin Modificación - GBM/Soporte - 17-04-2007 - 39428

            IF stiptraspaso IN ('IE','EE') THEN
               UPDATE GA_ABOCEL SET
               cod_limconsumo    = DECODE(scodlimcons,'',cod_limconsumo,scodlimcons), -- Modificación - GBM/Soporte - 17-04-2007 - 39428
               cod_cuenta        = ncod_cuentad,
               cod_subcuenta     = scod_SubCuentad,
               cod_cliente       = nCodCliDest,
               COD_PLANTARIF     = scod_plantarif,
               cod_cargobasico   = v_cod_cargobasico,
               tip_plantarif     = v_tip_plantarif,
               COD_EMPRESA       = scod_empresad,
               cod_planserv      = Vplan_serv    --inc.72325 - 13/12/2008-jjr
               WHERE NUM_ABONADO = nNumAbonado ;
            ELSE
               /* Inicio modificacion by SAQL/Soporte 31/07/2006 - CO-200607240253 */
               IF stiptraspaso = 'II' THEN
                  UPDATE GA_ABOCEL SET
                  cod_cuenta        = ncod_cuentad,
                  cod_subcuenta     = scod_SubCuentad,
                  cod_cliente       = nCodCliDest,
                  cod_empresa     = NULL,                 --COL-61078|11-01-2008|GEZ
                  cod_holding     = NULL,                 --COL-61078|11-01-2008|GEZ
                  COD_PLANTARIF     = scod_plantarif,     --INC 68653
                  cod_cargobasico   = v_cod_cargobasico,
                  cod_planserv    = Vplan_serv    --inc.72325 - 13/12/2008-jjr
                  WHERE NUM_ABONADO = nNumAbonado;
               --INI COL-61078|11-01-2008|GEZ
               --ELSE
               ELSIF stiptraspaso = 'EI' THEN
                  UPDATE GA_ABOCEL SET
                  cod_limconsumo    = DECODE(scodlimcons,'',cod_limconsumo,scodlimcons), -- Modificación - GBM/Soporte - 17-04-2007 - 39428
                  cod_cuenta        = ncod_cuentad,
                  cod_subcuenta     = scod_SubCuentad,
                  cod_cliente       = nCodCliDest,
                  COD_PLANTARIF     = scod_plantarif,
                  cod_cargobasico   = v_cod_cargobasico,
                  cod_empresa       = NULL,
                  cod_holding       = NULL,
                  tip_plantarif     = v_tip_plantarif,
                  cod_planserv      = Vplan_serv    --inc.72325 - 13/12/2008-jjr
                  WHERE NUM_ABONADO = nNumAbonado ;
               ELSE
               --FIN COL-61078|11-01-2008|GEZ
               /* Fin modificacion by SAQL/Soporte 31/07/2006 - CO-200607240253 */
                  UPDATE GA_ABOCEL SET
                  cod_limconsumo    = DECODE(scodlimcons,'',cod_limconsumo,scodlimcons), -- Modificación - GBM/Soporte - 17-04-2007 - 39428
                  cod_cuenta        = ncod_cuentad,
                  cod_subcuenta     = scod_SubCuentad,
                  cod_cliente       = nCodCliDest,
                  COD_PLANTARIF     = scod_plantarif,
                  cod_cargobasico   = v_cod_cargobasico,
                  tip_plantarif     = v_tip_plantarif,
                  cod_planserv      = Vplan_serv    --inc.72325 - 13/12/2008-jjr
                  WHERE NUM_ABONADO = nNumAbonado ;
               /* Inicio modificacion by SAQL/Soporte 31/07/2006 - CO-200607240253 */
               END IF;
               /* Fin modificacion by SAQL/Soporte 31/07/2006 - CO-200607240253 */
            END IF;
         EXCEPTION
            WHEN NO_DATA_FOUND THEN
               serror:='SI';
               scod_ora := SQLERRM;
               scod_per := '2';
               sdes_per :='El abonado no existe en la tabla maestra de abonados';
               DBMS_OUTPUT.PUT_LINE('MENSAJE    =' || sdes_per);
            WHEN OTHERS  THEN
               serror:='SI';
               scod_ora := SQLERRM;
               scod_per := '5';
               sdes_per :='Error de Acceso';
               DBMS_OUTPUT.PUT_LINE('MENSAJE    =' || sdes_per);
         END;
      END IF;

      IF serror = 'NO' THEN
         PV_DUPARRIENDO_PR(nNumAbonado,nCodCliDest ,serror,scod_per,sdes_per,scod_ora,sdes_trace);

         PV_UPROAMING_PR(nNumAbonado,snum_celular,ncodCliOrig,nCodCliDest,serror,scod_per,sdes_per,scod_ora,sdes_trace);

         --PV_DUPCONTABO_PR(ncod_Cuentao,nNumAbonado,scodtipcontrato,snumcontrato,snum_anexo,
         --             ncod_Cuentad,serror,scod_per,sdes_per,scod_ora,sdes_trace);

         IF NVL(snumcontrato,'*') <> '*' AND NVL(snum_anexo,'*') <> '*' THEN -- COL|77474|16-02-2009|SAQL
            PV_DUPCONTABO_PR(ncod_Cuentao,ncod_producto,scodtipcontrato,snumcontrato,snum_anexo,ncod_Cuentad,serror,scod_per,sdes_per,scod_ora,sdes_trace);
         END IF; -- COL|77474|16-02-2009|SAQL

         serror := ' ';
         PV_TRASDISTCLIP2_PR(ncodCliOrig,nCodCliDest,ncod_Cuentad,ncod_Cuentao,scod_usuariod,scod_usuario,nNumAbonado,ncod_producto,
            snum_celular,stiptraspaso,scod_empresad,scod_empresa,scod_subcuentad,scod_subcuenta,susuarora,scod_actabo,
            serror,scod_per,sdes_per,scod_ora,sdes_trace,nCodPlanCo);
         IF serror = 'NO' THEN
            PV_REASIGNACLI_PR(ncodCliOrig,nCodCliDest,nNumAbonado,ncod_producto,susuarora,scod_actabo,serror,scod_per,sdes_per,scod_ora,sdes_trace);
         END IF;
      END IF;
   END IF;
END PV_TRASPASO_PR;

PROCEDURE PV_DUPARRIENDO_PR (
    nNumAboAnt      IN  NUMBER,
        COD_CLIENTENEW  IN  NUMBER,
        serror                  OUT VARCHAR2,
        scod_per        OUT VARCHAR2,
    sdes_per        OUT VARCHAR2,
        scod_ora        OUT VARCHAR2,
    sdes_trace      OUT VARCHAR2
        )
IS

        -- Variables de Error, para procediemientos.
        dFEC_DESDE              FA_ARRIENDO.FEC_DESDE%TYPE;

BEGIN

        serror:='NO';
        scod_per    := ' ';
    sdes_per    := ' ';
    scod_ora    := ' ';
    sdes_trace  := ' ';
        IF serror ='NO' THEN
           BEGIN
           SELECT FEC_DESDE
           INTO dFEC_DESDE
           FROM  FA_ARRIENDO
           WHERE NUM_ABONADO = nNumAboAnt;

           EXCEPTION WHEN NO_DATA_FOUND THEN
                                                 serror:='SI';
                                                 scod_ora := SQLERRM;
                                                 scod_per := '1';
                                 sdes_per :='Registro de arriendo no encontrado';
                     WHEN OTHERS  THEN
                                 serror:='SI';
                                                 scod_ora := SQLERRM;
                                                 scod_per := '5';
                                 sdes_per :='Error de Acceso';
       END;
        END IF;

        IF serror ='NO' THEN
           BEGIN

          INSERT INTO FA_ARRIENDO
          (COD_CLIENTE, NUM_ABONADO, FEC_DESDE, FEC_HASTA, COD_PRODUCTO,
          COD_CONCEPTO, COD_ARTICULO, PRECIO_MES, COD_MONEDA)
          SELECT COD_CLIENTENEW,  nNumAboAnt , FEC_DESDE, FEC_HASTA, COD_PRODUCTO,
          COD_CONCEPTO, COD_ARTICULO, PRECIO_MES, COD_MONEDA
          FROM FA_ARRIENDO
          WHERE NUM_ABONADO = nNumAboAnt;

          IF SQL%ROWCOUNT = 0 THEN
                                 serror:='SI';
                                         scod_ora := SQLERRM;
                                         scod_per := '2';
                         sdes_per :='Registro en la Reasignacion de Cliente Duplicado';
                  END IF;

          EXCEPTION WHEN DUP_VAL_ON_INDEX THEN
                                         serror:='SI';
                                         scod_ora := SQLERRM;
                                         scod_per := '2';
                         sdes_per :='Registro de Arriendo Duplicado';
                                WHEN OTHERS  THEN
                         serror:='SI';
                                         scod_ora := SQLERRM;
                                         scod_per := '5';
                         sdes_per :='Error de Acceso';
       END;
        END IF;
END PV_DUPARRIENDO_PR;

 PROCEDURE PV_DUPCONTABO_PR (
                                nCodCuenta      IN  NUMBER,--INTEGER,
                                                                nCodProducto    IN  NUMBER,--INTEGER,
                                                                sCodTipcontrato IN  VARCHAR2,
                                                                sNumContrato    IN  VARCHAR2,
                                                                sNumAnexo               IN  VARCHAR2,
                                                                nCuenta         IN  NUMBER,--INTEGER,
                                                                serror                  OUT VARCHAR2,
                                                                scod_per        OUT VARCHAR2,
                                                            sdes_per        OUT VARCHAR2,
                                                                scod_ora        OUT VARCHAR2,
                                                            sdes_trace      OUT VARCHAR2
        )
IS

        NCOUNT                  NUMBER;
BEGIN

   serror:='NO';
   scod_per    := ' ';
    sdes_per    := ' ';
    scod_ora    := ' ';
    sdes_trace  := ' ';

   IF (nCuenta = nCodCuenta) THEN
      serror:='NO';
        scod_ora := SQLERRM;
        scod_per := '2';
        sdes_per :='Registro ya tiene Nº de Contrato de Cuenta';
            DBMS_OUTPUT.PUT_LINE('MENSAJE    =' || sdes_per);
  ELSE


   SELECT COUNT(*)
   INTO
   NCOUNT
   FROM GA_CONTCTA
   WHERE COD_CUENTA    = nCuenta
   AND COD_PRODUCTO    = nCodProducto
   AND COD_TIPCONTRATO = sCodTipcontrato
   AND NUM_CONTRATO    = sNumContrato
   AND NUM_ANEXO       = sNumAnexo;

   IF NCOUNT > 0 THEN
        serror:='NO';
        scod_ora := SQLERRM;
        scod_per := '2';
        sdes_per :='Registro ya tiene Nº de Contrato de Cuenta';
        DBMS_OUTPUT.PUT_LINE('MENSAJE    =' || sdes_per);

   ELSE
       BEGIN

          INSERT INTO GA_CONTCTA
          (COD_CUENTA,COD_PRODUCTO,COD_TIPCONTRATO,NUM_CONTRATO,NUM_ANEXO,NUM_MESES,
           NUM_VENTA,FEC_CONTRATO,NUM_ABONADOS,NUM_ABONADO)
          SELECT  nCuenta ,COD_PRODUCTO, COD_TIPCONTRATO,
                                  NUM_CONTRATO, NUM_ANEXO, NUM_MESES,
                          NUM_VENTA,FEC_CONTRATO,NUM_ABONADOS,NUM_ABONADO
          FROM GA_CONTCTA
          WHERE COD_CUENTA     =  nCodCuenta
          AND COD_PRODUCTO     =  nCodProducto
          AND COD_TIPCONTRATO  =  sCodTipcontrato
          AND NUM_CONTRATO     =  sNumContrato
          AND NUM_ANEXO        =  sNumAnexo;


          EXCEPTION WHEN DUP_VAL_ON_INDEX THEN
                                                 serror:='SI';
                                                 scod_ora := SQLERRM;
                                                 scod_per := '2';
                                 sdes_per :='Registro de Contrato Cuenta Duplicado';
                                                     DBMS_OUTPUT.PUT_LINE('MENSAJE    =' || sdes_per);
                                WHEN OTHERS  THEN
                                 serror:='SI';
                                                 scod_ora := SQLERRM;
                                                 scod_per := '5';
                                 sdes_per :='Error de Acceso';
                                             DBMS_OUTPUT.PUT_LINE('MENSAJE    =' || sdes_per);

        END;
         END IF;
        END IF;
EXCEPTION WHEN OTHERS  THEN
               serror:='SI';
               scod_ora := SQLERRM;
                   scod_per := '5';
                   sdes_per :='Error de Acceso';
                       DBMS_OUTPUT.PUT_LINE('MENSAJE    =' || sdes_per);

END PV_DUPCONTABO_PR;

PROCEDURE PV_UPROAMING_PR (
                                nNumAbonado     IN  NUMBER,--INTEGER,
                                                        nNumTerminal    IN  NUMBER,--INTEGER,
                                                        nCodCliOrig     IN  NUMBER,--INTEGER,
                                                        nCodCliDest     IN  NUMBER,--INTEGER,
                                                        serror                  OUT VARCHAR2,
                                                        scod_per        OUT VARCHAR2,
                                                    sdes_per        OUT VARCHAR2,
                                                        scod_ora        OUT VARCHAR2,
                                                    sdes_trace      OUT VARCHAR2
                          )
IS

        nNumEstadia         NUMBER;

BEGIN
        serror:='NO';
        scod_per    := ' ';
    sdes_per    := ' ';
    scod_ora    := ' ';
    sdes_trace  := ' ';

    SELECT num_estadia
        INTO
        nNumEstadia
        FROM ga_aboroacom
        WHERE num_abonado    = nNumAbonado  AND
              num_abonadocel = nNumTerminal;

    IF nNumEstadia > 0 THEN
           BEGIN
            UPDATE GE_CLIENTES SET
        NUM_ABOROAMING    = NUM_ABOROAMING - 1
        WHERE COD_CLIENTE = nCodCliOrig;

            EXCEPTION WHEN NO_DATA_FOUND  THEN
                      serror:='SI';
                          scod_ora := SQLERRM;
                          scod_per := '1';
                          sdes_per :='Cliente Origen no se encuentra definido en la tabla de Clientes';
                                  WHEN OTHERS  THEN
                      serror:='SI';
                          scod_ora := SQLERRM;
                          scod_per := '5';
                          sdes_per :='Error de Acceso';
       END;

           IF serror='NO' THEN
                 BEGIN
                 UPDATE GE_CLIENTES SET
             NUM_ABOROAMING    = NUM_ABOROAMING + 1
             WHERE COD_CLIENTE = nCodCliDest;

                 EXCEPTION WHEN NO_DATA_FOUND  THEN
                           serror:='SI';
                                   scod_ora := SQLERRM;
                                   scod_per := '2';
                                   sdes_per :='Cliente Destino no se encuentra definido en la tabla de Clientes';
                                           WHEN OTHERS  THEN
                           serror:='SI';
                           scod_ora := SQLERRM;
                           scod_per := '5';
                           sdes_per :='Error de Acceso';
         END;
       END IF;
    END IF;

EXCEPTION WHEN OTHERS  THEN
          serror:='SI';
          scod_ora := SQLERRM;
          scod_per := '5';
          sdes_per :='Error de Acceso';

END PV_UPROAMING_PR;

PROCEDURE PV_TRASDISTCLIP2_PR (
                                                            nCodCliOrig     IN NUMBER,
                                                                nCodCliDest     IN NUMBER,
                                                                ncod_Cuentad    IN NUMBER,
                                                            ncod_CuentaO    IN NUMBER,
                                                            nCod_Usuario    IN NUMBER,
                                                                nCod_Usuarioo   IN NUMBER,
                                                                nNumAbonado     IN NUMBER,
                                                                ncod_producto   IN NUMBER,
                                                            nNumTerminal        IN NUMBER,
                                                                iTipTraspaso    IN VARCHAR2,
                                                            nCodEmpresaDest IN NUMBER,
                                                                nCodEmpresaOrig IN NUMBER,
                                                                scod_SubCuentad IN VARCHAR2,
                                                                scod_SubCuentaO IN VARCHAR2,
                                                                snom_usuarora   IN VARCHAR2,
                                                                scod_actabo     IN VARCHAR2,
                                                                serror         OUT VARCHAR2,
                                                                scod_per       OUT VARCHAR2,
                                                            sdes_per       OUT VARCHAR2,
                                                                scod_ora       OUT VARCHAR2,
                                                            sdes_trace     OUT VARCHAR2,
                                                                nCodPlanCo     OUT VARCHAR2

                              )
IS
  nNUM_ABOCEL   GE_CLIENTES.NUM_ABOCEL%TYPE;
  nCodPlanCom   GA_CLIENTE_PCOM.COD_PLANCOM%TYPE;
BEGIN
 -- Los valores de las variables nNumAbonado , nNumAboNuevo deben ser identicas ya que el abonado se mantiene
 serror   := 'NO';
        scod_per    := ' ';
    sdes_per    := ' ';
    scod_ora    := ' ';
    sdes_trace  := ' ';
        nCodPlanCo  := ' ';
 IF serror = 'NO' THEN
           BEGIN

                 DELETE GA_PETSR WHERE NUM_ABONADO = nNumAbonado;

             EXCEPTION WHEN NO_DATA_FOUND THEN
                                serror:='NO';
                                                        scod_ora := SQLERRM;
                                                        scod_per := '3';
                                sdes_per :='El abonado no existe en la tabla maestra de suspensiones programadas';
                           WHEN OTHERS  THEN
                                serror:='SI';
                                                        scod_ora := SQLERRM;
                                                        scod_per := '5';
                                sdes_per :='Error de Acceso';
           END;

                   IF serror = 'NO' THEN
             BEGIN

                       DELETE GA_FINCICLO WHERE NUM_ABONADO = nNumAbonado;

                           EXCEPTION WHEN NO_DATA_FOUND THEN
                                  serror:='NO';
                                                          scod_ora := SQLERRM;
                                                          scod_per := '4';
                                  sdes_per :='El abonado no existe en la tabla maestra de fin ciclo';
                             WHEN OTHERS  THEN
                                  serror:='SI';
                                                  scod_ora := SQLERRM;
                                                          scod_per := '5';
                                  sdes_per :='Error de Acceso';
             END;

                     IF serror = 'NO' THEN

                         PV_TRASPABO_PR(nCodCliOrig,nCodCliDest,ncod_Cuentad,scod_SubCuentad,ncod_CuentaO,scod_SubCuentaO,
                                        nCod_Usuario,nCod_Usuarioo,nNumAbonado,ncod_producto,nNumTerminal,snom_usuarora,
                                        0,scod_actabo,serror,scod_per,sdes_per,scod_ora,sdes_trace);


                IF serror = 'NO' THEN
                   BEGIN
                          SELECT B.COD_PLANCOM
                          INTO
                               nCodPlanCom
                      FROM GA_ABOCEL A,
                               GA_CLIENTE_PCOM B
                      WHERE
                              A.NUM_ABONADO   = nNumAbonado
                      AND B.COD_CLIENTE   =  A.COD_CLIENTE
                      AND SYSDATE BETWEEN B.FEC_DESDE AND NVL(B.FEC_HASTA, SYSDATE);

                                      EXCEPTION WHEN NO_DATA_FOUND THEN
                                         serror:='SI';
                                         scod_ora := SQLERRM;
                                                                         scod_per := '6';
                                                         sdes_per :='El abonado  no tiene datos asociados a planes comerciales';
                                    WHEN OTHERS  THEN
                                         serror:='SI';
                                                                         scod_ora := SQLERRM;
                                                                         scod_per := '5';
                                         sdes_per :='Error de Acceso';
                           END;

                                   IF serror = 'NO' THEN
                              IF nCodPlanCom > 0 THEN
                                            nCodPlanCo := nCodPlanCom;
                                            PV_UPNUMABOCLI_PR (nCodCliOrig,nCodCliDest,iTipTraspaso,
                                                               nCodEmpresaDest,nCodEmpresaOrig,serror,scod_per,sdes_per,scod_ora,sdes_trace);

                                          END IF;
                      END IF;
                END IF;
                         END IF;
                   END IF;
 END IF;
END PV_TRASDISTCLIP2_PR;

PROCEDURE PV_TRASPABO_PR (
                            nCodCliOrig     IN NUMBER,
                            nCodCliDest     IN NUMBER,
                            ncod_Cuentad    IN NUMBER,
                            -- scod_SubCuentad IN NUMBER, -- COL 68278|22-07-2008|SAQL
                            scod_SubCuentad IN VARCHAR2, -- COL 68278|22-07-2008|SAQL
                            ncod_CuentaO    IN NUMBER,
                            -- scod_SubCuentaO IN NUMBER, -- COL 68278|22-07-2008|SAQL
                            scod_SubCuentaO IN VARCHAR2, -- COL 68278|22-07-2008|SAQL
                            nCod_Usuario    IN NUMBER,
                            nCod_Usuarioo   IN NUMBER,
                            nNumAbonadonue  IN NUMBER,
                            ncod_producto   IN NUMBER,
                            nNumTerminal    IN NUMBER,
                            snom_usuarora   IN VARCHAR2,
                            iIndTipTraspaso IN NUMBER,
                            scod_actabo     IN VARCHAR2,
                            serror          OUT VARCHAR2,
                            scod_per        OUT VARCHAR2,
                            sdes_per        OUT VARCHAR2,
                            scod_ora        OUT VARCHAR2,
                            sdes_trace      OUT VARCHAR2
                            -- Inicio modificacion by SAQL/Soporte 13/04/2006 - RA-200602210820
                            , VP_FECHA      IN DATE := NULL
                            -- Fin modificacion by SAQL/Soporte 13/04/2006 - RA-200602210820
         )
IS

LN_CodUsuario                  ga_abocel.cod_usuario%TYPE;-- COL-72325|09-12-2008|GEZ

BEGIN

   serror := 'NO';
        scod_per    := ' ';
    sdes_per    := ' ';
    scod_ora    := ' ';
    sdes_trace  := ' ';

    --INI COL-72325|09-12-2008|GEZ
        BEGIN
                 SELECT NVL(cod_usuario,nCod_Usuarioo)
                 INTO    LN_CodUsuario
                 FROM  ga_abocel
                 WHERE num_abonado=nNumAbonadonue;
        EXCEPTION
                         WHEN NO_DATA_FOUND THEN
                                  LN_CodUsuario:=nCod_Usuarioo;
        END;
        --FIN COL-72325|09-12-2008|GEZ

       INSERT INTO GA_TRASPABO
       (NUM_ABONADO, FEC_MODIFICA, COD_CLIENNUE, COD_CUENTANUE,
       COD_SUBCTANUE, COD_USUARNUE, COD_PRODUCTO, NUM_TERMINAL,
       NUM_ABONADOANT, COD_CLIENANT, COD_CUENTAANT, COD_SUBCTAANT,
       COD_USUARANT, IND_TRASDEUDA, NOM_USUARORA)
        VALUES (
       nNumAbonadonue,
       -- Inicio modificacion by SAQL/Soporte 13/04/2006 - RA-200602210820
       --SYSDATE,
       NVL(VP_FECHA,SYSDATE),
       -- Fin modificacion by SAQL/Soporte 13/04/2006 - RA-200602210820
       nCodCliDest,
       ncod_Cuentad,
       scod_SubCuentad,
       --ncod_Usuario, --COL-72325|09-12-2008|GEZ
           LN_CodUsuario,    --COL-72325|09-12-2008|GEZ
       ncod_producto,
       nNumTerminal,
       nNumAbonadonue,
       nCodCliOrig,
       nCod_CuentaO,
       sCod_SubCuentao,
       nCod_Usuarioo,
       iIndTipTraspaso,
       snom_usuarora
       );


    EXCEPTION WHEN DUP_VAL_ON_INDEX THEN
                                         serror:='SI';
                                         scod_ora := SQLERRM;
                                         scod_per := '1';
                         sdes_per :='Registro en la traspabo Duplicado';
              WHEN OTHERS  THEN
                         serror:='SI';
                                         scod_ora := SQLERRM;
                                         scod_per := '5';
                         sdes_per :='Error de Acceso t';

END PV_TRASPABO_PR;

PROCEDURE PV_UPNUMABOCLI_PR (
                               nCodCliOrig     IN NUMBER,
                               nCodCliDest     IN NUMBER,
                               iTipTraspaso    IN VARCHAR2,
                               nCodEmpresaDest IN NUMBER,
                               nCodEmpresaOrig IN NUMBER,
                               serror          OUT VARCHAR2,
                               scod_per        OUT VARCHAR2,
                               sdes_per        OUT VARCHAR2,
                               scod_ora        OUT VARCHAR2,
                               sdes_trace      OUT VARCHAR2
                             )
IS
  nNUM_ABOCEL   GE_CLIENTES.NUM_ABOCEL%TYPE;

BEGIN
 -- Los valores de las variables nNumAbonado , nNumAboNuevo deben ser identicas ya que el abonado se mantiene
  serror   := 'NO';
        scod_per    := ' ';
    sdes_per    := ' ';
    scod_ora    := ' ';
    sdes_trace  := ' ';

IF serror = 'NO' THEN
    -- Incrementa el nº de abonados del nuevo cliente
        BEGIN
      UPDATE GE_CLIENTES SET NUM_ABOCEL = NUM_ABOCEL + 1
      WHERE COD_CLIENTE = nCodCliDest;

      EXCEPTION WHEN NO_DATA_FOUND THEN
                     serror:='SI';
                                         scod_ora := SQLERRM;
                                         scod_per := '1';
                         sdes_per :='El cliente destino no esta definido como cliente';
                                         DBMS_OUTPUT.PUT_LINE('MENSAJE    =' || sdes_per);
                    WHEN OTHERS  THEN
                         serror:='SI';
                                         scod_ora := SQLERRM;
                                         scod_per := '5';
                         sdes_per :='Error de Acceso';
                                         DBMS_OUTPUT.PUT_LINE('MENSAJE    =' || sdes_per);
    END;
END IF;

IF serror = 'NO' THEN
    IF iTipTraspaso = 'IE' OR iTipTraspaso = 'EE' THEN
        -- CLIENTE DESTINO EMPRESA
        -- Incrementa el nº de abonados de la empresa del nuevo cliente
                BEGIN
                  UPDATE GA_EMPRESA SET NUM_ABONADOS = NUM_ABONADOS + 1
          WHERE COD_EMPRESA = nCodEmpresaDest;

                  EXCEPTION WHEN NO_DATA_FOUND THEN
                     serror:='SI';
                                         scod_ora := SQLERRM;
                                         scod_per := '2';
                         sdes_per :='El cod. empresa destino no esta definido';
                                         DBMS_OUTPUT.PUT_LINE('MENSAJE    =' || sdes_per);
                    WHEN OTHERS  THEN
                         serror:='SI';
                                         scod_ora := SQLERRM;
                                         scod_per := '5';
                         sdes_per :='Error de Acceso';
                                         DBMS_OUTPUT.PUT_LINE('MENSAJE    =' || sdes_per);

                END;
    END IF;

        IF serror = 'NO' THEN

       IF iTipTraspaso = 'EI' OR iTipTraspaso = 'EE' THEN
           -- CLIENTE ORIGEN EMPRESA
           -- Decrementa el nº de abonados de la empresa del nuevo cliente

                   BEGIN

             UPDATE GA_EMPRESA SET NUM_ABONADOS = NUM_ABONADOS - 1
             WHERE COD_EMPRESA = nCodEmpresaOrig;

                 EXCEPTION WHEN NO_DATA_FOUND THEN
                       serror:='SI';
                                           scod_ora := SQLERRM;
                                           scod_per := '3';
                           sdes_per :='El cod. empresa origen no esta definido';
                                           DBMS_OUTPUT.PUT_LINE('MENSAJE    =' || sdes_per);
                           WHEN OTHERS  THEN
                           serror:='SI';
                                           scod_ora := SQLERRM;
                                           scod_per := '5';
                           sdes_per :='Error de Acceso';
                                           DBMS_OUTPUT.PUT_LINE('MENSAJE    =' || sdes_per);

               END;
           END IF;

           IF serror = 'NO' THEN
          -- Decrementa el nº de abonados del antiguo cliente
          BEGIN

                    UPDATE GE_CLIENTES SET NUM_ABOCEL = NUM_ABOCEL - 1
            WHERE COD_CLIENTE = nCodCliOrig;

                    EXCEPTION WHEN NO_DATA_FOUND THEN
                               serror:='SI';
                                                   scod_ora := SQLERRM;
                                               scod_per := '4';
                               sdes_per :='El cod. empresa origen no esta definido';
                                                   DBMS_OUTPUT.PUT_LINE('MENSAJE    =' || sdes_per);
                          WHEN OTHERS  THEN
                               serror:='SI';
                                                   scod_ora := SQLERRM;
                                               scod_per := '5';
                               sdes_per :='Error de Acceso';
                                                   DBMS_OUTPUT.PUT_LINE('MENSAJE    =' || sdes_per);

              END;
           END IF;
        END IF;
END IF;
END PV_UPNUMABOCLI_PR;

PROCEDURE PV_REASIGNACLI_PR (
                               nCodCliOrig     IN NUMBER,
                               nCodCliDest     IN NUMBER,
                               nNumAbonadonue  IN NUMBER,
                               ncod_producto   IN NUMBER,
                               snom_usuarora   IN VARCHAR2,
                               scod_actabo     IN VARCHAR2,
                               serror          OUT VARCHAR2,
                               scod_per        OUT VARCHAR2,
                               sdes_per        OUT VARCHAR2,
                               scod_ora        OUT VARCHAR2,
                               sdes_trace      OUT VARCHAR2
                            )
IS

BEGIN
    serror:='NO';
        scod_per    := ' ';
    sdes_per    := ' ';
    scod_ora    := ' ';
    sdes_trace  := ' ';
INSERT INTO GA_REASIGNA_CLI_TO
 (COD_PRODUCTO,NUM_ABONADO,COD_CLIENTE_ORIG,COD_CLIENTE_DEST,
  NOM_USUARORA,FEC_REASIGNA,COD_ACTABO)
VALUES
  (ncod_producto,nNumAbonadonue,nCodCliOrig,nCodCliDest,
  snom_usuarora,SYSDATE,scod_actabo);


EXCEPTION WHEN DUP_VAL_ON_INDEX THEN
                                         serror:='SI';
                                         scod_ora := SQLERRM;
                                                 scod_per := '2';
                                 sdes_per :='Registro en la Reasignacion de Cliente Duplicado';
         WHEN OTHERS  THEN
                                 serror:='SI';
                                         scod_ora := SQLERRM;
                                         scod_per := '5';
                         sdes_per :='Error de Acceso';
END PV_REASIGNACLI_PR;


END PV_TRASPASO_PG;
/
SHOW ERRORS