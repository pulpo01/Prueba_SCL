CREATE OR REPLACE PROCEDURE PV_PR_BAJAAMISTAR (


/***********************************************************************************
   NOMBRE:       PV_PR_BAJAAMISTAR
   DESCRIPCION:  Procedimiento que es llamado de PRO-C Solamente para Opta Amistar
   FECHA:                17-03-2002
   AUTOR:                Karem Fernandez  Ayala
******************************************************************************/

--PV_PR_BAJAAMISTAR: v1.1 //RA-200602200811: German Espinoza Z; 24/02/2006
--PV_PR_BAJAAMISTAR: v1.2 //CO-200608160327: German Espinoza Z; 17/08/2006
--PV_PR_BAJAAMISTAR: v1.3 //COL-38130/07-03-2007/PCR
--PV_PR_BAJAAMISTAR: v1.4 //RRG COL 09-05-2007 40282
--PV_PR_BAJAAMISTAR: v1.5 //COL-41006|29-05-2007|GEZ
--PV_PR_BAJAAMISTAR: v1.6 //COL-41254|08-06-2007|EFR
--PV_PR_BAJAAMISTAR: v1.7 //COL-72966|19-11-2008|JJR
--*****************************************************************************


                nNUM_OOSS                IN NUMBER,               --Numero de OOSS
        nNUM_ABONADO                     IN NUMBER,               --Numero de abonado
        vCOD_ACTABO              IN VARCHAR2,             --Csdigo de actuacisn
        vCOD_CAUSA               IN VARCHAR2,             --Csdigo de Causa de Baja
        vNOM_USUARORA                    IN VARCHAR2,             --Usuario Responsable
        vNUM_CELULAR                     IN VARCHAR2,             --Celular del Abonado Amistar
        nCOD_ERROR               OUT NOCOPY NUMBER,
        sMEN_ERROR               OUT NOCOPY VARCHAR2)
IS

        nNumError                                                NUMBER (2);   -- numero de error
        sMsgError                                                VARCHAR2(60); -- mensaje de error
        sDuplicado                                                       VARCHAR2(2);
        --MIX-06003
                sParametroCPersonal                      GED_PARAMETROS.VAL_PARAMETRO%TYPE; --Parametro Cuenta Personal
                sAtlantida                               NUMBER(1);
                sExisteNumPersonal                                               VARCHAR2(1);
                sExisteNumCorporativo                                    VARCHAR2(1);
                SNumPersonal                             GA_NUMCEL_PERSONAL_TO.NUM_CEL_PERS%TYPE;
                SN_p_correlativo                             NUMBER(9);
            SN_cod_retorno                           ge_errores_pg.CodError;
        SV_mens_retorno                          ge_errores_pg.MsgError;
        SN_num_evento                            ge_errores_pg.Evento;
                --MIX-06003

        dFechaEjecucion                                          DATE;
        sCadServiciosAmiAdic                                     VARCHAR2(255);
        sCadServiciosAmi                                         VARCHAR2(255);
        sCodNivel                                                VARCHAR2(2);
        nCodActCen                                               GA_ACTABO.COD_ACTCEN%TYPE;
        nNumOOSS                                                 NUMBER(10);
        nNumMeses                                                NUMBER(3);
        sCodActabo                                               VARCHAR2(2);
        sSubNomCliente                                           VARCHAR2(50);
        sCodModulo                                               VARCHAR2(2);
        sAuxCodServ                                              VARCHAR2(255);
                sAplicAltaPP                                                     GED_PARAMETROS.VAL_PARAMETRO%TYPE;

        -- Variables de Error, para procediemientos.

        VP_ERROR                                                 VARCHAR2(1);
        VP_PROC                                                  VARCHAR2(50);
        VP_SQLCODE                                               VARCHAR2(15);
        VP_SQLERRM                                               VARCHAR2(70);
        VP_TABLA                                                 VARCHAR2(50);
        VP_ACT                                                   VARCHAR2(1);



        LV_COD_PRESTACION                        TA_PLANTARIF.COD_PRESTACION%TYPE; 
        vCodAmiPlantarif                         GA_DATOSGENER.COD_AMI_PLANTARIF%TYPE;
        vCodAmiPlanServ                          GA_DATOSGENER.COD_AMI_PLANSERV%TYPE;
        vCodAmiCargoBasico                       GA_DATOSGENER.COD_AMI_CARGOBASICO%TYPE;
        vCodAmiCiclo                             GA_DATOSGENER.COD_AMI_CICLO%TYPE;
        vCodAmiCauBaja                           GA_DATOSGENER.COD_AMI_CAUBAJA%TYPE;
        vCodAmiTipContra                         GA_DATOSGENER.COD_AMI_TIPCONTRA%TYPE;

        sCodCicloFact                            FA_CICLFACT.COD_CICLFACT%TYPE;
        vNumAbonado                              GA_ABOAMIST.NUM_ABONADO%TYPE;

        nCodProducto                             GA_ABOCEL.COD_PRODUCTO%TYPE;
        nCodCliente                              GA_ABOCEL.COD_CLIENTE%TYPE;
        nNumCelular                              GA_ABOCEL.NUM_CELULAR%TYPE;
        vCodPlantarif                            GA_ABOCEL.COD_PLANTARIF%TYPE;
                vCodCargoBasico                          GA_ABOCEL.COD_CARGOBASICO%TYPE;
        vTipPlantarif                            GA_ABOCEL.TIP_PLANTARIF%TYPE;
        vCodCiclo                                GA_ABOCEL.COD_CICLO%TYPE;
        vCodTipContrato                          GA_ABOCEL.COD_TIPCONTRATO%TYPE;
--      nIndEqPrestado                           GA_ABOAMIST.IND_EQPRESTADO%TYPE;
        nCodEmpresa                              GA_ABOCEL.COD_EMPRESA%TYPE;
        nNumMin                                  GA_ABOCEL.NUM_MIN%TYPE;
        sNumSerie                                GA_ABOCEL.NUM_SERIE%TYPE;
        sNumSerieHex                             GA_ABOCEL.NUM_SERIEHEX%TYPE;
        sTipTerminal                             GA_ABOCEL.TIP_TERMINAL%TYPE;
        nCodCuenta                               GA_ABOCEL.COD_CUENTA%TYPE;
        sCodTecnologia                           GA_ABOCEL.COD_TECNOLOGIA%TYPE;
        sNumImei                                 GA_ABOCEL.NUM_IMEI%TYPE;
        sCodUso                                  GA_ABOCEL.COD_USO%TYPE;

        nCodClienteAux                           GE_CLIENTES.COD_CLIENTE%TYPE;
        nNuevoCliente                            GE_CLIENTES.COD_CLIENTE%TYPE;
        vNomApeClien1                            GE_CLIENTES.NOM_APECLIEN1%TYPE;
        nNuevoAbonado                            GA_ABOAMIST.NUM_ABONADO%TYPE;
        nCodVendedorAgente                       GA_ABOAMIST.COD_VENDEDOR_AGENTE%TYPE;
        nCodClienteDist                          GA_ABOAMIST.COD_CLIENTE_DIST%TYPE;
        nCodCuentaDist                           GA_ABOAMIST.COD_CUENTA_DIST%TYPE;
        nCodUso                                  GA_ABOAMIST.COD_USO%TYPE;
        nCodPlantarif                            GA_TRASPABO.COD_PLANTARIF_ORIG%TYPE;
        nCodCentral                              GA_ABOAMIST.COD_CENTRAL%TYPE;
        nCodUsuario                              GA_USUAMIST.COD_USUARIO%TYPE;

        nCargaTotal                              GAT_SERIES_PROMOC.CARGA_TOTAL%TYPE;
        nCargaPeriodo                            GAT_SERIES_PROMOC.CARGA_PERIODO%TYPE;
        nCodMoneda                               GAT_SERIES_PROMOC.COD_MONEDA%TYPE;
        nCodPromocion                            GA_PROMOC_AMISTAR.COD_PROMOCION%TYPE;
        nValCargaIni                             GA_PROMOC_AMISTAR.VAL_CARGA_INI%TYPE;

        vNumMinMdn                                                       GA_ABOAMIST.NUM_MIN_MDN%TYPE; -- Modificación - GBM - TM-200408180902 - 20-08-2004

        nIndLn                                   GA_CAUSABAJA.IND_LN%TYPE;
        sCodOperador                             TA_DATOSGENER.COD_OPERADOR%TYPE;
        sCodModulos                              GE_MODULOS.COD_MODULO%TYPE;
        sCodValor                                GED_CODIGOS.COD_VALOR%TYPE;
                sAuxCodActabo                                                    GA_ACTABO.COD_ACTABO%TYPE;
                sCodTiplan                                                               TA_PLANTARIF.COD_TIPLAN%TYPE;
                sCodOperadora                                                    GE_OPERADORA_SCL_LOCAL.COD_OPERADORA_SCL%TYPE;
                sTipPlanHibrido                                                  GED_PARAMETROS.VAL_PARAMETRO%type;
                sCodFecAlta                              GED_PARAMETROS.VAL_PARAMETRO%type;
                Vcod_plan_comverse                                               TA_PLANTARIF.cod_plan_comverse%TYPE; --TM-20040714837 -SOPORTE - 16/07/2004
                scodtec                                                                  VARCHAR2(5);-- TM-20040714837 -SOPORTE - 16/07/2004
                cod_ami_cargobasico                                      VARCHAR2(5); --TM-20040714837 -SOPORTE - 16/07/2004

        ERROR_PROCESO                                                    EXCEPTION;

                --OCB-INI-TMM_04010
                ERROR_PROCESO_PUNTUAL                                    EXCEPTION;
                --OCB-FIN-TMM_04010


                nNumtransacc                                                     GA_TRANSACABO.NUM_TRANSACCION%TYPE;
                nCOD_RETORNO                                                     GA_TRANSACABO.COD_RETORNO%TYPE;

                --TM-200501131209: German Espinoza Z; 14/01/2005
                sCod_ZonaCentral                                             VARCHAR2(5);
                sCdma_Zona1900                                                   GED_PARAMETROS.VAL_PARAMETRO%TYPE;
                sCdma_Zona850                                                    GED_PARAMETROS.VAL_PARAMETRO%TYPE;
                --FIN - TM-200501131209: German Espinoza Z; 14/01/2005




                --OCB-INI-TMM-04010
                vCOD_VENDEDOR                                                    GA_ABOCEL.COD_VENDEDOR%TYPE;
                VCOD_USUARIO                                                     GA_ABOCEL.COD_USUARIO%TYPE;
                VCOD_SUBCUENTA                                                   GA_ABOCEL.COD_SUBCUENTA%TYPE;
                sVALParam_MIGRA                                                  GED_PARAMETROS.VAL_PARAMETRO%type;
                vCodPlantarif_des                                                GED_PARAMETROS.VAL_PARAMETRO%type;
                vCANT_MIGRA                                                              INTEGER;
                --vCodPlantarif_original                   GA_ABOCEL.COD_PLANTARIF%TYPE;
                vInd_traspaso                                                    GED_PARAMETROS.VAL_PARAMETRO%type;
                stip_plan                                GED_PARAMETROS.VAL_PARAMETRO%TYPE;
                ncod_ret                                                         INTEGER;
            scod_men                                                             VARCHAR2(255);
                vDES_CADENA                                                              VARCHAR2(255);
                --PAGC-TMM_04010
                vCod_vendedor_nuevo                                      GA_ABOAMIST.COD_VENDEDOR%TYPE;
                --FIN-PAGC-TMM_04010-
                --OCB-FIN-TMM-04010

                --RA-200602200811: German Espinoza Z; 24/02/2006
                LV_sSql                                                                  VARCHAR2(2000);
                LV_sSql2                                                                 VARCHAR2(2000);
                LV_sSql3                                                                 VARCHAR2(2000);
                LV_CodServTercen                                                 icg_actuaciontercen.cod_servicios%TYPE;
                LN_CodSersupl                                                    ga_servsupl.cod_servsupl%TYPE;
                LN_CodNivel                                                              ga_servsupl.cod_nivel%TYPE;
                LN_CantServ                                                              NUMBER(2);
                --FIN/RA-200602200811: German Espinoza Z; 24/02/2006

                vCodCategoria                                                    GED_PARAMETROS.VAL_PARAMETRO%TYPE; --COL-38130/07-03-2007/PCR

                vInd_Alta_pp                                                     GE_CLIENTES.IND_ALTA%TYPE; -- COL-41254|08-06-2007|EFR.

                --P-COL-06052 refactory numero frecuentes y baja opta prepago a ciclo en el trasabo 2008-01-29 IGO--
                NCOD_ACTIVIDAD_AUX ve_excepcion_vta_prepago_to.COD_CAUSA%TYPE;


                --INI YAAT P-MIX-06003 --
                eo_secuencia         pv_secuencia_qt; -- obtenersecuencia
                TYPE refCursor           IS REF CURSOR;
                SV_record                        refCursor;
                eo_param             pv_valida_serv_actdec_qt;
                ln_num_ooss          NUMBER(15);
                sCadServiciosmotor   VARCHAR2(255);
                ln_cero              number:=  0;
                setNumMovimiento     number(9);
                setCodActAbo         varchar2(2);
                setIndFactur         varchar2(1);
                setDesServ           varchar2(255);
                setNumUnidades       number(6);
                setCodConcepto       number(4);
                setImpCargo          number(14,4);
                setCodArticulo       number(6);
                setCodBodega         number(6);
                setNumSerie          varchar2(255);
                setIndEquipo         varchar2(1);
                setCodCliente        number(8);
                setNumAbonado        number(8);
                setTipDto            varchar2(1);
                setValDto            number(14,4);
                setCodConceptoDTO    number(4);
                setNumCelular            number(15);
                setCodPlanCom            number(6);
                setClaseServiciosAct varchar2(255);
                setClaseServiciosDes varchar2(255);
                setParam1_mens       varchar2(255);
                setParam2_mens       varchar2(255);
                setParam3_mens       varchar2(255);
                setClaseServicios    varchar2(255);
                setDesMoneda         varchar2(255);
                setCodMoneda         varchar2(3);
                setCodCiclo          number(2);
                setFacCont           number(1);
                setPDesc             number(1);
                setValMin            number(14,4);
                setValMax            number(14,4);
                setCodError          number(1);
                DES_ERROR            varchar2(255);
                lv_cod_planserv      varchar2(3);

                --FIN YAAT P-MIX-06003 --

