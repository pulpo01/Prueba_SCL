CREATE OR REPLACE PROCEDURE        CO_CALC_INTERMORO(
 vp_secuencia_co    IN VARCHAR2,
 vp_Cliente         IN VARCHAR2,
 vp_Folio           IN VARCHAR2,
 vp_Secuenci        IN VARCHAR2,
 vp_Docum           IN VARCHAR2,
 vp_Monto_Fact      IN VARCHAR2,
 /**vp_num_cuota       IN VARCHAR2,**/
 vp_sec_cuota       IN VARCHAR2
 ) IS
iDecimal            NUMBER(2);
usuario             VARCHAR2(30);
fecha               VARCHAR(10);
vp_error            NUMBER(2);
vp_factor_int       NUMBER(8,5);
vp_factor_dia       NUMBER(3);
vp_ind_fec_cobro    VARCHAR(1);
vp_dias_aplicacion  NUMBER(3);
vp_diasint          NUMBER(10);
vp_mon_deuda        NUMBER(14,4);
vp_mon_carrier      NUMBER(14,4);
vp_ind_facturado    NUMBER(1);
vp_cod_tipdocum     NUMBER(2);
vp_ejecuta_in       VARCHAR(2);
vp_val_int          NUMBER(14,4);
vp_val_cob          NUMBER(14,4);
vp_ruteo            NUMBER(2);
vp_cantidad         NUMBER(1);
vp_gls_error        VARCHAR2(255);
vp_pct_iva          NUMBER(8,2);
ERROR_PROCESO EXCEPTION;
BEGIN
        vp_gls_error := '';
        usuario := '';
        vp_val_cob := 0;
        vp_ruteo := 1;

        vp_gls_error := 'SELECT GE_PAC_DECIMALES.PARAM_GENERAL';
        SELECT GE_PAC_GENERAL.PARAM_GENERAL('num_decimal')
        INTO   iDecimal
        FROM   DUAL;

        vp_gls_error := 'Select usuario.';
        SELECT user, RTRIM(to_char(SYSDATE, 'dd-mm-yyyy')) INTO usuario, fecha
        FROM   DUAL;

        vp_ruteo := 9;
        vp_gls_error := 'Select fa_datosgener (PCT_IVA).';
        SELECT (PCT_IVA/100 ) + 1
        INTO   vp_pct_iva
        FROM   FA_DATOSGENER;

        vp_ruteo := 2;
        vp_gls_error := 'Select co_intereses.';
        SELECT FACTOR_INT, FACTOR_DIA, IND_FEC_COBRO, DIAS_APLICACION INTO
               vp_factor_int, vp_factor_dia, vp_ind_fec_cobro, vp_dias_aplicacion
        FROM   CO_INTERESES
        WHERE  TRUNC(SYSDATE) BETWEEN TRUNC(FEC_VIGENCIA_DD_DH)  AND    TRUNC(FEC_VIGENCIA_HH_DH);

        vp_ruteo := 3;
        vp_gls_error := vp_cliente || '-' || vp_docum || '-' || vp_secuenci || '-' || vp_folio;
        IF vp_ind_fec_cobro = 'F' then
           If vp_sec_cuota !='NULL' then
                SELECT TRUNC(SYSDATE) - (TRUNC(FEC_EFECTIVIDAD) + vp_dias_aplicacion),
                       SUM(IMPORTE_DEBE - IMPORTE_HABER), IND_FACTURADO, COD_TIPDOCUM
                INTO   vp_diasint, vp_mon_deuda, vp_ind_facturado, vp_cod_tipdocum
                FROM   CO_CARTERA
                WHERE  COD_CLIENTE = to_number(vp_Cliente)
                AND    COD_TIPDOCUM = to_number(vp_Docum)
                AND    NUM_SECUENCI = to_number(vp_Secuenci)
                AND    NUM_FOLIO = to_number(vp_Folio)
                AND    SEC_CUOTA  = to_number(vp_sec_cuota)
                GROUP BY FEC_EFECTIVIDAD, COD_TIPDOCUM, IND_FACTURADO;
           else
                SELECT TRUNC(SYSDATE) - (TRUNC(FEC_EFECTIVIDAD) + vp_dias_aplicacion),
                       SUM(IMPORTE_DEBE - IMPORTE_HABER), IND_FACTURADO, COD_TIPDOCUM
                INTO   vp_diasint, vp_mon_deuda, vp_ind_facturado, vp_cod_tipdocum
                FROM   CO_CARTERA
                WHERE  COD_CLIENTE = to_number(vp_Cliente)
                AND    COD_TIPDOCUM = to_number(vp_Docum)
                AND    NUM_SECUENCI = to_number(vp_Secuenci)
                AND    NUM_FOLIO = to_number(vp_Folio)
                AND    SEC_CUOTA  is NULL
                GROUP BY FEC_EFECTIVIDAD, COD_TIPDOCUM, IND_FACTURADO;
           end if;
        ELSE
           if  vp_sec_cuota !='NULL' then
                SELECT TRUNC(SYSDATE) - (TRUNC(FEC_VENCIMIE) + vp_dias_aplicacion),
                       SUM(IMPORTE_DEBE - IMPORTE_HABER), IND_FACTURADO, COD_TIPDOCUM
                INTO   vp_diasint, vp_mon_deuda, vp_ind_facturado, vp_cod_tipdocum
                FROM   CO_CARTERA
                WHERE  COD_CLIENTE = to_number(vp_Cliente)
                AND    COD_TIPDOCUM = to_number(vp_Docum)
                AND    NUM_SECUENCI = to_number(vp_Secuenci)
                AND    NUM_FOLIO = to_number(vp_Folio)
                AND    SEC_CUOTA  = to_number(vp_sec_cuota)
                GROUP BY FEC_VENCIMIE, COD_TIPDOCUM, IND_FACTURADO;
           else
                SELECT TRUNC(SYSDATE) - (TRUNC(FEC_VENCIMIE) + vp_dias_aplicacion),
                       SUM(IMPORTE_DEBE - IMPORTE_HABER), IND_FACTURADO, COD_TIPDOCUM
                INTO   vp_diasint, vp_mon_deuda, vp_ind_facturado, vp_cod_tipdocum
                FROM   CO_CARTERA
                WHERE  COD_CLIENTE = to_number(vp_Cliente)
                AND    COD_TIPDOCUM = to_number(vp_Docum)
                AND    NUM_SECUENCI = to_number(vp_Secuenci)
                AND    NUM_FOLIO = to_number(vp_Folio)
                AND    SEC_CUOTA  is NULL
                GROUP BY FEC_VENCIMIE, COD_TIPDOCUM, IND_FACTURADO;
           end if;
        END IF;

        If to_number(vp_Docum) > 47 Then
           If vp_ind_facturado = 1 Then
              vp_ejecuta_in := 'SI';
           Else
              vp_ejecuta_in := 'NO';
           End If;
        Else
           vp_ejecuta_in := 'SI';
        End If;

        IF vp_diasint > 0 And vp_ejecuta_in = 'SI' THEN
                vp_ruteo := 4;
                SELECT SUM(nvl(A.IMPORTE_DEBE,0) - nvl(A.IMPORTE_HABER, 0))
                INTO   vp_mon_carrier
                FROM   CO_CARTERA A, CO_CONCEPTOS B
                WHERE  A.COD_CLIENTE = to_number(vp_Cliente)
                AND    A.NUM_FOLIO = to_number(vp_Folio)
                AND    A.NUM_SECUENCI = to_number(vp_Secuenci)
                AND    A.COD_CONCEPTO = B.COD_CONCEPTO
                AND    B.COD_TIPCONCE = 4;

                vp_val_int := (to_number(vp_Monto_Fact));
                IF (vp_mon_deuda - vp_val_int) < vp_mon_carrier THEN
                    vp_val_int := vp_mon_deuda - vp_mon_carrier;
                END IF;
                vp_val_cob := (vp_val_int * (((vp_factor_int / vp_factor_dia) / 100) * vp_diasint))*vp_pct_iva;
        ELSE
                vp_val_cob := 0;
        END IF;
        vp_ruteo := 0;
        RAISE ERROR_PROCESO;
   EXCEPTION
      WHEN ERROR_PROCESO THEN
           if vp_ruteo != 0 then
                ROLLBACK;
           end if;
           INSERT INTO CO_TRANSACINT (NUM_TRANSACCION, COD_RETORNO, DES_CADENA, MTO_INTERESES)
           VALUES (TO_NUMBER(vp_secuencia_co), vp_ruteo, vp_gls_error, GE_PAC_GENERAL.REDONDEA(vp_val_cob, iDecimal, 0));
      WHEN DUP_VAL_ON_INDEX THEN
           ROLLBACK;
           INSERT INTO CO_TRANSACINT (NUM_TRANSACCION, COD_RETORNO, DES_CADENA, MTO_INTERESES)
           VALUES (TO_NUMBER(vp_secuencia_co), vp_ruteo, vp_gls_error, GE_PAC_GENERAL.REDONDEA(vp_val_cob, iDecimal, 0));
      WHEN NO_DATA_FOUND THEN
           ROLLBACK;
           INSERT INTO CO_TRANSACINT (NUM_TRANSACCION, COD_RETORNO, DES_CADENA, MTO_INTERESES)
           VALUES (TO_NUMBER(vp_secuencia_co), vp_ruteo, vp_gls_error, GE_PAC_GENERAL.REDONDEA(vp_val_cob, iDecimal, 0));
      WHEN OTHERS THEN
           ROLLBACK;
           INSERT INTO CO_TRANSACINT (NUM_TRANSACCION, COD_RETORNO, DES_CADENA, MTO_INTERESES)
           VALUES (TO_NUMBER(vp_secuencia_co), vp_ruteo, vp_gls_error, GE_PAC_GENERAL.REDONDEA(vp_val_cob, iDecimal, 0));
END CO_CALC_INTERMORO;
/
SHOW ERRORS
