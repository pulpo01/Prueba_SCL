CREATE OR REPLACE PROCEDURE CO_EMI_MISCELANEA
(secuencia_ga       IN VARCHAR2
,vp_num_interfaz    IN VARCHAR2
,vp_concepto_fact	IN NUMBER
) IS

vp_entrada          VARCHAR2(1);
usuario             VARCHAR2(30);
fecha               VARCHAR(10);
vp_gls_error        VARCHAR2(255);
vp_error            NUMBER(2);
vp_total_siniva     NUMBER(14,4);
sFormatoFecha       GED_PARAMETROS.VAL_PARAMETRO%TYPE;

vp_num_proceso      FA_INTERFACT.NUM_PROCESO%TYPE;
vp_cod_cliente      CO_INTERFAZ_CAJA.COD_CLIENTE%TYPE;
vp_cod_oficina      GE_SEG_USUARIO.COD_OFICINA%TYPE;
vp_cod_vendedor     GE_SEG_USUARIO.COD_VENDEDOR%TYPE;
vp_des_oficina      GE_OFICINAS.DES_OFICINA%TYPE;
vp_nom_vendedor     VE_VENDEDORES.NOM_VENDEDOR%TYPE;
vp_documento        FA_DATOSGENER.COD_MISCELA%TYPE;
vp_moneda           FA_DATOSGENER.COD_MONEFACT%TYPE;
vp_cod_centremi     AL_DOCUM_SUCURSAL.COD_CENTREMI%TYPE;
vp_cod_catimpos     GE_CATIMPCLIENTES.COD_CATIMPOS%TYPE;
vp_letra            GE_LETRAS.LETRA%TYPE;
vp_seq_miscel       FA_PROCESOS.NUM_SECUAG%TYPE;
vp_cod_region       GE_OFICINAS.COD_REGION%TYPE;
vp_cod_provincia    GE_OFICINAS.COD_PROVINCIA%TYPE;
vp_cod_ciudad       GE_DIRECCIONES.COD_CIUDAD%TYPE;
vp_cod_comuna       GE_OFICINAS.COD_COMUNA%TYPE;
vp_cod_plancom      GA_CLIENTE_PCOM.COD_PLANCOM%TYPE;
--secuencia_ga        GA_TRANSACABO.NUM_TRANSACCION%TYPE;
vp_cod_catribut     GA_CATRIBUTCLIE.COD_CATRIBUT%TYPE;
vp_cod_modgener     FA_GENCENTREMI.COD_MODGENER%TYPE;
vp_tip_movimiento   CO_INTERFAZ_CAJA.TIP_MOVIMIENTO%TYPE;
vp_num_movimiento   CO_INTERFAZ_CAJA.NUM_MOVIMIENTO%TYPE;
vp_cod_estado       FA_PERCONTABLE.COD_ESTADO%TYPE;
--iSec_PresupTemp     NUMBER(5);
iSec_PresupTemp     FAT_PRESUPTEMP.NUM_PROCESO%TYPE;
dMonto_Impos        NUMBER(14,4);
iSumaImp            NUMBER(14,4):=0;
iCod_concepto       FA_CONCEPTOS.COD_CONCEPTO%TYPE;
iTipConce           FA_CONCEPTOS.COD_TIPCONCE%TYPE;
iCod_Concerel       FAT_PRESUPTEMP.COD_CONCEREL%TYPE;
iPrc_Impuesto       FAT_PRESUPTEMP.PRC_IMPUESTO%TYPE;
--CLAUDIA
vp_tip_foliacion    FA_TIPMOVIMIEN.TIP_FOLIACION%TYPE;
vp_cod_tipdocum     FA_TIPMOVIMIEN.COD_TIPDOCUM%TYPE;
--CLAUDIA
vp_monto_calc       NUMBER(14,4);
vp_procIn           VARCHAR2(250);
vp_tablaIn          VARCHAR2(250);
vp_actIn            VARCHAR2(250);
vp_sqlcodeIn        VARCHAR2(250);
vp_glosaerr         VARCHAR2(250);
vp_errorm           NUMBER(2);
vp_Cargo			CO_INTERFAZ_CAJA.IMPORTE_INTER%TYPE;

