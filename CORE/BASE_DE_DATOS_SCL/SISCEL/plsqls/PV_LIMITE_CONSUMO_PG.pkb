CREATE OR REPLACE PACKAGE BODY SISCEL.PV_LIMITE_CONSUMO_PG AS

PROCEDURE PV_VALIDA_LIMITE_PR  (EN_NUM_ABONADO   IN  NUMBER,
                                EN_COD_CLIENTE   IN  NUMBER,
                                EV_COD_PLANTARIF IN  VARCHAR2,
                                SV_ESTADO        OUT NOCOPY VARCHAR2)
IS

/*
<Documentación TipoDoc = "Procedimiento">
    <Elemento Nombre = "PV_VALIDA_LIMITE_PR"
        Lenguaje="PL/SQL" Fecha="03-09-2007"
        Versión = "1.0"
        Diseñador = "Sebastian Quevedo L. "
        Programador = "Sebastian Quevedo L."
        Ambiente Desarrollo="BD">
        <Retorno></Retorno>
        <Descripción>Procedimiento para validar cambio de limite de consumo</Descripción>
        <Parámetros>
            <Entrada>
                <param nom="EN_NUM_ABONADO"   Tipo="NUMBER">Numero de Abonado</param>
                <param nom="EN_COD_CLIENTE"   Tipo="NUMBER">Codigo de Cliente</param>
                <param nom="EV_COD_PLANTARIF" Tipo="VARCHAR2">Codigo Plan Tarifario</param>
            </Entrada>
            <Salida>
                <param nom="SV_ESTADO"        Tipo="VARCHAR2">Codigo de Estado</param>
            </Salida>
        </Parámetros>
    </Elemento>
</Documentación>
*/

N_CANTIDAD NUMBER;

BEGIN
    SV_ESTADO := 'TRUE';

    SELECT COUNT(1) INTO N_CANTIDAD
    FROM    GA_INTARCEL
    WHERE   NUM_ABONADO     = EN_NUM_ABONADO
    AND     COD_CLIENTE     = EN_COD_CLIENTE
    AND     FEC_DESDE      >= TRUNC(SYSDATE)
    AND     COD_PLANTARIF   = EV_COD_PLANTARIF;


    IF N_CANTIDAD = 0 Then
        SV_ESTADO := 'FALSE';
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        SV_ESTADO := 'FALSE';
END PV_VALIDA_LIMITE_PR;

PROCEDURE PV_LIMITE_INTARCEL_PR(EN_pnSujeto IN  NUMBER,
                                EV_LcNuevo  IN  VARCHAR2,
                                EV_FecDesde IN  VARCHAR2,
                                SV_ErrorOra out VARCHAR2,
                                SV_ErrorOraGlosa out NOCOPY VARCHAR2,
                                SV_ErrorAplic    out NOCOPY VARCHAR2)
IS

/*
<Documentación TipoDoc = "Procedimiento">
    <Elemento Nombre = "PV_LIMITE_INTARCEL_PR"
        Lenguaje="PL/SQL" Fecha="27-08-2007"
        Versión = "1.0"
        Diseñador = "Roberto Rodriguez G. "
        Programador = "Roberto Rodriguez G."
        Ambiente Desarrollo="BD">
        <Retorno></Retorno>
        <Descripción>Procedimiento para actualizar limite de consumo a partir de cliente</Descripción>
        <Parámetros>
            <Entrada>
                <param nom="EN_pnSujeto"  Tipo="NUMBER">Codigo de Cliente</param>
                <param nom="EV_LcNuevo"  Tipo="VARCHAR2">Codigo nuevo Limite de consumo</param>
                <param nom="EV_FecDesde"  Tipo="VARCHAR2">Fecha de limite de consumo</param>
            </Entrada>
            <Salida>
                <param nom="SV_ErrorOra"    Tipo="VARCHAR2">Codigo Error Oracle</param>
                <param nom="SV_ErrorOraGlosa"      Tipo="VARCHAR2">Glosa de error retornada por Oracle</param>
                <param nom="SV_ErrorAplic"       Tipo="VARCHAR2">Codigo de Error Aplicacion</param>
            </Salida>
        </Parámetros>
    </Elemento>
</Documentación>
*/


    CURSOR cur_abonado is
    SELECT  a.COD_CLIENTE,
            a.NUM_ABONADO,
            a.IND_NUMERO,
            a.FEC_DESDE,
            a.FEC_HASTA,
            a.IMP_LIMCONSUMO,
            a.IND_FRIENDS,
            a.IND_DIASESP,
            a.COD_CELDA,
            a.TIP_PLANTARIF,
            a.COD_PLANTARIF,
            a.NUM_SERIE,
            a.NUM_CELULAR,
            a.COD_CARGOBASICO,
            b.COD_CICLO,
            a.COD_PLANCOM,
            a.COD_PLANSERV,
            a.COD_GRPSERV,
            a.COD_GRUPO ,
            a.COD_PORTADOR,
            a.cod_uso
    FROM    ga_intarcel a, ga_abocel b
    WHERE   a.cod_cliente = EN_pnSujeto
    AND     a.cod_cliente = b.cod_cliente
    AND     a.num_abonado = b.num_abonado
    AND     b.cod_situacion not in ('BAA','BAP')
    AND     sysdate between fec_desde AND fec_hasta;

    vSeqErr         NUMBER;
    VP_SQLCODE      VARCHAR2(15);
    VP_SQLERRM      VARCHAR2(255);
    V_ERROR         VARCHAR2(1) := '0';
    VP_PROC         VARCHAR2(50);
    VP_TABLA        VARCHAR2(50);
    VP_ACT          VARCHAR2(1);
    vDesCadena      VARCHAR2(255);
    vInd            number(1):=0;

    vFormatoSel2    GED_PARAMETROS.VAL_PARAMETRO%TYPE;
    vFormatoSel7    GED_PARAMETROS.VAL_PARAMETRO%TYPE;

    V_fec_desdeciclo date;
    V_coc_ciclfact   fa_ciclfact.cod_ciclfact%TYPE;

    ERROR_PROCESO_INTARCEL    EXCEPTION;

BEGIN

    vFormatoSel2 := ge_fn_devvalparam('GE', 1, 'FORMATO_SEL2');
    vFormatoSel7 := ge_fn_devvalparam('GE', 1, 'FORMATO_SEL7');

    for reg_abonado in cur_abonado loop

        BEGIN

            SELECT  b.FEC_hastallam + (1/64000) , b.cod_ciclfact
            INTO    V_fec_desdeciclo, V_coc_ciclfact
            FROM    fa_ciclfact b
            WHERE   B.COD_CICLO = reg_abonado.COD_CICLO
            AND     SYSDATE BETWEEN b.fec_desdellam AND b.fec_hastallam;

            IF vInd = 0 THEN
                P_LIMITE_CONSUMO(1,reg_abonado.cod_cliente,0, EV_LcNuevo,TO_DATE(EV_FecDesde, vFormatoSel2||' '||vFormatoSel7), VP_PROC, VP_TABLA, VP_ACT, VP_SQLCODE, VP_SQLERRM,V_ERROR);
                vInd := 1;
            END IF;

            P_LIMITE_CONSUMO(1,reg_abonado.cod_cliente, reg_abonado.num_abonado , EV_LcNuevo,TO_DATE(EV_FecDesde, vFormatoSel2||' '||vFormatoSel7),VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);

            INSERT INTO ga_finciclo (COD_CLIENTE, NUM_ABONADO, COD_CICLFACT,COD_PRODUCTO, TIP_PLANTARIF, COD_PLANTARIF,COD_CARGOBASICO,FEC_DESDELLAM, NUM_DIAS)
            VALUES                  (reg_abonado.cod_cliente,reg_abonado.num_abonado,V_coc_ciclfact,1,reg_abonado.TIP_PLANTARIF, -1,reg_abonado.COD_CARGOBASICO, V_fec_desdeciclo,1);

            IF V_ERROR > 0 THEN
                SV_ErrorAplic := '4';
                SV_ErrorOra := TO_CHAR(SQLCODE);
                SV_ErrorOraGlosa := SUBSTR(SQLERRM,1,60);
                RAISE ERROR_PROCESO_INTARCEL;
            END IF;

            exception when others THEN
                SV_ErrorAplic := '4';
                SV_ErrorOra := TO_CHAR(SQLCODE);
                SV_ErrorOraGlosa := SUBSTR(SQLERRM,1,60);
                RAISE ERROR_PROCESO_INTARCEL;
        end;

    end loop;

EXCEPTION
    WHEN ERROR_PROCESO_INTARCEL THEN
    NULL;
END PV_LIMITE_INTARCEL_PR;

PROCEDURE PV_MODIFICA_LC_PR(pnSujeto        IN NUMBER,
                            pvTipSujeto     IN VARCHAR2,
                            pvLcNuevo       IN VARCHAR2,
                            pvCausaHist     IN VARCHAR2,
                            pvFecDesde      IN VARCHAR2,
                            pvFecHasta      IN VARCHAR2,
                            pvCodValor      OUT NOCOPY VARCHAR2,
                            pvErrorAplic    OUT NOCOPY VARCHAR2,
                            pvErrorGlosa    OUT NOCOPY VARCHAR2,
                            pvErrorOra      OUT NOCOPY VARCHAR2,
                            pvErrorOraGlosa OUT NOCOPY VARCHAR2,
                            pvTrace         OUT NOCOPY VARCHAR2,
                            EVCodplantarIF  IN VARCHAR2:=NULL,
                            EVTipoMovimiento IN VARCHAR2:=NULL )
IS

nCodCliente         GE_CLIENTES.COD_CLIENTE%TYPE;
nCodClienteDest     GE_CLIENTES.COD_CLIENTE%TYPE;
nCodCliHist         GE_CLIENTES.COD_CLIENTE%TYPE;
nNumAbonadoHist     GA_ABOCEL.NUM_ABONADO%TYPE;
nNumAbonadoOrig     GA_ABOCEL.NUM_ABONADO%TYPE;
nCantAbonados       NUMBER;
nCantAboHist        NUMBER;
vModIFca            VARCHAR2(5);
nNumAbonado         GA_ABOCEL.NUM_ABONADO%TYPE;
nNumAboAux          GA_ABOCEL.NUM_ABONADO%TYPE;
vCodLimcons         GA_LIMITE_CLIABO_TO.COD_LIMCONS%TYPE;
vFecDesde           GA_LIMITE_CLIABO_TO.FEC_DESDE%TYPE;
vFecDesdeNuevo      GA_LIMITE_CLIABO_TO.FEC_DESDE%TYPE;
vFecDesdeNuevo_AUX  GA_LIMITE_CLIABO_TO.FEC_DESDE%TYPE;
vFecHastaNuevo      GA_LIMITE_CLIABO_TO.FEC_HASTA%TYPE;
vFormatoSel2        GED_PARAMETROS.VAL_PARAMETRO%TYPE;
vFormatoSel7        GED_PARAMETROS.VAL_PARAMETRO%TYPE;
vCodCausaHist       GA_LIMITE_CLIABO_TH.COD_CAUSA_HIST%TYPE;
vCodPlantarIF       TA_PLANTARIF.COD_PLANTARIF%TYPE;
vCodLimconsNuevo    GA_LIMITE_CLIABO_TO.COD_LIMCONS%TYPE;
LV_TipHibrido       GED_PARAMETROS.VAL_PARAMETRO%TYPE;
LV_TipPlan          TA_PLANTARIF.COD_TIPLAN%TYPE;
vFecDesdeProximo    GA_LIMITE_CLIABO_TO.FEC_DESDE%TYPE;
vCodLimConsActual   GA_LIMITE_CLIABO_TO.COD_LIMCONS%TYPE;
LV_COD_COLOR        GE_CLIENTES.COD_COLOR%TYPE;
LV_COD_SEGMENTO     GE_CLIENTES.COD_SEGMENTO%TYPE;

YA_EXISTE           VARCHAR2(1);
VP_PROC             VARCHAR2(50);
VP_TABLA            VARCHAR2(50);
VP_ACT              VARCHAR2(1);
VP_SQLCODE          VARCHAR2(15);
VP_SQLERRM          VARCHAR2(255);
V_ERROR             VARCHAR2(1) := '0';

nNumTransaccion     GA_TRANSACABO.NUM_TRANSACCION%TYPE;
nCodRetorno         GA_TRANSACABO.COD_RETORNO%TYPE;
vDesCadena          GA_TRANSACABO.DES_CADENA%TYPE;
vSeqErr             NUMBER;
V_fec_desdeciclo    date;
V_coc_ciclfact      fa_ciclfact.cod_ciclfact%TYPE;
v_cod_ciclo         ga_abocel.cod_ciclo%type;



ERROR_PROCESO    EXCEPTION;

BEGIN
    pvTrace := '('||pnSujeto||','||pvTipSujeto||','||pvLcNuevo||','||pvCausaHist||')';
    vFormatoSel2 := ge_fn_devvalparam('GE', 1, 'FORMATO_SEL2');
    vFormatoSel7 := ge_fn_devvalparam('GE', 1, 'FORMATO_SEL7');

    pvCodValor              := 'TRUE';
    pvErrorAplic    := '0';
    pvErrorGlosa    := ' ';
    pvErrorOra              := '0';
    pvErrorOraGlosa := ' ';
    nCantAbonados   := 0;
    nNumAbonadoOrig := 0;
    vModIFca        := 'FALSE';
    YA_EXISTE := 'N';

    IF GE_FN_DEVVALPARAM('GE', 1, 'IND_TOL') = 'N'  THEN
        pvCodValor := 'TRUE';
        IF pvTipSujeto = 'A' THEN
            vCodLimconsNuevo := '-1';
            nNumAbonado := pnSujeto;

            SELECT GA_SEQ_TRANSACABO.NEXTVAL
            INTO nNumTransaccion
            FROM DUAL;

            P_INTERFASES_ABONADOS(nNumTransaccion,'CL','1',nNumAbonado,vCodLimconsNuevo,NULL,NULL);

            SELECT  COD_RETORNO, DES_CADENA
            INTO    nCodRetorno, vDesCadena
            FROM    GA_TRANSACABO
            WHERE   NUM_TRANSACCION = nNumTransaccion;

            IF nCodRetorno > 0 THEN
                pvCodValor      := 'FALSE';
                pvErrorAplic    := '4';
                pvErrorGlosa    := SUBSTR(vDesCadena,1,60);
                pvErrorOra      := TO_CHAR(SQLCODE);
                pvErrorOraGlosa := SUBSTR(SQLERRM,1,60);
            END IF;
        Else
            IF pvTipSujeto = 'AL' THEN

                SELECT  COD_CLIENTE
                INTO    nCodCliente
                FROM    GA_ABOCEL
                WHERE   NUM_ABONADO = nNumAbonado;

                SELECT  NVL(COD_LIMCONS,' ')
                INTO    vCodLimConsActual
                FROM    GA_LIMITE_CLIABO_TO
                WHERE   cod_cliente = nCodCliente
                AND     NUM_ABONADO = nNumAbonado
                AND     SYSDATE BETWEEN FEC_DESDE AND NVL(FEC_HASTA,SYSDATE);

                P_LIMITE_CONSUMO(1,nCodCliente, pnSujeto, pvLcNuevo,TO_DATE(pvFecDesde, vFormatoSel2||' '||vFormatoSel7),VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);

                IF V_ERROR > 0 THEN
                    pvCodValor := 'FALSE';
                    pvErrorAplic := '4';
                    pvErrorGlosa := SUBSTR(vDesCadena,1,60);
                    pvErrorOra := TO_CHAR(SQLCODE);
                    pvErrorOraGlosa := SUBSTR(SQLERRM,1,60);
                    RAISE ERROR_PROCESO;
                END IF;

                BEGIN

                    INSERT INTO GA_MODABOCEL   (NUM_ABONADO,
                                                COD_TIPMODI,
                                                FEC_MODIFICA,
                                                NOM_USUARORA,
                                                COD_LIMCONSUMO)
                    VALUES                     (nNumAbonado,
                                                'IA',
                                                SYSDATE,
                                                USER,
                                                vCodLimConsActual);

                    EXCEPTION
                    WHEN OTHERS THEN
                        pvCodValor := 'FALSE';
                        pvErrorAplic := '4';
                        pvErrorGlosa := 'Problemas al insertar modIFicaciones del Abonado';
                        pvErrorOra := TO_CHAR(SQLCODE);
                        pvErrorOraGlosa := SUBSTR(SQLERRM,1,60);
                        RAISE ERROR_PROCESO;
                END;

            END IF;

        END IF;

        RAISE ERROR_PROCESO;
    END IF;

    IF pvTipSujeto = 'C' OR pvTipSujeto = 'CL' THEN
        pvTrace        := 'Op por Cliente';
        nCodCliente    := pnSujeto;
        nCodCliHist    := pnSujeto;

        BEGIN

            SELECT  a.COD_PLANTARIF
            INTO    vCodPlantarIF
            FROM    GA_EMPRESA a, GE_CLIENTES b, TA_PLANTARIF c
            WHERE   b.cod_cliente   = nCodCliente
            AND     b.COD_CLIENTE   = a.COD_CLIENTE
            AND     a.COD_PLANTARIF = c.COD_PLANTARIF
            AND     a.COD_PRODUCTO  = c.COD_PRODUCTO
            AND     a.COD_PRODUCTO  = 1;

            IF vCodPlantarIF <> EVCodplantarIF AND EVCodplantarIF Is Not Null THEN
                vCodPlantarIF := EVCodplantarIF;
            END IF;

            EXCEPTION
            WHEN NO_DATA_FOUND THEN
            IF EVCodplantarIF Is Not Null THEN
                vCodPlantarIF:=EVCodplantarIF;
            END IF;
        END;

        BEGIN
            SELECT  COD_CLIENTE_DEST, NUM_ABONADO
            INTO    nCodClienteDest, nNumAboAux
            FROM    GA_REASIGNA_CLI_TO
            WHERE   COD_CLIENTE_ORIG = nCodCliente
            AND     FEC_REASIGNA     = (SELECT MAX(FEC_REASIGNA)
                                        FROM GA_REASIGNA_CLI_TO
                                        WHERE COD_CLIENTE_ORIG = nCodCliente)
            AND     TRUNC(FEC_REASIGNA) = TRUNC(SYSDATE);

            EXCEPTION
            WHEN NO_DATA_FOUND THEN
                BEGIN
                    SELECT  COD_CLIENNUE, NUM_ABONADO, NUM_ABONADOANT
                    INTO    nCodClienteDest, nNumAboAux, nNumAbonadoOrig
                    FROM    GA_TRASPABO
                    WHERE   COD_CLIENANT = nCodCliente
                    AND     NUM_ABONADO  <> NUM_ABONADOANT
                    AND     FEC_MODIFICA = (SELECT MAX(FEC_MODIFICA)
                                            FROM GA_TRASPABO
                                            WHERE COD_CLIENANT = nCodCliente
                                            AND NUM_ABONADO  <> NUM_ABONADOANT)
                    AND     TRUNC(FEC_MODIFICA) = TRUNC (SYSDATE);

                EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    nCodClienteDest := nCodCliente;
                    nNumAboAux   := 0;
                END;
        END;


        BEGIN
            SELECT  COUNT(*)
            INTO    nCantAboHist
            FROM    GA_ABOCEL
            WHERE   COD_SITUACION = 'AAA'
            AND     COD_CLIENTE          = nCodCliHist
            GROUP BY COD_CLIENTE;

        EXCEPTION
        WHEN NO_DATA_FOUND THEN
            nCantAboHist := 0;
        END;

        -- En caso de no encontrar registro en GA_TRASPABO damos el abonado encontrado como destino --
        IF nNumAbonadoOrig = 0 THEN
            nNumAbonadoOrig := nNumAboAux;
        END IF;

        -- Buscamos Abonado correspondiente a Cliente Origen --
        BEGIN

            SELECT  NUM_ABONADO,NVL(COD_LIMCONS,' ')
            INTO    nNumAbonadoHist, vCodLimConsActual
            FROM    GA_LIMITE_CLIABO_TO A
            WHERE   a.cod_cliente = nCodCliHist
            AND     a.NUM_ABONADO = 0
            AND    (a.FEC_HASTA   IS NULL OR a.FEC_HASTA > SYSDATE)
            AND     a.FEC_DESDE = (SELECT MIN(B.FEC_DESDE)
                                   FROM GA_LIMITE_CLIABO_TO B
                                   WHERE B.cod_cliente = nCodCliHist
                                    AND B.NUM_ABONADO = 0);

        EXCEPTION
        WHEN NO_DATA_FOUND THEN
            nNumAbonadoHist := nNumAbonadoOrig;
        END;

        BEGIN
            SELECT COUNT(*)
            INTO    nCantAbonados
            FROM    GA_LIMITE_CLIABO_TO A
            WHERE   a.cod_cliente = nCodClienteDest
            AND     a.NUM_ABONADO = 0
            AND     a.FEC_HASTA   IS NULL;
        EXCEPTION
        WHEN NO_DATA_FOUND THEN
            nCantAbonados := 0;
        END;

        IF nCantAbonados = 0 THEN
            nCodCliente := nCodClienteDest;
            nNumAbonado := nNumAboAux;
        Else
            nNumAbonado := 0;
        END IF;

    ELSIF pvTipSujeto = 'A' OR pvTipSujeto = 'AL' THEN /* Operacion por Abonado Destino */

        pvTrace         := 'Op por Abonado';
        nNumAbonado     := pnSujeto;
        pvTrace         :='GA_ABOCEL'; --PAGC

        SELECT  COD_CLIENTE,COD_PLANTARIF
        INTO    nCodCliente, vCodPlantarIF
        FROM    GA_ABOCEL
        WHERE   NUM_ABONADO = nNumAbonado;

        SELECT  COD_TIPLAN INTO LV_TipPlan FROM TA_PLANTARIF
        WHERE   COD_PLANTARIF = vCodPlantarIF;

        SELECT  VAL_PARAMETRO INTO LV_TipHibrido
        FROM    GED_PARAMETROS
        WHERE   NOM_PARAMETRO='TIPOHIBRIDO';

        pvTrace:='GA_LIMITE_CLIABO_TO;'||to_char(nCodCliente)||';'||to_char(nNumAbonado); --PAGC
        -- Buscamos al Cliente, Abonado Origen y limite de consunmo actual --

        IF vCodPlantarIF <> EVCodplantarIF AND EVCodplantarIF Is Not Null THEN
            vCodPlantarIF := EVCodplantarIF;
        END IF;

        IF LV_TipPlan = LV_TipHibrido THEN
            vCodLimConsActual:=NULL;
        Else
            BEGIN
                IF EVTipoMovimiento = 'EI' THEN
                  vCodLimConsActual:=NULL;
                Else
                    SELECT  NVL(COD_LIMCONS,' ')
                    INTO    vCodLimConsActual
                    FROM    GA_LIMITE_CLIABO_TO
                    WHERE   cod_cliente     = nCodCliente
                    AND     NUM_ABONADO     = nNumAbonado
                    AND     SYSDATE BETWEEN FEC_DESDE AND NVL(FEC_HASTA,SYSDATE);
                END IF;

                EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    BEGIN
                        SELECT  COD_LIMCONSUMO
                        INTO    vCodLimConsActual
                        FROM    GA_ABOCEL
                        WHERE   cod_cliente = nCodCliente
                        AND     NUM_ABONADO = nNumAbonado;
                    EXCEPTION
                    WHEN NO_DATA_FOUND THEN
                        vCodLimconsActual := '-1';
                    END;
                END;
        END IF;

        BEGIN
                SELECT  COD_CLIENTE_ORIG, NUM_ABONADO
                INTO    nCodCliHist, nNumAbonadoHist
                FROM    GA_REASIGNA_CLI_TO
                WHERE   COD_CLIENTE_DEST = nCodCliente
                AND     FEC_REASIGNA     = (SELECT MAX(FEC_REASIGNA)
                                            FROM GA_REASIGNA_CLI_TO
                                            WHERE COD_CLIENTE_DEST = nCodCliente)
                AND TRUNC(FEC_REASIGNA) = TRUNC(SYSDATE);
            EXCEPTION
            WHEN NO_DATA_FOUND THEN
                BEGIN
                    SELECT  COD_CLIENANT, NUM_ABONADOANT
                    INTO    nCodCliHist, nNumAbonadoHist
                    FROM    GA_TRASPABO
                    WHERE   COD_CLIENNUE = nCodCliente
                    AND     NUM_ABONADO  <> NUM_ABONADOANT
                    AND     FEC_MODIFICA = (SELECT  MAX(FEC_MODIFICA)
                                            FROM    GA_TRASPABO
                                            WHERE   COD_CLIENNUE = nCodCliente
                                            AND     NUM_ABONADO  <> NUM_ABONADOANT)
                    AND TRUNC(FEC_MODIFICA) = TRUNC (SYSDATE);

                EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    nCodCliHist     := nCodCliente;
                    nNumAbonadoHist := nNumAbonado;
                END;
        END;


        -- Buscamos Abonado correspondiente a Cliente Origen --
        BEGIN

            SELECT  NUM_ABONADO
            INTO    nNumAboAux
            FROM    GA_LIMITE_CLIABO_TO A
            WHERE   a.cod_cliente = nCodCliHist
            AND     a.NUM_ABONADO = 0
            AND (a.FEC_HASTA   IS NULL OR a.FEC_HASTA > SYSDATE);
        -- Validamos si Cliente Origen debe o no pasar a Historico --
            BEGIN
                IF EVTipoMovimiento <> 'EI' THEN
                    nNumAbonadoHist := nNumAboAux;
                END IF;

                SELECT  COUNT(*)
                INTO    nCantAboHist
                FROM    GA_ABOCEL
                WHERE   COD_SITUACION = 'AAA'
                AND     COD_CLIENTE   = nCodCliHist
                GROUP BY COD_CLIENTE;

            EXCEPTION
            WHEN NO_DATA_FOUND THEN
               nCantAboHist := 0;
            END;

        EXCEPTION
        WHEN NO_DATA_FOUND THEN
            nCantAbonados := 0;
            nCantAboHist := 0;
        END;

    END IF;

    IF pvLcNuevo = ' ' OR pvLcNuevo IS NULL OR pvLcNuevo = '*' THEN
        BEGIN

            SELECT COD_COLOR,COD_SEGMENTO
            INTO LV_COD_COLOR, LV_COD_SEGMENTO
            FROM GE_CLIENTES
            WHERE cod_cliente =nCodCliente;

            SELECT  COD_LIMCONS
            INTO    vCodLimconsNuevo
            FROM    TOL_LIMITE_PLAN_TD
            WHERE   cod_plantarIF = vCodPlantarIF
            AND     id_subsegmento = LV_COD_SEGMENTO
            AND     ind_prioridad >= LV_COD_COLOR
            AND     SYSDATE BETWEEN FEC_DESDE AND NVL(FEC_HASTA, SYSDATE)
            AND     ROWNUM <=1
            ORDER  BY COD_LIMCONS ASC;
        EXCEPTION
        WHEN NO_DATA_FOUND THEN
            vCodLimconsNuevo := '-1';
        END;

    Else
        vCodLimconsNuevo := pvLcNuevo;
    END IF;

    IF pvFecDesde = ' ' OR pvFecDesde IS NULL OR pvFecDesde = '*' THEN
        vFecDesdeNuevo := SYSDATE;
        vFecDesdeNuevo_AUX:=vFecDesdeNuevo;
    Else
        SELECT TO_DATE(pvFecDesde, vFormatoSel2||' '||vFormatoSel7) INTO vFecDesdeNuevo FROM DUAL;
        SELECT TO_DATE(pvFecDesde, vFormatoSel2||' '||vFormatoSel7) INTO    vFecDesdeNuevo_AUX FROM DUAL;
    END IF;

    IF pvFecHasta = ' ' OR pvFecHasta IS NULL OR pvFecHasta = '*' THEN
        vFecHastaNuevo := NULL;
    Else
        vFecHastaNuevo := TO_DATE(pvFecHasta, vFormatoSel2||' '||vFormatoSel7);
    END IF;


    IF pvFecDesde = ' ' OR pvFecDesde IS NULL OR pvFecDesde = '*' THEN
        BEGIN
            SELECT  COD_LIMCONS,FEC_DESDE
            INTO    vCodLimcons, vFecDesde
            FROM    GA_LIMITE_CLIABO_TO
            WHERE   cod_cliente = nCodCliHist
            AND     NUM_ABONADO = nNumAbonadoHist
            AND     SYSDATE BETWEEN FEC_DESDE AND NVL(FEC_HASTA,SYSDATE);
        EXCEPTION
        WHEN NO_DATA_FOUND THEN
            vCodLimcons := NULL;
            vFecDesde   := NULL;
        END;

        IF nCantAboHist = 0 AND vCodLimcons Is Not Null THEN
            BEGIN

                IF EVTipoMovimiento IN ('EI','EE') THEN
                    UPDATE  GA_LIMITE_CLIABO_TO SET
                            FEC_HASTA = SYSDATE - (1 / 86400)
                    WHERE   NUM_ABONADO = 0
                    AND     COD_CLIENTE = nCodCliHist
                    AND     SYSDATE BETWEEN FEC_DESDE AND NVL(FEC_HASTA,SYSDATE);

                Else
                    UPDATE  GA_LIMITE_CLIABO_TO
                    SET     FEC_HASTA = SYSDATE - (1 / (24 * 60 * 60))
                    WHERE   NUM_ABONADO = pnSujeto
                    AND     COD_CLIENTE = nCodCliHist
                    AND     SYSDATE BETWEEN FEC_DESDE AND NVL(FEC_HASTA,SYSDATE);
                END IF;

            EXCEPTION
            WHEN OTHERS THEN
                pvCodValor      := 'FALSE';
                pvErrorAplic        := '4';
                pvErrorGlosa    := 'problemas al cerrar limite actual';
                pvErrorOra          := TO_CHAR(SQLCODE);
                pvErrorOraGlosa := SQLERRM;
                RAISE ERROR_PROCESO;
            END;

            IF pvCodValor != 'TRUE' THEN
                RAISE ERROR_PROCESO;
            END IF;

            BEGIN
                pvTrace:='GA_LIMITE_CLIABO_TO3.2'; --PAGC
                SELECT  'S' INTO YA_EXISTE
                FROM    GA_LIMITE_CLIABO_TO
                WHERE   cod_cliente = nCodCliHist
                AND     NUM_ABONADO = nNumAbonadoHist
                AND     SYSDATE BETWEEN FEC_DESDE AND NVL(FEC_HASTA,SYSDATE)
                AND     COD_LIMCONS = pvLcNuevo;

            EXCEPTION
            WHEN NO_DATA_FOUND THEN
              YA_EXISTE:='N';
            END;

            IF pvErrorAplic='5' THEN  YA_EXISTE:='N'; END IF; --Producto de un traspaso de abonado que implica la baja del abonado original
        ELSE
            YA_EXISTE := 'N';
        END IF;

    Else
        BEGIN

            YA_EXISTE := 'N';
            SELECT  'S' INTO YA_EXISTE
            FROM    GA_LIMITE_CLIABO_TO
            WHERE   cod_cliente = nCodCliHist
            AND     NUM_ABONADO = nNumAbonadoHist
            AND     FEC_DESDE = vFecDesdeNuevo
            AND     COD_LIMCONS = pvLcNuevo;

        EXCEPTION
        WHEN NO_DATA_FOUND THEN
            BEGIN

            SELECT  vFecDesdeNuevo - (1/(24*60*60)) INTO vFecDesdeNuevo FROM DUAL;

            Update  GA_LIMITE_CLIABO_TO SET
                    FEC_HASTA   = TO_DATE(to_char(vFecDesdeNuevo,'DD/MM/YY HH24:MI:SS'),'DD/MM/YY HH24:MI:SS')
            WHERE   cod_cliente = nCodCliente
            AND     NUM_ABONADO = nNumAbonado
            AND     SYSDATE BETWEEN FEC_DESDE AND NVL(FEC_HASTA,SYSDATE);
            vModIFca        := 'TRUE';

            EXCEPTION
            WHEN OTHERS THEN
                pvCodValor      := 'FALSE';
                pvErrorAplic      := '4';
                pvErrorGlosa  := 'problemas al cerrar limite actual';
                pvErrorOra    := TO_CHAR(SQLCODE);
                pvErrorOraGlosa := SQLERRM;
                RAISE ERROR_PROCESO;
            END;
        WHEN OTHERS THEN
            pvTrace:='GA_LIMITE_CLIABO_TO PASO 6;'||to_char(nCodCliente)||';'||to_char(nNumAbonado); --PAGC
            pvCodValor := 'FALSE';
            pvErrorAplic := '4';
            pvErrorGlosa := 'Problemas al buscar nuevo periodo de LC';
            pvErrorOra := TO_CHAR(SQLCODE);
            pvErrorOraGlosa := SQLERRM;
            RAISE ERROR_PROCESO;
        END;
    END IF;

    IF YA_EXISTE = 'N' THEN
        IF nCantAbonados = 0 OR vModIFca = 'TRUE' THEN
            BEGIN
                BEGIN
                    SELECT fec_desde
                    INTO    vFecDesdeProximo
                    FROM    GA_LIMITE_CLIABO_TO
                    WHERE   FEC_DESDE > SYSDATE
                    AND     COD_CLIENTE = nCodCliente
                    AND     NUM_ABONADO = nNumAbonado;
                EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    vFecDesdeProximo:=NULL;
                WHEN OTHERS THEN
                    pvCodValor      := 'FALSE';
                    pvErrorAplic        := '4';
                    pvErrorGlosa    := 'Problemas al borrar el limite antiguo';
                    pvErrorOra      := TO_CHAR(SQLCODE);
                    pvErrorOraGlosa := SQLERRM;
                    RAISE ERROR_PROCESO;
                END;

                IF vFecDesdeProximo Is Not Null THEN

                    BEGIN
                        DELETE FROM GA_LIMITE_CLIABO_TO
                        WHERE   cod_cliente = nCodCliente
                        AND     NUM_ABONADO = nNumAbonado
                        AND     FEC_DESDE=vFecDesdeProximo;

                    EXCEPTION
                    WHEN OTHERS THEN
                        pvCodValor      := 'FALSE';
                        pvErrorAplic        := '4';
                        pvErrorGlosa    := 'Problemas al borrar el limite antiguo';
                        pvErrorOra      := TO_CHAR(SQLCODE);
                        pvErrorOraGlosa := SQLERRM;
                        RAISE ERROR_PROCESO;
                    END;

                END IF;


                vFecDesdeNuevo:=vFecDesdeNuevo_AUX;

                INSERT INTO GA_LIMITE_CLIABO_TO (COD_CLIENTE, NUM_ABONADO, COD_LIMCONS,FEC_DESDE, FEC_HASTA,NOM_USUARORA,FEC_ASIGNACION,COD_PLANTARIF)
                Values (nCodCliente,   nNumAbonado, vCodLimconsNuevo,TO_DATE (to_char(vFecDesdeNuevo,'DD/MM/YY HH24:MI:SS'),'DD/MM/YY HH24:MI:SS'), vFecHastaNuevo,USER, SYSDATE,vCodPlantarIF);

                pvCodValor    := 'TRUE';
                pvErrorAplic  := '0';
                pvErrorGlosa  := ' ';
                pvErrorOra    := '0';
                pvErrorOraGlosa := ' ';

            EXCEPTION
            WHEN OTHERS THEN
                pvCodValor          := 'FALSE';
                pvErrorAplic        := '4';
                pvErrorGlosa        := 'problemas al insertar el nuevo limite';
                pvErrorOra          := TO_CHAR(SQLCODE);
                pvErrorOraGlosa     := SQLERRM;
                RAISE ERROR_PROCESO;
            END;
        END IF;

        IF pvTipSujeto = 'A' OR pvTipSujeto = 'AL' THEN
            BEGIN
                IF vFecDesdeNuevo <= (SYSDATE + 1 / 86400) THEN
                    Update  GA_ABOCEL
                    Set     COD_LIMCONSUMO = vCodLimconsNuevo
                    WHERE   NUM_ABONADO = nNumAbonado;
                Else
                    BEGIN
                        SELECT cod_ciclo
                        INTO v_cod_ciclo
                        FROM GA_ABOCEL
                        WHERE num_abonado = nNumAbonado;

                        SELECT FEC_hastallam + (1/64000) , cod_ciclfact
                        INTO V_fec_desdeciclo, V_coc_ciclfact
                        FROM FA_CICLFACT
                        WHERE COD_CICLO = v_cod_ciclo
                        AND SYSDATE BETWEEN fec_desdellam AND fec_hastallam;

                        INSERT INTO ga_finciclo
                        (COD_CLIENTE, NUM_ABONADO, COD_CICLFACT, COD_PRODUCTO, TIP_PLANTARIF, COD_PLANTARIF, FEC_DESDELLAM, NUM_DIAS)
                        VALUES (nCodCliente, pnSujeto, V_coc_ciclfact, 1, 'I', -1,V_fec_desdeciclo,1);
                    EXCEPTION WHEN NO_DATA_FOUND THEN
                        pvCodValor          := 'FALSE';
                        pvErrorAplic        := '4';
                        pvErrorGlosa        := 'problemas al insertar registro en ga_finciclo';
                        pvErrorOra          := TO_CHAR(SQLCODE);
                        pvErrorOraGlosa     := SQLERRM;
                        RAISE ERROR_PROCESO;
                    END;
                END IF;
            EXCEPTION
            WHEN OTHERS THEN
                pvCodValor          := 'FALSE';
                pvErrorAplic        := '4';
                pvErrorGlosa        := 'problemas al actualizar el nuevo limite';
                pvErrorOra          := TO_CHAR(SQLCODE);
                pvErrorOraGlosa := SQLERRM;
                RAISE ERROR_PROCESO;
            END;
        END IF;

        IF pvTipSujeto = 'C' THEN
            BEGIN
                IF vFecDesdeNuevo < SYSDATE THEN
                    UPDATE GA_ABOCEL SET
                    COD_LIMCONSUMO = vCodLimconsNuevo
                    WHERE COD_CLIENTE = nCodCliente;
                END IF;
            EXCEPTION
            WHEN OTHERS THEN
                pvCodValor := 'FALSE';
                pvErrorAplic := '4';
                pvErrorGlosa := 'problemas al actualizar el nuevo limite';
                pvErrorOra := TO_CHAR(SQLCODE);
                pvErrorOraGlosa := SQLERRM;
                RAISE ERROR_PROCESO;
            END;
        END IF;

        IF pvTipSujeto = 'CL' THEN
            BEGIN
                PV_LIMITE_INTARCEL_PR (pnSujeto,pvLcNuevo,pvFecDesde,pvErrorOra,pvErrorOraGlosa,pvErrorAplic);
                IF nCodRetorno > 0 THEN
                    pvCodValor      := 'FALSE';
                    pvErrorAplic    := '4';
                    pvErrorGlosa    := SUBSTR(pvErrorOraGlosa,1,60);
                    RAISE ERROR_PROCESO;
                END IF;

            EXCEPTION
            WHEN OTHERS THEN
                pvCodValor      := 'FALSE';
                pvErrorAplic    := '4';
                pvErrorGlosa    := 'problemas al actualizar el nuevo limite Cliente';
                pvErrorOra      := TO_CHAR(SQLCODE);
                pvErrorOraGlosa := SQLERRM;
                RAISE ERROR_PROCESO;
            END;

        END IF;
    Else
        IF EVTipoMovimiento IN ('EI','EE') THEN
            UPDATE  GA_LIMITE_CLIABO_TO SET
                    cod_limcons = vCodLimconsNuevo
            WHERE   cod_cliente = nCodCliHist
            AND     NUM_ABONADO = 0
            AND     FEC_DESDE = vFecDesdeNuevo;
        Else
            Update  GA_LIMITE_CLIABO_TO
            Set     cod_limcons = vCodLimconsNuevo
            WHERE   cod_cliente = nCodCliente
            AND     NUM_ABONADO = nNumAbonado
            AND     FEC_DESDE = vFecDesdeNuevo;
        END IF;
    END IF;

    IF pvTipSujeto = 'A' THEN
        IF ge_log_pg.debug_activo THEN
            ge_log_pg.DEBUG( 'pv_limite_consumo_pg - vFecDesdeNuevo:'||vFecDesdeNuevo);
        END IF;

        IF TO_DATE(vFecDesdeNuevo,'DD-MM-YY HH24:MI:SS')  > SYSDATE THEN
            IF ge_log_pg.debug_activo THEN
                ge_log_pg.DEBUG( 'pv_limite_consumo_pg - P_LIMITE_CONSUMO_CICLO:');
            END IF;
            P_LIMITE_CONSUMO_CICLO(1,nCodCliente, nNumAbonado, vCodLimconsNuevo,SYSDATE ,VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);

            IF V_ERROR > 0 THEN
                pvCodValor := 'FALSE';
                pvErrorAplic := '4';
                pvErrorGlosa := SUBSTR(vDesCadena,1,60);
                pvErrorOra := TO_CHAR(SQLCODE);
                pvErrorOraGlosa := SUBSTR(SQLERRM,1,60);
                RAISE ERROR_PROCESO;
            END IF;
        Else
            IF ge_log_pg.debug_activo THEN
                ge_log_pg.DEBUG( 'pv_limite_consumo_pg - P_INTERFASES_ABONADOS(CL)');
            END IF;

            SELECT GA_SEQ_TRANSACABO.NEXTVAL
            INTO nNumTransaccion
            FROM DUAL;

            pvTrace:='P_INTERFASES_ABONADOS'; --PAGC
            P_INTERFASES_ABONADOS(nNumTransaccion,'CL','1',nNumAbonado,vCodLimconsNuevo,NULL,NULL);

            SELECT  COD_RETORNO, DES_CADENA
            INTO    nCodRetorno, vDesCadena
            FROM    GA_TRANSACABO
            WHERE   NUM_TRANSACCION = nNumTransaccion;

            IF nCodRetorno > 0 THEN
                pvCodValor      := 'FALSE';
                pvErrorAplic        := '4';
                pvErrorGlosa        := SUBSTR(vDesCadena,1,60);
                pvErrorOra          := TO_CHAR(SQLCODE);
                pvErrorOraGlosa := SUBSTR(SQLERRM,1,60);
                RAISE ERROR_PROCESO;
            END IF;
        END IF;
    Else
        IF pvTipSujeto = 'AL' THEN
            P_LIMITE_CONSUMO(1,nCodCliente, pnSujeto, vCodLimconsNuevo,vFecDesdeNuevo ,VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);
            IF V_ERROR > 0 THEN
                pvCodValor := 'FALSE';
                pvErrorAplic := '4';
                pvErrorGlosa := SUBSTR(vDesCadena,1,60);
                pvErrorOra := TO_CHAR(SQLCODE);
                pvErrorOraGlosa := SUBSTR(SQLERRM,1,60);
                RAISE ERROR_PROCESO;
            END IF;
        END IF;
    END IF;

    IF pvTipSujeto = 'AL' THEN
        BEGIN

        INSERT INTO GA_MODABOCEL(NUM_ABONADO,COD_TIPMODI,FEC_MODIFICA,NOM_USUARORA,COD_LIMCONSUMO)
        VALUES (nNumAbonado,'IA',SYSDATE,USER, vCodLimConsActual);

        EXCEPTION
        WHEN OTHERS THEN
            pvCodValor := 'FALSE';
            pvErrorAplic := '4';
            pvErrorGlosa := 'Problemas al insertar modIFicaciones del Abonado';
            pvErrorOra := TO_CHAR(SQLCODE);
            pvErrorOraGlosa := SUBSTR(SQLERRM,1,60);
            RAISE ERROR_PROCESO;
        END;

    ELSIF pvTipSujeto = 'CL' THEN
        BEGIN
            INSERT INTO GA_MODCLI(COD_CLIENTE,COD_TIPMODI,FEC_MODIFICA,NOM_USUARORA,COD_LIMCONSUMO)
            VALUES (nCodCliente,'IC',SYSDATE,USER, vCodLimConsActual);
        EXCEPTION
        WHEN OTHERS THEN
            pvCodValor := 'FALSE';
            pvErrorAplic := '4';
            pvErrorGlosa := 'Problemas al insertar modIFicaciones del Cliente';
            pvErrorOra := TO_CHAR(SQLCODE);
            pvErrorOraGlosa := SUBSTR(SQLERRM,1,60);
        END;
    END IF;

    IF pvCodValor = 'TRUE' THEN
        pvErrorAplic    := '0';
        pvErrorGlosa    := 'OK';
        pvErrorOra      := '0';
        pvErrorOraGlosa := 'OK';
        pvTrace         := 'OK';
    END IF;


