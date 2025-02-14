CREATE OR REPLACE PROCEDURE CE_P_CAL_COMI(
        grpservicio IN VARCHAR2,
        periodo IN VARCHAR2,
        resul IN OUT VARCHAR2)
        IS
        marca                   NUMBER(8);
        num_pro             NUMBER(8);
        pfec_desde          CET_PERIODOSERV.FEC_DESDE%TYPE;
        pfec_hasta          CET_PERIODOSERV.FEC_HASTA%TYPE;
        pmto_servicio   FA_PREFACTURA.IMP_CONCEPTO%TYPE;
        pnum_tran           NUMBER(12);
        pcomision           CED_COMISION.VAL_COMISION%TYPE;
        indicador       CED_COMISION.IND_VARFIJA%TYPE;
        ptip_valor      CED_COMISION.TIP_VALOR%TYPE;
        pmto_comi       CEH_COMISIONES.MTO_COMISIONES%TYPE;
        pnum_cuadrante  CED_COMISION.NUM_CUADRANTE%TYPE;
        pcod_tipcuad    CED_COMISION.COD_TIPCUAD%TYPE;
        pprome_mtoser   NUMBER(12);
        pcod_concsimple CED_DETCOMIS.COD_CONCSIMPLE%TYPE;
        pcod_concdoble  CED_DETCOMIS.COD_CONCDOBLE%TYPE;
        pcod_moneda     CED_COMISION.COD_MONEDA%TYPE;
        pcambio                 GE_CONVERSION.CAMBIO%TYPE;
        ptip_unidad             CED_DETCOMIS.TIP_UNIDAD%TYPE;
        pempresa                CET_PERIODOSERV.COD_EMPRESA%TYPE;
        pmin_serie              AL_SERIES.NUM_SERIE%TYPE;
        pmax_serie              AL_SERIES.NUM_SERIE%TYPE;
        pcant_claves    NUMBER(12);
        pval_inicio             NUMBER(12);
        pacumulado              NUMBER(12);
        servicio                CET_PERIODOSERV.COD_SERVICIO%TYPE;
--
-- *************************************************************
-- * procedimiento      : CE_P_CAL_COMI
-- * Descripcion        : Calcular comisiones para periodos de facturacion
-- * Fecha de creacion  :
-- * Responsable        : Comisiones
-- * PARAMETROS         : grupo de servicio - periodo
-- *************************************************************
--
CURSOR COMISION IS
SELECT COD_SERVICIO FROM CED_GRPCOMIS
WHERE COD_GRPSERV=grpservicio;
ERROR_PROCESO EXCEPTION;
BEGIN
resul:='OK';
marca:=35;
    SELECT CES_NUMPROC.NEXTVAL INTO num_pro FROM DUAL;
        SELECT COD_EMPRESA, FEC_DESDE, FEC_HASTA
        INTO pempresa, pfec_desde, pfec_hasta
        FROM CET_PERIODOSERV
        WHERE COD_SERVICIO=servicio
        AND IND_GRUPOSERV=1
        AND COD_PERIODO=periodo;
        OPEN COMISION;
LOOP
        marca:=59;
        FETCH COMISION INTO servicio;
        EXIT WHEN COMISION%NOTFOUND;
        marca:=60;
    UPDATE CET_TRANSACCION SET
        NUM_PROCOMIS=num_pro,
        IND_COMISION='1',
        FEC_MOVIMIENTO=sysdate
        WHERE
        IND_COMISION='0'
        AND NUM_PROCOMIS='0'
        AND COD_EMPRSERV=pempresa
        AND COD_SERVICIO =servicio
        AND FEC_MOVIMIENTO BETWEEN pfec_desde AND pfec_hasta;