/*************************************
* CURSOR PARA PROMOCION AMISTAR
**************************************/



    /*CURSOR CUR_PROMOCION IS
        SELECT COD_PROMOCION, VAL_CARGA_INI
        FROM GA_PROMOC_AMISTAR
        WHERE SYSDATE BETWEEN FEC_DESDE AND FEC_HASTA
        AND COD_UNIPROM = 1;*/

/*************************************
* CURSOR PARA OBTENER CODIGO CLIENTE
**************************************/

        CURSOR CUR_CLIENTE(nCodCuentaCur number, vCodAmiCicloCur number)  IS
        SELECT COD_CLIENTE
        FROM GE_CLIENTES
        WHERE COD_CUENTA = nCodCuentaCur
        AND COD_CICLO = vCodAmiCicloCur
                AND NUM_ABOCEL < 9999; ---- RRG 40282 COL 09-05-2007

/*************************************
* CURSOR PARA OBTENER CADENA DE SERVICIOS
**************************************/

-- inicio modificacion TM-200407070815 ------

       --CO-200608160327: German Espinoza Z; 17/08/2006
           --CURSOR CUR_SERVICIO_AMI(nCodUsoAux number) IS
           CURSOR CUR_SERVICIO_AMI(nCodUsoAux number,LV_CodServTercen VARCHAR2) IS
           --FIN/CO-200608160327: German Espinoza Z; 17/08/2006
           SELECT CONCAT(LTRIM(TO_CHAR(B.COD_SERVSUPL,'00')),LTRIM(TO_CHAR(B.COD_NIVEL,'0000')))
           FROM GAD_SERVSUP_PLAN A, GA_SERVSUPL B, GA_SERVUSO C
           WHERE B.COD_SERVICIO = C.COD_SERVICIO
             AND B.COD_PRODUCTO = C.COD_PRODUCTO --COD_SERVICIO PAGC-OCB 29-12-2004 -----
             AND C.COD_USO = nCodUsoAux
             AND A.COD_SERVICIO = B.COD_SERVICIO
             AND A.COD_PRODUCTO = B.COD_PRODUCTO
             AND SYSDATE BETWEEN A.FEC_DESDE AND NVL(A.FEC_HASTA, SYSDATE)
             AND A.TIP_RELACION = 3
             AND A.COD_PLANTARIF = nCodPlantarif
             AND A.COD_PRODUCTO = C.COD_PRODUCTO
                 AND INSTR(LV_CodServTercen,CONCAT(LTRIM(TO_CHAR(B.COD_SERVSUPL,'00')),LTRIM(TO_CHAR(B.COD_NIVEL,'0000'))))=0
           /*WHERE A.COD_PRODUCTO = nCodProducto*/
           /*AND C.COD_SERVICIO = B.COD_SERVICIO*/
           UNION
           SELECT CONCAT(LPAD(A.COD_SERVSUPL,2,'00'),LPAD(A.COD_NIVEL,4,'0000'))
           FROM GA_SERVSUPLABO A, GA_ABOCEL B, GA_SERVUSO C
           WHERE A.COD_SERVICIO = C.COD_SERVICIO
             AND NVL(A.COD_PRODUCTO,0)=C.COD_PRODUCTO
             AND C.COD_USO = nCodUsoAux
             AND NVL(A.COD_PRODUCTO,0) = B.COD_PRODUCTO
             AND A.NUM_ABONADO = B.NUM_ABONADO
             AND SYSDATE BETWEEN A.FEC_ALTABD AND NVL(A.FEC_BAJABD,SYSDATE)
             AND A.NUM_ABONADO = nNUM_ABONADO
             AND EXISTS (
                                SELECT D.COD_SERVICIO
                                    FROM GAD_SERVSUP_PLAN D
                                    WHERE D.COD_SERVICIO = A.COD_SERVICIO
                                    AND D.COD_PLANTARIF = nCodPlantarif
                                    AND TIP_RELACION <> '3'
                                    AND SYSDATE BETWEEN FEC_DESDE AND NVL(D.FEC_HASTA, SYSDATE)
                                    );

           /*WHERE A.NUM_ABONADO = nNUM_ABONADO*/
           /*AND A.COD_PRODUCTO = B.COD_PRODUCTO*/
           /*AND A.COD_PRODUCTO = C.COD_PRODUCTO*/
           /*AND A.COD_SERVICIO = C.COD_SERVICIO*/
           /*AND A.COD_SERVICIO IN (SELECT COD_SERVICIO*/
                                  /*FROM GAD_SERVSUP_PLAN */
                                  /*WHERE COD_PLANTARIF = nCodPlantarif*/
                                  /*AND TIP_RELACION <> '3'*/
                                  /*AND SYSDATE BETWEEN FEC_DESDE AND NVL(FEC_HASTA, SYSDATE));*/

-- Fin modificacion TM-200407070815 ------

   --CO-200608160327: German Espinoza Z; 17/08/2006
   sClaseServicio                        ga_aboamist.clase_servicio%TYPE;

   CURSOR CUR_ServSup(nNumAbonado number)  IS
        SELECT CONCAT(LTRIM(TO_CHAR(cod_servsupl,'00')),LTRIM(TO_CHAR(cod_nivel,'0000'))) servicioSS
        FROM ga_servsuplabo
        WHERE num_abonado=nNumAbonado
        AND ind_estado<3;
        --FIN/CO-200608160327: German Espinoza Z; 17/08/2006

