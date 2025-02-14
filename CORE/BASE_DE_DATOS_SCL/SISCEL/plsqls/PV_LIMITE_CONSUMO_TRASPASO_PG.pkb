CREATE OR REPLACE PACKAGE BODY PV_LIMITE_CONSUMO_TRASPASO_PG AS



PROCEDURE PV_LIMITE_INTARCEL_PR(EN_pnSujeto IN NUMBER,
                                 EV_LcNuevo  IN  VARCHAR2,
                                                         EV_FecDesde   IN  VARCHAR2,
                                                         pvimp_limcons IN  number,
                                                         SV_ErrorOra      out VARCHAR2,
                                                         SV_ErrorOraGlosa out NOCOPY VARCHAR2,
                                                         SV_ErrorAplic    out NOCOPY VARCHAR2
                                                         )
IS

/*
<Documentación TipoDoc = "Procedimiento">
   <Elemento Nombre = "PV_LIMITE_INTARCEL_PR"
      Lenguaje="PL/SQL" Fecha="27-08-2007"
      Versión="1.0"
      Diseñador="Roberto Rodriguez G. "
      Programador="Roberto Rodriguez G."
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


cursor cur_abonado is
select a.COD_CLIENTE,a.NUM_ABONADO,a.IND_NUMERO,
          a.FEC_DESDE,a.FEC_HASTA,a.IMP_LIMCONSUMO,
          a.IND_FRIENDS,a.IND_DIASESP,a.COD_CELDA,
          a.TIP_PLANTARIF,a.COD_PLANTARIF,a.NUM_SERIE,
          a.NUM_CELULAR,a.COD_CARGOBASICO,b.COD_CICLO,
          a.COD_PLANCOM,a.COD_PLANSERV,a.COD_GRPSERV,
          a.COD_GRUPO,a.COD_PORTADOR,a.COD_USO
from ga_intarcel a, ga_abocel b
where a.cod_cliente = EN_pnSujeto
and a.cod_cliente = b.cod_cliente
and a.num_abonado = b.num_abonado
and b.cod_situacion not in ('BAA','BAP')
and sysdate between fec_desde and fec_hasta;

vSeqErr                 NUMBER;
VP_SQLCODE              VARCHAR2(15);
VP_SQLERRM              VARCHAR2(255);
V_ERROR                 VARCHAR2(1) := '0';
VP_PROC                 VARCHAR2(50);
VP_TABLA                VARCHAR2(50);
VP_ACT                  VARCHAR2(1);
vDesCadena              VARCHAR2(255);
vInd                    number(1):=0;

vFormatoSel2    GED_PARAMETROS.VAL_PARAMETRO%TYPE;
vFormatoSel7    GED_PARAMETROS.VAL_PARAMETRO%TYPE;

V_fec_desdeciclo date;
V_coc_ciclfact   fa_ciclfact.cod_ciclfact%TYPE;

ERROR_PROCESO_INTARCEL    EXCEPTION;

begin

vFormatoSel2 := ge_fn_devvalparam('GE', 1, 'FORMATO_SEL2');
vFormatoSel7 := ge_fn_devvalparam('GE', 1, 'FORMATO_SEL7');

for reg_abonado in cur_abonado loop

        begin

                                select b.FEC_hastallam + (1/64000) , b.cod_ciclfact
                                into V_fec_desdeciclo, V_coc_ciclfact
                                from fa_ciclfact b
                                where b.cod_ciclo = reg_abonado.cod_ciclo
                                and sysdate between b.fec_desdellam and b.fec_hastallam;

                                IF vInd = 0 THEN
                                        PV_LIMITE_CONSUMO_RANGO_PG.PV_LIMITE_CONSUMO_RANGO_PR(1,reg_abonado.cod_cliente, 0 , EV_LcNuevo,
                                        TO_DATE(EV_FecDesde, vFormatoSel2||' '||vFormatoSel7), pvimp_limcons,VP_PROC, VP_TABLA,
                                        VP_ACT, VP_SQLCODE, VP_SQLERRM,V_ERROR);

                                        vInd := 1;

                                END IF;

                                PV_LIMITE_CONSUMO_RANGO_PG.PV_LIMITE_CONSUMO_RANGO_PR(1,reg_abonado.cod_cliente, reg_abonado.num_abonado , EV_LcNuevo,
                                TO_DATE(EV_FecDesde, vFormatoSel2||' '||vFormatoSel7),pvimp_limcons,VP_PROC,VP_TABLA,
                                VP_ACT,
                                VP_SQLCODE,VP_SQLERRM,V_ERROR);

                                INSERT INTO ga_finciclo
                                (COD_CLIENTE, NUM_ABONADO, COD_CICLFACT,
                                COD_PRODUCTO, TIP_PLANTARIF, COD_PLANTARIF,
                                COD_CARGOBASICO,FEC_DESDELLAM, NUM_DIAS)
                                VALUES (reg_abonado.cod_cliente,reg_abonado.num_abonado,V_coc_ciclfact,
                                1,reg_abonado.TIP_PLANTARIF, -1,
                                reg_abonado.COD_CARGOBASICO, V_fec_desdeciclo,1);


                                IF V_ERROR > 0 THEN
                                      SV_ErrorAplic := '4';
                                      SV_ErrorOra := TO_CHAR(SQLCODE);
                                      SV_ErrorOraGlosa := SUBSTR(SQLERRM,1,60);
                                      RAISE ERROR_PROCESO_INTARCEL;
                                END IF;

        exception when others then
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
                            pvimp_limcons   IN NUMBER,
                            pvCodValor      OUT NOCOPY VARCHAR2,
                            pvErrorAplic    OUT NOCOPY VARCHAR2,
                            pvErrorGlosa    OUT NOCOPY VARCHAR2,
                            pvErrorOra      OUT NOCOPY VARCHAR2,
                            pvErrorOraGlosa OUT NOCOPY VARCHAR2,
                            pvTrace         OUT NOCOPY VARCHAR2,
                            EVCodplantarif  IN VARCHAR2:=NULL
                            ,EVTipoMovimiento IN VARCHAR2:=NULL )
IS
    nCodCliente      GE_CLIENTES.COD_CLIENTE%TYPE;
    nCodClienteDest  GE_CLIENTES.COD_CLIENTE%TYPE;
    nCodCliHist      GE_CLIENTES.COD_CLIENTE%TYPE;
    nNumAbonadoHist  GA_ABOCEL.NUM_ABONADO%TYPE;
    nNumAbonadoOrig  GA_ABOCEL.NUM_ABONADO%TYPE;
    nCantAbonados    NUMBER;
    nCantAboHist     NUMBER;
    vModifca         VARCHAR2(5);
    nNumAbonado      GA_ABOCEL.NUM_ABONADO%TYPE;
    nNumAboAux       GA_ABOCEL.NUM_ABONADO%TYPE;
    vCodLimcons      GA_LIMITE_CLIABO_TO.COD_LIMCONS%TYPE;
    vFecDesde        GA_LIMITE_CLIABO_TO.FEC_DESDE%TYPE;
    vFecDesdeNuevo   GA_LIMITE_CLIABO_TO.FEC_DESDE%TYPE;
    vFecDesdeNuevo_AUX   GA_LIMITE_CLIABO_TO.FEC_DESDE%TYPE;


    vFecHastaNuevo   GA_LIMITE_CLIABO_TO.FEC_HASTA%TYPE;
    vFormatoSel2     GED_PARAMETROS.VAL_PARAMETRO%TYPE;
    vFormatoSel7     GED_PARAMETROS.VAL_PARAMETRO%TYPE;
    vCodCausaHist    GA_LIMITE_CLIABO_TH.COD_CAUSA_HIST%TYPE;
    vCodPlantarif    TA_PLANTARIF.COD_PLANTARIF%TYPE;
    vCodLimconsNuevo GA_LIMITE_CLIABO_TO.COD_LIMCONS%TYPE;
    LV_TipHibrido    GED_PARAMETROS.VAL_PARAMETRO%TYPE;
    LV_TipPlan       TA_PLANTARIF.COD_TIPLAN%TYPE;
    LV_TipPlan2      TA_PLANTARIF.COD_TIPLAN%TYPE;   
    vFecDesdeProximo        GA_LIMITE_CLIABO_TO.FEC_DESDE%TYPE;
    vCodLimConsActual   GA_LIMITE_CLIABO_TO.COD_LIMCONS%TYPE;
    YA_EXISTE                   VARCHAR2(1);

    VP_PROC             VARCHAR2(50);
    VP_TABLA            VARCHAR2(50);
    VP_ACT              VARCHAR2(1);
    VP_SQLCODE          VARCHAR2(15);
    VP_SQLERRM          VARCHAR2(255);
    V_ERROR             VARCHAR2(1) := '0';

    nNumTransaccion  GA_TRANSACABO.NUM_TRANSACCION%TYPE;
    nCodRetorno      GA_TRANSACABO.COD_RETORNO%TYPE;
    vDesCadena       GA_TRANSACABO.DES_CADENA%TYPE;
    vSeqErr         NUMBER;

    V_fec_desdeciclo date;
    V_coc_ciclfact   fa_ciclfact.cod_ciclfact%TYPE;
    v_cod_ciclo              ga_abocel.cod_ciclo%type;
    LV_AUX_PLAN  TA_PLANTARIF.COD_PLANTARIF%TYPE;
    COD_CLIENTE_AUX_ANT  GA_ABOCEL.COD_CLIENTE%TYPE;


    ERROR_PROCESO    EXCEPTION;

BEGIN
        DBMS_OUTPUT.PUT_LINE('PV_MODIFICA_LC_PR');
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
        vModifca        := 'FALSE';
        YA_EXISTE := 'N';

    IF GE_FN_DEVVALPARAM('GE', 1, 'IND_TOL') = 'N'
    THEN

        pvCodValor := 'TRUE';
        IF pvTipSujeto = 'A' THEN /* Operacion por Abonado */
                 vCodLimconsNuevo := '-1';
                 nNumAbonado := pnSujeto;

                 SELECT COD_CLIENTE
                 INTO   nCodCliente
                 FROM   GA_ABOCEL
                 WHERE  NUM_ABONADO = nNumAbonado;


                 IF pvFecDesde = ' ' OR pvFecDesde IS NULL OR pvFecDesde = '*' THEN
                        vFecDesdeNuevo := SYSDATE;
                 ELSE
                        SELECT TO_DATE(pvFecDesde, vFormatoSel2||' '||vFormatoSel7) INTO vFecDesdeNuevo FROM DUAL;
                 END IF;

                 PV_LIMITE_CONSUMO_RANGO_PG.PV_LIMITE_CONSUMO_RANGO_PR(1,nCodCliente, nNumAbonado, vCodLimconsNuevo,vFecDesdeNuevo ,pvimp_limcons ,VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,
                                VP_SQLERRM,V_ERROR);


                 IF V_ERROR > 0 THEN

                              pvCodValor := 'FALSE';
                              pvErrorAplic := '4';
                              pvErrorGlosa := SUBSTR(vDesCadena,1,60);
                              pvErrorOra := TO_CHAR(SQLCODE);
                              pvErrorOraGlosa := SUBSTR(SQLERRM,1,60);
                                  RAISE ERROR_PROCESO;
                 END IF;



        ELSE
                IF pvTipSujeto = 'AL' THEN

                          SELECT COD_CLIENTE
                  INTO   nCodCliente
                  FROM   GA_ABOCEL
                  WHERE  NUM_ABONADO = nNumAbonado;

                  SELECT NVL(COD_LIMCONS,' ')
                  INTO vCodLimConsActual
                  FROM GA_LIMITE_CLIABO_TO
                  WHERE COD_CLIENTE = nCodCliente
                  AND NUM_ABONADO   = nNumAbonado
                          AND SYSDATE BETWEEN FEC_DESDE AND NVL(FEC_HASTA,SYSDATE);

                          PV_LIMITE_CONSUMO_RANGO_PG.PV_LIMITE_CONSUMO_RANGO_PR(1,nCodCliente, pnSujeto, pvLcNuevo,TO_DATE(pvFecDesde, vFormatoSel2||' '||vFormatoSel7),pvimp_limcons ,VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);

                          IF V_ERROR > 0 THEN
                              pvCodValor := 'FALSE';
                          pvErrorAplic := '4';
                          pvErrorGlosa := SUBSTR(vDesCadena,1,60);
                          pvErrorOra := TO_CHAR(SQLCODE);
                          pvErrorOraGlosa := SUBSTR(SQLERRM,1,60);
                              RAISE ERROR_PROCESO;
                       END IF;

                       BEGIN

                           INSERT INTO GA_MODABOCEL(NUM_ABONADO,
                           COD_TIPMODI,
                           FEC_MODIFICA,
                           NOM_USUARORA,
                           COD_LIMCONSUMO)
                           VALUES (nNumAbonado,
                           'IA', -- MAM 12/11/2003
                           SYSDATE,
                           USER,
                           vCodLimConsActual);

                           EXCEPTION
                                WHEN OTHERS THEN
                                     pvCodValor := 'FALSE';
                                     pvErrorAplic := '4';
                                     pvErrorGlosa := 'Problemas al insertar modificaciones del Abonado';
                                     pvErrorOra := TO_CHAR(SQLCODE);
                                     pvErrorOraGlosa := SUBSTR(SQLERRM,1,60);
                                     RAISE ERROR_PROCESO;
                           END;

               END IF;
        END IF;
                RAISE ERROR_PROCESO;
    END IF;

    IF pvTipSujeto = 'C' OR pvTipSujeto = 'CL'/* Operacion por Cliente Destino*/
    THEN

                 pvTrace        := 'Op por Cliente';
                 nCodCliente    := pnSujeto;
                 nCodCliHist    := pnSujeto;

                 BEGIN

                         SELECT A.COD_PLANTARIF
                          INTO vCodPlantarif
                          FROM GA_EMPRESA A, GE_CLIENTES B, TA_PLANTARIF C
                         WHERE B.COD_CLIENTE   = nCodCliente
                           AND B.COD_CLIENTE   = A.COD_CLIENTE
                           AND A.COD_PLANTARIF = C.COD_PLANTARIF
                           AND A.COD_PRODUCTO  = C.COD_PRODUCTO
                           AND A.COD_PRODUCTO  = 1;

                         IF vCodPlantarif <> EVCodplantarif and EVCodplantarif IS NOT NULL THEN
                            vCodPlantarif := EVCodplantarif;
                         END IF;

                 EXCEPTION
                        WHEN NO_DATA_FOUND THEN
                        IF EVCodplantarif IS NOT NULL THEN
                                vCodPlantarif:=EVCodplantarif;
                        END IF;
                 END;


                 BEGIN
                      SELECT COD_CLIENTE_DEST, NUM_ABONADO
                      INTO nCodClienteDest, nNumAboAux
                      FROM GA_REASIGNA_CLI_TO
                      WHERE COD_CLIENTE_ORIG    = nCodCliente
                      AND FEC_REASIGNA     = (SELECT MAX(FEC_REASIGNA)
                      FROM GA_REASIGNA_CLI_TO
                      WHERE COD_CLIENTE_ORIG = nCodCliente)
                      AND TRUNC(FEC_REASIGNA) = TRUNC(SYSDATE);

                 EXCEPTION
                        WHEN NO_DATA_FOUND THEN
                        BEGIN
                              SELECT COD_CLIENNUE, NUM_ABONADO, NUM_ABONADOANT
                              INTO nCodClienteDest, nNumAboAux, nNumAbonadoOrig
                              FROM GA_TRASPABO
                              WHERE COD_CLIENANT = nCodCliente
                              AND NUM_ABONADO  <> NUM_ABONADOANT
                              AND FEC_MODIFICA = (SELECT MAX(FEC_MODIFICA)
                                                  FROM GA_TRASPABO
                                                  WHERE COD_CLIENANT = nCodCliente
                                                  AND NUM_ABONADO  <> NUM_ABONADOANT)
                              AND TRUNC(FEC_MODIFICA) = TRUNC (SYSDATE);


                        EXCEPTION
                                WHEN NO_DATA_FOUND THEN
                                     nCodClienteDest := nCodCliente;
                                     nNumAboAux   := 0;
                        END;
                 END;

                 BEGIN
                        SELECT COUNT(*)
                        INTO nCantAboHist
                        FROM GA_ABOCEL
                        WHERE COD_SITUACION = 'AAA'
                        AND COD_CLIENTE          = nCodCliHist
                        GROUP BY COD_CLIENTE;
                 EXCEPTION
                         WHEN NO_DATA_FOUND THEN
                              nCantAboHist := 0;
                 END;

                 IF nNumAbonadoOrig = 0 THEN
                        nNumAbonadoOrig := nNumAboAux;
                 END IF;

                 BEGIN

                        SELECT NUM_ABONADO,NVL(COD_LIMCONS,' ')
                        INTO nNumAbonadoHist,vCodLimConsActual
                        FROM GA_LIMITE_CLIABO_TO A
                        WHERE A.COD_CLIENTE = nCodCliHist
                        AND A.NUM_ABONADO = 0
                        AND (A.FEC_HASTA   IS NULL OR A.FEC_HASTA > SYSDATE)
                        AND A.FEC_DESDE = (SELECT MIN(B.FEC_DESDE)
                                           FROM GA_LIMITE_CLIABO_TO B
                                           WHERE B.COD_CLIENTE = nCodCliHist
                                           AND B.NUM_ABONADO = 0);

                 EXCEPTION
                         WHEN NO_DATA_FOUND THEN
                              nNumAbonadoHist := nNumAbonadoOrig;
                 END;

                  dbms_output.put_line('Abonado para historico :'||nNumAbonadoHist);

                 BEGIN
                        SELECT COUNT(*)
                        INTO nCantAbonados
                        FROM GA_LIMITE_CLIABO_TO A
                        WHERE A.COD_CLIENTE = nCodClienteDest
                        AND A.NUM_ABONADO = 0
                        AND A.FEC_HASTA   IS NULL;
                  EXCEPTION
                        WHEN NO_DATA_FOUND THEN
                             nCantAbonados := 0;
                  END;

                  IF nCantAbonados = 0 THEN
                     nCodCliente := nCodClienteDest;
                     nNumAbonado := nNumAboAux;
                  ELSE
                     nNumAbonado := 0;
                  END IF;

    ELSIF pvTipSujeto = 'A' OR pvTipSujeto = 'AL' THEN /* Operacion por Abonado Destino */

                pvTrace         := 'Op por Abonado';
                nNumAbonado     := pnSujeto;
                pvTrace         :='GA_ABOCEL';

                SELECT COD_CLIENTE,COD_PLANTARIF
                INTO   nCodCliente,vCodPlantarif
                FROM GA_ABOCEL
                WHERE NUM_ABONADO = nNumAbonado;

                SELECT COD_TIPLAN INTO LV_TipPlan FROM TA_PLANTARIF
                WHERE COD_PLANTARIF = vCodPlantarif;

                SELECT VAL_PARAMETRO INTO LV_TipHibrido
                FROM GED_PARAMETROS
                WHERE NOM_PARAMETRO='TIPOHIBRIDO';

                pvTrace:='GA_LIMITE_CLIABO_TO;'||to_char(nCodCliente)||';'||to_char(nNumAbonado);

                IF vCodPlantarif <> EVCodplantarif AND EVCodplantarif IS NOT NULL THEN
                   vCodPlantarif := EVCodplantarif;
                END IF;

                IF LV_TipPlan = LV_TipHibrido THEN
                   vCodLimConsActual:=NULL;

                ELSE
                       BEGIN
                            IF EVTipoMovimiento = 'EI' THEN
                               vCodLimConsActual:=NULL;
                            ELSE
                                    SELECT NVL(COD_LIMCONS,' ')
                                      INTO vCodLimConsActual
                                      FROM GA_LIMITE_CLIABO_TO
                                     WHERE COD_CLIENTE = nCodCliente
                                       AND NUM_ABONADO   = nNumAbonado
                                       AND SYSDATE BETWEEN FEC_DESDE AND NVL(FEC_HASTA,SYSDATE);
                            END IF;
                       EXCEPTION
                          WHEN NO_DATA_FOUND THEN
                             BEGIN
                                SELECT COD_LIMCONSUMO
                                INTO vCodLimConsActual
                                FROM GA_ABOCEL
                                WHERE COD_CLIENTE = nCodCliente
                                AND NUM_ABONADO = nNumAbonado;
                             EXCEPTION
                                WHEN NO_DATA_FOUND THEN
                                   vCodLimconsActual := '-1';
                             END;
                       END;

                END IF;

                BEGIN
                      SELECT COD_CLIENTE_ORIG, NUM_ABONADO
                      INTO nCodCliHist, nNumAbonadoHist
                      FROM GA_REASIGNA_CLI_TO
                      WHERE COD_CLIENTE_DEST    = nCodCliente
                      AND FEC_REASIGNA     = (SELECT MAX(FEC_REASIGNA)
                                              FROM GA_REASIGNA_CLI_TO
                                              WHERE COD_CLIENTE_DEST = nCodCliente)
                                              AND TRUNC(FEC_REASIGNA) = TRUNC(SYSDATE);
                EXCEPTION
                      WHEN NO_DATA_FOUND THEN
                           BEGIN
                                 SELECT COD_CLIENANT, NUM_ABONADOANT
                                 INTO nCodCliHist,  nNumAbonadoHist
                                 FROM GA_TRASPABO
                                 WHERE COD_CLIENNUE = nCodCliente
                                 AND NUM_ABONADO  <> NUM_ABONADOANT
                                 AND FEC_MODIFICA = (SELECT MAX(FEC_MODIFICA)
                                                     FROM GA_TRASPABO
                                                     WHERE COD_CLIENNUE = nCodCliente
                                                     AND NUM_ABONADO  <> NUM_ABONADOANT)
                                                     AND TRUNC(FEC_MODIFICA) = TRUNC (SYSDATE);

                           EXCEPTION
                                 WHEN NO_DATA_FOUND THEN
                                      nCodCliHist     := nCodCliente;
                                      nNumAbonadoHist := nNumAbonado;
                           END;
                END;


                -- Buscamos Abonado correspondiente a Cliente Origen --
                BEGIN

                      SELECT NUM_ABONADO
                      INTO nNumAboAux
                      FROM GA_LIMITE_CLIABO_TO A
                      WHERE A.COD_CLIENTE = nCodCliHist
                      AND A.NUM_ABONADO = 0
                      AND (A.FEC_HASTA   IS NULL OR A.FEC_HASTA > SYSDATE);

                       -- Validamos si Cliente Origen debe o no pasar a Historico --
                       BEGIN

                             IF EVTipoMovimiento <> 'EI' THEN
                             nNumAbonadoHist := nNumAboAux;
                             END IF;

                             SELECT COUNT(*)
                             INTO nCantAboHist
                             FROM GA_ABOCEL
                             WHERE COD_SITUACION = 'AAA'
                             AND COD_CLIENTE     = nCodCliHist
                             GROUP BY COD_CLIENTE;

                       EXCEPTION
                             WHEN NO_DATA_FOUND THEN
                                  nCantAboHist := 0;
                       END;

                EXCEPTION
                           WHEN NO_DATA_FOUND THEN
                                nCantAbonados := 0;
                                nCantAboHist := 0;
                           WHEN OTHERS THEN                            
                                nCantAbonados := 0;
                                nCantAboHist := 0;                                
                END;

        END IF;

        /* Si no viene Limite de Consumo le asigno uno por defecto.
           de acuerdo al plan tarifario
        */


        IF pvLcNuevo = ' ' OR pvLcNuevo IS NULL OR pvLcNuevo = '*'
        THEN
                 vCodLimconsNuevo := '-1';

        ELSE
                 vCodLimconsNuevo := pvLcNuevo;
        END IF;

        IF pvFecDesde = ' ' OR pvFecDesde IS NULL OR pvFecDesde = '*' THEN
                        vFecDesdeNuevo := SYSDATE;
                        vFecDesdeNuevo_AUX:=vFecDesdeNuevo;
        ELSE
                        SELECT TO_DATE(pvFecDesde, vFormatoSel2||' '||vFormatoSel7) INTO vFecDesdeNuevo FROM DUAL;
                        SELECT TO_DATE(pvFecDesde, vFormatoSel2||' '||vFormatoSel7) INTO    vFecDesdeNuevo_AUX FROM DUAL;
        END IF;

        IF pvFecHasta = ' ' OR pvFecHasta IS NULL OR pvFecHasta = '*' THEN
            vFecHastaNuevo := NULL;
        ELSE
            vFecHastaNuevo := TO_DATE(pvFecHasta, vFormatoSel2||' '||vFormatoSel7);
        END IF;

        /* Comienzo de la asignacion de un nuevo limite de consumo
           en caso de venir el parametro pvFecDesde nulo, el cambio
           se aplica de forma inmediata.
        */

        IF pvFecDesde = ' ' OR pvFecDesde IS NULL OR pvFecDesde = '*'
        THEN
            BEGIN
                   SELECT COD_LIMCONS,FEC_DESDE
                   INTO vCodLimcons,vFecDesde
                   FROM GA_LIMITE_CLIABO_TO
                   WHERE COD_CLIENTE = nCodCliHist
                   AND NUM_ABONADO = nNumAbonadoHist
                   AND SYSDATE BETWEEN FEC_DESDE AND NVL(FEC_HASTA,SYSDATE);
            EXCEPTION
                    WHEN NO_DATA_FOUND THEN
                         vCodLimcons := NULL;
                         vFecDesde   := NULL;
            END;

            IF nCantAboHist = 0 AND vCodLimcons IS NOT NULL THEN

                        BEGIN


