CREATE OR REPLACE PROCEDURE Co_P_Aplica_Convenio
(vp_secuencia_co     IN VARCHAR2
,vp_num_interfaz     IN VARCHAR2
,vp_cod_oficina      IN VARCHAR2
,vp_cod_caja         IN VARCHAR2
,vp_caja_centremi    IN VARCHAR2
,vp_num_compago      IN NUMBER
,VP_NUM_FOLIOCOMP    IN VARCHAR2
,vp_numsec_pago      IN NUMBER
,vFecPago            IN VARCHAR2
)
IS

vp_ruteo                NUMBER(2);
vp_gls_error            VARCHAR2(255);
vp_FechaConvenio        VARCHAR2(10);
i                       NUMBER(10);
j                       NUMBER(10);
k                       NUMBER(10);
vp_existe               NUMBER(12);
usuario                 VARCHAR2(30);
fecha                   VARCHAR(10);
iDecimal                NUMBER(2);
vp_num_Solicitud        CO_INTERFAZ_CAJA.NUM_MOVIMIENTO%TYPE;
vp_tipo_convenio        CO_CONVENIOS.TIPO_CONVENIO%TYPE;
vp_NumPagare            CO_CONVENIOS.NUM_PAGARE%TYPE;
vp_NumIdent             CO_CONVENIOS.NUM_IDENT%TYPE;
vp_ClienteAsoc          CO_CONVENIOS.CLIENTE_ASOCIADO%TYPE;
vp_CodBanco             CO_CONVENIOS.COD_BANCO%TYPE;
vp_ImporteConv          CO_CONVENIOS.IMPORTE_CONVENIO%TYPE;
--SOPORTE
vp_ImporteCtdo                  CO_CONVENIOS.IMPORTE_CTDO%TYPE;
vp_ImporteMora                  CO_CONVENIOS.IMP_INTERES_MORA%TYPE;
vp_ImporteCobr                  CO_CONVENIOS.IMP_INTERES_COBRAN%TYPE;
vp_ImporteFinan                 CO_CONVENIOS.IMP_INTERES_FINAN%TYPE;
vp_ImporteOpera                 CO_CONVENIOS.IMP_INTERES_OPERA%TYPE;
--
vp_InteresFinan         CO_CONVENIOS.IMP_INTERES_FINAN%TYPE;
vp_docum_carga          CO_PAGOSCONC.COD_TIPDOCUM%TYPE;
vp_secuencia_pago       CO_PAGOSCONC.NUM_SECUENCI%TYPE;
vp_secuencia_pago_aux   CO_PAGOSCONC.NUM_SECUENCI%TYPE;
vp_secuencia_cargos     GE_CARGOS.NUM_CARGO%TYPE;
vp_secuencia_cheque     CO_DOCUMENTOS.NUM_SECUENCI%TYPE;
vp_secuencia_coo        CO_TRANSACINT.NUM_TRANSACCION%TYPE;
ssecuenciapago          CO_PAGOSCONC.NUM_SECUENCI%TYPE;
sclientecheque          CO_DET_CONVENIO.COD_CLIENTE%TYPE;
vp_tot_deuda            CO_DET_CONVENIO.IMPORTE_CA%TYPE;
vp_caja_agente_interno  CO_DATGEN.AGENTE_INTERNO%TYPE;
vp_caja_letra           CO_DATGEN.LETRA_COBROS%TYPE;
vp_doc_pago             CO_DATGEN.DOC_PAGO%TYPE;
vp_ori_caja             CO_DATGEN.ORI_CAJA%TYPE;
vp_cau_caja             CO_DATGEN.CAU_CAJA%TYPE;
vp_ProdGeneral          GE_DATOSGENER.PROD_GENERAL%TYPE;
vp_Num_Movimiento       CO_INTERFAZ_CAJA.NUM_MOVIMIENTO%TYPE;
vp_esta                 NUMBER(1);
vp_primero              NUMBER(5);
vp_ultimo               NUMBER(5);
iSecuenciaDet           NUMBER(10);
Monto_Acum              NUMBER(25,10);
vp_total_miscelanea     NUMBER(14,4);
iProcesa                NUMBER(10);
vp_columna              CO_SECARTERA.COLUMNA%TYPE;
vp_abonado              VARCHAR2(5);
vp_concepto             VARCHAR2(5);
vp_moneda               VARCHAR2(5);
vp_producto             VARCHAR2(5);
vp_factor_int           CO_INTERESES.FACTOR_INT%TYPE;
vp_factor_dia           CO_INTERESES.FACTOR_DIA%TYPE;
vp_ind_fec_cobro        CO_INTERESES.IND_FEC_COBRO%TYPE;
vp_dias_aplicacion      CO_INTERESES.DIAS_APLICACION%TYPE;
vp_ejecuta_in           NUMBER(1);
vp_cod_centremi         CO_CARTERA.COD_CENTREMI%TYPE;
vp_dias_f               NUMBER(10);
vp_dias_v               NUMBER(10);
vp_mto_intereses        NUMBER(14,4);
vp_cod_ciclfact         GE_CARGOS.COD_CICLFACT%TYPE;
vp_ind_facturado        CO_CARTERA.IND_FACTURADO%TYPE;
vp_secumov              CO_CAJAS.NUM_SECUMOV%TYPE;
AUX_NUM_FOLIO           CO_CARTERA.NUM_FOLIO%TYPE;
AUX_PREF_PLAZA          CO_CARTERA.PREF_PLAZA%TYPE;
AUX_TOT_CUOTA           CO_CUOTA_CONVENIO.NUM_CUOTA%TYPE;
Prox_Cliente            CO_DET_CONVENIO.COD_CLIENTE%TYPE;
sProcedimiento          VARCHAR2(40)   :='';
v_Script                VARCHAR2(2000) := '';
sCodCliente             VARCHAR2(20);
sNumFolio               CO_CARTERA.NUM_FOLIO%TYPE;
sPref_Plaza             CO_CARTERA.PREF_PLAZA%TYPE;
sNumSecuenci            VARCHAR2(20);
sCodTipDocum            VARCHAR2(20);
iImporte                NUMBER(14,4);
sSecCouta               VARCHAR2(20);
sCod_OperadorAbono      CO_CARTERA.COD_OPERADORA_SCL%TYPE;
sCod_PlazaAbono         CO_CARTERA.COD_PLAZA%TYPE;
vRetorno1               NUMBER(10);
vRetorno2               VARCHAR2(11);
vRetorno3               VARCHAR2(255);
vRetorno4               NUMBER(10);

m                       BINARY_INTEGER := 0;
/*************************************************************************
        INI MODIFICACION THALES-IS UC AGOSTO 2004
*************************************************************************/
sw_copagos              VARCHAR(1);
/*************************************************************************
        FIN MODIFICACION THALES-IS UC AGOSTO 2004
*************************************************************************/

TYPE TipRegCheques IS RECORD
(
        NUM_PAGARE              CO_CUOTA_CONVENIO.NUM_PAGARE%TYPE,
        NUM_CUOTA               CO_CUOTA_CONVENIO.NUM_CUOTA%TYPE,
        FECHA_VENCTO            CO_CUOTA_CONVENIO.FECHA_VENCTO%TYPE,
        IMPORTE                 CO_CUOTA_CONVENIO.IMPORTE%TYPE,
        NUM_IDENT_CTACTE        CO_CUOTA_CONVENIO.NUM_IDENT_CTACTE%TYPE,
        IND_TITULAR             CO_CUOTA_CONVENIO.IND_TITULAR%TYPE,
        COD_BANCO               CO_CUOTA_CONVENIO.COD_BANCO%TYPE,
        NUM_CTACTE              CO_CUOTA_CONVENIO.NUM_CTACTE%TYPE,
        COD_SUCURSAL            CO_CUOTA_CONVENIO.COD_SUCURSAL%TYPE,
        COD_PLAZA               CO_CUOTA_CONVENIO.COD_PLAZA%TYPE,
        NUM_CHEQUE              CO_CUOTA_CONVENIO.NUM_CHEQUE%TYPE,
        COD_AUTORIZACION        CO_CUOTA_CONVENIO.COD_AUTORIZACION%TYPE,
        IMPORTE_REAL            CO_CUOTA_CONVENIO.IMPORTE%TYPE,
        SECUENCIA               CO_CARTERA.NUM_SECUENCI%TYPE  --PARA GUARDAR LA SECUENCIA DEL CHEQUE 30-01-2003
                );
TYPE TipTab_Cheques IS TABLE OF TipRegCheques INDEX BY
BINARY_INTEGER;
Registro_Cheques        TipTab_Cheques;

TYPE TipRegClientes IS RECORD
(
        COD_CLIENTE             CO_DET_CONVENIO.COD_CLIENTE%TYPE,
        SECUENCIA_PAGO          CO_CARTERA.NUM_SECUENCI%TYPE,
        EXENTO                  NUMBER(1)
);
TYPE TipTab_Clientes IS TABLE OF TipRegClientes INDEX BY
BINARY_INTEGER;
Registro_Clientes       TipTab_Clientes;

TYPE TipRegFacturas IS RECORD
(
        NUM_SECUENCI_CA         CO_DET_CONVENIO.NUM_SECUENCI_CA%TYPE,
        COD_TIPDOCUM_CA         CO_DET_CONVENIO.COD_TIPDOCUM_CA%TYPE,
        COD_VEND_AGENTE_CA      CO_DET_CONVENIO.COD_VEND_AGENTE_CA%TYPE,
        LETRA_CA                CO_DET_CONVENIO.LETRA_CA%TYPE,
        COD_CLIENTE             CO_DET_CONVENIO.COD_CLIENTE%TYPE,
        NUM_FOLIO_CA            CO_DET_CONVENIO.NUM_FOLIO_CA%TYPE,
        PREF_PLAZA              CO_DET_CONVENIO.PREF_PLAZA%TYPE,
        NUM_CUOTA_CA            CO_DET_CONVENIO.NUM_CUOTA_CA%TYPE,
        SEC_CUOTA_CA            CO_DET_CONVENIO.SEC_CUOTA_CA%TYPE,
        IMPORTE_CA              CO_DET_CONVENIO.IMPORTE_CA%TYPE,
        PROCESADO               CO_DET_CONVENIO.IMPORTE_CA%TYPE
);
TYPE TipTab_Facturas IS TABLE OF TipRegFacturas INDEX BY
BINARY_INTEGER;
Registro_Facturas       TipTab_Facturas;

CURSOR      c_Folios_Conv IS
            SELECT      NUM_SECUENCI,
                        NUM_SECUENCI_CA,
                        COD_TIPDOCUM_CA,
                        COD_VEND_AGENTE_CA,
                        LETRA_CA,
                        NUM_FOLIO_CA,
                        PREF_PLAZA,
                        NUM_CUOTA_CA,
                        SEC_CUOTA_CA,
                        IMPORTE_CA,
                        COD_CLIENTE
            FROM        CO_DET_CONVENIO
            WHERE       NUM_CONVENIO = vp_num_movimiento