BEGIN

    nNumError:=0;                    --Operacion Exitosa
    sMsgError:='Operacisn Exitosa';
    dFechaEjecucion:=SYSDATE;
    sCodActabo:=vCOD_ACTABO;
    vNumAbonado:=nNUM_ABONADO;
    VP_ERROR:='0';
    VP_PROC:='PV_PR_BAJAAMISTAR';
    sCodModulo := 'GA';



    --Datos Generales

    BEGIN

        nNumError:=1;
        sMsgError:='Error Obteniendo Datos de Parametros';
        VP_TABLA:='GA_DATOSGENER';
        VP_ACT:='S';

                -- Inicio Modificación TM-20040714837---------------
                SELECT cod_ami_planserv,cod_ami_ciclo,cod_ami_tipcontra
                INTO
                        vCodAmiPlanServ,vCodAmiCiclo,vCodAmiTipContra
                FROM GA_DATOSGENER;

                nNumError:=2;
            sMsgError:='Error, al Obtener Codigo Central de GED_PARAMETROS';
        VP_TABLA:='GED_PARAMETROS';
        VP_ACT:='S';

                scodtec := GE_FN_DEVVALPARAM('GA',1,'GRUPO_TEC_GSM');

        SELECT VAL_PARAMETRO
        INTO vCodAmiCauBaja
        FROM GED_PARAMETROS
        WHERE NOM_PARAMETRO = 'COD_OPTAAMISTAR';

        IF vCodAmiCauBaja <> vCOD_CAUSA THEN
           NULL;
           RAISE ERROR_PROCESO;
        END IF;

            nNumError:=3; --TM-20040714837
        sMsgError:='Error, al Obtener Datos de la Abocel';
        VP_TABLA:='GA_ABOAMIST';
        VP_ACT:='S';

        SELECT COD_PRODUCTO,COD_CLIENTE,NUM_CELULAR,COD_PLANTARIF,COD_CARGOBASICO,TIP_PLANTARIF,COD_CICLO,
               COD_TIPCONTRATO,COD_EMPRESA,COD_CICLO,NUM_MIN,NUM_SERIE,NUM_SERIEHEX,TIP_TERMINAL,
               COD_CUENTA, COD_VENDEDOR_AGENTE, COD_TECNOLOGIA, NUM_IMEI, COD_USO,COD_CENTRAL,COD_VENDEDOR,COD_USUARIO,COD_SUBCUENTA
          INTO nCodProducto,nCodCliente,nNumCelular,vCodPlantarif,vCodCargoBasico,vTipPlantarif,vCodCiclo,
               vCodTipContrato,nCodEmpresa,vCodCiclo,nNumMin,sNumSerie,sNumSerieHex,sTipTerminal,
               nCodCuenta,nCodVendedorAgente, sCodTecnologia, sNumImei, sCodUso, nCodCentral,vCOD_VENDEDOR,VCOD_USUARIO,VCOD_SUBCUENTA
        FROM GA_ABOCEL
        WHERE NUM_ABONADO =nNUM_ABONADO;


                BEGIN

                SELECT NVL(A.COD_empresa,0)
        INTO nNuevoAbonado
        FROM PV_PARAM_CLIENTE A
        WHERE A.NUM_OS = nNUM_OOSS;

                EXCEPTION
                        WHEN NO_DATA_FOUND THEN
                        nCodPlantarif:='';
                        nNuevoAbonado:=0;
        END;



                --TMM-04026 INI
                IF GA_APROVISIONAR_CENTRAL_PG.PV_GRUPO_TECNOLOGICO_FN(sCodTecnologia) = sCodTec then
                --TMM-04026 FIN
                   nNumError:=4; --TM-20040714837
           sMsgError:='Error, al Obtener Datos de la GA_DATOSGENER';
           VP_TABLA:='GA_DATOSGENER';
           VP_ACT:='S';
           BEGIN
                SELECT nvl(A.COD_PLANTARIF_NUE,'')
                       INTO nCodPlantarif
                       FROM PV_PARAM_ABOCEL A
                       WHERE A.NUM_OS = nNUM_OOSS;
                EXCEPTION
                        WHEN NO_DATA_FOUND THEN
                        nCodPlantarif:='';
                        nNuevoAbonado:=0;
           END;
           if  (trim(nCodPlantarif) = '' or nCodPlantarif is null) then
            sMsgError:='Error, al Obtener Datos de la datosgener';
           VP_TABLA:='datosgener';
           VP_ACT:='S';
                SELECT cod_ami_plantarif, cod_ami_cargobasico
                INTO nCodPlantarif, vCodAmiCargoBasico
                FROM GA_DATOSGENER;
           end if;

           SELECT COD_PLAN_COMVERSE
                          INTO Vcod_plan_comverse
                   FROM TA_PLANTARIF
                   WHERE COD_PLANTARIF = nCodPlantarif;



                ELSE
                    --TM-200501131209: German Espinoza Z; 14/01/2005

                        nNumError :=35; --TM-20040714837
            sMsgError :='Error, al Obtener Nombre Central de ICG_CENTRAL';
            VP_TABLA  :='icg_central';
            VP_ACT    :='S';

                        SELECT SUBSTR(nom_central,2,INSTR(nom_central,'_')-2)
                        INTO sCod_ZonaCentral
                        FROM icg_central
                        WHERE cod_tecnologia = sCodTecnologia
                        AND   cod_central    = nCodCentral;

                        nNumError:=36; --TM-20040714837
            sMsgError:='Error, al Obtener Datos CDMA_ZONA1900 de la GED_PARAMETROS';
            VP_TABLA:='GED_PARAMETROS';
            VP_ACT:='S';

                        SELECT VAL_PARAMETRO
            INTO sCdma_Zona1900
            FROM GED_PARAMETROS
            WHERE NOM_PARAMETRO = 'CDMA_ZONA1900';

                        nNumError:=37; --TM-20040714837
            sMsgError:='Error, al Obtener Datos CDMA_ZONA1900 de la GED_PARAMETROS';
            VP_TABLA:='GED_PARAMETROS';
            VP_ACT:='S';

                        SELECT VAL_PARAMETRO
            INTO sCdma_Zona850
            FROM GED_PARAMETROS
            WHERE NOM_PARAMETRO = 'CDMA_ZONA850';

                        IF sCod_ZonaCentral=sCdma_Zona850 THEN

                            nNumError:=38; --TM-20040714837
                    sMsgError:='Error, al Obtener Datos PLAN_CDMA850 de la GED_PARAMETROS';
                    VP_TABLA:='GED_PARAMETROS';
                    VP_ACT:='S';

        BEGIN
                SELECT nvl(A.COD_PLANTARIF_NUE,'')
                INTO nCodPlantarif
                FROM PV_PARAM_ABOCEL A
                WHERE A.NUM_OS = nNUM_OOSS;
        EXCEPTION
                WHEN NO_DATA_FOUND THEN
                nCodPlantarif:='';
                nNuevoAbonado:=0;
        END;

        IF  (trim(nCodPlantarif) = '' or nCodPlantarif is null) THEN
                SELECT VAL_PARAMETRO
                INTO nCodPlantarif
                FROM GED_PARAMETROS
                WHERE NOM_PARAMETRO = 'PLAN_CDMA850';
        END IF;

        ELSIF sCod_ZonaCentral=sCdma_Zona1900 THEN

                                nNumError:=39; --TM-20040714837
                    sMsgError:='Error, al Obtener Datos PLAN_CDMA1900 de la GED_PARAMETROS';
                    VP_TABLA:='GED_PARAMETROS';
                    VP_ACT:='S';


        BEGIN
                SELECT nvl(A.COD_PLANTARIF_NUE,'')
                INTO nCodPlantarif
                FROM PV_PARAM_ABOCEL A
                WHERE A.NUM_OS = nNUM_OOSS;
        EXCEPTION
                WHEN NO_DATA_FOUND THEN
                nCodPlantarif:='';
                nNuevoAbonado:=0;
        END;

        IF  (trim(nCodPlantarif) = '' or nCodPlantarif is null) THEN
            SELECT VAL_PARAMETRO
            INTO nCodPlantarif
            FROM GED_PARAMETROS
            WHERE NOM_PARAMETRO = 'PLAN_CDMA1900';
        END IF;

        ELSE

                    nNumError:=40; --TM-20040714837

                nNumError:=4; --TM-20040714837
                sMsgError:='Error, al Obtener Codigo Central de GED_PARAMETROS';
                VP_TABLA:='GED_PARAMETROS';
                VP_ACT:='S';

                                -- Obtener código de plantarifario amistar
                        BEGIN
                                SELECT nvl(A.COD_PLANTARIF_NUE,'')
                                INTO nCodPlantarif
                                FROM PV_PARAM_ABOCEL A
                                WHERE A.NUM_OS = nNUM_OOSS;
                        EXCEPTION
                                WHEN NO_DATA_FOUND THEN
                                nCodPlantarif:='';
                                nNuevoAbonado:=0;
                        END;
                        IF  (trim(nCodPlantarif) = '' or nCodPlantarif is null) THEN
                         sMsgError:='Error, al Obtener Datos de la  GED_PARAMETROS';
           VP_TABLA:='ged_parametros';
           VP_ACT:='S';
                                SELECT VAL_PARAMETRO
                                INTO nCodPlantarif
                                FROM GED_PARAMETROS
                                WHERE NOM_PARAMETRO = 'COD_AMI_PLANTARIF'
                                      AND COD_MODULO = 'GA'
                                      AND COD_PRODUCTO = 1;


                        END IF;
        --                      nNumError:=4;  --TM-20040714837
                                nNumError:=5; --TM-20040714837
                    sMsgError:='Error, al Obtener Cargo básico TA_PLANTARIF';
                    VP_TABLA:='TA_PLANTARIF';
                    VP_ACT:='S';

                        SELECT COD_CARGOBASICO, COD_PLAN_COMVERSE
                                --Inicio Modificacion - ACB - 27/09/2004 - TM200409220951
                                --INTO cod_ami_cargobasico, Vcod_plan_comverse
                                INTO vCodAmiCargoBasico, Vcod_plan_comverse
                                --Fin Modificacion - ACB - 27/09/2004 - TM200409220951
                                FROM TA_PLANTARIF
                                WHERE COD_PLANTARIF = nCodPlantarif;
                        END IF;


                        -- Fin modificacion - TM-200407140837
            END IF;







        --Verifica Cliente Amistar
        nNumError:=6; -- TM-200407140837
        sMsgError:='Error, al Obtener Codigo Cliente';
        VP_TABLA:='GE_CLIENTES';
        VP_ACT:='S';