dbms_output.PUT_LINE('VIENE CON FECHA =' );

                            IF EVTipoMovimiento IN ('EI','EE') THEN
                                    UPDATE GA_LIMITE_CLIABO_TO SET
                                    FEC_HASTA = SYSDATE - (1/86400)
                                    WHERE NUM_ABONADO = 0
                                    AND COD_CLIENTE = nCodCliHist
                                    AND SYSDATE BETWEEN FEC_DESDE AND NVL(FEC_HASTA,SYSDATE);

                            ELSE
                                    
                                    SELECT  COD_CLIENANT INTO COD_CLIENTE_AUX_ANT  FROM GA_TRASPABO
                                    WHERE  NUM_ABONADO = pnSujeto
                                    AND FEC_MODIFICA IN (SELECT MAX(FEC_MODIFICA) FROM GA_TRASPABO
                                                         WHERE  NUM_ABONADO = pnSujeto);
                                                         
                                                         
                                    SELECT  COD_PLANTARIF  INTO LV_AUX_PLAN   FROM GA_INTARCEL
                                    WHERE  NUM_ABONADO = pnSujeto
                                    AND  COD_CLIENTE =  COD_CLIENTE_AUX_ANT 
                                    AND FEC_HASTA IN (SELECT MAX(FEC_HASTA)  FROM GA_INTARCEL
                                                            WHERE  NUM_ABONADO = pnSujeto
                                                            AND  COD_CLIENTE =  COD_CLIENTE_AUX_ANT);
                                                            
                            
                            
                                    UPDATE GA_LIMITE_CLIABO_TO
                                    SET    FEC_HASTA   = SYSDATE - (1/(24*60*60))
                                    WHERE  NUM_ABONADO = pnSujeto
                                    AND COD_CLIENTE = nCodCliHist
                                    AND    SYSDATE BETWEEN FEC_DESDE AND NVL(FEC_HASTA,SYSDATE);
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
                        

                             SELECT 'S' INTO YA_EXISTE
                            FROM   GA_LIMITE_CLIABO_TO
                            WHERE  COD_CLIENTE = nCodCliHist
                            AND    NUM_ABONADO = nNumAbonadoHist
                            AND    SYSDATE BETWEEN FEC_DESDE AND NVL(FEC_HASTA,SYSDATE)
                            AND    COD_LIMCONS = pvLcNuevo;


                        EXCEPTION
                                WHEN OTHERS THEN
                                    YA_EXISTE:='N';
                        END;
                        
                        
                        IF EVTipoMovimiento IN ('II') then
                        
                        
                                --PLAN NUEVO 
                                SELECT COD_PLANTARIF
                                INTO   vCodPlantarif
                                FROM GA_ABOCEL
                                WHERE NUM_ABONADO = pnSujeto;

                                SELECT COD_TIPLAN INTO LV_TipPlan FROM TA_PLANTARIF
                                WHERE COD_PLANTARIF = vCodPlantarif;

                                SELECT VAL_PARAMETRO INTO LV_TipHibrido
                                FROM GED_PARAMETROS
                                WHERE NOM_PARAMETRO='TIPOHIBRIDO';

                                
                                --PLAN ANTIGUO

                                SELECT COD_TIPLAN INTO LV_TipPlan2 FROM TA_PLANTARIF
                                WHERE COD_PLANTARIF = LV_AUX_PLAN;



                                IF  (TRIM(LV_TipPlan2) = TRIM(LV_TipPlan)) THEN
                                    YA_EXISTE:='N';
                                    vModifca := 'TRUE';
                                END IF;
                                
                                
                                IF  (TRIM(LV_TipPlan2) ='3' AND  TRIM(LV_TipPlan)= '2') THEN
                                    YA_EXISTE:='N';
                                    vModifca := 'TRUE';
                                END IF;
                                
                                
                                
                                

                            
                        end if;
                        
                        

                        IF pvErrorAplic='5' THEN  YA_EXISTE:='N'; END IF; --Producto de un traspaso de abonado que implica la baja del abonado original

            ELSE
                YA_EXISTE := 'N';
            END IF;

        ELSE
             BEGIN


                   dbms_output.PUT_LINE('VIENE CON FECHA =' );

                   YA_EXISTE := 'N';
                   SELECT 'S' INTO YA_EXISTE
                   FROM   GA_LIMITE_CLIABO_TO
                   WHERE  COD_CLIENTE = nCodCliHist
                   AND    NUM_ABONADO = nNumAbonadoHist
                   AND    FEC_DESDE = vFecDesdeNuevo
                   AND    COD_LIMCONS = pvLcNuevo;

             EXCEPTION

                     WHEN NO_DATA_FOUND THEN
                          BEGIN


                               SELECT  vFecDesdeNuevo - (1/(24*60*60)) INTO vFecDesdeNuevo FROM DUAL;

                               UPDATE GA_LIMITE_CLIABO_TO
                               SET FEC_HASTA   = TO_DATE(to_char(vFecDesdeNuevo,'DD/MM/YY HH24:MI:SS'),'DD/MM/YY HH24:MI:SS')
                               WHERE COD_CLIENTE = nCodCliente
                               AND NUM_ABONADO = nNumAbonado
                               AND SYSDATE BETWEEN FEC_DESDE AND NVL(FEC_HASTA,SYSDATE);
                               vModifca        := 'TRUE';
                               dbms_output.PUT_LINE('ACTUALIZA GA_LIMITE_CLIABO_TO = vFecDesdeNuevo' );

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
pvTrace:='GA_LIMITE_CLIABO_TO3.5'||YA_EXISTE;

        /* Insertamos Limite Nuevo */
        IF YA_EXISTE = 'N' THEN



                        IF nCantAbonados = 0 OR vModifca = 'TRUE' THEN
                        BEGIN

                               BEGIN
                                           SELECT fec_desde
                                           INTO vFecDesdeProximo
                                           FROM GA_LIMITE_CLIABO_TO
                                           WHERE fec_desde > sysdate
                                           AND COD_CLIENTE = nCodCliente
                                           AND NUM_ABONADO = nNumAbonado;


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

                               IF vFecDesdeProximo IS NOT NULL then

                                   BEGIN
                                             DELETE FROM GA_LIMITE_CLIABO_TO
                                             WHERE COD_CLIENTE = nCodCliente
                                             AND NUM_ABONADO = nNumAbonado
                                             AND FEC_DESDE=vFecDesdeProximo;

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


                               DBMS_OUTPUT.PUT_LINE('vFecDesdeNuevo ANTES'||vFecDesdeNuevo);
                               vFecDesdeNuevo:=vFecDesdeNuevo_AUX;

                               DBMS_OUTPUT.PUT_LINE('vFecDesdeNuevo DESPUES'||vFecDesdeNuevo);