ORDER BY    NUM_SECUENCI;

CURSOR      c_Documentos_Conv IS
            SELECT      NUM_PAGARE,
                        NUM_CUOTA,
                        FECHA_VENCTO,
                        IMPORTE,
                        NUM_IDENT_CTACTE,
                        IND_TITULAR,
                        NVL(COD_BANCO,' ') COD_BANCO,
                        NVL(NUM_CTACTE,' ') NUM_CTACTE,
                        NVL(COD_SUCURSAL,' ') COD_SUCURSAL,
                        NVL(COD_PLAZA,' ') COD_PLAZA,
                        NVL(NUM_CHEQUE,' ') NUM_CHEQUE,
                        COD_AUTORIZACION,
                        IMPORTE IMPORTE_REAL,
                        0 AS SECUENCIA
            FROM        CO_CUOTA_CONVENIO
            WHERE       NUM_CONVENIO = vp_num_movimiento;

CURSOR cur_intereses(EN_numtransaccion NUMBER) IS
        SELECT
                  tra.mto_intereses, tra.fac_cobro, tra.num_dias, tra.cod_concfact, tra.imp_cargo
    FROM
              CO_TRANSACINT tra
    WHERE
              tra.num_transaccion = EN_numtransaccion;


FECHAEFECTIVIDAD        VARCHAR2(12); /*AEO */
TIPOVALOR               NUMBER(1);
FECHAHOY                DATE;
CODCLIENTE              CO_CONVENIOS.CLIENTE_ASOCIADO%TYPE;
DEUDAPAGO               CO_CARTERA.IMPORTE_DEBE%TYPE;
ERROR_PROCESO EXCEPTION;

BEGIN
        vp_ruteo := 1;
        vp_gls_error := 'Select Usuario.';
/*************************************************************************
        INI MODIFICACION THALES-IS UC AGOSTO 2004
*************************************************************************/
        sw_copagos:='0';
/*************************************************************************
        FIN MODIFICACION THALES-IS UC AGOSTO 2004
*************************************************************************/

--      SELECT GE_PAC_GENERAL.PARAM_GENERAL('num_decimal')
--      INTO   iDecimal
--      FROM   DUAL;

        iDecimal := GE_PAC_GENERAL.PARAM_GENERAL('num_decimal');

--      SELECT USER, RTRIM(TO_CHAR(SYSDATE, 'dd-mm-yyyy'))
--      INTO   usuario, fecha
--      FROM   DUAL;

        usuario := USER;
        fecha := RTRIM(TO_CHAR(SYSDATE, 'dd-mm-yyyy'));

    vp_ruteo := 2;
    vp_gls_error := 'Select Co_interfaz_caja';
    SELECT NUM_MOVIMIENTO,IMPORTE_INTER
    INTO   vp_Num_Movimiento,vp_total_miscelanea
    FROM   CO_INTERFAZ_CAJA
    WHERE  NUM_INTERFAZ = TO_NUMBER(vp_num_interfaz);

    vp_ruteo := 3;
    vp_gls_error := 'Select Co_Datgen';
    SELECT AGENTE_INTERNO, LETRA_COBROS, DOC_PAGO, ORI_CAJA,CAU_CAJA
    INTO   vp_caja_agente_interno, vp_caja_letra, vp_doc_pago, vp_ori_caja,
           vp_cau_caja
    FROM   CO_DATGEN;

    vp_ruteo := 4;
    vp_gls_error := 'Select Ge_DatosGener';
    SELECT PROD_GENERAL
    INTO   vp_ProdGeneral
    FROM   GE_DATOSGENER;

    vp_ruteo := 5;
    vp_gls_error := 'Select Co_CONVENIOS';
    SELECT TIPO_CONVENIO,    NUM_PAGARE,      NUM_IDENT,        CLIENTE_ASOCIADO,
           IMPORTE_CONVENIO, TO_CHAR(FECHA_CONVENIO,'DD-MM-YYYY'),IMP_INTERES_FINAN, COD_BANCO,
           IMPORTE_CTDO,  IMP_INTERES_MORA, IMP_INTERES_COBRAN, IMP_INTERES_OPERA
    INTO   vp_tipo_convenio, vp_NumPagare,     vp_NumIdent,   vp_ClienteAsoc,
           vp_ImporteConv,   vp_FechaConvenio , vp_InteresFinan,   vp_CodBanco,
           vp_ImporteCtdo,   vp_ImporteMora,  vp_ImporteCobr,   vp_ImporteOpera
    FROM   CO_CONVENIOS
    WHERE  NUM_CONVENIO = vp_num_movimiento;

    vp_gls_error := 'SELECT COD_OPERADORA.';
    SELECT COD_OPERADORA
    INTO   sCod_OperadorAbono
    FROM   GE_CLIENTES
    WHERE  COD_CLIENTE = vp_ClienteAsoc;

    vp_gls_error := 'SELECT Fn_Obtiene_PlazaCliente';
--   SELECT Fn_Obtiene_PlazaCliente(vp_ClienteAsoc)
--   INTO   sCod_PlazaAbono
--   FROM   DUAL;

        sCod_PlazaAbono := Fn_Obtiene_PlazaCliente(vp_ClienteAsoc);

    vp_ruteo := 6;
    vp_gls_error := 'Select Co_Intereses';
        SELECT
                inte.ind_fec_cobro, inte.dias_aplicacion
        INTO
                        vp_ind_fec_cobro, vp_dias_aplicacion
        FROM
                        ge_clientes cli,
                CO_CATEGORIAS_TD cat,
                        CO_INTERESES inte,
                        CO_CATCOBCLIE_TD catcli
        WHERE   cli.cod_cliente = vp_ClienteAsoc
          AND
                        cli.cod_categoria = catcli.cod_catecli
          AND
                        cat.cod_categoria = catcli.cod_catecob
          AND
                        cat.cod_tasa = inte.cod_tasa
          AND
                        TRUNC(SYSDATE) BETWEEN TRUNC(fec_vigencia_dd_dh) AND TRUNC(fec_vigencia_hh_dh);

    vp_ruteo := 7;
    vp_gls_error := 'Select en Co_cuota_convenio.';
    i := 0;
    AUX_TOT_CUOTA := 0;

    FOR rReg IN c_Documentos_Conv LOOP
        i := i + 1 ;
        Registro_Cheques(i).NUM_PAGARE       := rReg.NUM_PAGARE;
        Registro_Cheques(i).NUM_CUOTA        := rReg.NUM_CUOTA;
        Registro_Cheques(i).FECHA_VENCTO     := rReg.FECHA_VENCTO;
        Registro_Cheques(i).IMPORTE          := rReg.IMPORTE;
        Registro_Cheques(i).NUM_IDENT_CTACTE := rReg.NUM_IDENT_CTACTE;
        Registro_Cheques(i).IND_TITULAR      := rReg.IND_TITULAR;
        Registro_Cheques(i).COD_BANCO        := rReg.COD_BANCO;
        Registro_Cheques(i).NUM_CTACTE       := rReg.NUM_CTACTE;
        Registro_Cheques(i).COD_SUCURSAL     := rReg.COD_SUCURSAL;
        Registro_Cheques(i).COD_PLAZA        := rReg.COD_PLAZA;
        Registro_Cheques(i).NUM_CHEQUE       := rReg.NUM_CHEQUE;
        Registro_Cheques(i).COD_AUTORIZACION := rReg.COD_AUTORIZACION;
        Registro_Cheques(i).IMPORTE_REAL     := rReg.IMPORTE_REAL;
        Registro_Cheques(i).SECUENCIA        := rReg.SECUENCIA;

        IF AUX_TOT_CUOTA < Registro_Cheques(i).NUM_CUOTA THEN
            AUX_TOT_CUOTA := Registro_Cheques(i).NUM_CUOTA;
        END IF;
    END LOOP;

    vp_ruteo := 8;
    vp_gls_error := 'Select en Co_det_solicitud.';

    i := 0;
    j := 0;
    FOR rReg IN c_Folios_Conv LOOP
        i := i + 1 ;
        Registro_Facturas(i).NUM_SECUENCI_CA   := rReg.NUM_SECUENCI_CA;
        Registro_Facturas(i).COD_TIPDOCUM_CA   := rReg.COD_TIPDOCUM_CA;
        Registro_Facturas(i).COD_VEND_AGENTE_CA:= rReg.COD_VEND_AGENTE_CA;
        Registro_Facturas(i).LETRA_CA          := rReg.LETRA_CA;
        Registro_Facturas(i).COD_CLIENTE       := rReg.COD_CLIENTE;
        Registro_Facturas(i).NUM_FOLIO_CA      := rReg.NUM_FOLIO_CA;
        Registro_Facturas(i).PREF_PLAZA        := rReg.PREF_PLAZA;
        Registro_Facturas(i).NUM_CUOTA_CA      := rReg.NUM_CUOTA_CA;
        Registro_Facturas(i).SEC_CUOTA_CA      := rReg.SEC_CUOTA_CA;
        Registro_Facturas(i).IMPORTE_CA        := rReg.IMPORTE_CA;
        Registro_Facturas(i).PROCESADO         := rReg.IMPORTE_CA;

        vp_esta := 0;
        vp_primero := NVL(Registro_Clientes.FIRST, 0);
        vp_ultimo  := NVL(Registro_Clientes.LAST, 0);
        IF vp_ultimo != 0 THEN
            <<LOOP_CLIENTES>>
            FOR j IN 1 .. vp_ultimo LOOP
                IF Registro_Clientes(j).COD_CLIENTE = Registro_Facturas(i).COD_CLIENTE THEN
                    vp_esta := 1;
                    EXIT;
                END IF;
            END LOOP LOOP_CLIENTES;
        END IF;
        IF vp_esta = 0 THEN
            j := vp_ultimo + 1;
            vp_ruteo := 9;
            vp_gls_error := 'Select Co_Seq_Pago';
            SELECT CO_SEQ_PAGO.NEXTVAL
                        INTO   vp_secuencia_pago
            FROM   DUAL;
                vp_secuencia_pago_aux:=vp_secuencia_pago;

            vp_ruteo := 10;
            vp_gls_error := 'Select Co_Cliesinter';
            vp_esta := 0;
            SELECT  COUNT(1)
            INTO    vp_esta
            FROM    CO_CLIESINTER
            WHERE   COD_EXENCION = 'SINTE' AND
                                        SYSDATE BETWEEN FEC_DESDE AND FEC_HASTA AND
                                        COD_CLIENTE = rReg.COD_CLIENTE;
            IF vp_esta = 0 THEN
                vp_ruteo := 11;
                vp_gls_error := 'Select Co_Inmunidad';
                SELECT COUNT(1)
                  INTO vp_esta
                  FROM CO_INMUNIDAD
                 WHERE SYSDATE BETWEEN FEC_DESDE AND FEC_HASTA
                   AND COD_CLIENTE = RREG.COD_CLIENTE;
            END IF;
            Registro_Clientes(j).COD_CLIENTE := rReg.COD_CLIENTE;
            Registro_Clientes(j).SECUENCIA_PAGO := vp_secuencia_pago;
            Registro_Clientes(j).EXENTO := vp_esta;
        END IF;
    END LOOP;  --c_Folios_Conv