EXCEPTION
WHEN ERROR_PROCESO THEN
    DBMS_OUTPUT.PUT_LINE('FIN DEL PROCESO DE MODIFICACION DE LIMITE DE CONSUMO');
WHEN OTHERS THEN
    pvCodValor:='FALSE';
    pvErrorAplic:='4';
    pvErrorGlosa:='Error de Aplicación';
    pvErrorOra:= SUBSTR(SQLCODE,1,50);
    pvErrorOraGlosa:= SUBSTR(SQLERRM,1,255);
    pvTrace:= 'PV_MODIFICA_LC_PR-' || pvTrace;
END PV_MODIFICA_LC_PR;

PROCEDURE PV_LC_HISTORICO_PR   (pnSujeto        IN NUMBER,
                                pvTipSujeto     IN VARCHAR2,
                                pvCodLimCons    IN VARCHAR2,
                                pvFecDesde      IN VARCHAR2,
                                pvCausaHist     IN VARCHAR2,
                                pvCodValor      OUT NOCOPY VARCHAR2,
                                pvErrorAplic    OUT NOCOPY VARCHAR2,
                                pvErrorGlosa    OUT NOCOPY VARCHAR2,
                                pvErrorOra      OUT NOCOPY VARCHAR2,
                                pvErrorOraGlosa OUT NOCOPY VARCHAR2,
                                pvTrace         OUT NOCOPY VARCHAR2)
IS

nCodCliente     GE_CLIENTES.COD_CLIENTE%TYPE;
nNumAbonado     GA_ABOCEL.NUM_ABONADO%TYPE;
vCodPlantarIF   TA_PLANTARIF.COD_PLANTARIF%TYPE;
pvabonado       GA_ABOCEL.NUM_ABONADO%TYPE;
pv_cliente      GA_ABOCEL.NUM_ABONADO%TYPE;
vFormatoSel2    GED_PARAMETROS.VAL_PARAMETRO%TYPE;
vFormatoSel7    GED_PARAMETROS.VAL_PARAMETRO%TYPE;
nNumAbonadoOrig GA_ABOCEL.NUM_ABONADO%TYPE;
nNumAboAux      GA_ABOCEL.NUM_ABONADO%TYPE;
ERROR_PROCESO   EXCEPTION;

BEGIN
    pvCodValor      := 'TRUE';
    pvErrorAplic    := '0';
    pvErrorGlosa    := ' ';
    pvErrorOra      := '0';
    pvErrorOraGlosa := ' ';
    nNumAbonadoOrig := 0;

    IF GE_FN_DEVVALPARAM('GE', 1, 'IND_TOL') = 'N'  THEN
        pvCodValor := 'TRUE';
        RAISE ERROR_PROCESO;
    END IF;

    pvTrace := '('||pnSujeto||','||pvTipSujeto||','||pvCodLimCons||','||pvFecDesde||','||pvCausaHist||')';
    vFormatoSel2 := ge_fn_devvalparam('GE', 1, 'FORMATO_SEL2');
    vFormatoSel7 := ge_fn_devvalparam('GE', 1, 'FORMATO_SEL7');
    IF pvTipSujeto = 'C' OR pvTipSujeto = 'CL' THEN
        nCodCliente := pnSujeto;
        SELECT  a.COD_PLANTARIF
        INTO    vCodPlantarIF
        FROM    GA_EMPRESA A, GE_CLIENTES B, TA_PLANTARIF C
        WHERE   b.cod_cliente = nCodCliente
        AND     b.COD_CLIENTE = a.COD_CLIENTE
        AND     a.COD_PLANTARIF = C.COD_PLANTARIF
        AND     a.COD_PRODUCTO = C.COD_PRODUCTO
        AND     a.COD_PRODUCTO = 1;

        -- Buscamos abonado que fue traspasado para pasarlo a Historico --
        BEGIN
            SELECT  NUM_ABONADO
            INTO    nNumAboAux
            FROM    GA_REASIGNA_CLI_TO
            WHERE   COD_CLIENTE_ORIG = nCodCliente
            AND     FEC_REASIGNA     = (SELECT MAX(FEC_REASIGNA)
                                        FROM GA_REASIGNA_CLI_TO
                                        WHERE COD_CLIENTE_ORIG = nCodCliente);
        EXCEPTION
        WHEN NO_DATA_FOUND THEN
            BEGIN
                SELECT  NUM_ABONADOANT
                INTO    nNumAbonadoOrig
                FROM    GA_TRASPABO
                WHERE   COD_CLIENANT = nCodCliente
                AND     NUM_ABONADO  <> NUM_ABONADOANT
                AND     FEC_MODIFICA = (SELECT MAX(FEC_MODIFICA)
                                        FROM GA_TRASPABO
                                        WHERE COD_CLIENANT = nCodCliente
                                        AND NUM_ABONADO  <> NUM_ABONADOANT);
            EXCEPTION
            WHEN NO_DATA_FOUND THEN
                nNumAboAux    := 0;
            END;
        END;

        -- En caso de no encontrar registro en GA_TRASPABO damos el abonado encontrado como destino --
        IF nNumAbonadoOrig = 0 THEN
            nNumAbonadoOrig := nNumAboAux;
        END IF;

        -- Buscamos Abonado correspondiente a Cliente Origen --
        BEGIN
            SELECT  NUM_ABONADO
            INTO    nNumAbonado
            FROM    GA_LIMITE_CLIABO_TO A
            WHERE   a.cod_cliente = nCodCliente
            AND     a.NUM_ABONADO = 0
            AND     a.FEC_HASTA   IS NULL;
        EXCEPTION
        WHEN NO_DATA_FOUND THEN
            nNumAbonado := nNumAbonadoOrig;
        END;

    ELSIF pvTipSujeto = 'A' OR pvTipSujeto = 'AL'  THEN
        nNumAbonado := pnSujeto;

        SELECT  COD_CLIENTE, COD_PLANTARIF
        INTO    nCodCliente, vCodPlantarIF
        FROM    GA_ABOCEL
        WHERE   NUM_ABONADO = nNumAbonado;

        PV_CLI_ABO_ORIGINAL_PR(pnSujeto,pvabonado,pv_cliente,pvCodValor,pvErrorAplic,pvErrorGlosa,pvErrorOra,pvErrorOraGlosa,pvTrace);

        IF pvCodValor = 'FALSE' THEN
            RAISE ERROR_PROCESO;
        Else
            nCodCliente:= pv_cliente;
            nNumAbonado:= pvabonado;
        END IF;
    END IF;

    IF pvCodLimCons = ' ' OR pvCodLimCons IS NULL OR pvCodLimCons ='*' THEN
        dbms_output.put_line('INSERT EN CLIABO_TH');
        BEGIN
            INSERT INTO GA_LIMITE_CLIABO_TH
            (COD_CLIENTE,NUM_ABONADO,COD_LIMCONS,COD_PLANTARIF,FEC_DESDE, FEC_HASTA,FEC_HISTORICO,NOM_USUARORA,FEC_ASIGNACION,COD_CAUSA_HIST,EST_APLICA_TOL,FEC_APLICA_TOL)
            SELECT  COD_CLIENTE, NUM_ABONADO,COD_LIMCONS,vCodPlantarIF,FEC_DESDE,FEC_HASTA,SYSDATE,USER,SYSDATE,pvCausaHist,EST_APLICA_TOL,FEC_APLICA_TOL
            FROM    GA_LIMITE_CLIABO_TO
            WHERE   cod_cliente = nCodCliente
            AND     NUM_ABONADO = nNumAbonado
            AND     SYSDATE BETWEEN FEC_DESDE AND NVL(FEC_HASTA, SYSDATE);

        EXCEPTION
        WHEN NO_DATA_FOUND THEN
            pvCodValor   := 'TRUE';
            pvErrorAplic := '0';
        WHEN OTHERS THEN
            pvCodValor    := 'FALSE';
            pvErrorAplic  := '4';
            pvErrorGlosa  := 'Problemas al traspasar el limite a historico1';
            pvErrorOra    := TO_CHAR(SQLCODE);
            pvErrorOraGlosa := SQLERRM;
            RAISE ERROR_PROCESO;
        END;


        BEGIN
            DELETE FROM GA_LIMITE_CLIABO_TO
            WHERE   cod_cliente = nCodCliente
            AND     NUM_ABONADO = nNumAbonado
            AND     SYSDATE BETWEEN FEC_DESDE AND NVL(FEC_HASTA, SYSDATE);

        EXCEPTION
        WHEN OTHERS THEN
            pvCodValor      := 'FALSE';
            pvErrorAplic        := '4';
            pvErrorGlosa    := 'Problemas al borrar el limite antiguo';
            pvErrorOra      := TO_CHAR(SQLCODE);
            pvErrorOraGlosa := SQLERRM;
            RAISE ERROR_PROCESO;
        END;

    Else

        BEGIN
        INSERT INTO GA_LIMITE_CLIABO_TH
        (COD_CLIENTE,NUM_ABONADO,COD_LIMCONS,COD_PLANTARIF,FEC_DESDE,FEC_HASTA,FEC_HISTORICO,NOM_USUARORA,FEC_ASIGNACION,COD_CAUSA_HIST,EST_APLICA_TOL,FEC_APLICA_TOL)
        SELECT COD_CLIENTE,NUM_ABONADO,COD_LIMCONS,vCodPlantarIF,FEC_DESDE,FEC_HASTA,SYSDATE,USER,SYSDATE,pvCausaHist,EST_APLICA_TOL,FEC_APLICA_TOL
        FROM    GA_LIMITE_CLIABO_TO
        WHERE   cod_cliente = nCodCliente
        AND     NUM_ABONADO = nNumAbonado
        AND     COD_LIMCONS = pvCodLimCons
        AND     FEC_DESDE   = TO_DATE(pvFecDesde, vFormatoSel2||' '||vFormatoSel7);

        EXCEPTION
        WHEN OTHERS THEN
            pvCodValor      := 'FALSE';
            pvErrorAplic    := '4';
            pvErrorGlosa    := 'Problemas al traspasar el limite a historico';
            pvErrorOra      := TO_CHAR(SQLCODE);
            pvErrorOraGlosa := SQLERRM;
            RAISE ERROR_PROCESO;
        END;

        BEGIN

            DELETE FROM GA_LIMITE_CLIABO_TO
            WHERE   cod_cliente = nCodCliente
            AND     NUM_ABONADO = nNumAbonado
            AND     COD_LIMCONS = pvCodLimCons
            AND     FEC_DESDE   = TO_DATE(pvFecDesde, vFormatoSel2||' '||vFormatoSel7);

        EXCEPTION
        WHEN OTHERS THEN
            pvCodValor      := 'FALSE';
            pvErrorAplic    := '4';
            pvErrorGlosa    := 'Problemas al borrar el limite antiguo';
            pvErrorOra      := TO_CHAR(SQLCODE);
            pvErrorOraGlosa := SQLERRM;
            RAISE ERROR_PROCESO;
        END;
    END IF;
    RAISE ERROR_PROCESO;

EXCEPTION
WHEN ERROR_PROCESO  THEN
    DBMS_OUTPUT.PUT_LINE('Fin proceso pv_lc_historico');
END PV_LC_HISTORICO_PR;


PROCEDURE PV_OPERA_LIMITE_PR   (pnSujeto        IN  NUMBER,
                                pvTipSujeto     IN  VARCHAR2,
                                pvFecDesde      IN  VARCHAR2,
                                pvFecHasta      IN  VARCHAR2,
                                pvCodActabo     IN  VARCHAR2,
                                pvCodPlantarIF  IN  VARCHAR2,
                                pvTipMovimiento IN  VARCHAR2,
                                pvCodValor      OUT NOCOPY VARCHAR2,
                                pvErrorAplic    OUT NOCOPY VARCHAR2,
                                pvErrorGlosa    OUT NOCOPY VARCHAR2,
                                pvErrorOra      OUT NOCOPY VARCHAR2,
                                pvErrorOraGlosa OUT NOCOPY VARCHAR2,
                                pvTrace         OUT NOCOPY VARCHAR2
)
IS
dFecDesde           GA_LIMITE_CLIABO_TO.FEC_DESDE%TYPE;
dFecHasta           GA_LIMITE_CLIABO_TO.FEC_HASTA%TYPE;
nCodCliente         GE_CLIENTES.COD_CLIENTE%TYPE;
nNumAbonado         GA_ABOCEL.NUM_ABONADO%TYPE;
vCodPlantarIF       TA_PLANTARIF.COD_PLANTARIF%TYPE;
vFormatoSel2        GED_PARAMETROS.VAL_PARAMETRO%TYPE;
vFormatoSel7        GED_PARAMETROS.VAL_PARAMETRO%TYPE;
vCodLimconsNuevo    GA_LIMITE_CLIABO_TO.COD_LIMCONS%TYPE;
p_abonado           GA_ABOCEL.NUM_ABONADO%TYPE;
vCodLimcons         GA_LIMITE_CLIABO_TO.COD_LIMCONS%TYPE;
LN_cod_clienant     GA_TRASPABO.COD_CLIENANT%TYPE;
LV_LIMCONSUMO_AUX   TOL_LIMITE_TD.IMP_LIMITE%TYPE;
LV_TIPLAN_AUX       TA_PLANTARIF.COD_TIPLAN%TYPE;
LN_NUM_OS           PV_IORSERV.NUM_OS%TYPE;
LV_fECHA            GA_INTARCEL.FEC_DESDE%TYPE;
LV_CICLO            GA_aBOCEL.COD_CICLO%TYPE;
LV_COD_COLOR        GE_CLIENTES.COD_COLOR%TYPE;
LV_COD_SEGMENTO     GE_CLIENTES.COD_SEGMENTO%TYPE;