pvTrace:='GA_LIMITE_CLIABO_TO3.6'||YA_EXISTE;
                                                              
                                
                               INSERT INTO GA_LIMITE_CLIABO_TO
                               (COD_CLIENTE, NUM_ABONADO, COD_LIMCONS,
                                FEC_DESDE, FEC_HASTA,NOM_USUARORA,
                                FEC_ASIGNACION,COD_PLANTARIF,MTO_CONS)
                               VALUES
                               (nCodCliente,   nNumAbonado, vCodLimconsNuevo,
                                TO_DATE (to_char(vFecDesdeNuevo,'DD/MM/YY HH24:MI:SS'),'DD/MM/YY HH24:MI:SS'), vFecHastaNuevo,USER, SYSDATE,vCodPlantarif,pvimp_limcons );


pvTrace:='GA_LIMITE_CLIABO_TO3.62'||YA_EXISTE;
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
                                pvErrorOraGlosa := SQLERRM;
                                RAISE ERROR_PROCESO;
                        END;

                        END IF;

                        IF pvTipSujeto = 'A' OR pvTipSujeto = 'AL' then/* Operacion por Abonado */
                        BEGIN


                            IF vFecDesdeNuevo <= (SYSDATE+1/86400) THEN
                                            UPDATE GA_ABOCEL
                                            SET COD_LIMCONSUMO = vCodLimconsNuevo
                                            WHERE NUM_ABONADO = nNumAbonado;

                            ELSE

                                   BEGIN
                                          select cod_ciclo
                                          into v_cod_ciclo
                                          from ga_abocel
                                          where num_abonado = nNumAbonado;

                                          select FEC_hastallam + (1/64000) , cod_ciclfact
                                          into V_fec_desdeciclo, V_coc_ciclfact
                                          from fa_ciclfact
                                          where cod_ciclo = v_cod_ciclo
                                          and sysdate between fec_desdellam and fec_hastallam;

                                          INSERT INTO ga_finciclo
                                          (COD_CLIENTE, NUM_ABONADO, COD_CICLFACT, COD_PRODUCTO, TIP_PLANTARIF, COD_PLANTARIF,
                                          FEC_DESDELLAM, NUM_DIAS)
                                          VALUES (nCodCliente, pnSujeto, V_coc_ciclfact, 1, 'I', -1,V_fec_desdeciclo,1);

                                   EXCEPTION WHEN NO_DATA_FOUND THEN
                                                  pvCodValor          := 'FALSE';
                                                  pvErrorAplic        := '4';
                                                  pvErrorGlosa        := 'problemas al insertar registro en ga_finciclo';
                                                  pvErrorOra          := TO_CHAR(SQLCODE);
                                                  pvErrorOraGlosa := SQLERRM;
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

                              if vFecDesdeNuevo< SYSDATE THEN
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

                                --- no se actualiza ga_abocel debido a que se hace en actabo (unix)

                                PV_LIMITE_INTARCEL_PR (pnSujeto,pvLcNuevo,pvFecDesde,pvimp_limcons,pvErrorOra,pvErrorOraGlosa,pvErrorAplic);

                                IF nCodRetorno > 0 THEN
                                   pvCodValor      := 'FALSE';
                                   pvErrorAplic    := '4';
                                   pvErrorGlosa    := SUBSTR(pvErrorOraGlosa,1,60);
                                   RAISE ERROR_PROCESO;
                                END IF;

                        EXCEPTION
                              WHEN OTHERS THEN
                                 pvCodValor := 'FALSE';
                                 pvErrorAplic := '4';
                                 pvErrorGlosa := 'problemas al actualizar el nuevo limite Cliente';
                                 pvErrorOra := TO_CHAR(SQLCODE);
                                 pvErrorOraGlosa := SQLERRM;
                                 RAISE ERROR_PROCESO;
                        END;


                        END IF;


        ELSE
                        -- SI EXISTE SE CAMBIA LC

 pvTrace:='UPDATE GA_LIMITE_CLIABO_TO:'|| EVTipoMovimiento ;
                        IF EVTipoMovimiento IN ('EI','EE') THEN

                               UPDATE GA_LIMITE_CLIABO_TO SET
                               COD_LIMCONS = vCodLimconsNuevo
                               WHERE COD_CLIENTE = nCodCliHist
                               AND NUM_ABONADO = 0
                               AND FEC_DESDE = vFecDesdeNuevo;

                        ELSE
                                pvTrace:='GA_LIMITE_CLIABO_TO3.7';


                                UPDATE GA_LIMITE_CLIABO_TO
                                SET    COD_LIMCONS = vCodLimconsNuevo
                                WHERE  COD_CLIENTE = nCodCliente
                                AND    NUM_ABONADO = nNumAbonado
                                AND    FEC_DESDE = vFecDesdeNuevo;



                        END IF;


        END IF;

    IF pvTipSujeto = 'A' /* Operacion por Abonado */
    THEN


         IF ge_log_pg.debug_activo THEN
               ge_log_pg.DEBUG( 'pv_limite_consumo_pg - vFecDesdeNuevo:'||vFecDesdeNuevo);
         END IF;


         IF ge_log_pg.debug_activo THEN
                               ge_log_pg.DEBUG( 'pv_limite_consumo_TRASPASO_pg - PV_LIMITE_CONSUMO_RANGO_PG.PV_LIMITE_CONSUMO_RANGO_PR');
         END IF;


         pvTrace:='PV_LIMITE_CONSUMO_RANGO_PG.PV_LIMITE_CONSUMO_RANGO_PR';

         PV_LIMITE_CONSUMO_RANGO_PG.PV_LIMITE_CONSUMO_RANGO_PR(1,nCodCliente, pnSujeto, vCodLimconsNuevo,vFecDesdeNuevo ,pvimp_limcons ,VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,
                                VP_SQLERRM,V_ERROR);

         IF V_ERROR > 0 THEN

                      pvCodValor := 'FALSE';
                      pvErrorAplic := '4';
                      pvErrorGlosa := SUBSTR(vDesCadena,1,60);
                      pvErrorOra := TO_CHAR(SQLCODE);
                      pvErrorOraGlosa := SUBSTR(SQLERRM,1,60);
                          RAISE ERROR_PROCESO;
         END IF;


    ELSE


        IF pvTipSujeto = 'AL' THEN

               PV_LIMITE_CONSUMO_RANGO_PG.PV_LIMITE_CONSUMO_RANGO_PR(1,nCodCliente, pnSujeto, vCodLimconsNuevo,vFecDesdeNuevo ,pvimp_limcons ,VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,
                                VP_SQLERRM,V_ERROR);

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

                INSERT INTO GA_MODABOCEL(NUM_ABONADO,
                                         COD_TIPMODI,
                                         FEC_MODIFICA,
                                         NOM_USUARORA,
                                         COD_LIMCONSUMO)
                                         VALUES (nNumAbonado,
                                         'IA',
                                         SYSDATE,
                                         USER,
                                         vCodLimConsActual);

           EXCEPTION
                  WHEN OTHERS THEN

                           pvCodValor := 'FALSE';
                           pvErrorAplic := '4';
                           pvErrorGlosa := 'Problemas al insertar modificaciones del Abonado';
                           pvErrorOra := TO_CHAR(SQLCODE);
                           pvErrorOraGlosa := SUBSTR(SQLERRM,1,60);
                           RAISE ERROR_PROCESO;
           END;

    ELSIF pvTipSujeto = 'CL' THEN
           BEGIN


                   INSERT INTO GA_MODCLI(COD_CLIENTE,
                                         COD_TIPMODI,
                                         FEC_MODIFICA,
                                         NOM_USUARORA,
                                         COD_LIMCONSUMO)
                                         VALUES (nCodCliente,
                                        'IC',
                                        SYSDATE,
                                        USER,
                                        vCodLimConsActual);
           EXCEPTION
                    WHEN OTHERS THEN

                             pvCodValor := 'FALSE';
                             pvErrorAplic := '4';
                             pvErrorGlosa := 'Problemas al insertar modificaciones del Cliente';
                             pvErrorOra := TO_CHAR(SQLCODE);
                             pvErrorOraGlosa := SUBSTR(SQLERRM,1,60);
           END;

    END IF;


    if pvCodValor = 'TRUE' THEN
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
             pvErrorOraGlosa:= SUBSTR(SQLERRM,1,60);
             pvTrace:= 'PV_MODIFICA_LC_PR-' || pvTrace;

