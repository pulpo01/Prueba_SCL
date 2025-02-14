CREATE OR REPLACE PROCEDURE PV_PR_BAJAABONADO (
        nNUM_OOSS                                                 IN  NUMBER,                       --Numero de OOSS
        nNUM_ABONADO                                       IN  NUMBER,                       --Numero de abonado
        vCOD_ACTABO                                          IN  VARCHAR2,                     --Csdigo de actuacisn
        vCOD_CAUSA                                                IN  VARCHAR2,                     --Csdigo de Causa de Baja
        vNOM_USUARORA                                     IN  VARCHAR2,                     --Usuario Responsable
        vCOD_DEVEQ                                            IN  VARCHAR2,                     --Devolucisn de Equipo en Comodato
        nCOD_ERROR                                               OUT NUMBER,
        sMEN_ERROR                                               OUT VARCHAR2)
IS

--PV_PR_BAJAABONADO v1.0 //COL-40285|11-05-2007|GEZ
--PV_PR_BAJAABONADO v1.1 //COL-40285|07-06-2007|MMC
--PV_PR_BAJAABONADO v1.2 //COL-41633|17-06-2007|MMC
--PV_PR_BAJAABONADO v1.3 //COL-72424|03-11-2008|GEZ
--PV_PR_BAJAABONADO v1.4 //COL-72424|27-11-2008|GEZ
--PV_PR_BAJAABONADO v1.5   COL 72424|19-12-2008|SAQL

        nNumError                NUMBER (2);   -- numero de error
        sMsgError                VARCHAR2(70); -- mensaje de error
        sDuplicado                       VARCHAR2(2);
        dFechaEjecucion                  DATE;

        -- Variables de Error, para procediemientos.

        VP_ERROR                 VARCHAR2(1);
        VP_PROC                  VARCHAR2(50);
        VP_SQLCODE               VARCHAR2(15);
        VP_SQLERRM               VARCHAR2(70);
        VP_TABLA                 VARCHAR2(50);
        VP_ACT                   VARCHAR2(1);

        nOrdComando              PV_MOVIMIENTOS.ORD_COMANDO%TYPE;
        sCodCicloFact                    FA_CICLFACT.COD_CICLFACT%TYPE;
        vNumAbonado              GA_ABOCEL.NUM_ABONADO%TYPE;
        sCodActabo               GA_ACTABO.COD_ACTABO%TYPE;
        nCodProducto                     GA_ABOCEL.COD_PRODUCTO%TYPE;
        nCodCliente              GA_ABOCEL.COD_CLIENTE%TYPE;
        nNumCelular              GA_ABOCEL.NUM_CELULAR%TYPE;
        vCodPlantarif                    GA_ABOCEL.COD_PLANTARIF%TYPE;
        vCodCargoBasico                  GA_ABOCEL.COD_CARGOBASICO%TYPE;
        vTipPlantarif                    GA_ABOCEL.TIP_PLANTARIF%TYPE;
        vCodCiclo                GA_ABOCEL.COD_CICLO%TYPE;
        vCodTipContrato                  GA_ABOCEL.COD_TIPCONTRATO%TYPE;
        nIndEqPrestado                   GA_ABOCEL.IND_EQPRESTADO%TYPE;
        nCodEmpresa              GA_ABOCEL.COD_EMPRESA%TYPE;
        nNumMin                  GA_ABOCEL.NUM_MIN%TYPE;
        sNumSerie                GA_ABOCEL.NUM_SERIE%TYPE;
        sNumSerieHex                     GA_ABOCEL.NUM_SERIEHEX%TYPE;
        sTipTerminal                     GA_ABOCEL.TIP_TERMINAL%TYPE;
        sCodUsoLinea                     GA_ABOCEL.COD_USO%TYPE;
        sCodTecnologia                       GA_ABOCEL.COD_TECNOLOGIA%TYPE;
        sCodGSM                              GA_ABOCEL.COD_TECNOLOGIA%TYPE;
        sNumImei                     GA_ABOCEL.NUM_IMEI%TYPE;
        nIndLn                   GA_CAUSABAJA.IND_LN%TYPE;
        vCadServicio                     ICC_MOVIMIENTO.COD_SERVICIOS%TYPE;
        sCodOperador             TA_DATOSGENER.COD_OPERADOR%TYPE;
        vServicio                VARCHAR2(6);
        vIndPortabilidad                 PV_CAMCOM.IND_PORTABLE%TYPE;
        nCodigoEstado                    PV_IORSERV.COD_ESTADO%TYPE;
        vCodigoOrdenServicio     PV_IORSERV.COD_OS%TYPE;
        nTipoOrdenServicio       CI_TIPORSERV.TIP_OOSS%TYPE;
        vCodigoOficina           GE_SEG_USUARIO.COD_OFICINA%TYPE;
        nNotaCredito                     NUMBER(1);
        v_transac                        GA_TRANSACABO.NUM_TRANSACCION%TYPE;
        sfaFecBaja                       VARCHAR(8);
        sAuxCodActabo            GA_ACTABO.COD_ACTABO%TYPE;
        sCodTiplan                           TA_PLANTARIF.COD_TIPLAN%TYPE;
        sAuxCodTiplan                        TA_PLANTARIF.COD_TIPLAN%TYPE;
        V_IND_FAMILIAR           VARCHAR2(1); -- Homologación Patricio G. CH-140820031203 12-09-2003
        LV_COD_CAUSA_EIR    GA_LISTACAUSAEIR_TD.COD_CAUSA%TYPE; 
    LV_COD_OS        PV_IORSERV.COD_OS%TYPE;    
       

                --MIX-06003
        sParametroCPersonal      GED_PARAMETROS.VAL_PARAMETRO%TYPE; --Parametro Cuenta Personal
        CV_TRUE                                  GED_PARAMETROS.VAL_PARAMETRO%TYPE :='TRUE'; --Parametro Cuenta Personal
        sAtlantida               NUMBER(1);
        sExisteNumPersonal               VARCHAR2(1);
        splan_atlantida                  NUMBER(1);
                sExisteNumCorporativo    VARCHAR2(1);
                SNumPersonal             GA_NUMCEL_PERSONAL_TO.NUM_CEL_PERS%TYPE;
                SN_p_correlativo             NUMBER(9);
                SN_cod_retorno           ge_errores_pg.CodError;
        SV_mens_retorno          ge_errores_pg.MsgError;
        SN_num_evento            ge_errores_pg.Evento;
                LV_FLAG_ATLANTIDA                VARCHAR2(5);
                --MIX-06003

        ERROR_PROCESO                    EXCEPTION;
                PARAMETRO                                VARCHAR2(1); -- p-col-06054 y.o.
                cod_causa_pl                     VARCHAR(2); -- p-col-06054 y.o.
                TRANSAC                                  GA_TRANSACABO.NUM_TRANSACCION%TYPE := 0;-- p-col-06054 y.o.
                SERIE                                    GA_ABOCEL.NUM_SERIE%TYPE; -- p-col-06054 y.o.
                dato_causa                               NUMBER; -- p-col-06054 y.o.
                nCantidad                        NUMBER; -- COL 65280|09-05-2008|SAQL

            CURSOR C_SERVACT IS
            SELECT LPAD(TO_CHAR(COD_SERVSUPL),2,'00')||'0000'
            FROM GA_SERVSUPLABO
            WHERE NUM_ABONADO=nNUM_ABONADO
            AND IND_ESTADO<3;

                --INI COL-72424|03-11-2008|GEZ
                LNEsOOSSProg                    NUMBER;                 --0: no es programada, 1: es programada
                LVCodOSBajaAbo                  ged_parametros.val_parametro%TYPE;
                LVCodOSBajaOpta                 ged_parametros.val_parametro%TYPE;
                LVCodOSSolicBaja                ged_parametros.val_parametro%TYPE;

                LVFecCorteBajaAbo               ged_parametros.val_parametro%TYPE;
                LVFecCorteBajaOpta              ged_parametros.val_parametro%TYPE;
                LVFecCorteSolicBaja             ged_parametros.val_parametro%TYPE;

                LD_FecProg                                         pv_iorserv.fh_ejecucion%TYPE;

                --FIN COL-72424|03-11-2008|GEZ
        lv_cod_seguro ga_seguroabonado_to.cod_seguro%type;
        ln_seguro number(1):=1;

        --P-MIX-09003
        cursor cur_ip is
        select b.cod_servicio,b.cod_servsupl,b.cod_nivel,b.fec_altabd
        from ga_servsuplabo b
        where  b.num_abonado =nNUM_ABONADO
        and b.cod_servicio in ( select a.cod_servicio
        from ga_servsupl a
        where a.cod_producto = 1
        and a.ind_ip= 1 )
        and b.ind_estado < 3;

        lv_cod_servicio ga_servsuplabo.cod_servicio%type;
        ln_cod_servsupl ga_servsuplabo.cod_servsupl%type;
        ld_fec_altabd   ga_servsuplabo.fec_altabd%type;
        ln_cod_nivel    ga_servsuplabo.cod_nivel%type;

        ln_cod_retorno   ge_errores_pg.CodError;
           lv_mens_retorno  ge_errores_pg.MsgError;
           ln_num_evento    ge_errores_pg.Evento;