-- Proceso propiemente tal
    vp_ruteo := 12;
    vp_gls_error := 'Loop Clientes (1)';
    <<LOOP_CLIENTES2>>
    FOR i IN 1 .. Registro_Clientes.LAST LOOP
        vp_ruteo := 13;
        vp_gls_error := 'Select Co_Det_Convenio (1)';
        SELECT  SUM(NVL(IMPORTE_CA,0))
        INTO    vp_tot_deuda
        FROM    CO_DET_CONVENIO
        WHERE   NUM_CONVENIO = vp_num_movimiento AND
                COD_CLIENTE = Registro_Clientes(i).COD_CLIENTE;
    END LOOP LOOP_CLIENTES2;

    vp_ruteo := 16;
    vp_gls_error := 'Loop Facturas (2)';
    <<LOOP_FACTURAS2>>
    FOR i IN 1 .. Registro_Facturas.LAST LOOP
        vp_esta := 0;
        <<LOOP_CLIENTES3>>
        FOR j IN 1 .. Registro_Clientes.LAST LOOP
            IF Registro_Clientes(j).COD_CLIENTE = Registro_Facturas(i).COD_CLIENTE THEN
                vp_secuencia_pago := Registro_Clientes(j).SECUENCIA_PAGO;
                IF Registro_Clientes(j).EXENTO > 0 THEN
                    vp_esta := 1;
                END IF;
                EXIT;
            END IF;
        END LOOP LOOP_CLIENTES3;

        IF Registro_Facturas(i).SEC_CUOTA_CA IS NOT NULL THEN
            vp_ruteo := 17;
            vp_gls_error := 'Select Co_Cartera (Fecha_1)';
            IF vp_ind_fec_cobro = 'F' THEN
                SELECT  (TRUNC(SYSDATE) - (TRUNC(FEC_EFECTIVIDAD) + vp_dias_aplicacion)),
                        IND_FACTURADO
                INTO    vp_dias_f, vp_ind_facturado
                FROM    CO_CARTERA
                WHERE   COD_CLIENTE = Registro_Facturas(i).COD_CLIENTE
                AND     NUM_SECUENCI = Registro_Facturas(i).NUM_SECUENCI_CA
                AND     COD_TIPDOCUM = Registro_Facturas(i).COD_TIPDOCUM_CA
                AND     COD_VENDEDOR_AGENTE = Registro_Facturas(i).COD_VEND_AGENTE_CA
                AND     LETRA = Registro_Facturas(i).LETRA_CA
                AND     NUM_CUOTA = Registro_Facturas(i).NUM_CUOTA_CA
                AND     SEC_CUOTA = Registro_Facturas(i).SEC_CUOTA_CA
                GROUP BY FEC_EFECTIVIDAD, IND_FACTURADO;
            ELSE
                SELECT  (TRUNC(SYSDATE) - (TRUNC(FEC_VENCIMIE) + vp_dias_aplicacion)), IND_FACTURADO
                INTO    vp_dias_v, vp_ind_facturado
                FROM    CO_CARTERA
                WHERE   COD_CLIENTE = Registro_Facturas(i).COD_CLIENTE
                AND     NUM_SECUENCI = Registro_Facturas(i).NUM_SECUENCI_CA
                AND     COD_TIPDOCUM = Registro_Facturas(i).COD_TIPDOCUM_CA
                AND     COD_VENDEDOR_AGENTE = Registro_Facturas(i).COD_VEND_AGENTE_CA
                AND     LETRA = Registro_Facturas(i).LETRA_CA
                AND     NUM_CUOTA = Registro_Facturas(i).NUM_CUOTA_CA
                AND     SEC_CUOTA = Registro_Facturas(i).SEC_CUOTA_CA
                GROUP BY FEC_VENCIMIE, IND_FACTURADO;
            END IF;

            vp_ruteo := 18;
            vp_gls_error := 'Select Co_Cartera (centremi)';
            SELECT  COD_CENTREMI
            INTO    vp_cod_centremi
            FROM    CO_CARTERA
            WHERE   COD_CLIENTE = Registro_Facturas(i).COD_CLIENTE
            AND     NUM_SECUENCI = Registro_Facturas(i).NUM_SECUENCI_CA
            AND     COD_TIPDOCUM = Registro_Facturas(i).COD_TIPDOCUM_CA
            AND     COD_VENDEDOR_AGENTE = Registro_Facturas(i).COD_VEND_AGENTE_CA
            AND     LETRA = Registro_Facturas(i).LETRA_CA
            AND     NUM_CUOTA = Registro_Facturas(i).NUM_CUOTA_CA
            AND     SEC_CUOTA = Registro_Facturas(i).SEC_CUOTA_CA
            AND     ROWNUM <= 1;
        ELSE
            vp_ruteo := 19;
            vp_gls_error := 'Select Co_Cartera (fecha_2)';
            IF vp_ind_fec_cobro = 'F' THEN
                SELECT  (TRUNC(SYSDATE) - (TRUNC(FEC_EFECTIVIDAD) + vp_dias_aplicacion))
                INTO    vp_dias_f
                FROM    CO_CARTERA
                WHERE   COD_CLIENTE = Registro_Facturas(i).COD_CLIENTE
                AND     NUM_SECUENCI = Registro_Facturas(i).NUM_SECUENCI_CA
                AND     COD_TIPDOCUM = Registro_Facturas(i).COD_TIPDOCUM_CA
                AND     COD_VENDEDOR_AGENTE = Registro_Facturas(i).COD_VEND_AGENTE_CA
                AND     LETRA = Registro_Facturas(i).LETRA_CA
                GROUP BY FEC_EFECTIVIDAD, IND_FACTURADO;
            ELSE
                SELECT  (TRUNC(SYSDATE) - (TRUNC(FEC_VENCIMIE) + vp_dias_aplicacion))
                INTO    vp_dias_v
                FROM    CO_CARTERA
                WHERE   COD_CLIENTE = Registro_Facturas(i).COD_CLIENTE
                AND     NUM_SECUENCI = Registro_Facturas(i).NUM_SECUENCI_CA
                AND     COD_TIPDOCUM = Registro_Facturas(i).COD_TIPDOCUM_CA
                AND     COD_VENDEDOR_AGENTE = Registro_Facturas(i).COD_VEND_AGENTE_CA
                AND     LETRA = Registro_Facturas(i).LETRA_CA
                GROUP BY FEC_VENCIMIE, IND_FACTURADO;
            END IF;

            vp_ruteo := 20;
            vp_gls_error := 'Select Co_Cartera (centremi)';
            SELECT  COD_CENTREMI
            INTO    vp_cod_centremi
            FROM    CO_CARTERA
            WHERE   COD_CLIENTE = Registro_Facturas(i).COD_CLIENTE
            AND     NUM_SECUENCI = Registro_Facturas(i).NUM_SECUENCI_CA
            AND     COD_TIPDOCUM = Registro_Facturas(i).COD_TIPDOCUM_CA
            AND     COD_VENDEDOR_AGENTE = Registro_Facturas(i).COD_VEND_AGENTE_CA
            AND     LETRA = Registro_Facturas(i).LETRA_CA
            AND     ROWNUM <= 1;
        END IF; --SecCuota<>""
        IF vp_esta = 0 THEN   --Intereses
            vp_ejecuta_in := 0;

            IF Registro_Facturas(i).COD_TIPDOCUM_CA > 47 AND Registro_Facturas(i).COD_TIPDOCUM_CA < 57 THEN
                IF vp_ind_facturado = 1 THEN
                    vp_ejecuta_in := 1;
                ELSE
                    vp_ejecuta_in := 0;
                END IF;
            ELSE
                vp_ejecuta_in := 1;
            END IF;

            IF vp_ejecuta_in = 1 THEN
                vp_ruteo := 21;
                vp_gls_error := 'Select Co_Seq_transacint';

                SELECT CO_SEQ_TRANSACINT.NEXTVAL
                  INTO vp_secuencia_coo
                  FROM DUAL;

                /*SELECT GE_FN_OBTIENE_RUTINA ('CO', 1,'TRUE', 'PL') INTO sProcedimiento FROM DUAL;*/

                vp_gls_error := 'Proceso Co_Calc_Intermoro';
                /*CO_CALC_INTERMORO(  vp_secuencia_coo,
                                    Registro_Facturas(i).COD_CLIENTE,
                                    Registro_Facturas(i).NUM_FOLIO_CA,
                                    Registro_Facturas(i).NUM_SECUENCI_CA,
                                    Registro_Facturas(i).COD_TIPDOCUM_CA,
                                    Registro_Facturas(i).IMPORTE_CA,
                                    Registro_Facturas(i).SEC_CUOTA_CA);*/

                sCodCliente:=Registro_Facturas(i).COD_CLIENTE;
                sNumFolio:= Registro_Facturas(i).NUM_FOLIO_CA;
                sPref_Plaza := Registro_Facturas(i).PREF_PLAZA;
                sNumSecuenci:=Registro_Facturas(i).NUM_SECUENCI_CA;
                sCodTipDocum:=Registro_Facturas(i).COD_TIPDOCUM_CA;
                iImporte:=Registro_Facturas(i).IMPORTE_CA;
                sSecCouta:=Registro_Facturas(i).SEC_CUOTA_CA;

                IF sSecCouta IS NULL THEN
                       sSecCouta:='NULL';
                END IF;

                                vp_gls_error := 'LLAMADA A PL Co_Interesmora_Pg.CO_CALCULO_PR (1). Cliente : ' || sCodCliente;
                                Co_Interesmora_Pg.Co_Calculo_Pr( vp_secuencia_coo, sCodCliente, sNumFolio, sPref_Plaza, sNumSecuenci, sCodTipDocum, iImporte, sSecCouta, vFecPago );

                vp_ruteo := 23;
                vp_gls_error := 'Proceso Co_Transacint';

                /*SELECT  MTO_INTERESES
                INTO    vp_mto_intereses
                FROM    CO_TRANSACINT
                WHERE   NUM_TRANSACCION = vp_secuencia_coo;*/
                                FOR rRegInt IN cur_intereses(vp_secuencia_coo) LOOP
                                        vp_mto_intereses := rRegInt.mto_intereses;

                        IF vp_mto_intereses > 0 THEN

                            vp_ruteo := 24;
                            vp_gls_error := 'Select ge_seq_cargos';

                            SELECT  GE_SEQ_CARGOS.NEXTVAL
                            INTO    vp_secuencia_cargos
                            FROM    DUAL;

                            --vp_concepto := '5678';
                                                vp_concepto := rRegInt.cod_concfact;
                            vp_moneda := '001';
                            vp_producto := '5';
                            vp_abonado := '0';
                            vp_ruteo := 25;
                            vp_gls_error := 'proceso co_gen_cargo';
                            Co_Gen_Cargo(   TO_CHAR(Registro_Facturas(i).COD_CLIENTE),
                                            vp_abonado,
                                            vp_concepto,
                                            TO_CHAR(vp_mto_intereses),
                                            vp_moneda,
                                            vp_producto,
                                            TO_CHAR(vp_secuencia_cargos));

                            vp_ruteo := 26;
                            vp_gls_error := 'select ge_cargos';
                            SELECT  cod_ciclfact
                            INTO    vp_cod_ciclfact
                            FROM    GE_CARGOS
                            WHERE   NUM_CARGO = vp_secuencia_cargos;

                            vp_ruteo := 27;
                            vp_gls_error := 'insert co_interesapli';
                            INSERT INTO CO_INTERESAPLI
                                       (NUM_SECUENCI, COD_TIPDOCUM,
                                        COD_VENDEDOR_AGENTE, LETRA,
                                        COD_CENTREMI, NUM_SECUREL,
                                        COD_TIPDOCREL, COD_AGENTEREL,
                                        LETRA_REL, COD_CENTRREL,
                                        NUM_CARGO, NUM_FOLIO, PREF_PLAZA,
                                        SEC_CUOTA, NUM_CUOTA,
                                        IMP_DEUDA, IMP_CARGO,
                                        FACTOR_COBRO, NUM_DIAS,
                                        COD_CLIENTE, COD_CICLFACT,
                                        IND_FACTURADO, FEC_CALCULO, COD_MODULO)
                            VALUES     (vp_secuencia_pago, vp_doc_pago,
                                        vp_caja_agente_interno, vp_caja_letra,
                                        vp_caja_centremi, Registro_facturas(i).NUM_SECUENCI_CA,
                                        Registro_Facturas(i).COD_TIPDOCUM_CA,
                                        Registro_Facturas(i).COD_VEND_AGENTE_CA,
                                        Registro_Facturas(i).LETRA_CA, vp_cod_centremi,
                                        vp_secuencia_cargos, Registro_Facturas(i).NUM_FOLIO_CA,
                                        Registro_Facturas(i).PREF_PLAZA,
                                        Registro_Facturas(i).SEC_CUOTA_CA,
                                        Registro_Facturas(i).NUM_CUOTA_CA,
                                        rRegInt.imp_cargo, vp_mto_intereses,
                                        --Registro_Facturas(i).IMPORTE_CA, vp_mto_intereses,
                                        --(TO_NUMBER(vp_factor_int)/TO_NUMBER(vp_factor_dia))/100, vp_dias,
                                                                        rRegInt.fac_cobro, rRegInt.num_dias,
                                        Registro_Facturas(i).COD_CLIENTE, vp_cod_ciclfact, NULL, SYSDATE, 'COV' );
                        END IF;  -- mto intereses > 0
                                END LOOP;
            END IF;   --Ejecuta en 1
        END IF; -- Intereses

        vp_ruteo := 28;
        vp_gls_error := 'SUMA DE DEUDA 28';
        SELECT SUM(IMPORTE_DEBE - IMPORTE_HABER) INTO DEUDAPAGO
        FROM CO_CARTERA
        WHERE NUM_FOLIO    = Registro_Facturas(i).NUM_FOLIO_CA    AND
              PREF_PLAZA   = Registro_Facturas(i).PREF_PLAZA      AND
              COD_TIPDOCUM = Registro_Facturas(i).COD_TIPDOCUM_CA AND
              NUM_SECUENCI = Registro_Facturas(i).NUM_SECUENCI_CA AND
              COD_CLIENTE  = Registro_Facturas(i).COD_CLIENTE
        GROUP BY NUM_FOLIO, PREF_PLAZA, COD_TIPDOCUM, NUM_SECUENCI, COD_CLIENTE;

        IF (Registro_Facturas(i).IMPORTE_CA = DEUDAPAGO) THEN
            BEGIN
                vp_ruteo := 28;
                vp_gls_error := 'Llamada a PL  UNIVERSAl ENTERO';