END PV_MODIFICA_LC_PR;


PROCEDURE PV_MODIFICA_LCCICLO_PR(pnSujeto        IN NUMBER,
                            pvTipSujeto     IN VARCHAR2,
                            pvLcNuevo       IN VARCHAR2,
                            pvCausaHist     IN VARCHAR2,
                            pvFecDesde      IN VARCHAR2,
                            pvFecHasta      IN VARCHAR2,
                            EVCodplantarif  IN VARCHAR2:=NULL,
                            EVTipoMovimiento IN VARCHAR2:=NULL,
                            pvimp_limcons   IN NUMBER,
                            pvCodValor      OUT NOCOPY VARCHAR2,
                            pvErrorAplic    OUT NOCOPY VARCHAR2,
                            pvErrorGlosa    OUT NOCOPY VARCHAR2,
                            pvErrorOra      OUT NOCOPY VARCHAR2,
                            pvErrorOraGlosa OUT NOCOPY VARCHAR2,
                            pvTrace         OUT NOCOPY VARCHAR2 )
IS
    nCodCliente      GE_CLIENTES.COD_CLIENTE%TYPE;
    nCodClienteDest  GE_CLIENTES.COD_CLIENTE%TYPE;
    nCodCliHist      GE_CLIENTES.COD_CLIENTE%TYPE;
    nNumAbonadoHist  GA_ABOCEL.NUM_ABONADO%TYPE;
    nNumAbonadoOrig  GA_ABOCEL.NUM_ABONADO%TYPE;
    nCantAbonados    NUMBER;
    nCantAboHist     NUMBER;
    vModifca         VARCHAR2(5);
    nNumAbonado      GA_ABOCEL.NUM_ABONADO%TYPE;
    nNumAboAux       GA_ABOCEL.NUM_ABONADO%TYPE;
    vCodLimcons      GA_LIMITE_CLIABO_TO.COD_LIMCONS%TYPE;
    vFecDesde        GA_LIMITE_CLIABO_TO.FEC_DESDE%TYPE;
    vFecDesdeNuevo   GA_LIMITE_CLIABO_TO.FEC_DESDE%TYPE;
    vFecDesdeNuevo_AUX   GA_LIMITE_CLIABO_TO.FEC_DESDE%TYPE;


    vFecHastaNuevo   GA_LIMITE_CLIABO_TO.FEC_HASTA%TYPE;
    vFormatoSel2     GED_PARAMETROS.VAL_PARAMETRO%TYPE;
    vFormatoSel7     GED_PARAMETROS.VAL_PARAMETRO%TYPE;
    vCodCausaHist    GA_LIMITE_CLIABO_TH.COD_CAUSA_HIST%TYPE;
    vCodPlantarif    TA_PLANTARIF.COD_PLANTARIF%TYPE;
    vCodLimconsNuevo GA_LIMITE_CLIABO_TO.COD_LIMCONS%TYPE;
    LV_TipHibrido    GED_PARAMETROS.VAL_PARAMETRO%TYPE;
    LV_TipPlan       TA_PLANTARIF.COD_TIPLAN%TYPE;
    vFecDesdeProximo        GA_LIMITE_CLIABO_TO.FEC_DESDE%TYPE;
    vCodLimConsActual   GA_LIMITE_CLIABO_TO.COD_LIMCONS%TYPE;
    YA_EXISTE                   VARCHAR2(1);

    VP_PROC             VARCHAR2(50);
    VP_TABLA            VARCHAR2(50);
    VP_ACT              VARCHAR2(1);
    VP_SQLCODE          VARCHAR2(15);
    VP_SQLERRM          VARCHAR2(255);
    V_ERROR             VARCHAR2(1) := '0';

    nNumTransaccion  GA_TRANSACABO.NUM_TRANSACCION%TYPE;
    nCodRetorno      GA_TRANSACABO.COD_RETORNO%TYPE;
    vDesCadena       GA_TRANSACABO.DES_CADENA%TYPE;
    vSeqErr         NUMBER;

        V_fec_desdeciclo date;
        V_coc_ciclfact   fa_ciclfact.cod_ciclfact%TYPE;
        v_cod_ciclo              ga_abocel.cod_ciclo%type;


    ERROR_PROCESO    EXCEPTION;