p_cliente           NUMBER(8);
nCantAbonados       NUMBER(10);
vEstadoIntarcel     VARCHAR2(100);

EXIT_PROCESO        EXCEPTION;

BEGIN

    vFormatoSel2    := ge_fn_devvalparam('GE', 1, 'FORMATO_SEL2');
    vFormatoSel7    := ge_fn_devvalparam('GE', 1, 'FORMATO_SEL7');
    pvCodValor      := 'TRUE';
    pvErrorAplic    := '0';
    pvErrorGlosa    := ' ';
    pvErrorOra      := '0';
    pvErrorOraGlosa := ' ';
    pvTrace         := ' ';
    nCantAbonados   :=0;

    IF GE_FN_DEVVALPARAM('GE', 1, 'IND_TOL') = 'N'  THEN
        pvCodValor := 'TRUE';
        RAISE EXIT_PROCESO;
    END IF;

    IF pvFecDesde = ' ' OR pvFecDesde IS NULL OR pvFecDesde = '*'   THEN
        dFecDesde := SYSDATE;
    Else
        dFecDesde := TO_DATE(pvFecDesde, vFormatoSel2||' '||vFormatoSel7);
    END IF;

    IF pvFecHasta = ' ' OR pvFecHasta IS NULL OR pvFecHasta = '*' THEN
        dFecHasta := NULL;
    Else
        dFecHasta := TO_DATE(pvFecHasta, vFormatoSel2||' '||vFormatoSel7);
    END IF;

    IF pvTipSujeto = 'C' OR pvTipSujeto = 'CL' THEN
        nCodCliente := pnSujeto;
        nNumAbonado := 0;
    ELSIF pvTipSujeto = 'A' OR pvTipSujeto = 'AL' THEN
        nNumAbonado := pnSujeto;
        pvTrace:='GA_ABOCEL'; --PAGC
        SELECT  COD_CLIENTE
        INTO    nCodCliente
        FROM    GA_ABOCEL
        WHERE   NUM_ABONADO = nNumAbonado;
    END IF;

    SELECT COD_COLOR,COD_SEGMENTO
    INTO LV_COD_COLOR, LV_COD_SEGMENTO
    FROM GE_CLIENTES
    WHERE cod_cliente =nCodCliente;



    IF pvCodActabo IN ('TA','TP','RO','AE','T2','R2','A2') THEN
        IF pvTipMovimiento IN ('IE', 'EI')  THEN
            IF pvTipMovimiento = 'IE' THEN
                BEGIN
                    SELECT  COUNT(*)
                    INTO    nCantAbonados
                    FROM    GA_ABOCEL
                    WHERE   COD_SITUACION = 'AAA'
                    AND     COD_CLIENTE = nCodCliente
                    AND     TIP_PLANTARIF ='I'
                    GROUP BY COD_CLIENTE;

                EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    pvCodValor      := 'TRUE';
                    pvErrorAplic    := '0';
                WHEN OTHERS THEN
                    pvCodValor := 'FALSE';
                    pvErrorAplic := '4';
                    pvErrorGlosa := 'Problemas de Acceso ga_abocel ';
                    pvErrorOra := TO_CHAR(SQLCODE);
                    pvErrorOraGlosa := SQLERRM;
                    pvTrace := '*';
                    RAISE EXIT_PROCESO;
                END;


                BEGIN


                    SELECT  COD_LIMCONS
                    INTO    vCodLimconsNuevo
                    FROM    TOL_LIMITE_PLAN_TD
                    WHERE   cod_plantarIF   = pvCodPlantarIF
                    AND     id_subsegmento  = LV_COD_SEGMENTO
                    AND     ind_prioridad    >= LV_COD_COLOR
                    AND     SYSDATE BETWEEN FEC_DESDE  AND     NVL(FEC_HASTA, SYSDATE)
                    AND     ROWNUM <=1
                    ORDER BY COD_LIMCONS ASC;

                    BEGIN
                        SELECT  COD_LIMCONS
                        INTO    vCodLimcons
                        FROM    GA_LIMITE_CLIABO_TO
                        WHERE   cod_cliente = nCodCliente
                        AND     NUM_ABONADO = 0
                        AND     SYSDATE BETWEEN FEC_DESDE AND NVL(FEC_HASTA,SYSDATE);

                    EXCEPTION
                    WHEN NO_DATA_FOUND THEN
                        IF nCantAbonados = 0 THEN
                            PV_MODIFICA_LC_PR (nCodCliente,'C','*','0','*','*',pvCodValor,pvErrorAplic,pvErrorGlosa,pvErrorOra,pvErrorOraGlosa,pvTrace,pvCodPlantarIF,pvTipMovimiento);
                             IF pvCodValor != 'TRUE' THEN
                                RAISE EXIT_PROCESO;
                             end IF;
                        Else
                            PV_MODIFICA_LC_PR (pnSujeto,pvTipSujeto,'*','0','*','*',pvCodValor,pvErrorAplic,pvErrorGlosa,pvErrorOra,pvErrorOraGlosa,pvTrace,pvCodPlantarIF,pvTipMovimiento);
                            IF pvCodValor != 'TRUE' THEN
                                RAISE EXIT_PROCESO;
                            end IF;
                        END IF;
                    END;

                EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    pvCodValor      := 'TRUE';
                    pvErrorAplic    := '0';
                    pvErrorGlosa    := 'No inserta registro ya que el plan no tiene asociado limite de consumo';
                    pvErrorOra      := '0';
                END;

                BEGIN

                    SELECT cod_clienant
                    INTO LN_cod_clienant
                    FROM GA_TRASPABO
                    WHERE NUM_ABONADO = pnSujeto
                    AND cod_cliennue = nCodCliente
                    AND fec_modIFica = (SELECT max(fec_modIFica)
                    FROM GA_TRASPABO
                    WHERE NUM_ABONADO = pnSujeto
                    AND cod_cliennue = nCodCliente);

                    Update GA_LIMITE_CLIABO_TO
                    Set FEC_HASTA = SYSDATE - (1 / (24 * 60 * 60))
                    WHERE NUM_ABONADO = pnSujeto
                    AND cod_cliente = LN_cod_clienant
                    AND SYSDATE BETWEEN FEC_DESDE AND NVL(FEC_HASTA,SYSDATE);

                EXCEPTION
                WHEN OTHERS THEN
                    pvCodValor      := 'FALSE';
                    pvErrorAplic        := '4';
                    pvErrorGlosa    := 'problemas al cerrar limite actual';
                    pvErrorOra          := TO_CHAR(SQLCODE);
                    pvErrorOraGlosa := SQLERRM;
                    RAISE EXIT_PROCESO;
                END;

                IF pvCodValor != 'TRUE' THEN
                    RAISE EXIT_PROCESO;
                end IF;
            Else
                PV_MODIFICA_LC_PR(pnSujeto,pvTipSujeto,'*','0','*','*',pvCodValor,pvErrorAplic,pvErrorGlosa,pvErrorOra,pvErrorOraGlosa,pvTrace,pvCodPlantarIF,pvTipMovimiento);
                IF pvCodValor != 'TRUE' THEN
                    RAISE EXIT_PROCESO;
                END IF;
            END IF;
        ELSIF pvTipMovimiento IN ('EE', 'II', '*', ' ') OR pvTipMovimiento IS NULL THEN
            IF pvCodPlantarIF IS NOT NULL AND pvCodPlantarIF NOT IN (' ', '*') THEN
                SELECT  COD_TIPLAN
                INTO LV_TIPLAN_AUX
                FROM TA_PLANTARIF
                WHERE COD_PLANTARIF = pvCodPlantarIF;

                IF (trim(LV_TIPLAN_AUX)) ='3' THEN
                    BEGIN

                        SELECT B.IMP_LIMITE INTO LV_LIMCONSUMO_AUX
                        FROM TOL_LIMITE_PLAN_TD A, TOL_LIMITE_TD B
                        WHERE B.COD_LIMCONS > '0'
                        AND   a.cod_limcons = B.cod_limcons
                        AND   a.id_subsegmento  = LV_COD_SEGMENTO
                        AND   a.ind_prioridad    >= LV_COD_COLOR
                        AND   SYSDATE BETWEEN a.FEC_DESDE AND a.FEC_HASTA
                        AND   a.COD_PLANTARIF = pvCodPlantarIF
                        AND   ROWNUM <=1;


                    EXCEPTION
                    WHEN NO_DATA_FOUND THEN
                        vCodLimconsNuevo := '*';
                    END;
                Else
                    BEGIN


                        SELECT COD_LIMCONS
                        INTO vCodLimconsNuevo
                        FROM TOL_LIMITE_PLAN_TD
                        WHERE   cod_plantarIF  = pvCodPlantarIF
                        AND     id_subsegmento = LV_COD_SEGMENTO
                        AND     ind_prioridad >= LV_COD_COLOR
                        AND     SYSDATE BETWEEN FEC_DESDE AND NVL(FEC_HASTA, SYSDATE)
                        AND     ROWNUM <=1
                        ORDER BY COD_LIMCONS ASC;


                    EXCEPTION
                    WHEN NO_DATA_FOUND THEN
                        pvCodValor := 'FALSE';
                        pvErrorAplic := '4';
                        pvErrorGlosa := 'no existe limite por default del plan tarIFario '||vCodPlantarIF;
                        pvErrorOra := TO_CHAR(SQLCODE);
                        pvErrorOraGlosa := SQLERRM;
                        pvTrace := 'BuscANDo nuevo Limite de Consumo Actabo:'||pvCodActabo;
                        RAISE EXIT_PROCESO;
                    END;
                END IF;

                pvTrace:='PV_MODIFICA_LC_PR';
                PV_MODIFICA_LC_PR( pnSujeto,pvTipSujeto,vCodLimconsNuevo,'0','*','*',pvCodValor,pvErrorAplic,pvErrorGlosa,pvErrorOra,pvErrorOraGlosa,pvTrace,pvCodPlantarIF,pvTipMovimiento);

                IF pvCodValor != 'TRUE' THEN
                    RAISE EXIT_PROCESO;
                END IF;
            END IF;
        END IF;
    ELSIF pvCodActabo IN ('BA','BF','BH') THEN
        LN_NUM_OS:= 0;
        BEGIN
            SELECT  NUM_OS
            INTO LN_NUM_OS
            FROM PV_PARAM_ABOCEL
            WHERE NUM_ABONADO = pnSujeto
            AND NUM_OS IN ( SELECT  NUM_OS FROM  PV_IORSERV
            WHERE COD_OS  ='10233' AND TRUNC(FECHA_ING) <> TRUNC(FH_EJECUCION));
        EXCEPTION
        WHEN NO_DATA_FOUND THEN
            LN_NUM_OS:= 0;
        END;

        IF LN_NUM_OS = 0 THEN
            IF pvTipSujeto = 'A' OR pvTipSujeto = 'AL'THEN
                Update GA_LIMITE_CLIABO_TO
                Set FEC_HASTA = SYSDATE
                WHERE NUM_ABONADO = pnSujeto
                AND cod_cliente = nCodCliente --- RRG COL 39162
                AND SYSDATE BETWEEN fec_desde AND nvl(fec_hasta,SYSDATE);
            END IF;
        Else
            SELECT  COD_CICLO INTO LV_CICLO FROM GA_ABOCEL
            WHERE NUM_ABONADO =pnSujeto;

            SELECT FEC_DESDELLAM-1/86400
            INTO LV_fECHA
            FROM FA_CICLFACT
            WHERE COD_CICLO = LV_CICLO
            AND SYSDATE BETWEEN FEC_DESDELLAM AND FEC_HASTALLAM;

            IF pvTipSujeto = 'A' OR pvTipSujeto = 'AL'THEN
                Update GA_LIMITE_CLIABO_TO
                Set FEC_HASTA = LV_fECHA
                WHERE NUM_ABONADO = pnSujeto
                AND cod_cliente = nCodCliente --- RRG COL 39162
                AND SYSDATE BETWEEN fec_desde AND nvl(fec_hasta,SYSDATE);
            END IF;
        END IF;
    ELSIF pvCodActabo IN ('PH') THEN
        BEGIN
            UPDATE  GA_LIMITE_CLIABO_TO SET
                    FEC_HASTA = dFecHasta
            WHERE   NUM_ABONADO = pnSujeto
            AND     cod_cliente = nCodCliente
            AND     SYSDATE BETWEEN FEC_DESDE AND NVL(FEC_HASTA,SYSDATE)
            AND     COD_PLANTARIF NOT IN   (SELECT  a.COD_PLANTARIF FROM TA_PLANTARIF A,GA_LIMITE_CLIABO_TO B
                                            WHERE   a.COD_PRODUCTO = 1
                                            AND     a.CLA_PLANTARIF = 'SRV'
                                            AND     b.COD_CLIENTE = nCodCliente
                                            AND     b.NUM_ABONADO = pnSujeto
                                            AND     a.COD_PLANTARIF = B.COD_PLANTARIF);

        EXCEPTION
        WHEN OTHERS THEN
            pvCodValor      := 'FALSE';
            pvErrorAplic        := '4';
            pvErrorGlosa    := 'problemas al cerrar limite actual hibrido CPU';
            pvErrorOra          := TO_CHAR(SQLCODE);
            pvErrorOraGlosa := SQLERRM;
            RAISE EXIT_PROCESO;
        END;
    ELSIF pvCodActabo IN ('PT','PI') AND (pvTipMovimiento IN ('NCT','s',' ', '*') OR pvTipMovimiento IS NULL) THEN
        BEGIN


            SELECT COD_LIMCONS
            INTO vCodLimconsNuevo
            FROM TOL_LIMITE_PLAN_TD
            WHERE cod_plantarIF = pvCodPlantarIF
            AND     id_subsegmento  = LV_COD_SEGMENTO
            AND     ind_prioridad    >= LV_COD_COLOR
            AND SYSDATE BETWEEN FEC_DESDE AND NVL(FEC_HASTA, SYSDATE)
            AND     ROWNUM <=1
            ORDER BY COD_LIMCONS ASC;

        EXCEPTION
        WHEN NO_DATA_FOUND THEN
           vCodLimconsNuevo := '0';
        END;

        SELECT  COD_TIPLAN
        INTO LV_TIPLAN_AUX
        FROM TA_PLANTARIF
        WHERE COD_PLANTARIF = pvCodPlantarIF;

        IF (trim(LV_TIPLAN_AUX)) ='3' THEN
            BEGIN

                SELECT B.IMP_LIMITE INTO LV_LIMCONSUMO_AUX
                FROM TOL_LIMITE_PLAN_TD A, TOL_LIMITE_TD B
                WHERE a.cod_limcons = B.cod_limcons
                AND   B.COD_LIMCONS > '0'
                AND   a.id_subsegmento  = LV_COD_SEGMENTO
                AND   a.ind_prioridad    >= LV_COD_COLOR
                AND   SYSDATE BETWEEN a.FEC_DESDE AND a.FEC_HASTA
                AND   a.COD_PLANTARIF = pvCodPlantarIF
                AND   ROWNUM <=1;


            EXCEPTION
            WHEN NO_DATA_FOUND THEN
                vCodLimconsNuevo := '*';
            END;
        END IF;

        PV_VALIDA_LIMITE_PR(pnSujeto,nCodCliente,pvCodPlantarIF,vEstadoIntarcel);
        IF vEstadoIntarcel = 'FALSE' THEN
            IF pvFecDesde = ' ' OR pvFecDesde IS NULL OR pvFecDesde = '*' THEN
                BEGIN
                    UPDATE  GA_LIMITE_CLIABO_TO
                    SET     FEC_HASTA = SYSDATE - (1 / (24 * 60 * 60))
                    WHERE   NUM_ABONADO = pnSujeto
                    AND     cod_cliente = nCodCliente
                    AND     SYSDATE BETWEEN FEC_DESDE AND NVL(FEC_HASTA,SYSDATE);

                EXCEPTION
                WHEN OTHERS THEN
                    pvCodValor      := 'FALSE';
                    pvErrorAplic        := '4';
                    pvErrorGlosa    := 'problemas al cerrar limite actual';
                    pvErrorOra          := TO_CHAR(SQLCODE);
                    pvErrorOraGlosa := SQLERRM;
                    RAISE EXIT_PROCESO;
                END;
            ELSE

                BEGIN
                    Update GA_LIMITE_CLIABO_TO
                    Set FEC_HASTA = dFecDesde - (1 / (24 * 60 * 60))
                    WHERE NUM_ABONADO = pnSujeto
                    AND cod_cliente = nCodCliente
                    AND    SYSDATE BETWEEN FEC_DESDE AND NVL(FEC_HASTA,SYSDATE);

                EXCEPTION
                WHEN OTHERS THEN
                    pvCodValor      := 'FALSE';
                    pvErrorAplic        := '4';
                    pvErrorGlosa    := 'problemas al cerrar limite actual';
                    pvErrorOra          := TO_CHAR(SQLCODE);
                    pvErrorOraGlosa := SQLERRM;
                    RAISE EXIT_PROCESO;
                END;
            END IF;

            IF vCodLimconsNuevo <> '0' THEN
                IF pvFecDesde = ' ' OR pvFecDesde IS NULL OR pvFecDesde = '*' THEN
                    PV_MODIFICA_LC_PR(pnSujeto,pvTipSujeto,vCodLimconsNuevo,'0','*','*',pvCodValor,pvErrorAplic,pvErrorGlosa,pvErrorOra,pvErrorOraGlosa,pvTrace,pvCodPlantarIF);
                    IF pvCodValor != 'TRUE' THEN
                        RAISE EXIT_PROCESO;
                    END IF;
                ELSE
                    PV_MODIFICA_LC_PR(pnSujeto,pvTipSujeto,vCodLimconsNuevo,'0',dFecDesde,'*',pvCodValor,pvErrorAplic,pvErrorGlosa,pvErrorOra,pvErrorOraGlosa,pvTrace,pvCodPlantarIF);
                    IF pvCodValor != 'TRUE' THEN
                        RAISE EXIT_PROCESO;
                    END IF;
                END IF;
            END IF;
        END IF;
    ELSIF pvCodActabo IN ('PT', 'PI', 'AB','AF','AH') AND (pvTipMovimiento IN ('CTN', 'RNT',' ','*') OR pvTipMovimiento IS NULL) THEN
        BEGIN

            SELECT COD_LIMCONS
            INTO vCodLimconsNuevo
            FROM TOL_LIMITE_PLAN_TD
            WHERE cod_plantarIF = pvCodPlantarIF
            AND   id_subsegmento  = LV_COD_SEGMENTO
            AND   ind_prioridad    >= LV_COD_COLOR
            AND   SYSDATE BETWEEN FEC_DESDE AND NVL(FEC_HASTA, SYSDATE)
            AND   ROWNUM <=1
            ORDER BY COD_LIMCONS ASC;


        EXCEPTION
        WHEN NO_DATA_FOUND THEN
            pvCodValor := 'FALSE';
            pvErrorAplic := '4';
            pvErrorGlosa := 'no existe limite por default del plan tarIFario '||vCodPlantarIF;
            pvErrorOra := TO_CHAR(SQLCODE);
            pvErrorOraGlosa := SQLERRM;
            pvTrace := 'BuscANDo nuevo Limite de Consumo Actabo:'||pvCodActabo;
            RAISE EXIT_PROCESO;
        END;
        PV_VALIDA_LIMITE_PR(pnSujeto,nCodCliente,pvCodPlantarIF,vEstadoIntarcel);
        IF vEstadoIntarcel = 'FALSE' THEN
            IF pvFecDesde = ' ' OR pvFecDesde IS NULL OR pvFecDesde = '*' THEN
                PV_MODIFICA_LC_PR(pnSujeto,pvTipSujeto,vCodLimconsNuevo,'0','*','*',pvCodValor,pvErrorAplic,pvErrorGlosa,pvErrorOra,pvErrorOraGlosa,pvTrace,pvCodPlantarIF,pvTipMovimiento);
                IF pvCodValor != 'TRUE' THEN
                    RAISE EXIT_PROCESO;
                END IF;
            ELSE
                PV_MODIFICA_LC_PR(pnSujeto,pvTipSujeto,vCodLimconsNuevo,'0',dFecDesde,'*',pvCodValor,pvErrorAplic,pvErrorGlosa,pvErrorOra,pvErrorOraGlosa,pvTrace,pvCodPlantarIF,pvTipMovimiento);
                IF pvCodValor != 'TRUE' THEN
                    RAISE EXIT_PROCESO;
                END IF;
            END IF;
        END IF;
    ELSIF pvCodActabo IN ('PI') AND (pvTipMovimiento IN (' ', '*') OR pvTipMovimiento IS NULL) THEN
        PV_MODIFICA_LC_PR(pnSujeto,pvTipSujeto,'*','0',pvFecDesde,pvFecHasta,pvCodValor,pvErrorAplic,pvErrorGlosa,pvErrorOra,pvErrorOraGlosa,pvTrace,pvCodPlantarIF,pvTipMovimiento);
        IF pvCodValor != 'TRUE' THEN
            RAISE EXIT_PROCESO;
        END IF;
    ELSIF pvCodActabo IN ('EC','CT') THEN
        SELECT  COD_TIPLAN
        INTO LV_TIPLAN_AUX
        FROM TA_PLANTARIF
        WHERE COD_PLANTARIF = pvCodPlantarIF;

        IF (trim(LV_TIPLAN_AUX)) ='3' THEN
            BEGIN

                SELECT B.IMP_LIMITE INTO LV_LIMCONSUMO_AUX
                FROM TOL_LIMITE_PLAN_TD A, TOL_LIMITE_TD B
                WHERE a.cod_limcons = B.cod_limcons
                AND   B.COD_LIMCONS > '0'
                AND   a.id_subsegmento  = LV_COD_SEGMENTO
                AND   a.ind_prioridad    >= LV_COD_COLOR
                AND   SYSDATE BETWEEN a.FEC_DESDE AND a.FEC_HASTA
                AND   a.COD_PLANTARIF = pvCodPlantarIF
                AND   ROWNUM <=1;

            EXCEPTION
            WHEN NO_DATA_FOUND THEN
            vCodLimconsNuevo := '*';
            END;
        ELSE
            BEGIN

                SELECT  COD_LIMCONS
                INTO    vCodLimconsNuevo
                FROM    TOL_LIMITE_PLAN_TD
                WHERE   cod_plantarIF = pvCodPlantarIF
                AND     id_subsegmento  = LV_COD_SEGMENTO
                AND     ind_prioridad    >= LV_COD_COLOR
                AND     SYSDATE BETWEEN FEC_DESDE AND NVL(FEC_HASTA, SYSDATE)
                AND     ROWNUM <=1
                ORDER BY COD_LIMCONS ASC;


            EXCEPTION
            WHEN NO_DATA_FOUND THEN
                pvCodValor          := 'FALSE';
                pvErrorAplic        := '4';
                pvErrorGlosa        := 'no existe limite por default del plan tarIFario '||vCodPlantarIF;
                pvErrorOra          := TO_CHAR(SQLCODE);
                pvErrorOraGlosa     := SQLERRM;
                pvTrace             := 'BuscANDo nuevo Limite de Consumo Actabo:'||pvCodActabo;
                RAISE EXIT_PROCESO;
            END;
        END IF;

        PV_MODIFICA_LC_PR(pnSujeto,pvTipSujeto,vCodLimconsNuevo,'0',pvFecDesde,pvFecHasta,pvCodValor,pvErrorAplic,pvErrorGlosa,pvErrorOra,pvErrorOraGlosa,pvTrace,pvCodPlantarIF,pvTipMovimiento);
        IF pvCodValor != 'TRUE' THEN
            RAISE EXIT_PROCESO;
        END IF;
    END IF;

    RAISE EXIT_PROCESO;

EXCEPTION
WHEN EXIT_PROCESO  THEN
    DBMS_OUTPUT.PUT_LINE('FIN PROCESO');
WHEN OTHERS THEN
    pvCodValor      :='FALSE';
    pvErrorAplic    :='4';
    pvErrorGlosa    :='Error de Aplicación';
    pvErrorOra      := SUBSTR(SQLCODE,1,50);
    pvErrorOraGlosa := SUBSTR(SQLERRM,1,255);
    pvTrace         := 'END PV_OPERA_LIMITE_PR-' || pvTrace;
END PV_OPERA_LIMITE_PR;

PROCEDURE PV_CLI_ABO_ORIGINAL_PR   (pnSujeto        IN  NUMBER,
                                    pvabonado       OUT NOCOPY NUMBER,
                                    pv_cliente      OUT NOCOPY  NUMBER,
                                    pvCodValor      OUT NOCOPY VARCHAR2,
                                    pvErrorAplic    OUT NOCOPY VARCHAR2,
                                    pvErrorGlosa    OUT NOCOPY VARCHAR2,
                                    pvErrorOra      OUT NOCOPY VARCHAR2,
                                    pvErrorOraGlosa OUT NOCOPY VARCHAR2,
                                    pvTrace         OUT NOCOPY VARCHAR2)
IS
nCodCliente        GE_CLIENTES.COD_CLIENTE%TYPE;
nCOD_CLINANT       GA_TRASPABO.COD_CLIENANT%TYPE;
sCodSituacion      GA_ABOCEL.COD_SITUACION%TYPE;
dFecModIFica       GA_TRASPABO.FEC_MODIFICA%TYPE;
NCOD_CLIENTE_ORIG  GE_CLIENTES.COD_CLIENTE%TYPE;
NCOD_CLIENANT      GA_TRASPABO.COD_CLIENANT%TYPE;
NNUM_ABONADOANT    GA_TRASPABO.NUM_ABONADOANT%TYPE;
nNumAbonado        GA_ABOCEL.NUM_ABONADO%TYPE;
nNumAbo_ANT        GA_ABOCEL.NUM_ABONADO%TYPE;
dfec_modIFica      GA_MODABOCEL.FEC_MODIFICA%TYPE;
dfec_SYSDATE       GA_MODABOCEL.FEC_MODIFICA%TYPE;
SCOD_TIPMODI       GA_MODABOCEL.COD_TIPMODI%TYPE;
VP_CLIENTE_ANT     GA_TRASPABO.COD_CLIENANT %TYPE;
VP_ABONADO_ANT     GA_TRASPABO.NUM_ABONADOANT%TYPE;
VP_CLIENTE_NUE     GA_TRASPABO.COD_CLIENNUE%TYPE;
VP_ABONADO_NUE     GA_TRASPABO.NUM_ABONADO%TYPE;
vFormatoSel2       GED_PARAMETROS.VAL_PARAMETRO%TYPE;
vFormatoSel7       GED_PARAMETROS.VAL_PARAMETRO%TYPE;
EXIT_PROCESO       EXCEPTION;