/*************************************************************************
        INI MODIFICACION THALES-IS UC AGOSTO 2004
*************************************************************************/
                Co_Aplicapago_Universal(
                                'COV'  ,
                                Registro_Facturas(i).COD_CLIENTE    ,
                                vp_tot_deuda   ,
                                vFecPago  ,
                                NULL  ,
                                '1'    ,
                                '1'    ,
                                'Convenio'  ,
                                vp_cod_oficina  ,
                                NULL    ,
                                NULL  ,
                                NULL  ,
                                vp_num_compago    ,
                                NULL  ,
                                NULL  ,
                                NULL    ,
                                NULL  ,
                                NULL  ,
                                NULL    ,
                                vp_secuencia_pago_aux  ,
                                NULL  ,
                                sNumFolio ,
                                '1'  ,
                                NULL  ,
                                sw_copagos,
                                'Total'  ,
                                Registro_Facturas(i).NUM_SECUENCI_CA ,
                                Registro_Facturas(i).COD_TIPDOCUM_CA ,
                                Registro_Facturas(i).COD_VEND_AGENTE_CA  ,
                                Registro_Facturas(i).LETRA_CA  ,
                                Registro_Facturas(i).SEC_CUOTA_CA  ,
                                Registro_Facturas(i).IMPORTE_CA,
                                vRetorno1,
                                Registro_Facturas(i).PREF_PLAZA,
                                vRetorno3,
                                vRetorno4);
                                sw_copagos:='1';
                    IF (vRetorno4!=0) THEN
                        BEGIN
                                RAISE ERROR_PROCESO;
                        END;
                    END IF;
                END;
/*************************************************************************
        FIN MODIFICACION THALES-IS UC AGOSTO 2004
*************************************************************************/
        END IF;

        IF (Registro_Facturas(i).IMPORTE_CA < DEUDAPAGO) THEN
            BEGIN
                vp_ruteo := 28;
                vp_gls_error := 'Llamada a PL  CO_P_PAGO_PARCIALES_FACTURA';
/*************************************************************************
        INI MODIFICACION THALES-IS UC AGOSTO 2004
*************************************************************************/
                Co_Aplicapago_Universal(
                                'COV'  ,
                                Registro_Facturas(i).COD_CLIENTE    ,
                                vp_tot_deuda   ,
                                vFecPago  ,
                                NULL  ,
                                '1'    ,
                                '1'    ,
                                'Convenio'  ,
                                vp_cod_oficina  ,
                                NULL    ,
                                NULL  ,
                                NULL  ,
                                vp_num_compago    ,
                                NULL  ,
                                NULL  ,
                                NULL    ,
                                NULL  ,
                                NULL  ,
                                NULL    ,
                                vp_secuencia_pago_aux  ,
                                NULL  ,
                                sNumFolio  ,
                                '1'  ,
                                NULL  ,
                                sw_copagos,
                                'Parcial'  ,
                                Registro_Facturas(i).NUM_SECUENCI_CA ,
                                Registro_Facturas(i).COD_TIPDOCUM_CA ,
                                Registro_Facturas(i).COD_VEND_AGENTE_CA  ,
                                Registro_Facturas(i).LETRA_CA  ,
                                Registro_Facturas(i).SEC_CUOTA_CA  ,
                                Registro_Facturas(i).IMPORTE_CA,
                                vRetorno1,
                                Registro_Facturas(i).PREF_PLAZA,
                                vRetorno3,
                                vRetorno4);
                                sw_copagos:='1';
                IF (vRetorno4!=0) THEN
                        BEGIN
                                RAISE ERROR_PROCESO;
                        END;
                END IF;
            END;
/*************************************************************************
        FIN MODIFICACION THALES-IS UC AGOSTO 2004
*************************************************************************/
       END IF;

    END LOOP LOOP_FACTURAS2;
    vp_ruteo := 9;
    vp_gls_error := 'Toma CO_CAJAS Update.';
    vp_ruteo := 29;
    vp_gls_error := 'update co_cajas';
    UPDATE  CO_CAJAS    SET
            NUM_SECUMOV = NUM_SECUMOV
    WHERE   COD_OFICINA = vp_cod_oficina AND
            COD_CAJA = vp_cod_caja;

    vp_ruteo := 30;
    vp_gls_error := 'Select CO_CAJAS Secuencia.';
    SELECT     NUM_SECUMOV
    INTO       vp_secumov
    FROM       CO_CAJAS
    WHERE      COD_OFICINA = vp_cod_oficina AND
               COD_CAJA = vp_cod_caja;

    vp_ruteo := 31;
    vp_gls_error := 'Loop Cheques (3)';
    <<LOOP_CHEQUES7>>
    FOR i IN 1 .. Registro_Cheques.LAST LOOP
        IF vp_tipo_convenio <> '1' THEN -- <> Pagari
            vp_docum_carga := 59;

            vp_ruteo := 32;
            vp_gls_error := 'Select Co_Seq_Pagocheque';

            SELECT CO_SEQ_PAGOCHEQUE.NEXTVAL
            INTO   vp_secuencia_cheque
            FROM   DUAL;

            Registro_Cheques(i).SECUENCIA:=vp_secuencia_cheque;
            vp_secumov := vp_secumov + 1;
            vp_ruteo := 33;
            vp_gls_error := 'Insert Co_Documentos';
            INSERT INTO CO_DOCUMENTOS
                        (NUM_SECUENCI, COD_TIPDOCUM, NUM_SEC_CUOTA,COD_TIPVALOR,
                         NUM_CONVENIO, NUM_DOCUMENTO, COD_OFICINA,COD_CAJA,
                         NUM_SECUMOV, COD_BANCO, COD_SUCURSAL,COD_PLAZA, CTA_CORRIENTE,
                         COD_AUTORIZACION, IND_TITULAR, NUM_IDENT,IMPORTE_DOCUM,
                         FECHA_VENCTO, FECHA_DEPOSITO, NUN_DEPOSITO,COD_BANCO_DEPO,
                         COD_SUCURSAL_DEPO, COD_PLAZA_DEPO,CTA_CORRIENTE_DEPO,
                         COD_ESTADO, COD_PROTESTO, COD_UBICACION,FEC_ULT_MOVIMIENTO,
                         NOM_USUARIO, COD_OPERADORA_SCL, COD_PLAZA_OP)
            VALUES      (vp_secuencia_cheque, 59, Registro_Cheques(i).NUM_CUOTA, '2',
                         vp_num_movimiento, Registro_Cheques(i).NUM_CHEQUE,
                         vp_cod_oficina, vp_cod_caja,
                         vp_secumov, Registro_cheques(i).COD_BANCO,
                         Registro_cheques(i).COD_SUCURSAL, Registro_cheques(i).COD_PLAZA,
                         Registro_cheques(i).NUM_CTACTE,
                         Registro_cheques(i).COD_AUTORIZACION,
                         Registro_cheques(i).IND_TITULAR, Registro_cheques(i).NUM_IDENT_CTACTE,
                         Registro_cheques(i).IMPORTE,
                         Registro_cheques(i).FECHA_VENCTO, NULL, NULL, NULL,
                         NULL, NULL, NULL, '0', NULL, '1', SYSDATE, usuario, sCod_OperadorAbono, sCod_PlazaAbono );

           vp_ruteo := 28;
           vp_gls_error := 'FEC_EFECTIVIDAD DE CO_CAJAS';
           SELECT TO_CHAR(FEC_EFECTIVIDAD,'YYYYMMDDHH24MI') INTO FECHAEFECTIVIDAD
           FROM CO_CAJAS
           WHERE COD_OFICINA= vp_cod_oficina
           AND   COD_CAJA   = TO_NUMBER(vp_cod_caja);