BEGIN
        DBMS_OUTPUT.PUT_LINE('PPV_MODIFICA_LCCICLO_PR');
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
        vModifca        := 'FALSE';
        YA_EXISTE := 'N';

    IF GE_FN_DEVVALPARAM('GE', 1, 'IND_TOL') = 'N'
    THEN

        pvCodValor := 'TRUE';
        IF pvTipSujeto = 'A' THEN /* Operacion por Abonado */
                vCodLimconsNuevo := '-1';
                nNumAbonado := pnSujeto;

                 SELECT COD_CLIENTE
                 INTO   nCodCliente
                 FROM   GA_ABOCEL
                 WHERE  NUM_ABONADO = nNumAbonado;


                 IF pvFecDesde = ' ' OR pvFecDesde IS NULL OR pvFecDesde = '*' THEN
                        vFecDesdeNuevo := SYSDATE;
                 ELSE
                        SELECT TO_DATE(pvFecDesde, vFormatoSel2||' '||vFormatoSel7) INTO vFecDesdeNuevo FROM DUAL;
                 END IF;

                 PV_LIMITE_CONSUMO_RANGO_PG.PV_LIMITE_CONSUMO_RANGO_PR(1,nCodCliente, nNumAbonado, vCodLimconsNuevo,vFecDesdeNuevo ,pvimp_limcons ,VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,
                                VP_SQLERRM,V_ERROR);


                 IF V_ERROR > 0 THEN

                   pvCodValor      := 'FALSE';
                   pvErrorAplic    := '4';
                   pvErrorGlosa    := SUBSTR(vDesCadena,1,60);
                   pvErrorOra      := TO_CHAR(SQLCODE);
                   pvErrorOraGlosa := SUBSTR(SQLERRM,1,60);
                                  RAISE ERROR_PROCESO;
                END IF;



        ELSE
                IF pvTipSujeto = 'AL' THEN

                          SELECT COD_CLIENTE
                  INTO   nCodCliente
                  FROM   GA_ABOCEL
                  WHERE  NUM_ABONADO = nNumAbonado;

                  SELECT NVL(COD_LIMCONS,' ')
                  INTO vCodLimConsActual
                  FROM GA_LIMITE_CLIABO_TO
                  WHERE COD_CLIENTE = nCodCliente
                  AND NUM_ABONADO   = nNumAbonado
                          AND SYSDATE BETWEEN FEC_DESDE AND NVL(FEC_HASTA,SYSDATE);

                          PV_LIMITE_CONSUMO_RANGO_PG.PV_LIMITE_CONSUMO_RANGO_PR(1,nCodCliente, pnSujeto, pvLcNuevo,TO_DATE(pvFecDesde, vFormatoSel2||' '||vFormatoSel7),pvimp_limcons ,VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,VP_SQLERRM,V_ERROR);

                          IF V_ERROR > 0 THEN
                              pvCodValor := 'FALSE';
                          pvErrorAplic := '4';
                          pvErrorGlosa := SUBSTR(vDesCadena,1,60);
                          pvErrorOra := TO_CHAR(SQLCODE);
                          pvErrorOraGlosa := SUBSTR(SQLERRM,1,60);
                              RAISE ERROR_PROCESO;
                       END IF;

                       BEGIN

                           INSERT INTO GA_MODABOCEL(NUM_ABONADO,
                           COD_TIPMODI,
                           FEC_MODIFICA,
                           NOM_USUARORA,
                           COD_LIMCONSUMO)
                           VALUES (nNumAbonado,
                           'IA', -- MAM 12/11/2003
                           SYSDATE,
                           USER,
                           vCodLimConsActual);

                           EXCEPTION
                                WHEN OTHERS THEN
                                     pvCodValor := 'FALSE';
                                     pvErrorAplic := '4';
                                     pvErrorGlosa := 'Problemas al insertar modificaciones del Abonado';
                                     pvErrorOra := TO_CHAR(SQLCODE);
                                     pvErrorOraGlosa := SUBSTR(SQLERRM,1,60);
                                     RAISE ERROR_PROCESO;
                           END;

               END IF;
        END IF;
                RAISE ERROR_PROCESO;
    END IF;

    IF pvTipSujeto = 'C' OR pvTipSujeto = 'CL'/* Operacion por Cliente Destino*/
    THEN

                 pvTrace        := 'Op por Cliente';
                 nCodCliente    := pnSujeto;
                 nCodCliHist    := pnSujeto;

                 BEGIN

                         SELECT A.COD_PLANTARIF
                          INTO vCodPlantarif
                          FROM GA_EMPRESA A, GE_CLIENTES B, TA_PLANTARIF C
                         WHERE B.COD_CLIENTE   = nCodCliente
                           AND B.COD_CLIENTE   = A.COD_CLIENTE
                           AND A.COD_PLANTARIF = C.COD_PLANTARIF
                           AND A.COD_PRODUCTO  = C.COD_PRODUCTO
                           AND A.COD_PRODUCTO  = 1;

                         IF vCodPlantarif <> EVCodplantarif and EVCodplantarif IS NOT NULL THEN
                            vCodPlantarif := EVCodplantarif;
                         END IF;

                 EXCEPTION
                        WHEN NO_DATA_FOUND THEN
                        IF EVCodplantarif IS NOT NULL THEN
                                vCodPlantarif:=EVCodplantarif;
                        END IF;
                 END;


                 BEGIN
                      SELECT COD_CLIENTE_DEST, NUM_ABONADO
                      INTO nCodClienteDest, nNumAboAux
                      FROM GA_REASIGNA_CLI_TO
                      WHERE COD_CLIENTE_ORIG    = nCodCliente
                      AND FEC_REASIGNA     = (SELECT MAX(FEC_REASIGNA)
                      FROM GA_REASIGNA_CLI_TO
                      WHERE COD_CLIENTE_ORIG = nCodCliente)
                      AND TRUNC(FEC_REASIGNA) = TRUNC(SYSDATE);

                  EXCEPTION
                        WHEN NO_DATA_FOUND THEN
                        BEGIN
                              SELECT COD_CLIENNUE, NUM_ABONADO, NUM_ABONADOANT
                              INTO nCodClienteDest, nNumAboAux, nNumAbonadoOrig
                              FROM GA_TRASPABO
                              WHERE COD_CLIENANT = nCodCliente
                              AND NUM_ABONADO  <> NUM_ABONADOANT
                              AND FEC_MODIFICA = (SELECT MAX(FEC_MODIFICA)
                                                  FROM GA_TRASPABO
                                                  WHERE COD_CLIENANT = nCodCliente
                                                  AND NUM_ABONADO  <> NUM_ABONADOANT)
                              AND TRUNC(FEC_MODIFICA) = TRUNC (SYSDATE);


                         EXCEPTION
                                WHEN NO_DATA_FOUND THEN
                                     nCodClienteDest := nCodCliente;
                                     nNumAboAux   := 0;
                                END;
                  END;

                  BEGIN
                            SELECT COUNT(*)
                        INTO nCantAboHist
                        FROM GA_ABOCEL
                        WHERE COD_SITUACION = 'AAA'
                        AND COD_CLIENTE          = nCodCliHist
                        GROUP BY COD_CLIENTE;
                  EXCEPTION
                         WHEN NO_DATA_FOUND THEN
                              nCantAboHist := 0;
                  END;

                  IF nNumAbonadoOrig = 0 THEN
                        nNumAbonadoOrig := nNumAboAux;
                  END IF;

          BEGIN

                        SELECT NUM_ABONADO,NVL(COD_LIMCONS,' ')
                        INTO nNumAbonadoHist,vCodLimConsActual
                        FROM GA_LIMITE_CLIABO_TO A
                    WHERE A.COD_CLIENTE = nCodCliHist
                    AND A.NUM_ABONADO = 0
                    AND (A.FEC_HASTA   IS NULL OR A.FEC_HASTA > SYSDATE)
                        AND A.FEC_DESDE = (SELECT MIN(B.FEC_DESDE)
                                           FROM GA_LIMITE_CLIABO_TO B
                                                           WHERE B.COD_CLIENTE = nCodCliHist
                                                   AND B.NUM_ABONADO = 0);

          EXCEPTION
                         WHEN NO_DATA_FOUND THEN
                              nNumAbonadoHist := nNumAbonadoOrig;
                  END;

                  dbms_output.put_line('Abonado para historico :'||nNumAbonadoHist);

                  BEGIN
                        SELECT COUNT(*)
                        INTO nCantAbonados
                        FROM GA_LIMITE_CLIABO_TO A
                        WHERE A.COD_CLIENTE = nCodClienteDest
                        AND A.NUM_ABONADO = 0
                        AND A.FEC_HASTA   IS NULL;
                  EXCEPTION
                        WHEN NO_DATA_FOUND THEN
                             nCantAbonados := 0;
                  END;

                  IF nCantAbonados = 0 THEN
                     nCodCliente := nCodClienteDest;
                     nNumAbonado := nNumAboAux;
                  ELSE
                     nNumAbonado := 0;
                  END IF;

    ELSIF pvTipSujeto = 'A' OR pvTipSujeto = 'AL' THEN /* Operacion por Abonado Destino */

                pvTrace         := 'Op por Abonado';
                nNumAbonado     := pnSujeto;
                pvTrace         :='GA_ABOCEL';

                SELECT COD_CLIENTE,COD_PLANTARIF
                INTO   nCodCliente,vCodPlantarif
                FROM GA_ABOCEL
                WHERE NUM_ABONADO = nNumAbonado;

                SELECT COD_TIPLAN INTO LV_TipPlan FROM TA_PLANTARIF
                WHERE COD_PLANTARIF = vCodPlantarif;

                SELECT VAL_PARAMETRO INTO LV_TipHibrido
                FROM GED_PARAMETROS
                WHERE NOM_PARAMETRO='TIPOHIBRIDO';

                pvTrace:='GA_LIMITE_CLIABO_TO;'||to_char(nCodCliente)||';'||to_char(nNumAbonado);

                IF vCodPlantarif <> EVCodplantarif AND EVCodplantarif IS NOT NULL THEN
                   vCodPlantarif := EVCodplantarif;
                END IF;

                IF LV_TipPlan = LV_TipHibrido THEN
                   vCodLimConsActual:=NULL;

                ELSE
                   BEGIN
                        IF EVTipoMovimiento = 'EI' THEN
                           vCodLimConsActual:=NULL;
                        ELSE
                                SELECT NVL(COD_LIMCONS,' ')
                                  INTO vCodLimConsActual
                                  FROM GA_LIMITE_CLIABO_TO
                                 WHERE COD_CLIENTE = nCodCliente
                                   AND NUM_ABONADO   = nNumAbonado
                                           AND SYSDATE BETWEEN FEC_DESDE AND NVL(FEC_HASTA,SYSDATE);
                        END IF;
                   EXCEPTION
                      WHEN NO_DATA_FOUND THEN
                         BEGIN
                            SELECT COD_LIMCONSUMO
                            INTO vCodLimConsActual
                            FROM GA_ABOCEL
                            WHERE COD_CLIENTE = nCodCliente
                            AND NUM_ABONADO = nNumAbonado;
                         EXCEPTION
                            WHEN NO_DATA_FOUND THEN
                               vCodLimconsActual := '-1';
                         END;
                   END;

                END IF;

                BEGIN
                      SELECT COD_CLIENTE_ORIG, NUM_ABONADO
                      INTO nCodCliHist, nNumAbonadoHist
                      FROM GA_REASIGNA_CLI_TO
                      WHERE COD_CLIENTE_DEST    = nCodCliente
                      AND FEC_REASIGNA     = (SELECT MAX(FEC_REASIGNA)
                                              FROM GA_REASIGNA_CLI_TO
                                              WHERE COD_CLIENTE_DEST = nCodCliente)
                                              AND TRUNC(FEC_REASIGNA) = TRUNC(SYSDATE);
                EXCEPTION
                      WHEN NO_DATA_FOUND THEN
                           BEGIN
                                 SELECT COD_CLIENANT, NUM_ABONADOANT
                                 INTO nCodCliHist,  nNumAbonadoHist
                                 FROM GA_TRASPABO
                                 WHERE COD_CLIENNUE = nCodCliente
                                 AND NUM_ABONADO  <> NUM_ABONADOANT
                                 AND FEC_MODIFICA = (SELECT MAX(FEC_MODIFICA)
                                                     FROM GA_TRASPABO
                                                     WHERE COD_CLIENNUE = nCodCliente
                                                     AND NUM_ABONADO  <> NUM_ABONADOANT)
                                                     AND TRUNC(FEC_MODIFICA) = TRUNC (SYSDATE);

                           EXCEPTION
                                 WHEN NO_DATA_FOUND THEN
                                      nCodCliHist     := nCodCliente;
                                      nNumAbonadoHist := nNumAbonado;
                           END;
                END;


                -- Buscamos Abonado correspondiente a Cliente Origen --
                BEGIN

                      SELECT NUM_ABONADO
                      INTO nNumAboAux
                      FROM GA_LIMITE_CLIABO_TO A
                      WHERE A.COD_CLIENTE = nCodCliHist
                      AND A.NUM_ABONADO = 0
                      AND (A.FEC_HASTA   IS NULL OR A.FEC_HASTA > SYSDATE);

                       -- Validamos si Cliente Origen debe o no pasar a Historico --
                       BEGIN

                             IF EVTipoMovimiento <> 'EI' THEN
                             nNumAbonadoHist := nNumAboAux;
                             END IF;

                             SELECT COUNT(*)
                             INTO nCantAboHist
                             FROM GA_ABOCEL
                             WHERE COD_SITUACION = 'AAA'
                             AND COD_CLIENTE     = nCodCliHist
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

        /* Si no viene Limite de Consumo le asigno uno por defecto.
           de acuerdo al plan tarifario
        */


        IF pvLcNuevo = ' ' OR pvLcNuevo IS NULL OR pvLcNuevo = '*'
        THEN
                             vCodLimconsNuevo := '-1';

        ELSE
                 vCodLimconsNuevo := pvLcNuevo;
        END IF;

        IF pvFecDesde = ' ' OR pvFecDesde IS NULL OR pvFecDesde = '*' THEN
            vFecDesdeNuevo := SYSDATE;
             vFecDesdeNuevo_AUX:=vFecDesdeNuevo;
        ELSE
                        SELECT TO_DATE(pvFecDesde, vFormatoSel2||' '||vFormatoSel7) INTO vFecDesdeNuevo FROM DUAL;
 SELECT TO_DATE(pvFecDesde, vFormatoSel2||' '||vFormatoSel7) INTO    vFecDesdeNuevo_AUX FROM DUAL;
        END IF;

        IF pvFecHasta = ' ' OR pvFecHasta IS NULL OR pvFecHasta = '*' THEN
            vFecHastaNuevo := NULL;
        ELSE
            vFecHastaNuevo := TO_DATE(pvFecHasta, vFormatoSel2||' '||vFormatoSel7);
        END IF;

        /* Comienzo de la asignacion de un nuevo limite de consumo
           en caso de venir el parametro pvFecDesde nulo, el cambio
           se aplica de forma inmediata.
        */

        IF pvFecDesde = ' ' OR pvFecDesde IS NULL OR pvFecDesde = '*'
        THEN
            BEGIN
                       SELECT COD_LIMCONS,FEC_DESDE
                   INTO vCodLimcons,vFecDesde
                   FROM GA_LIMITE_CLIABO_TO
                   WHERE COD_CLIENTE = nCodCliHist
                   AND NUM_ABONADO = nNumAbonadoHist
                   AND SYSDATE BETWEEN FEC_DESDE AND NVL(FEC_HASTA,SYSDATE);
            EXCEPTION
                    WHEN NO_DATA_FOUND THEN
                         vCodLimcons := NULL;
                         vFecDesde   := NULL;
            END;

            IF nCantAboHist = 0 AND vCodLimcons IS NOT NULL THEN

                                BEGIN