BEGIN

        nNumError:=0;--Operacion Exitosa
        sMsgError:='Operacion Exitosa';

                --Inicio  Incidencia 41633 19-6-2007 MMC
                --INI COL-40285|11-05-2007|GEZ

                --dFechaEjecucion:=SYSDATE; --COL-72424|03-11-2008|GEZ

                --dFechaEjecucion:=SYSDATE;
--              nNumError:=1;
--        sMsgError:='Error Obteniendo Fecha de Programacion de OOSS';
--        VP_TABLA:='PV_IORSERV';
--        VP_ACT:='S';



              SELECT COD_OS
              INTO   LV_COD_OS
              FROM   pv_iorserv
              WHERE  num_os=nNUM_OOSS;

        --FIN COL-40285|11-05-2007|GEZ
                --Fin  Incidencia 41633 19-6-2007 MMC

                sCodActabo:=vCOD_ACTABO;
        vNumAbonado:=nNUM_ABONADO;
        nOrdComando:=1;

        VP_ERROR:='0';
        VP_PROC:='PV_PR_BAJABONADO';

        --Datos Generales

        BEGIN

                 nNumError:=1;
                 sMsgError:='Error Obteniendo Datos de Abocel';
                 VP_TABLA:='GA_ABOCEL';
                 VP_ACT:='S';

                 SELECT COD_PRODUCTO,COD_CLIENTE,NUM_CELULAR,COD_PLANTARIF,COD_CARGOBASICO,TIP_PLANTARIF,COD_CICLO,
                        COD_TIPCONTRATO,IND_EQPRESTADO,COD_EMPRESA,COD_CICLO,NUM_MIN,NUM_SERIE,NUM_SERIEHEX,TIP_TERMINAL,COD_USO,COD_TECNOLOGIA,NUM_IMEI
                 INTO   nCodProducto,nCodCliente,nNumCelular,vCodPlantarif,vCodCargoBasico,vTipPlantarif,vCodCiclo,
                        vCodTipContrato,nIndEqPrestado,nCodEmpresa,vCodCiclo,nNumMin,sNumSerie,sNumSerieHex,sTipTerminal,sCodUsoLinea,sCodTecnologia,sNumImei
                 FROM   GA_ABOCEL
                 WHERE  NUM_ABONADO =nNUM_ABONADO;

                 sMsgError:='Error Obteniendo Datos de TECNOLOGIA_GSM';
                 VP_TABLA:='GED_PARAMETROS';
                 VP_ACT:='S';

                                 --TMM-04026 Ini
                                 sCodGSM := GE_FN_DEVVALPARAM('GA',1,'GRUPO_TEC_GSM');

                                 IF sCodGSM = GA_APROVISIONAR_CENTRAL_PG.PV_GRUPO_TECNOLOGICO_FN(sCodTecnologia) THEN
                                        sMsgError:='Error al setear Imei en Serie';
                                        sNumSerie := sNumImei;
                                 END IF;

                                 --TMM-04026 Fin

                 nNumError:=2;
                 sMsgError:='Error, al obtener Indicador de Lista Negra';
                 VP_TABLA:='GA_CAUSABAJA';
                 VP_ACT:='S';

                 SELECT IND_LN
                 INTO nIndLn
                 FROM GA_CAUSABAJA
                 WHERE COD_PRODUCTO=nCodProducto
                 AND COD_CAUSABAJA=vCOD_CAUSA;

                 nNumError:=3;
                 sMsgError:='Error, al obtener Periodo Facturable';
                 VP_TABLA:='FA_CICLFACT';
                 VP_ACT:='S';

                 --SELECT cod_ciclfact INTO sCodCicloFact                                                                                                    --COL-72424|03-11-2008|GEZ
                                 --SELECT cod_ciclfact,fec_hastallam INTO sCodCicloFact,dFechaEjecucion         --COL-72424|03-11-2008|GEZ
                                 SELECT cod_ciclfact INTO sCodCicloFact                                                                                                                   --COL-72424|27-11-2008|GEZ
                 FROM fa_ciclfact
                 WHERE cod_ciclo = vCodCiclo
                 AND SYSDATE BETWEEN fec_desdellam AND fec_hastallam;

                 nNumError:=4;
                 sMsgError:='Error, al obtener Datos Generales';
                 VP_TABLA:='TA_DATOSGENER';
                 VP_ACT:='S';

                 SELECT COD_OPERADOR INTO sCodOperador
                 FROM TA_DATOSGENER;

                 nNumError:=5;
                 sMsgError:='Error, al obtener Indicador de Portabilidad';
                 VP_TABLA:='PV_CAMCOM';
                 VP_ACT:='S';

                 SELECT IND_PORTABLE INTO vIndPortabilidad
                 FROM PV_CAMCOM
                 WHERE NUM_OS=nNUM_OOSS;

                 nNumError:=6;
                 sMsgError:='Error, al obtener Código Estado y Código Orden de Servicio';
                 VP_TABLA:='PV_IORSERV';
                 VP_ACT:='S';

                 --SELECT COD_ESTADO,COD_OS INTO        nCodigoEstado , vCodigoOrdenServicio --COL-72424|03-11-2008|GEZ
                                 --SELECT cod_estado,cod_os,DECODE(fh_ejecucion,NULL,0,1)                                           --COL-72424|03-11-2008|GEZ
                                 --INTO         nCodigoEstado , vCodigoOrdenServicio,LNEsOOSSProg                                       --COL-72424|03-11-2008|GEZ
                                 SELECT cod_estado,cod_os,DECODE(fh_ejecucion,NULL,0,1),fh_ejecucion                                --COL-72424|27-11-2008|GEZ
                                 INTO    nCodigoEstado , vCodigoOrdenServicio,LNEsOOSSProg,LD_FecProg                              --COL-72424|27-11-2008|GEZ
                 FROM   pv_iorserv
                 WHERE  num_os=nNUM_OOSS;

                                 --INI COL-72424|03-11-2008|GEZ
                                 -- IF LNEsOOSSProg=0 THEN -- COL 72424|19-12-2008|SAQL
                                 IF LNEsOOSSProg=0 OR TRUNC(LD_FecProg) = TRUNC(SYSDATE) THEN
                                        dFechaEjecucion:=SYSDATE;
                                 ELSE

                                        --INI COL-72424|27-11-2008|GEZ
                                        VP_TABLA:='FA_CICLFACTX';
                                        VP_ACT:='S';

                                        SELECT fec_hastallam INTO dFechaEjecucion
                                        FROM   fa_ciclfact
                                        WHERE cod_ciclo = vCodCiclo
                                        AND     NVL(LD_FecProg,SYSDATE) BETWEEN fec_desdellam AND fec_hastallam;
                                        --FIN COL-72424|27-11-2008|GEZ

                                        LVCodOSBajaAbo    := GE_FN_DEVVALPARAM('GA',1,'CODOS_BAJA_ABONADO');
                                        LVCodOSBajaOpta   := GE_FN_DEVVALPARAM('GA',1,'CODOS_BAJA_OPTAPREPA');
                                        LVCodOSSolicBaja  := GE_FN_DEVVALPARAM('GA',1,'CODOS_SOLICITUD_BAJA');

                                        IF vCodigoOrdenServicio = LVCodOSBajaAbo THEN
                                           LVFecCorteBajaAbo     := GE_FN_DEVVALPARAM('GA',1,'FEC_CORTE_BAJA_ABO');

                                           IF LVFecCorteBajaAbo='FALSE' THEN
                                                  dFechaEjecucion:=SYSDATE;
                                           END IF;
                                        ELSIF  vCodigoOrdenServicio = LVCodOSBajaOpta THEN
                                           LVFecCorteBajaOpta    := GE_FN_DEVVALPARAM('GA',1,'FEC_CORTE_BAJA_OPTA');

                                           IF LVFecCorteBajaOpta='FALSE' THEN
                                                  dFechaEjecucion:=SYSDATE;
                                           END IF;
                                        ELSIF  vCodigoOrdenServicio = LVCodOSSolicBaja THEN

                                           LVFecCorteSolicBaja   := GE_FN_DEVVALPARAM('GA',1,'FEC_CORTE_SOLIC_BAJA');

                                           IF LVFecCorteSolicBaja='FALSE' THEN
                                                  dFechaEjecucion:=SYSDATE;
                                           END IF;
                                        END IF;

                                 END IF;
                                 --FIN COL-72424|03-11-2008|GEZ