--           SELECT SYSDATE INTO FECHAHOY FROM DUAL;

                   FECHAHOY := SYSDATE;

           vp_ruteo := 28;
           vp_gls_error := 'SELECCIONANDO CLIENTE DE CO_CONVENIOS';
           SELECT CLIENTE_ASOCIADO INTO CODCLIENTE
           FROM  CO_CONVENIOS
           WHERE NUM_CONVENIO=vp_num_movimiento;
           IF (TRUNC(Registro_cheques(i).FECHA_VENCTO)=TRUNC(FECHAHOY)) THEN
                 TIPOVALOR := 4;
           ELSE
                 TIPOVALOR := 2;
           END IF;

           vp_ruteo := 28;
           vp_gls_error := 'INSERT EN LA CO_MOVIMIENTOSCAJA 28';
           INSERT INTO CO_MOVIMIENTOSCAJA
                  (COD_OFICINA, COD_CAJA, NUM_SECUMOV, NUM_EJERCICIO, FEC_EFECTIVIDAD, NOM_USUARORA,
                  TIP_MOVCAJA, IND_DEPOSITO, IMPORTE, IND_ERRONEO, TIP_VALOR, IND_CIERRE, COD_CLIENTE,
                  TIP_DOCUMENT, COD_VENDEDOR_AGENTE, LETRA, COD_CENTREMI, /*                                        NUM_SECUENCI,           */
                  NUM_COMPAGO, PREF_PLAZA, COD_BANCO, CTA_CORRIENTE, NUM_CHEQUE, FEC_CHEQUE, COD_OPERADORA_SCL, COD_PLAZA )
           VALUES (vp_cod_oficina, TO_NUMBER(vp_cod_caja), vp_secumov, FECHAEFECTIVIDAD,
                   SYSDATE, USUARIO, 8, 0, Registro_cheques(i).IMPORTE, 0, TIPOVALOR,
                   0, CODCLIENTE, 8, '100001', 'X', 1, /*                                          ?,                    */
                   VP_NUM_COMPAGO,VP_NUM_FOLIOCOMP, Registro_cheques(i).COD_BANCO, Registro_cheques(i).NUM_CTACTE,
                   Registro_Cheques(i).NUM_CHEQUE, Registro_cheques(i).FECHA_VENCTO , sCod_OperadorAbono, sCod_PlazaAbono);

        ELSE --Pagare
            vp_docum_carga := 5;
            vp_ruteo := 34;
            vp_gls_error := 'Select Co_Seq_Pagare';

            SELECT CO_SEQ_PAGARE.NEXTVAL
            INTO   vp_secuencia_cheque
            FROM   DUAL;

            Registro_Cheques(i).SECUENCIA:=vp_secuencia_cheque;
            --vp_secumov := vp_secumov + 1;
                        vp_ruteo := 51;
            vp_gls_error := 'Insert Co_Documentos';
            INSERT INTO CO_DOCUMENTOS
                        (NUM_SECUENCI, COD_TIPDOCUM, NUM_SEC_CUOTA,COD_TIPVALOR,
                         NUM_CONVENIO, NUM_DOCUMENTO, COD_OFICINA,COD_CAJA,
                         NUM_SECUMOV, COD_BANCO, COD_SUCURSAL,COD_PLAZA, CTA_CORRIENTE,
                         COD_AUTORIZACION, IND_TITULAR, NUM_IDENT,IMPORTE_DOCUM,
                         FECHA_VENCTO, FECHA_DEPOSITO, NUN_DEPOSITO,COD_BANCO_DEPO,
                         COD_SUCURSAL_DEPO, COD_PLAZA_DEPO,CTA_CORRIENTE_DEPO,
                         COD_ESTADO, COD_PROTESTO, COD_UBICACION,FEC_ULT_MOVIMIENTO,
                         NOM_USUARIO, COD_OPERADORA_SCL, COD_PLAZA_OP)
            VALUES       (vp_secuencia_cheque, 5, Registro_Cheques(i).NUM_CUOTA, '7',
                         vp_num_movimiento, Registro_Cheques(i).NUM_PAGARE,
                         vp_cod_oficina, vp_cod_caja,
                         vp_secumov, vp_CodBanco,
                         Registro_cheques(i).COD_SUCURSAL, Registro_cheques(i).COD_PLAZA,
                         Registro_cheques(i).NUM_CTACTE,
                         Registro_cheques(i).COD_AUTORIZACION,
                         Registro_cheques(i).IND_TITULAR, Registro_cheques(i).NUM_IDENT_CTACTE,
                         Registro_cheques(i).IMPORTE,
                         Registro_cheques(i).FECHA_VENCTO, NULL, NULL, NULL,
                         NULL, NULL, NULL,
                         '0', NULL, '1', SYSDATE, usuario, sCod_OperadorAbono, sCod_PlazaAbono  );
        END IF;
        iSecuenciaDet := 0;
        Monto_Acum := 0;
        iProcesa := 0;

        vp_ruteo := 35;
        vp_gls_error := 'Loop Facturas (4)';
        <<LOOP_FACTURAS>>
        FOR j IN 1 .. Registro_Facturas.LAST LOOP
            iProcesa := iProcesa + 1;
            IF Registro_Facturas(j).IMPORTE_CA <> 0 THEN --PROCESADO = 0 THEN
                sClienteCheque := Registro_Facturas(j).COD_CLIENTE;
                <<LOOP_CLIENTES>>
                FOR k IN 1 .. Registro_Clientes.LAST LOOP
                    IF Registro_Clientes(k).COD_CLIENTE = sClienteCheque THEN
                        sSecuenciaPago := Registro_Clientes(k).SECUENCIA_PAGO;
                        EXIT;
                    END IF;
                END LOOP LOOP_CLIENTES;
                IF Registro_Cheques(i).IMPORTE > Registro_Facturas(j).IMPORTE_CA THEN
                    IF j = Registro_Facturas.LAST AND i = Registro_Cheques.LAST THEN
                        Monto_Acum := Monto_Acum + Registro_Cheques(i).IMPORTE;
                    ELSE
                        Monto_Acum := Monto_Acum + Registro_Facturas(j).IMPORTE_CA;
                    END IF;

                    Registro_Cheques(i).IMPORTE := Registro_Cheques(i).IMPORTE - Registro_Facturas(j).IMPORTE_CA;
                    Registro_Facturas(j).IMPORTE_CA := 0;
                    iSecuenciaDet := iSecuenciaDet + 1;
                    IF vp_tipo_convenio <> '1' THEN -- <> Pagari
                        vp_ruteo := 36;
                        vp_gls_error := 'Insert Co_Det_Documentos';

                        INSERT INTO CO_DET_DOCUMENTOS
                                    (NUM_SECUENCI, NUM_DOCUMENTO,
                                     NUM_SECUENCI_DOC, COD_CLIENTE,
                                     NUM_SECUENCI_PAGO, NUM_SECUENCI_CA,
                                     COD_TIPDOCUM_CA, COD_VEND_AGENTE_CA,
                                     LETRA_CA, NUM_FOLIO_CA, PREF_PLAZA,
                                     NUM_CUOTA_CA, SEC_CUOTA_CA,
                                     IMPORTE_CA)
                        VALUES      (iSecuenciaDet, Registro_Cheques(i).NUM_CHEQUE,
                                     vp_secuencia_cheque, Registro_Facturas(j).COD_CLIENTE,
                                     sSecuenciaPago, Registro_Facturas(j).NUM_SECUENCI_CA,
                                     Registro_Facturas(j).COD_TIPDOCUM_CA,
                                     Registro_Facturas(j).COD_VEND_AGENTE_CA,
                                     Registro_Facturas(j).LETRA_CA,
                                     Registro_Facturas(j).NUM_FOLIO_CA,
                                     Registro_Facturas(j).PREF_PLAZA,
                                     Registro_Facturas(j).NUM_CUOTA_CA,
                                     Registro_Facturas(j).SEC_CUOTA_CA,
                                     Registro_Facturas(j).IMPORTE_CA
                                    );
                    ELSE  -- =  Pagare
                        vp_ruteo := 52;
                        vp_gls_error := 'Insert Co_Det_Documentos';

                        INSERT INTO CO_DET_DOCUMENTOS
                                    (NUM_SECUENCI, NUM_DOCUMENTO,
                                     NUM_SECUENCI_DOC, COD_CLIENTE,
                                     NUM_SECUENCI_PAGO, NUM_SECUENCI_CA,
                                     COD_TIPDOCUM_CA, COD_VEND_AGENTE_CA,
                                     LETRA_CA, NUM_FOLIO_CA,PREF_PLAZA,
                                     NUM_CUOTA_CA, SEC_CUOTA_CA,
                                     IMPORTE_CA)
                        VALUES      (iSecuenciaDet, Registro_Cheques(i).NUM_PAGARE,
                                     vp_secuencia_cheque, Registro_Facturas(j).COD_CLIENTE,
                                     sSecuenciaPago, Registro_Facturas(j).NUM_SECUENCI_CA,
                                     Registro_Facturas(j).COD_TIPDOCUM_CA,
                                     Registro_Facturas(j).COD_VEND_AGENTE_CA,
                                     Registro_Facturas(j).LETRA_CA,
                                     Registro_Facturas(j).NUM_FOLIO_CA,
                                     Registro_Facturas(j).PREF_PLAZA,
                                     Registro_Facturas(j).NUM_CUOTA_CA,
                                     Registro_Facturas(j).SEC_CUOTA_CA,
                                     Registro_Facturas(j).IMPORTE_CA
                                    );
                    END IF;
                    IF j + 1 > Registro_Facturas.LAST THEN
                        Prox_Cliente := 0;
                    ELSE
                        Prox_Cliente :=Registro_Facturas(j+1).COD_CLIENTE;
                    END IF;
                                        --COMENTADO EL 6 DE NOV 2002
                    /*IF Prox_Cliente != sClienteCheque or (j = Registro_Facturas.Last and i = Registro_Cheques.Last) THEN

                        vp_ruteo := 37;
                        vp_gls_error := 'Select Co_Secartera';
                        SELECT  COUNT(1)
                        INTO    vp_existe
                        FROM     CO_SECARTERA
                        WHERE   COD_TIPDOCUM = vp_docum_carga
                        AND COD_VENDEDOR_AGENTE = vp_caja_agente_interno
                        AND LETRA = vp_caja_letra
                        AND COD_CENTREMI = TO_NUMBER(vp_caja_centremi)
                        AND NUM_SECUENCI = vp_secuencia_cheque
                        AND COD_CONCEPTO = 1;

                        IF vp_existe > 0 THEN
                            vp_ruteo := 38;
                            vp_gls_error := 'Select Co_Secartera';
                            SELECT COLUMNA
                            INTO   vp_columna
                            FROM   CO_SECARTERA
                            WHERE  COD_TIPDOCUM = vp_docum_carga
                            AND       COD_VENDEDOR_AGENTE = vp_caja_agente_interno
                            AND       LETRA = vp_caja_letra
                            AND       COD_CENTREMI = TO_NUMBER(vp_caja_centremi)
                            AND       NUM_SECUENCI = vp_secuencia_cheque
                            AND       COD_CONCEPTO = 1;
                            IF vp_columna = 9999 THEN
                                vp_columna := 1;
                            ELSE
                                vp_columna := vp_columna + 1;
                            END IF;

                            vp_ruteo := 39;
                            vp_gls_error := 'Update Co_Secartera';
                            UPDATE CO_SECARTERA SET
                                   COLUMNA = vp_columna
                            WHERE  COD_TIPDOCUM = vp_docum_carga
                            AND    COD_VENDEDOR_AGENTE = vp_caja_agente_interno
                            AND    LETRA = vp_caja_letra
                            AND    COD_CENTREMI = TO_NUMBER(vp_caja_centremi)
                            AND    NUM_SECUENCI = vp_secuencia_cheque
                            AND    COD_CONCEPTO = 1;
                        ELSE
                            vp_columna := 1;
                            vp_ruteo := 40;
                            vp_gls_error := 'Insert Co_Secartera-1';
                            INSERT INTO CO_SECARTERA
                                       (COD_TIPDOCUM,
                                        COD_VENDEDOR_AGENTE,
                                        LETRA,
                                        COD_CENTREMI,
                                        NUM_SECUENCI,
                                        COD_CONCEPTO,
                                        COLUMNA)
                            VALUES     (vp_docum_carga,
                                        vp_caja_agente_interno,
                                        vp_caja_letra,
                                        TO_NUMBER(vp_caja_centremi),
                                        vp_secuencia_cheque,
                                        1,
                                        vp_columna );
                        END IF;
                        IF vp_docum_carga = 5 THEN  /*Pagare*/       /*rbr*/
                            /*AUX_NUM_FOLIO := Registro_Cheques(i).NUM_PAGARE ;
                        ELSE
                            AUX_NUM_FOLIO := TO_NUMBER(Registro_Cheques(i).NUM_CHEQUE) ;
                        END IF;

                        vp_ruteo := 41;
                        vp_gls_error := 'Insert Co_cartera - 1';
                        INSERT INTO CO_CARTERA
                               (COD_CLIENTE    , COD_TIPDOCUM   ,  COD_CENTREMI  ,
                                NUM_SECUENCI   , COD_VENDEDOR_AGENTE,  LETRA     ,
                                COD_CONCEPTO   , COLUMNA        ,  COD_PRODUCTO  ,
                                IMPORTE_DEBE   , IMPORTE_HABER  ,  IND_CONTADO   ,
                                IND_FACTURADO  , FEC_EFECTIVIDAD, FEC_VENCIMIE   ,
                                FEC_CADUCIDA   , FEC_ANTIGUEDAD , FEC_PAGO       ,
                                NUM_ABONADO    , NUM_FOLIO      , NUM_CUOTA      ,
                                SEC_CUOTA      , NUM_FOLIOCTC   , NUM_VENTA      )
                        VALUES (Registro_Facturas(j).COD_CLIENTE, vp_docum_carga, vp_caja_centremi,
                                vp_secuencia_cheque, vp_caja_agente_interno, vp_caja_letra,
                                1,  vp_columna, vp_ProdGeneral,
                                Monto_Acum,  0, 0,
                                1, SYSDATE , Registro_Cheques(i).FECHA_VENCTO,
                                SYSDATE    , SYSDATE       , SYSDATE        ,
                                0          , AUX_NUM_FOLIO , AUX_TOT_CUOTA  ,
                                Registro_Cheques(i).NUM_CUOTA,   NULL, NULL );
                        Monto_Acum := 0;
                    END IF; */ --COMENTADO EL 6 DE NOV 2002

                ELSE -- monto cheque <= monto factura

                    Registro_Facturas(j).PROCESADO := Registro_Facturas(j).PROCESADO - Registro_Cheques(i).IMPORTE;
                    Monto_Acum := Monto_Acum + Registro_Cheques(i).IMPORTE;
                    Registro_Facturas(j).IMPORTE_CA := Registro_Facturas(j).IMPORTE_CA - Registro_Cheques(i).IMPORTE;
                    Registro_Cheques(i).IMPORTE := 0;
                    iSecuenciaDet := iSecuenciaDet + 1;

                    IF vp_tipo_convenio <> '1' THEN -- <> Pagari
                        vp_ruteo := 42;
                        vp_gls_error := 'Insert Co_Det_Documentos';
                        INSERT INTO CO_DET_DOCUMENTOS
                                    (NUM_SECUENCI, NUM_DOCUMENTO,
                                     NUM_SECUENCI_DOC, COD_CLIENTE,
                                     NUM_SECUENCI_PAGO, NUM_SECUENCI_CA,
                                     COD_TIPDOCUM_CA, COD_VEND_AGENTE_CA,
                                     LETRA_CA, NUM_FOLIO_CA,PREF_PLAZA,
                                     NUM_CUOTA_CA, SEC_CUOTA_CA,
                                     IMPORTE_CA)
                        VALUES      (iSecuenciaDet, Registro_Cheques(i).NUM_CHEQUE,
                                     vp_secuencia_cheque, Registro_Facturas(j).COD_CLIENTE,
                                     sSecuenciaPago, Registro_Facturas(j).NUM_SECUENCI_CA,
                                     Registro_Facturas(j).COD_TIPDOCUM_CA,
                                     Registro_Facturas(j).COD_VEND_AGENTE_CA,
                                     Registro_Facturas(j).LETRA_CA,
                                     Registro_Facturas(j).NUM_FOLIO_CA,
                                     Registro_Facturas(j).PREF_PLAZA,
                                     Registro_Facturas(j).NUM_CUOTA_CA,
                                     Registro_Facturas(j).SEC_CUOTA_CA,
                                     Registro_Facturas(j).IMPORTE_CA
                                    );
                    ELSE  -- =  Pagare

                        vp_ruteo := 53;
                        vp_gls_error := 'Insert Co_Det_Documentos';
                        INSERT INTO CO_DET_DOCUMENTOS
                                    (NUM_SECUENCI, NUM_DOCUMENTO,
                                     NUM_SECUENCI_DOC, COD_CLIENTE,
                                     NUM_SECUENCI_PAGO, NUM_SECUENCI_CA,
                                     COD_TIPDOCUM_CA, COD_VEND_AGENTE_CA,
                                     LETRA_CA, NUM_FOLIO_CA,PREF_PLAZA,
                                     NUM_CUOTA_CA, SEC_CUOTA_CA,
                                     IMPORTE_CA)
                        VALUES      (iSecuenciaDet, Registro_Cheques(i).NUM_PAGARE,
                                     vp_secuencia_cheque, Registro_Facturas(j).COD_CLIENTE,
                                     sSecuenciaPago, Registro_Facturas(j).NUM_SECUENCI_CA,
                                     Registro_Facturas(j).COD_TIPDOCUM_CA,
                                     Registro_Facturas(j).COD_VEND_AGENTE_CA,
                                     Registro_Facturas(j).LETRA_CA,
                                     Registro_Facturas(j).NUM_FOLIO_CA,
                                     Registro_Facturas(j).PREF_PLAZA,
                                     Registro_Facturas(j).NUM_CUOTA_CA,
                                     Registro_Facturas(j).SEC_CUOTA_CA,
                                     Registro_Facturas(j).IMPORTE_CA );
     END IF;

         --COMENTADO 6 NOV 2002
     /*               vp_ruteo := 43;
                    vp_gls_error := 'Select Co_Secartera';
                    SELECT  COUNT(1)
                    INTO    vp_existe
                    FROM    CO_SECARTERA
                    WHERE   COD_TIPDOCUM = vp_docum_carga
                    AND     COD_VENDEDOR_AGENTE = vp_caja_agente_interno
                    AND     LETRA = vp_caja_letra
                    AND     COD_CENTREMI = vp_caja_centremi
                    AND     NUM_SECUENCI = vp_secuencia_cheque
                    AND     COD_CONCEPTO = 1;
                    IF vp_existe > 0 THEN
                        vp_ruteo := 44;
                        vp_gls_error := 'Select Co_Secartera';
                        SELECT COLUMNA
                        INTO   vp_columna
                        FROM   CO_SECARTERA
                        WHERE  COD_TIPDOCUM = vp_docum_carga
                        AND    COD_VENDEDOR_AGENTE = vp_caja_agente_interno
                        AND    LETRA = vp_caja_letra
                        AND    COD_CENTREMI = vp_caja_centremi
                        AND    NUM_SECUENCI = vp_secuencia_cheque
                        AND    COD_CONCEPTO = 1;
                        IF vp_columna = 9999 THEN
                            vp_columna := 1;
                        ELSE
                            vp_columna := vp_columna + 1;
                        END IF;

                        vp_ruteo := 45;
                        vp_gls_error := 'Update Co_Secartera';
                        UPDATE CO_SECARTERA
                        SET    COLUMNA = vp_columna
                        WHERE  COD_TIPDOCUM = vp_docum_carga
                        AND    COD_VENDEDOR_AGENTE = vp_caja_agente_interno
                        AND    LETRA = vp_caja_letra
                        AND    COD_CENTREMI = vp_caja_centremi
                        AND    NUM_SECUENCI = vp_secuencia_cheque
                        AND    COD_CONCEPTO = 1;
                    ELSE

                        vp_columna := 1;
                        vp_ruteo := 46;
                        vp_gls_error := 'Insert Co_Secartera-2';
                        INSERT INTO CO_SECARTERA
                                   (COD_TIPDOCUM,
                                    COD_VENDEDOR_AGENTE,
                                    LETRA,
                                    COD_CENTREMI,
                                    NUM_SECUENCI,
                                    COD_CONCEPTO,
                                    COLUMNA)
                        VALUES     (vp_docum_carga,
                                    vp_caja_agente_interno,
                                    vp_caja_letra,
                                    vp_caja_centremi,
                                    vp_secuencia_cheque,
                                    1,
                                    vp_columna   );
                    END IF;
                    IF vp_docum_carga = 5 THEN  /* Pagare */     /*rbr*/
                    /*    AUX_NUM_FOLIO := Registro_Cheques(i).NUM_PAGARE ;
                    ELSE
                        AUX_NUM_FOLIO := TO_NUMBER(Registro_Cheques(i).NUM_CHEQUE) ;
                    END IF;

                    vp_ruteo := 47;
                    vp_gls_error := 'Insert Co_Cartera - 2';
                    INSERT INTO CO_CARTERA
                           (COD_CLIENTE,   COD_TIPDOCUM,   COD_CENTREMI,   NUM_SECUENCI,
                            COD_VENDEDOR_AGENTE,    LETRA,  COD_CONCEPTO,   COLUMNA,
                            COD_PRODUCTO,   IMPORTE_DEBE,   IMPORTE_HABER,  IND_CONTADO,
                            IND_FACTURADO,  FEC_EFECTIVIDAD,    FEC_VENCIMIE,   FEC_CADUCIDA,
                            FEC_ANTIGUEDAD, FEC_PAGO,   NUM_ABONADO,    NUM_FOLIO,
                            NUM_CUOTA,  SEC_CUOTA,  NUM_FOLIOCTC,   NUM_VENTA)
                    VALUES (Registro_Facturas(j).COD_CLIENTE,   vp_docum_carga,
                            vp_caja_centremi    ,   vp_secuencia_cheque,
                            vp_caja_agente_interno, vp_caja_letra,
                            1,   vp_columna     ,   vp_ProdGeneral,
                            Monto_Acum,
                            0,  0,  1,  SYSDATE,    Registro_Cheques(i).FECHA_VENCTO,
                            SYSDATE,    SYSDATE,    SYSDATE,    0,
                            AUX_NUM_FOLIO,  AUX_TOT_CUOTA,  Registro_Cheques(i).NUM_CUOTA,
                            NULL,   NULL    ); */

                    Monto_Acum := 0;
                    EXIT; -- LOOP Facturas
                END IF;
            END IF;
        END LOOP LOOP_FACTURAS;

                vp_ruteo := 48;
        vp_gls_error := 'Update Co_Cajas';
        UPDATE  CO_CAJAS  SET
                NUM_SECUMOV = vp_secumov + 1
        WHERE   COD_OFICINA = vp_cod_oficina
        AND     COD_CAJA = vp_cod_caja;
    END LOOP LOOP_CHEQUES7;

                --MEJORA PARA INSERTAR LOS REGISTROS DE LA CO_CUOTA_CONVENIO EN LA CO_CARTERA
                    m:=1;
                    FOR m IN Registro_Cheques.FIRST .. Registro_Cheques.LAST LOOP
               IF vp_tipo_convenio <> '1' THEN -- <> Pagari
                  vp_docum_carga := 59;
                  vp_ruteo := 50;
                  vp_gls_error := 'Select Co_Secartera';
                  SELECT  COUNT(1)
                  INTO    vp_existe
                  FROM     CO_SECARTERA
                  WHERE   COD_TIPDOCUM = vp_docum_carga
                  AND COD_VENDEDOR_AGENTE = vp_caja_agente_interno
                  AND LETRA = vp_caja_letra
                  AND COD_CENTREMI = TO_NUMBER(vp_caja_centremi)
                  --AND NUM_SECUENCI = vp_secuencia_cheque
                  AND NUM_SECUENCI = Registro_Cheques(m).SECUENCIA
                  AND COD_CONCEPTO = 1;

                    IF vp_existe > 0 THEN
                        vp_ruteo := 51;
                        vp_gls_error := 'Select Co_Secartera';
                        SELECT COLUMNA
                        INTO   vp_columna
                        FROM   CO_SECARTERA
                        WHERE  COD_TIPDOCUM = vp_docum_carga
                        AND       COD_VENDEDOR_AGENTE = vp_caja_agente_interno
                        AND       LETRA = vp_caja_letra
                        AND       COD_CENTREMI = TO_NUMBER(vp_caja_centremi)
                        --AND       NUM_SECUENCI = vp_secuencia_cheque
                        AND       NUM_SECUENCI = Registro_Cheques(m).SECUENCIA
                        AND       COD_CONCEPTO = 1;
                        IF vp_columna = 9999 THEN
                            vp_columna := 1;
                        ELSE
                            vp_columna := vp_columna + 1;
                        END IF;

                        vp_ruteo :=52;
                        vp_gls_error := 'Update Co_Secartera';
                        UPDATE CO_SECARTERA SET
                               COLUMNA = vp_columna
                        WHERE  COD_TIPDOCUM = vp_docum_carga
                        AND    COD_VENDEDOR_AGENTE = vp_caja_agente_interno
                        AND    LETRA = vp_caja_letra
                        AND    COD_CENTREMI = TO_NUMBER(vp_caja_centremi)
                        --AND    NUM_SECUENCI = vp_secuencia_cheque
                        AND    NUM_SECUENCI = Registro_Cheques(m).SECUENCIA
                        AND    COD_CONCEPTO = 1;
                    ELSE
                        vp_columna := 1;
                        vp_ruteo := 53;
                        vp_gls_error := 'Insert Co_Secartera-1';
                        INSERT INTO CO_SECARTERA
                                   (COD_TIPDOCUM,
                                    COD_VENDEDOR_AGENTE,
                                    LETRA,
                                    COD_CENTREMI,
                                    NUM_SECUENCI,
                                    COD_CONCEPTO,
                                    COLUMNA)
                        VALUES     (vp_docum_carga,
                                    vp_caja_agente_interno,
                                    vp_caja_letra,
                                    TO_NUMBER(vp_caja_centremi),
                                    --vp_secuencia_cheque,
                                    Registro_Cheques(m).SECUENCIA,
                                    1,
                                    vp_columna );
                    END IF;
                    IF vp_docum_carga = 5 THEN  /*Pagare*/       /*rbr*/
                        AUX_NUM_FOLIO := Registro_Cheques(m).NUM_PAGARE ;
                    ELSE
                        AUX_NUM_FOLIO := TO_NUMBER(Registro_Cheques(m).NUM_CHEQUE) ;
                    END IF;

                                   vp_gls_error := 'SELECT PREF_PLAZA FROM FROM GE_OPERPLAZA_TD A, ';
                                   SELECT PREF_PLAZA
                                   INTO AUX_PREF_PLAZA
                                   FROM GE_OPERPLAZA_TD A, GE_OPERADORA_SCL B , GE_DIRECCIONES C, GE_PLAZAS_TD D
                                   WHERE A.COD_OPERADORA_SCL = B.COD_OPERADORA_SCL AND A.COD_DIRECCION = C.COD_DIRECCION
                                   AND A.COD_PLAZA = D.COD_PLAZA AND A.COD_PLAZA = sCod_PlazaAbono;

                     vp_ruteo := 54;
                     vp_gls_error := 'Insert Co_cartera - 1';
                     INSERT INTO CO_CARTERA
                            (COD_CLIENTE    , COD_TIPDOCUM   ,  COD_CENTREMI  ,
                             NUM_SECUENCI   , COD_VENDEDOR_AGENTE,  LETRA     ,
                             COD_CONCEPTO   , COLUMNA        ,  COD_PRODUCTO  ,
                             IMPORTE_DEBE   , IMPORTE_HABER  ,  IND_CONTADO   ,
                             IND_FACTURADO  , FEC_EFECTIVIDAD, FEC_VENCIMIE   ,
                             FEC_CADUCIDA   , FEC_ANTIGUEDAD , FEC_PAGO       ,
                             NUM_ABONADO    , NUM_FOLIO      , PREF_PLAZA     ,
                             NUM_CUOTA      , SEC_CUOTA      , NUM_FOLIOCTC   ,
                             NUM_VENTA      , COD_OPERADORA_SCL, COD_PLAZA)
                     VALUES (vp_ClienteAsoc, vp_docum_carga, vp_caja_centremi,
                             --vp_secuencia_cheque, vp_caja_agente_interno, vp_caja_letra,
                             Registro_Cheques(m).SECUENCIA, vp_caja_agente_interno, vp_caja_letra,
                             1,  vp_columna, vp_ProdGeneral,
                             Registro_Cheques(m).IMPORTE_REAL,
                             0, 0,  1,
                             SYSDATE , Registro_Cheques(m).FECHA_VENCTO,
                             SYSDATE    , SYSDATE       , SYSDATE        ,
                             0          , AUX_NUM_FOLIO , AUX_PREF_PLAZA ,
                             AUX_TOT_CUOTA  , Registro_Cheques(m).NUM_CUOTA,   NULL, NULL ,sCod_OperadorAbono, sCod_PlazaAbono);
                     Monto_Acum := 0;
           ELSE  --PAGARE
                         vp_ruteo := 55;
                 vp_gls_error := 'Select Co_Secartera';
                 SELECT  COUNT(1)
                 INTO    vp_existe
                 FROM    CO_SECARTERA
                 WHERE   COD_TIPDOCUM = vp_docum_carga
                 AND     COD_VENDEDOR_AGENTE = vp_caja_agente_interno
                 AND     LETRA = vp_caja_letra
                 AND     COD_CENTREMI = vp_caja_centremi
                 --AND     NUM_SECUENCI = vp_secuencia_cheque
                 AND     NUM_SECUENCI = Registro_Cheques(m).SECUENCIA
                 AND     COD_CONCEPTO = 1;
                 IF vp_existe > 0 THEN
                     vp_ruteo := 56;
                     vp_gls_error := 'Select Co_Secartera';
                     SELECT COLUMNA
                     INTO   vp_columna
                     FROM   CO_SECARTERA
                     WHERE  COD_TIPDOCUM = vp_docum_carga
                     AND    COD_VENDEDOR_AGENTE = vp_caja_agente_interno
                     AND    LETRA = vp_caja_letra
                     AND    COD_CENTREMI = vp_caja_centremi
                     --AND    NUM_SECUENCI = vp_secuencia_cheque
                     AND    NUM_SECUENCI = Registro_Cheques(m).SECUENCIA
                     AND    COD_CONCEPTO = 1;
                     IF vp_columna = 9999 THEN
                         vp_columna := 1;
                     ELSE
                         vp_columna := vp_columna + 1;
                     END IF;

                     vp_ruteo := 57;
                     vp_gls_error := 'Update Co_Secartera';
                     UPDATE CO_SECARTERA
                     SET    COLUMNA = vp_columna
                     WHERE  COD_TIPDOCUM = vp_docum_carga
                     AND    COD_VENDEDOR_AGENTE = vp_caja_agente_interno
                     AND    LETRA = vp_caja_letra
                     AND    COD_CENTREMI = vp_caja_centremi
                     --AND    NUM_SECUENCI = vp_secuencia_cheque
                     AND    NUM_SECUENCI = Registro_Cheques(m).SECUENCIA
                     AND    COD_CONCEPTO = 1;
                 ELSE

                     vp_columna := 1;
                     vp_ruteo := 57;
                     vp_gls_error := 'Insert Co_Secartera-2';
                     INSERT INTO CO_SECARTERA
                                (COD_TIPDOCUM,
                                 COD_VENDEDOR_AGENTE,
                                 LETRA,
                                 COD_CENTREMI,
                                 NUM_SECUENCI,
                                 COD_CONCEPTO,
                                 COLUMNA)
                     VALUES     (vp_docum_carga,
                                 vp_caja_agente_interno,
                                 vp_caja_letra,
                                 vp_caja_centremi,
                                 --vp_secuencia_cheque,
                                 Registro_Cheques(m).SECUENCIA,
                                 1,
                                 vp_columna   );
                 END IF;
                 IF vp_docum_carga = 5 THEN  /* Pagare */     /*rbr*/
                     AUX_NUM_FOLIO := Registro_Cheques(m).NUM_PAGARE ;
                 ELSE
                     AUX_NUM_FOLIO := TO_NUMBER(Registro_Cheques(m).NUM_CHEQUE) ;
                 END IF;


                                 vp_gls_error := 'SELECT PREF_PLAZA FROM FROM GE_OPERPLAZA_TD A, ';
                                 SELECT PREF_PLAZA
                                 INTO AUX_PREF_PLAZA
                                 FROM GE_OPERPLAZA_TD A, GE_PLAZAS_TD D, GE_DIRECCIONES C, GE_OPERADORA_SCL B
                                 WHERE A.COD_OPERADORA_SCL = B.COD_OPERADORA_SCL AND C.COD_DIRECCION = A.COD_DIRECCION
                                 AND A.COD_PLAZA = D.COD_PLAZA AND A.COD_PLAZA = sCod_PlazaAbono;

                 vp_ruteo :=59;
                 vp_gls_error := 'Insert Co_Cartera - 2';
                 INSERT INTO CO_CARTERA
                        (COD_CLIENTE,   COD_TIPDOCUM,   COD_CENTREMI,   NUM_SECUENCI,
                         COD_VENDEDOR_AGENTE,    LETRA,  COD_CONCEPTO,   COLUMNA,
                         COD_PRODUCTO,   IMPORTE_DEBE,   IMPORTE_HABER,  IND_CONTADO,
                         IND_FACTURADO,  FEC_EFECTIVIDAD,    FEC_VENCIMIE,   FEC_CADUCIDA,
                         FEC_ANTIGUEDAD, FEC_PAGO,   NUM_ABONADO,    NUM_FOLIO, PREF_PLAZA,
                         NUM_CUOTA,  SEC_CUOTA,  NUM_FOLIOCTC,   NUM_VENTA, COD_OPERADORA_SCL, COD_PLAZA)
                 VALUES (vp_ClienteAsoc      ,  vp_docum_carga,
                         --vp_caja_centremi    ,   vp_secuencia_cheque,
                         vp_caja_centremi    ,   Registro_Cheques(m).SECUENCIA,
                         vp_caja_agente_interno, vp_caja_letra,
                         1,   vp_columna     ,   vp_ProdGeneral,
                         Registro_Cheques(m).IMPORTE_REAL,
                         0,  0,  1,  SYSDATE,    Registro_Cheques(m).FECHA_VENCTO,
                         SYSDATE,    SYSDATE,    SYSDATE,    0,
                         AUX_NUM_FOLIO,  AUX_PREF_PLAZA, AUX_TOT_CUOTA,  Registro_Cheques(m).NUM_CUOTA,
                         NULL,   NULL    ,sCod_OperadorAbono, sCod_PlazaAbono);
                      END IF;
         END LOOP;
                --

    IF vp_tipo_convenio = '1' THEN -- SI ES PagarE
       vp_gls_error := 'FEC_EFECTIVIDAD DE CO_CAJAS';
       SELECT TO_CHAR(FEC_EFECTIVIDAD,'YYYYMMDDHH24MI') INTO FECHAEFECTIVIDAD
       FROM   CO_CAJAS
       WHERE  COD_OFICINA= vp_cod_oficina
       AND    COD_CAJA   = TO_NUMBER(vp_cod_caja);

       /* insertar en Co_moviemientosCaja */
    vp_gls_error := 'Insert Co_movimientosCaja';
    INSERT INTO CO_MOVIMIENTOSCAJA
           (COD_OFICINA,     COD_CAJA,    NUM_SECUMOV,   NUM_EJERCICIO,    FEC_EFECTIVIDAD,
            NOM_USUARORA,    TIP_MOVCAJA, IND_DEPOSITO,   IMPORTE,       IND_ERRONEO,
            TIP_VALOR,       IND_CIERRE,    COD_CLIENTE,    TIP_DOCUMENT,   COD_VENDEDOR_AGENTE,
            LETRA,           COD_CENTREMI,  NUM_COMPAGO,PREF_PLAZA,    COD_BANCO,      NUM_CHEQUE,
            FEC_CHEQUE,   NUM_IDENT, COD_OPERADORA_SCL, COD_PLAZA)
    VALUES (vp_cod_oficina,  TO_NUMBER(vp_cod_caja), vp_secumov,  FECHAEFECTIVIDAD, SYSDATE,
            --SOPORTE
            --USUARIO ,  8,  0,  GE_PAC_GENERAL.REDONDEA(vp_ImporteConv + vp_InteresFinan, iDecimal, 0),
                    --Soporte 28/05/2003
            --USUARIO ,  8,  0,  GE_PAC_GENERAL.REDONDEA((vp_ImporteConv + vp_InteresFinan + vp_ImporteOpera + vp_ImporteCobr + vp_ImporteMora)- vp_ImporteCtdo , iDecimal, 0),
               --Soporte 29/10/2003 Se modifica Importe por concepto de Pagari.  Homologado 04-11-2003 SOP RyC. R.V.R.
            -- USUARIO ,  8,  0,  GE_PAC_GENERAL.REDONDEA((vp_ImporteConv + vp_ImporteOpera + vp_ImporteCobr + vp_ImporteMora)- vp_ImporteCtdo , iDecimal, 0),
               USUARIO ,  8,  0,  GE_PAC_GENERAL.REDONDEA(vp_ImporteConv, iDecimal, 0),
            0,  7,  0,  vp_ClienteAsoc, 8,  '100001',  'X',  1,  VP_NUM_COMPAGO,VP_NUM_FOLIOCOMP, vp_CodBanco,
            vp_NumPagare,    TO_DATE(vp_FechaConvenio,'DD-MM-YYYY'), vp_NumIdent, sCod_OperadorAbono, sCod_PlazaAbono);
    END IF;

    vp_ruteo := 49;
    vp_gls_error:='Actualizacisn de tabla co_convenios';
    UPDATE  CO_CONVENIOS
    SET     ESTADO_CONVENIO = 5
    WHERE   NUM_CONVENIO  = vp_Num_Movimiento;

    vp_ruteo := 60;
    vp_gls_error:='Actualizacisn de tabla co_pagos';
    IF vp_total_miscelanea > 0 THEN
       BEGIN
           UPDATE  CO_PAGOS SET
                IMP_PAGO = GE_PAC_GENERAL.REDONDEA(vp_total_miscelanea, iDecimal, 0)
           WHERE   NUM_SECUENCI = vp_numsec_pago
           AND     NUM_COMPAGO = vp_num_compago
           AND     PREF_PLAZA  =VP_NUM_FOLIOCOMP;

           UPDATE  CO_PAGOSCONC SET
                IMP_CONCEPTO = GE_PAC_GENERAL.REDONDEA(vp_total_miscelanea, iDecimal, 0)
           WHERE   NUM_SECUENCI = vp_numsec_pago
           AND     COD_TIPDOCUM = 8;
       END;
    ELSE
       BEGIN
           DELETE CO_PAGOS
           WHERE   NUM_SECUENCI = vp_numsec_pago
           AND     NUM_COMPAGO = vp_num_compago
           AND     PREF_PLAZA  = VP_NUM_FOLIOCOMP
           /*Soporte RyC CGLagos CH-200406301959 07-07-2004.*/
           /*AND     IMP_PAGO    = 0;*/
           AND     IMP_PAGO    >= 0;

           DELETE CO_PAGOSCONC
           WHERE   NUM_SECUENCI = vp_numsec_pago
           AND     COD_TIPDOCUM = 8;
       END;
    END IF;

    vp_ruteo := 50;
    vp_gls_error:='Actualizacion tabla Co_interfaz_caja a procesado';
    UPDATE CO_INTERFAZ_CAJA SET
           IND_PROCESADO = 1,
           NUM_SECUENCI_PAGO = vp_numsec_pago
    WHERE  NUM_INTERFAZ = TO_NUMBER(vp_Num_Interfaz);

    vp_ruteo := 0;
    vp_gls_error := 'Ok.';
    RAISE ERROR_PROCESO;