/*
        OPEN CUR_CLIENTE(nCodCuenta, vCodAmiCiclo);
             LOOP
                FETCH CUR_CLIENTE INTO nCodClienteAux;
                EXIT WHEN CUR_CLIENTE%NOTFOUND;
             END LOOP;
        CLOSE CUR_CLIENTE;
*/
        BEGIN
                SELECT A.COD_CLIENTE_NUE, A.COD_ACTIVIDAD
                INTO nCodClienteAux, NCOD_ACTIVIDAD_AUX
                FROM PV_PARAM_CLIENTE A
                WHERE A.NUM_OS = nNUM_OOSS;
        EXCEPTION
                WHEN NO_DATA_FOUND THEN
                nCodClienteAux:=NULL;
        END;


        --RA-200602200811: German Espinoza Z; 24/02/2006
        /*nNumError:=7;   -- TM-200407140837
        sMsgError:='Error, al Obtener Nuevo Cliente';
        VP_TABLA:='DUAL';
        VP_ACT:='S';*/
                --RA-200602200811: German Espinoza Z; 24/02/2006

        IF nCodClienteAux IS NULL  THEN

                   --RA-200602200811: German Espinoza Z; 24/02/2006
           nNumError:=7;   -- TM-200407140837
           sMsgError:='Error, al Obtener Nuevo Cliente';
           VP_TABLA:='DUAL';
           VP_ACT:='S';
                   --RA-200602200811: German Espinoza Z; 24/02/2006

           /*Select ge_seq_clientes.nextval
           Into nNuevoCliente
           From dual;*/

                   nNuevoCliente := GE_SEQ_CLIENTES_FN(0);

                   --INI COL-38130/07-03-2007/PCR
                   nNumError:=4;
           sMsgError:='Error, al Obtener Categoria para Prepago de GED_PARAMETROS';
           VP_TABLA:='GED_PARAMETROS';
           VP_ACT:='S';

                   SELECT val_parametro
                   INTO vCodCategoria
                   FROM ged_parametros
                   WHERE nom_parametro = 'COD_CATEMP_DEFAULT';

                   --FIN COL-38130/07-03-2007/PCR

                   -- INI COL-41254|08-06-2007|EFR.
                   -- busco indicador de alta para prepagos.-
                   SELECT VAL_PARAMETRO
                   INTO  vInd_Alta_pp
                   FROM  GED_PARAMETROS
                   WHERE NOM_PARAMETRO = 'IND_ALTA'
                   AND   COD_MODULO = 'GA'
                   AND   COD_PRODUCTO = 1;
                   -- FIN COL-41254|08-06-2007|EFR.

                   nNumError:=8;-- TM-200407140837
           sMsgError:='Error, al Insertar Nuevo Cliente';
           VP_TABLA:='GE_CLIENTES';
           VP_ACT:='I';

           INSERT INTO GE_CLIENTES (COD_CLIENTE, NOM_CLIENTE, COD_TIPIDENT,
                   NUM_IDENT, COD_CALCLIEN, IND_SITUACION, FEC_ALTA, IND_FACTUR,
                   IND_TRASPASO, IND_AGENTE, FEC_ULTMOD, NUM_FAX, IND_MANDATO,
                   NOM_USUARORA, IND_ALTA, COD_CUENTA, IND_ACEPVENT, COD_ABC,
                   COD_123, COD_ACTIVIDAD, COD_PAIS, TEF_CLIENTE1, NUM_ABOCEL,
                   TEF_CLIENTE2, NUM_ABOBEEP, IND_DEBITO, NUM_ABOTRUNK,
                   COD_PROSPECTO, NUM_ABOTREK, COD_SISPAGO, NOM_APECLIEN1,
                   NOM_EMAIL, NUM_ABORENT, NOM_APECLIEN2, NUM_ABOROAMING,
                   FEC_ACEPVENT, IMP_STOPDEBIT, COD_BANCO, COD_SUCURSAL,
                   IND_TIPCUENTA, COD_TIPTARJETA, NUM_CTACORR, NUM_TARJETA,
                   FEC_VENCITARJ, COD_BANCOTARJ, COD_TIPIDTRIB, NUM_IDENTTRIB,
                   COD_TIPIDENTAPOR, NUM_IDENTAPOR, NOM_APODERADO, COD_OFICINA,
                   FEC_BAJA, COD_COBRADOR, COD_PINCLI, COD_CICLO,
                   IND_TIPPERSONA, COD_CICLONUE, COD_OPERADORA, COD_CATEGORIA) --COL-38130/07-03-2007/PCR se agrega categoria
           SELECT  nNuevoCliente , NOM_CLIENTE, COD_TIPIDENT,
                   NUM_IDENT, COD_CALCLIEN, IND_SITUACION, SYSDATE, IND_FACTUR,
                   IND_TRASPASO, IND_AGENTE, FEC_ULTMOD, NUM_FAX, IND_MANDATO,
           --vNOM_USUARORA, IND_ALTA, COD_CUENTA, IND_ACEPVENT, COD_ABC, -- COL-41254|08-06-2007|EFR.
                   vNOM_USUARORA, vInd_Alta_pp, COD_CUENTA, IND_ACEPVENT, COD_ABC, -- COL-41254|08-06-2007|EFR.
                   COD_123, COD_ACTIVIDAD, COD_PAIS, TEF_CLIENTE1, 0,
                   TEF_CLIENTE2,  0 , IND_DEBITO, 0 ,
                   COD_PROSPECTO, 0 , COD_SISPAGO, NOM_APECLIEN1,
                   NOM_EMAIL, 0 , NOM_APECLIEN2, 0 ,
                   FEC_ACEPVENT, IMP_STOPDEBIT, COD_BANCO, COD_SUCURSAL,
                   IND_TIPCUENTA, COD_TIPTARJETA, NUM_CTACORR, NUM_TARJETA,
                   FEC_VENCITARJ, COD_BANCOTARJ, COD_TIPIDTRIB, NUM_IDENTTRIB,
                   COD_TIPIDENTAPOR, NUM_IDENTAPOR, NOM_APODERADO, COD_OFICINA,
                   FEC_BAJA, COD_COBRADOR, COD_PINCLI, vCodAmiCiclo ,
                   IND_TIPPERSONA, COD_CICLONUE, COD_OPERADORA, vCodCategoria --COL-38130/07-03-2007/PCR
           FROM GE_CLIENTES
           WHERE COD_CLIENTE = nCodCliente;

           -- Ingreso de Categoria Tributaria
           nNumError:=9;-- TM-200407140837
           sMsgError:='Error, al Insertar Categorma Tributaria';
           VP_TABLA:='GA_CATRIBUTCLIE';
           VP_ACT:='I';

           INSERT INTO GA_CATRIBUTCLIE (COD_CLIENTE,FEC_DESDE,FEC_HASTA,COD_CATRIBUT)
           SELECT  nNuevoCliente , SYSDATE ,FEC_HASTA,COD_CATRIBUT
           FROM GA_CATRIBUTCLIE
                   WHERE COD_CLIENTE =  nCodCliente
                   AND sysdate BETWEEN fec_desde AND fec_hasta;

                        -- Inicio Modificacion -- TM-20040714083 - 20/07/2004
                    nNumError:=10; -- TM-200407140837
                    sMsgError:='Error, al Insertar Categoria Impositiva';
                    VP_TABLA:='GE_CATIMPCLIENTES';
                    VP_ACT:='I';

                INSERT INTO GE_CATIMPCLIENTES (COD_CLIENTE,FEC_DESDE,FEC_HASTA,COD_CATIMPOS)
                    SELECT  nNuevoCliente , SYSDATE ,FEC_HASTA,'1'
                    FROM GE_CATIMPCLIENTES
                    WHERE COD_CLIENTE =  nCodCliente
                    AND sysdate BETWEEN fec_desde AND fec_hasta;
                        -- Fin Modificacion -- TM-20040714083 - 20/07/2004

            -- Ingreso de Direccion
            nNumError:=11;-- TM-200407140837
            sMsgError:='Error, al Insertar Direccion del Cliente';
            VP_TABLA:='GA_DIRECCLI';
            VP_ACT:='I';

            INSERT INTO GA_DIRECCLI (COD_CLIENTE, COD_TIPDIRECCION, COD_DIRECCION)
                SELECT nNuevoCliente, COD_TIPDIRECCION, COD_DIRECCION
            FROM GA_DIRECCLI
            WHERE COD_CLIENTE = nCodCliente;

            -- Planes Comerciales de Clientes
            nNumError:=12; -- TM-200407140837
            sMsgError:='Error, al Insertar Planes Comerciales de Clientes';
            VP_TABLA:='GA_CLIENTE_PCOM';
            VP_ACT:='I';

            INSERT INTO GA_CLIENTE_PCOM (COD_CLIENTE, COD_PLANCOM,
                   FEC_DESDE, NOM_USUARORA, FEC_HASTA)
            SELECT nNuevoCliente , COD_PLANCOM, FEC_DESDE,
                vNOM_USUARORA, FEC_HASTA
            FROM GA_CLIENTE_PCOM
            WHERE COD_CLIENTE = nCodCliente;

        ELSE
            --CB-INI INCIDENCIA RA-200512130311 14122005
            --nNuevoCliente := nCodCliente;
            nNuevoCliente :=nCodClienteAux;
            --OCB-FIN INCIDENCIA RA-200512130311 14122005
        END IF;

        -- Obtener Numero de Abonado Nuevo
        nNumError:=13;-- TM-200407140837
        sMsgError:='Error, al Obtener Numero de Abonado Nuevo';
        VP_TABLA:='GA_CLIENTE_PCOM';
        VP_ACT:='S';

                IF nNuevoAbonado= 0 THEN
                SELECT GA_SEQ_NUMABO.NEXTVAL
                INTO nNuevoAbonado
                FROM DUAL;
                END IF;
        -- Obtener Csdigo VEndedor Agente
        nNumError:=14;  -- TM-200407140837
        sMsgError:='Error, al Obtener Código Vendedor Agente';
        VP_TABLA:='GA_PERCONTRATO';
        VP_ACT:='S';

        SELECT A.COD_CLIENTE, B.COD_CUENTA
        INTO  nCodClienteDist, nCodCuentaDist
        FROM VE_VENDEDORES A, GE_CLIENTES B
        WHERE A.COD_VENDEDOR = nCodVendedorAgente
        AND A.COD_CLIENTE = B.COD_CLIENTE;

                --      inicio  Fecha Alta -------------------------------------------------------
        -- Obtener Parametro Fecha de alta entre pospago y prepago.
        nNumError:=46;
        sMsgError:='Error, al Obtener Valor Fec. Alta, GED_PARAMETROS';
        VP_TABLA:='GED_PARAMETROS';
        VP_ACT:='S';

        SELECT VAL_PARAMETRO
        INTO   sCodFecAlta
        FROM   GED_PARAMETROS
        WHERE  NOM_PARAMETRO = 'FEC_ALTA_MIGRACION'
        AND    COD_MODULO = 'GE'
                AND    COD_PRODUCTO = 1;

                --      fin     Fecha Alta -------------------------------------------------------

        -- Obtener Codigo de uso de datos generales
        nNumError:=15; -- TM-200407140837
        sMsgError:='Error, al Obtener Cod.Uso Prepago, GED_PARAMETROS';
        VP_TABLA:='GED_PARAMETROS';
        VP_ACT:='S';

        SELECT VAL_PARAMETRO
        INTO nCodUso
        FROM GED_PARAMETROS
        WHERE NOM_PARAMETRO = 'USO_PREPAGO'
        AND COD_MODULO = 'GA';

                --CO-200608160327: German Espinoza Z; 17/08/2006
                nNumError:=16;
        sMsgError:='Error, al Obtener Servicios Suplem. por defecto al comando';
        VP_TABLA:='ICG_ACTUACIONTERCEN';
        VP_ACT:='S';

                SELECT cod_servicios
                INTO   LV_CodServTercen
                FROM   icg_actuaciontercen
                WHERE  cod_actuacion=(SELECT cod_actcen
                                                      FROM   ga_actabo
                                                      WHERE  cod_actabo='AM'
                                                      AND    cod_modulo='GA'
                                                  AND    cod_tecnologia=sCodTecnologia)
                AND    tip_tecnologia=sCodTecnologia
                AND    cod_producto=nCodProducto
                AND    tip_terminal=sTipTerminal;

                --FIN/CO-200608160327: German Espinoza Z; 17/08/2006

                -- Obtener Codigo Central de Parametros
        nNumError:=16;-- TM-200407140837
        sMsgError:='Error, al Obtener Código Central de GED_PARAMETROS';
        VP_TABLA:='GED_PARAMETROS';
        VP_ACT:='S';

        sAuxCodServ := NULL;

                --CO-200608160327: German Espinoza Z; 17/08/2006
        --OPEN CUR_SERVICIO_AMI(nCodUso);
                OPEN CUR_SERVICIO_AMI(nCodUso,LV_CodServTercen);
                --FIN/CO-200608160327: German Espinoza Z; 17/08/2006

             LOOP
                 FETCH CUR_SERVICIO_AMI INTO sAuxCodServ;--PAGC-OCB 30-12-2004
                 EXIT WHEN CUR_SERVICIO_AMI%NOTFOUND;

                                 sCadServiciosAmiAdic := sCadServiciosAmiAdic || sAuxCodServ;--PAGC-OCB 30-12-2004

                 END LOOP;
        CLOSE CUR_SERVICIO_AMI;

        -- Insertar Abonado Amistar en GA_ABOAMIST

                --RA-200602200811: German Espinoza Z; 24/02/2006
        /*nNumError:=17; -- TM-200407140837
        sMsgError:='Error, al Insertar Abonado Amistar';
        VP_TABLA:='GA_ABOAMIST';
        VP_ACT:='I';*/
                --FIN/RA-200602200811: German Espinoza Z; 24/02/2006

            -- Inicio Modificación - GBM - TM-200408180902 - 20-08-2004
            IF vNUM_CELULAR <> nNumCelular THEN
                vNumMinMdn:= GE_FN_MIN_DE_MDN (vNUM_CELULAR);
            ELSE
                vNumMinMdn := '';
            END IF;
            -- Fin Modificación - GBM - TM-200408180902 - 20-08-2004

            --INI-PAGC-TMM_04010
            BEGIN

                   --RA-200602200811: German Espinoza Z; 24/02/2006
           nNumError:=50;
           sMsgError:='Error, al Seleccionar Vendedor';
           VP_TABLA:='GE_SEG_USUARIO';
           VP_ACT:='S';
                   --FIN/RA-200602200811: German Espinoza Z; 24/02/2006

                   Select Nvl(Cod_vendedor,vCOD_VENDEDOR)
                   Into vCod_vendedor_nuevo
                   From Ge_seg_usuario
                   Where Nom_usuario=vNOM_USUARORA;
            EXCEPTION
                        WHEN OTHERS THEN
                                vCod_vendedor_nuevo:=vCOD_VENDEDOR;
            END;
                --FIN-PAGC-TMM_04010


              --Inicio Inc. 72966|COL|19/11/22008|jjr.-
                  nNumError:=55; --TM-20040714837
              sMsgError:='Error, al Obtener Cargo básico TA_PLANTARIF';
              VP_TABLA:='TA_PLANTARIF';
              VP_ACT:='S';

                  SELECT COD_CARGOBASICO, COD_PLAN_COMVERSE,COD_PRESTACION
                  INTO vCodAmiCargoBasico, Vcod_plan_comverse,LV_COD_PRESTACION
                  FROM TA_PLANTARIF
                  WHERE COD_PLANTARIF = nCodPlantarif;
              --Fin Inc. 72966|COL|19/11/22008|jjr.-

                BEGIN

                    --RA-200602200811: German Espinoza Z; 24/02/2006
            nNumError:=17; -- TM-200407140837
            sMsgError:='Error, al Insertar Abonado Amistar';
            VP_TABLA:='GA_ABOAMIST';
            VP_ACT:='I';
                    --FIN/RA-200602200811: German Espinoza Z; 24/02/2006

            INSERT INTO GA_ABOAMIST
                (NUM_ABONADO    , NUM_CELULAR        , COD_PRODUCTO   , COD_CLIENTE   ,
            COD_CLIENTE_DIST, COD_CUENTA         , COD_CUENTA_DIST, COD_CENTRAL   ,
                        COD_USO         , COD_SITUACION      , IND_PROCALTA   , IND_PROCEQUI  ,
            COD_VENDEDOR    , COD_VENDEDOR_AGENTE, TIP_TERMINAL   , COD_PLANSERV  ,
                        NUM_SERIE       , NUM_SERIEHEX       , NOM_USUARORA   , FEC_ALTA      ,
            NUM_SERIEMEC    , NUM_VENTA          , COD_MODVENTA   , IND_SUSPEN    ,
                        IND_REHABI      , FEC_ACEPVENTA      , FEC_ACTCEN     , FEC_BAJA      ,
                        FEC_BAJACEN     , FEC_ULTMOD         , COD_CAUSABAJA  , CLASE_SERVICIO,
                        PERFIL_ABONADO  , COD_VENDEALER      , IND_DISP       , COD_PASSWORD  ,
                        IND_PASSWORD    , COD_CARGOBASICO    , COD_PLANTARIF  , TIP_PLANTARIF ,
            COD_USUARIO     , COD_TECNOLOGIA     , NUM_IMEI       , NUM_MIN_MDN   ,  --TM-2004071408937
            --TMM-04026 INI
            COD_OFICINA_PRINCIPAL,
            --TMM-04026 FIN
                        --OCB-INI-TMM-04010 POR TEMA DE ZONA IMPOSITIVA (bENEFICIOS Y PROMOCIONES)
                        COD_CIUDAD,COD_REGION,COD_PROVINCIA,COD_PRESTACION
                        --OCB-FIN-TMM-04010
            )
            SELECT nNuevoAbonado       , vNUM_CELULAR       , COD_PRODUCTO    , nNuevoCliente       ,
                   nCodClienteDist     , COD_CUENTA             , nCodCuentaDist  , nCodCentral         ,
                                   nCodUso                     , 'TAP'                          , IND_PROCALTA    , IND_PROCEQUI        ,
                                   --Ini. TMM-04010-PAGC
                   --COD_VENDEDOR        , COD_VENDEDOR_AGENTE, TIP_TERMINAL    , vCodAmiPlanServ     ,
                                   vCod_vendedor_nuevo , COD_VENDEDOR_AGENTE, TIP_TERMINAL    , vCodAmiPlanServ     ,
                                   --Fin. TMM-04010-PAGC
                                   NUM_SERIE           , NUM_SERIEHEX           , vNOM_USUARORA   , DECODE(sCodFecAlta, 'S',FEC_ALTA, SYSDATE)   ,
                   NUM_SERIEMEC            , NUM_VENTA                  , COD_MODVENTA    , IND_SUSPEN              ,
                                   IND_REHABI          , SYSDATE                        , FEC_ACTCEN      , NULL                            ,
                                   --CO-200608160327: German Espinoza Z; 17/08/2006
                                   --NULL                              , SYSDATE                        , NULL                    , sCadServiciosAmiAdic,
                                   --sCadServiciosAmiAdic, COD_VENDEALER      , IND_DISP        , COD_PASSWORD        ,
                                   NULL                        , SYSDATE                        , NULL                    , LV_CodServTercen,
                                   LV_CodServTercen, COD_VENDEALER      , IND_DISP        , COD_PASSWORD        ,
                                   --FIN/CO-200608160327: German Espinoza Z; 17/08/2006
                                   IND_PASSWORD        , vCodAmiCargoBasico , nCodPlantarif   ,'I'                  ,
                                   COD_USUARIO         , COD_TECNOLOGIA     ,NUM_IMEI         , DECODE(vNumMinMdn, '',NUM_MIN_MDN, vNumMinMdn),
                                   --COD_TECNOLOGIA,NUM_IMEI  --TM-2004071408937
                           --TMM-04026 INI
                           COD_OFICINA_PRINCIPAL,
                           --TMM-04026 FIN
                                   --OCB-INI-TMM-04010 POR TEMA DE ZONA IMPOSITIVA (bENEFICIOS Y PROMOCIONES)
                                   COD_CIUDAD,COD_REGION,COD_PROVINCIA,LV_COD_PRESTACION
                                   --OCB-FIN-TMM-04010
                FROM GA_ABOCEL
                WHERE NUM_ABONADO = nNUM_ABONADO;
                EXCEPTION
                        WHEN OTHERS THEN
                                 nCOD_RETORNO:=2;
                                 vDES_CADENA:=SQLERRM;
                                 raise ERROR_PROCESO_PUNTUAL;
                END;

           --INI P-COL-06052 refactory validaciones de número frecuente IGO 2008-01-29