dbms_output.PUT_LINE('VIENE CON FECHA =' );


                            IF EVTipoMovimiento IN ('EI','EE') THEN
                               UPDATE GA_LIMITE_CLIABO_TO SET
                               FEC_HASTA = SYSDATE - (1/86400)
                               WHERE NUM_ABONADO = 0
                               AND COD_CLIENTE = nCodCliHist
                               AND SYSDATE BETWEEN FEC_DESDE AND NVL(FEC_HASTA,SYSDATE);

                            ELSE
                            UPDATE GA_LIMITE_CLIABO_TO
                            SET    FEC_HASTA   = SYSDATE - (1/(24*60*60))
                            WHERE  NUM_ABONADO = pnSujeto
                                    AND COD_CLIENTE = nCodCliHist
                            AND    SYSDATE BETWEEN FEC_DESDE AND NVL(FEC_HASTA,SYSDATE);
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

                            SELECT 'S' INTO YA_EXISTE
                            FROM   GA_LIMITE_CLIABO_TO
                            WHERE  COD_CLIENTE = nCodCliHist
                            AND    NUM_ABONADO = nNumAbonadoHist
                            AND    SYSDATE BETWEEN FEC_DESDE AND NVL(FEC_HASTA,SYSDATE)
                            AND    COD_LIMCONS = pvLcNuevo;


                        EXCEPTION
                                WHEN OTHERS THEN
                                   YA_EXISTE:='N';

                        END;

                        IF pvErrorAplic='5' THEN  YA_EXISTE:='N'; END IF; --Producto de un traspaso de abonado que implica la baja del abonado original

             ELSE
                YA_EXISTE := 'N';
             END IF;

        ELSE
             BEGIN


                           dbms_output.PUT_LINE('VIENE CON FECHA =' );

                   YA_EXISTE := 'N';
                   SELECT 'S' INTO YA_EXISTE
                   FROM   GA_LIMITE_CLIABO_TO
                   WHERE  COD_CLIENTE = nCodCliHist
                   AND    NUM_ABONADO = nNumAbonadoHist
                   AND    FEC_DESDE = vFecDesdeNuevo
                   AND    COD_LIMCONS = pvLcNuevo;

                         EXCEPTION

                     WHEN NO_DATA_FOUND THEN
                          BEGIN


                       SELECT  vFecDesdeNuevo - (1/(24*60*60)) INTO vFecDesdeNuevo FROM DUAL;

                       UPDATE GA_LIMITE_CLIABO_TO
                                             SET FEC_HASTA   = TO_DATE(to_char(vFecDesdeNuevo,'DD/MM/YY HH24:MI:SS'),'DD/MM/YY HH24:MI:SS')
                               WHERE COD_CLIENTE = nCodCliente
                               AND NUM_ABONADO = nNumAbonado
                       AND SYSDATE BETWEEN FEC_DESDE AND NVL(FEC_HASTA,SYSDATE);
                           vModifca        := 'TRUE';
                               dbms_output.PUT_LINE('ACTUALIZA GA_LIMITE_CLIABO_TO = vFecDesdeNuevo' );

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
pvTrace:='GA_LIMITE_CLIABO_TO3.5'||YA_EXISTE;

        /* Insertamos Limite Nuevo */
        IF YA_EXISTE = 'N' THEN


                        IF nCantAbonados = 0 OR vModifca = 'TRUE' THEN
                                BEGIN

                       BEGIN
                                   SELECT fec_desde
                                   INTO vFecDesdeProximo
                                   FROM GA_LIMITE_CLIABO_TO
                                   WHERE fec_desde > sysdate
                                   AND COD_CLIENTE = nCodCliente
                                       AND NUM_ABONADO = nNumAbonado;


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

                                           IF vFecDesdeProximo IS NOT NULL then

                                           BEGIN
                                                     DELETE FROM GA_LIMITE_CLIABO_TO
                                                     WHERE COD_CLIENTE = nCodCliente
                                                     AND NUM_ABONADO = nNumAbonado
                                                     AND FEC_DESDE=vFecDesdeProximo;

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


                           DBMS_OUTPUT.PUT_LINE('vFecDesdeNuevo ANTES'||vFecDesdeNuevo);
                           vFecDesdeNuevo:=vFecDesdeNuevo_AUX;

                           DBMS_OUTPUT.PUT_LINE('vFecDesdeNuevo DESPUES'||vFecDesdeNuevo);
pvTrace:='GA_LIMITE_CLIABO_TO3.6'||YA_EXISTE;
                           INSERT INTO GA_LIMITE_CLIABO_TO
                           (COD_CLIENTE, NUM_ABONADO, COD_LIMCONS,
                            FEC_DESDE, FEC_HASTA,NOM_USUARORA,
                                FEC_ASIGNACION,COD_PLANTARIF,MTO_CONS)
                           VALUES
                           (nCodCliente,   nNumAbonado, vCodLimconsNuevo,
                                TO_DATE (to_char(vFecDesdeNuevo,'DD/MM/YY HH24:MI:SS'),'DD/MM/YY HH24:MI:SS'), vFecHastaNuevo,USER, SYSDATE,vCodPlantarif,pvimp_limcons );


