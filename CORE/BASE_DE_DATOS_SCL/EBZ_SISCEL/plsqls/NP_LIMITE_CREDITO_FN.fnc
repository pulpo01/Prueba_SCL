CREATE OR REPLACE FUNCTION np_Limite_Credito_fn (pCodVendedor in ve_vendedores.COD_VENDEDOR%TYPE
 ) RETURN VARCHAR2

IS
-- Funcion que le obtiene cod Cliente,saldo Cta, cte, limite de crédito para un vendedor entregado
error_proceso EXCEPTION;
sFormatoSel2  ged_parametros.VAL_PARAMETRO%TYPE;
sFormatoSel7  ged_parametros.VAL_PARAMETRO%TYPE;
vSalida       varchar2(2000);
vCodCliente   GA_DIST_LCRED_TH.COD_CLIENTE%TYPE := -1;
vCodMoneda    GA_DIST_LCRED_TH.COD_MONEDA%TYPE := '-1';
vLimCredito   GA_DIST_LCRED_TH.MONTO_CREDITO%TYPE := -1;
vSaldoCtaCte  CO_CARTERA.importe_haber%type;
vNomUsuario   GA_DIST_LCRED_TH.NOM_USUARIO%TYPE:= '-1';
sFormatoFecha varchar2(25);
vFecDesde     varchar2(20);
nCant         number;
LN_count      number;
BEGIN

    vSaldoCtaCte:=NULL;

-- Selecciona Formatos Fecha
        SELECT val_parametro
        into  sFormatoSel2
        FROM GED_PARAMETROS
        WHERE cod_modulo = 'GE'
        AND cod_producto=1
        AND Nom_parametro = 'FORMATO_SEL2';
   IF SQLCODE <> 0 THEN
      vSalida := 'ERROR en búsqueda Formato de fechas';
      RAISE error_proceso;
   END IF;

-- Selecciona Fromatos Hora
        SELECT val_parametro
        into  sFormatoSel7
        FROM GED_PARAMETROS
        WHERE cod_modulo = 'GE'
        AND cod_producto=1
        AND Nom_parametro = 'FORMATO_SEL7';
   IF SQLCODE <> 0 THEN
      vSalida := 'ERROR en búsqueda Formato de Horas';
      RAISE error_proceso;
   END IF;

        sFormatoFecha := sFormatoSel2 || ' ' || sFormatoSel7;

-- Selecciona Datos Límite Crédito
        SELECT COUNT(*)
        INTO nCant
        FROM VE_VENDEDORES A, VE_TIPCOMIS B
        WHERE A.COD_TIPCOMIS = B.COD_TIPCOMIS
        AND B.IND_VTA_EXTERNA = '1'
        AND     A.COD_VENDEDOR = pCodVendedor;


   IF SQLCODE <> 0 THEN
      vSalida := 'ERROR np_Limite_Credito_fn, confirmando vendedor Tipo Dealer';
      RAISE error_proceso;
   END IF;
   IF nCant = 0 THEN
      vSalida := 'ERROR np_Limite_Credito_fn.Vendedor no existe en la tabla de vendedor o no es Tipo Dealer';
      RAISE error_proceso;
   END IF;

-- Selecciona Datos Límite Crédito
   SELECT A.COD_CLIENTE,A.COD_MONEDA,A.MONTO_CREDITO,A.NOM_USUARIO,TO_CHAR(A.FEC_DESDE,sFormatoFecha)
     INTO vCodCliente,vCodMoneda, vLimCredito,vNomUsuario,vFecDesde
     FROM GA_DIST_LCRED_TH A
    WHERE A.COD_VENDEDOR = pCodVendedor AND A.FEC_HASTA IS NULL;
    IF SQLCODE <> 0 THEN
      vSalida := 'ERROR np_Limite_Credito_fn, en consulta de límite de crédito';
      RAISE error_proceso;
    END IF;

   if vCodCliente is null then
          vCodCliente := -1;
   else
        --verifica si cliente es externo
        SELECT count(1) into LN_count
           FROM ge_clientes a, ve_vendedores b, ve_tipcomis c
          WHERE a.cod_cliente= vCodCliente
            AND a.cod_cliente = b.cod_cliente
            AND b.cod_tipcomis = c.cod_tipcomis
            AND c.ind_vta_externa = 1;

        IF SQLCODE <> 0 THEN
          vSalida := 'ERROR np_Limite_Credito_fn, confirmando cliente Tipo Dealer';
          RAISE error_proceso;
        END IF;


        IF LN_count > 0 then
           -- Selecciona saldo Cta Cte
           select nvl(sum(debe - haber),0)
                INTO vSaldoCtaCte
                From
                (select sum(a.importe_debe) debe,
                sum(a.importe_haber) haber
                from  co_cartera a,ge_tipdocumen g
                where a.cod_cliente = vCodCliente and  a.IND_FACTURADO < 2
                and  a.cod_tipdocum = g.cod_tipdocum
                UNION ALL
                select  sum(a.importe_debe) debe, sum(a.importe_haber) haber
                from co_cancelados a, ge_tipdocumen g
                where a.cod_cliente = vCodCliente
                and a.cod_tipdocum = g.cod_tipdocum);

               IF SQLCODE <> 0 THEN
                  vSalida := 'ERROR np_Limite_Credito_fn en consulta Saldo Cta Cte.';
                  RAISE error_proceso;
               END IF;

              if vSaldoCtaCte is null then
                 vSaldoCtaCte := 'SIN CUENTA CORRIENTE';
              end if;

         ELSE
              vSalida := 'ERROR np_Limite_Credito_fn. Cliente no existe en la tabla de vendedores o no es Tipo Dealer.';
              RAISE error_proceso;
         END IF;


   end if;
   vSalida := vCodCliente || ';' || vCodMoneda || ';' || vLimCredito || ';' || vFecDesde || ';' || vNomUsuario || ';' || vSaldoCtaCte;

   RETURN vSalida;

-- Control de errores
   EXCEPTION
   WHEN error_proceso THEN
      RETURN vSalida;
   WHEN NO_DATA_FOUND THEN
          if vCodCliente = -1 or vCodCliente IS NULL then
             vSalida := 'Distribuidor no existe en Tabla de límite de créditos';
             RETURN vSalida;
          end if;
          if vLimCredito = -1 or vLimCredito IS NULL then
             vSalida := 'Distribuidor no existe en Tabla de límite de créditos';
             RETURN vSalida;
          end if;
          if vSaldoCtaCte = -1 or vSaldoCtaCte IS NULL then
             vSalida := 'Distribuidor no existe en Tabla de Cuenta Corriente';
             RETURN vSalida;
          end if;
   WHEN OTHERS THEN
      vSalida := 'ERROR np_Limite_Credito_fn, SQLERRM : ' || SQLERRM;
      RETURN vSalida;
END;
/