--         IF NCOD_ACTIVIDAD_AUX IS NOT NULL THEN
--
--                      BEGIN
--                 nNumError:=46;
--                 sMsgError:='Error, al Insertar tabla de excepcion.';
--                 VP_TABLA:='ve_excepcion_vta_prepago_to';
--                 VP_ACT:='I';
--
--
--                              INSERT INTO ve_excepcion_vta_prepago_to
--                           (cod_excepcion_vta, num_venta, cod_cliente, num_abonado,cod_causa, fecha_venta,nom_usuario,cod_plantarif)
--                              VALUES
--                              (ve_venta_excepcionada_sq.NEXTVAL, 0, nCodClienteAux, nNuevoAbonado, NCOD_ACTIVIDAD_AUX, SYSDATE, USER           ,
--                            nCodPlantarif);
--
--                      EXCEPTION
--                              WHEN OTHERS THEN
--                                       nCOD_RETORNO:=2;
--                                       vDES_CADENA:=SQLERRM;
--                                       raise ERROR_PROCESO_PUNTUAL;
--                      END;
--
--              END IF;

           --FIN P-COL-06052 refactory validaciones de número frecuente IGO 2008-01-29


       -- Obtener Nombre Apellido
       nNumError:=18; -- TM-200407140837
       sMsgError:='Error, al Obtener Nombre Apellido';
       VP_TABLA:='GE_CLIENTES';
       VP_ACT:='S';

       SELECT NOM_APECLIEN1
       INTO vNomApeClien1
       FROM GE_CLIENTES
       WHERE COD_CLIENTE = nCodCliente;

       -- Obtener Nombre Apellido
       nNumError:=19; -- TM-200407140837
       sMsgError:='Error, al Obtener Código Usuario';
       VP_TABLA:='DUAL';
       VP_ACT:='S';

       SELECT GA_SEQ_USUARIOS.NEXTVAL
       INTO nCodUsuario
       FROM DUAL;

       -- Obtener al Insertar Usuario

           --RA-200602200811: German Espinoza Z; 24/02/2006
       /*nNumError:=20; -- TM-200407140837
       sMsgError:='Error, al Insertar Usuario Amistar';
       VP_TABLA:='GA_USUAMIST';
       VP_ACT:='I';*/

           nNumError:=51;
       sMsgError:='Error, al Seleccionar Nombre de Cliente';
       VP_TABLA:='GE_CLIENTES';
       VP_ACT:='S';
           --FIN/RA-200602200811: German Espinoza Z; 24/02/2006

       SELECT SUBSTR(NOM_CLIENTE,1,20)
       INTO sSubNomCliente
       FROM GE_CLIENTES
       WHERE COD_CLIENTE =  nNuevoCliente;

           --RA-200602200811: German Espinoza Z; 24/02/2006
       nNumError:=20;
       sMsgError:='Error, al Insertar Usuario Amistar';
       VP_TABLA:='GA_USUAMIST';
       VP_ACT:='I';
           --FIN/RA-200602200811: German Espinoza Z; 24/02/2006

       INSERT INTO GA_USUAMIST
       (COD_USUARIO, NUM_ABONADO, NOM_USUARIO, NOM_APELLIDO1, FEC_ALTA,
        COD_TIPIDENT, NUM_IDENT, IND_ESTADO, NOM_APELLIDO2, FEC_NACIMIEN,
        COD_ESTCIVIL, IND_SEXO)
       SELECT nCodUsuario, nNuevoAbonado, sSubNomCliente, vNomApeClien1,
              SYSDATE, COD_TIPIDENT, NUM_IDENT, 'C', NOM_APECLIEN2, FEC_NACIMIEN, IND_ESTCIVIL, IND_SEXO
       FROM   GE_CLIENTES
       WHERE  COD_CLIENTE =  nNuevoCliente;

       -- Actuactizar Csdigo Usuario en Tabla
       nNumError:=21; -- TM-200407140837
       sMsgError:='Error, al Actualizar Código Usuario en Tabla';
       VP_TABLA:='GA_ABOAMIST';
       VP_ACT:='U';

       UPDATE GA_ABOAMIST
           SET COD_USUARIO= nCodUsuario
           WHERE NUM_ABONADO = nNuevoAbonado;

       -- Insertar Servicio Suplementario
       nNumError:=22; -- TM-200407140837

       sMsgError:='Error, al Insertar Servicio Suplementario (migrados)';
       VP_TABLA:='GA_SERVSUPLABO';
       VP_ACT:='I';

       INSERT INTO GA_SERVSUPLABO
                           (NUM_ABONADO, COD_SERVICIO, FEC_ALTABD  , COD_SERVSUPL,
                    COD_NIVEL  , COD_PRODUCTO, NUM_TERMINAL, NOM_USUARORA,
                        IND_ESTADO , FEC_ALTACEN , FEC_BAJABD  , FEC_BAJACEN ,
                                        COD_CONCEPTO)
       SELECT nNuevoAbonado, a.COD_SERVICIO, SYSDATE, a.COD_SERVSUPL,
                                        a.COD_NIVEL, a.COD_PRODUCTO, vNUM_CELULAR,vNOM_USUARORA,
                                        a.IND_ESTADO, SYSDATE, NULL, NULL, a.COD_CONCEPTO
           FROM GA_SERVSUPLABO A, GA_ABOCEL B, GA_SERVUSO C
           WHERE A.NUM_ABONADO = nNUM_ABONADO
           AND SYSDATE BETWEEN A.FEC_ALTABD AND NVL(A.FEC_BAJABD,SYSDATE)
           AND A.NUM_ABONADO = B.NUM_ABONADO
           AND C.COD_USO = nCodUso
                                --AND A.COD_PRODUCTO = B.COD_PRODUCTO            --COL-39306|05-04-2007|GEZ
           AND NVL(A.COD_PRODUCTO,1) = B.COD_PRODUCTO   --COL-39306|05-04-2007|GEZ
           AND A.COD_PRODUCTO = C.COD_PRODUCTO
           AND A.COD_SERVICIO = C.COD_SERVICIO
           AND A.COD_SERVICIO IN (SELECT COD_SERVICIO
                                                  FROM GAD_SERVSUP_PLAN
                                                          WHERE COD_PLANTARIF = nCodPlantarif
                                                          AND TIP_RELACION <> '3'
                                                          AND cod_producto=1                    --COL-39306|05-04-2007|GEZ
                                                          AND cod_servicio is not null  --COL-39306|05-04-2007|GEZ
                                                          AND SYSDATE BETWEEN FEC_DESDE AND NVL(FEC_HASTA, SYSDATE));

       nNumError:=23; -- TM-200407140837
       sMsgError:='Error, al Insertar Servicio Suplementario (por defecto)';
       VP_TABLA:='GA_SERVSUPLABO';
       VP_ACT:='I';

       INSERT INTO GA_SERVSUPLABO
       (NUM_ABONADO, COD_SERVICIO, FEC_ALTABD, COD_SERVSUPL,
       COD_NIVEL, COD_PRODUCTO, NUM_TERMINAL, NOM_USUARORA,
       IND_ESTADO, FEC_ALTACEN, FEC_BAJABD, FEC_BAJACEN, COD_CONCEPTO)
       SELECT nNuevoAbonado, a.COD_SERVICIO, SYSDATE, a.COD_SERVSUPL,
                        a.COD_NIVEL, a.COD_PRODUCTO, vNUM_CELULAR,vNOM_USUARORA,
                        1, SYSDATE, NULL, NULL, B.COD_CONCEPTO
                FROM GA_SERVSUPL A, GA_ACTUASERV B, GA_SERVUSO C
                WHERE A.COD_PRODUCTO = nCodProducto
                AND A.COD_PRODUCTO = B.COD_PRODUCTO
                AND A.COD_PRODUCTO = C.COD_PRODUCTO
                AND B.COD_ACTABO = 'SS'
                AND B.COD_TIPSERV = 2
                AND C.COD_USO = nCodUso
                AND A.COD_SERVICIO = B.COD_SERVICIO
                AND A.COD_SERVICIO = C.COD_SERVICIO
                AND A.COD_SERVICIO IN (SELECT COD_SERVICIO
                                                           FROM GAD_SERVSUP_PLAN
                                                           WHERE COD_PLANTARIF = nCodPlantarif
                                                           AND TIP_RELACION = '3'
                                                           AND cod_producto=1                   --COL-39306|05-04-2007|GEZ
                                                           AND cod_servicio is not null --COL-39306|05-04-2007|GEZ
                                                           AND SYSDATE BETWEEN FEC_DESDE AND NVL(FEC_HASTA, SYSDATE));

                --RA-200602200811: German Espinoza Z; 24/02/2006

                BEGIN
                        nNumError:=52;
                sMsgError:='Error, Seleccionar Servicio por Defecto en Centerales';
                VP_TABLA:='ICG_ACTUACIONTERCEN';
                VP_ACT:='S';

                        --CO-200608160327: German Espinoza Z; 17/08/2006
                        /*LV_sSql:=' SELECT cod_servicios';
                        LV_sSql:=LV_sSql||' FROM   icg_actuaciontercen';
                        LV_sSql:=LV_sSql||' WHERE  cod_actuacion=(SELECT cod_actcen';
                        LV_sSql:=LV_sSql||'                                           FROM   ga_actabo ';
                        LV_sSql:=LV_sSql||'                                           WHERE  cod_actabo=:v1';
                        LV_sSql:=LV_sSql||'                                           AND    cod_modulo=:v2';
                        LV_sSql:=LV_sSql||'                                           AND    cod_tecnologia=:v3)';
                        LV_sSql:=LV_sSql||' AND    tip_tecnologia=:v4';
                        LV_sSql:=LV_sSql||' AND    cod_producto=:v5';
                        LV_sSql:=LV_sSql||' AND    tip_terminal=:v6';*/
                        --FIN/CO-200608160327: German Espinoza Z; 17/08/2006

                        LV_sSql2:=' SELECT COUNT(1)';
                        LV_sSql2:=LV_sSql2||' FROM  ga_servsuplabo';
                        LV_sSql2:=LV_sSql2||' WHERE num_abonado=:v1';
                        LV_sSql2:=LV_sSql2||' AND   cod_servsupl=:v2';
                        LV_sSql2:=LV_sSql2||' AND   cod_producto=:v4';
                        LV_sSql2:=LV_sSql2||' AND   ind_estado<3';

                        LV_sSql3:=' INSERT INTO ga_servsuplabo';
                LV_sSql3:=LV_sSql3||' (num_abonado, cod_servicio, fec_altabd, cod_servsupl,';
                LV_sSql3:=LV_sSql3||' cod_nivel, cod_producto, num_terminal, nom_usuarora,';
                LV_sSql3:=LV_sSql3||' ind_estado, fec_altacen, fec_bajabd, fec_bajacen, cod_concepto)';
                    LV_sSql3:=LV_sSql3||' SELECT :v1, a.cod_servicio,:v2, a.cod_servsupl,';
                    LV_sSql3:=LV_sSql3||' a.cod_nivel, a.cod_producto,:v3,:v4,';
                    LV_sSql3:=LV_sSql3||' :v5,NULL, NULL, NULL, b.cod_concepto';
                    LV_sSql3:=LV_sSql3||' FROM ga_servsupl a, ga_actuaserv b, ga_servuso c';
                    LV_sSql3:=LV_sSql3||' WHERE a.cod_producto = :v6';
                    --LV_sSql3:=LV_sSql3||' AND a.cod_servsupl=:v7';      --COL-39306|05-04-2007|GEZ
                        LV_sSql3:=LV_sSql3||' AND NVL(a.cod_servsupl,1)=:v7'; --COL-39306|05-04-2007|GEZ
                    LV_sSql3:=LV_sSql3||' AND a.cod_nivel=:v8';
                    LV_sSql3:=LV_sSql3||' AND a.cod_producto = b.cod_producto(+)';
                    LV_sSql3:=LV_sSql3||' AND b.cod_actabo(+) = :v9';
                    LV_sSql3:=LV_sSql3||' AND b.cod_tipserv(+) = :v10';
                    LV_sSql3:=LV_sSql3||' AND a.cod_servicio = b.cod_servicio(+)';
                    LV_sSql3:=LV_sSql3||' AND a.cod_producto = c.cod_producto';
                    LV_sSql3:=LV_sSql3||' AND a.cod_servicio = c.cod_servicio';
                    LV_sSql3:=LV_sSql3||' AND c.cod_uso = :v11';

                        --CO-200608160327: German Espinoza Z; 17/08/2006
                        --EXECUTE IMMEDIATE LV_sSql INTO LV_CodServTercen
                        --USING 'AM','GA',sCodTecnologia,sCodTecnologia,nCodProducto,sTipTerminal;
                        --FIN/CO-200608160327: German Espinoza Z; 17/08/2006

                        LOOP

                                IF LV_CodServTercen IS NULL THEN
                                   EXIT;
                                END IF;

                                LN_CodSersupl:=SUBSTR(LV_CodServTercen,1,2);
                                LN_CodNivel:=SUBSTR(LV_CodServTercen,5,2);

                                BEGIN
                                        nNumError:=53;
                                sMsgError:='Error, Al Verificar si el Servicio ('||LN_CodSersupl||'-'||LN_CodNivel||') existe';
                                VP_TABLA:='GA_SERVSUPLABO';
                                VP_ACT:='S';

                                        EXECUTE IMMEDIATE LV_sSql2 INTO LN_CantServ
                                        USING nNuevoAbonado,LN_CodSersupl,nCodProducto;

                                        IF LN_CantServ=0 THEN

                                           nNumError:=54;
                                   sMsgError:='Error, Al Insertar en la GA_SERVUSPLABO';
                                   VP_TABLA:='GA_SERVSUPLABO';
                                   VP_ACT:='I';

                                           EXECUTE IMMEDIATE LV_sSql3
                                           USING nNuevoAbonado,SYSDATE,vNUM_CELULAR,vNOM_USUARORA,1
                                           ,nCodProducto,LN_CodSersupl,LN_CodNivel,'SS',2,nCodUso;

                                        END IF;
                                EXCEPTION
                                        WHEN OTHERS THEN
                                                 VP_SQLERRM:=SQLERRM;
                                                 RAISE ERROR_PROCESO;
                                END;

                                LV_CodServTercen:=SUBSTR(LV_CodServTercen,7);
                        END LOOP;

                EXCEPTION
                        WHEN NO_DATA_FOUND THEN
                                NULL;
                END;
                --FIN/RA-200602200811: German Espinoza Z; 24/02/2006

            --CO-200608160327: German Espinoza Z; 17/08/2006
            nNumError:=56; -- TM-200407140837
        sMsgError:='Error, al Obtener Servcios Suplementarios del Abonado';
        VP_TABLA :='GA_SERVSUPLABO';
        VP_ACT   :='C';

                sAuxCodServ := NULL;
                sClaseServicio:=NULL;

        OPEN CUR_ServSup(nNuevoAbonado);
             LOOP
                FETCH CUR_ServSup INTO sAuxCodServ;
                EXIT WHEN CUR_ServSup%NOTFOUND;

                                sClaseServicio:=sClaseServicio||sAuxCodServ;

             END LOOP;
        CLOSE CUR_ServSup;

                UPDATE ga_aboamist SET clase_servicio=sClaseServicio
                WHERE num_abonado=nNuevoAbonado;

            --FIN/CO-200608160327: German Espinoza Z; 17/08/2006

        -- Insertar Serie en GA_EQUIPABOSER
        nNumError:=24;-- TM-200407140837
        sMsgError:='Error, al Insetar Serie';
        VP_TABLA:='GA_EQUIPABOSER';
        VP_ACT:='I';

       INSERT INTO GA_EQUIPABOSER
       (NUM_ABONADO, NUM_SERIE, COD_PRODUCTO, IND_PROCEQUI, FEC_ALTA,
       IND_PROPIEDAD, COD_BODEGA, TIP_STOCK, COD_ARTICULO, IND_EQUIACC,
       COD_MODVENTA, TIP_TERMINAL, COD_USO, COD_ESTADO, CAP_CODE,
       --TMM-04026 INI
       NUM_SERIEMEC, DES_EQUIPO, NUM_MOVIMIENTO, COD_PAQUETE, NUM_IMEI, COD_TECNOLOGIA)
       --TMM-04026 FIN
       SELECT  nNuevoAbonado , NUM_SERIE, COD_PRODUCTO, IND_PROCEQUI,
       SYSDATE, IND_PROPIEDAD, COD_BODEGA, TIP_STOCK, COD_ARTICULO,
       IND_EQUIACC, COD_MODVENTA, TIP_TERMINAL, nCodUso , COD_ESTADO,
       --TMM-04026 INI
       CAP_CODE, NUM_SERIEMEC, DES_EQUIPO, NUM_MOVIMIENTO, COD_PAQUETE, NUM_IMEI, COD_TECNOLOGIA --sNumImei
       --TMM-04026 FIN
       FROM GA_EQUIPABOSER
       WHERE NUM_ABONADO =  vNumAbonado
       AND FEC_ALTA = (SELECT MAX(FEC_ALTA) FROM GA_EQUIPABOSER
       WHERE NUM_ABONADO =  vNumAbonado );

       -- Actualiza numero de abonados del cliente
       nNumError:=25; -- TM-200407140837

           --INI COL-41006|29-05-2007|GEZ
           --sMsgError:='Error, al Insertar Serie';
           --VP_TABLA:='GA_EQUIPABOSER';
       --VP_ACT:='I';
           sMsgError:='Error, al Act. la Cant. de Abonados del Cliente';
           VP_TABLA:='GE_CLIENTES';
       VP_ACT:='U';
           --FIN COL-41006|29-05-2007|GEZ

       --Incrementa el n: de abonados del nuevo cliente
       UPDATE GE_CLIENTES SET NUM_ABOCEL = NUM_ABOCEL + 1
       --WHERE COD_CLIENTE = nCodClienteDist; --COL-41006|29-05-2007|GEZ
           WHERE COD_CLIENTE = nNuevoCliente;     --COL-41006|29-05-2007|GEZ

       --Obtener Csdigo Actuacisn Central
           nNumError:=26; -- TM-200407140837
       sMsgError:='Error, al Obtener Csdigo Actuacisn Central';
       VP_TABLA:='GA_ACTABO-22';
       VP_ACT:='S';

       -- Obtener Csdigo Actuacisn Central
       nNumError:=27;-- TM-200407140837
       sMsgError:='Error, al Ejecutar PV_PR_INSMOVIMIENTOS';
       VP_TABLA:='PV_PR_INSMOVIMIENTOS';
       VP_ACT:='E';

           SELECT  COD_TIPLAN INTO sCodTiplan
                 FROM TA_PLANTARIF
                WHERE COD_PLANTARIF = vCodPlantarif;

           sTipPlanHibrido := GE_FN_DEVVALPARAM('GA', 1, 'TIP_PLAN_HIBRIDO');

           IF sTipPlanHibrido = 'ERROR' then
                  RAISE ERROR_PROCESO;
           END IF;

           --INI CEM VIR_05002
                sAplicAltaPP:= GE_FN_DEVVALPARAM('GA',1,'APLICA_ALTA_PP');
           -- FIN CEM VIR_05002
           IF sCodTiplan = sTipPlanHibrido AND LTRIM(RTRIM(sAplicAltaPP)) = 'TRUE' THEN

          sCodActabo := 'SS';

          -- Obtener Csdigo Actuacisn Central
          nNumError:=28; -- TM-200407140837
          sMsgError:='Error, al Ejecutar PV_PR_INSMOVIMIENTOS';
          VP_TABLA:='PV_PR_INSMOVIMIENTOS';
          VP_ACT:='E';

          PV_PR_INSMOVIMIENTOS(nNUM_OOSS, SYSDATE,3,'SS', sCadServiciosAmiAdic,nCOD_ERROR, sMEN_ERROR);
          IF nCOD_ERROR <> 0 THEN
             RAISE ERROR_PROCESO;
          END IF;

          UPDATE GA_ABOAMIST
                     SET COD_SITUACION = 'AAA'
                   WHERE NUM_ABONADO = nNuevoAbonado;

                ELSE

           PV_PR_INSMOVIMIENTOS(nNUM_OOSS, SYSDATE,2,'AM', NULL,nCOD_ERROR, sMEN_ERROR);
           IF nCOD_ERROR <> 0 THEN
              RAISE ERROR_PROCESO;
           END IF;

                   sCodActabo := 'SS';

                   --CO-200608160327: German Espinoza Z; 17/08/2006
                   IF sCadServiciosAmiAdic IS NOT NULL THEN
                           -- Obtener Csdigo Actuacisn Central
                   nNumError:=29; -- TM-200407140837
                   sMsgError:='Error, al Ejecutar PV_PR_INSMOVIMIENTOS';
                   VP_TABLA:='PV_PR_INSMOVIMIENTOS';
                   VP_ACT:='E';

                   PV_PR_INSMOVIMIENTOS(nNUM_OOSS, SYSDATE,3,'SS', sCadServiciosAmiAdic,nCOD_ERROR, sMEN_ERROR);
                   IF nCOD_ERROR <> 0 THEN
                      RAISE ERROR_PROCESO;
                   END IF;
                   END IF;
                   --FIN/CO-200608160327: German Espinoza Z; 17/08/2006

                END IF;

                -- INI YAAT P-MIX-06003 --
                nNumError:=46;
            sMsgError:='Error, Al obtener Secuencia';
            VP_TABLA:=' pv_generales_pg';
            VP_ACT:='E';

                eo_secuencia := pv_inicia_estructuras_pg.pv_secuencia_qt_fn;

        eo_secuencia.nom_secuencia := 'PV_SEQ_NUMOS';

        pv_generales_pg.pv_obtiene_secuencia_pr( eo_secuencia, sn_cod_retorno, sv_mens_retorno, sn_num_evento);

                IF sn_cod_retorno!=0 THEN
                     RAISE ERROR_PROCESO;
                ELSE
                   ln_num_ooss := eo_secuencia.num_secuencia;
                END IF;

                nNumError:=47;
            sMsgError:='Error, Al obtener Cod. Plan Servicio';
            VP_TABLA:='GA_PLANTECPLSERV';
            VP_ACT:='S';

                SELECT COD_PLANSERV INTO lv_cod_planserv
                FROM GA_PLANTECPLSERV
                WHERE COD_PRODUCTO   = 1
                AND   COD_TECNOLOGIA = sCodTecnologia
                AND   COD_PLANTARIF  = nCodPlantarif
                AND   SYSDATE BETWEEN FEC_DESDE AND NVL(FEC_HASTA,SYSDATE);

                IF trim(lv_cod_planserv) = '' or lv_cod_planserv is null THEN
           RAISE ERROR_PROCESO;
        END IF;

                nNumError:=48;
            sMsgError:='Error, Al obtener Validacion de Serv. ACT/DES';
            VP_TABLA:='pv_inicia_estructuras_pg';
            VP_ACT:='E';

                  eo_param := pv_inicia_estructuras_pg.pv_valida_serv_actdec_qt_fn;
                  eo_param.num_movimiento    := ln_num_ooss;
                  eo_param.cod_actabo        := 'BA';
                  eo_param.cod_producto      := 1;
                  eo_param.cod_tecnologia    := sCodTecnologia;
                  eo_param.tip_pantalla      := ln_cero;
                  eo_param.cod_concepto      := ln_cero;
                  eo_param.cod_modulo        := 'XS';
                  eo_param.cod_plantarif_nue := nCodPlantarif;
                  eo_param.cod_plantarif_ant := nCodPlantarif;
                  eo_param.tip_abonado       := ln_cero;
                  eo_param.cod_os            := '10233';
                  eo_param.cod_cliente       := nNuevoCliente  ;
                  eo_param.num_abonado       := nNuevoAbonado;
                  eo_param.ind_factur        := ln_cero;
                  eo_param.cod_planserv      := lv_cod_planserv;
                  eo_param.cod_operacion     := ln_cero;
                  eo_param.cod_tipcontrato   := ln_cero;
                  eo_param.tip_celular       := ln_cero;
                  eo_param.num_meses         := ln_cero;
                  eo_param.cod_antiguedad    := ln_cero;
                  eo_param.cod_ciclo         := ln_cero;
                  eo_param.num_celular       := vNUM_CELULAR;
                  eo_param.tip_servicio      := ln_cero;
                  eo_param.cod_plancom       := ln_cero;
                  eo_param.param1_mens       := 'NO';
                  eo_param.param2_mens       := ln_cero;
                  eo_param.param3_mens       := ln_cero;
                  eo_param.cod_articulo      := ln_cero;
                  eo_param.cod_causa         := ln_cero;
                  eo_param.cod_causa_nue     := ln_cero;
                  eo_param.cod_vend          := ln_cero;
                  eo_param.cod_categoria     := ln_cero;
                  eo_param.cod_modventa      := ln_cero;
                  eo_param.cod_causinie      := ln_cero;

                  pv_restric_validaciones_pg.pv_valida_serv_actdec_pr(eo_param, SV_record,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

                  If SN_cod_retorno!=0 THEN
                     RAISE ERROR_PROCESO;
                  END IF;

                  FETCH SV_record INTO
                        setNumMovimiento,setCodActAbo,setIndFactur,setDesServ,setNumUnidades,setCodConcepto,setImpCargo,setCodArticulo,setCodBodega,SetNumSerie,setIndEquipo,setCodCliente,setNumAbonado,setTipDto,setValDto,setCodConceptoDTO,setNumCelular,setCodPlanCom,SetClaseServiciosAct,setClaseServiciosDes,setParam1_mens,setParam2_mens,setParam3_mens,setClaseServicios,setDesMoneda,setCodMoneda,setCodCiclo,setFacCont,setPDesc,setValMin,setValMax, setCodError,DES_ERROR;
                  CLOSE SV_record;

                  sCadServiciosmotor:=setClaseServicios;

                  IF (sCadServiciosmotor IS NOT NULL OR trim(sCadServiciosmotor) <> '' )THEN

                                nNumError:=49;
                    sMsgError:='Error, al Ejecutar PV_PR_INSMOVIMIENTOS';
                    VP_TABLA:='PV_PR_INSMOVIMIENTOS';
                    VP_ACT:='E';

                                PV_PR_INSMOVIMIENTOS(nNUM_OOSS,SYSDATE,4,'SS',sCadServiciosmotor,nCOD_ERROR, sMEN_ERROR);
                                IF nCOD_ERROR <> 0 THEN
                                           RAISE ERROR_PROCESO;
                                END IF;
                  END IF;

                -- FIN YAAT P-MIX-06003 --


                -- Inicio Modificacion TM-200407140837 - 19/07/2004 - SOPORTE
                nNumError:=30; -- TM-200407140837
        sMsgError:='Error, al Actualizar COD_PLANTARIF';
                VP_TABLA:='PV_PARAM_ABOCEL';
        VP_ACT:='S';

                UPDATE PV_PARAM_ABOCEL
                   SET COD_PLANTARIF = Vcod_plan_comverse
                 WHERE num_os = nNUM_OOSS;
                -- Fin Modificacion TM-200407140837 - 19/07/2004 - SOPORTE



        --Promocion
                nNumError:=32; -- TM-200407140837
                sMsgError:='Error, al obtener Cod_Modulo';
                VP_TABLA:='GE_MODULOS';
                VP_ACT:='S';

                --OCB-INI-TMM-04010
        sCodModulos := GE_FN_DEVVALPARAM('GA', 1, 'COD_MOD_PSVTA');
                --OCB-FIN-TMM-04010

                nNumError:=33; -- TM-200407140837
        sMsgError:='Error, al obtener Cod_Valor';
        VP_TABLA:='GE_MODULOS';
        VP_ACT:='S';

                SELECT COD_VALOR
          INTO sCodValor
          FROM GED_CODIGOS
         WHERE NOM_COLUMNA = 'COD_TIPLAN'
           AND DES_VALOR='PREPAGO';

        BEGIN

             nNumError:=34; -- TM-200407140837
             sMsgError:='Error, al ejecuta BP_PROMOCIONES_PG.BP_PROMOCION_OMISION_PR';
             VP_TABLA:='BP_PROMOCION_OMISION_PR';
             VP_ACT:='E';

             SELECT GA_SEQ_TRANSACABO.NEXTVAL
                         INTO nNumtransacc
                         FROM DUAL;

             BP_PROMOCIONES_PG.BP_PROMOCION_OMISION_PR(nNumtransacc,nNuevoAbonado,sCodModulos,sCodValor,'A','A',3,0,'N');

                         SELECT COD_RETORNO,DES_CADENA
                         INTO nCOD_RETORNO,vDES_CADENA
                         FROM GA_TRANSACABO
                         WHERE NUM_TRANSACCION = nNumtransacc;

                         IF nCOD_RETORNO <> 0 THEN
                            --OCB-INI-TMM-04010
                            RAISE ERROR_PROCESO_PUNTUAL;
                                --OCB-FIN-TMM-04010
                         END IF;

        EXCEPTION
             WHEN OTHERS THEN
                              --OCB-INI-TMM-04010
                  RAISE ERROR_PROCESO_PUNTUAL;
                                  --OCB-FIN-TMM-04010
        END;

        --OCB-INI-TMM-04010
        nNumError:=35;
            sMsgError:='Error, al obtener parametro de migracion postpago/prepago';
            VP_TABLA:='GED_PARAMETROS';
            VP_ACT:='S';

        SELECT VAL_PARAMETRO
              INTO sVALParam_MIGRA
              FROM GED_PARAMETROS
             WHERE NOM_PARAMETRO = 'MIG_NUM_FREC';


            nNumError:=38;
        sMsgError:='Error, Al obtener tipo plan hibrido';
        VP_TABLA:='GED_PARAMETROS';
        VP_ACT:='S';

                sTipPlanHibrido := GE_FN_DEVVALPARAM('GA', 1, 'TIP_PLAN_HIBRIDO');

                IF sTipPlanHibrido = 'ERROR' then
               RAISE ERROR_PROCESO;
                END IF;

                -- VERIFICA SI APLICA MIGRACION
                BEGIN

                        IF (trim(sVALParam_MIGRA) ='TRUE'  and trim(sCodTiplan) <> trim(sTipPlanHibrido)) THEN

                           nNumError:=39;
                           sMsgError:='Error, al obtener total registros';
                           VP_TABLA:='GA_TRASP_NUMFREC_TEMP';
                           VP_ACT:='S';

                           SELECT COUNT(1)
                           INTO vCANT_MIGRA
                           FROM GA_TRASP_NUMFREC_TEMP
                           WHERE NUM_ABONADO = nNUM_ABONADO;

                           -- VERIFICA  SI EFECTIVAMENTE POSEE REGISTROS PARA MIGRAR

                           IF vCANT_MIGRA > 0 THEN

                          nNumError:=40;
                          sMsgError:='Error, al actualizar abonado';
                          VP_TABLA:='GA_TRASP_NUMFREC_TEMP';
                          VP_ACT:='U';

                          UPDATE GA_TRASP_NUMFREC_TEMP
                             SET NUM_ABONADO =  nNuevoAbonado
                           WHERE NUM_ABONADO = nNUM_ABONADO;

                              nNumError:=41;
                          sMsgError:='Error, al insertar abonado con actuacion SS';
                          VP_TABLA:='GA_TRASP_NUMFREC_TEMP';
                          VP_ACT:='I';

                          INSERT INTO GA_TRASP_NUMFREC_TEMP
                                        (COD_ACTABO,NUM_ABONADO,NUM_CELULAR,NUM_MOVIMIENTO,TIP_FRECUENTE)
                          VALUES('SS',nNuevoAbonado ,vNUM_CELULAR ,NULL,NULL);

                           END IF;

                     END IF;
                EXCEPTION
                        WHEN OTHERS THEN
                                 nCOD_RETORNO:=3;
                                 vDES_CADENA:=sMsgError;
                                 RAISE ERROR_PROCESO_PUNTUAL;
                END;

            vCodPlantarif_des:=nCodPlantarif;

        IF trim(vCodPlantarif_des) = '' or vCodPlantarif_des is null THEN
           RAISE ERROR_PROCESO;
        END IF;

                nNumError:=44;
            sMsgError:='Error, Al obtener Ind. de Traspaso';
            VP_TABLA:='GED_PARAMETROS';
            VP_ACT:='S';

                IF sCodTiplan = sTipPlanHibrido THEN

            SELECT VAL_PARAMETRO
            INTO vInd_traspaso
            FROM GED_PARAMETROS
            WHERE NOM_PARAMETRO = 'TRASP_HIBR_PREPAGO';

            IF trim(vInd_traspaso) = '' or vCodPlantarif_des is null THEN
               RAISE ERROR_PROCESO;
            END IF;

                ELSE

            SELECT VAL_PARAMETRO
            INTO vInd_traspaso
            FROM GED_PARAMETROS
            WHERE NOM_PARAMETRO = 'TRASP_POST_PREPAGO';

            IF trim(vInd_traspaso) = '' or vCodPlantarif_des is null THEN
                        RAISE ERROR_PROCESO;
            END IF;

            END IF;

            nNumError:=45;
            sMsgError:='Error, al ejecutar GA_HIST_MIGR_PG.GA_INSERTA_TRASPASO_PR';
            VP_TABLA:='GA_INSERTA_TRASPASO_PR';
            VP_ACT:='E';

        SELECT GA_SEQ_TRANSACABO.NEXTVAL
                  INTO nNumtransacc
                  FROM DUAL;

        GA_HIST_MIGR_PG.GA_INSERTA_TRASPASO_PR(
                                                   nNumtransacc,
                                                   nNuevoAbonado,
                                                   nNuevoCliente,
                                                   nCodCuenta,
                                                   '0',
                                                   VCOD_USUARIO,--ESPERAR DEFINICION PATO: OK! PAGC
                                                   1,
                                                   vNUM_CELULAR,
                                                   nNUM_ABONADO,
                                                   nCodCliente,
                                                   nCodCuenta,
                                                   VCOD_SUBCUENTA,
                                                   VCOD_USUARIO,
                                                   '0',
                                                   USER,
                                                   vInd_traspaso,
                                                   vCodPlantarif,
                                                   vCodPlantarif_des,
                                                   --vCOD_VENDEDOR); --ESPERAR DEFINICION PATO
                                                   vCod_vendedor_nuevo);--TMM_04010_PAGC

                SELECT COD_RETORNO,DES_CADENA
                  INTO nCOD_RETORNO,vDES_CADENA
                  FROM GA_TRANSACABO
                 WHERE NUM_TRANSACCION = nNumtransacc;

                IF NVL(nCOD_RETORNO,4)<> 0 then
                   raise ERROR_PROCESO_PUNTUAL;
                ELSE
                        DELETE GA_TRANSACABO
                        WHERE NUM_TRANSACCION = nNumtransacc;
                END IF;

         --OCB-FIN-TMM-04010

     EXCEPTION
                             WHEN ERROR_PROCESO_PUNTUAL THEN
                                                  RAISE ERROR_PROCESO_PUNTUAL;
                 WHEN OTHERS THEN
                          RAISE ERROR_PROCESO;



     END;


     nNumError:=0;
     sMsgError:='Operacisn Exitosa';
     nCOD_ERROR:=nNumError;
     sMEN_ERROR:=sMsgError;