pvTrace:='GA_LIMITE_CLIABO_TO3.62'||YA_EXISTE;
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
                            pvErrorOraGlosa := SQLERRM;
                            RAISE ERROR_PROCESO;
                    END;

                        END IF;

                        IF pvTipSujeto = 'A' OR pvTipSujeto = 'AL' then/* Operacion por Abonado */
                                    BEGIN

pvTrace:='-> Operacion por Abonado:'||nNumAbonado;

                            IF vFecDesdeNuevo <= (SYSDATE+1/86400) THEN
                                UPDATE GA_ABOCEL
                                SET COD_LIMCONSUMO = vCodLimconsNuevo
                                WHERE NUM_ABONADO = nNumAbonado;

                                          ELSE

                                               BEGIN

                                                  pvTrace:='-> Operacion INSERT INTO ga_finciclo, TIPO SJETO: '||pvTipSujeto;

                                                        select cod_ciclo
                                                                  into v_cod_ciclo
                                                                  from ga_abocel
                                                                 where num_abonado = nNumAbonado;

                                                                select FEC_hastallam + (1/64000) , cod_ciclfact
                                                  into V_fec_desdeciclo, V_coc_ciclfact
                                                                  from fa_ciclfact
                                                                 where cod_ciclo = v_cod_ciclo
                                   and sysdate between fec_desdellam and fec_hastallam;

                                                            INSERT INTO ga_finciclo
                                                                    (COD_CLIENTE, NUM_ABONADO, COD_CICLFACT, COD_PRODUCTO, TIP_PLANTARIF, COD_PLANTARIF,
                                                                         FEC_DESDELLAM, NUM_DIAS)
                                          VALUES (nCodCliente, pnSujeto, V_coc_ciclfact, 1, 'I', -1,V_fec_desdeciclo,1);

                                                   EXCEPTION WHEN NO_DATA_FOUND THEN
                                                            pvCodValor          := 'FALSE';
                                    pvErrorAplic        := '4';
                                    pvErrorGlosa        := 'problemas al insertar registro en ga_finciclo';
                                    pvErrorOra          := TO_CHAR(SQLCODE);
                                    pvErrorOraGlosa := SQLERRM;
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

pvTrace:='-> Operacion por Cliente:'||nCodCliente;

                              if vFecDesdeNuevo< SYSDATE THEN
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

pvTrace:='-> Tipo Sujeto CL:'||pnSujeto;

                           BEGIN

                   --- no se actualiza ga_abocel debido a que se hace en actabo (unix)

                                PV_LIMITE_INTARCEL_PR (pnSujeto,pvLcNuevo,pvFecDesde,pvimp_limcons,pvErrorOra,pvErrorOraGlosa,pvErrorAplic);

                                IF nCodRetorno > 0 THEN
                   pvCodValor      := 'FALSE';
                   pvErrorAplic    := '4';
                   pvErrorGlosa    := SUBSTR(pvErrorOraGlosa,1,60);
                                   RAISE ERROR_PROCESO;
                END IF;

                            EXCEPTION
                      WHEN OTHERS THEN
                         pvCodValor := 'FALSE';
                         pvErrorAplic := '4';
                         pvErrorGlosa := 'problemas al actualizar el nuevo limite Cliente';
                         pvErrorOra := TO_CHAR(SQLCODE);
                         pvErrorOraGlosa := SQLERRM;
                         RAISE ERROR_PROCESO;
                   END;


                        END IF;


        ELSE
                        -- SI EXISTE SE CAMBIA LC

 pvTrace:='UPDATE GA_LIMITE_CLIABO_TO:'|| EVTipoMovimiento ;
                        IF EVTipoMovimiento IN ('EI','EE') THEN

                           UPDATE GA_LIMITE_CLIABO_TO SET
                           COD_LIMCONS = vCodLimconsNuevo
                           WHERE COD_CLIENTE = nCodCliHist
                           AND NUM_ABONADO = 0
                           AND FEC_DESDE = vFecDesdeNuevo;

                        ELSE
                                pvTrace:='GA_LIMITE_CLIABO_TO3.7';


                        UPDATE GA_LIMITE_CLIABO_TO
                        SET    COD_LIMCONS = vCodLimconsNuevo
                        WHERE  COD_CLIENTE = nCodCliente
                        AND    NUM_ABONADO = nNumAbonado
                        AND    FEC_DESDE = vFecDesdeNuevo;



                        END IF;


        END IF;

    IF pvTipSujeto = 'A' /* Operacion por Abonado */
    THEN


pvTrace:='-> Operacion por abonado, tipo sujeto  :'||pvTipSujeto;

         IF ge_log_pg.debug_activo THEN
                ge_log_pg.DEBUG( 'pv_limite_consumo_pg - vFecDesdeNuevo:'||vFecDesdeNuevo);
         END IF;


         if TO_DATE(vFecDesdeNuevo,'DD-MM-YY HH24:MI:SS')  > SYSDATE then
                   IF ge_log_pg.debug_activo THEN
                                 ge_log_pg.DEBUG( 'pv_limite_consumo_TRASPASO_pg - PV_LIMITE_CONSUMO_RANGO_PG.PV_LIMITE_CONSUMO_RANGO_PR');
                   END IF;

                   PV_LIMITE_CONSUMO_RANGO_PG.PV_LIMITE_CONSUMO_RANGO_PR(1,nCodCliente, pnSujeto, vCodLimconsNuevo,vFecDesdeNuevo ,pvimp_limcons ,VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,
                                VP_SQLERRM,V_ERROR);

                  IF V_ERROR > 0 THEN

                      pvCodValor := 'FALSE';
                      pvErrorAplic := '4';
                      pvErrorGlosa := SUBSTR(vDesCadena,1,60);
                      pvErrorOra := TO_CHAR(SQLCODE);
                      pvErrorOraGlosa := SUBSTR(SQLERRM,1,60);
                          RAISE ERROR_PROCESO;
                 END IF;



         ELSE

pvTrace:='-> antes ejecuta PV_LIMITE_CONSUMO_RANGO_PG.PV_LIMITE_CONSUMO_RANGO_PR';

                  IF ge_log_pg.debug_activo THEN
                        ge_log_pg.DEBUG( 'pv_limite_consumo_pg - vFecDesdeNuevo:'||vFecDesdeNuevo);
                  END IF;


                  IF ge_log_pg.debug_activo THEN
                               ge_log_pg.DEBUG( 'pv_limite_consumo_TRASPASO_pg - PV_LIMITE_CONSUMO_RANGO_PG.PV_LIMITE_CONSUMO_RANGO_PR');
                  END IF;


                  pvTrace:='PV_LIMITE_CONSUMO_RANGO_PG.PV_LIMITE_CONSUMO_RANGO_PR';

                  PV_LIMITE_CONSUMO_RANGO_PG.PV_LIMITE_CONSUMO_RANGO_PR(1,nCodCliente, pnSujeto, vCodLimconsNuevo,vFecDesdeNuevo ,pvimp_limcons ,VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,
                                VP_SQLERRM,V_ERROR);

                  IF V_ERROR > 0 THEN

                      pvCodValor := 'FALSE';
                      pvErrorAplic := '4';
                      pvErrorGlosa := SUBSTR(vDesCadena,1,60);
                      pvErrorOra := TO_CHAR(SQLCODE);
                      pvErrorOraGlosa := SUBSTR(SQLERRM,1,60);
                          RAISE ERROR_PROCESO;
                 END IF;
         END IF;
    ELSE


        IF pvTipSujeto = 'AL' THEN

---pvTrace:='-> Tipo Sujeto = AL---> '||nCodCliente||'+'||pnSujeto||'+'||vCodLimconsNuevo||'+'||vFecDesdeNuevo||'+'||pvimp_limcons;

 ---pvTrace:='-> Error1: '||V_ERROR;

---lmv
               PV_LIMITE_CONSUMO_RANGO_PG.PV_LIMITE_CONSUMO_RANGO_PR(1,nCodCliente, pnSujeto, vCodLimconsNuevo,vFecDesdeNuevo ,pvimp_limcons ,VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,
                                VP_SQLERRM,V_ERROR);

               IF V_ERROR > 0 THEN

               --pvTrace:='-> Error2: '||V_ERROR||'+'||SUBSTR(SQLERRM,1,60)||'+'|| TO_CHAR(SQLCODE);

                      pvCodValor := 'FALSE';
                  pvErrorAplic := '4';
                  pvErrorGlosa := SUBSTR(vDesCadena,1,60);
                  pvErrorOra := TO_CHAR(SQLCODE);
                  pvErrorOraGlosa := SUBSTR(SQLERRM,1,60);
                      RAISE ERROR_PROCESO;
               END IF;

               ---pvTrace:='-> Tipo Sujeto = AL --->salida normal ';

            END IF;

    END IF;

    IF pvTipSujeto = 'AL' THEN
---pvTrace:='-> antes INSERT INTO GA_MODABOCEL';

           BEGIN

                INSERT INTO GA_MODABOCEL(NUM_ABONADO,
                                         COD_TIPMODI,
                                         FEC_MODIFICA,
                                         NOM_USUARORA,
                                         COD_LIMCONSUMO)
                                         VALUES (nNumAbonado,
                                         'IA',
                                         SYSDATE,
                                         USER,
                                         vCodLimConsActual);

        EXCEPTION
                  WHEN OTHERS THEN

                                   pvCodValor := 'FALSE';
                           pvErrorAplic := '4';
                           pvErrorGlosa := 'Problemas al insertar modificaciones del Abonado';
                           pvErrorOra := TO_CHAR(SQLCODE);
                           pvErrorOraGlosa := SUBSTR(SQLERRM,1,60);
                                   RAISE ERROR_PROCESO;
            END;

    ELSIF pvTipSujeto = 'CL' THEN
       BEGIN

---pvTrace:='-> antes INSERT INTO GA_MODCLI';
                   INSERT INTO GA_MODCLI(COD_CLIENTE,
                                         COD_TIPMODI,
                                         FEC_MODIFICA,
                                         NOM_USUARORA,
                                         COD_LIMCONSUMO)
                                         VALUES (nCodCliente,
                                        'IC',
                                        SYSDATE,
                                        USER,
                                        vCodLimConsActual);
           EXCEPTION
                    WHEN OTHERS THEN

                                     pvCodValor := 'FALSE';
                             pvErrorAplic := '4';
                             pvErrorGlosa := 'Problemas al insertar modificaciones del Cliente';
                             pvErrorOra := TO_CHAR(SQLCODE);
                             pvErrorOraGlosa := SUBSTR(SQLERRM,1,60);
       END;

        END IF;


        if pvCodValor = 'TRUE' THEN
            pvErrorAplic        := '0';
        pvErrorGlosa    := 'OK';
        pvErrorOra              := '0';
        pvErrorOraGlosa := 'OK';
                pvTrace                 := 'OK';
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
             pvTrace:= 'PV_MODIFICA_LCCICLO_PR-' || pvTrace;