CURSOR c_conceptos_PRO IS
SELECT CONCEPTO_PRORRO, MONTO_INTERESES
FROM   CO_DET_SOLICITUD
WHERE  NUM_SOLICITUD = vp_num_movimiento
AND    TIPO_SOLICITUD = '2';
CURSOR c_conceptos_SCPRO IS
SELECT CONCEPTO_PRORRO, MONTO_INTERESES
FROM   CO_DET_SOLICITUD
WHERE  NUM_SOLICITUD = vp_num_movimiento
AND    TIPO_SOLICITUD = '4';
vp_concepto_mora    CO_CONVENIOS.CONCEPTO_MORA%TYPE;
vp_monto_mora       CO_CONVENIOS.IMP_INTERES_MORA%TYPE;
vp_concepto_cobran  CO_CONVENIOS.CONCEPTO_COBRAN%TYPE;
vp_monto_cobran     CO_CONVENIOS.IMP_INTERES_COBRAN%TYPE;
vp_concepto_finan   CO_CONVENIOS.CONCEPTO_FINAN%TYPE;
vp_monto_finan      CO_CONVENIOS.IMP_INTERES_FINAN%TYPE;
vp_concepto_opera   CO_CONVENIOS.CONCEPTO_OPERA%TYPE;
vp_monto_opera      CO_CONVENIOS.IMP_INTERES_OPERA%TYPE;
vp_concepto         CO_CONVENIOS.CONCEPTO_OPERA%TYPE;
vp_monto            CO_CONVENIOS.IMP_INTERES_OPERA%TYPE;
vp_monto_acum       CO_CONVENIOS.IMP_INTERES_OPERA%TYPE;
vp_monto_siniva     CO_CONVENIOS.IMP_INTERES_OPERA%TYPE;
vp_cod_retorno      NUMBER;
vp_des_cadena       VARCHAR2(255);
i                   NUMBER(10);
j                   NUMBER(10);
iDecimal            NUMBER(2);
iCod_conceptoMora   NUMBER(5);
iCod_conceptoCobr   NUMBER(5);
iCod_conceptoFina   NUMBER(5);
iCod_conceptoOpera  NUMBER(5);