END LOOP;
        marca:=53;
        SELECT SUM(MTO_SERVICIO), COUNT(MTO_SERVICIO) INTO pmto_servicio, pnum_tran FROM CET_TRANSACCION
        WHERE NUM_PROCOMIS=num_pro;
        pprome_mtoser:=pmto_servicio/pnum_tran;
        marca:=57;
        SELECT IND_VARFIJA, VAL_COMISION, TIP_VALOR, COD_MONEDA
        INTO indicador, pcomision, ptip_valor, pcod_moneda
        FROM CED_COMISION
        WHERE COD_EMPRESA=pempresa
        AND COD_GRPSERV=grpservicio
        AND SYSDATE BETWEEN FEC_DESDE AND FEC_HASTA;
        IF indicador='F' THEN
                IF ptip_valor='M' THEN --Monto
                        marca:=64;
                SELECT CAMBIO INTO pcambio FROM GE_CONVERSION WHERE
                        COD_MONEDA=pcod_moneda
                        AND SYSDATE BETWEEN FEC_DESDE AND FEC_HASTA;
                    pmto_comi:=pcomision * pcambio;     --PESO - UF  - DOLAR
                ELSE                               --Porcentaje
                   pmto_comi:=(pmto_servicio * pcomision)/100;
                END IF;
        ELSE    -- ES VARIABLE
                marca:=75;
                SELECT NUM_CUADRANTE, COD_TIPCUAD
                INTO pnum_cuadrante, pcod_tipcuad
                FROM CED_COMISION
                WHERE COD_EMPRESA=pempresa
                AND COD_GRPSERV=grpservicio
                AND SYSDATE BETWEEN FEC_DESDE AND FEC_HASTA;
                -- RESCATA CODIGO TIPO DE CUADRANTE PARA RESCATAR COMISION RESCATA CODIGO SIMPLE Y/O DOBLE
                -- Y TIPO DE UNIDAD
                marca:=84;
                SELECT DISTINCT(COD_CONCSIMPLE), COD_CONCDOBLE, TIP_UNIDAD, COD_MONEDA
                INTO pcod_concsimple, pcod_concdoble, ptip_unidad, pcod_moneda
                FROM CED_DETCOMIS
                WHERE NUM_CUADRANTE=pnum_cuadrante
                AND SYSDATE BETWEEN FEC_INICIO AND FEC_TERMINO;
                --SELECCCIONA EL CAMBIO DE MONEDA--
                marca:=91;
            SELECT CAMBIO INTO pcambio FROM GE_CONVERSION WHERE
                COD_MONEDA=pcod_moneda
                AND SYSDATE BETWEEN FEC_DESDE AND FEC_HASTA;
                IF pcod_tipcuad='S' THEN
                        IF pcod_concsimple='MT' THEN --Monto transado
                                marca:=97;
                                SELECT VAL_COMISION, VAL_INICIO, MTO_ACUMULADO
                                INTO pcomision, pval_inicio, pacumulado
                                FROM CED_DETCOMIS
                                WHERE NUM_CUADRANTE=pnum_cuadrante
                                AND pmto_servicio BETWEEN VAL_INICIO AND VAL_TERMINO
                                AND SYSDATE BETWEEN FEC_INICIO AND FEC_TERMINO;
                        END IF;
                        IF pcod_concsimple='VP' THEN -- Valor promedio transaccion
                            marca:=104;
                                SELECT VAL_COMISION, VAL_INICIO, MTO_ACUMULADO
                                INTO pcomision, pval_inicio, pacumulado
                                FROM CED_DETCOMIS
                                WHERE NUM_CUADRANTE=pnum_cuadrante
                                AND pprome_mtoser BETWEEN VAL_INICIO AND VAL_TERMINO
                                AND SYSDATE BETWEEN FEC_INICIO AND FEC_TERMINO;
                        END IF;
                        IF pcod_concsimple='CT' THEN -- Cantidad transacciones
                           marca:=111;
                                SELECT VAL_COMISION, VAL_INICIO, MTO_ACUMULADO
                                INTO pcomision, pval_inicio, pacumulado
                                FROM CED_DETCOMIS
                                WHERE NUM_CUADRANTE=pnum_cuadrante
                                AND pnum_tran BETWEEN VAL_INICIO AND VAL_TERMINO
                                AND SYSDATE BETWEEN FEC_INICIO AND FEC_TERMINO;
                        END IF;
                ELSE -- SI ES DOBLE
                        IF pcod_concsimple='MT' AND pcod_concdoble= 'CT' THEN
                            marca:=119;
                                SELECT VAL_COMISION, VAL_INICIO, MTO_ACUMULADO
                                INTO pcomision, pval_inicio, pacumulado
                                FROM CED_DETCOMIS
                                WHERE NUM_CUADRANTE=pnum_cuadrante
                                AND pmto_servicio BETWEEN VAL_INICIO AND VAL_TERMINO
                                AND pnum_tran BETWEEN VAL_INICIO2 AND VAL_TERMINO2
                                AND SYSDATE BETWEEN FEC_INICIO AND FEC_TERMINO;
                        END IF;
                        IF pcod_concsimple='CT' AND pcod_concdoble= 'MT' THEN
                            marca:=127;
                                SELECT VAL_COMISION, VAL_INICIO, MTO_ACUMULADO
                                INTO pcomision, pval_inicio, pacumulado
                                FROM CED_DETCOMIS
                                WHERE NUM_CUADRANTE=pnum_cuadrante
                                AND pnum_tran BETWEEN VAL_INICIO AND VAL_TERMINO
                                AND pmto_servicio  BETWEEN VAL_INICIO2 AND VAL_TERMINO2
                                AND SYSDATE BETWEEN FEC_INICIO AND FEC_TERMINO;
                        END IF;
                        IF pcod_concsimple='VP' AND pcod_concdoble= 'CT' THEN
                            marca:=135;
                                SELECT VAL_COMISION, VAL_INICIO, MTO_ACUMULADO
                                INTO pcomision, pval_inicio, pacumulado
                                FROM CED_DETCOMIS
                                WHERE NUM_CUADRANTE=pnum_cuadrante
                                AND pprome_mtoser BETWEEN VAL_INICIO AND VAL_TERMINO
                                AND pnum_tran BETWEEN VAL_INICIO2 AND VAL_TERMINO2
                                AND SYSDATE BETWEEN FEC_INICIO AND FEC_TERMINO;
                        END IF;
                        IF pcod_concsimple='CT' AND pcod_concdoble= 'VP' THEN
                            marca:=143;
                                SELECT VAL_COMISION, VAL_INICIO, MTO_ACUMULADO
                                INTO pcomision, pval_inicio, pacumulado
                                FROM CED_DETCOMIS
                                WHERE NUM_CUADRANTE=pnum_cuadrante
                                AND pnum_tran BETWEEN VAL_INICIO AND VAL_TERMINO
                                AND pprome_mtoser BETWEEN VAL_INICIO2 AND VAL_TERMINO2
                                AND SYSDATE BETWEEN FEC_INICIO AND FEC_TERMINO;
                        END IF;
                        IF pcod_concsimple='MT' AND pcod_concdoble= 'VP' THEN
                            marca:=151;
                                SELECT VAL_COMISION, VAL_INICIO, MTO_ACUMULADO
                                INTO pcomision, pval_inicio, pacumulado
                                FROM CED_DETCOMIS
                                WHERE NUM_CUADRANTE=pnum_cuadrante
                                AND pmto_servicio BETWEEN VAL_INICIO AND VAL_TERMINO
                                AND pprome_mtoser BETWEEN VAL_INICIO2 AND VAL_TERMINO2
                                AND SYSDATE BETWEEN FEC_INICIO AND FEC_TERMINO;
                        END IF;
                        IF pcod_concsimple='VP' AND pcod_concdoble= 'MT' THEN
                            marca:=159;
                                SELECT VAL_COMISION, VAL_INICIO, MTO_ACUMULADO
                                INTO pcomision, pval_inicio, pacumulado
                                FROM CED_DETCOMIS
                                WHERE NUM_CUADRANTE=pnum_cuadrante
                                AND pprome_mtoser BETWEEN VAL_INICIO AND VAL_TERMINO
                                AND pmto_servicio BETWEEN VAL_INICIO2 AND VAL_TERMINO2
                                AND SYSDATE BETWEEN FEC_INICIO AND FEC_TERMINO;
                        END IF;
                END IF;
                IF ptip_valor='M' THEN
                   IF ptip_unidad='T' THEN-- SI ES POR TRANSACCION
                          pmto_comi:=pnum_tran * pcomision * pcambio;
                   END IF;
                   IF ptip_unidad='C' THEN-- SI ES POR CUADRANTE
                  pmto_comi:=pcomision * pcambio;
                   END IF;
                   IF ptip_unidad='I' THEN-- SI ES POR INTERVALO
                          pmto_comi:=((pnum_tran - pval_inicio + 1)*pcomision) + pacumulado;
                                SELECT MAX(val_comision)
                                INTO pcomision
                                FROM CED_DETCOMIS
                                WHERE NUM_CUADRANTE=pnum_cuadrante
                                AND SYSDATE BETWEEN FEC_INICIO AND FEC_TERMINO;
                   END IF;
                ELSE
                   pmto_comi:=(pmto_servicio*pcomision)/100;
                END IF;
        END IF;
        marca:=177;
        INSERT INTO CEH_COMISIONES
        (
        Cod_empresa,         --Transaccisn (empresa)
        cod_grpserv,        --Transaccisn (servicio)
        Cod_periodo,         --Parametro
        Fec_desde,           --cet_periodoserv
        Fec_hasta,           --cet_periodoserv
        Cod_estado,          --'GE'
        num_proceso,             -- num_proceso
        Num_transaccion,     --Cantidad de transacciones
        Mto_transaccion,     --Monto de transacciones acumuladas
        Num_transinfor,      --0
        Mto_transinfor,      --0
        Num_transcomis,      --0
        Mto_transcomis,      --0
        Val_comision,        --Valor comisisn aplicada
        Mto_comisiones,      --Monto comisisn calculada
        Fec_proceso,         --sysdate
        Fec_conciliacion,    -- ""
        Fec_pagocomis,       -- ""
        Fec_cierre           -- ""
        )
        VALUES
        (
        pempresa,                --         Cod_empresa     VARCHAR2(5) 1       N
        grpservicio,     --     cod_servicio    VARCHAR2(5)     2
        periodo,         --     Cod_periodo     VARCHAR2(6)     3       N
        pfec_desde,      --     Fec_desde       DATE                    N
        pfec_hasta,      --     Fec_hasta       DATE                    N
        'GE',           --      Cod_estado      VARCHAR2(2)             N
        num_pro,
        pnum_tran,      --      Num_transaccion NUMBER(6)
        pmto_servicio,  --      Mto_transaccion NUMBER(14,4)
        0,              --      Num_transinfor  NUMBER(6)
        0,              --      Mto_transinfor  NUMBER(14,4)
        0,              --      Num_transcomis  NUMBER(6)
        0,              --      Mto_transcomis  NUMBER(14,4)
        pcomision,      --      Val_comision    NUMBER(14,4)
        pmto_comi,              --      Mto_comisiones  NUMBER(14,4)
        sysdate,        --      Fec_proceso     DATE
        NULL,           --      Fec_conciliacionDATE
        NULL,           --      Fec_pagocomis   DATE
        NULL            --      Fec_cierre      DATE
        );
        EXCEPTION
        WHEN ERROR_PROCESO THEN
        RESUL:=SQLERRM||' linea: '||marca;
                ROLLBACK;
        WHEN OTHERS THEN
        RESUL:=SQLERRM||' linea: '||marca;
        ROLLBACK;
END CE_P_CAL_COMI;
/
SHOW ERRORS