EXCEPTION


        WHEN ERROR_PROCESO THEN


                  VP_SQLCODE:=SQLCODE;
                  VP_SQLERRM:=SQLERRM;

                  ROLLBACK;

                  INSERT INTO GA_ERRORES(COD_ACTABO,CODIGO,FEC_ERROR,COD_PRODUCTO,NOM_PROC,
                  NOM_TABLA,COD_ACT,COD_SQLCODE,COD_SQLERRM)
                  VALUES(vCOD_ACTABO,nNUM_ABONADO,SYSDATE,1,VP_PROC,VP_TABLA,VP_ACT,
                  VP_SQLCODE,VP_SQLERRM);

                  COMMIT;

                  nCOD_ERROR:=nNumError;
                  sMEN_ERROR:=sMsgError;


                WHEN ERROR_PROCESO_PUNTUAL THEN

                                  VP_SQLCODE := nCOD_RETORNO;
                  VP_SQLERRM := SUBSTR(vDES_CADENA,1,60);

                                  ROLLBACK;

                  INSERT INTO GA_ERRORES(COD_ACTABO,CODIGO,FEC_ERROR,COD_PRODUCTO,NOM_PROC,
                  NOM_TABLA,COD_ACT,COD_SQLCODE,COD_SQLERRM)
                  VALUES(vCOD_ACTABO,nNUM_ABONADO,SYSDATE,1,VP_PROC,VP_TABLA,VP_ACT,
                  VP_SQLCODE,VP_SQLERRM);

                  COMMIT;

                  nCOD_ERROR:=nNumError;
                  sMEN_ERROR:=sMsgError;




END PV_PR_BAJAAMISTAR;
/
SHOW ERRORS