/*              IF nCodigoEstado = 0 THEN */

                 nNumError:=7;
                 sMsgError:='Error, al obtener Tipo Orden de Servicio';
                 VP_TABLA:='CI_TIPORSERV';
                 VP_ACT:='S';

                 SELECT TIP_OOSS INTO nTipoOrdenServicio
                 FROM   CI_TIPORSERV
                 WHERE  COD_OS = vCodigoOrdenServicio;

                 nNumError:=7;
                 sMsgError:='Error, al obtener parametro para Nota de Credito';
                 VP_TABLA:='GED_PARAMETROS';
                 VP_ACT:='S';

                 SELECT VAL_PARAMETRO INTO nNotaCredito
                 FROM GED_PARAMETROS
                 WHERE NOM_PARAMETRO = 'NOTA_CREDITO';

                 IF nTipoOrdenServicio = 1 THEN

                        nNumError:=8;
                    sMsgError:='Error, al obtener Código Oficina';
                    VP_TABLA:='GE_SEG_USUARIO';
                    VP_ACT:='S';

                    SELECT COD_OFICINA INTO vCodigoOficina
                    FROM GE_SEG_USUARIO
                    WHERE GE_SEG_USUARIO.NOM_USUARIO = vNOM_USUARORA;

/*                      END IF;

                ELSE

                                        nTipoOrdenServicio := NULL;   */

                END IF;

                                -- INICIO CH-110920031315 12-09-2003 Marcelo Miranda
                         BEGIN

                         nNumError:=40;                                                                                 --COL-72424|03-11-2008|GEZ
                         sMsgError:='Error, al obtener Indicador de Familiar';      --COL-72424|03-11-2008|GEZ
                         VP_TABLA:='PLANTARIF-EMPRESA';                                                     --COL-72424|03-11-2008|GEZ
                         VP_ACT:='S';                                                                                       --COL-72424|03-11-2008|GEZ

                         SELECT A.IND_FAMILIAR
                         INTO V_IND_FAMILIAR
                         FROM TA_PLANTARIF A, GA_EMPRESA B
                         WHERE B.COD_CLIENTE = nCodCliente
                         AND A.COD_PLANTARIF = B.COD_PLANTARIF;
                        EXCEPTION
                        WHEN NO_DATA_FOUND THEN
                          V_IND_FAMILIAR := '0';
                        END;
                -- FIN CH-110920031315 12-09-2003 Marcelo Miranda

             EXCEPTION
             WHEN OTHERS THEN

                                  VP_SQLCODE:=SUBSTR(SQLCODE,1,15); --COL-72424|03-11-2008|GEZ
                  VP_SQLERRM:=SUBSTR(SQLERRM,1,60); --COL-72424|03-11-2008|GEZ

                  RAISE ERROR_PROCESO;
        END;

        -- Operaciones Comunes
        BEGIN
                    -- Servicio IP por baja = HIBERNACION
                   OPEN cur_ip;
                    LOOP
                         FETCH cur_ip INTO lv_cod_servicio,ln_cod_servsupl,ln_cod_nivel,ld_fec_altabd;
                         EXIT WHEN cur_ip%NOTFOUND;

                         PV_IPFIJA_PG.PV_GENERAR_DATOS_IP_PR(nNUM_ABONADO,nNumCelular,nCodProducto,
                                                             lv_cod_servicio,ld_fec_altabd,ln_cod_servsupl,ln_cod_nivel,'HIB',0,0,
                                                                ln_cod_retorno,lv_mens_retorno,ln_num_evento);
                         IF ln_cod_retorno <> 0 THEN
                              nNumError:=ln_cod_retorno;
                              VP_SQLERRM:=lv_mens_retorno;
                              RAISE ERROR_PROCESO;
                         END IF;

                    END LOOP;
                    CLOSE cur_ip;

                    -- Servico de Seguro

                    ln_seguro:=1;
                    begin
                     select a.cod_seguro
                     into lv_cod_seguro
                     from ga_seguroabonado_to a
                     Where a.num_abonado =  nNUM_ABONADO
                     and (trunc(a.fec_fincontrato) >= sysdate or a.fec_fincontrato is null);

                     exception
                       when no_data_found then
                           ln_seguro:=0;
                       when others then
                           ln_seguro:=0;
                    end;

                     if ln_seguro=1 then
                       begin
                          Update ga_seguroabonado_to
                          Set fec_fincontrato =  SYSDATE
                          where  num_abonado = nNUM_ABONADO
                          and    cod_seguro  = lv_cod_seguro
                          and (trunc(fec_fincontrato) >= sysdate or fec_fincontrato is null);

                       exception
                        when others then
                           nNumError:=0;
                       end;


                          UPDATE FA_CARGOS_REC_TO
                          SET FEC_BAJA      = dFechaEjecucion,
                                FEC_HASTACOBR = dFechaEjecucion,
                                FEC_ULTMOD    = dFechaEjecucion,
                                NOM_USUARIO   = vNOM_USUARORA
                          WHERE COD_CLIENTESERV     = nCodCliente
                          AND NUM_ABONADOSERV        = nNUM_ABONADO
                          AND COD_PROD_CONTRATADO   = 0;



                     end if;

                 nNumError:=9;
                 sMsgError:='Error, al insertar GA_HDTOSTARIF';
                 VP_TABLA:='GA_HDTOSTARIF';
                 VP_ACT:='I';

                 INSERT INTO GA_HDTOSTARIF (NUM_ABONADO, COD_CICLFACT, NUM_MINUTOS,TIP_PLANTARIF, COD_VENDEDOR,
                             NOM_USUARORA,FEC_GRABACION , FEC_BAJA )
                 SELECT NUM_ABONADO, COD_CICLFACT, NUM_MINUTOS,TIP_PLANTARIF, COD_VENDEDOR, NOM_USUARORA,
                 FEC_GRABACION, SYSDATE
                 FROM GA_DTOSTARIF
                                 WHERE NUM_ABONADO = nNUM_ABONADO
                         AND COD_CICLFACT <> sCodCicloFact;

                 nNumError:=10;
                 sMsgError:='Error, al eliminar GA_DTOSTARIF';
                 VP_TABLA:='GA_DTOSTARIF';
                 VP_ACT:='D';

                         DELETE GA_DTOSTARIF
                         WHERE NUM_ABONADO = nNUM_ABONADO
                         AND COD_CICLFACT <> sCodCicloFact;

                 nNumError:=11;
                 sMsgError:='Error, al actualizar GE_CLIENTES';
                 VP_TABLA:='GE_CLIENTES';
                 VP_ACT:='U';

                         UPDATE GE_CLIENTES
                 SET NUM_ABOCEL = NUM_ABOCEL - 1
                         WHERE COD_CLIENTE =  nCodCliente;

                 nNumError:=12;
                 sMsgError:='Error, al ejecutar PV_PR_NUMDUPLICADO';
                 VP_TABLA:='PV_PR_NUMDUPLICADO';
                 VP_ACT:='E';
                 if nNumCelular> 0 then
                 PV_PR_NUMDUPLICADO(nNumCelular, nNUM_ABONADO, sDuplicado,VP_ERROR);


                    IF VP_ERROR <> '0' THEN

                                                VP_SQLCODE:=VP_ERROR;                                                               --COL-72424|03-11-2008|GEZ
                                VP_SQLERRM:=SUBSTR('ERROR EN PV_PR_NUMDUPLICADO',1,60); --COL-72424|03-11-2008|GEZ

                        RAISE ERROR_PROCESO;
                    END IF;
                 end if;

                                 --if parametro de CP aplica realizar validacion para desactivacion o modificación

                                 nNumError:=41;                                                         --COL-72424|03-11-2008|GEZ
                 sMsgError:='Error, al obtener Parametro';      --COL-72424|03-11-2008|GEZ
                 VP_TABLA:='GED_PARAMETROS';                            --COL-72424|03-11-2008|GEZ
                 VP_ACT:='S';                                                           --COL-72424|03-11-2008|GEZ

                 SELECT val_parametro
                 INTO   sParametroCPersonal
                 FROM   ged_parametros
                 WHERE  nom_parametro = 'APLICA_NUMPERS_GSM';

                                 nNumError:=42;                                                                                                         --COL-72424|03-11-2008|GEZ
                 sMsgError:='Error, al ejecutar funcion PV_CLIENTEESATLANTIDA_FN';      --COL-72424|03-11-2008|GEZ
                 VP_TABLA:='PV_CLIENTEESATLANTIDA_FN';                                                          --COL-72424|03-11-2008|GEZ
                 VP_ACT:='F';                                                                                                           --COL-72424|03-11-2008|GEZ

                                 SELECT  PV_OBTIENEINFO_ATLANTIDA_PG.PV_CLIENTEESATLANTIDA_FN(nCodCliente)
                                 INTO Satlantida
                                 FROM DUAL;

                                 nNumError:=43;                                                                                                                         --COL-72424|03-11-2008|GEZ
                 sMsgError:='Error, al ejecutar procedimiento PV_EXISTEABOATLANTIDA2_PR';       --COL-72424|03-11-2008|GEZ
                 VP_TABLA:='PV_EXISTEABOATLANTIDA2_PR';                                                                         --COL-72424|03-11-2008|GEZ
                 VP_ACT:='P';                                                                                                                           --COL-72424|03-11-2008|GEZ

                                 PV_OBTIENEINFO_ATLANTIDA_PG.PV_EXISTEABOATLANTIDA2_PR(nNUM_ABONADO,LV_FLAG_ATLANTIDA,SN_cod_retorno,Sv_mens_retorno, Sn_num_Evento);

                                 IF TRIM(LV_FLAG_ATLANTIDA) ='TRUE' THEN
                                        Satlantida:=1;
                                ELSE
                                        Satlantida:=0;
                                END IF;

                                nNumError:=44;                                                                                                          --COL-72424|03-11-2008|GEZ
                sMsgError:='Error, al ejecutar funcion GA_EXISTE_NUMPERSONAL2_FN';      --COL-72424|03-11-2008|GEZ
                VP_TABLA:='GA_EXISTE_NUMPERSONAL2_FN';                                                          --COL-72424|03-11-2008|GEZ
                VP_ACT:='F';                                                                                                            --COL-72424|03-11-2008|GEZ

                                SELECT  GA_NUMCEL_PERSONAL_PG.GA_EXISTE_NUMPERSONAL2_FN(nNumCELULAR)
                                INTO sExisteNumPersonal
                                FROM DUAL;

                                nNumError:=45;                                                                                                                  --COL-72424|03-11-2008|GEZ
                sMsgError:='Error, al ejecutar funcion GA_EXISTE_NUMCORPORATIVO2_FN';   --COL-72424|03-11-2008|GEZ
                VP_TABLA:='GA_EXISTE_NUMCORPORATIVO2_FN';                                                               --COL-72424|03-11-2008|GEZ
                VP_ACT:='F';                                                                                                                    --COL-72424|03-11-2008|GEZ

                                SELECT  GA_NUMCEL_PERSONAL_PG.ga_existe_numcorporativo2_fn(nNumCELULAR)
                                INTO sExisteNumCorporativo
                                FROM DUAL;

                                BEGIN

                                         nNumError:=46;                                                                         --COL-72424|03-11-2008|GEZ
                         sMsgError:='Error, al obtener numero personal';        --COL-72424|03-11-2008|GEZ
                         VP_TABLA:='GA_NUMCEL_PERSONAL_TO';                                     --COL-72424|03-11-2008|GEZ
                         VP_ACT:='S';                                                                           --COL-72424|03-11-2008|GEZ

                                 SELECT NUM_CEL_PERS
                                 INTO SNumPersonal
                                 FROM GA_NUMCEL_PERSONAL_TO
                                 WHERE NUM_CEL_CORP=nNumCelular;

                                EXCEPTION
                                WHEN NO_DATA_FOUND THEN
                                         SNumPersonal:=0;
                                END;

                                IF (sParametroCPersonal = CV_TRUE) THEN
                           IF (SexisteNumCorporativo<>'0' AND Satlantida > 0 AND SNumPersonal > 0) THEN

                                          nNumError:=47;                                                                                --COL-72424|03-11-2008|GEZ
                          sMsgError:='Error, al actualizar numero personal';    --COL-72424|03-11-2008|GEZ
                          VP_TABLA:='GA_NUMCEL_PERSONAL_TO';                                    --COL-72424|03-11-2008|GEZ
                          VP_ACT:='U';                                                                                  --COL-72424|03-11-2008|GEZ

                                          UPDATE GA_NUMCEL_PERSONAL_TO
                                  SET COD_ESTADO=4
                                  WHERE NUM_CEL_CORP=NnumCelular;

                                          nNumError:=48;                                                                                                                                --COL-72424|03-11-2008|GEZ
                          sMsgError:='Error, al ejecutar procedimiento GA_DESACTIVA_NUMPERSONAL_PR';    --COL-72424|03-11-2008|GEZ
                          VP_TABLA:='GA_DESACTIVA_NUMPERSONAL_PR';                                                                              --COL-72424|03-11-2008|GEZ
                          VP_ACT:='P';                                                                                                                                  --COL-72424|03-11-2008|GEZ

                          GA_NUMCEL_PERSONAL_PG.GA_DESACTIVA_NUMPERSONAL_PR(SNumPersonal,'PV',Sn_p_correlativo,SN_cod_retorno,Sn_num_Evento,Sv_mens_retorno);

                                          IF SN_cod_retorno <> '0' THEN

                                                 VP_SQLCODE:=SUBSTR(Sn_num_Evento,1,15);   --COL-72424|03-11-2008|GEZ
                                 VP_SQLERRM:=SUBSTR(Sv_mens_retorno,1,60); --COL-72424|03-11-2008|GEZ

                                         RAISE  ERROR_PROCESO;
                                          END IF;
                           END IF;

                                   nNumError :=49;                                                                              --COL-72424|03-11-2008|GEZ
                   sMsgError :='Error, consultar por el tipo de plan';  --COL-72424|03-11-2008|GEZ
                   VP_TABLA  :='TA_PLANTARIF';                                                  --COL-72424|03-11-2008|GEZ
                   VP_ACT        :='S';                                                                         --COL-72424|03-11-2008|GEZ

                                   SELECT COD_TIPLAN INTO sCodTiplan
                                   FROM   TA_PLANTARIF
                                   WHERE  COD_PLANTARIF = vCodPlantarif;

                                   sAuxCodTiplan:='1';

                           IF sExisteNumPersonal <> '0'  AND sAuxCodTiplan <> sCodTiplan THEN

                                          nNumError:=50;                                                                                        --COL-72424|03-11-2008|GEZ
                          sMsgError:='Error, al consultar por el numero personal';      --COL-72424|03-11-2008|GEZ
                          VP_TABLA :='GA_NUMCEL_PERSONAL_TO';                                           --COL-72424|03-11-2008|GEZ
                          VP_ACT   :='S';                                                                                       --COL-72424|03-11-2008|GEZ

                                  SELECT NUM_CEL_CORP
                                  INTO   SNumPersonal
                                          FROM   GA_NUMCEL_PERSONAL_TO
                                  WHERE  NUM_CEL_PERS=nNumCelular;

                                          nNumError:=51;                                                                                --COL-72424|03-11-2008|GEZ
                          sMsgError:='Error, al actualizar numero personal';    --COL-72424|03-11-2008|GEZ
                          VP_TABLA:='GA_NUMCEL_PERSONAL_TO';                                    --COL-72424|03-11-2008|GEZ
                          VP_ACT:='U';                                                                                  --COL-72424|03-11-2008|GEZ

                                  UPDATE GA_NUMCEL_PERSONAL_TO
                                          SET COD_ESTADO=3
                                          WHERE  NUM_CEL_PERS = NnumCelular;

                                          nNumError:=52;                                                                                                                        --COL-72424|03-11-2008|GEZ
                          sMsgError:='Error, al ejecutar procedimiento GA_MODIFICA_NUMPERSONAL_PR';     --COL-72424|03-11-2008|GEZ
                          VP_TABLA:='GA_MODIFICA_NUMPERSONAL_PR';                                                                       --COL-72424|03-11-2008|GEZ
                          VP_ACT:='P';                                                                                                                          --COL-72424|03-11-2008|GEZ

                          GA_NUMCEL_PERSONAL_PG.GA_MODIFICA_NUMPERSONAL_PR(NnumCelular,SNumPersonal,'PV',Sn_p_correlativo,SN_cod_retorno,Sn_num_Evento,Sv_mens_retorno);

                       END IF;

                        END IF;

                        -- INI.MAM 25/09/2003 PORTABILIDAD NUMERICA
                        nNumError:=20;
                        sMsgError:='Error, al updatear GA_ABOCEL';
                        VP_TABLA:='GA_ABOCEL';
                        VP_ACT:='U';

                        UPDATE GA_ABOCEL
                        SET    COD_SITUACION='BAP',
                                FEC_BAJA=dFechaEjecucion,
                                FEC_ULTMOD=dFechaEjecucion,
                                COD_CAUSABAJA=vCOD_CAUSA
                        WHERE  NUM_ABONADO=nNUM_ABONADO;

                                nNumError:=52;                                                                          --COL-72424|03-11-2008|GEZ
                sMsgError:='Error, al inscribir en ga_modabocel';       --COL-72424|03-11-2008|GEZ
                VP_TABLA :='GA_MODABOCEL';                                                      --COL-72424|03-11-2008|GEZ
                VP_ACT   :='I';                                                                         --COL-72424|03-11-2008|GEZ

                        /************* Actualizar GA_MODABOCEL *************************/
                        INSERT INTO GA_MODABOCEL
                        (NUM_ABONADO, NUM_OS, COD_TIPMODI, FEC_MODIFICA,NOM_USUARORA,COD_CAUSA)
                        VALUES(nNUM_ABONADO, nNUM_OOSS, vCOD_ACTABO, SYSDATE, vNOM_USUARORA,vCOD_CAUSA);
                                -- FIN.MAM 25/09/2003 PORTABILIDAD NUMERICA

                IF sDuplicado = 'NO' AND vIndPortabilidad = 0 THEN
                                BEGIN

                          nNumError:=13;
                          sMsgError:='Error, al insertar en GA_CELNUM_REUTIL';
                          VP_TABLA:='GA_CELNUM_REUTIL';
                          VP_ACT:='I';

                                  INSERT INTO GA_CELNUM_REUTIL (NUM_CELULAR, COD_SUBALM, COD_PRODUCTO,
                          COD_CENTRAL, COD_CAT, COD_USO, FEC_BAJA, IND_EQUIPADO,USO_ANTERIOR )
                                  SELECT  nNumCelular , a.COD_SUBALM, a.COD_PRODUCTO,a.COD_CENTRAL,
                          a.COD_CAT, sCodUsoLinea, dFechaEjecucion+1, 1,a.COD_USO
                          FROM GA_CELNUM_USO a
                                  WHERE a.COD_PRODUCTO = nCodProducto
                                  AND nNumCelular BETWEEN a.NUM_DESDE AND a.NUM_HASTA;

                    EXCEPTION
                        WHEN OTHERS THEN

                                                         VP_SQLCODE:=SUBSTR(SQLCODE,1,15); --COL-72424|03-11-2008|GEZ
                                         VP_SQLERRM:=SUBSTR(SQLERRM,1,60); --COL-72424|03-11-2008|GEZ

                                 RAISE ERROR_PROCESO;
                    END;
                 END IF;

                 nNumError:=14;
                 sMsgError:='Error, al eliminar GA_FINCICLO';
                 VP_TABLA:='GA_FINCICLO';
                 VP_ACT:='D';

                         DELETE GA_FINCICLO
                         WHERE NUM_ABONADO  = nNUM_ABONADO
                         AND COD_CICLFACT = sCodCiclofact;

                 nNumError:=15;
                 sMsgError:='Error, al eliminar GA_PETSR';
                 VP_TABLA:='GA_PETSR';
                 VP_ACT:='D';

                         DELETE GA_PETSR
                         WHERE NUM_ABONADO  = nNUM_ABONADO;

                 IF nIndEqPrestado=1 THEN
                        --Devolucion Almacen

                        nNumError:=16;
                        sMsgError:='Error, al ejecutar  PV_PR_DEVALMACEN';
                        VP_TABLA:='PV_PR_DEVALMACEN';
                        VP_ACT:='E';

                        PV_PR_DEVALMACEN(sNumSerie,nNUM_ABONADO,vCOD_DEVEQ,vNOM_USUARORA,dFechaEjecucion,vCOD_ACTABO,VP_ERROR,sMsgError);

                        IF VP_ERROR <> '0' THEN

                                                   VP_SQLCODE:=VP_ERROR;                                                                    --COL-72424|03-11-2008|GEZ
                                   VP_SQLERRM:=SUBSTR('ERROR EN PV_PR_NUMDUPLICADO',1,60); --COL-72424|03-11-2008|GEZ

                           RAISE ERROR_PROCESO;
                        END IF;

                 END IF;

                 -- INICIO CH-140820031203 Patricio G. 12-09-2003
                 --IF V_IND_FAMILIAR = '1' THEN (P-MIX-06003 cpu)
                 nNumError:=25;
                 sMsgError:='Error, al ejecutar  PV_BAJA_FF_PR';
                 VP_TABLA:='PV_BAJA_FF_PR';
                 VP_ACT:='E';

                                 PV_BAJA_FF_PR(nCodCliente,nNUM_ABONADO,VP_ERROR);

                                 IF VP_ERROR <> '0' THEN

                                        VP_SQLCODE:=SUBSTR(VP_ERROR,1,15);                                 --COL-72424|03-11-2008|GEZ
                        VP_SQLERRM:=SUBSTR('ERROR EN PV_BAJA_FF_PR',1,60); --COL-72424|03-11-2008|GEZ

                        RAISE ERROR_PROCESO;
                 END IF;
                 --END IF;(P-MIX-06003 cpu)
                 --FIN CH-140820031203

                 IF nIndLn=1 THEN



                                                         -- ini p-col-06054 y.o.
                                             --nNumError := 26;
                                             --sMsgError := 'Error, al buscar en PV_PARAMETROS_SIMPLES_VW';
                                             --VP_TABLA:='PV_PARAMETROS_SIMPLES_VW';
                                             --VP_ACT:='S';

                                              --           SELECT VALOR_NUMERICO
                                              --          INTO PARAMETRO
                                              --          FROM   PV_PARAMETROS_SIMPLES_VW
                                              --          WHERE  NOM_PARAMETRO = 'FLAG_SERIE_NEGATIVA';

                                              --           SELECT "GA_SEQ_TRANSACABO".NEXTVAL INTO TRANSAC FROM DUAL;

                                             --nNumError := 25;
                                             --sMsgError := 'Error, al buscar en AL_CODIGO_EXTERNO no existe la causa';
                                             --VP_TABLA  :='AL_CODIGO_EXTERNO';
                                             --VP_ACT    :='S';

                                              --   SELECT 1, codigo_interno INTO dato_causa ,cod_causa_pl
                                              --           FROM al_codigo_externo
                                              --           WHERE codigo_externo = vCOD_CAUSA
                                              --           AND tip_codigo = '10011';

                                              --IF dato_causa = 1  THEN

                                                        --IF PARAMETRO = '1' THEN

                                                           --nNumError:=17;
                                                           --sMsgError:='Error, al insertar PV_SERIES_NEGATIVAS_PG.PV_SERIES_NEGATIVAS_PR';
                                                           --VP_TABLA :='PV_SERIES_NEGATIVAS_PR';
                                                           --VP_ACT   :='I';

                                                           --Pv_Series_Negativas_Pg.PV_SERIES_NEGATIVAS_PR( TRANSAC , sNumSerie , 'I' , nNUM_ABONADO , cod_causa_pl , 'PLBA' );

                                                           -- SELECT DES_CADENA INTO nNumError
                                                           --             FROM GA_TRANSACABO
                                                           --             WHERE NUM_TRANSACCION = TRANSAC;
                                                           --IF nNumError <> '0' THEN
                                                               -- VP_SQLCODE:=SUBSTR(TO_CHAR(nNumError),1,15);                                 --COL-72424|03-11-2008|GEZ
                                                               --VP_SQLERRM:=SUBSTR('ERROR EN PV_SERIES_NEGATIVAS_PR',1,60);  --COL-72424|03-11-2008|GEZ
                                                               --RAISE ERROR_PROCESO;
                                                           --END IF;

                                                        --ELSE

                                        nNumError:=17;
                                        sMsgError:='Error, al insertar en GA_LNCELU';
                                        VP_TABLA:='GA_LNCELU';
                                        VP_ACT:='I';

                                                                    --Inserta Lista Negra
                                         INSERT INTO GA_LNCELU
                                                (NUM_SERIE, IND_PROCEQUI, NUM_SERIEMEC, COD_OPERADOR,
                                                NUM_CELULAR, NUM_ABONADO, COD_CLIENTE, FEC_ALTA, COD_FABRICANTE, COD_ARTICULO)
                                                SELECT sNumSerie,IND_PROCEQUI,NULL,sCodOperador,nNumCelular,nNUM_ABONADO,
                                                nCodCliente, dFechaEjecucion,C.COD_FABRICANTE,B.COD_ARTICULO
                                                FROM GA_EQUIPABOSER B, AL_ARTICULOS C
                                                WHERE B.NUM_ABONADO = nNUM_ABONADO
                                                AND B.NUM_SERIE=sNumSerie
                                                AND B.IND_EQUIACC = 'E'
                                                AND B.FEC_ALTA IN (SELECT MAX(FEC_ALTA) FROM GA_EQUIPABOSER
                                                                   WHERE NUM_ABONADO = nNUM_ABONADO
                                                                   AND NUM_SERIE=sNumSerie
                                                                   AND IND_EQUIACC = 'E')
                                                                   AND C.COD_ARTICULO = B.COD_ARTICULO;
                                                                   
                         IF TRIM(LV_COD_OS) = '50013' OR TRIM(LV_COD_OS) = '50002' THEN

                                                                   
                                         SELECt COD_CAUSA 
                         INTO LV_COD_CAUSA_EIR
                         FROM GA_LISTACAUSAEIR_TD
                         WHERE COD_TIPOLISTA='B'
                         AND COD_OS         = LV_COD_OS
                         AND IND_CAUSA      = 1
                         AND SYSDATE BETWEEN FEC_DESDE AND FEC_HASTA;
                                        
                         INSERT INTO GA_CAUSAEIR_TO (NUM_SERIE,COD_CAUSA,COD_TIPOLISTA,
                                                     COD_OS,FEC_ING,NOM_USUARIO,ORIG_TRANS,COD_CAUSA_OS)
                         SELECT sNumSerie,LV_COD_CAUSA_EIR,'B',LV_COD_OS,dFechaEjecucion,vNOM_USUARORA,'1',vCOD_CAUSA
                     FROM GA_EQUIPABOSER B, AL_ARTICULOS C
                                                WHERE B.NUM_ABONADO = nNUM_ABONADO
                                                AND B.NUM_SERIE=sNumSerie
                                                AND B.IND_EQUIACC = 'E'
                                                AND B.FEC_ALTA IN (SELECT MAX(FEC_ALTA) FROM GA_EQUIPABOSER
                                                                   WHERE NUM_ABONADO = nNUM_ABONADO
                                                                   AND NUM_SERIE=sNumSerie
                                                                   AND IND_EQUIACC = 'E')
                                                                   AND C.COD_ARTICULO = B.COD_ARTICULO;  
                         END IF;
                                                                   
                                        -- END IF;

                                        --                 ELSE

                                        --                        VP_SQLCODE:=SUBSTR(SQLCODE,1,15); --COL-72424|03-11-2008|GEZ
                                        --        VP_SQLERRM:=SUBSTR(SQLERRM,1,60); --COL-72424|03-11-2008|GEZ
                                        --                        RAISE ERROR_PROCESO;


                         END IF;
                                                         -- fin p-col-06054 y.o.

        EXCEPTION
                                WHEN DUP_VAL_ON_INDEX THEN
                                 NULL;
        END;


                 nNumError:=18;
                 sMsgError:='Error, al obtener dato desde Cursor Servicios';
                 VP_TABLA:='CURSOR';
                 VP_ACT:='S';

                 OPEN C_SERVACT;

                 LOOP
                          FETCH C_SERVACT INTO vServicio;
                          EXIT WHEN C_SERVACT%NOTFOUND;

                          vCadServicio:=vCadServicio||vServicio;


                         --Indica IP Móvil


                 END LOOP;

                                 --INI COL-72424|03-11-2008|GEZ
                 /*
                                 nNumError:=19;
                 sMsgError:='Error, al insertar PV_MOVIMIENTOS';
                 VP_TABLA:='PV_MOVIMIENTOS';
                 VP_ACT:='I';

                         -- Ingresa Movimiento en Interfaz
                                 SELECT COD_TIPLAN INTO sCodTiplan
                                 FROM   TA_PLANTARIF
                                 WHERE  COD_PLANTARIF = vCodPlantarif;

                                 SELECT GE_FN_DEVVALPARAM('GA', 1, 'TIPOHIBRIDO')
                                 INTO sAuxCodTiplan
                                 FROM dual;

                                 IF sAuxCodTiplan = sCodTiplan THEN
                                         BEGIN
                                         SELECT COD_ACTABO INTO sAuxCodActabo
                                                 FROM PV_ACTABO_TIPLAN
                                                 WHERE COD_TIPMODI = vCOD_ACTABO
                                                 AND   COD_TIPLAN = sCodTiplan;

                                         EXCEPTION
                                             WHEN NO_DATA_FOUND THEN
                                                      sAuxCodActabo := vCOD_ACTABO;
                                         END;
                                 ELSE
                                         sAuxCodActabo := vCOD_ACTABO;
                                 END IF;
                                 */
                                 BEGIN

                                         nNumError := 53;
                         sMsgError := 'Error, al buscar actabo';
                         VP_TABLA  := 'PV_ACTABO_TIPLAN';
                         VP_ACT    := 'S';

                                         SELECT cod_actabo
                                         INTO   sAuxCodActabo
                         FROM   pv_actabo_tiplan
                                         WHERE  cod_os          =(SELECT cod_os FROM pv_iorserv WHERE num_os=nNUM_OOSS)
                                         AND    cod_tipmodi     =(SELECT cod_tipmodi
                                                                                  FROM ci_tiporserv WHERE cod_os=(SELECT cod_os
                                                                                                                                                  FROM pv_iorserv
                                                                                                                                                  WHERE num_os=nNUM_OOSS)
                                                                                 )
                                         AND    cod_tiplan      =(SELECT cod_tiplan FROM ta_plantarif WHERE cod_plantarif = vCodPlantarif);
                                 EXCEPTION
                                        WHEN NO_DATA_FOUND THEN
                                                 sAuxCodActabo := vCOD_ACTABO;
                                 END;
                                 --FIN COL-72424|03-11-2008|GEZ

                                 Pv_Pr_Insmovimientos(nNUM_OOSS,dFechaEjecucion,nOrdComando,sAuxCodActabo,vCadServicio,VP_ERROR,sMsgError);

                                 IF VP_ERROR <> '0' THEN

                                                VP_SQLCODE:=SUBSTR(VP_ERROR,1,15); --COL-72424|03-11-2008|GEZ
                                VP_SQLERRM:=SUBSTR(sMsgError,1,60); --COL-72424|03-11-2008|GEZ

                        RAISE ERROR_PROCESO;
                 END IF;