EXCEPTION
    WHEN ERROR_PROCESO THEN
        IF vp_ruteo != 0 THEN
            ROLLBACK;
        END IF;
        INSERT INTO CO_TRANSACINT (NUM_TRANSACCION, COD_RETORNO,DES_CADENA, MTO_INTERESES)
        VALUES (TO_NUMBER(vp_secuencia_co), vp_ruteo, vp_gls_error, 0);

    WHEN DUP_VAL_ON_INDEX THEN
        ROLLBACK;
        INSERT INTO CO_TRANSACINT (NUM_TRANSACCION, COD_RETORNO,DES_CADENA, MTO_INTERESES)
        VALUES (TO_NUMBER(vp_secuencia_co), vp_ruteo, vp_gls_error, 0);

    WHEN NO_DATA_FOUND THEN
        ROLLBACK;
        INSERT INTO CO_TRANSACINT (NUM_TRANSACCION, COD_RETORNO,DES_CADENA, MTO_INTERESES)
        VALUES (TO_NUMBER(vp_secuencia_co), vp_ruteo, vp_gls_error, 0);

    WHEN OTHERS THEN
        ROLLBACK;
        INSERT INTO CO_TRANSACINT (NUM_TRANSACCION, COD_RETORNO,DES_CADENA, MTO_INTERESES)
        VALUES (TO_NUMBER(vp_secuencia_co), vp_ruteo, vp_gls_error, 0);
                vp_gls_error:=SQLERRM;
END Co_P_Aplica_Convenio;
/
SHOW ERRORS