BEGIN

    pvCodValor      := 'TRUE';
    pvErrorAplic    := '0';
    pvErrorGlosa    := ' ';
    pvErrorOra      := '0';
    pvErrorOraGlosa := ' ';
    pvTrace         := ' ';

    vFormatoSel2 := GE_FN_DEVVALPARAM('GE', 1, 'FORMATO_SEL2');

    nNumAbonado := pnSujeto;
    dfec_SYSDATE:= to_date(to_char(SYSDATE,vFormatoSel2),vFormatoSel2);

    BEGIN

        SELECT  COD_CLIENTE,COD_SITUACION
        INTO    nCodCliente, sCodSituacion
        FROM    GA_ABOCEL
        WHERE   NUM_ABONADO = nNumAbonado;

    EXCEPTION
    WHEN NO_DATA_FOUND THEN
        pvCodValor      := 'FALSE';
        pvErrorAplic    := '4';
        pvErrorGlosa    := 'No existe abonado en la ga_abocel '||nNumAbonado;
        pvErrorOra      := TO_CHAR(SQLCODE);
        pvErrorOraGlosa := SQLERRM;
        pvTrace         := ' ';
        RAISE EXIT_PROCESO;
    END;

    pvabonado:= nNumAbonado;
    pv_cliente:= nCodCliente;


    IF sCodSituacion IN ('BAP','BAA','ABP') THEN
        pvErrorAplic := '5'; -- ME PERMITE REALIZAR LA INSERCIÓN DEL NUEVO ABONADO EN LA GA_LIMITE_CLIABO_TO
        RAISE EXIT_PROCESO;
    END IF;

    BEGIN

        SELECT MAX(FEC_MODIFICA)
        INTO dFecModIFica
        FROM GA_TRASPABO
        WHERE NUM_ABONADOANT = nNumAbonado
        AND COD_PRODUCTO   = 1;


        SELECT  COD_CLIENANT
        INTO    nCOD_CLINANT
        FROM    GA_TRASPABO
        WHERE   NUM_ABONADOANT    = nNumAbonado
        AND     FEC_MODIFICA      = dFecModIFica
        AND     COD_PRODUCTO      = 1;

        VP_ABONADO_ANT := nNumAbonado;
        VP_CLIENTE_ANT := nCOD_CLINANT;

    EXCEPTION
    WHEN NO_DATA_FOUND THEN
        BEGIN
            SELECT MAX(FEC_MODIFICA)
            INTO dFecModIFica
            FROM GA_TRASPABO
            WHERE NUM_ABONADO = nNumAbonado
            AND COD_PRODUCTO   = 1;

            SELECT  COD_CLIENANT
            INTO    nCOD_CLINANT
            FROM    GA_TRASPABO
            WHERE   NUM_ABONADO = nNumAbonado
            AND     FEC_MODIFICA   = dFecModIFica
            AND     COD_PRODUCTO   = 1;

            VP_ABONADO_ANT := nNumAbonado;
            VP_CLIENTE_ANT := nCOD_CLINANT;

        EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE EXIT_PROCESO;
        END;
    END;

    BEGIN

        SELECT COD_TIPMODI
        INTO SCOD_TIPMODI
        FROM GA_MODABOCEL
        WHERE NUM_ABONADO  =  VP_ABONADO_ANT  AND
        FEC_MODIFICA = ( SELECT MAX(FEC_MODIFICA)
        FROM GA_MODABOCEL
        WHERE NUM_ABONADO  =  VP_ABONADO_ANT );
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
        BEGIN
            SELECT  COD_TIPMODI
            INTO    SCOD_TIPMODI
            FROM    GA_MODCLI
            WHERE   COD_CLIENTE  =  VP_CLIENTE_ANT
            AND     FEC_MODIFICA = (SELECT MAX(FEC_MODIFICA)
            FROM    GA_MODCLI
            WHERE   COD_CLIENTE  =  VP_CLIENTE_ANT);

        EXCEPTION
        WHEN NO_DATA_FOUND THEN
            pvabonado := VP_ABONADO_ANT;
            pv_cliente:= VP_CLIENTE_ANT;
            RAISE EXIT_PROCESO;
        END;

    WHEN OTHERS THEN
        pvCodValor := 'FALSE';
        pvErrorAplic := '4';
        pvErrorGlosa := 'No existe abonado en la ga_modabocel '||nNumAbonado;
        pvErrorOra := TO_CHAR(SQLCODE);
        pvErrorOraGlosa := SQLERRM;
        pvTrace := ' ';
        RAISE EXIT_PROCESO;
    END;

    IF SCOD_TIPMODI NOT IN ('TP','RO','AE','T2','R2','A2','TA') THEN
        RAISE EXIT_PROCESO;
    END IF;


    IF SCOD_TIPMODI IN ('TA') THEN
        BEGIN

            SELECT  COD_CLIENANT
            INTO    nCOD_CLINANT
            FROM    GA_TRASPABO
            WHERE   NUM_ABONADO    = nNumAbonado
            AND     FEC_MODIFICA   = dFecModIFica
            AND     COD_PRODUCTO   = 1;

            VP_ABONADO_ANT := nNumAbo_ANT;
            VP_CLIENTE_ANT := nCOD_CLINANT;

            SELECT COD_CLIENANT, NUM_ABONADOANT, COD_CLIENNUE, NUM_ABONADO
            INTO VP_CLIENTE_ANT, VP_ABONADO_ANT, VP_CLIENTE_NUE, VP_ABONADO_NUE
            FROM GA_TRASPABO
            WHERE  NUM_ABONADOANT = nNumAbo_ANT
            AND    COD_PRODUCTO   = 1
            AND    fec_modIFica = (SELECT MAX(FEC_MODIFICA)
                                   FROM GA_TRASPABO
                                   WHERE NUM_ABONADOANT = nNumAbo_ANT
                                   AND COD_PRODUCTO   = 1);
        EXCEPTION
        WHEN NO_DATA_FOUND  THEN
            pvCodValor     := 'FALSE';
            pvErrorAplic   := '4';
            pvErrorGlosa   := 'No existe abonado en la GA_TRASPABO '||nNumAbonado;
            pvErrorOra     := TO_CHAR(SQLCODE);
            pvErrorOraGlosa:= SQLERRM;
            pvTrace        := ' ';
            RAISE EXIT_PROCESO;
        END;
    ELSE
        BEGIN
            SELECT COD_CLIENANT, NUM_ABONADOANT, COD_CLIENNUE, NUM_ABONADO
            INTO VP_CLIENTE_ANT, VP_ABONADO_ANT, VP_CLIENTE_NUE, VP_ABONADO_NUE
            FROM GA_TRASPABO
            WHERE  NUM_ABONADOANT = nNumAbonado
            AND    COD_PRODUCTO   = 1
            AND    fec_modIFica =  (SELECT MAX(FEC_MODIFICA)
                                    FROM GA_TRASPABO
                                    WHERE NUM_ABONADOANT = nNumAbonado
                                    AND   COD_PRODUCTO   = 1);
        EXCEPTION
        WHEN NO_DATA_FOUND THEN
            pvCodValor     := 'FALSE';
            pvErrorAplic   := '4';
            pvErrorGlosa   := 'No existe abonado en la GA_TRASPABO '||nNumAbonado;
            pvErrorOra     := TO_CHAR(SQLCODE);
            pvErrorOraGlosa:= SQLERRM;
            pvTrace        := ' ';
            RAISE EXIT_PROCESO;
        END;

    END IF;

    pvabonado := VP_ABONADO_ANT;
    pv_cliente:= VP_CLIENTE_ANT;


    RAISE EXIT_PROCESO;

EXCEPTION
WHEN EXIT_PROCESO  THEN
    DBMS_OUTPUT.PUT_LINE('FIN PROCESO PV_CLI_ABO_ORIGINAL_PR');

END PV_CLI_ABO_ORIGINAL_PR;

FUNCTION PV_VALIDA_PWD_FN  (pnSujeto    IN NUMBER,
                            pvTipSujeto IN VARCHAR2,
                            pvPasswd    IN VARCHAR2) RETURN VARCHAR2
IS
vClave    GA_CLAVE_TO.CLAVE%TYPE;
vTipClave GA_CLAVE_TO.TIP_CLAVE%TYPE;
BEGIN
    IF pvTipsujeto = 'A' OR pvTipSujeto = 'AL' THEN
        vTipClave := TO_NUMBER(GE_FN_DEVVALPARAM('GA', 1, 'PWD_LCA'));
    ELSIF pvTipsujeto = 'C' OR pvTipSujeto = 'CL' THEN
        vTipClave := TO_NUMBER(GE_FN_DEVVALPARAM('GA', 1, 'PWD_LCC'));
    ELSE
        Return 'FALSE|tipo sujeto '||' '' '||pvTipSujeto||' '' '||' desconocido';
    END IF;

    BEGIN
        SELECT  CLAVE
        INTO    vClave
        FROM    GA_CLAVE_TO
        WHERE   TIP_SUJETO = pvTipSujeto
        AND     SUJETO = pnSujeto
        AND     TIP_CLAVE = vTipClave;

    EXCEPTION
    WHEN NO_DATA_FOUND THEN
        Return 'FALSE|el sujeto '||TO_CHAR(pnSujeto)||' no tiene clave asignada';
    WHEN OTHERS THEN
        Return 'FALSE|'||SQLERRM;
    END;

    IF PV_CRYPT_FN(pvPasswd) = vClave  THEN
        Return 'TRUE';
    Else
        Return 'FALSE|clave invalida';
    END IF;

END PV_VALIDA_PWD_FN;


PROCEDURE pv_cerrarlim_aciclo_ind_pr   (EN_NumAbonado IN                               ga_limite_cliabo_to.num_abonado%TYPE,
                                        EN_CodCliente IN                                ga_limite_cliabo_to.cod_cliente%TYPE,
                                        EV_CodPlanAct IN                                ga_limite_cliabo_to.cod_plantarIF%TYPE,
                                        SV_Estado     OUT NOCOPY                VARCHAR2,
                                        SV_Proc       OUT NOCOPY                VARCHAR2,
                                        SN_CodMsg     OUT NOCOPY                NUMBER,
                                        SN_Evento     OUT NOCOPY                NUMBER,
                                        SV_Tabla      OUT NOCOPY                VARCHAR2,
                                        SV_Act        OUT NOCOPY                VARCHAR2,
                                        SV_Code       OUT NOCOPY                VARCHAR2,
                                        SV_Errm       OUT NOCOPY                VARCHAR2   ) IS
/*
<Documentación TipoDoc = "PROCEDIMIENTO">
    <Elemento Nombre = "PV_CERRARLIM_ACICLO_IND_PR" Lenguaje="PL/SQL" Fecha="09-12-2008" Versión="1.0"
        Diseñador="German Espinoza Zuñiga" Programador="German Espinoza Zuñiga" Ambiente="BD">
        <Retorno>N/A</Retorno>
        <Descripción>Cierra vigencia de limite de consumo actual al corte de ciclo</Descripción>
        <Parámetros>
            <Entrada>
                <param nom="EN_NumAbonado" Tipo="NUMBER">Numero de abonado</param>
                <param nom="EN_CodCliente"     Tipo="NUMBER">Codigo de cliente</param>
                <param nom="EV_CodPlanAct"   Tipo="VARCHAR2">Plan a cerrar vigencia de limite de consumo</param>
            </Entrada>
            <Salida>
                <param nom="SV_Estado"    Tipo="VARCHAR2">Estado de la ejecucion del procedimiento 3: OK-4:ERROR</param>
                <param nom="SV_Proc"        Tipo="VARCHAR2">Nombre del procedo en donde ocurre un evento</param>
                <param nom="SN_CodMsg"   Tipo="NUMBER">Codigo de Mensaje del evento ocurrido</param>
                <param nom="SN_Evento"    Tipo="NUMBER">numero de evento</param>
                <param nom="SV_Tabla"      Tipo="VARCHAR2">Nombre de la tabla en donde ocurrio el evento</param>
                <param nom="SV_Act"         Tipo="VARCHAR2">accion sobre la table en donde ocurre el evento</param>
                <param nom="SV_Code"       Tipo="VARCHAR2">codigo del error oracle</param>
                <param nom="SV_Errm"        Tipo="VARCHAR2">Descripcion del Error Oracle</param>
            </Salida>
        </Parámetros>
    </Elemento>
</Documentación>
*/

LN_CantLimVig    NUMBER;
LN_CantEmp       NUMBER;
LN_EsEmpresa     NUMBER;  --0: no cliente no es empresa 1: cliente es empresa
LD_FecCorteFin   DATE;
LV_DesError      VARCHAR2(1000);
LV_Sql           VARCHAR2(2000);
LV_MensajeError  VARCHAR2(2000);