END PV_MODIFICA_LCCICLO_PR;


PROCEDURE PV_OPERA_LIMITE_PR(pnSujeto        IN  NUMBER,
                             pvTipSujeto     IN  VARCHAR2,
                             pvFecDesde      IN  VARCHAR2,
                             pvFecHasta      IN  VARCHAR2,
                             pvCodActabo     IN  VARCHAR2,
                             pvCodPlantarif  IN  VARCHAR2,
                             pvTipMovimiento IN  VARCHAR2,
                             pvcod_limcons   IN  VARCHAR2,
                             pvimp_limcons   IN  NUMBER,
                             pvCodValor      OUT NOCOPY VARCHAR2,
                             pvErrorAplic    OUT NOCOPY VARCHAR2,
                             pvErrorGlosa    OUT NOCOPY VARCHAR2,
                             pvErrorOra      OUT NOCOPY VARCHAR2,
                             pvErrorOraGlosa OUT NOCOPY VARCHAR2,
                             pvTrace         OUT NOCOPY VARCHAR2
)
IS
        dFecDesde        GA_LIMITE_CLIABO_TO.FEC_DESDE%TYPE;
        dFecHasta        GA_LIMITE_CLIABO_TO.FEC_HASTA%TYPE;
        nCodCliente      GE_CLIENTES.COD_CLIENTE%TYPE;
        nNumAbonado      GA_ABOCEL.NUM_ABONADO%TYPE;
        vCodPlantarif    TA_PLANTARIF.COD_PLANTARIF%TYPE;
        vFormatoSel2     GED_PARAMETROS.VAL_PARAMETRO%TYPE;
        vFormatoSel7     GED_PARAMETROS.VAL_PARAMETRO%TYPE;
        vCodLimconsNuevo GA_LIMITE_CLIABO_TO.COD_LIMCONS%TYPE;
        p_abonado        GA_ABOCEL.NUM_ABONADO%TYPE;
        vCodLimcons      ga_limite_cliabo_to.COD_LIMCONS%type;
        nCantAbonados    NUMBER(10);
        LV_LIMCONSUMO_AUX  TOL_LIMITE_TD.IMP_LIMITE%TYPE;
        LV_TIPLAN_AUX      TA_PLANTARIF.COD_TIPLAN%TYPE;
        p_cliente       number(8);

        LN_cod_clienant           ga_traspabo.cod_clienant%TYPE;

        EXIT_PROCESO    EXCEPTION;

        vEstadoIntarcel   VARCHAR2(100);
        LN_NUM_OS        PV_IORSERV.NUM_OS%TYPE;
        LV_fECHA         GA_INTARCEL.FEC_DESDE%TYPE;
        LV_CICLO         GA_aBOCEL.COD_CICLO%TYPE;

BEGIN
        DBMS_OUTPUT.PUT_LINE('PV_OPERA_LIMITE_PR');

        vFormatoSel2    := ge_fn_devvalparam('GE', 1, 'FORMATO_SEL2');
        vFormatoSel7    := ge_fn_devvalparam('GE', 1, 'FORMATO_SEL7');
        pvCodValor      := 'TRUE';
        pvErrorAplic    := '0';
        pvErrorGlosa    := ' ';
        pvErrorOra          := '0';
        pvErrorOraGlosa := ' ';
        pvTrace             := ' ';
            nCantAbonados       :=0;

   IF GE_FN_DEVVALPARAM('GE', 1, 'IND_TOL') = 'N'
    THEN
        pvCodValor := 'TRUE';
                RAISE EXIT_PROCESO;
    END IF;


        IF pvFecDesde = ' ' OR pvFecDesde IS NULL OR pvFecDesde = '*'
        THEN
                dFecDesde := SYSDATE;
        ELSE
                dFecDesde := TO_DATE(pvFecDesde, vFormatoSel2||' '||vFormatoSel7);
        END IF;

        IF pvFecHasta = ' ' OR pvFecHasta IS NULL OR pvFecHasta = '*'
        THEN
                dFecHasta := NULL;
        ELSE
                dFecHasta := TO_DATE(pvFecHasta, vFormatoSel2||' '||vFormatoSel7);
        END IF;

        IF pvTipSujeto = 'C' OR pvTipSujeto = 'CL'/* Operacion por Cliente */
        THEN
                nCodCliente := pnSujeto;
                nNumAbonado := 0;
        ELSIF pvTipSujeto = 'A' OR pvTipSujeto = 'AL'/* Operacion por Abonado */
        THEN
                nNumAbonado := pnSujeto;
                pvTrace:='GA_ABOCEL';
                SELECT COD_CLIENTE
                  INTO nCodCliente
                  FROM GA_ABOCEL
                 WHERE NUM_ABONADO = nNumAbonado;

                END IF;



        IF pvCodActabo IN ('TA','TP','RO','AE','T2','R2','A2') -- Traspaso de Abonados
                                                               -- Traspaso de Propiedad
                                                               -- Cambio de Plan con Reordenamiento
        THEN
                IF pvTipMovimiento IN ('IE', 'EI')
                THEN
                     IF pvTipMovimiento = 'IE'  THEN
                             BEGIN
                                     SELECT COUNT(*)
                                      INTO nCantAbonados
                                      FROM GA_ABOCEL
                                      WHERE COD_SITUACION = 'AAA'
                                      AND COD_CLIENTE = nCodCliente
                                      AND TIP_PLANTARIF ='I'
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
                                   SELECT COD_LIMCONS
                                   INTO vCodLimconsNuevo
                                   FROM TOL_LIMITE_PLAN_TD
                                   WHERE COD_PLANTARIF = pvCodPlantarif
                                   AND SYSDATE BETWEEN FEC_DESDE
                                   AND NVL(FEC_HASTA, SYSDATE)
                                   AND IND_DEFAULT = 'S';

                                  BEGIN
                                          SELECT COD_LIMCONS
                                          INTO vCodLimcons
                                          FROM GA_LIMITE_CLIABO_TO
                                          WHERE COD_CLIENTE = nCodCliente
                                          AND NUM_ABONADO = 0
                                          AND SYSDATE BETWEEN FEC_DESDE AND NVL(FEC_HASTA,SYSDATE);



                                  EXCEPTION
                                         WHEN NO_DATA_FOUND THEN

                                              IF nCantAbonados = 0  THEN

                                                   PV_MODIFICA_LC_PR (nCodCliente,'C','*','0','*','*',pvimp_limcons,pvCodValor,pvErrorAplic,pvErrorGlosa,pvErrorOra,
                                                                      pvErrorOraGlosa,pvTrace,pvCodPlantarif,pvTipMovimiento);
                                                   if pvCodValor != 'TRUE' then
                                                      RAISE EXIT_PROCESO;
                                                   end if;

                                              ELSE

                                                   PV_MODIFICA_LC_PR    (pnSujeto,pvTipSujeto,'*','0','*','*',pvimp_limcons,pvCodValor,
                                                                         pvErrorAplic,pvErrorGlosa,pvErrorOra,pvErrorOraGlosa,
                                                                         pvTrace,pvCodPlantarif,pvTipMovimiento);

                                                   if pvCodValor != 'TRUE' then
                                                      RAISE EXIT_PROCESO;
                                                   end if;

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
                                          FROM ga_traspabo
                                          WHERE num_abonado = pnSujeto
                                          AND cod_cliennue = nCodCliente
                                          AND fec_modifica = (SELECT max(fec_modifica)
                                                              FROM ga_traspabo
                                                              WHERE num_abonado = pnSujeto
                                                              AND cod_cliennue = nCodCliente);

                                          UPDATE GA_LIMITE_CLIABO_TO
                                          SET    FEC_HASTA   = SYSDATE - (1/(24*60*60))
                                          WHERE  NUM_ABONADO = pnSujeto  AND cod_cliente = LN_cod_clienant
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


                             if pvCodValor != 'TRUE' then
                                            RAISE EXIT_PROCESO;
                             end if;

                     ELSE

                         PV_MODIFICA_LC_PR(pnSujeto,pvTipSujeto,'*','0','*','*',pvimp_limcons,pvCodValor,pvErrorAplic,
                                           pvErrorGlosa,pvErrorOra,pvErrorOraGlosa,pvTrace,pvCodPlantarif
                                           ,pvTipMovimiento);

                         if pvCodValor != 'TRUE' then
                            RAISE EXIT_PROCESO;
                         end if;

                     END IF;

                ELSIF pvTipMovimiento IN ('EE', 'II', '*', ' ') OR pvTipMovimiento IS NULL
                THEN
                        IF pvCodPlantarif IS NOT NULL AND pvCodPlantarif NOT IN (' ', '*')
                        THEN
                               
                               
                               SELECT  COD_TIPLAN
                               INTO LV_TIPLAN_AUX
                               FROM TA_PLANTARIF
                               WHERE COD_PLANTARIF = pvCodPlantarif;

                               IF (trim(LV_TIPLAN_AUX)) ='3' THEN

                                  vCodLimconsNuevo := '*';

                               ELSE

                                  vCodLimconsNuevo:=pvcod_limcons;

                               END IF;
                               

                               pvTrace:='PV_MODIFICA_LC_PR';
                                                               
                               
                               PV_MODIFICA_LC_PR( pnSujeto,
                                                   pvTipSujeto,
                                                   vCodLimconsNuevo,
                                                   '0',
                                                   '*',
                                                   '*',
                                                   pvimp_limcons,
                                                   pvCodValor,
                                                    pvErrorAplic,
                                                   pvErrorGlosa,
                                                   pvErrorOra,
                                                   pvErrorOraGlosa,
                                                   pvTrace,pvCodPlantarif
                                                   ,pvTipMovimiento);
                               
                                                   


                                if pvCodValor != 'TRUE' then
                                                  RAISE EXIT_PROCESO;
                                end if;

                        ELSE
                                DBMS_OUTPUT.PUT_LINE('***');
                        END IF;
                END IF;
         END IF;

RAISE EXIT_PROCESO;

EXCEPTION
        WHEN EXIT_PROCESO  THEN
             DBMS_OUTPUT.PUT_LINE('FIN PROCESO');

        WHEN OTHERS THEN
             pvCodValor:='FALSE';
             pvErrorAplic:='4';
             pvErrorGlosa:='Error de Aplicación';
             pvErrorOra:= SUBSTR(SQLCODE,1,50);
             pvErrorOraGlosa:= SUBSTR(SQLERRM,1,255);
             pvTrace:= 'END PV_OPERA_LIMITE_PR-' || pvTrace;
END PV_OPERA_LIMITE_PR;


END PV_LIMITE_CONSUMO_TRASPASO_PG;
/
SHOW ERROR