ERROR_PROCESO EXCEPTION;
BEGIN
        vp_monto_acum := 0;
                vp_total_siniva := 0;
        vp_error := 1;
        vp_gls_error := 'Select Usuario.';

        vp_gls_error := 'SELECT GE_PAC_GENERAL.PARAM_GENERAL';
        SELECT GE_PAC_GENERAL.PARAM_GENERAL('num_decimal'),GE_PAC_GENERAL.PARAM_GENERAL('FORMATO_SEL2')
        INTO   iDecimal, sFormatoFecha
        FROM   DUAL;

        SELECT user, RTRIM(to_char(SYSDATE, 'dd-mm-yyyy'))
        INTO   usuario, fecha
        FROM   DUAL;

        /* Obtener secuencia de impuestos */
        SELECT FAS_PRESUPTEMP.NEXTVAL
        INTO   iSec_PresupTemp
        FROM   DUAL;

        vp_error := 1;
        vp_gls_error := 'Select Co_interfaz_caja';
        SELECT TIP_MOVIMIENTO, NUM_MOVIMIENTO, COD_CLIENTE, IMPORTE_INTER
        INTO   vp_tip_movimiento, vp_num_movimiento, vp_cod_cliente, vp_Cargo
        FROM   CO_INTERFAZ_CAJA
        WHERE  NUM_INTERFAZ = to_number(vp_num_interfaz);
        IF vp_tip_movimiento != 'SCP' AND vp_tip_movimiento != 'SPR' AND vp_tip_movimiento != 'CDO' AND vp_tip_movimiento != 'CPA' AND vp_tip_movimiento != 'CPC' THEN
           vp_gls_error := 'Error, tipo movimiento no genera Factura Miscelnea (' || vp_tip_movimiento || ').';
           RAISE ERROR_PROCESO;
        END IF;

        vp_error := 1;
        vp_gls_error := 'Select Per_Contable';
        SELECT COD_ESTADO
        INTO   vp_cod_estado
        FROM   FA_PERCONTABLE
        WHERE  COD_PERCONTAB = SUBSTR(fecha, 7, 4) || SUBSTR(fecha, 4, 2);

        vp_error := 2;
        vp_gls_error := 'Select Fa_seq_numpro.';
        SELECT FA_SEQ_NUMPRO.NEXTVAL
        INTO   vp_num_proceso
        FROM DUAL;
        vp_error := 2;

        vp_gls_error := 'Select Fa_seq_miscelanea.';
        SELECT FA_SEQ_MISCELANEA.NEXTVAL
        INTO   vp_seq_miscel
        FROM DUAL;
        vp_error := 1;

        vp_gls_error := 'Select Oficina.';
        SELECT a.COD_OFICINA, nvl(a.COD_VENDEDOR, 0), b.DES_OFICINA, c.NOM_VENDEDOR
        INTO   vp_cod_oficina, vp_cod_vendedor, vp_des_oficina, vp_nom_vendedor
        FROM   GE_SEG_USUARIO a, GE_OFICINAS b, VE_VENDEDORES c
        WHERE  NOM_USUARIO = usuario
        AND    a.COD_OFICINA = b.COD_OFICINA
        AND    a.COD_VENDEDOR = c.COD_VENDEDOR(+);

        IF vp_cod_vendedor = 0 THEN
           vp_cod_vendedor := 100001;
        END IF;

        vp_error := 1;
        vp_gls_error := 'Select Fa_datosgener.';
        SELECT COD_MISCELA, COD_MONEFACT
        INTO   vp_documento, vp_moneda
        FROM   FA_DATOSGENER;

        vp_error := 1;
        vp_gls_error := 'Select Al_docum_sucursal.';
        SELECT COD_CENTREMI
        INTO   vp_cod_centremi
        FROM   AL_DOCUM_SUCURSAL
        WHERE  COD_OFICINA = vp_cod_oficina
        AND    COD_TIPDOCUM = vp_documento;

        vp_error := 1;
        vp_gls_error := 'Select Ge_catimpclientes.';
        SELECT COD_CATIMPOS
        INTO   vp_cod_catimpos
        FROM   GE_CATIMPCLIENTES
        WHERE  COD_CLIENTE = vp_cod_cliente
        AND    SYSDATE BETWEEN FEC_DESDE AND FEC_HASTA;

        vp_error := 1;
        vp_gls_error := 'Select Ge_letras.';
        SELECT LETRA
        INTO   vp_letra
        FROM   GE_LETRAS
        WHERE  COD_TIPDOCUM = vp_documento
        AND    COD_CATIMPOS = vp_cod_catimpos;

        vp_error := 1;
        vp_gls_error := 'Select Ge_direcciones.';
        SELECT a.COD_REGION, a.COD_PROVINCIA, b.COD_CIUDAD, a.COD_COMUNA
        INTO   vp_cod_region, vp_cod_provincia, vp_cod_ciudad, vp_cod_comuna
        FROM   GE_OFICINAS a, GE_DIRECCIONES b
        WHERE  a.COD_OFICINA = vp_cod_oficina
        AND    a.COD_DIRECCION = b.COD_DIRECCION;

        vp_error := 1;
        vp_gls_error := 'Select Ga_cliente_pcom.';
        SELECT COD_PLANCOM
        INTO   vp_cod_plancom
        FROM   GA_CLIENTE_PCOM
        WHERE  COD_CLIENTE = vp_cod_cliente
        AND    SYSDATE BETWEEN FEC_DESDE AND NVL(FEC_HASTA,SYSDATE+1);


        IF vp_tip_movimiento = 'CDO' or vp_tip_movimiento = 'CPA' THEN

        	vp_gls_error := 'SELECT CONCEPTO_MORA';
        	SELECT VAL_PARAMETRO
            INTO  iCod_conceptoMora
            FROM  GED_PARAMETROS
            WHERE COD_MODULO='RE'
            AND NOM_PARAMETRO ='CONCEPTO_MORA';

    		vp_gls_error := 'SELECT CONCEPTO_COBRANZA';
            SELECT VAL_PARAMETRO
            INTO  iCod_conceptoCobr
            FROM  GED_PARAMETROS
            WHERE COD_MODULO='RE'
            AND NOM_PARAMETRO ='CONCEPTO_COBRANZA';

            vp_gls_error := 'SELECT CONCEPTO_FINANCIERO';
            SELECT VAL_PARAMETRO
            INTO  iCod_conceptoFina
            FROM  GED_PARAMETROS
            WHERE COD_MODULO='RE'
            AND NOM_PARAMETRO ='CONCEPTO_FINANCIERO';

            vp_gls_error := 'SELECT CONCEPTO_OPERACIONAL';
            SELECT VAL_PARAMETRO
            INTO  iCod_conceptoOpera
            FROM  GED_PARAMETROS
            WHERE COD_MODULO='RE'
            AND NOM_PARAMETRO ='CONCEPTO_OPERACIONAL';

	        /* Obtiene Cod_concepto */
	        SELECT COD_CONCEPTO  , COD_TIPCONCE
	        INTO   iCod_concepto , iTipConce
	        FROM   FA_CONCEPTOS
	        WHERE  COD_CONCEPTO = iCod_conceptoCobr; --5876

            vp_error := 1;
            vp_gls_error := 'Select en Co_convenio.';
                SELECT nvl(CONCEPTO_MORA,0), nvl(IMP_INTERES_MORA,0),
                   nvl(CONCEPTO_COBRAN,0), nvl(IMP_INTERES_COBRAN,0),
                   nvl(CONCEPTO_FINAN, 0), nvl(IMP_INTERES_FINAN,0),
                   nvl(CONCEPTO_OPERA, 0), nvl(IMP_INTERES_OPERA,0)
            INTO   vp_concepto_mora, vp_monto_mora,
                   vp_concepto_cobran, vp_monto_cobran,
                   vp_concepto_finan, vp_monto_finan,
                   vp_concepto_opera, vp_monto_opera
            FROM   CO_CONVENIOS
            WHERE  NUM_CONVENIO = vp_num_movimiento;

                        iSumaImp := vp_monto_mora + vp_monto_cobran + vp_monto_finan + vp_monto_opera;
            IF vp_monto_mora = 0 and vp_monto_cobran = 0 and vp_monto_finan = 0 and vp_monto_opera = 0 THEN
                   --ROLLBACK; SOPORTE
                   vp_error := 0;
                   vp_gls_error := 'No hay monto para genera Factura Miscelnea (CONV.).';
                   RAISE ERROR_PROCESO;
            END IF;

            /* Rescatando el valor sin iva */
            j := 1;
            FOR i IN 1 .. 4 LOOP
                    IF i = 1 THEN
                        vp_monto_calc:=vp_monto_mora;
                                                iCod_concepto:= iCod_conceptoMora;
                    END IF;
                    IF i = 2 THEN
                        vp_monto_calc:=vp_monto_cobran;
                                                iCod_concepto:= iCod_conceptoCobr;
                    END IF;
                    IF i = 3 THEN
                        vp_monto_calc:=vp_monto_finan;
                                                iCod_concepto:=iCod_conceptoFina;
                    END IF;
                    IF i = 4 THEN
                        vp_monto_calc:=vp_monto_opera;
                                                iCod_concepto:= iCod_conceptoOpera;
                    END IF;

                    IF vp_monto_calc > 0 THEN
                        /* inserta en Fat_presupimp */
                        INSERT INTO FAT_PRESUPTEMP
                               (NUM_PROCESO     , COD_CONCEPTO  , COLUMNA        , COD_CLIENTE   ,
                                FEC_EFECTIVIDAD , IMP_CONCEPTO  , IMP_FACTURABLE , COD_TIPCONCE  )
                        VALUES (iSec_PresupTemp , iCod_concepto , 1              , vp_cod_cliente,
               			   --SOPORTE  SYSDATE         , GE_PAC_GENERAL.REDONDEA(vp_monto_calc, iDecimal, 0),
                                SYSDATE         , GE_PAC_GENERAL.REDONDEA(vp_monto_calc, 4, 0),
								GE_PAC_GENERAL.REDONDEA(vp_monto_calc , 4, 0) , iTipConce );

                        /* Llamada a Pl FA_PROC_IMPTOS */
                        BEGIN
                            FA_PROC_IMPTOS (iSec_PresupTemp, vp_cod_catimpos, vp_cod_oficina, vp_procIn, vp_tablaIn, vp_actIn, vp_sqlcodeIn, vp_glosaerr, vp_errorm );
                        END;

                        IF vp_errorm != 0 THEN
                            vp_error:= vp_errorm;
                            vp_gls_error:= vp_glosaerr;
                            vp_monto := 0;

                        ELSE

                            SELECT  COD_CONCEREL  ,vp_monto_calc/(1+(SUM(PRC_IMPUESTO)/100))
                            INTO    iCod_Concerel , dMonto_Impos
                            FROM    FAT_PRESUPTEMP
                            WHERE   NUM_PROCESO  = iSec_PresupTemp
                                                        AND     COD_CONCEREL = iCod_concepto
                            AND     COD_TIPCONCE = '1'
                            GROUP BY COD_CONCEREL;

                        END IF;
                        IF i = 1 THEN
                            vp_monto_mora:=dMonto_Impos;
                        END IF;
                        IF i = 2 THEN
                            vp_monto_cobran:=dMonto_Impos;
                        END IF;
                        IF i = 3 THEN
                            vp_monto_finan:=dMonto_Impos;
                        END IF;
                        IF i = 4 THEN
                            vp_monto_opera:=dMonto_Impos;
                        END IF;
                    END IF;

            END LOOP;

            j := 1;
            FOR i IN 1 .. 4 LOOP
                    IF i = 1 THEN
                       vp_concepto := vp_concepto_mora;
                       vp_monto_siniva := vp_monto_mora;
                       vp_monto := vp_monto_mora;
                    END IF;
                    IF i = 2 THEN
                       vp_concepto := vp_concepto_cobran;
                       vp_monto_siniva := vp_monto_cobran;
                       vp_monto := vp_monto_cobran;
                    END IF;
                    IF i = 3 THEN
                      vp_concepto := vp_concepto_finan;
                      vp_monto_siniva := vp_monto_finan;
                      vp_monto := vp_monto_finan;
                    END IF;
                    IF i = 4 THEN
                       vp_concepto := vp_concepto_opera;
                       vp_monto_siniva := vp_monto_opera;
                       vp_monto := vp_monto_opera;
                    END IF;
                    IF vp_concepto != 0 and vp_monto > 0 THEN
                       vp_monto_acum := vp_monto_acum + vp_monto;
                                           vp_total_siniva := vp_total_siniva + vp_monto_siniva;
                       vp_error := 3;
                       vp_gls_error := 'Insert en Fa_prefactura.';

                       INSERT INTO FA_PREFACTURA
                              (NUM_PROCESO, COD_CLIENTE, COD_CONCEPTO,
                              COLUMNA, COD_PRODUCTO, COD_MONEDA,
                              FEC_VALOR, FEC_EFECTIVIDAD, IMP_CONCEPTO,
                              IMP_FACTURABLE, IMP_MONTOBASE, COD_REGION,
                              COD_PROVINCIA, COD_CIUDAD, COD_MODULO,
                              COD_PLANCOM, IND_FACTUR, COD_CATIMPOS,
                              COD_PORTADOR, IND_ESTADO, COD_TIPCONCE,
                              NUM_UNIDADES, COD_CICLFACT, COD_CONCEREL,
                              COLUMNA_REL, NUM_ABONADO, NUM_TERMINAL,
                              CAP_CODE, NUM_SERIEMEC, NUM_SERIELE,
                              FLAG_IMPUES, FLAG_DTO, PRC_IMPUESTO,
                              VAL_DTO,TIP_DTO, NUM_VENTA,
                              NUM_TRANSACCION, MES_GARANTIA, NUM_GUIA,
                              IND_ALTA, IND_SUPERTEL,NUM_PAQUETE,
                              IND_CUOTA, NUM_CUOTAS, ORD_CUOTA,
                              IND_MODVENTA)
                       VALUES (vp_num_proceso, vp_cod_cliente, vp_concepto,
                               j, 5, '001',
                               SYSDATE, SYSDATE,
							   -- SOPOERTE 14-05-2003 GE_PAC_GENERAL.REDONDEA(vp_monto_siniva, iDecimal, 0),
                               GE_PAC_GENERAL.REDONDEA(vp_monto_siniva, 4, 0),
                               GE_PAC_GENERAL.REDONDEA(vp_monto_siniva, 4, 0),
                               0, vp_cod_region,
                               vp_cod_provincia, vp_cod_ciudad, 'CO',
                               vp_cod_plancom, 1, vp_cod_catimpos,
                               0, 0, 3, 1, NULL, NULL,
                               NULL, NULL, NULL, NULL, NULL, '0',
                               0, 0, NULL, NULL, NULL, NULL, NULL,
                               NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
                        j := j + 1;
                    END IF;
            END LOOP;
        END IF;

        IF vp_tip_movimiento = 'SPR' THEN

            vp_error := 1;
            vp_gls_error := 'Select en Co_det_solicitud.';
            j := 1;
            FOR rReg IN c_conceptos_PRO LOOP
                vp_concepto := rReg.CONCEPTO_PRORRO;
                vp_monto    := rReg.MONTO_INTERESES;
                vp_monto_acum := vp_monto_acum + vp_monto;
                                vp_total_siniva := vp_total_siniva + vp_monto_acum;
                IF vp_concepto = 0 and vp_monto = 0 THEN
                   --ROLLBACK; SOPORTE
                   vp_error := 0;
                   vp_gls_error := 'No hay monto para genera Factura Miscelnea (PRORR).';
                   RAISE ERROR_PROCESO;
                END IF;

                vp_error := 3;
                vp_gls_error := 'Insert en Fa_prefactura.';
                INSERT INTO FA_PREFACTURA
                       (NUM_PROCESO, COD_CLIENTE, COD_CONCEPTO,
                        COLUMNA, COD_PRODUCTO, COD_MONEDA,
                        FEC_VALOR, FEC_EFECTIVIDAD, IMP_CONCEPTO,
                        IMP_FACTURABLE, IMP_MONTOBASE, COD_REGION,
                        COD_PROVINCIA, COD_CIUDAD, COD_MODULO,
                        COD_PLANCOM, IND_FACTUR, COD_CATIMPOS,
                        COD_PORTADOR, IND_ESTADO, COD_TIPCONCE,
                        NUM_UNIDADES, COD_CICLFACT, COD_CONCEREL,
                        COLUMNA_REL, NUM_ABONADO, NUM_TERMINAL,
                        CAP_CODE, NUM_SERIEMEC, NUM_SERIELE,
                        FLAG_IMPUES, FLAG_DTO, PRC_IMPUESTO,
                        VAL_DTO, TIP_DTO, NUM_VENTA,
                        NUM_TRANSACCION, MES_GARANTIA, NUM_GUIA,
                        IND_ALTA, IND_SUPERTEL, NUM_PAQUETE,
                        IND_CUOTA, NUM_CUOTAS, ORD_CUOTA,
                        IND_MODVENTA)
                VALUES  (vp_num_proceso, vp_cod_cliente, vp_concepto,
                         j, 5, '001', SYSDATE, SYSDATE,
						 -- SOPORTE 14-05-2003 GE_PAC_GENERAL.REDONDEA(vp_monto, iDecimal, 0),
                         GE_PAC_GENERAL.REDONDEA(vp_monto, 4, 0),
                         GE_PAC_GENERAL.REDONDEA(vp_monto, 4, 0),
                         0, vp_cod_region, vp_cod_provincia, vp_cod_ciudad,
                         'CO', vp_cod_plancom, 1, vp_cod_catimpos, 0,
                         0, 3, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
                         '0', 0, 0, NULL, NULL, NULL, NULL,
                         NULL,NULL,NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);

                j := j + 1;
            END LOOP;
        END IF;
        IF vp_tip_movimiento = 'SCP' THEN
                vp_error := 1;
                vp_gls_error := 'Select en Co_det_solicitud.';
                j := 1;
                FOR rReg IN c_conceptos_SCPRO LOOP
                    vp_concepto := rReg.CONCEPTO_PRORRO;
                    vp_monto    := rReg.MONTO_INTERESES;
                    vp_monto_acum := vp_monto_acum + vp_monto;
                                        vp_total_siniva := vp_total_siniva + vp_monto_acum;
                        IF vp_concepto = 0 and vp_monto = 0 THEN
                           --ROLLBACK; SOPORTE
                           vp_error := 0;
                           vp_gls_error := 'No hay monto para genera Factura Miscelnea (PRORR).';
                           RAISE ERROR_PROCESO;
                        END IF;
                        vp_error := 3;
                        vp_gls_error := 'Insert en Fa_prefactura.';
                        INSERT INTO FA_PREFACTURA
                               (NUM_PROCESO, COD_CLIENTE, COD_CONCEPTO,
                                COLUMNA, COD_PRODUCTO, COD_MONEDA,
                                FEC_VALOR, FEC_EFECTIVIDAD, IMP_CONCEPTO,
                                IMP_FACTURABLE, IMP_MONTOBASE, COD_REGION,
                                COD_PROVINCIA, COD_CIUDAD, COD_MODULO,
                                COD_PLANCOM, IND_FACTUR, COD_CATIMPOS,
                                COD_PORTADOR, IND_ESTADO, COD_TIPCONCE,
                                NUM_UNIDADES, COD_CICLFACT, COD_CONCEREL,
                                COLUMNA_REL, NUM_ABONADO, NUM_TERMINAL,
                                CAP_CODE, NUM_SERIEMEC, NUM_SERIELE,
                                FLAG_IMPUES, FLAG_DTO, PRC_IMPUESTO,
                                VAL_DTO, TIP_DTO, NUM_VENTA,
                                NUM_TRANSACCION, MES_GARANTIA, NUM_GUIA,
                                IND_ALTA, IND_SUPERTEL, NUM_PAQUETE,
                                IND_CUOTA, NUM_CUOTAS, ORD_CUOTA,
                                IND_MODVENTA)
                        VALUES (vp_num_proceso, vp_cod_cliente, vp_concepto, j, 5,
                                '001', SYSDATE, SYSDATE,
                                -- SOPORTE 150-05-2003 GE_PAC_GENERAL.REDONDEA(vp_monto, iDecimal, 0),
								GE_PAC_GENERAL.REDONDEA(vp_monto, 4, 0),
                                GE_PAC_GENERAL.REDONDEA(vp_monto, 4, 0),
                                0,vp_cod_region, vp_cod_provincia, vp_cod_ciudad,
                                'CO', vp_cod_plancom, 1, vp_cod_catimpos, 0,
                                0, 3, 1, NULL, NULL, NULL, NULL, NULL, NULL,
                                NULL, '0',  0, 0, NULL, NULL, NULL, NULL,
                                NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);

                         j := j + 1;
                END LOOP;
        END IF;

        IF vp_tip_movimiento = 'CPC' THEN
                    vp_concepto 	 := vp_concepto_fact;
					vp_monto_calc 	 := vp_Cargo;
					iSumaImp		 := vp_Cargo;
			        /* Obtiene Cod_concepto */
			        SELECT COD_TIPCONCE
			        INTO   iTipConce
			        FROM   FA_CONCEPTOS
			        WHERE  COD_CONCEPTO = vp_concepto;
					--Calcula Neto del Cargo
                    IF vp_monto_calc > 0 THEN
                        /* inserta en Fat_presupimp */
                        INSERT INTO FAT_PRESUPTEMP
                               (NUM_PROCESO     , COD_CONCEPTO  , COLUMNA        , COD_CLIENTE   ,
                                FEC_EFECTIVIDAD , IMP_CONCEPTO  , IMP_FACTURABLE , COD_TIPCONCE  )
                        VALUES (iSec_PresupTemp , vp_concepto 	, 1              , vp_cod_cliente,
                                SYSDATE         , GE_PAC_GENERAL.REDONDEA(vp_monto_calc, 4, 0),
								GE_PAC_GENERAL.REDONDEA(vp_monto_calc , 4, 0) , iTipConce );

                        /* Llamada a Pl FA_PROC_IMPTOS */
                        BEGIN
                            FA_PROC_IMPTOS (iSec_PresupTemp, vp_cod_catimpos, vp_cod_oficina, vp_procIn, vp_tablaIn, vp_actIn, vp_sqlcodeIn, vp_glosaerr, vp_errorm );
                        END;

                        IF vp_errorm != 0 THEN
                            vp_error:= vp_errorm;
                            vp_gls_error:= vp_glosaerr;
                            vp_monto := 0;

                        ELSE

                            SELECT  COD_CONCEREL  ,vp_monto_calc/(1+(SUM(PRC_IMPUESTO)/100))
                            INTO    iCod_Concerel , dMonto_Impos
                            FROM    FAT_PRESUPTEMP
                            WHERE   NUM_PROCESO  = iSec_PresupTemp
                            AND     COD_CONCEREL = vp_concepto
                            AND     COD_TIPCONCE = '1'
                            GROUP BY COD_CONCEREL;

                        END IF;
					END IF;

                    vp_monto    := dMonto_Impos;
                    vp_total_siniva := vp_total_siniva + vp_monto;
                        IF vp_concepto = 0 and vp_monto = 0 THEN
                           vp_error := 0;
                           vp_gls_error := 'No hay monto para generar Factura Miscelnea (CPC).';
                           RAISE ERROR_PROCESO;
                        END IF;
                        vp_error := 3;
                        vp_gls_error := 'Insert en Fa_prefactura.';
                        INSERT INTO FA_PREFACTURA
                               (NUM_PROCESO, COD_CLIENTE, COD_CONCEPTO,
                                COLUMNA, COD_PRODUCTO, COD_MONEDA,
                                FEC_VALOR, FEC_EFECTIVIDAD, IMP_CONCEPTO,
                                IMP_FACTURABLE, IMP_MONTOBASE, COD_REGION,
                                COD_PROVINCIA, COD_CIUDAD, COD_MODULO,
                                COD_PLANCOM, IND_FACTUR, COD_CATIMPOS,
                                COD_PORTADOR, IND_ESTADO, COD_TIPCONCE,
                                NUM_UNIDADES, COD_CICLFACT, COD_CONCEREL,
                                COLUMNA_REL, NUM_ABONADO, NUM_TERMINAL,
                                CAP_CODE, NUM_SERIEMEC, NUM_SERIELE,
                                FLAG_IMPUES, FLAG_DTO, PRC_IMPUESTO,
                                VAL_DTO, TIP_DTO, NUM_VENTA,
                                NUM_TRANSACCION, MES_GARANTIA, NUM_GUIA,
                                IND_ALTA, IND_SUPERTEL, NUM_PAQUETE,
                                IND_CUOTA, NUM_CUOTAS, ORD_CUOTA,
                                IND_MODVENTA)
                        VALUES (vp_num_proceso, vp_cod_cliente, vp_concepto, 1, 5,
                                '001', SYSDATE, SYSDATE,
								GE_PAC_GENERAL.REDONDEA(vp_monto, 4, 0),
                                GE_PAC_GENERAL.REDONDEA(vp_monto, 4, 0),
                                0,vp_cod_region, vp_cod_provincia, vp_cod_ciudad,
                                'CO', vp_cod_plancom, 1, vp_cod_catimpos, 0,
                                0, 3, 1, NULL, NULL, NULL, NULL, NULL, NULL,
                                NULL, '0',  0, 0, NULL, NULL, NULL, NULL,
                                NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);

        END IF;

        vp_error := 4;
        vp_gls_error := 'Update Ge_secuenciasemi.';
        UPDATE  GE_SECUENCIASEMI SET
                NUM_SECUENCI = vp_seq_miscel + 1
        WHERE   COD_TIPDOCUM = vp_documento
        AND     COD_CENTREMI = vp_cod_centremi
        AND     LETRA = vp_letra;

        --SOPORTE SE CAMBIO DE POSICION
        vp_error := 1;
        vp_gls_error := 'Insert en Fa_procesos.';
        INSERT INTO FA_PROCESOS
               (NUM_PROCESO, COD_TIPDOCUM, COD_VENDEDOR_AGENTE, COD_CENTREMI,
                FEC_EFECTIVIDAD, NOM_USUARORA, LETRAAG, NUM_SECUAG, COD_TIPDOCNOT,
                COD_VENDEDOR_AGENTENOT, LETRANOT, COD_CENTRNOT, NUM_SECUNOT,
                IND_ESTADO, COD_CICLFACT)
        VALUES (vp_num_proceso, vp_documento, vp_cod_vendedor, vp_cod_centremi,
                to_date(fecha, 'dd-mm-yyyy'), usuario, vp_letra, vp_seq_miscel, NULL,
                NULL, NULL, NULL, NULL, 0, NULL);
        --SOPORTE

        IF vp_tip_movimiento = 'CDO' or vp_tip_movimiento = 'CPA' THEN
                   vp_error := 4;
           vp_gls_error := 'Update Co_interfaz_caja.';
--                 vp_total_siniva := (vp_total_siniva * 1.18);
           UPDATE  CO_INTERFAZ_CAJA SET
                   IND_PASOCOB   = 0,
                   NUM_PROCESO   = vp_num_proceso,
                   --IMPORTE_INTER = GE_PAC_GENERAL.REDONDEA(vp_total_siniva, iDecimal, 0)
                                   IMPORTE_INTER = GE_PAC_GENERAL.REDONDEA(iSumaImp, iDecimal, 0)
           WHERE   NUM_INTERFAZ = to_number(vp_num_interfaz);
                END IF;

                IF vp_tip_movimiento = 'SPR' or vp_tip_movimiento = 'SCP' THEN
                   vp_error := 4;
           vp_gls_error := 'Update Co_interfaz_caja.';
           UPDATE  CO_INTERFAZ_CAJA SET
                   IND_PASOCOB   = 0,
                   NUM_PROCESO   = vp_num_proceso,
                   IMPORTE_INTER = GE_PAC_GENERAL.REDONDEA(vp_monto_acum, iDecimal, 0)
           WHERE   NUM_INTERFAZ = to_number(vp_num_interfaz);
                END IF;

           IF vp_tip_movimiento = 'CPC' THEN
                   vp_error := 4;
           		   vp_gls_error := 'Update Co_interfaz_caja.';
           UPDATE  CO_INTERFAZ_CAJA SET
                   IND_PASOCOB   = 0,
                   NUM_PROCESO = vp_num_proceso,
                   IMPORTE_INTER = GE_PAC_GENERAL.REDONDEA(iSumaImp, iDecimal, 0)
           WHERE   NUM_INTERFAZ = to_number(vp_num_interfaz);
           END IF;

                vp_error := 1;
        vp_gls_error := 'Select Ga_catributclie.';
        SELECT COD_CATRIBUT
        INTO   vp_cod_catribut
        FROM   GA_CATRIBUTCLIE
        WHERE  COD_CLIENTE = vp_cod_cliente
        AND    FEC_DESDE <= SYSDATE
        AND    FEC_HASTA >= SYSDATE;

--CLAUDIA
                vp_error := 1;
        vp_gls_error := 'Select Fa_tipmovimien.';
                SELECT COD_TIPDOCUM, TIP_FOLIACION
                INTO   vp_cod_tipdocum,vp_tip_foliacion
            FROM FA_TIPMOVIMIEN
                WHERE COD_TIPMOVIMIEN= 18
                AND COD_CATRIBUT='F'
                AND COD_MODVENTA=1
                AND COD_TIPIMPOSITIVA=1;
--CLAUDIA

        vp_error := 1;
        vp_gls_error := 'Select Fa_gencentremi.';
        SELECT COD_MODGENER
        INTO   vp_cod_modgener
        FROM   FA_GENCENTREMI
        WHERE  COD_CENTREMI = vp_cod_centremi
        AND    COD_TIPMOVIMIEN = vp_documento
        AND    COD_CATRIBUT = vp_cod_catribut
        AND    COD_MODVENTA = 1;

		--Deja Fecha en formato utilizado por la Operadora
        vp_error := 1;
        vp_gls_error := 'Select TO_CHAR(TO_DATE(fecha,"dd-mm-yyyy"),sFormatoFecha)';
		SELECT TO_CHAR(TO_DATE(fecha,'dd-mm-yyyy'),sFormatoFecha)
		INTO fecha
		FROM DUAL;

        vp_entrada := '0';
        vp_error := 5;
        vp_gls_error := 'Invocacin FA_INS_INTERFACT.';
                IF  vp_total_siniva > 0 THEN
              FA_INS_INTERFACT( secuencia_ga, vp_num_proceso, 0,
                               vp_cod_modgener, '18', vp_cod_catribut, '',
                              '100', '3', fecha, vp_entrada, '1', '0','',vp_tip_foliacion,vp_cod_tipdocum);
        END IF;
                vp_error := 1;
        vp_gls_error := 'Select Ga_transacabo.';
        SELECT COD_RETORNO, DES_CADENA
        INTO   vp_cod_retorno, vp_des_cadena
        FROM   GA_TRANSACABO
        WHERE  NUM_TRANSACCION = to_number(secuencia_ga);
        IF vp_cod_retorno != 0 THEN
            vp_error := 9;
            RAISE ERROR_PROCESO;
        ELSE
            vp_error := 6;
            vp_gls_error := 'Delete Ga_transacabo.';
            DELETE FROM GA_TRANSACABO
            WHERE  NUM_TRANSACCION = to_number(secuencia_ga);
        END IF;
        vp_error := 0;
        vp_gls_error := 'Proceso O.K.';
        RAISE ERROR_PROCESO;

   EXCEPTION
      WHEN ERROR_PROCESO THEN
           vp_gls_error:=sqlerrm;
                   if vp_error != 0 then
                ROLLBACK;
           end if;
           INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
           VALUES (TO_NUMBER(secuencia_ga), vp_error, vp_gls_error);
      WHEN DUP_VAL_ON_INDEX THEN
           ROLLBACK;
           --vp_gls_error:=sqlerrm;
           INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
           VALUES (TO_NUMBER(secuencia_ga), 1, 'Duplicado - ' || vp_gls_error);
      WHEN NO_DATA_FOUND THEN
           --ROLLBACK; SOPORTE
           INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
           VALUES (TO_NUMBER(secuencia_ga), 1, 'No Datos - ' || vp_gls_error);
      WHEN OTHERS THEN
           ROLLBACK;
                   --vp_gls_error:=sqlerrm;
           INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
           VALUES (TO_NUMBER(secuencia_ga), 1, 'Otros Errores - ' || vp_gls_error);
END CO_EMI_MISCELANEA;
/
SHOW ERRORS