BEGIN
    SV_Estado       :='3';
    SV_Proc         :='PV_CERRARLIM_ACICLO_IND_PR';
    SN_CodMsg       :=0;
    SN_Evento       :=0;
    SV_Code         :='0';
    SV_Errm         :='0';

    SV_Tabla := 'GA_LIMITE_CLIABO_TO';
    SV_Act    := 'S';

    LV_Sql:=' SELECT COUNT(1) FROM ga_limite_cliabo_to';
    LV_Sql:=LV_Sql || ' WHERE  cod_cliente     = '||EN_CodCliente;
    LV_Sql:=LV_Sql || ' AND      num_abonado = '||EN_NumAbonado;
    LV_Sql:=LV_Sql || ' AND      cod_plantarIF   = '''||EV_CodPlanAct||'''';
    LV_Sql:=LV_Sql || ' AND      SYSDATE BETWEEN fec_desde AND NVL(fec_hasta,SYSDATE)';

    EXECUTE IMMEDIATE  LV_Sql INTO LN_CantLimVig;

    IF LN_CantLimVig > 0 THEN
        SV_Tabla := 'ABOCEL-CICLFACT';
        SV_Act    := 'S';
        LV_Sql:=' SELECT fec_hastallam';
        LV_Sql:=LV_Sql || ' FROM    ga_abocel a,fa_ciclfact b';
        LV_Sql:=LV_Sql || ' WHERE  a.num_abonado = '||EN_NumAbonado;
        LV_Sql:=LV_Sql || ' AND      b.cod_ciclo        = a.cod_ciclo';
        LV_Sql:=LV_Sql || ' AND      SYSDATE BETWEEN fec_desdellam AND fec_hastallam';

        EXECUTE IMMEDIATE  LV_Sql INTO LD_FecCorteFin;

        SV_Tabla := 'GA_LIMITE_CLIABO_TO';
        SV_Act    := 'U';

        LV_Sql:=' UPDATE ga_limite_cliabo_to';
        LV_Sql:=LV_Sql || ' SET       fec_hasta       = TO_DATE('''||TO_CHAR(LD_FecCorteFin,'dd-mm-yyyy hh24:mi:ss')||''',''dd-mm-yyyy hh24:mi:ss'')';
        LV_Sql:=LV_Sql || ' WHERE  cod_cliente     = '||EN_CodCliente;
        LV_Sql:=LV_Sql || ' AND     num_abonado  = '||EN_NumAbonado;
        LV_Sql:=LV_Sql || ' AND     cod_plantarIF    = '''||EV_CodPlanAct||'''';
        LV_Sql:=LV_Sql || ' AND     SYSDATE BETWEEN fec_desde AND NVL(fec_hasta,SYSDATE)';

        EXECUTE IMMEDIATE  LV_Sql;

    END IF;

EXCEPTION
WHEN OTHERS THEN
    SV_Estado   :='4';
    SV_Code     :=SQLCODE;
    SV_Errm     :=SQLERRM;
    SN_CodMsg := 2431;

    IF Not ge_errores_pg.mensajeerror(SN_CodMsg, LV_MensajeError) THEN
        LV_MensajeError := 'Error No ClasIFicado';
    END IF;

    LV_DesError := 'PV_CERRARLIM_ACICLO_IND_PR(' || EN_NumAbonado || ','||EN_CodCliente||','||EV_CodPlanAct||')';
    LV_DesError :=LV_DesError ||'-T:'||SV_Tabla;
    LV_DesError :=LV_DesError ||'('||SV_Act||')';
    LV_DesError :=LV_DesError ||'-'|| SV_Errm;

    SN_Evento := ge_errores_pg.grabarpl( SN_Evento,'PV',LV_MensajeError,'1.0',USER,'PV_CERRARLIM_ACICLO_IND_PR',LV_Sql,SN_CodMsg,LV_DesError);

END pv_cerrarlim_aciclo_ind_pr;

PROCEDURE pv_eliminarlim_aciclo_ind_pr (EN_NumAbonado IN ga_limite_cliabo_to.num_abonado%TYPE,
                                        EN_CodCliente IN ga_limite_cliabo_to.cod_cliente%TYPE,
                                        EV_CodPlanFut IN ga_limite_cliabo_to.cod_plantarIF%TYPE,
                                        SV_Estado     OUT NOCOPY VARCHAR2,
                                        SV_Proc       OUT NOCOPY VARCHAR2,
                                        SN_CodMsg     OUT NOCOPY NUMBER,
                                        SN_Evento     OUT NOCOPY NUMBER,
                                        SV_Tabla      OUT NOCOPY VARCHAR2,
                                        SV_Act        OUT NOCOPY VARCHAR2,
                                        SV_Code       OUT NOCOPY VARCHAR2,
                                        SV_Errm       OUT NOCOPY VARCHAR2   ) IS

/*
<Documentación TipoDoc = "PROCEDIMIENTO">
    <Elemento Nombre = "PV_ELIMINARLIM_ACICLO_IND_PR" Lenguaje="PL/SQL" Fecha="09-12-2008" Versión="1.0"
        Diseñador="German Espinoza Zuñiga" Programador="German Espinoza Zuñiga" Ambiente="BD">
        <Retorno>N/A</Retorno>
        <Descripcion>Elimina y pasa a historico limite de consumo que el abonado tenga al corte de ciclo</Descripcion>
        <Parámetros>
            <Entrada>
                <param nom="EN_NumAbonado" Tipo="NUMBER">Numero de abonado</param>
                <param nom="EN_CodCliente"     Tipo="NUMBER">Codigo de cliente</param>
                <param nom="EV_CodPlanFut"   Tipo="VARCHAR2">Plan a cerrar vigencia de limite de consumo a futuro</param>
            </Entrada>
            <Salida>
                <param nom="SV_Estado"    Tipo="VARCHAR2">Estado de la ejecucion del procedimiento 3: OK-4:ERROR</param>
                <param nom="SV_Proc"        Tipo="VARCHAR2">Nombre del procedo en donde ocurre un evento</param>
                <param nom="SN_CodMsg"   Tipo="NUMBER">Codigo de Mensaje del evento ocurrido</param>
                <param nom="SN_Evento"    Tipo="NUMBER">numero de evento</param>
                <param nom="SV_Tabla"      Tipo="VARCHAR2">Nombre de la tabla en donde ocurrio el evento</param>
                <param nom="SV_Act"         Tipo="VARCHAR2">accion sobre la table en donde ocurre el evento</param>
                <param nom="SV_Code"       Tipo="VARCHAR2">codigo del error oracle</param>
            <param nom="SV_Errm"        Tipo="VARCHAR2">Descripcion del Error Oracle</param>
            </Salida>
        </Parámetros>
    </Elemento>
</Documentación>
*/

LN_CantLimVig    NUMBER;
LV_DesError      VARCHAR2(1000);
LV_Sql           VARCHAR2(2000);
LV_MensajeError  VARCHAR2(2000);

BEGIN
    SV_Estado       :='3';
    SV_Proc         :='PV_ELIMINARLIM_ACICLO_IND_PR';
    SN_CodMsg       :=0;
    SN_Evento       :=0;
    SV_Code         :='0';
    SV_Errm         :='0';

    SV_Tabla := 'GA_LIMITE_CLIABO_TO';
    SV_Act    := 'S';

    LV_Sql:=' SELECT COUNT(1)';
    LV_Sql:=LV_Sql || ' FROM    ga_limite_cliabo_to';
    LV_Sql:=LV_Sql || ' WHERE  cod_cliente     = '||EN_CodCliente;
    LV_Sql:=LV_Sql || ' AND     num_abonado = '||EN_NumAbonado;
    LV_Sql:=LV_Sql || ' AND     cod_plantarIF   = '''||EV_CodPlanFut||'''';
    LV_Sql:=LV_Sql || ' AND     fec_desde>SYSDATE';

    EXECUTE IMMEDIATE  LV_Sql INTO LN_CantLimVig;

    IF LN_CantLimVig > 0 THEN

        SV_Tabla := 'GA_LIMITE_CLIABO_TH';
        SV_Act    := 'I';

        LV_Sql:=               ' INSERT INTO ga_limite_cliabo_th';
        LV_Sql:=LV_Sql || ' (cod_cliente, num_abonado, cod_limcons, cod_plantarIF, fec_desde, fec_historico, fec_hasta, nom_usuarora';
        LV_Sql:=LV_Sql || ' , fec_asignacion, cod_causa_hist, est_aplica_tol, fec_aplica_tol)';
        LV_Sql:=LV_Sql || ' SELECT cod_cliente, num_abonado, cod_limcons, cod_plantarIF, fec_desde,SYSDATE,fec_hasta, nom_usuarora';
        LV_Sql:=LV_Sql || ' , fec_asignacion,''PV_CT'', est_aplica_tol, fec_aplica_tol';
        LV_Sql:=LV_Sql || ' FROM   ga_limite_cliabo_to';
        LV_Sql:=LV_Sql || ' WHERE  cod_cliente     = '||EN_CodCliente;
        LV_Sql:=LV_Sql || ' AND     num_abonado = '||EN_NumAbonado;
        LV_Sql:=LV_Sql || ' AND     cod_plantarIF   = '''||EV_CodPlanFut||'''';
        LV_Sql:=LV_Sql || ' AND     fec_desde>SYSDATE';

        EXECUTE IMMEDIATE  LV_Sql;

        SV_Tabla := 'GA_LIMITE_CLIABO_TO';
        SV_Act    := 'D';

        LV_Sql:=               ' DELETE ga_limite_cliabo_to';
        LV_Sql:=LV_Sql || ' WHERE  cod_cliente     = '||EN_CodCliente;
        LV_Sql:=LV_Sql || ' AND     num_abonado = '||EN_NumAbonado;
        LV_Sql:=LV_Sql || ' AND     cod_plantarIF   = '''||EV_CodPlanFut||'''';
        LV_Sql:=LV_Sql || ' AND     fec_desde>SYSDATE';

        EXECUTE IMMEDIATE  LV_Sql;

    END IF;

EXCEPTION
WHEN OTHERS THEN
    SV_Estado   :='4';
    SV_Code     :=SQLCODE;
    SV_Errm     :=SQLERRM;
    SN_CodMsg := 2432;
    IF Not ge_errores_pg.mensajeerror(SN_CodMsg, LV_MensajeError) THEN
        LV_MensajeError := 'Error No ClasIFicado';
    END IF;
    LV_DesError := 'PV_ELIMINARLIM_ACICLO_IND_PR(' || EN_NumAbonado || ','||EN_CodCliente||','||EV_CodPlanFut||')';
    LV_DesError :=LV_DesError ||'-T:'||SV_Tabla;
    LV_DesError :=LV_DesError ||'('||SV_Act||')';
    LV_DesError :=LV_DesError ||'-'|| SV_Errm;
    SN_Evento := ge_errores_pg.grabarpl( SN_Evento,'PV',LV_MensajeError,'1.0',USER,'PV_ELIMINARLIM_ACICLO_IND_PR',LV_Sql,SN_CodMsg,LV_DesError);
END pv_eliminarlim_aciclo_ind_pr;

PROCEDURE pv_crealim_aciclo_ind_pr (EN_NumAbonado IN ga_limite_cliabo_to.num_abonado%TYPE,
                                    EN_CodCliente IN ga_limite_cliabo_to.cod_cliente%TYPE,
                                    EV_CodPlanFut IN ga_limite_cliabo_to.cod_plantarIF%TYPE,
                                    SV_Estado     OUT NOCOPY VARCHAR2,
                                    SV_Proc       OUT NOCOPY VARCHAR2,
                                    SN_CodMsg     OUT NOCOPY NUMBER,
                                    SN_Evento     OUT NOCOPY NUMBER,
                                    SV_Tabla      OUT NOCOPY VARCHAR2,
                                    SV_Act        OUT NOCOPY VARCHAR2,
                                    SV_Code       OUT NOCOPY VARCHAR2,
                                    SV_Errm       OUT NOCOPY VARCHAR2   ) IS

/*
<Documentación TipoDoc = "PROCEDIMIENTO">
    <Elemento Nombre = "PV_CREALIM_ACICLO_IND_PR" Lenguaje="PL/SQL" Fecha="09-12-2008" Versión="1.0"
        Diseñador="German Espinoza Zuñiga" Programador="German Espinoza Zuñiga" Ambiente="BD">
        <Retorno>N/A</Retorno>
        <Descripcion>Crea limite de consumo al corte de ciclo</Descripcion>
        <Parámetros>
            <Entrada>
                <param nom="EN_NumAbonado" Tipo="NUMBER">Numero de abonado</param>
                <param nom="EN_CodCliente"     Tipo="NUMBER">Codigo de cliente</param>
                <param nom="EV_CodPlanFut"   Tipo="VARCHAR2">Plan a cerrar vigencia de limite de consumo a futuro</param>
            </Entrada>
            <Salida>
                <param nom="SV_Estado"    Tipo="VARCHAR2">Estado de la ejecucion del procedimiento 3: OK-4:ERROR</param>
                <param nom="SV_Proc"        Tipo="VARCHAR2">Nombre del procedo en donde ocurre un evento</param>
                <param nom="SN_CodMsg"   Tipo="NUMBER">Codigo de Mensaje del evento ocurrido</param>
                <param nom="SN_Evento"    Tipo="NUMBER">numero de evento</param>
                <param nom="SV_Tabla"      Tipo="VARCHAR2">Nombre de la tabla en donde ocurrio el evento</param>
                <param nom="SV_Act"         Tipo="VARCHAR2">accion sobre la table en donde ocurre el evento</param>
                <param nom="SV_Code"       Tipo="VARCHAR2">codigo del error oracle</param>
                <param nom="SV_Errm"        Tipo="VARCHAR2">Descripcion del Error Oracle</param>
            </Salida>
        </Parámetros>
    </Elemento>
</Documentación>
*/

LN_CantLimVig    NUMBER;
LD_FecCorteCiclo DATE;
LV_CodLimCons    ga_limite_cliabo_to.cod_limcons%TYPE;
LV_DesError      VARCHAR2(1000);
LV_Sql           VARCHAR2(2000);
LV_MensajeError  VARCHAR2(2000);
LV_COD_COLOR     GE_CLIENTES.COD_COLOR%TYPE;
LV_COD_SEGMENTO  GE_CLIENTES.COD_SEGMENTO%TYPE;

BEGIN
--Valido si el abonado tiene limite de consumo vigente

    SV_Estado       :='3';
    SV_Proc         :='PV_CREALIM_ACICLO_IND_PR';
    SN_CodMsg       :=0;
    SN_Evento       :=0;
    SV_Code         :='0';
    SV_Errm         :='0';

    SV_Tabla := 'TOL_LIMITE_PLAN_TD';
    SV_Act    := 'S';

    SELECT COD_COLOR,COD_SEGMENTO
    INTO LV_COD_COLOR, LV_COD_SEGMENTO
    FROM GE_CLIENTES
    WHERE cod_cliente =EN_CodCliente;


    LV_Sql:=   ' SELECT cod_limcons';
    LV_Sql:=LV_Sql || ' FROM    tol_limite_plan_td';
    LV_Sql:=LV_Sql || ' WHERE   cod_plantarIF  = '''||EV_CodPlanFut||'''';
    LV_Sql:=LV_Sql || ' AND     id_subsegmento = '  || LV_COD_SEGMENTO;
    --LV_Sql:=LV_Sql || ' AND   ind_prioridad >= '''|| LV_COD_COLOR || ''''; --INC 185916 BMR 04-07-2012
    LV_Sql:=LV_Sql || ' AND   ind_prioridad >= to_number('''|| LV_COD_COLOR || ''')';
    LV_Sql:=LV_Sql || ' AND     SYSDATE BETWEEN fec_desde AND NVL(fec_hasta,SYSDATE)';
    LV_Sql:=LV_Sql || ' AND     ROWNUM <=1';
    LV_Sql:=LV_Sql || ' ORDER   BY COD_LIMCONS ASC';


    EXECUTE IMMEDIATE  LV_Sql INTO LV_CodLimCons;

    SV_Tabla := 'ABOCEL-CICLFACT';
    SV_Act    := 'S';

    LV_Sql:=               ' SELECT fec_hastallam+1/86400';
    LV_Sql:=LV_Sql || ' FROM    ga_abocel a,fa_ciclfact b';
    LV_Sql:=LV_Sql || ' WHERE  a.num_abonado = '||EN_NumAbonado;
    LV_Sql:=LV_Sql || ' AND      b.cod_ciclo        = a.cod_ciclo';
    LV_Sql:=LV_Sql || ' AND      SYSDATE BETWEEN fec_desdellam AND fec_hastallam';

    EXECUTE IMMEDIATE  LV_Sql INTO LD_FecCorteCiclo;

    SV_Tabla := 'GA_LIMITE_CLIABO_TO';
    SV_Act    := 'I';

    LV_Sql:=               ' INSERT INTO ga_limite_cliabo_to(num_abonado,cod_cliente,cod_limcons,cod_plantarIF,fec_desde,fec_hasta,fec_asignacion,nom_usuarora)';
    LV_Sql:=LV_Sql || ' VALUES ('||EN_NumAbonado||','||EN_CodCliente||','''||LV_CodLimCons||''','''||EV_CodPlanFut||''',TO_DATE('''||TO_CHAR(LD_FecCorteCiclo,'dd-mm-yyyy hh24:mi:ss')||''',''dd-mm-yyyy hh24:mi:ss''),NULL,SYSDATE,USER)';/*Inicio COL - INC - 72899 - PMY */

    EXECUTE IMMEDIATE  LV_Sql;

EXCEPTION
WHEN OTHERS THEN
    SV_Estado   :='4';
    SV_Code     :=SQLCODE;
    SV_Errm     :=SQLERRM;
    SN_CodMsg := 2433;

    IF Not ge_errores_pg.mensajeerror(SN_CodMsg, LV_MensajeError) THEN
        LV_MensajeError := 'Error No ClasIFicado';
    END IF;

    LV_DesError := 'PV_CREALIM_ACICLO_IND_PR(' || EN_NumAbonado || ','||EN_CodCliente||','||EV_CodPlanFut||')';
    LV_DesError :=LV_DesError ||'-T:'||SV_Tabla;
    LV_DesError :=LV_DesError ||'('||SV_Act||')';
    LV_DesError :=LV_DesError ||'-'|| SV_Errm;

    SN_Evento := ge_errores_pg.GRABARPL( SN_Evento,'PV',LV_MensajeError,'1.0',USER,'PV_CREALIM_ACICLO_IND_PR',LV_Sql,SN_CodMsg,LV_DesError);

END pv_crealim_aciclo_ind_pr;

PROCEDURE pv_cerrarlim_linea_ind_pr(EN_NumAbonado IN ga_limite_cliabo_to.num_abonado%TYPE,
                                    EN_CodCliente IN ga_limite_cliabo_to.cod_cliente%TYPE,
                                    EV_CodPlanAct IN ga_limite_cliabo_to.cod_plantarIF%TYPE,
                                    ED_FecHasta   IN DATE,
                                    SV_Estado     OUT NOCOPY VARCHAR2,
                                    SV_Proc       OUT NOCOPY VARCHAR2,
                                    SN_CodMsg     OUT NOCOPY NUMBER,
                                    SN_Evento     OUT NOCOPY NUMBER,
                                    SV_Tabla      OUT NOCOPY VARCHAR2,
                                    SV_Act        OUT NOCOPY VARCHAR2,
                                    SV_Code       OUT NOCOPY VARCHAR2,
                                    SV_Errm       OUT NOCOPY VARCHAR2   ) IS

/*
<Documentación TipoDoc = "PROCEDIMIENTO">
    <Elemento Nombre = "PV_CERRARLIM_LINEA_IND_PR" Lenguaje="PL/SQL" Fecha="09-12-2008" Versión="1.0"
        Diseñador="German Espinoza Zuñiga" Programador="German Espinoza Zuñiga" Ambiente="BD">
        <Retorno>N/A</Retorno>
        <Descripcion>Cierra vigencia de limite de consumo que el abonado en linea</Descripcion>
        <Parámetros>
            <Entrada>
                <param nom="EN_NumAbonado" Tipo="NUMBER">Numero de abonado</param>
                <param nom="EN_CodCliente"     Tipo="NUMBER">Codigo de cliente</param>
                <param nom="EV_CodPlanAct"   Tipo="VARCHAR2">Plan a cerrar vigencia de limite de consumo en linea</param>
            </Entrada>
            <Salida>
                <param nom="SV_Estado"    Tipo="VARCHAR2">Estado de la ejecucion del procedimiento 3: OK-4:ERROR</param>
                <param nom="SV_Proc"        Tipo="VARCHAR2">Nombre del procedo en donde ocurre un evento</param>
                <param nom="SN_CodMsg"   Tipo="NUMBER">Codigo de Mensaje del evento ocurrido</param>
                <param nom="SN_Evento"    Tipo="NUMBER">numero de evento</param>
                <param nom="SV_Tabla"      Tipo="VARCHAR2">Nombre de la tabla en donde ocurrio el evento</param>
                <param nom="SV_Act"         Tipo="VARCHAR2">accion sobre la table en donde ocurre el evento</param>
                <param nom="SV_Code"       Tipo="VARCHAR2">codigo del error oracle</param>
                <param nom="SV_Errm"        Tipo="VARCHAR2">Descripcion del Error Oracle</param>
            </Salida>
        </Parámetros>
    </Elemento>
</Documentación>
*/

LV_DesError      VARCHAR2(1000);
LV_Sql           VARCHAR2(2000);
LV_MensajeError  VARCHAR2(2000);
LN_CantLimVig    NUMBER;

BEGIN

    SV_Estado       :='3';
    SV_Proc         :='PV_CERRARLIM_LINEA_IND_PR';
    SN_CodMsg       :=0;
    SN_Evento       :=0;
    SV_Code         :='0';
    SV_Errm         :='0';

    SV_Tabla := 'GA_LIMITE_CLIABO_TO';
    SV_Act    := 'S';

    LV_Sql:=               ' SELECT COUNT(1)';
    LV_Sql:=LV_Sql || ' FROM    ga_limite_cliabo_to';
    LV_Sql:=LV_Sql || ' WHERE  cod_cliente     = '||EN_CodCliente;
    LV_Sql:=LV_Sql || ' AND     num_abonado = '||EN_NumAbonado;
    LV_Sql:=LV_Sql || ' AND     cod_plantarIF   = '''||EV_CodPlanAct||'''';
    LV_Sql:=LV_Sql || ' AND     SYSDATE BETWEEN fec_desde AND NVL(fec_hasta,SYSDATE)';

    EXECUTE IMMEDIATE  LV_Sql INTO LN_CantLimVig;

    IF LN_CantLimVig > 0 THEN

        SV_Tabla := 'GA_LIMITE_CLIABO_TO';
        SV_Act    := 'U';

        LV_Sql:=               ' UPDATE ga_limite_cliabo_to';
        LV_Sql:=LV_Sql || ' SET  fec_hasta =TO_DATE('''|| TO_CHAR(ED_FecHasta,'dd-mm-yyyy hh24:mi:ss') ||  ''',''dd-mm-yyyy hh24:mi:ss'')-1/86400 ' ;
        LV_Sql:=LV_Sql || ' WHERE  cod_cliente     = '||EN_CodCliente;
        LV_Sql:=LV_Sql || ' AND     num_abonado = '||EN_NumAbonado;
        LV_Sql:=LV_Sql || ' AND     cod_plantarIF   = '''||EV_CodPlanAct||'''';
        LV_Sql:=LV_Sql || ' AND     SYSDATE BETWEEN fec_desde AND NVL(fec_hasta,SYSDATE)';

        EXECUTE IMMEDIATE  LV_Sql;

    END IF;

EXCEPTION
WHEN OTHERS THEN
    SV_Estado   :='4';
    SV_Code     :=SQLCODE;
    SV_Errm     :=SQLERRM;
    SN_CodMsg := 2431;
    IF Not ge_errores_pg.mensajeerror(SN_CodMsg, LV_MensajeError) THEN
        LV_MensajeError := 'Error No ClasIFicado';
    END IF;
    LV_DesError := 'PV_CERRARLIM_LINEA_IND_PR(' || EN_NumAbonado || ','||EN_CodCliente||','||EV_CodPlanAct||')';
    LV_DesError :=LV_DesError ||'-T:'||SV_Tabla;
    LV_DesError :=LV_DesError ||'('||SV_Act||')';
    LV_DesError :=LV_DesError ||'-'|| SV_Errm;
    SN_Evento := ge_errores_pg.GRABARPL( SN_Evento,'PV',LV_MensajeError,'1.0',USER,'PV_CERRARLIM_LINEA_IND_PR',LV_Sql,SN_CodMsg,LV_DesError);
END pv_cerrarlim_linea_ind_pr;

PROCEDURE pv_crealim_linea_ind_pr  (EN_NumAbonado IN ga_limite_cliabo_to.num_abonado%TYPE,
                                    EN_CodCliente IN ga_limite_cliabo_to.cod_cliente%TYPE,
                                    EV_CodPlanFut IN ga_limite_cliabo_to.cod_plantarIF%TYPE,
                                    ED_FecDesde   IN DATE,
                                    SV_Estado     OUT NOCOPY VARCHAR2,
                                    SV_Proc       OUT NOCOPY VARCHAR2,
                                    SN_CodMsg     OUT NOCOPY NUMBER,
                                    SN_Evento     OUT NOCOPY NUMBER,
                                    SV_Tabla      OUT NOCOPY VARCHAR2,
                                    SV_Act        OUT NOCOPY VARCHAR2,
                                    SV_Code       OUT NOCOPY VARCHAR2,
                                    SV_Errm       OUT NOCOPY VARCHAR2   ) IS

/*
<Documentación TipoDoc = "PROCEDIMIENTO">
    <Elemento Nombre = "PV_CREALIM_LINEA_IND_PR" Lenguaje="PL/SQL" Fecha="09-12-2008" Versión="1.0"
        Diseñador="German Espinoza Zuñiga" Programador="German Espinoza Zuñiga" Ambiente="BD">
        <Retorno>N/A</Retorno>
        <Descripcion>Se crea limite de consumo en linea</Descripcion>
        <Parámetros>
            <Entrada>
                <param nom="EN_NumAbonado" Tipo="NUMBER">Numero de abonado</param>
                <param nom="EN_CodCliente"     Tipo="NUMBER">Codigo de cliente</param>
                <param nom="EV_CodPlanAct"   Tipo="VARCHAR2">Plan a cerrar vigencia de limite de consumo en linea</param>
            </Entrada>
            <Salida>
                <param nom="SV_Estado"    Tipo="VARCHAR2">Estado de la ejecucion del procedimiento 3: OK-4:ERROR</param>
                <param nom="SV_Proc"        Tipo="VARCHAR2">Nombre del procedo en donde ocurre un evento</param>
                <param nom="SN_CodMsg"   Tipo="NUMBER">Codigo de Mensaje del evento ocurrido</param>
                <param nom="SN_Evento"    Tipo="NUMBER">numero de evento</param>
                <param nom="SV_Tabla"      Tipo="VARCHAR2">Nombre de la tabla en donde ocurrio el evento</param>
                <param nom="SV_Act"         Tipo="VARCHAR2">accion sobre la table en donde ocurre el evento</param>
                <param nom="SV_Code"       Tipo="VARCHAR2">codigo del error oracle</param>
                <param nom="SV_Errm"        Tipo="VARCHAR2">Descripcion del Error Oracle</param>
            </Salida>
        </Parámetros>
    </Elemento>
</Documentación>
*/

LV_DesError         VARCHAR2(1000);
LV_Sql              VARCHAR2(2000);
LV_MensajeError     VARCHAR2(2000);
LN_CantLimVig       NUMBER;
LV_CodLimCons       GA_LIMITE_CLIABO_TO.COD_LIMCONS%TYPE;
LD_FecCorteCiclo    DATE;
LV_COD_COLOR        GE_CLIENTES.COD_COLOR%TYPE;
LV_COD_SEGMENTO     GE_CLIENTES.COD_SEGMENTO%TYPE;

BEGIN

    SV_Estado       :='3';
    SV_Proc         :='PV_CREALIM_LINEA_IND_PR';
    SN_CodMsg       :=0;
    SN_Evento       :=0;
    SV_Code         :='0';
    SV_Errm         :='0';

    SV_Tabla := 'GE_CLIENTES';
    SV_Act    := 'S';

    SELECT COD_COLOR,COD_SEGMENTO
    INTO LV_COD_COLOR, LV_COD_SEGMENTO
    FROM GE_CLIENTES
    WHERE cod_cliente =EN_CodCliente;

    SV_Tabla := 'TOL_LIMITE_PLAN_TD';
    SV_Act    := 'S';

    LV_Sql:=          ' SELECT cod_limcons';
    LV_Sql:=LV_Sql || ' FROM  tol_limite_plan_td';
    LV_Sql:=LV_Sql || ' WHERE cod_plantarIF  = '''||EV_CodPlanFut||'''';
    LV_Sql:=LV_Sql || ' AND   id_subsegmento = '  || LV_COD_SEGMENTO;
    --LV_Sql:=LV_Sql || ' AND   ind_prioridad >= '''|| LV_COD_COLOR || ''''; --INC 185916 BMR 04-07-2012
    LV_Sql:=LV_Sql || ' AND   ind_prioridad >= to_number('''|| LV_COD_COLOR || ''')';
    LV_Sql:=LV_Sql || ' AND   SYSDATE BETWEEN fec_desde AND NVL(fec_hasta,SYSDATE)';
    LV_Sql:=LV_Sql || ' AND   ROWNUM <=1';
    LV_Sql:=LV_Sql || ' ORDER BY COD_LIMCONS ASC';

    EXECUTE IMMEDIATE  LV_Sql INTO LV_CodLimCons;

    SV_Tabla := 'GA_LIMITE_CLIABO_TO';
    SV_Act    := 'I';

    LV_Sql:= ' INSERT INTO ga_limite_cliabo_to(num_abonado,cod_cliente,cod_limcons,cod_plantarIF,fec_desde,fec_hasta,fec_asignacion,nom_usuarora)';
    LV_Sql := LV_Sql || ' VALUES ('||EN_NumAbonado||','||EN_CodCliente||',';
    LV_Sql := LV_Sql || CHR(39) || LV_CodLimCons || CHR(39) ||',';
    LV_Sql := LV_Sql || CHR(39) || EV_CodPlanFut || CHR(39) ||',';
    LV_Sql := LV_Sql || ' TO_DATE('|| CHR(39) || TO_CHAR(ED_FecDesde,'dd-mm-yyyy hh24:mi:ss') || CHR(39) ||','|| CHR(39) || 'DD-MM-YYYY HH24:MI:SS' || CHR(39) || '),';
    LV_Sql := LV_Sql || 'NULL,SYSDATE,USER)';

    EXECUTE IMMEDIATE  LV_Sql;

EXCEPTION
WHEN OTHERS THEN
    SV_Estado   :='4';
    SV_Code     :=SQLCODE;
    SV_Errm     :=SQLERRM;
    SN_CodMsg := 2433;
    IF Not ge_errores_pg.mensajeerror(SN_CodMsg, LV_MensajeError) THEN
        LV_MensajeError := 'Error No ClasIFicado';
    END IF;
    LV_DesError := 'PV_CREALIM_LINEA_IND_PR(' || EN_NumAbonado || ','||EN_CodCliente||','||EV_CodPlanFut||')';
    LV_DesError :=LV_DesError ||'-T:'||SV_Tabla;
    LV_DesError :=LV_DesError ||'('||SV_Act||')';
    LV_DesError :=LV_DesError ||'-'|| SV_Errm;
    SN_Evento := ge_errores_pg.grabarpl( SN_Evento,'PV',LV_MensajeError,'1.0',USER,'PV_CREALIM_LINEA_IND_PR',LV_Sql,SN_CodMsg,LV_DesError);

END pv_crealim_linea_ind_pr;

PROCEDURE pv_cerrarlim_linea_emp_pr(EN_NumAbonado IN ga_limite_cliabo_to.num_abonado%TYPE,
                                    EN_CodCliente IN ga_limite_cliabo_to.cod_cliente%TYPE,
                                    EV_CodPlanAct IN ga_limite_cliabo_to.cod_plantarIF%TYPE,
                                    ED_FecHasta   IN DATE,
                                    SV_Estado     OUT NOCOPY VARCHAR2,
                                    SV_Proc       OUT NOCOPY VARCHAR2,
                                    SN_CodMsg     OUT NOCOPY NUMBER,
                                    SN_Evento     OUT NOCOPY NUMBER,
                                    SV_Tabla      OUT NOCOPY VARCHAR2,
                                    SV_Act        OUT NOCOPY VARCHAR2,
                                    SV_Code       OUT NOCOPY VARCHAR2,
                                    SV_Errm       OUT NOCOPY VARCHAR2   ) IS

/*
<Documentación TipoDoc = "PROCEDIMIENTO">
    <Elemento Nombre = "PV_CERRARLIM_LINEA_EMP_PR" Lenguaje="PL/SQL" Fecha="09-12-2008" Versión="1.0"
        Diseñador="German Espinoza Zuñiga" Programador="German Espinoza Zuñiga" Ambiente="BD">
        <Retorno>N/A</Retorno>
        <Descripcion>Cierra vigencia de limite de consumo que del cliente empresa en linea</Descripcion>
        <Parámetros>
            <Entrada>
                <param nom="EN_NumAbonado" Tipo="NUMBER">Numero de abonado</param>
                <param nom="EN_CodCliente"     Tipo="NUMBER">Codigo de cliente</param>
                <param nom="EV_CodPlanAct"   Tipo="VARCHAR2">Plan a cerrar vigencia de limite de consumo en linea</param>
            </Entrada>
            <Salida>
                <param nom="SV_Estado"    Tipo="VARCHAR2">Estado de la ejecucion del procedimiento 3: OK-4:ERROR</param>
                <param nom="SV_Proc"        Tipo="VARCHAR2">Nombre del procedo en donde ocurre un evento</param>
                <param nom="SN_CodMsg"   Tipo="NUMBER">Codigo de Mensaje del evento ocurrido</param>
                <param nom="SN_Evento"    Tipo="NUMBER">numero de evento</param>
                <param nom="SV_Tabla"      Tipo="VARCHAR2">Nombre de la tabla en donde ocurrio el evento</param>
                <param nom="SV_Act"         Tipo="VARCHAR2">accion sobre la table en donde ocurre el evento</param>
                <param nom="SV_Code"       Tipo="VARCHAR2">codigo del error oracle</param>
                <param nom="SV_Errm"        Tipo="VARCHAR2">Descripcion del Error Oracle</param>
            </Salida>
        </Parámetros>
    </Elemento>
</Documentación>
*/

LV_DesError      VARCHAR2(1000);
LV_Sql           VARCHAR2(2000);
LV_MensajeError  VARCHAR2(2000);
LN_CantLimVig    NUMBER;

BEGIN

    SV_Estado       :='3';
    SV_Proc         :='PV_CERRARLIM_LINEA_IND_PR';
    SN_CodMsg       :=0;
    SN_Evento       :=0;
    SV_Code         :='0';
    SV_Errm         :='0';

    SV_Tabla := 'GA_ABOCEL';
    SV_Act    := 'S';

    LV_Sql:=' SELECT COUNT(1)';
    LV_Sql:=LV_Sql || ' FROM    ga_abocel';
    LV_Sql:=LV_Sql || ' WHERE  cod_cliente     = '||EN_CodCliente;
    LV_Sql:=LV_Sql || ' AND     num_abonado <> '||EN_NumAbonado;
    LV_Sql:=LV_Sql || ' AND     cod_situacion not in (''BAA'',''BAP'')';

    EXECUTE IMMEDIATE  LV_Sql INTO LN_CantLimVig;

    IF LN_CantLimVig = 0 THEN
        SV_Tabla := 'GA_LIMITE_CLIABO_TO';
        SV_Act    := 'S';
        LV_Sql:=               ' SELECT COUNT(1)';
        LV_Sql:=LV_Sql || ' FROM    ga_limite_cliabo_to';
        LV_Sql:=LV_Sql || ' WHERE  cod_cliente     = '||EN_CodCliente;
        LV_Sql:=LV_Sql || ' AND     num_abonado = 0';
        LV_Sql:=LV_Sql || ' AND     cod_plantarIF   = '''||EV_CodPlanAct||'''';
        LV_Sql:=LV_Sql || ' AND     SYSDATE BETWEEN fec_desde AND NVL(fec_hasta,SYSDATE)';

        EXECUTE IMMEDIATE  LV_Sql INTO LN_CantLimVig;

        IF LN_CantLimVig > 0 THEN

            SV_Tabla := 'GA_LIMITE_CLIABO_TO';
            SV_Act    := 'U';

            LV_Sql:=               ' UPDATE ga_limite_cliabo_to';
            LV_Sql:=LV_Sql || ' SET  fec_hasta = TO_DATE(' || CHR(39) || TO_CHAR(ED_FecHasta,'dd-mm-yyyy hh24:mi:ss') || CHR(39) || ',' ||CHR(39) || 'DD-MM-YYYY HH24:MI:SS ' || CHR(39) || ')-1/86400 '; --SAQL
            LV_Sql:=LV_Sql || ' WHERE  cod_cliente     = '||EN_CodCliente;
            LV_Sql:=LV_Sql || ' AND     num_abonado = 0';
            LV_Sql:=LV_Sql || ' AND     cod_plantarIF   = '''||EV_CodPlanAct||'''';
            LV_Sql:=LV_Sql || ' AND     SYSDATE BETWEEN fec_desde AND NVL(fec_hasta,SYSDATE)';

            EXECUTE IMMEDIATE  LV_Sql;

        END IF;
    END IF;

EXCEPTION
WHEN OTHERS THEN
    SV_Estado   :='4';
    SV_Code     :=SQLCODE;
    SV_Errm     :=SQLERRM;
    SN_CodMsg := 2431;
    IF Not ge_errores_pg.mensajeerror(SN_CodMsg, LV_MensajeError) THEN
        LV_MensajeError := 'Error No ClasIFicado';
    END IF;
    LV_DesError := 'PV_CERRARLIM_LINEA_EMP_PR(' || EN_NumAbonado || ','||EN_CodCliente||','||EV_CodPlanAct||')';
    LV_DesError :=LV_DesError ||'-T:'||SV_Tabla;
    LV_DesError :=LV_DesError ||'('||SV_Act||')';
    LV_DesError :=LV_DesError ||'-'|| SV_Errm;
    SN_Evento := ge_errores_pg.GRABARPL( SN_Evento,'PV',LV_MensajeError,'1.0',USER,'PV_CERRARLIM_LINEA_EMP_PR',LV_Sql,SN_CodMsg,LV_DesError);

END pv_cerrarlim_linea_emp_pr;

PROCEDURE pv_cerrarlim_aciclo_emp_pr   (EN_NumAbonado IN ga_limite_cliabo_to.num_abonado%TYPE,
                                        EN_CodCliente IN ga_limite_cliabo_to.cod_cliente%TYPE,
                                        EV_CodPlanAct IN ga_limite_cliabo_to.cod_plantarIF%TYPE,
                                        SV_Estado     OUT NOCOPY VARCHAR2,
                                        SV_Proc       OUT NOCOPY VARCHAR2,
                                        SN_CodMsg     OUT NOCOPY NUMBER,
                                        SN_Evento     OUT NOCOPY NUMBER,
                                        SV_Tabla      OUT NOCOPY VARCHAR2,
                                        SV_Act        OUT NOCOPY VARCHAR2,
                                        SV_Code       OUT NOCOPY VARCHAR2,
                                        SV_Errm       OUT NOCOPY VARCHAR2) IS
/*
<Documentación TipoDoc = "PROCEDIMIENTO">
    <Elemento Nombre = "PV_CERRARLIM_ACICLO_EMP_PR" Lenguaje="PL/SQL" Fecha="09-12-2008" Versión="1.0"
        Diseñador="German Espinoza Zuñiga" Programador="German Espinoza Zuñiga" Ambiente="BD">
        <Retorno>N/A</Retorno>
        <Descripción>Cierra vigencia de limite de consumo actual al corte de ciclo</Descripción>
        <Parámetros>
            <Entrada>
                <param nom="EN_NumAbonado" Tipo="NUMBER">Numero de abonado</param>
                <param nom="EN_CodCliente"     Tipo="NUMBER">Codigo de cliente</param>
                <param nom="EV_CodPlanAct"   Tipo="VARCHAR2">Plan a cerrar vigencia de limite de consumo</param>
            </Entrada>
            <Salida>
                <param nom="SV_Estado"    Tipo="VARCHAR2">Estado de la ejecucion del procedimiento 3: OK-4:ERROR</param>
                <param nom="SV_Proc"        Tipo="VARCHAR2">Nombre del procedo en donde ocurre un evento</param>
                <param nom="SN_CodMsg"   Tipo="NUMBER">Codigo de Mensaje del evento ocurrido</param>
                <param nom="SN_Evento"    Tipo="NUMBER">numero de evento</param>
                <param nom="SV_Tabla"      Tipo="VARCHAR2">Nombre de la tabla en donde ocurrio el evento</param>
                <param nom="SV_Act"         Tipo="VARCHAR2">accion sobre la table en donde ocurre el evento</param>
                <param nom="SV_Code"       Tipo="VARCHAR2">codigo del error oracle</param>
                <param nom="SV_Errm"        Tipo="VARCHAR2">Descripcion del Error Oracle</param>
            </Salida>
        </Parámetros>
    </Elemento>
</Documentación>
*/

LN_CantLimVig      NUMBER;
LN_CantEmp         NUMBER;
LN_EsEmpresa       NUMBER;  --0: no cliente no es empresa 1: cliente es empresa
LD_FecCorteFin     DATE;
LV_DesError        VARCHAR2(1000);
LV_Sql             VARCHAR2(2000);
LV_MensajeError    VARCHAR2(2000);

BEGIN
    SV_Estado       :='3';
    SV_Proc         :='PV_CERRARLIM_ACICLO_IND_PR';
    SN_CodMsg       :=0;
    SN_Evento       :=0;
    SV_Code         :='0';
    SV_Errm         :='0';

    SV_Tabla := 'GA_ABOCEL';
    SV_Act    := 'S';

    LV_Sql:=               ' SELECT COUNT(1)';
    LV_Sql:=LV_Sql || ' FROM    ga_abocel';
    LV_Sql:=LV_Sql || ' WHERE  cod_cliente     = '||EN_CodCliente;
    LV_Sql:=LV_Sql || ' AND     num_abonado <> '||EN_NumAbonado;
    LV_Sql:=LV_Sql || ' AND     cod_situacion not in (''BAA'',''BAP'')';

    EXECUTE IMMEDIATE  LV_Sql INTO LN_CantLimVig;

    IF LN_CantLimVig = 0 THEN

        SV_Tabla := 'GA_LIMITE_CLIABO_TO';
        SV_Act    := 'S';

        LV_Sql:=' SELECT COUNT(1) FROM ga_limite_cliabo_to';
        LV_Sql:=LV_Sql || ' WHERE  cod_cliente     = '||EN_CodCliente;
        LV_Sql:=LV_Sql || ' AND      num_abonado = 0';
        LV_Sql:=LV_Sql || ' AND      cod_plantarIF   = '''||EV_CodPlanAct||'''';
        LV_Sql:=LV_Sql || ' AND      SYSDATE BETWEEN fec_desde AND NVL(fec_hasta,SYSDATE)';

        EXECUTE IMMEDIATE  LV_Sql INTO LN_CantLimVig;

        IF LN_CantLimVig > 0 THEN

            SV_Tabla := 'ABOCEL-CICLFACT';
            SV_Act    := 'S';

            LV_Sql:=' SELECT fec_hastallam';
            LV_Sql:=LV_Sql || ' FROM    ga_abocel a,fa_ciclfact b';
            LV_Sql:=LV_Sql || ' WHERE  a.num_abonado = '||EN_NumAbonado;
            LV_Sql:=LV_Sql || ' AND      b.cod_ciclo        = a.cod_ciclo';
            LV_Sql:=LV_Sql || ' AND      SYSDATE BETWEEN fec_desdellam AND fec_hastallam';

            EXECUTE IMMEDIATE  LV_Sql INTO LD_FecCorteFin;

            SV_Tabla := 'GA_LIMITE_CLIABO_TO';
            SV_Act    := 'U';

            LV_Sql:=' UPDATE ga_limite_cliabo_to';
            LV_Sql:=LV_Sql || ' SET       fec_hasta       = TO_DATE('''||TO_CHAR(LD_FecCorteFin,'dd-mm-yyyy hh24:mi:ss')||''',''dd-mm-yyyy hh24:mi:ss'')';
            LV_Sql:=LV_Sql || ' WHERE  cod_cliente     = '||EN_CodCliente;
            LV_Sql:=LV_Sql || ' AND     num_abonado  = 0';
            LV_Sql:=LV_Sql || ' AND     cod_plantarIF    = '''||EV_CodPlanAct||'''';
            LV_Sql:=LV_Sql || ' AND     SYSDATE BETWEEN fec_desde AND NVL(fec_hasta,SYSDATE)';

            EXECUTE IMMEDIATE  LV_Sql;
        END IF;
    END IF;

EXCEPTION
WHEN OTHERS THEN
    SV_Estado   :='4';
    SV_Code     :=SQLCODE;
    SV_Errm     :=SQLERRM;
    SN_CodMsg := 2431;
    IF Not ge_errores_pg.mensajeerror(SN_CodMsg, LV_MensajeError) THEN
        LV_MensajeError := 'Error No ClasIFicado';
    END IF;
    LV_DesError := 'PV_CERRARLIM_ACICLO_EMP_PR(' || EN_NumAbonado || ','||EN_CodCliente||','||EV_CodPlanAct||')';
    LV_DesError :=LV_DesError ||'-T:'||SV_Tabla;
    LV_DesError :=LV_DesError ||'('||SV_Act||')';
    LV_DesError :=LV_DesError ||'-'|| SV_Errm;
    SN_Evento := ge_errores_pg.grabarpl( SN_Evento,'PV',LV_MensajeError,'1.0',USER,'PV_CERRARLIM_ACICLO_EMP_PR',LV_Sql,SN_CodMsg,LV_DesError);
END;

PROCEDURE pv_eliminarlim_aciclo_emp_pr (EN_NumAbonado IN ga_limite_cliabo_to.num_abonado%TYPE,
                                        EN_CodCliente IN ga_limite_cliabo_to.cod_cliente%TYPE,
                                        EV_CodPlanFut IN ga_limite_cliabo_to.cod_plantarIF%TYPE,
                                        SV_Estado     OUT NOCOPY VARCHAR2,
                                        SV_Proc       OUT NOCOPY VARCHAR2,
                                        SN_CodMsg     OUT NOCOPY NUMBER,
                                        SN_Evento     OUT NOCOPY NUMBER,
                                        SV_Tabla      OUT NOCOPY VARCHAR2,
                                        SV_Act        OUT NOCOPY VARCHAR2,
                                        SV_Code       OUT NOCOPY VARCHAR2,
                                        SV_Errm       OUT NOCOPY VARCHAR2   ) IS

/*
<Documentación TipoDoc = "PROCEDIMIENTO">
    <Elemento Nombre = "PV_ELIMINARLIM_ACICLO_EMP_PR" Lenguaje="PL/SQL" Fecha="09-12-2008" Versión="1.0"
        Diseñador="German Espinoza Zuñiga" Programador="German Espinoza Zuñiga" Ambiente="BD">
        <Retorno>N/A</Retorno>
        <Descripcion>Elimina y pasa a historico limite de consumo que el abonado tenga al corte de ciclo</Descripcion>
        <Parámetros>
            <Entrada>
                <param nom="EN_NumAbonado" Tipo="NUMBER">Numero de abonado</param>
                <param nom="EN_CodCliente"     Tipo="NUMBER">Codigo de cliente</param>
                <param nom="EV_CodPlanFut"   Tipo="VARCHAR2">Plan a cerrar vigencia de limite de consumo a futuro</param>
            </Entrada>
            <Salida>
                <param nom="SV_Estado"    Tipo="VARCHAR2">Estado de la ejecucion del procedimiento 3: OK-4:ERROR</param>
                <param nom="SV_Proc"        Tipo="VARCHAR2">Nombre del procedo en donde ocurre un evento</param>
                <param nom="SN_CodMsg"   Tipo="NUMBER">Codigo de Mensaje del evento ocurrido</param>
                <param nom="SN_Evento"    Tipo="NUMBER">numero de evento</param>
                <param nom="SV_Tabla"      Tipo="VARCHAR2">Nombre de la tabla en donde ocurrio el evento</param>
                <param nom="SV_Act"         Tipo="VARCHAR2">accion sobre la table en donde ocurre el evento</param>
                <param nom="SV_Code"       Tipo="VARCHAR2">codigo del error oracle</param>
                <param nom="SV_Errm"        Tipo="VARCHAR2">Descripcion del Error Oracle</param>
            </Salida>
        </Parámetros>
    </Elemento>
</Documentación>
*/

LN_CantLimVig   NUMBER;
LV_DesError     VARCHAR2(1000);
LV_Sql          VARCHAR2(2000);
LV_MensajeError VARCHAR2(2000);

BEGIN
    SV_Estado       :='3';
    SV_Proc         :='PV_ELIMINARLIM_ACICLO_IND_PR';
    SN_CodMsg       :=0;
    SN_Evento       :=0;
    SV_Code         :='0';
    SV_Errm         :='0';

    SV_Tabla := 'GA_ABOCEL';
    SV_Act    := 'S';

    LV_Sql:=          ' SELECT COUNT(1)';
    LV_Sql:=LV_Sql || ' FROM    ga_abocel';
    LV_Sql:=LV_Sql || ' WHERE  cod_cliente     = '||EN_CodCliente;
    LV_Sql:=LV_Sql || ' AND     num_abonado <> '||EN_NumAbonado;
    LV_Sql:=LV_Sql || ' AND     cod_situacion not in (''BAA'',''BAP'')';

    EXECUTE IMMEDIATE  LV_Sql INTO LN_CantLimVig;

    IF LN_CantLimVig = 0 THEN

        SV_Tabla := 'GA_LIMITE_CLIABO_TO';
        SV_Act    := 'S';

        LV_Sql:=' SELECT COUNT(1)';
        LV_Sql:=LV_Sql || ' FROM    ga_limite_cliabo_to';
        LV_Sql:=LV_Sql || ' WHERE  cod_cliente     = '||EN_CodCliente;
        LV_Sql:=LV_Sql || ' AND     num_abonado =0 ';
        LV_Sql:=LV_Sql || ' AND     cod_plantarIF   = '''||EV_CodPlanFut||'''';
        LV_Sql:=LV_Sql || ' AND     fec_desde>SYSDATE';

        EXECUTE IMMEDIATE  LV_Sql INTO LN_CantLimVig;

        IF LN_CantLimVig > 0 THEN

            SV_Tabla := 'GA_LIMITE_CLIABO_TH';
            SV_Act    := 'I';

            LV_Sql:=               ' INSERT INTO ga_limite_cliabo_th';
            LV_Sql:=LV_Sql || ' (cod_cliente, num_abonado, cod_limcons, cod_plantarIF, fec_desde, fec_historico, fec_hasta, nom_usuarora';
            LV_Sql:=LV_Sql || ' , fec_asignacion, cod_causa_hist, est_aplica_tol, fec_aplica_tol)';
            LV_Sql:=LV_Sql || ' SELECT cod_cliente, num_abonado, cod_limcons, cod_plantarIF, fec_desde,SYSDATE,fec_hasta, nom_usuarora';
            LV_Sql:=LV_Sql || ' , fec_asignacion,''PV_CT'', est_aplica_tol, fec_aplica_tol';
            LV_Sql:=LV_Sql || ' FROM   ga_limite_cliabo_to';
            LV_Sql:=LV_Sql || ' WHERE  cod_cliente     = '||EN_CodCliente;
            LV_Sql:=LV_Sql || ' AND     num_abonado = 0';
            LV_Sql:=LV_Sql || ' AND     cod_plantarIF   = '''||EV_CodPlanFut||'''';
            LV_Sql:=LV_Sql || ' AND     fec_desde>SYSDATE';

            EXECUTE IMMEDIATE  LV_Sql;

            SV_Tabla := 'GA_LIMITE_CLIABO_TO';
            SV_Act    := 'D';

            LV_Sql:=               ' DELETE ga_limite_cliabo_to';
            LV_Sql:=LV_Sql || ' WHERE  cod_cliente     = '||EN_CodCliente;
            LV_Sql:=LV_Sql || ' AND     num_abonado =0 ';
            LV_Sql:=LV_Sql || ' AND     cod_plantarIF   = '''||EV_CodPlanFut||'''';
            LV_Sql:=LV_Sql || ' AND     fec_desde>SYSDATE';

            EXECUTE IMMEDIATE  LV_Sql;

        END IF;

    END IF;

EXCEPTION
WHEN OTHERS THEN
    SV_Estado   :='4';
    SV_Code     :=SQLCODE;
    SV_Errm     :=SQLERRM;
    SN_CodMsg := 2432;
    IF Not ge_errores_pg.mensajeerror(SN_CodMsg, LV_MensajeError) THEN
        LV_MensajeError := 'Error No ClasIFicado';
    END IF;
    LV_DesError := 'PV_ELIMINARLIM_ACICLO_EMP_PR(' || EN_NumAbonado || ','||EN_CodCliente||','||EV_CodPlanFut||')';
    LV_DesError :=LV_DesError ||'-T:'||SV_Tabla;
    LV_DesError :=LV_DesError ||'('||SV_Act||')';
    LV_DesError :=LV_DesError ||'-'|| SV_Errm;
    SN_Evento := ge_errores_pg.grabarpl( SN_Evento,'PV',LV_MensajeError,'1.0',USER,'PV_ELIMINARLIM_ACICLO_EMP_PR',LV_Sql,SN_CodMsg,LV_DesError);

END pv_eliminarlim_aciclo_emp_pr;

PROCEDURE pv_crealim_linea_emp_pr  (EN_NumAbonado IN ga_limite_cliabo_to.num_abonado%TYPE,
                                    EN_CodCliente IN ga_limite_cliabo_to.cod_cliente%TYPE,
                                    EV_CodPlanFut IN ga_limite_cliabo_to.cod_plantarIF%TYPE,
                                    SV_Estado     OUT NOCOPY VARCHAR2,
                                    SV_Proc       OUT NOCOPY VARCHAR2,
                                    SN_CodMsg     OUT NOCOPY NUMBER,
                                    SN_Evento     OUT NOCOPY NUMBER,
                                    SV_Tabla      OUT NOCOPY VARCHAR2,
                                    SV_Act        OUT NOCOPY VARCHAR2,
                                    SV_Code       OUT NOCOPY VARCHAR2,
                                    SV_Errm       OUT NOCOPY VARCHAR2   ) IS

/*
<Documentación TipoDoc = "PROCEDIMIENTO">
    <Elemento Nombre = "PV_CREALIM_LINEA_IND_PR" Lenguaje="PL/SQL" Fecha="09-12-2008" Versión="1.0"
        Diseñador="German Espinoza Zuñiga" Programador="German Espinoza Zuñiga" Ambiente="BD">
        <Retorno>N/A</Retorno>
        <Descripcion>Se crea limite de consumo en linea</Descripcion>
        <Parámetros>
            <Entrada>
                <param nom="EN_NumAbonado" Tipo="NUMBER">Numero de abonado</param>
                <param nom="EN_CodCliente"     Tipo="NUMBER">Codigo de cliente</param>
                <param nom="EV_CodPlanAct"   Tipo="VARCHAR2">Plan a cerrar vigencia de limite de consumo en linea</param>
            </Entrada>
            <Salida>
                <param nom="SV_Estado"    Tipo="VARCHAR2">Estado de la ejecucion del procedimiento 3: OK-4:ERROR</param>
                <param nom="SV_Proc"        Tipo="VARCHAR2">Nombre del procedo en donde ocurre un evento</param>
                <param nom="SN_CodMsg"   Tipo="NUMBER">Codigo de Mensaje del evento ocurrido</param>
                <param nom="SN_Evento"    Tipo="NUMBER">numero de evento</param>
                <param nom="SV_Tabla"      Tipo="VARCHAR2">Nombre de la tabla en donde ocurrio el evento</param>
                <param nom="SV_Act"         Tipo="VARCHAR2">accion sobre la table en donde ocurre el evento</param>
                <param nom="SV_Code"       Tipo="VARCHAR2">codigo del error oracle</param>
                <param nom="SV_Errm"        Tipo="VARCHAR2">Descripcion del Error Oracle</param>
            </Salida>
        </Parámetros>
    </Elemento>
</Documentación>
*/

LV_DesError      VARCHAR2(1000);
LV_Sql           VARCHAR2(2000);
LV_MensajeError  VARCHAR2(2000);
LN_CantLimVig    NUMBER;
LV_CodLimCons    GA_LIMITE_CLIABO_TO.COD_LIMCONS%TYPE;
LD_FecCorteCiclo DATE;
LV_COD_COLOR     GE_CLIENTES.COD_COLOR%TYPE;
LV_COD_SEGMENTO  GE_CLIENTES.COD_SEGMENTO%TYPE;

BEGIN

    SV_Estado       :='3';
    SV_Proc         :='PV_CREALIM_LINEA_IND_PR';
    SN_CodMsg       :=0;
    SN_Evento       :=0;
    SV_Code         :='0';
    SV_Errm         :='0';

    SV_Tabla := 'GA_ABOCEL';
    SV_Act    := 'S';

    LV_Sql:=' SELECT COUNT(1)';
    LV_Sql:=LV_Sql || ' FROM    ga_abocel';
    LV_Sql:=LV_Sql || ' WHERE  cod_cliente     = '||EN_CodCliente;
    LV_Sql:=LV_Sql || ' AND     num_abonado <> '||EN_NumAbonado;
    LV_Sql:=LV_Sql || ' AND     cod_situacion not in (''BAA'',''BAP'')';

    EXECUTE IMMEDIATE  LV_Sql INTO LN_CantLimVig;

    IF LN_CantLimVig = 0 THEN

        SELECT COD_COLOR,COD_SEGMENTO
        INTO LV_COD_COLOR, LV_COD_SEGMENTO
        FROM GE_CLIENTES
        WHERE cod_cliente =EN_CodCliente;

        SV_Tabla := 'TOL_LIMITE_PLAN_TD';
        SV_Act    := 'S';

        LV_Sql:= ' SELECT cod_limcons';
        LV_Sql:=LV_Sql || ' FROM    tol_limite_plan_td';
        LV_Sql:=LV_Sql || ' WHERE   cod_plantarIF  = '''||EV_CodPlanFut||'''';
        LV_Sql:=LV_Sql || ' AND   id_subsegmento = '  || LV_COD_SEGMENTO;
        LV_Sql:=LV_Sql || ' AND   ind_prioridad >= '''|| LV_COD_COLOR || '''';
        LV_Sql:=LV_Sql || ' AND     SYSDATE BETWEEN fec_desde AND NVL(fec_hasta,SYSDATE)';
        LV_Sql:=LV_Sql || ' AND   ROWNUM <=1';
        LV_Sql:=LV_Sql || ' ORDER BY COD_LIMCONS ASC';

        EXECUTE IMMEDIATE  LV_Sql INTO LV_CodLimCons;

        SV_Tabla := 'GA_LIMITE_CLIABO_TO';
        SV_Act    := 'I';

        LV_Sql:=               ' INSERT INTO ga_limite_cliabo_to(num_abonado,cod_cliente,cod_limcons,cod_plantarIF,fec_desde,fec_hasta,fec_asignacion,nom_usuarora)';
        LV_Sql:=LV_Sql || ' VALUES (0,'||EN_CodCliente||','''||LV_CodLimCons||''','''||EV_CodPlanFut||''',SYSDATE,NULL,SYSDATE,USER)';

        EXECUTE IMMEDIATE  LV_Sql;

    END IF;

EXCEPTION
WHEN OTHERS THEN
    SV_Estado   :='4';
    SV_Code     :=SQLCODE;
    SV_Errm     :=SQLERRM;
    SN_CodMsg := 2433;
    IF Not ge_errores_pg.mensajeerror(SN_CodMsg, LV_MensajeError) THEN
    LV_MensajeError := 'Error No ClasIFicado';
    END IF;
    LV_DesError := 'PV_CREALIM_LINEA_EMP_PR(' || EN_NumAbonado || ','||EN_CodCliente||','||EV_CodPlanFut||')';
    LV_DesError :=LV_DesError ||'-T:'||SV_Tabla;
    LV_DesError :=LV_DesError ||'('||SV_Act||')';
    LV_DesError :=LV_DesError ||'-'|| SV_Errm;
    SN_Evento := ge_errores_pg.grabarpl( SN_Evento,'PV',LV_MensajeError,'1.0',USER,'PV_CREALIM_LINEA_EMP_PR',LV_Sql,SN_CodMsg,LV_DesError);

END pv_crealim_linea_emp_pr;

PROCEDURE pv_crealim_aciclo_emp_pr (EN_NumAbonado IN ga_limite_cliabo_to.num_abonado%TYPE,
                                    EN_CodCliente IN ga_limite_cliabo_to.cod_cliente%TYPE,
                                    EV_CodPlanFut IN  ga_limite_cliabo_to.cod_plantarIF%TYPE,
                                    SV_Estado     OUT NOCOPY VARCHAR2,
                                    SV_Proc       OUT NOCOPY VARCHAR2,
                                    SN_CodMsg     OUT NOCOPY NUMBER,
                                    SN_Evento     OUT NOCOPY NUMBER,
                                    SV_Tabla      OUT NOCOPY VARCHAR2,
                                    SV_Act        OUT NOCOPY VARCHAR2,
                                    SV_Code       OUT NOCOPY VARCHAR2,
                                    SV_Errm       OUT NOCOPY VARCHAR2   ) IS

/*
<Documentación TipoDoc = "PROCEDIMIENTO">
    <Elemento Nombre = "PV_CREALIM_ACICLO_IND_PR" Lenguaje="PL/SQL" Fecha="09-12-2008" Versión="1.0"
        Diseñador="German Espinoza Zuñiga" Programador="German Espinoza Zuñiga" Ambiente="BD">
        <Retorno>N/A</Retorno>
        <Descripcion>Crea limite de consumo al corte de ciclo</Descripcion>
        <Parámetros>
        <Entrada>
            <param nom="EN_NumAbonado" Tipo="NUMBER">Numero de abonado</param>
            <param nom="EN_CodCliente"     Tipo="NUMBER">Codigo de cliente</param>
            <param nom="EV_CodPlanFut"   Tipo="VARCHAR2">Plan a cerrar vigencia de limite de consumo a futuro</param>
        </Entrada>
        <Salida>
            <param nom="SV_Estado"    Tipo="VARCHAR2">Estado de la ejecucion del procedimiento 3: OK-4:ERROR</param>
            <param nom="SV_Proc"        Tipo="VARCHAR2">Nombre del procedo en donde ocurre un evento</param>
            <param nom="SN_CodMsg"   Tipo="NUMBER">Codigo de Mensaje del evento ocurrido</param>
            <param nom="SN_Evento"    Tipo="NUMBER">numero de evento</param>
            <param nom="SV_Tabla"      Tipo="VARCHAR2">Nombre de la tabla en donde ocurrio el evento</param>
            <param nom="SV_Act"         Tipo="VARCHAR2">accion sobre la table en donde ocurre el evento</param>
            <param nom="SV_Code"       Tipo="VARCHAR2">codigo del error oracle</param>
            <param nom="SV_Errm"        Tipo="VARCHAR2">Descripcion del Error Oracle</param>
        </Salida>
        </Parámetros>
    </Elemento>
</Documentación>
*/

LN_CantLimVig    NUMBER;
LD_FecCorteCiclo DATE;
LV_CodLimCons    GA_LIMITE_CLIABO_TO.COD_LIMCONS%TYPE;
LV_DesError      VARCHAR2(1000);
LV_Sql           VARCHAR2(2000);
LV_MensajeError  VARCHAR2(2000);
LV_COD_COLOR     GE_CLIENTES.COD_COLOR%TYPE;
LV_COD_SEGMENTO  GE_CLIENTES.COD_SEGMENTO%TYPE;

BEGIN
--Valido si el abonado tiene limite de consumo vigente

    SV_Estado       :='3';
    SV_Proc         :='PV_CREALIM_ACICLO_IND_PR';
    SN_CodMsg       :=0;
    SN_Evento       :=0;
    SV_Code         :='0';
    SV_Errm         :='0';

    SV_Tabla := 'GA_ABOCEL';
    SV_Act    := 'S';

    LV_Sql:=' SELECT COUNT(1)';
    LV_Sql:=LV_Sql || ' FROM    ga_abocel';
    LV_Sql:=LV_Sql || ' WHERE  cod_cliente     = '||EN_CodCliente;
    LV_Sql:=LV_Sql || ' AND     num_abonado <> '||EN_NumAbonado;
    LV_Sql:=LV_Sql || ' AND     cod_situacion not in (''BAA'',''BAP'')';

    EXECUTE IMMEDIATE  LV_Sql INTO LN_CantLimVig;

    IF LN_CantLimVig = 0 THEN

        SELECT COD_COLOR,COD_SEGMENTO
        INTO LV_COD_COLOR, LV_COD_SEGMENTO
        FROM GE_CLIENTES
        WHERE cod_cliente =EN_CodCliente;

        SV_Tabla := 'TOL_LIMITE_PLAN_TD';
        SV_Act    := 'S';

        LV_Sql:= ' SELECT cod_limcons';
        LV_Sql:=LV_Sql || ' FROM    tol_limite_plan_td';
        LV_Sql:=LV_Sql || ' WHERE  cod_plantarIF  = '''||EV_CodPlanFut||'''';
        LV_Sql:=LV_Sql || ' AND   id_subsegmento = '  || LV_COD_SEGMENTO;
        LV_Sql:=LV_Sql || ' AND   ind_prioridad >= '''|| LV_COD_COLOR || '''';
        LV_Sql:=LV_Sql || ' AND     SYSDATE BETWEEN fec_desde AND NVL(fec_hasta,SYSDATE)';
        LV_Sql:=LV_Sql || ' AND   ROWNUM <=1';
        LV_Sql:=LV_Sql || ' ORDER BY COD_LIMCONS ASC';

        EXECUTE IMMEDIATE  LV_Sql INTO LV_CodLimCons;

        SV_Tabla := 'ABOCEL-CICLFACT';
        SV_Act    := 'S';

        LV_Sql:= ' SELECT fec_hastallam+1/86400';
        LV_Sql:=LV_Sql || ' FROM    ga_abocel a,fa_ciclfact b';
        LV_Sql:=LV_Sql || ' WHERE  a.num_abonado = '||EN_NumAbonado;
        LV_Sql:=LV_Sql || ' AND      b.cod_ciclo        = a.cod_ciclo';
        LV_Sql:=LV_Sql || ' AND      SYSDATE BETWEEN fec_desdellam AND fec_hastallam';

        EXECUTE IMMEDIATE  LV_Sql INTO LD_FecCorteCiclo;

        SV_Tabla := 'GA_LIMITE_CLIABO_TO';
        SV_Act    := 'I';

        LV_Sql:= ' INSERT INTO ga_limite_cliabo_to(num_abonado,cod_cliente,cod_limcons,cod_plantarIF,fec_desde,fec_hasta,fec_asignacion,nom_usuarora)';
        LV_Sql:=LV_Sql || ' VALUES (0,'||EN_CodCliente||','''||LV_CodLimCons||''','''||EV_CodPlanFut||''',TO_DATE('''||TO_CHAR(LD_FecCorteCiclo,'dd-mm-yyyy hh24:mi:ss')||''',''dd-mm-yyyy hh24:mi:ss''),NULL,SYSDATE,USER)';

    EXECUTE IMMEDIATE  LV_Sql;
    END IF;

EXCEPTION
WHEN OTHERS THEN
    SV_Estado   :='4';
    SV_Code     :=SQLCODE;
    SV_Errm     :=SQLERRM;
    SN_CodMsg := 2433;
    IF Not ge_errores_pg.mensajeerror(SN_CodMsg, LV_MensajeError) THEN
        LV_MensajeError := 'Error No ClasIFicado';
    END IF;
    LV_DesError := 'PV_CREALIM_ACICLO_EMP_PR(' || EN_NumAbonado || ','||EN_CodCliente||','||EV_CodPlanFut||')';
    LV_DesError :=LV_DesError ||'-T:'||SV_Tabla;
    LV_DesError :=LV_DesError ||'('||SV_Act||')';
    LV_DesError :=LV_DesError ||'-'|| SV_Errm;
    SN_Evento := ge_errores_pg.GRABARPL( SN_Evento,'PV',LV_MensajeError,'1.0',USER,'PV_CREALIM_ACICLO_EMP_PR',LV_Sql,SN_CodMsg,LV_DesError);
END pv_crealim_aciclo_emp_pr;


PROCEDURE Pv_Del_Reglimcons_Vigente_Pr (EN_Sujeto     IN NUMBER,
                                        EV_TipSujeto  IN VARCHAR2,
                                        SVEstado     OUT NOCOPY     VARCHAR2,
                                        SVProc       OUT NOCOPY     VARCHAR2,
                                        SNCodMsg     OUT NOCOPY     NUMBER,
                                        SNEvento     OUT NOCOPY     NUMBER,
                                        SVTabla      OUT NOCOPY     VARCHAR2,
                                        SVAct        OUT NOCOPY     VARCHAR2,
                                        SVCode       OUT NOCOPY     VARCHAR2,
                                        SVErrm       OUT NOCOPY     VARCHAR2) IS
/*
<Documentación TipoDoc = "PROCEDIMIENTO">
    <Elemento Nombre = "pv_del_reglimcons_vigente_pr"
        Lenguaje = "PL/SQL"
        Fecha = "03-02-2009"
        Versión = "1.1.0"
        Diseñador = "German Espinoza Z."
        Programador="German Espinoza Z." Ambiente="BD">
        <Retorno>NA</Retorno>
        <Descripción>Regularizacion de limite de consumo busca limite de consumo actual y se verIFica si corresponde este al plan del abonado</Descripción>
        <Parámetros>
            <Entrada>
                <param nom="EN_Sujeto"    Tipo="NUMBER">Numero de abonado o codigo de Cliente</param>
                <param nom="EN_TipSujeto" Tipo="NUMBER">A: El EN_Sujeto es un numero de abonado C: el EN_Sujeto es un cliente</param>
            </Entrada>
            <Salida>
                <param nom="SVEstado" Tipo="VARCHAR2">Estado de la ejecucion del procedimiento 3: OK-4:ERROR-5:Error en validacion</param>
                <param nom="SVProc"   Tipo="VARCHAR2">Nombre del procedo en donde ocurre un evento</param>
                <param nom="SVCodMsg" Tipo="VARCHAR2">Codigo de Mensaje del evento ocurrido</param>
                <param nom="SNEvento" Tipo="VARCHAR2">numero de evento</param>
                <param nom="SVTabla"  Tipo="VARCHAR2">Nombre de la tabla en donde ocurrio el evento</param>
                <param nom="SVAct"    Tipo="VARCHAR2">accion sobre la table en donde ocurre el evento</param>
                <param nom="SVCode"   Tipo="VARCHAR2">codigo del error oracle</param>
                <param nom="SVErrm"   Tipo="VARCHAR2">Descripcion del Error Oracle</param>
            </Salida>
        </Parámetros>
    </Elemento>
</Documentación>
*/
LV_DesError         VARCHAR2(1000);
LV_Sql              VARCHAR2(2000);
LV_MensajeError     VARCHAR2(2000);
LB_CerrarLim        BOOLEAN;
LB_CrearLim         BOOLEAN;
LN_ContLim          NUMBER;
LD_FecHasta         DATE;
LD_FecSYSDATE       DATE;
LV_Situacion        GA_ABOCEL.cod_situacion%TYPE;
LN_Abonado          GA_ABOCEL.NUM_ABONADO%TYPE;
LN_Cliente          GA_ABOCEL.cod_cliente%TYPE;
LV_Uso              GA_ABOCEL.cod_uso%TYPE;
LV_Plan             GA_ABOCEL.cod_plantarIF%TYPE;
LV_UsoHibrido       GA_ABOCEL.cod_uso%TYPE;
LV_LimCons          GA_LIMITE_CLIABO_TO.cod_limcons%TYPE;
LV_LimConsNue       GA_LIMITE_CLIABO_TO.cod_limcons%TYPE;
LV_PlanACiclo       GA_FINCICLO.cod_plantarIF%TYPE;
LN_ImpLimCons        tol_limite_td.imp_limite%TYPE;
error_planaciclo     EXCEPTION;
error_maslim         EXCEPTION;
error_cliennoempresa EXCEPTION;
error_cliempsinabo   EXCEPTION;
error_cliempplan     EXCEPTION;
error_maslimcli      EXCEPTION;
LV_COD_COLOR        GE_CLIENTES.COD_COLOR%TYPE;
LV_COD_SEGMENTO     GE_CLIENTES.COD_SEGMENTO%TYPE;

BEGIN

    LB_CerrarLim :=FALSE;
    LB_CrearLim :=FALSE;

    SVEstado    := '3';
    SVProc      := 'PV_DEL_REGLIMCONS_VIGENTE_PR';
    SNCodMsg    := 0;
    SNEvento    := 0;
    SVCode      := '0';
    SVErrm      := '0';

    IF EV_TipSujeto='A' THEN
        BEGIN

            SVTabla :='GA_ABOCEL';
            SVAct   :='S';

            LV_Sql:=          ' SELECT cod_situacion,num_abonado,cod_cliente,cod_uso,cod_plantarIF';
            LV_Sql:= LV_Sql|| ' FROM   ga_abocel ';
            LV_Sql:= LV_Sql|| ' WHERE  num_abonado=' || EN_Sujeto;

            EXECUTE IMMEDIATE LV_Sql INTO LV_Situacion,LN_Abonado,LN_Cliente,LV_Uso,LV_Plan;

            IF LV_Situacion IN ('BAA','BAP') THEN
                LB_CerrarLim    :=TRUE;
                LB_CrearLim :=FALSE;
            Else
                LV_UsoHibrido:= Ge_Fn_Devvalparam('GA',1,'USO_HIBRIDO_GSM_TDMA');

                IF LV_Uso = LV_UsoHibrido THEN
                    LB_CerrarLim :=TRUE;
                    LB_CrearLim  :=FALSE;
                Else
                    SVTabla :='GA_LIMITE_CLIABO_TOA';
                    SVAct       :='S';

                    LV_Sql:=          ' SELECT COUNT(1) ';
                    LV_Sql:= LV_Sql|| ' FROM   ga_limite_cliabo_to  ';
                    LV_Sql:= LV_Sql|| ' WHERE  num_abonado   = '||LN_Abonado;
                    LV_Sql:= LV_Sql|| ' AND      cod_cliente   = '||LN_Cliente;
                    LV_Sql:= LV_Sql|| ' AND      cod_plantarIF = '''||LV_Plan||'''';
                    LV_Sql:= LV_Sql|| ' AND      SYSDATE BETWEEN fec_desde AND NVL(fec_hasta,SYSDATE) ';

                    EXECUTE IMMEDIATE LV_Sql INTO LN_ContLim;

                    IF LN_ContLim > 1 THEN
                        RAISE error_maslim;
                    ELSIF LN_ContLim=0 THEN
                        LB_CerrarLim    :=FALSE;
                        LB_CrearLim :=TRUE;
                    ELSIF LN_ContLim=1 THEN

                        SVTabla :='GA_LIMITE_CLIABO_TOB';
                        SVAct       :='S';

                        LV_Sql:=          ' SELECT cod_limcons ';
                        LV_Sql:= LV_Sql|| ' FROM   ga_limite_cliabo_to  ';
                        LV_Sql:= LV_Sql|| ' WHERE  num_abonado   = '||LN_Abonado;
                        LV_Sql:= LV_Sql|| ' AND      cod_cliente   = '||LN_Cliente;
                        LV_Sql:= LV_Sql|| ' AND      cod_plantarIF = '''||LV_Plan||'''';
                        LV_Sql:= LV_Sql|| ' AND      SYSDATE BETWEEN fec_desde AND NVL(fec_hasta,SYSDATE) ';

                        EXECUTE IMMEDIATE LV_Sql INTO LV_LimCons;

                        SVTabla :='TOL_LIMITE_PLAN_TDA';
                        SVAct       :='S';

                        SELECT COD_COLOR,COD_SEGMENTO
                        INTO LV_COD_COLOR, LV_COD_SEGMENTO
                        FROM GE_CLIENTES
                        WHERE cod_cliente =LN_Cliente;

                        LV_Sql:=          ' SELECT COUNT(1) ';
                        LV_Sql:= LV_Sql|| ' FROM   tol_limite_plan_td  ';
                        LV_Sql:= LV_Sql|| ' WHERE  cod_plantarIF = '''||LV_Plan||'''';
                        LV_Sql:= LV_Sql|| ' AND    cod_limcons   = '''||LV_LimCons||'''';
                        LV_Sql:= LV_Sql|| ' AND   id_subsegmento = '  || LV_COD_SEGMENTO;
                        LV_Sql:= LV_Sql|| ' AND   ind_prioridad >= '''|| LV_COD_COLOR || '''';


                        EXECUTE IMMEDIATE LV_Sql INTO LN_ContLim;

                        IF LN_ContLim = 0 THEN
                            LB_CerrarLim    :=TRUE;
                            LB_CrearLim :=TRUE;
                        END IF;

                    END IF;
                END IF;
            END IF;
        EXCEPTION
        WHEN NO_DATA_FOUND THEN
            LB_CerrarLim  :=TRUE;
            LB_CrearLim   :=FALSE;
        END;

    ELSIF EV_TipSujeto='C' THEN

        LN_Cliente:=EN_Sujeto;
        LN_Abonado:=0;

        BEGIN
            SVTabla :='GA_EMPRESA';
            SVAct   :='S';

            LV_Sql:=          ' SELECT cod_plantarIF';
            LV_Sql:= LV_Sql|| ' FROM   ga_empresa';
            LV_Sql:= LV_Sql|| ' WHERE  cod_cliente='||LN_Cliente;

            EXECUTE IMMEDIATE LV_Sql INTO LV_Plan;

        EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE error_cliennoempresa;
        END;

        SVTabla :='GA_ABOCELE';
        SVAct   :='S';

        LV_Sql:=          ' SELECT COUNT(1)';
        LV_Sql:= LV_Sql|| ' FROM   ga_abocel';
        LV_Sql:= LV_Sql|| ' WHERE  cod_cliente='||LN_Cliente;
        LV_Sql:= LV_Sql|| ' AND    cod_situacion NOT IN (''BAA'',''BAP'')';

        EXECUTE IMMEDIATE LV_Sql INTO LN_ContLim;

        IF LN_ContLim = 0 THEN
            RAISE error_cliempsinabo;
        END IF;

        SVTabla :='GA_ABOCELF';
        SVAct   :='S';

        LV_Sql:=          ' SELECT COUNT(1)';
        LV_Sql:= LV_Sql|| ' FROM   ga_abocel';
        LV_Sql:= LV_Sql|| ' WHERE  cod_cliente='||LN_Cliente;
        LV_Sql:= LV_Sql|| ' AND    cod_situacion NOT IN (''BAA'',''BAP'')';
        LV_Sql:= LV_Sql|| ' AND    cod_plantarIF<>'''||LV_Plan||'''';

        EXECUTE IMMEDIATE LV_Sql INTO LN_ContLim;

        IF LN_ContLim > 0 THEN
            RAISE error_cliempplan;
        Else
            SVTabla :='GA_LIMITE_CLIABO_TOE';
            SVAct   :='S';

            LV_Sql:=          ' SELECT COUNT(1) ';
            LV_Sql:= LV_Sql|| ' FROM   ga_limite_cliabo_to  ';
            LV_Sql:= LV_Sql|| ' WHERE  num_abonado   = 0';
            LV_Sql:= LV_Sql|| ' AND       cod_cliente   = '||LN_Cliente;
            LV_Sql:= LV_Sql|| ' AND       cod_plantarIF = '''||LV_Plan||'''';
            LV_Sql:= LV_Sql|| ' AND       SYSDATE BETWEEN fec_desde AND NVL(fec_hasta,SYSDATE) ';

            EXECUTE IMMEDIATE LV_Sql INTO LN_ContLim;

            IF LN_ContLim > 1 THEN
                RAISE error_maslimcli;
            ELSIF LN_ContLim=0 THEN
                LB_CerrarLim    :=FALSE;
                LB_CrearLim :=TRUE;
            ELSIF LN_ContLim=1 THEN
                SVTabla :='GA_LIMITE_CLIABO_TOF';
                SVAct       :='S';

                LV_Sql:=          ' SELECT cod_limcons ';
                LV_Sql:= LV_Sql|| ' FROM   ga_limite_cliabo_to  ';
                LV_Sql:= LV_Sql|| ' WHERE  num_abonado   = 0';
                LV_Sql:= LV_Sql|| ' AND      cod_cliente   = '||LN_Cliente;
                LV_Sql:= LV_Sql|| ' AND      cod_plantarIF = '''||LV_Plan||'''';
                LV_Sql:= LV_Sql|| ' AND      SYSDATE BETWEEN fec_desde AND NVL(fec_hasta,SYSDATE) ';

                EXECUTE IMMEDIATE LV_Sql INTO LV_LimCons;

                SVTabla :='TOL_LIMITE_PLAN_TD';
                SVAct       :='S';

                SELECT COD_COLOR,COD_SEGMENTO
                INTO LV_COD_COLOR, LV_COD_SEGMENTO
                FROM GE_CLIENTES
                WHERE cod_cliente =LN_Cliente;

                LV_Sql:=          ' SELECT COUNT(1) ';
                LV_Sql:= LV_Sql|| ' FROM   tol_limite_plan_td  ';
                LV_Sql:= LV_Sql|| ' WHERE  cod_plantarIF = '''||LV_Plan||'''';
                LV_Sql:= LV_Sql|| ' AND      cod_limcons   = '''||LV_LimCons||'''';
                LV_Sql:= LV_Sql|| ' AND   id_subsegmento = '  || LV_COD_SEGMENTO;
                LV_Sql:= LV_Sql|| ' AND   ind_prioridad >= '''|| LV_COD_COLOR || '''';

                EXECUTE IMMEDIATE LV_Sql INTO LN_ContLim;

                IF LN_ContLim = 0 THEN
                    LB_CerrarLim    :=TRUE;
                    LB_CrearLim :=TRUE;
                Else
                    LB_CerrarLim    :=FALSE;
                    LB_CrearLim :=FALSE;
                END IF;

            END IF;
        END IF;
    END IF;

    LD_FecSYSDATE:=SYSDATE;

    --::::::::::::: QUITAR VIGENCIA LIMITE DE CONSUMO ACTUAL :::::::::::::
    IF LB_CerrarLim THEN

        SVTabla :='GA_LIMITE_CLIABO_TO';
        SVAct   :='U';

        LV_Sql:=         ' UPDATE ga_limite_cliabo_to';
        LV_Sql:= LV_Sql|| ' SET    fec_hasta=TO_DATE('''||TO_CHAR(LD_FecSYSDATE,'dd-mm-yyyy hh24:mi:ss')||''',''dd-mm-yyyy hh24:mi:ss'')';
        LV_Sql:= LV_Sql|| ' WHERE  num_abonado   = '||LN_Abonado;
        LV_Sql:= LV_Sql|| ' AND    cod_cliente   = '||LN_Cliente;

        IF LV_Uso <> LV_UsoHibrido THEN
            LV_Sql:= LV_Sql|| ' AND    cod_plantarIF = '''||LV_Plan||'''';
        END IF;

        LV_Sql:= LV_Sql|| ' AND    SYSDATE BETWEEN fec_desde AND NVL(fec_hasta,SYSDATE) ';

        EXECUTE IMMEDIATE LV_Sql;

        -- si el clientes es hibrido el campo imp_Limconsumo se deja iagual a cero

        IF LV_Uso = LV_UsoHibrido THEN
            SVTabla :='GA_INTARCEL';
            SVAct   :='U';

            LV_Sql:=' UPDATE ga_intarcel';
            LV_Sql:= LV_Sql|| ' SET    IMP_LIMCONSUMO = 0';
            LV_Sql:= LV_Sql|| ' WHERE  num_abonado   = '||LN_Abonado;
            LV_Sql:= LV_Sql|| ' AND    cod_cliente   = '||LN_Cliente;
            LV_Sql:= LV_Sql|| ' AND    SYSDATE BETWEEN fec_desde AND NVL(fec_hasta,SYSDATE) ';

            EXECUTE IMMEDIATE LV_Sql;


            SVTabla :='GA_ABOCEL';
            SVAct   :='U';

            LV_Sql:=' UPDATE ga_abocel';
            LV_Sql:= LV_Sql|| ' SET    cod_limconsumo = -1';
            LV_Sql:= LV_Sql|| ' WHERE  num_abonado   = '||LN_Abonado;
            LV_Sql:= LV_Sql|| ' AND    cod_cliente   = '||LN_Cliente;


            EXECUTE IMMEDIATE LV_Sql;

        END IF;
    END IF;

--::::::::::::: CREAR LIMITE DE CONSUMO :::::::::::::
    IF LB_CrearLim THEN

        SVTabla :='TOL_LIMITE_PLAN_TDC';
        SVAct   :='S';

        SELECT COD_COLOR,COD_SEGMENTO
        INTO LV_COD_COLOR, LV_COD_SEGMENTO
        FROM GE_CLIENTES
        WHERE cod_cliente =LN_Cliente;

        LV_Sql:=          ' SELECT cod_limcons ';
        LV_Sql:= LV_Sql|| ' FROM   tol_limite_plan_td  ';
        LV_Sql:= LV_Sql|| ' WHERE  cod_plantarIF = '''||LV_Plan||'''';
        LV_Sql:=LV_Sql || ' AND   id_subsegmento = '  || LV_COD_SEGMENTO;
        LV_Sql:=LV_Sql || ' AND   ind_prioridad >= '''|| LV_COD_COLOR || '''';

        EXECUTE IMMEDIATE LV_Sql INTO LV_LimConsNue;

        IF EV_TipSujeto='A' THEN
            BEGIN
                SVTabla :='GA_FINCICLOA';
                SVAct   :='S';

                LV_Sql:=          ' SELECT cod_plantarIF';
                LV_Sql:= LV_Sql|| ' FROM   ga_finciclo';
                LV_Sql:= LV_Sql|| ' WHERE  cod_cliente ='|| LN_Cliente;
                LV_Sql:= LV_Sql|| ' AND       num_abonado ='|| LN_Abonado;
                LV_Sql:= LV_Sql|| ' AND       cod_plantarIF IS NOT NULL';

                EXECUTE IMMEDIATE LV_Sql INTO LV_PlanACiclo;

            EXCEPTION
            WHEN NO_DATA_FOUND THEN
                LV_PlanACiclo:=NULL;
            END;
        ELSIF EV_TipSujeto='C' THEN
            SVTabla :='GA_FINCICLOB';
            SVAct   :='S';

            LV_Sql:=          ' SELECT COUNT(1)';
            LV_Sql:= LV_Sql|| ' FROM   ga_finciclo';
            LV_Sql:= LV_Sql|| ' WHERE  cod_cliente ='|| LN_Cliente;
            LV_Sql:= LV_Sql|| ' AND       cod_plantarIF IS NOT NULL';

            EXECUTE IMMEDIATE LV_Sql INTO LN_ContLim;

            IF LN_ContLim = 0 THEN
                LV_PlanACiclo:=NULL;
            ELSE

                SVTabla :='GA_FINCICLOC';
                SVAct   :='S';

                LV_Sql:=          ' SELECT cod_plantarIF';
                LV_Sql:= LV_Sql|| ' FROM   ga_finciclo';
                LV_Sql:= LV_Sql|| ' WHERE  cod_cliente ='|| LN_Cliente;
                LV_Sql:= LV_Sql|| ' AND      cod_plantarIF IS NOT NULL AND ROWNUM<=1';

                EXECUTE IMMEDIATE LV_Sql INTO LV_PlanACiclo;
            END IF;
        END IF;

        IF LV_PlanACiclo Is Null THEN
            LD_FecHasta:=NULL;
        ELSE
            BEGIN
                SVTabla :='GA_LIMITE_CLIABO_TOC';
                SVAct       :='S';

                LV_Sql:=          ' SELECT fec_desde-1/86900 ';
                LV_Sql:= LV_Sql|| ' FROM   ga_limite_cliabo_to  ';
                LV_Sql:= LV_Sql|| ' WHERE  num_abonado   = '||LN_Abonado;
                LV_Sql:= LV_Sql|| ' AND      cod_cliente   = '||LN_Cliente;
                LV_Sql:= LV_Sql|| ' AND      cod_plantarIF = '''||LV_PlanACiclo||'''';
                LV_Sql:= LV_Sql|| ' AND      fec_desde>SYSDATE ';

                EXECUTE IMMEDIATE LV_Sql INTO LD_FecHasta;
            EXCEPTION
            WHEN NO_DATA_FOUND THEN
                RAISE error_planaciclo;
            END;
        END IF;

        SVTabla :='GA_LIMITE_CLIABO_TO';
        SVAct   :='I';

        LV_Sql:=          ' INSERT INTO ga_limite_cliabo_to';
        LV_Sql:= LV_Sql|| ' (COD_CLIENTE, NUM_ABONADO, COD_LIMCONS, FEC_DESDE, FEC_HASTA, NOM_USUARORA';
        LV_Sql:= LV_Sql|| ' , FEC_ASIGNACION, EST_APLICA_TOL, FEC_APLICA_TOL, COD_PLANTARIF)';
        LV_Sql:= LV_Sql|| ' VALUES';
        LV_Sql:= LV_Sql|| ' ('||LN_Cliente||','||LN_Abonado||','''||LV_LimConsNue||''',TO_DATE('''||TO_CHAR(LD_FecSYSDATE+1/86900,'dd-mm-yyyy hh24:mi:ss')||''',''dd/mm/yyyy hh24:mi:ss'')';
        LV_Sql:= LV_Sql|| ' ,TO_DATE('''||TO_CHAR(LD_FecHasta,'dd-mm-yyyy hh24:mi:ss')||''',''dd/mm/yyyy hh24:mi:ss''),USER';
        LV_Sql:= LV_Sql|| ' ,SYSDATE,NULL,NULL,'''||LV_Plan||''')';

        EXECUTE IMMEDIATE LV_Sql;

        SVTabla :='GA_ABOCEL';
        SVAct   :='U';

        LV_Sql:=         ' UPDATE ga_abocel';
        LV_Sql:= LV_Sql|| ' SET    cod_limconsumo='''||LV_LimConsNue||'''';

        IF EV_TipSujeto='A' THEN
            LV_Sql:= LV_Sql|| ' WHERE  num_abonado   = '||LN_Abonado;
        ELSIF EV_TipSujeto='C' THEN
            LV_Sql:= LV_Sql|| ' WHERE  cod_cliente = '||LN_Cliente;
            LV_Sql:= LV_Sql|| ' AND    cod_situacion NOT IN (''BAA'',''BAP'')';
        END IF;

        EXECUTE IMMEDIATE LV_Sql;

        SVTabla :='TOL_LIMITE_TD';
        SVAct   :='S';

        LV_Sql:=          ' SELECT imp_limite ';
        LV_Sql:= LV_Sql|| ' FROM   tol_limite_td  ';
        LV_Sql:= LV_Sql|| ' WHERE  cod_limcons   = '''||LV_LimConsNue||'''';
        LV_Sql:= LV_Sql|| ' AND       SYSDATE BETWEEN fec_desde AND NVL(fec_hasta,SYSDATE)';

        EXECUTE IMMEDIATE LV_Sql INTO LN_ImpLimCons;

        SVTabla :='GA_INTARCEL';
        SVAct   :='U';

        LV_Sql:=         ' UPDATE ga_intarcel';
        LV_Sql:= LV_Sql|| ' SET    imp_limconsumo='''||LN_ImpLimCons||'''';

        IF EV_TipSujeto='A' THEN
            LV_Sql:= LV_Sql|| ' WHERE  num_abonado   = '||LN_Abonado;
        ELSIF EV_TipSujeto='C' THEN
            LV_Sql:= LV_Sql|| ' WHERE  cod_cliente = '||LN_Cliente;
        END IF;

        LV_Sql:= LV_Sql|| ' AND       SYSDATE BETWEEN fec_desde AND fec_hasta ';

        EXECUTE IMMEDIATE LV_Sql;
    END IF;

EXCEPTION
WHEN error_cliempsinabo THEN
    SVEstado    :='5';
    SVCode      :='0';
    SVErrm      :='El Cliente empresa no tiene abonados';
    SNCodMsg := 920;
WHEN error_cliempplan THEN
    SVEstado    :='5';
    SVCode      :='0';
    SVErrm      :='El Cliente empresa tiene abonados con distINTOs planes';
    SNCodMsg := 920;
WHEN error_maslimcli THEN
    SVEstado    :='5';
    SVCode      :=LV_Sql;
    SVErrm      :='El Cliente empresa tiene mas de un limite vigente para el mismo plan';
    SNCodMsg := 920;
WHEN error_cliennoempresa THEN
    SVEstado    :='5';
    SVCode      :='0';
    SVErrm      :='El Cliente no es de Tipo empresa no se puede regularizar por este medio ya que es solo para cliente empresas';
    SNCodMsg := 920;
WHEN error_planaciclo THEN
    SVEstado    :='5';
    SVCode      :='0';
    SVErrm      :='El CLiente o Abonado tiene un Cambio de plan al Corte de Ciclo pero no tiene limite al corte de ciclo';
    SNCodMsg := 920;
WHEN error_maslim THEN
    SVEstado    :='5';
    SVCode      :='El Abonado tiene mas de un limite vigente para el plan actual';
    SVErrm      :=LV_Sql;
    SNCodMsg := 920;
    SNEvento :=0;
WHEN OTHERS THEN
    ROLLBACK;
    SVEstado    :='4';
    SVCode      :=SQLCODE;
    SVErrm      :=SQLERRM;
    SNCodMsg := 920;
    SNEvento :=0;
    IF Not ge_errores_pg.mensajeerror(SNCodMsg, LV_MensajeError) THEN
        LV_MensajeError := 'Error No ClasIFicado';
    END IF;
    LV_DesError := 'pv_del_reglimcons_vigente_pr(' || EN_Sujeto || ','||EV_TipSujeto||')';
    LV_DesError :=LV_DesError ||'-T:'||SVTabla;
    LV_DesError :=LV_DesError ||'('||SVAct||')';
    LV_DesError :=LV_DesError ||'-'|| SVErrm;
    SNEvento :=ge_errores_pg.grabarpl( SNEvento,'PV',LV_MensajeError,'1.0',USER,'pv_del_reglimcons_vigente_pr',
    LV_Sql,SNCodMsg,LV_DesError);
END;

PROCEDURE pv_del_reglimcons_doble_pr    (EN_Sujeto    IN NUMBER,
                                        EV_TipSujeto  IN VARCHAR2,
                                        EV_Plan       IN VARCHAR2,
                                        SVEstado     OUT NOCOPY VARCHAR2,
                                        SVProc       OUT NOCOPY VARCHAR2,
                                        SNCodMsg     OUT NOCOPY NUMBER,
                                        SNEvento     OUT NOCOPY NUMBER,
                                        SVTabla      OUT NOCOPY VARCHAR2,
                                        SVAct        OUT NOCOPY VARCHAR2,
                                        SVCode       OUT NOCOPY VARCHAR2,
                                        SVErrm       OUT NOCOPY VARCHAR2) IS
/*
<Documentación TipoDoc = "PROCEDIMIENTO">
    <Elemento Nombre = "pv_del_reglimcons_doble_pr"
        Lenguaje = "PL/SQL"
        Fecha = "12-11-2008"
        Versión = "1.1.0"
        Diseñador = "German Espinoza Z."
        Programador="German Espinoza Z." Ambiente="BD">
        <Retorno>NA</Retorno>
        <Descripción>Regularizacion de limite de consumo si hay dos limites vigentes para el mismo plan se buscara cual es el correcto</Descripción>
        <Parámetros>
        <Entrada>
            <param nom="EN_Sujeto"    Tipo="NUMBER"  >Numero de abonado o codigo de Cliente</param>
            <param nom="EV_TipSujeto" Tipo="VARCHAR2">A: El EN_Sujeto es un numero de abonado C: el EN_Sujeto es un cliente</param>
            <param nom="EV_Plan"      Tipo="VARCHAR2">Codigo de plan a evaluar</param>
        </Entrada>
        <Salida>
            <param nom="SVEstado" Tipo="VARCHAR2">Estado de la ejecucion del procedimiento 3: OK-4:ERROR-5:Error en validacion</param>
            <param nom="SVProc"   Tipo="VARCHAR2">Nombre del procedo en donde ocurre un evento</param>
            <param nom="SVCodMsg" Tipo="VARCHAR2">Codigo de Mensaje del evento ocurrido</param>
            <param nom="SNEvento" Tipo="VARCHAR2">numero de evento</param>
            <param nom="SVTabla"  Tipo="VARCHAR2">Nombre de la tabla en donde ocurrio el evento</param>
            <param nom="SVAct"    Tipo="VARCHAR2">accion sobre la table en donde ocurre el evento</param>
            <param nom="SVCode"   Tipo="VARCHAR2">codigo del error oracle</param>
            <param nom="SVErrm"   Tipo="VARCHAR2">Descripcion del Error Oracle</param>
        </Salida>
        </Parámetros>
    </Elemento>
</Documentación>
*/
LV_DesError         VARCHAR2(1000);
LV_Sql              VARCHAR2(2000);
LV_MensajeError     VARCHAR2(2000);
LB_CerrarLim        BOOLEAN;
LB_CrearLim         BOOLEAN;
LN_ContLim          NUMBER;
LD_FecHasta         DATE;
LD_FecSYSDATE       DATE;
LV_Situacion        GA_ABOCEL.COD_SITUACION%TYPE;
LN_Abonado          GA_ABOCEL.NUM_ABONADO%TYPE;
LN_Cliente          GA_ABOCEL.COD_CLIENTE%TYPE;
LV_Uso              GA_ABOCEL.COD_USO%TYPE;
LV_Plan             GA_ABOCEL.COD_PLANTARIF%TYPE;
LV_UsoHibrido       GA_ABOCEL.COD_USO%TYPE;
LV_LimCons          GA_LIMITE_CLIABO_TO.COD_LIMCONS%TYPE;
LV_LimConsNue       GA_LIMITE_CLIABO_TO.COD_LIMCONS%TYPE;
LV_PlanACiclo       GA_FINCICLO.COD_PLANTARIF%TYPE;
LN_ImpLimCons       TOL_LIMITE_TD.IMP_LIMITE%TYPE;
LV_COD_COLOR        GE_CLIENTES.COD_COLOR%TYPE;
LV_COD_SEGMENTO     GE_CLIENTES.COD_SEGMENTO%TYPE;
error_unlimvig       EXCEPTION;
error_datos          EXCEPTION;
error_plannull       EXCEPTION;
error_planbolsa      EXCEPTION;
error_planaciclo     EXCEPTION;

BEGIN

    LB_CerrarLim  :=FALSE;
    LB_CrearLim   :=FALSE;

    SVEstado    := '3';
    SVProc      := 'PV_DEL_REGLIMCONS_DOBLE_PR';
    SNCodMsg    := 0;
    SNEvento    := 0;
    SVCode      := '0';
    SVErrm      := '0';

    IF EN_Sujeto Is Null Or EV_TipSujeto Is Null THEN
        RAISE error_datos;
    END IF;

    IF EV_Plan Is Null THEN
        RAISE error_plannull;
    END IF;

    IF EV_TipSujeto='A' THEN
        BEGIN
            --Se evalua si plan entrante no sea de bolsas
            SVTabla     :='TA_PLANTARIF';
            SVAct       :='S';

            LV_Sql:=          ' SELECT COUNT(1)';
            LV_Sql:= LV_Sql|| ' FROM   ta_plantarIF  ';
            LV_Sql:= LV_Sql|| ' WHERE  cod_producto  = 1 ';
            LV_Sql:= LV_Sql|| ' AND    cla_plantarIF = ''SRV''';
            LV_Sql:= LV_Sql|| ' AND    cod_plantarIF = '''||EV_Plan||'''';

            EXECUTE IMMEDIATE LV_Sql INTO LN_ContLim;

            IF LN_ContLim > 0 THEN
                RAISE error_planbolsa;
            END IF;

            SVTabla :='GA_ABOCEL';
            SVAct   :='S';

            LV_Sql:=          ' SELECT cod_situacion,num_abonado,cod_cliente,cod_uso,cod_plantarIF';
            LV_Sql:= LV_Sql|| ' FROM   ga_abocel ';
            LV_Sql:= LV_Sql|| ' WHERE  num_abonado=' || EN_Sujeto;

            EXECUTE IMMEDIATE LV_Sql INTO LV_Situacion,LN_Abonado,LN_Cliente,LV_Uso,LV_Plan;

            SELECT COD_COLOR,COD_SEGMENTO
            INTO LV_COD_COLOR, LV_COD_SEGMENTO
            FROM GE_CLIENTES
            WHERE cod_cliente =LN_Cliente;


            IF LV_Situacion IN ('BAA','BAP') THEN
                LB_CerrarLim:=TRUE;
                LB_CrearLim :=FALSE;
            Else
                LV_UsoHibrido:= Ge_Fn_Devvalparam('GA',1,'USO_HIBRIDO_GSM_TDMA');
                IF LV_Uso = LV_UsoHibrido THEN
                    LB_CerrarLim :=TRUE;
                    LB_CrearLim  :=FALSE;
                Else
                    LB_CerrarLim :=TRUE;
                    LB_CrearLim  :=TRUE;
                    IF LV_Plan <> EV_Plan THEN
                        SVTabla :='TOL_LIMITE_PLAN_TDA';
                        SVAct       :='S';

                        LV_Sql:= ' SELECT cod_limcons ';
                        LV_Sql:=LV_Sql|| ' FROM    tol_limite_plan_td ';
                        LV_Sql:=LV_Sql|| ' WHERE  cod_plantarIF='''||EV_Plan ||'''';
                        LV_Sql:=LV_Sql|| ' AND   id_subsegmento = '  || LV_COD_SEGMENTO;
                        LV_Sql:=LV_Sql|| ' AND   ind_prioridad >= '''|| LV_COD_COLOR || '''';
                        LV_Sql:=LV_Sql|| ' AND   SYSDATE BETWEEN fec_desde AND NVL(fec_hasta,SYSDATE)';
                        LV_Sql:=LV_Sql|| ' AND   ROWNUM <=1';
                        LV_Sql:=LV_Sql|| ' ORDER BY COD_LIMCONS ASC';

                        EXECUTE IMMEDIATE LV_Sql INTO LV_LimConsNue;
                    ELSE
                        SVTabla :='GA_LIMITE_CLIABO_TOA';
                        SVAct       :='S';

                        LV_Sql:=          ' SELECT COUNT(1) ';
                        LV_Sql:= LV_Sql|| ' FROM   ga_limite_cliabo_to  ';
                        LV_Sql:= LV_Sql|| ' WHERE  num_abonado   = '||LN_Abonado;
                        LV_Sql:= LV_Sql|| ' AND      cod_cliente   = '||LN_Cliente;
                        LV_Sql:= LV_Sql|| ' AND      cod_plantarIF = '''||EV_Plan||'''';
                        LV_Sql:= LV_Sql|| ' AND      SYSDATE BETWEEN fec_desde AND NVL(fec_hasta,SYSDATE) ';

                        EXECUTE IMMEDIATE LV_Sql INTO LN_ContLim;

                        IF LN_ContLim < 2 THEN
                            RAISE error_unlimvig;
                        Else
                            --valido si algunos de los limites del abonado es por defecto al plan.
                            SVTabla :='LIMITE_PLAN_CLIABOA';
                            SVAct       :='S';

                            LV_Sql:=          ' SELECT COUNT(1) ';
                            LV_Sql:= LV_Sql|| ' FROM     tol_limite_plan_td ';
                            LV_Sql:= LV_Sql|| ' WHERE    cod_plantarIF='''||EV_Plan ||'''';
                            LV_Sql:= LV_Sql|| ' AND   id_subsegmento = '  || LV_COD_SEGMENTO;
                            LV_Sql:= LV_Sql|| ' AND   ind_prioridad >= '''|| LV_COD_COLOR || '''';
                            LV_Sql:= LV_Sql|| ' AND      SYSDATE BETWEEN fec_desde AND NVL(fec_hasta,SYSDATE)';
                            LV_Sql:= LV_Sql|| ' AND      cod_limcons IN (SELECT cod_limcons';
                            LV_Sql:= LV_Sql|| '                        FROM   ga_limite_cliabo_to  ';
                            LV_Sql:= LV_Sql|| '                        WHERE  num_abonado   = '||LN_Abonado;
                            LV_Sql:= LV_Sql|| '                        AND  cod_cliente   = '||LN_Cliente;
                            LV_Sql:= LV_Sql|| '                        AND  cod_plantarIF = '''||EV_Plan||'''';
                            LV_Sql:= LV_Sql|| '                        AND  SYSDATE BETWEEN fec_desde AND NVL(fec_hasta,SYSDATE) ';
                            LV_Sql:= LV_Sql|| '                       )';

                            EXECUTE IMMEDIATE LV_Sql INTO LN_ContLim;

                            IF LN_ContLim > 0 THEN
                                --hay limites del abonado vigentes que son por defecto al plan
                                SVTabla :='LIMITE_PLAN_CLIABOB';
                                SVAct       :='S';

                                LV_Sql:=          ' SELECT cod_limcons ';
                                LV_Sql:= LV_Sql|| ' FROM     tol_limite_plan_td ';
                                LV_Sql:= LV_Sql|| ' WHERE  cod_plantarIF='''||EV_Plan ||'''';
                                LV_Sql:= LV_Sql|| ' AND   id_subsegmento = '  || LV_COD_SEGMENTO;
                                LV_Sql:= LV_Sql|| ' AND   ind_prioridad >= '''|| LV_COD_COLOR || '''';
                                LV_Sql:= LV_Sql|| ' AND      SYSDATE BETWEEN fec_desde AND NVL(fec_hasta,SYSDATE)';
                                LV_Sql:= LV_Sql|| ' AND      cod_limcons IN (SELECT cod_limcons';
                                LV_Sql:= LV_Sql|| '                        FROM   ga_limite_cliabo_to  ';
                                LV_Sql:= LV_Sql|| '                        WHERE  num_abonado   = '||LN_Abonado;
                                LV_Sql:= LV_Sql|| '                        AND  cod_cliente   = '||LN_Cliente;
                                LV_Sql:= LV_Sql|| '                        AND  cod_plantarIF = '''||EV_Plan||'''';
                                LV_Sql:= LV_Sql|| '                        AND  SYSDATE BETWEEN fec_desde AND NVL(fec_hasta,SYSDATE) ';
                                LV_Sql:= LV_Sql|| '                       )';

                                EXECUTE IMMEDIATE LV_Sql INTO LV_LimConsNue;

                            ELSIF LN_ContLim=0 THEN
                                --valido si los limites del abonados son opcionales al plan
                                SVTabla :='LIMITE_PLAN_CLIABOC';
                                SVAct       :='S';

                                LV_Sql:=          ' SELECT count(1) ';
                                LV_Sql:= LV_Sql|| ' FROM     tol_limite_plan_td';
                                LV_Sql:= LV_Sql|| ' WHERE  cod_plantarIF = '''||EV_Plan||'''';
                                LV_Sql:= LV_Sql|| ' AND   id_subsegmento = '  || LV_COD_SEGMENTO;
                                LV_Sql:= LV_Sql|| ' AND   ind_prioridad >= '''|| LV_COD_COLOR || '''';
                                LV_Sql:= LV_Sql|| ' AND      SYSDATE BETWEEN fec_desde AND NVL(fec_hasta,SYSDATE)';
                                LV_Sql:= LV_Sql|| ' AND      cod_limcons IN (SELECT cod_limcons';
                                LV_Sql:= LV_Sql|| '                        FROM   ga_limite_cliabo_to  ';
                                LV_Sql:= LV_Sql|| '                        WHERE  num_abonado   = '||LN_Abonado;
                                LV_Sql:= LV_Sql|| '                        AND  cod_cliente   = '||LN_Cliente;
                                LV_Sql:= LV_Sql|| '                        AND  cod_plantarIF = '''||EV_Plan||'''';
                                LV_Sql:= LV_Sql|| '                          AND    SYSDATE BETWEEN fec_desde AND NVL(fec_hasta,SYSDATE)';
                                LV_Sql:= LV_Sql|| '                         )';

                                EXECUTE IMMEDIATE LV_Sql INTO LN_ContLim;

                                IF LN_ContLim = 0 THEN
                                    --Ningun limite es opcional al plan, se busca el por defecto
                                    SVTabla :='TOL_LIMITE_PLAN_TDA';
                                    SVAct       :='S';

                                    LV_Sql:=          ' SELECT cod_limcons ';
                                    LV_Sql:= LV_Sql|| ' FROM    tol_limite_plan_td ';
                                    LV_Sql:= LV_Sql|| ' WHERE  cod_plantarIF='''||EV_Plan ||'''';
                                    LV_Sql:= LV_Sql|| ' AND   id_subsegmento = '  || LV_COD_SEGMENTO;
                                    LV_Sql:= LV_Sql|| ' AND   ind_prioridad >= '''|| LV_COD_COLOR || '''';
                                    LV_Sql:= LV_Sql|| ' AND     SYSDATE BETWEEN fec_desde AND NVL(fec_hasta,SYSDATE)';
                                    LV_Sql:=LV_Sql || ' AND   ROWNUM <=1';
                                    LV_Sql:=LV_Sql || ' ORDER BY COD_LIMCONS ASC';

                                    EXECUTE IMMEDIATE LV_Sql INTO LV_LimConsNue;

                                ELSIF LN_ContLim=1 THEN
                                    --hay un limite que es opcional al plan por lo que ese se va a asociar al abonado
                                    SVTabla :='LIMITE_PLAN_CLIABOD';
                                    SVAct       :='S';

                                    LV_Sql:=          ' SELECT cod_limcons ';
                                    LV_Sql:= LV_Sql|| ' FROM    tol_limite_plan_td';
                                    LV_Sql:= LV_Sql|| ' WHERE  cod_plantarIF = '''||EV_Plan||'''';
                                    LV_Sql:= LV_Sql|| ' AND   id_subsegmento = '  || LV_COD_SEGMENTO;
                                    LV_Sql:= LV_Sql|| ' AND   ind_prioridad >= '''|| LV_COD_COLOR || '''';
                                    LV_Sql:= LV_Sql|| ' AND     SYSDATE BETWEEN fec_desde AND NVL(fec_hasta,SYSDATE)';
                                    LV_Sql:= LV_Sql|| ' AND     cod_limcons IN (SELECT cod_limcons';
                                    LV_Sql:= LV_Sql|| '                        FROM   ga_limite_cliabo_to  ';
                                    LV_Sql:= LV_Sql|| '                        WHERE  num_abonado   = '||LN_Abonado;
                                    LV_Sql:= LV_Sql|| '                        AND  cod_cliente   = '||LN_Cliente;
                                    LV_Sql:= LV_Sql|| '                        AND  cod_plantarIF = '''||EV_Plan||'''';
                                    LV_Sql:= LV_Sql|| '                         AND     SYSDATE BETWEEN fec_desde AND NVL(fec_hasta,SYSDATE)';
                                    LV_Sql:= LV_Sql|| '                         )';
                                    EXECUTE IMMEDIATE LV_Sql INTO LV_LimConsNue;
                                ELSIF LN_ContLim>1 THEN
                                    --hay mas de un limite que tiene el abonado que es opcional al plan, se comparan con el limite del abonado
                                    SVTabla :='LIMITE_PLAN_CLIABOCELA';
                                    SVAct       :='S';

                                    LV_Sql:=          ' SELECT COUNT(1)';
                                    LV_Sql:= LV_Sql|| ' FROM   tol_limite_plan_td a,ga_abocel b';
                                    LV_Sql:= LV_Sql|| ' WHERE  a.cod_plantarIF = '''||EV_Plan||'''';
                                    LV_Sql:= LV_Sql|| ' AND   id_subsegmento = '  || LV_COD_SEGMENTO;
                                    LV_Sql:= LV_Sql|| ' AND   ind_prioridad >= '''|| LV_COD_COLOR || '''';
                                    LV_Sql:= LV_Sql|| ' AND    SYSDATE BETWEEN a.fec_desde AND NVL(a.fec_hasta,SYSDATE)';
                                    LV_Sql:= LV_Sql|| ' AND    a.cod_limcons IN (SELECT cod_limcons';
                                    LV_Sql:= LV_Sql|| '                           FROM   ga_limite_cliabo_to';
                                    LV_Sql:= LV_Sql|| '                          WHERE  num_abonado   = '||LN_Abonado;
                                    LV_Sql:= LV_Sql|| '                          AND     cod_cliente   = '||LN_Cliente;
                                    LV_Sql:= LV_Sql|| '                          AND     cod_plantarIF = '''||EV_Plan||'''';
                                    LV_Sql:= LV_Sql|| '                          AND     SYSDATE BETWEEN fec_desde AND NVL(fec_hasta,SYSDATE)';
                                    LV_Sql:= LV_Sql|| '                     )';
                                    LV_Sql:= LV_Sql|| ' AND b.num_abonado   = '||LN_Abonado;
                                    LV_Sql:= LV_Sql|| ' AND    b.cod_cliente   = '||LN_Cliente;
                                    LV_Sql:= LV_Sql|| ' AND b.cod_limconsumo=a.cod_limcons';

                                    EXECUTE IMMEDIATE LV_Sql INTO LN_ContLim;

                                    IF LN_ContLim = 0 THEN
                                    --ningun limite de la ga_limite_cliabo_to lo tiene el abonado en ga_abocel
                                        SVTabla :='TOL_LIMITE_PLAN_TDA';
                                        SVAct       :='S';

                                        LV_Sql:=          ' SELECT cod_limcons ';
                                        LV_Sql:= LV_Sql|| ' FROM   tol_limite_plan_td ';
                                        LV_Sql:= LV_Sql|| ' WHERE  cod_plantarIF='''||EV_Plan ||'''';
                                        LV_Sql:= LV_Sql|| ' AND   id_subsegmento = '  || LV_COD_SEGMENTO;
                                        LV_Sql:= LV_Sql|| ' AND   ind_prioridad >= '''|| LV_COD_COLOR || '''';
                                        LV_Sql:= LV_Sql|| ' AND    SYSDATE BETWEEN fec_desde AND NVL(fec_hasta,SYSDATE)';
                                        LV_Sql:=LV_Sql || ' AND   ROWNUM <=1';
                                        LV_Sql:=LV_Sql || ' ORDER BY COD_LIMCONS ASC';

                                        EXECUTE IMMEDIATE LV_Sql INTO LV_LimConsNue;
                                    ELSE
                                        --tiene un limite de la ga_limite_cliabo_to lo tiene el abonado en ga_abocel
                                        SVTabla :='GA_ABOCEL_B';
                                        SVAct   :='S';

                                        LV_Sql:=          ' SELECT cod_limconsumo ';
                                        LV_Sql:= LV_Sql|| ' FROM   ga_abocel ';
                                        LV_Sql:= LV_Sql|| ' WHERE  num_abonado   = '||LN_Abonado;
                                        LV_Sql:= LV_Sql|| ' AND    cod_cliente   = '||LN_Cliente;

                                        EXECUTE IMMEDIATE LV_Sql INTO LV_LimConsNue;
                                    END IF; --ENDIF LN_ContLim=0 THEN

                                END IF; --ENDIF LN_ContLim=0 THEN
                            END IF; --ENDIF LN_ContLim>0 THEN
                        END IF; --ENDIF LN_ContLim<2 THEN
                    END IF; --el plan entrante no es el del abonado
                END IF; --ENDIF LV_Uso=LV_UsoHibrido THEN
            END IF; --ENDIF LV_Situacion IN ('BAA','BAP') THEN
        EXCEPTION
        WHEN NO_DATA_FOUND THEN
            LB_CerrarLim  :=TRUE;
            LB_CrearLim   :=FALSE;
        END;
    END IF;

    LD_FecSYSDATE:=SYSDATE;

    --::::::::::::: QUITAR VIGENCIA LIMITE DE CONSUMO ACTUAL :::::::::::::
    IF LB_CerrarLim THEN

        SVTabla :='GA_LIMITE_CLIABO_TO';
        SVAct   :='U';

        LV_Sql:=         ' UPDATE ga_limite_cliabo_to';
        LV_Sql:= LV_Sql|| ' SET    fec_hasta=TO_DATE('''||TO_CHAR(LD_FecSYSDATE,'dd-mm-yyyy hh24:mi:ss')||''',''dd-mm-yyyy hh24:mi:ss'')';
        LV_Sql:= LV_Sql|| ' WHERE  num_abonado   = '||LN_Abonado;
        LV_Sql:= LV_Sql|| ' AND    cod_cliente   = '||LN_Cliente;
        LV_Sql:= LV_Sql|| ' AND    cod_plantarIF = '''||EV_Plan||'''';
        LV_Sql:= LV_Sql|| ' AND    SYSDATE BETWEEN fec_desde AND NVL(fec_hasta,SYSDATE) ';

        EXECUTE IMMEDIATE LV_Sql;

    END IF;

    --::::::::::::: CREAR LIMITE DE CONSUMO :::::::::::::
    IF LB_CrearLim THEN
        IF EV_TipSujeto='A' THEN
            BEGIN
                SVTabla :='GA_FINCICLOA';
                SVAct   :='S';

                LV_Sql:=          ' SELECT cod_plantarIF';
                LV_Sql:= LV_Sql|| ' FROM   ga_finciclo';
                LV_Sql:= LV_Sql|| ' WHERE  cod_cliente ='|| LN_Cliente;
                LV_Sql:= LV_Sql|| ' AND       num_abonado ='|| LN_Abonado;
                LV_Sql:= LV_Sql|| ' AND       cod_plantarIF IS NOT NULL';

                EXECUTE IMMEDIATE LV_Sql INTO LV_PlanACiclo;

            EXCEPTION
            WHEN NO_DATA_FOUND THEN
                LV_PlanACiclo:=NULL;
            END;
        ELSIF EV_TipSujeto='C' THEN

            SVTabla :='GA_FINCICLOB';
            SVAct   :='S';

            LV_Sql:=          ' SELECT COUNT(1)';
            LV_Sql:= LV_Sql|| ' FROM   ga_finciclo';
            LV_Sql:= LV_Sql|| ' WHERE  cod_cliente ='|| LN_Cliente;
            LV_Sql:= LV_Sql|| ' AND       cod_plantarIF IS NOT NULL';

            EXECUTE IMMEDIATE LV_Sql INTO LN_ContLim;

            IF LN_ContLim = 0 THEN
                LV_PlanACiclo:=NULL;
            ELSE
                SVTabla :='GA_FINCICLOC';
                SVAct   :='S';

                LV_Sql:=          ' SELECT cod_plantarIF';
                LV_Sql:= LV_Sql|| ' FROM   ga_finciclo';
                LV_Sql:= LV_Sql|| ' WHERE  cod_cliente ='|| LN_Cliente;
                LV_Sql:= LV_Sql|| ' AND      cod_plantarIF IS NOT NULL AND ROWNUM<=1';

                EXECUTE IMMEDIATE LV_Sql INTO LV_PlanACiclo;
            END IF;
        END IF;

        IF LV_PlanACiclo Is Null THEN
            LD_FecHasta:=NULL;
        ELSE
            BEGIN
                SVTabla :='GA_LIMITE_CLIABO_TOC';
                SVAct       :='S';

                LV_Sql:=          ' SELECT fec_desde-1/86900 ';
                LV_Sql:= LV_Sql|| ' FROM   ga_limite_cliabo_to  ';
                LV_Sql:= LV_Sql|| ' WHERE  num_abonado   = '||LN_Abonado;
                LV_Sql:= LV_Sql|| ' AND      cod_cliente   = '||LN_Cliente;
                LV_Sql:= LV_Sql|| ' AND      cod_plantarIF = '''||LV_PlanACiclo||'''';
                LV_Sql:= LV_Sql|| ' AND      fec_desde>SYSDATE ';

                EXECUTE IMMEDIATE LV_Sql INTO LD_FecHasta;
            EXCEPTION
            WHEN NO_DATA_FOUND THEN
                RAISE error_planaciclo;
            END;
        END IF;

        SVTabla :='GA_LIMITE_CLIABO_TO';
        SVAct   :='I';

        LV_Sql:=          ' INSERT INTO ga_limite_cliabo_to';
        LV_Sql:= LV_Sql|| ' (COD_CLIENTE, NUM_ABONADO, COD_LIMCONS, FEC_DESDE, FEC_HASTA, NOM_USUARORA';
        LV_Sql:= LV_Sql|| ' , FEC_ASIGNACION, EST_APLICA_TOL, FEC_APLICA_TOL, COD_PLANTARIF)';
        LV_Sql:= LV_Sql|| ' VALUES';
        LV_Sql:= LV_Sql|| ' ('||LN_Cliente||','||LN_Abonado||','''||LV_LimConsNue||''',TO_DATE('''||TO_CHAR(LD_FecSYSDATE+1/86900,'dd-mm-yyyy hh24:mi:ss')||''',''dd/mm/yyyy hh24:mi:ss'')';
        LV_Sql:= LV_Sql|| ' ,TO_DATE('''||TO_CHAR(LD_FecHasta,'dd-mm-yyyy hh24:mi:ss')||''',''dd/mm/yyyy hh24:mi:ss''),USER';
        LV_Sql:= LV_Sql|| ' ,SYSDATE,NULL,NULL,'''||EV_Plan||''')';

        EXECUTE IMMEDIATE LV_Sql;

        SVTabla :='GA_ABOCEL';
        SVAct   :='U';

        LV_Sql:=         ' UPDATE ga_abocel';
        LV_Sql:= LV_Sql|| ' SET    cod_limconsumo='''||LV_LimConsNue||'''';

        IF EV_TipSujeto='A' THEN
            LV_Sql:= LV_Sql|| ' WHERE  num_abonado   = '||LN_Abonado;
        ELSIF EV_TipSujeto='C' THEN
            LV_Sql:= LV_Sql|| ' WHERE  cod_cliente = '||LN_Cliente;
            LV_Sql:= LV_Sql|| ' AND    cod_situacion NOT IN (''BAA'',''BAP'')';
        END IF;

        EXECUTE IMMEDIATE LV_Sql;

        SVTabla :='tol_limite_td';
        SVAct   :='S';


        LV_Sql:=          ' SELECT imp_limite ';
        LV_Sql:= LV_Sql|| ' FROM   tol_limite_td  ';
        LV_Sql:= LV_Sql|| ' WHERE  cod_limcons   = '''||LV_LimConsNue||'''';
        LV_Sql:= LV_Sql|| ' AND       SYSDATE BETWEEN fec_desde AND NVL(fec_hasta,SYSDATE)';

        EXECUTE IMMEDIATE LV_Sql INTO LN_ImpLimCons;

        SVTabla :='GA_INTARCEL';
        SVAct   :='U';

        LV_Sql:=         ' UPDATE ga_intarcel';
        LV_Sql:= LV_Sql|| ' SET    imp_limconsumo='''||LN_ImpLimCons||'''';

        IF EV_TipSujeto='A' THEN
            LV_Sql:= LV_Sql|| ' WHERE  num_abonado   = '||LN_Abonado;
        ELSIF EV_TipSujeto='C' THEN
            LV_Sql:= LV_Sql|| ' WHERE  cod_cliente = '||LN_Cliente;
        END IF;

        LV_Sql:= LV_Sql|| ' AND       SYSDATE BETWEEN fec_desde AND fec_hasta ';

        EXECUTE IMMEDIATE LV_Sql;

    END IF;

EXCEPTION
WHEN error_unlimvig THEN
    SVEstado    :='5';
    SVCode      :='0';
    SVErrm      :='Solo tiene un limite vigente para este plan';
    SNCodMsg := 920;
WHEN error_datos THEN
    SVEstado    :='5';
    SVCode      :='0';
    SVErrm      :='Los Parametros de entrada son nulos';
    SNCodMsg := 920;
WHEN error_plannull THEN
    SVEstado    :='5';
    SVCode      :='0';
    SVErrm      :='El plan entrante es null ';
    SNCodMsg := 920;
WHEN error_planbolsa THEN
    SVEstado    :='5';
    SVCode      :='0';
    SVErrm      :='El plan entrante es de tipo bolsa: '||EV_Plan;
    SNCodMsg := 920;
WHEN error_planaciclo THEN
    SVEstado    :='5';
    SVCode      :='0';
    SVErrm      :='El CLiente o Abonado tiene un Cambio de plan al Corte de Ciclo pero no tiene limite al corte de ciclo';
    SNCodMsg := 920;
WHEN OTHERS THEN
    ROLLBACK;
    SVEstado    :='4';
    SVCode      :=SQLCODE;
    SVErrm      :=SQLERRM;
    SNCodMsg := 920;
    SNEvento :=0;
    IF Not ge_errores_pg.mensajeerror(SNCodMsg, LV_MensajeError) THEN
        LV_MensajeError := 'Error No ClasIFicado';
    END IF;
    LV_DesError := 'pv_del_reglimcons_vigente_pr(' || EN_Sujeto || ','||EV_TipSujeto||')';
    LV_DesError :=LV_DesError ||'-T:'||SVTabla;
    LV_DesError :=LV_DesError ||'('||SVAct||')';
    LV_DesError :=LV_DesError ||'-'|| SVErrm;
    SNEvento :=ge_errores_pg.grabarpl( SNEvento,'PV',LV_MensajeError,'1.0',USER,'pv_del_reglimcons_vigente_pr',
    LV_Sql,SNCodMsg,LV_DesError);
END;

PROCEDURE pv_pasohist_aciclo_limcons_pr(EN_Cliente       IN  GA_ABOCEL.cod_cliente%TYPE,
                                        EN_Abonado       IN  GA_ABOCEL.NUM_ABONADO%TYPE,
                                        EV_CausaHist     IN  VARCHAR2,
                                        SVEstado         OUT NOCOPY VARCHAR2,
                                        SVProc           OUT NOCOPY VARCHAR2,
                                        SNCodMsg         OUT NOCOPY NUMBER,
                                        SNEvento         OUT NOCOPY NUMBER,
                                        SVTabla          OUT NOCOPY VARCHAR2,
                                        SVAct            OUT NOCOPY VARCHAR2,
                                        SVCode           OUT NOCOPY VARCHAR2,
                                        SVErrm           OUT NOCOPY VARCHAR2) IS

/*
<Documentación TipoDoc = "PROCEDIMIENTO">
    <Elemento Nombre = "PV_PASOHIST_ACICLO_LIMCONS_PR"
        Lenguaje = "PL/SQL"
        Fecha = "07-11-2008"
        Versión = "1.2.0"
        Diseñador = "German Espinoza Z."
        Programador="German Espinoza Z." Ambiente="BD">
        <Retorno>NA</Retorno>
        <Descripción>Paso a Historico de Limite de Consumo a Futuro</Descripción>
        <Parámetros>
            <Entrada>
                <param nom="EN_Cliente"   Tipo="NUMBER"  >Codigo del Cliente</param>
                <param nom="EN_Abonado"   Tipo="NUMBER"  >Numero de Abonado</param>
                <param nom="EV_CausaHist" Tipo="VARCHAR2">codigo de Causa del paso a historico</param>
            </Entrada>
            <Salida>
                <param nom="SVEstado" Tipo="VARCHAR2">Estado de la ejecucion del procedimiento 3: OK-4:ERROR</param>
                <param nom="SVProc"   Tipo="VARCHAR2">Nombre del procedo en donde ocurre un evento</param>
                <param nom="SVCodMsg" Tipo="VARCHAR2">Codigo de Mensaje del evento ocurrido</param>
                <param nom="SNEvento" Tipo="VARCHAR2">numero de evento</param>
                <param nom="SVTabla"  Tipo="VARCHAR2">Nombre de la tabla en donde ocurrio el evento</param>
                <param nom="SVAct"    Tipo="VARCHAR2">accion sobre la table en donde ocurre el evento</param>
                <param nom="SVCode"   Tipo="VARCHAR2">codigo del error oracle</param>
                <param nom="SVErrm"   Tipo="VARCHAR2">Descripcion del Error Oracle</param>
            </Salida>
        </Parámetros>
    </Elemento>
</Documentación>
*/

LV_DesError         VARCHAR2(1000);
LV_Sql              VARCHAR2(2000);
LV_MensajeError     VARCHAR2(2000);

BEGIN

    SVEstado    :='3';
    SVProc      :='PV_PASOHIST_ACICLO_LIMCONS_PR';
    SNCodMsg    :=0;
    SNEvento    :=0;
    SVCode      :='0';
    SVErrm      :='0';

    SVTabla :='GA_LIMITE_CLIABO_TH';
    SVAct   :='I';

    LV_Sql:=       ' INSERT INTO ga_limite_cliabo_th';
    LV_Sql:=LV_Sql||' (cod_cliente, num_abonado, cod_limcons, cod_plantarIF, fec_desde, fec_historico, fec_hasta';
    LV_Sql:=LV_Sql||' , nom_usuarora, fec_asignacion, cod_causa_hist, est_aplica_tol, fec_aplica_tol)';
    LV_Sql:=LV_Sql||' SELECT cod_cliente, num_abonado, cod_limcons, cod_plantarIF, fec_desde,SYSDATE, fec_hasta';
    LV_Sql:=LV_Sql||' , nom_usuarora, fec_asignacion,SUBSTR('''||EV_CausaHist||''',1,5), est_aplica_tol, fec_aplica_tol';
    LV_Sql:=LV_Sql||' FROM   ga_limite_cliabo_to';
    LV_Sql:=LV_Sql||' WHERE  cod_cliente='||EN_Cliente;
    LV_Sql:=LV_Sql||' AND    num_abonado='||EN_Abonado;
    LV_Sql:=LV_Sql||' AND    fec_desde>SYSDATE';

    EXECUTE IMMEDIATE LV_Sql;

    SVTabla :='GA_LIMITE_CLIABO_TO';
    SVAct   :='S';

    LV_Sql:=       ' DELETE ga_limite_cliabo_to';
    LV_Sql:=LV_Sql||' WHERE  cod_cliente='||EN_Cliente;
    LV_Sql:=LV_Sql||' AND    num_abonado='||EN_Abonado;
    LV_Sql:=LV_Sql||' AND    fec_desde>SYSDATE';

    EXECUTE IMMEDIATE LV_Sql;

    EXCEPTION
    WHEN OTHERS THEN
    SVEstado    :='4';
    SVCode      :=SQLCODE;
    SVErrm      :=SQLERRM;
    SNCodMsg := 925;
    IF Not ge_errores_pg.mensajeerror(SNCodMsg, LV_MensajeError) THEN
        LV_MensajeError := 'Error No ClasIFicado';
    END IF;
    LV_DesError := 'pv_pasohist_aciclo_limcons_pr(' || EN_Cliente || ','||EN_Abonado||','||EV_CausaHist||')';
    LV_DesError :=LV_DesError ||'-T:'||SVTabla;
    LV_DesError :=LV_DesError ||'('||SVAct||')';
    LV_DesError :=LV_DesError ||'-'|| SVErrm;
    SNEvento :=ge_errores_pg.grabarpl( SNEvento,'PV',LV_MensajeError,'1.0',USER,'pv_pasohist_aciclo_limcons_pr',
    LV_Sql,SNCodMsg,LV_DesError);
END pv_pasohist_aciclo_limcons_pr;
END PV_LIMITE_CONSUMO_PG;
/
SHOW ERRORS