--                  nNumError:=20;
--                  sMsgError:='Error, al updatear GA_ABOCEL';
--                  VP_TABLA:='GA_ABOCEL';
--                  VP_ACT:='U';
--
--                  UPDATE GA_ABOCEL
--                                 SET COD_SITUACION='BAP',
--                                         FEC_BAJA=dFechaEjecucion,
--                                         FEC_ULTMOD=dFechaEjecucion,
--                                         COD_CAUSABAJA=vCOD_CAUSA
--                  WHERE NUM_ABONADO=nNUM_ABONADO;
--
--            /************* Actualizar GA_MODABOCEL *************************/
--              INSERT INTO GA_MODABOCEL
--                  (NUM_ABONADO, NUM_OS, COD_TIPMODI, FEC_MODIFICA,NOM_USUARORA,COD_CAUSA)
--                  VALUES(nNUM_ABONADO, nNUM_OOSS, vCOD_ACTABO, SYSDATE, vNOM_USUARORA,vCOD_CAUSA);

                /*********** INSERTAR EN PV_ADMIN_CARTAS_TO ********************/

/*              IF NVL(nTipoOrdenServicio , -1 )  =  1  AND nCodigoEstado = 0  THEN */
                 IF nTipoOrdenServicio = 1  THEN
                                         nNumError:=21;
                     sMsgError:='Error, al insertar en PV_ADMIN_CARTAS_TO';
                     VP_TABLA:='PV_ADMIN_CARTAS_TO';
                     VP_ACT:='I';

                     INSERT INTO PV_ADMIN_CARTAS_TO
                     (NUM_OS,COD_OS,NUM_ABONADO ,COD_CAUSABAJA,NUM_CELULAR,FEC_INGRESO,NOM_USUARIO,COD_OFICINA,COD_CLIENTE,NUM_CARTA)
                     VALUES
                     (nNUM_OOSS,vCodigoOrdenServicio,nNUM_ABONADO,vCOD_CAUSA,nNumCelular,SYSDATE,vNOM_USUARORA,vCodigoOficina,nCodCliente,0);

                END IF;

                IF nNotaCredito = 1 THEN

                   nNumError:=22;
                   sMsgError:='Error, al obtener numero de transaccion';
                   VP_TABLA:='GA_SEQ_TRANSACABO';
                   VP_ACT:='E';

                   SELECT GA_SEQ_TRANSACABO.NEXTVAL INTO v_transac
                   FROM DUAL;

                   BEGIN
                           nNumError:=23;
                           sMsgError:='Error, al extraer Fecha';
                           VP_TABLA:='DUAL';
                           VP_ACT:='S';

                           SELECT TO_CHAR(SYSDATE,'YYYYMMDD')
                           INTO sfaFecBaja
                           FROM DUAL;

                           nNumError:=24;
                           sMsgError:='Error, al ejecuta FA_PROC_PRE_NCBAJAS';
                           VP_TABLA:='FA_PROC_PRE_NCBAJAS';
                           VP_ACT:='E';

                           FA_PROC_PRE_NCBAJAS(v_transac,nCodCliente,nNUM_ABONADO,sfaFecBaja,1,vNOM_USUARORA,0);

                   EXCEPTION
                           WHEN OTHERS THEN

                                                                VP_SQLCODE:=SUBSTR(TO_CHAR(nNumError),1,15); --COL-72424|03-11-2008|GEZ
                                                VP_SQLERRM:=SUBSTR('ERROR EN FA_PROC_PRE_NCBAJAS',1,60); --COL-72424|03-11-2008|GEZ

                                        RAISE ERROR_PROCESO;

                   END;
                END IF;

                -- INI COL|43301|26-09-2007|SAQL
                BEGIN
                       nNumError:=27;
                       sMsgError:='Error, al eliminar numero frecuente';
                       VP_TABLA:='GA_NUMESPABO';
                       VP_ACT:='D';

                       DELETE GA_NUMESPABO
                       WHERE NUM_ABONADO = nNUM_ABONADO;
                EXCEPTION
                        WHEN OTHERS THEN
                                 VP_SQLCODE:=SUBSTR(SQLCODE,1,15); --COL-72424|03-11-2008|GEZ
                                 VP_SQLERRM:=SUBSTR(SQLERRM,1,60); --COL-72424|03-11-2008|GEZ
                                 RAISE ERROR_PROCESO;
                END;
                -- FIN COL|43301|26-09-2007|SAQL

                                -- INI COL|65280|09-05-2008|SAQL
                BEGIN
                         nCantidad := 0;
                         BEGIN
                                  SELECT COUNT(1)
                                                  INTO nCantidad
                                  FROM PV_IORSERV A, PV_CAMCOM B
                                  WHERE A.COD_ESTADO = 10
                                  AND A.FH_EJECUCION > SYSDATE
                                  AND A.NUM_OS <> nNUM_OOSS
                                  AND A.NUM_OS = B.NUM_OS
                                  AND B.NUM_ABONADO = nNUM_ABONADO;
                         EXCEPTION
                                WHEN OTHERS THEN
                                 nCantidad := 0;
                         END;

                                         IF nCantidad > 0 THEN -- PASO A HISTORICO

                                                nNumError:=28;
                                sMsgError:='Error, al pasar a historico ooss a futuro';

                                                -- INSERTO COD_ESTADO = 3 A LA TABLA PV_ERECORRIDO
                                INSERT INTO PV_ERECORRIDO
                                SELECT A.NUM_OS, 3, 'ANULACION OOSS POR BAJA', 3, SYSDATE, NULL
                                FROM PV_IORSERV A, PV_CAMCOM B
                                WHERE A.COD_ESTADO = 10
                                AND A.FH_EJECUCION > SYSDATE
                                AND A.NUM_OS <> nNUM_OOSS
                                AND A.NUM_OS = B.NUM_OS
                                AND B.NUM_ABONADO = nNUM_ABONADO;

                                -- MODIFICO ESTADO EN PV_ERECORRIDO PARA COD_ESTADO = 10
                                UPDATE PV_ERECORRIDO SET
                                TIP_ESTADO = 5,
                                MSG_ERROR = 'ANULACION OOSS POR BAJA'
                                WHERE COD_ESTADO = 10
                                AND NUM_OS IN (
                                                  SELECT A.NUM_OS
                                                  FROM PV_IORSERV A, PV_CAMCOM B
                                                  WHERE A.COD_ESTADO = 10
                                                  AND A.FH_EJECUCION > SYSDATE
                                                  AND A.NUM_OS <> nNUM_OOSS
                                                  AND A.NUM_OS = B.NUM_OS
                                                  AND B.NUM_ABONADO = nNUM_ABONADO
                                );

                                -- MODIFICO COD_ESTADO EN PV_IORSERV
                                UPDATE PV_IORSERV SET
                                COD_ESTADO = 3
                                WHERE ROWID IN (
                                                        SELECT A.ROWID
                                                        FROM PV_IORSERV A, PV_CAMCOM B
                                                        WHERE A.COD_ESTADO = 10
                                                        AND A.FH_EJECUCION > SYSDATE
                                                        AND A.NUM_OS <> nNUM_OOSS
                                                        AND A.NUM_OS = B.NUM_OS
                                                        AND B.NUM_ABONADO = nNUM_ABONADO
                                                                );

                         END IF;
                EXCEPTION
                        WHEN OTHERS THEN

                                                 VP_SQLCODE:=SUBSTR(SQLCODE,1,15); --COL-72424|03-11-2008|GEZ
                                 VP_SQLERRM:=SUBSTR(SQLERRM,1,60); --COL-72424|03-11-2008|GEZ

                                 RAISE ERROR_PROCESO;
                END;
                -- FIN COL|65280|09-05-2008|SAQL
/*
        EXCEPTION
                WHEN OTHERS THEN

                                 VP_SQLCODE:=SUBSTR(SQLCODE,1,15); --COL-72424|03-11-2008|GEZ
                 VP_SQLERRM:=SUBSTR(SQLERRM,1,60); --COL-72424|03-11-2008|GEZ

                 RAISE ERROR_PROCESO;
        END;
*/
        nNumError:=0;
        sMsgError:='Operación Exitosa';
        nCOD_ERROR:=nNumError;
        sMEN_ERROR:=sMsgError;

EXCEPTION
        WHEN ERROR_PROCESO THEN

                  --VP_SQLCODE:=SUBSTR(SQLCODE,1,15); --COL-72424|03-11-2008|GEZ
                  --VP_SQLERRM:=SUBSTR(SQLERRM,1,60); --COL-72424|03-11-2008|GEZ

                  ROLLBACK;

                  INSERT INTO GA_ERRORES(COD_ACTABO,CODIGO,FEC_ERROR,COD_PRODUCTO,NOM_PROC,
                  NOM_TABLA,COD_ACT,COD_SQLCODE,COD_SQLERRM)
                  VALUES(vCOD_ACTABO,nNUM_ABONADO,SYSDATE,1,VP_PROC,VP_TABLA,VP_ACT,
                  VP_SQLCODE,VP_SQLERRM);


                  COMMIT;

                  nCOD_ERROR:=nNumError;
                  sMEN_ERROR:=sMsgError;

        WHEN OTHERS THEN

                  VP_SQLCODE:=SUBSTR(SQLCODE,1,15);
                  VP_SQLERRM:=SUBSTR(SQLERRM,1,60);

                  ROLLBACK;

                  INSERT INTO GA_ERRORES(COD_ACTABO,CODIGO,FEC_ERROR,COD_PRODUCTO,NOM_PROC,
                  NOM_TABLA,COD_ACT,COD_SQLCODE,COD_SQLERRM)
                  VALUES(vCOD_ACTABO,nNUM_ABONADO,SYSDATE,1,VP_PROC,VP_TABLA,VP_ACT,
                  VP_SQLCODE,VP_SQLERRM);

                  COMMIT;

                  nCOD_ERROR:=-9;
                  sMEN_ERROR:='Error no determinado en la aplicacion. Revisar tabla GA_ERRORES.';

END PV_PR_BAJAABONADO;
/
SHOW ERRORS

