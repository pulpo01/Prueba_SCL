CREATE OR REPLACE PROCEDURE CO_APLICAPAGO_LIMITECONSUMO_PR (
    vp_Cod_cliente            IN NUMBER    ,
    vp_Imp_pago               IN NUMBER    ,
    vp_Fecha_efec             IN VARCHAR2  ,
    vp_Cod_banco              IN VARCHAR2  ,
    vp_OriPago                IN NUMBER    ,
    vp_CauPago                IN NUMBER    ,
    vp_Emp_recauda            IN VARCHAR2  ,
    vp_Oficina                IN VARCHAR2  ,
    vp_Cod_servicio           IN NUMBER    ,
    vp_Num_celular            IN NUMBER    ,
    vp_CtaCte                 IN VARCHAR2  ,
    vp_Num_transac            IN NUMBER    ,
    vp_Cod_Recext             IN NUMBER    ,
    vp_folioCTC               IN VARCHAR2  ,
    vp_num_ejer               IN VARCHAR2  ,
    vp_tip_valor              IN NUMBER    ,
    vp_num_docum              IN NUMBER    ,
    vp_caja                   IN NUMBER    ,
    vp_transaccion            IN NUMBER    ,
    vp_num_tarjeta            IN VARCHAR2  ,
    vp_num_folio              IN VARCHAR2  ,
    vp_sw_doc                 IN VARCHAR2  ,
    vp_fec_diferido           IN VARCHAR2  ,
    vp_sw_copago              IN VARCHAR2  ,
    vp_sw_tpago               IN VARCHAR2  ,
    vp_num_secuenci_ca        IN VARCHAR2  ,
    vp_cod_tipdocum_ca        IN VARCHAR2  ,
    vp_cod_vend_agente_ca     IN VARCHAR2  ,
    vp_letra_ca               IN VARCHAR2  ,
    vp_sec_cuota_ca           IN VARCHAR2  ,
    vp_importe_ca             IN VARCHAR2  ,
    vp_Secu_Compago           OUT NOCOPY NUMBER   ,
    vp_Pref_Plaza             IN OUT NOCOPY VARCHAR2 ,
    vp_Cod_Operacion          IN VARCHAR2   ,
    vp_OutGlosa               OUT NOCOPY VARCHAR2 ,
    vp_OutRetorno             OUT NOCOPY NUMBER,
    vp_CodPlanSrv             IN  VARCHAR2 default null,
    vp_codtiptarjeta          IN CO_INTERFAZ_PAGOS.COD_TIPTARJETA%TYPE DEFAULT NULL,
    vp_codautoriza            IN CO_INTERFAZ_PAGOS.COD_AUTORIZA%TYPE DEFAULT NULL
) IS
/*
<Documentación TipoDoc = "Procedimiento">
<Elemento Nombre = "CO_APLICAPAGO_LIMITECONSUMO_PR" Lenguaje="PL/SQL" Fecha="22-11-2006" Versión="1.0.0" Diseñador="Carlos Perez" Programador= Carlos Perez" Ambiente="BD">
<Retorno>NA</Retorno>
<Descripción>Descripción</Descripción>
<Parámetros>
    <Entrada>
        <param nom="vp_Cod_cliente"         Tipo="NUMBER">Codigo del cliente</param>
        <param nom="vp_Imp_pago"            Tipo="NUMBER">Monto del pago</param>
        <param nom="vp_Fecha_efec"          Tipo="STRING">Fecha efectividad del pago</param>
        <param nom="vp_Cod_banco"           Tipo="STRING">Codigo del banco</param>
        <param nom="vp_OriPago"             Tipo="NUMBER">Origen del pago</param>
        <param nom="vp_CauPago"             Tipo="NUMBER">Causa del pago</param>
        <param nom="vp_CauPago"             Tipo="NUMBER">Causa del pago</param>
        <param nom="vp_Emp_recauda"         Tipo="STRING">Codigo de la empresa recaudadora</param>
        <param nom="vp_Oficina"             Tipo="STRING">Codigo de la oficina</param>
        <param nom="vp_Cod_servicio"        Tipo="NUMBER">Codigo de servicio</param>
        <param nom="vp_Num_celular"         Tipo="NUMBER">Numero de celular</param>
        <param nom="vp_CtaCte"              Tipo="STRING">Numero de cuenta corriente</param>
        <param nom="vp_Num_transac"         Tipo="NUMBER">Numero de transaccion</param>
        <param nom="vp_Cod_Recext"          Tipo="NUMBER">Codigo de empresa de recaudacion externa</param>
        <param nom="vp_folioCTC"            Tipo="STRING">Numero de folio CTC</param>
        <param nom="vp_num_ejer"            Tipo="STRING">Numero de ejercicio</param>
        <param nom="vp_tip_valor"           Tipo="NUMBER">Tipo de valor</param>
        <param nom="vp_num_docum"           Tipo="NUMBER">Numero de documento</param>
        <param nom="vp_caja"                Tipo="NUMBER">Codigo de caja</param>
        <param nom="vp_transaccion"         Tipo="NUMBER">Codigo de transaccion del pago</param>
        <param nom="vp_num_tarjeta"         Tipo="STRING">Numero de tarjeta</param>
        <param nom="vp_num_folio"           Tipo="STRING">Numero de folio</param>
        <param nom="vp_sw_doc"              Tipo="STRING">switch. Identifica el tipo de documento</param>
        <param nom="vp_fec_diferido"        Tipo="STRING">Fecha del pago, si es pago diferido</param>
        <param nom="vp_sw_copago"           Tipo="STRING">switch. Identifica el comprobante de pago</param>
        <param nom="vp_sw_tpago"            Tipo="STRING">switch. Identifica el tipo de pago</param>
        <param nom="vp_num_secuenci_ca"     Tipo="STRING">Numero de secuencia del documento a cancelar</param>
        <param nom="vp_cod_tipdocum_ca"     Tipo="STRING">Tipo de documento del documento a cancelar</param>
        <param nom="vp_cod_vend_agente_ca"  Tipo="STRING">Codigo del vendedor del documento a cancelar</param>
        <param nom="vp_letra_ca"            Tipo="STRING">Letra del documento a cancelar</param>
        <param nom="vp_sec_cuota_ca"        Tipo="STRING">Secuencia de la cuota del documento a cancelar</param>
        <param nom="vp_importe_ca"          Tipo="STRING">Monto del documento a cancelar</param>
        <param nom="vp_Pref_Plaza"          Tipo="STRING">Prefijo Plaza</param>
        <param nom="vp_Cod_Operacion"       Tipo="STRING">Codigo de Operacion</param>
    </Entrada>
    <Salida>
        <param nom="vp_Secu_Compago"  Tipo="NUMBER">Secuencia del comprobante de pago</param>
        <param nom="vp_Pref_Plaza"    Tipo="STRING">Prefijo Plaza</param>
        <param nom="vp_OutGlosa"      Tipo="STRING">Glosa de retorno</param>
        <param nom="vp_OutRetorno"    Tipo="NUMBER">Valor de retorno</param>
    </Salida>
</Parámetros>
</Elemento>
</Documentación>
*/

/*****************************(I) NOMENCLATURA MODULOS GENERADORES DE PAGO ********************************/
/* Pago Electrónico        'PNT'                                              ********************************/
/*****************************(F) NOMENCLATURA MODULOS GENERADORES DE PAGO ********************************/

sDesc_empresa           CED_EMPRESAS.DES_EMPRESA%TYPE;
sNomCajero              CO_ACCECLI.NOM_USUARORA%TYPE;
sNom_User               CO_CAJEROS.NOM_USUARORA%TYPE;
dNumColumna             CO_CARTERA.COLUMNA%TYPE := 0;
dNumAuxColumna          CO_CARTERA.COLUMNA%TYPE;
lPref_Plaza             CO_CARTERA.PREF_PLAZA%TYPE;
lNum_Folio              CO_CARTERA.NUM_FOLIO%TYPE;
lPref_Plaza2            CO_CARTERA.PREF_PLAZA%TYPE;
dSaldoAux               CO_CARTERA.IMPORTE_DEBE%TYPE;
sCod_OperadorAbono      CO_CARTERA.COD_OPERADORA_SCL%TYPE;
sCod_PlazaAbono         CO_CARTERA.COD_PLAZA%TYPE;
v_folio_ctc             CO_CARTERA.NUM_FOLIOCTC%TYPE;
sNumSecuenciaDet        CO_DET_DOCUMENTOS.NUM_SECUENCI%TYPE;
sNumSecueChe            CO_DOCUMENTOS.NUM_SECUENCI%TYPE;
iDocumPago              CO_DATGEN.DOC_COMPAGO%TYPE;
iDoc_Pago               CO_DATGEN.DOC_PAGO%TYPE;
iDoc_LimConsumo         CO_DATGEN.DOC_RESPALDO%TYPE;
iDoc_Factcontado        CO_DATGEN.DOC_FACTCONTADO%TYPE;
iConcep_Pag             CO_DATGEN.CONCEP_PAG%TYPE;
iAgenteInterno          CO_DATGEN.AGENTE_INTERNO%TYPE;
sLetraCobros            CO_DATGEN.LETRA_COBROS%TYPE;
sCod_Oficina            CO_EMPRESAS_REX.COD_OFICINA%TYPE;
vp_Cod_Oficina            CO_EMPRESAS_REX.COD_OFICINA%TYPE;
sCod_Operadora            CO_EMPRESAS_REX.COD_OPERADORA_SCL%TYPE;
nSecuencia              CO_MOVIMIENTOSCAJA.NUM_SECUMOV%TYPE;
lSecCompago                CO_PAGOS.NUM_COMPAGO%TYPE;
lSec_Pago               CO_PAGOS.NUM_SECUENCI%TYPE;
lSec_PagoLimite               CO_PAGOS.NUM_SECUENCI%TYPE;
lSec_LimConsumo            CO_PAGOS.NUM_SECUENCI%TYPE;
hNumRegularizacion        CO_PAGO_DOC_REGULARIZA.NUM_REGULARIZA%TYPE;
sCod_Moneda             CO_TIPVALOR.COD_MONEDA%TYPE;
sNom_proceso            CO_TRANSAC_ERROR.NOM_PROCESO%TYPE;
lCod_cliente            GA_ABOCEL.COD_CLIENTE%TYPE;
sNumIdent                GE_CLIENTES.NUM_IDENT%TYPE;
sCod_tipident           GE_CLIENTES.COD_TIPIDENT%TYPE;
sCodProducto            GE_DATOSGENER.PROD_GENERAL%TYPE;
szVal_Param             GED_PARAMETROS.VAL_PARAMETRO%TYPE;
LN_cod_cliente          TOL_CLIENTE.COD_CLIENTE%TYPE;
LV_CodCiclo             TOL_CLIENTE.COD_CICLO%TYPE;
LD_FecIniVig            TOL_CLIENTE.FEC_INI_VIG%TYPE;
LV_CodPlan              TOL_CLIENTE.COD_PLAN%TYPE;
LV_CodBolsa             TOL_CLIENTE.COD_BOLSA%TYPE;
LD_FecTasa              TOL_CRONOGRAMA.FEC_TASA%TYPE;
LV_NomTabla             VARCHAR2(21);
--

CLIENTE_BLOQUEADO        EXCEPTION;
ERROR_PROCESO            EXCEPTION;
ERROR_CALC_LIMITECONS   EXCEPTION;
ERROR_MONTO_APLICADO    EXCEPTION;

    -- VARIABLES AUXILIARES
fec_pnt                    DATE;
vp_num_docum_pnt        NUMBER;
vp_imp_pago_aux            NUMBER;
vaux_num_cuota            NUMBER(8);
vaux_sec_cuota            NUMBER(3);
iDecimal                NUMBER(2);
dTotal_pago             NUMBER(14,4);
dSaldo                  NUMBER(14,4);
iPos1                   NUMBER(5);
iPos2                   NUMBER(5);
iPos3                   NUMBER(5);
iPos4                   NUMBER(5);
vp_oripago_aux          NUMBER;
vp_caupago_aux          NUMBER;
sFormatoFecha            VARCHAR2(20);
iCod_caja               VARCHAR2(4);
vp_num_tarjeta_aux_pnt  VARCHAR2(20);
vp_codtiptarjeta_aux_pnt co_interfaz_pagos.cod_tiptarjeta%TYPE;
vp_codautoriza_aux_pnt co_interfaz_pagos.cod_autoriza%TYPE;
vp_ctecorriente_aux_pnt VARCHAR2(18);
vp_cod_banco_pnt        VARCHAR2(3);
v_sqlcode               VARCHAR2(10);
v_sqlerrm               VARCHAR2(255);
vp_Gls_Error            VARCHAR2(255);
vp_mensaje                VARCHAR2(255);
vp_mensajeError            VARCHAR2(750);
sPasoFolio              VARCHAR2(150);
sPasoFolio2             VARCHAR2(150);
vp_emp_recauda_aux      VARCHAR2(40);
vp_emp_recauda_aux_tec  VARCHAR2(40);
vp_num_tarjeta_aux      VARCHAR2(20);
vp_ctecorriente_aux     VARCHAR2(18);
vp_tip_tarjeta_aux        VARCHAR2(3);
Fecha_Pago              VARCHAR2(20);
pref_plaza                VARCHAR2(11);
tec_letra                VARCHAR2(1);
dMto_Umbral                NUMBER(14,4);
dMto_Consumo            NUMBER(14,4);
iCod_Ciclo                NUMBER(2);
--
DATOS_SQL                 VARCHAR2(2500);
LN_largo                NUMBER(12);
LN_modulo               NUMBER(1);
LV_CodPlanSrv           VARCHAR2(3);
LV_ServicioBase         TOL_PAGO_LIMITE_TO.COD_PLAN%TYPE;
LV_limite               TOL_PAGO_LIMITE_TO.COD_LIMITE%TYPE;
LN_montoaplicado        NUMBER(14,4) := 0;

--

-- DECLARACION VARIABLES DURAS
-- GLOBALES
p_nop_consumo           NUMBER;
vp_uso                    NUMBER;
vcod_centremi            NUMBER;
vcod_forpago            NUMBER;
vcod_sispago            NUMBER;
vcod_producto            NUMBER;
vind_contado            NUMBER;
vind_facturado            NUMBER;
vnum_abonado            NUMBER;
vcod_centrrel            NUMBER;
vcod_ciclfact            NUMBER;
vnum_cargo                NUMBER;
vcod_moneda                CHAR(3);
-- PNT
vtip_movcaja            NUMBER;
vind_deposito            NUMBER;
vind_erroneo            NUMBER;
vind_cierre                NUMBER;
vefec_egreso            NUMBER;
vcod_tipdocum            NUMBER;
vnum_sec_cuota            NUMBER;
vind_titular            CHAR(1);
vcod_estado                CHAR(1);
vcod_ubicacion            CHAR(1);
vnum_cuota                NUMBER;
vsec_cuota                NUMBER;
vimporte_haber            NUMBER;
vcod_movimiento            NUMBER;
---
LV_Srv                  VARCHAR2(3);

-- DEFINICION CURSORES

i BINARY_INTEGER := 0;
TYPE TipRegCartera IS RECORD (
    DES_ABREVIADA            GE_TIPDOCUMEN.DES_TIPDOCUM%TYPE,
    COD_TIPDOCUM            CO_CARTERA.COD_TIPDOCUM%TYPE    ,
    COD_VENDEDOR_AGENTE        CO_CARTERA.COD_VENDEDOR_AGENTE%TYPE,
    LETRA                   CO_CARTERA.LETRA%TYPE,
    COD_CENTREMI            CO_CARTERA.COD_CENTREMI%TYPE,
    NUM_SECUENCI            CO_CARTERA.NUM_SECUENCI%TYPE,
    NUM_FOLIO               CO_CARTERA.NUM_FOLIO%TYPE,
    PREF_PLAZA              CO_CARTERA.PREF_PLAZA%TYPE,
    FEC_EFECTIVIDAD         VARCHAR2(10),
    FEC_VENCIMIE            VARCHAR2(10),
    NUM_VENTA               CO_CARTERA.NUM_VENTA%TYPE,
    IND_CONTADO             CO_CARTERA.IND_CONTADO%TYPE,
    SEC_CUOTA               CO_CARTERA.SEC_CUOTA%TYPE,
    IND_FACTURADO           CO_CARTERA.IND_FACTURADO%TYPE,
    NUM_CUOTA               CO_CARTERA.NUM_CUOTA%TYPE,
    SW                      VARCHAR2(2),
    MONTO                   NUMBER(18,4),
    COD_OPERADORA           CO_CARTERA.COD_OPERADORA_SCL%TYPE,
    COD_PLAZA               CO_CARTERA.COD_PLAZA%TYPE,
    COD_CONCEPTO               CO_CARTERA.COD_CONCEPTO%TYPE);
TYPE TipTab_CO_CARTERA       IS TABLE  OF  TipRegCartera INDEX BY  BINARY_INTEGER;
Tab_CARGA_CARTERA            TipTab_CO_CARTERA;

CURSOR LIMCONSUMO  IS
    SELECT COD_ABONADO
        FROM TOL_CLIENTE
     WHERE /*NUM_CELULAR = vp_Num_celular
       AND */ COD_CLIENTE = vp_Cod_cliente
       AND SYSDATE BETWEEN FEC_INI_VIG AND FEC_TER_VIG;

     /*SELECT NUM_ABONADO
         FROM GA_ABOCEL
        WHERE NUM_CELULAR = vp_Num_celular
          AND COD_CLIENTE = vp_Cod_cliente;*/

TYPE     DYNAMIC_CURSOR             IS REF CURSOR;
CO_CARTERA03                 DYNAMIC_CURSOR;

CURSOR TipoCursor IS
    SELECT /*+ INDEX (CO_CARTERA AK_CO_CARTERA_GE_CLIENTES) */
           B.DES_ABREVIADA                         DES_ABREVIADA,
           A.COD_TIPDOCUM                          COD_TIPDOCUM,
           A.COD_VENDEDOR_AGENTE                   COD_VENDEDOR_AGENTE,
           A.LETRA                                 LETRA,
           A.COD_CENTREMI                          COD_CENTREMI,
           A.NUM_SECUENCI                          NUM_SECUENCI,
           A.NUM_FOLIO                             NUM_FOLIO,
           A.PREF_PLAZA                            PREF_PLAZA,
           TO_CHAR(A.FEC_EFECTIVIDAD,'DD-MM-YYYY') FEC_EFECTIVIDAD,
           TO_CHAR(A.FEC_VENCIMIE,'DD-MM-YYYY')    FEC_VENCIMIE,
           NVL(A.NUM_VENTA,-1)                     NUM_VENTA,
           A.IND_CONTADO                           IND_CONTADO,
           NVL(A.SEC_CUOTA,-1)                     SEC_CUOTA,
           A.IND_FACTURADO                         IND_FACTURADO,
           NVL(A.NUM_CUOTA,-1)                     NUM_CUOTA,
           ''                                      SW,
           0                                       MONTO,
           A.COD_OPERADORA_SCL                     COD_OPERADORA,
           A.COD_PLAZA                             COD_PLAZA,
           A.COD_CONCEPTO                            COD_CONCEPTO
      FROM CO_CARTERA A, GE_TIPDOCUMEN B
     WHERE A.COD_TIPDOCUM = B.COD_TIPDOCUM;

rReg              TipoCursor%ROWTYPE;
LV_nomtablacodigo GED_CODIGOS.NOM_TABLA%TYPE := 'CO_TIPVALOR'; --MA-70067
LV_nomcolumna     GED_CODIGOS.NOM_COLUMNA%TYPE := 'TIP_VALOR'; --MA-70067
LN_contador       NUMBER := 0; --MA-70067 Si valor es 0 el tipo de valor no es válido.
LV_codvalor       GED_CODIGOS.COD_VALOR%TYPE;  --MA-70067
TIPVAL_NO_PARAM   EXCEPTION; --MA-70067
LV_primerregistro BOOLEAN := TRUE;

/**********************************************************************************************************************/
/*********************************************************************************************(F) DEFINICION CURSORES */
/**********************************************************************************************************************/
BEGIN
    vp_OutGlosa := '';
    vp_OutRetorno:=0;
    vp_emp_recauda_aux:=vp_emp_recauda;
    vp_oripago_aux:=vp_OriPago;
    vp_caupago_aux:=vp_CauPago;
    vp_num_tarjeta_aux:=vp_num_tarjeta;
    vp_ctecorriente_aux:=vp_CtaCte;
      sNom_proceso :='CO_APLICAPAGO_LIMITECONSUMO_PR Cliente: '||vp_Cod_cliente;

    -- INICIALIZACION VARIABLES DURAS
    sNumSecuenciaDet:=0;
    p_nop_consumo:=1;
    vp_uso:=0;
    vcod_centremi:=1;
    vcod_forpago:=0;
    vcod_sispago:=1;
    vcod_producto:=5;
    vind_contado:=0;
    vnum_abonado:=0;
    vcod_centrrel:=1;
    vcod_ciclfact:=0;
    vnum_cargo:=0;
    vcod_moneda:='001';

    vp_OutGlosa := 'Paso 1 recorrido PL';
    vp_OutRetorno:=-1;
    vp_oripago_aux:=11;
    vp_caupago_aux:=1;
    vtip_movcaja:=6;
    vind_deposito:=0;
    vind_erroneo:=0;
    vind_cierre:=0;
    vefec_egreso:=0;
    vcod_tipdocum:=59;
    vnum_sec_cuota:=1;
    vind_titular:='1';
    vcod_estado:='1';
    vcod_ubicacion:='1';
    vind_facturado:=4;
    vnum_cuota:=0;
    vsec_cuota:=0;

    vimporte_haber:=0;
    vcod_movimiento:=1;
    ---
    LV_Srv:='SRV';

    -- ASIGNACION DE VARIABLES POR MODULO PARTE 1
    IF (vp_fec_diferido IS NULL) THEN
        Fecha_Pago:=vp_Fecha_efec;
    ELSE
        Fecha_Pago:=vp_fec_diferido;
    END IF;

    IF ((vp_Cod_Operacion= '4') AND (vp_CodPlanSrv IS NULL))  THEN
         vp_OutGlosa := 'FALTA INGRESAR CODIGO DE PLAN DE SERVICIOS SUPLEMENTARIOS';
            vp_OutRetorno:=-1;
         RAISE ERROR_CALC_LIMITECONS;
    END IF;

    vp_OutGlosa := 'Select CO_EMPRESAS_REX';
    vp_OutRetorno:=-2;

    SELECT A.COD_OFICINA,    A.COD_CAJA,    B.NOM_USUARORA,    A.COD_OPERADORA_SCL
    INTO sCod_Oficina,iCod_caja,    sNom_User,    sCod_Operadora
    FROM CO_EMPRESAS_REX A, CO_CAJEROS B
    WHERE A.EMP_RECAUDADORA= vp_emp_recauda_aux
    AND A.COD_OFICINA         = B.COD_OFICINA
    AND A.COD_CAJA            = B.COD_CAJA;

    vp_Cod_Oficina:=sCod_Oficina;

    vp_OutGlosa := 'SELECT GE_PAC_DECIMALES.PARAM_GENERAL';
    vp_OutRetorno:=-3;
    iDecimal:= Ge_Pac_General.PARAM_GENERAL('num_decimal');

      vp_OutGlosa := 'Select CO_DATGEN.';
    vp_OutRetorno:=-4;
    SELECT 88, DOC_PAGO, DOC_COMPAGO, DOC_FACTCONTADO, CONCEP_PAG, AGENTE_INTERNO, LETRA_COBROS
    INTO iDoc_LimConsumo, iDoc_Pago , iDocumPago , iDoc_Factcontado, iConcep_Pag, iAgenteInterno, sLetraCobros
    FROM CO_DATGEN;

    vp_OutGlosa := 'SELECT PROD_GENERAL FROM GE_DATOSGENER.';
    vp_OutRetorno:=-5;
    SELECT PROD_GENERAL
    INTO sCodProducto
    FROM GE_DATOSGENER;

    vp_OutGlosa := 'SELECT FORMATO_SEL2 FROM GED_PARAMETROS.';
    vp_OutRetorno:=-8;
    SELECT VAL_PARAMETRO
    INTO sFormatoFecha
    FROM GED_PARAMETROS
    WHERE COD_MODULO='GE'
    AND COD_PRODUCTO=1
    AND NOM_PARAMETRO='FORMATO_SEL2';

    IF (vp_Cod_servicio=3) THEN
        BEGIN
            vp_OutGlosa := 'Select COD_CLIENTE Ga_abocel. Cliente : '||vp_Cod_cliente;
            vp_OutRetorno:=-9;

            SELECT COD_CLIENTE
            INTO lCod_cliente
            FROM GA_ABOCEL
            WHERE NUM_CELULAR  = vp_Num_celular ;

        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                BEGIN
                    vp_OutGlosa := 'Select Ga_intarcel. Cliente.';
                    vp_OutRetorno:=-10;

                    SELECT COD_CLIENTE
                    INTO lCod_cliente
                    FROM GA_INTARCEL
                    WHERE NUM_CELULAR = vp_num_celular
                    AND TO_DATE(vp_fecha_efec,sFormatoFecha||' HH24:MI:SS') BETWEEN FEC_DESDE AND FEC_HASTA;
                END;
        END;
    ELSE
        vp_OutGlosa := 'Select  UNIQUE COD_CLIENTE GE_CLIENTES.';
        vp_OutRetorno:=-11;

        SELECT UNIQUE COD_CLIENTE
        INTO lCod_cliente
        FROM GE_CLIENTES
        WHERE COD_CLIENTE = vp_Cod_cliente;
    END IF;

    -- ASIGNACION DE VARIABLES POR MODULO PARTE 2 */
    /**********************************************************************************************************************/
    BEGIN
        vp_OutGlosa := 'Paso 5 recorrido PL';
        vp_OutRetorno:=-12;

        SELECT NOM_USUARORA
        INTO sNomCajero
        FROM CO_ACCECLI
        WHERE COD_CLIENTE = lCod_Cliente
        AND FEC_INICIO > SYSDATE-1;

     EXCEPTION
        WHEN NO_DATA_FOUND THEN
        sNomCajero := NULL;
    END;

    BEGIN
        IF sNomCajero IS NOT NULL THEN /* Cliente bloqueado, no debe realizarce el pago */
            RAISE CLIENTE_BLOQUEADO;
        END IF;
    END;

    vp_OutGlosa := 'Select NUM_SECUMOV FROM COT_CAJAS_NT.';
    vp_OutRetorno:=-13;

    SELECT COS_SEQ_MOVCAJA.NEXTVAL
    INTO nSecuencia
    FROM DUAL ;

    vp_OutGlosa := 'SELECT COD_OPERADORA.';
    vp_OutRetorno:=-14;

    SELECT COD_OPERADORA
    INTO sCod_OperadorAbono
    FROM GE_CLIENTES
    WHERE COD_CLIENTE = lCod_cliente;

    vp_OutGlosa := 'Select CO_SEQ_PAGO.NEXTVAL(1).';
    vp_OutRetorno:=-15;

    SELECT CO_SEQ_PAGO.NEXTVAL
    INTO lSec_Pago
    FROM DUAL;

    vp_OutGlosa := 'select CO_SEQ_PAGO.NEXTVAL';
    vp_OutRetorno:=-16;

    SELECT CO_SEQ_PAGO.NEXTVAL
    INTO lSec_LimConsumo
    FROM DUAL;

    vp_OutGlosa := 'SELECT VAL_PARAMETRO.';
    vp_OutRetorno:=-17;

    SELECT VAL_PARAMETRO
    INTO szVal_Param
    FROM GED_PARAMETROS
    WHERE NOM_PARAMETRO = 'OFICINA_FOLIO'
    AND COD_MODULO='RE';

    vp_OutGlosa :='IF szVal_Param != "0" THEN';
     IF (szVal_Param != '0') THEN
        sCod_Oficina:=szVal_Param;
     /*ELSE
         IF (vp_Modulo_Usado!='PNT' AND vp_Modulo_Usado!='PEX') THEN
            vp_OutGlosa := 'Paso 6 recorrido PL';
            vp_OutRetorno:=-18;
            sCod_oficina :=vp_cod_oficina;
         END IF;*/
    END IF;

    /*
    IF vp_cod_oficina = 'NT' THEN
        vp_OutGlosa := 'Paso 6 recorrido PL';
        vp_OutRetorno:=-18;
        sCod_oficina :=vp_cod_oficina;
    END IF;
*/
    vp_OutGlosa := 'Fn_Obtiene_PlazaCliente(lCod_cliente)';
    vp_OutRetorno:=-19;
    sCod_PlazaAbono:=Fn_Obtiene_Plazacliente(lCod_cliente);

    vp_OutGlosa := 'FA_FOLIACION_PG.FA_CONSUME_FOLIO_FN';
    vp_OutRetorno:=-20;
    sPasoFolio:=Fa_Foliacion_Pg.FA_CONSUME_FOLIO_FN(iDoc_Pago,NULL,sCod_oficina,sCod_Operadora,NULL,NULL,NULL,SYSDATE,p_nop_consumo);

    iPos1             := INSTR(sPasoFolio,';',1);
    iPos2             := LENGTH(sPasoFolio) - iPos1;
    sPasoFolio2       := SUBSTR(sPasoFolio,iPos1 + 1, iPos2);
    iPos3             := INSTR(sPasoFolio2,';',1);
    iPos4             := INSTR(sPasoFolio2,';',1,2) - iPos3-1;
    IF iPos4 <= 0 THEN
        iPos4 := LENGTH(sPasoFolio2)- iPos3;
    END IF;

    lSecCompago     := SUBSTR(sPasoFolio2,iPos3 +1,iPos4);
    lPref_Plaza     := SUBSTR(sPasoFolio2,1,iPos3 - 1);
    dTotal_pago        := Ge_Pac_General.REDONDEA(vp_Imp_pago, iDecimal, vp_uso);
    vp_OutRetorno    := -21;
    vp_OutGlosa     := 'UPDATE COT_CAJAS_NT.';

    UPDATE COT_CAJAS_NT
    SET NUM_SECUMOV = nSecuencia
    WHERE COD_OFICINA = vp_Cod_Oficina
    AND COD_CAJA = iCod_caja
    AND NUM_EJERCICIO = vp_num_ejer;

    vp_OutRetorno:=-22;
    vp_OutGlosa := 'SELECT COD_MONEDA FROM CO_TIPVALOR';

    SELECT COD_MONEDA
    INTO sCod_Moneda
    FROM CO_TIPVALOR
    WHERE TIP_VALOR = vp_tip_valor;

/*    BEGIN
         vp_OutGlosa := 'SELECT GED_CODIGOS.';

        SELECT a.cod_valor
          INTO LV_codvalor
          FROM ged_codigos a
         WHERE a.nom_tabla = LV_nomtablacodigo
           AND a.nom_columna = LV_nomcolumna
           AND a.des_valor = TO_CHAR(vp_tip_valor);

        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                RAISE TIPVAL_NO_PARAM;
            WHEN OTHERS THEN
                  RAISE ERROR_PROCESO;
    END;*/

        --    IF LV_codvalor <> 'C' THEN --MA-70067
    IF (vp_tip_valor=1 OR vp_tip_valor=12 OR vp_tip_valor=3) THEN
        fec_pnt                    := SYSDATE;
        IF vp_tip_valor = 12 THEN
            vp_cod_banco_pnt:= vp_Cod_banco;
        ELSE
            vp_cod_banco_pnt:=NULL;
        END IF;        
        vp_ctecorriente_aux_pnt    := NULL;
        vp_num_tarjeta_aux_pnt    := vp_num_tarjeta_aux;
        vp_num_docum_pnt        := 0;
        vp_codtiptarjeta_aux_pnt := vp_codtiptarjeta;
        vp_codautoriza_aux_pnt := vp_codautoriza;
    ELSE
        IF (vp_tip_valor=4) THEN
        fec_pnt                    := SYSDATE;
        vp_cod_banco_pnt        := vp_cod_banco;
        vp_ctecorriente_aux_pnt    := vp_ctecorriente_aux;
        vp_num_tarjeta_aux_pnt    := NULL;
        vp_num_docum_pnt        := vp_num_docum;
        vp_codtiptarjeta_aux_pnt := NULL;
        vp_codautoriza_aux_pnt := NULL;
        END IF;
    END IF;

    IF (vp_tip_valor=1 OR vp_tip_valor=4 OR vp_tip_valor=12 OR vp_tip_valor=3 ) THEN
    --IF vp_tip_valor IS NOT NULL THEN
        --Fin MA-70067
        vp_OutRetorno:=-23;
        vp_OutGlosa := 'INSERT INTO CO_MOVIMIENTOSCAJA (1-12). Cliente : '||lCod_cliente;
        INSERT INTO CO_MOVIMIENTOSCAJA(
            COD_OFICINA,            COD_CAJA,                    NUM_SECUMOV,
                NUM_EJERCICIO,            FEC_EFECTIVIDAD,            NOM_USUARORA,
                TIP_MOVCAJA,             IND_DEPOSITO,                IMPORTE,
                IND_ERRONEO,             TIP_VALOR,                     IND_CIERRE,
                COD_CLIENTE,             NUM_ABONADO,                COD_PRODUCTO,
                TIP_DOCUMENT,             COD_VENDEDOR_AGENTE,        LETRA,
                COD_CENTREMI,             NUM_SECUENCI,                 LETRAC,
                COD_CENTRC,             NUM_SECUC,                     COD_BANCO,
                COD_SUCURSAL,             CTA_CORRIENTE,                 NUM_CHEQUE,
                TIP_CLEARING,             FEC_CHEQUE,                 COD_TIPTARJETA,
                NUM_TARJETA,             COD_AUTORIZA,                 NUM_CUPON,
                NUM_CUOTAS,             FEC_CUPON,                     COD_MOVILI,
                DES_MOVILI,             COD_RECOMPE,                 NOM_CUSTODIA,
                NUM_IDENT,                 NUM_ORDEN,                     FEC_EMISION,
                FEC_VENCIMIENTO,        COD_COBRADOR,                 NUM_INGMANUAL,
                NUM_RESPINGR,             COD_MONEDA,                 NUM_COMPAGO,
                PREF_PLAZA,             COD_OPERADORA_SCL,             COD_PLAZA)
         VALUES (
             vp_Cod_Oficina,            iCod_caja,                     nSecuencia,
            vp_num_ejer,             TO_DATE(vp_fecha_efec,sFormatoFecha||' HH24:MI:SS'), sNom_User,
            vtip_movcaja,            vind_deposito,                Ge_Pac_General.REDONDEA(vp_imp_pago, iDecimal, vp_uso),
            vind_erroneo,            vp_tip_valor,                vind_cierre,
            lCod_cliente,            NULL,                        NULL,
            iDoc_LimConsumo,        iAgenteInterno,             sLetraCobros,
            vcod_centremi,            lSec_Pago,                     NULL,
            NULL,                     NULL,                         vp_Cod_banco_pnt,
            NULL,                     vp_ctecorriente_aux_pnt,    vp_num_docum_pnt,
            NULL,                    fec_pnt,                    vp_codtiptarjeta_aux_pnt,
            vp_num_tarjeta_aux_pnt, vp_codautoriza_aux_pnt,                         NULL,
            NULL,                     NULL,                         NULL,
            NULL,                     NULL,                         NULL,
            NULL,                     NULL,                         NULL,
            NULL,                     NULL,                         NULL,
            NULL,                     sCod_Moneda,                 lSecCompago,
            lPref_Plaza,             sCod_OperadorAbono,            sCod_PlazaAbono);
    END IF;

            -- APLICACION DE PAGO
    IF (dTotal_pago>0 ) THEN
        IF (((vp_sw_doc=0) OR (vp_sw_copago=0))) THEN
            IF (vp_Cod_Operacion= '3') THEN
                vp_emp_recauda_aux_tec:='PAGO L.CONSUMO por '||vp_emp_recauda_aux;
            ELSE
                IF (vp_Cod_Operacion= '3') THEN
                    vp_emp_recauda_aux_tec:='PAGO L. CONSUMO SS por '||vp_emp_recauda_aux;
                ELSE
                    vp_emp_recauda_aux_tec:='PAGO L. CONSUMO PLAN ADIC por '||vp_emp_recauda_aux;
                END IF;
            END IF;

            vp_imp_pago_aux:=vp_Imp_pago;
            vp_OutRetorno:=-24;
            vp_OutGlosa := 'INSERT INTO CO_PAGOS.';

            INSERT INTO CO_PAGOS (
                COD_TIPDOCUM,            COD_VENDEDOR_AGENTE, LETRA,
                COD_CENTREMI,            NUM_SECUENCI,         COD_CLIENTE,
                IMP_PAGO,                FEC_EFECTIVIDAD,     COD_CAJA,
                FEC_VALOR,                NOM_USUARORA,         COD_FORPAGO,
                COD_SISPAGO,            COD_ORIPAGO,         COD_CAUPAGO,
                COD_BANCO,                COD_TIPTARJETA,         COD_SUCURSAL,
                CTA_CORRIENTE,            NUM_TARJETA,         DES_PAGO,
                NUM_COMPAGO,            PREF_PLAZA,             IND_REGULARIZA)
            VALUES (
                iDoc_LimConsumo,        iAgenteInterno,         sLetraCobros,
                vcod_centremi,            lSec_Pago,             lCod_cliente,
                Ge_Pac_General.REDONDEA(dTotal_pago, iDecimal, vp_uso),SYSDATE,    iCod_caja,
                TO_DATE(Fecha_Pago,sFormatoFecha||' HH24:MI:SS'),    sNom_User,    vcod_forpago,
                vcod_sispago,            vp_oripago_aux,         vp_caupago_aux,
                vp_cod_banco_pnt,         vp_tip_tarjeta_aux,     NULL,
                vp_ctecorriente_aux,    vp_num_tarjeta_aux,     vp_emp_recauda_aux_tec,
                lSecCompago,            lPref_Plaza,         hNumRegularizacion);
        END IF;

        IF (vp_cod_servicio=2 OR vp_cod_servicio=3)  THEN
            i:=0;
            vp_OutRetorno:=-25;
            vp_OutGlosa := 'Paso 7 recorrido PL';
            dSaldoAux:= 0;
        END IF;
    END IF;

    BEGIN
        vp_OutRetorno:=-26;
        vp_OutGlosa := 'SELECT  COD_CICLO FROM GE_CLIENTES.';

        SELECT COD_CICLO into iCod_Ciclo
          FROM GE_CLIENTES
         WHERE COD_CLIENTE=lCod_cliente;

        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                iCod_Ciclo:=0;
    END;

    FOR rReg IN LIMCONSUMO () LOOP
        BEGIN
            vp_OutRetorno:=-27;
            vp_OutGlosa := 'SELECT MONTO CONSUMO.';
            vnum_abonado:=rReg.COD_ABONADO;
            BEGIN
                BEGIN
                    SELECT a.cod_ciclo, MAX(a.fec_ini_vig), a.cod_plan, a.cod_bolsa
                    INTO LV_CodCiclo, LD_FecIniVig , LV_CodPlan, LV_CodBolsa
                    FROM tol_cliente a
                    WHERE a.cod_cliente = lCod_cliente
                    AND ((a.cod_abonado = 0) OR (a.cod_abonado=vnum_abonado))
                    AND SYSDATE BETWEEN fec_ini_vig AND fec_ter_vig
                    GROUP BY a.cod_ciclo, a.cod_plan, a.cod_bolsa;

                EXCEPTION
                    WHEN OTHERS THEN
                        vp_OutRetorno:=-28;
                        vp_OutGlosa := 'ERROR AL OBTENER CICLO';
                        RAISE ERROR_CALC_LIMITECONS;
                END;

                BEGIN
                    SELECT a.fec_tasa
                         INTO LD_FecTasa
                      FROM tol_cronograma a
                     WHERE a.cod_ciclo =LV_CodCiclo
                       AND a.est_proc ='ACTIV'
                       AND a.fec_inic <= SYSDATE
                       AND a.fec_term >= SYSDATE;

                    EXCEPTION
                        WHEN OTHERS THEN
                            vp_OutRetorno:=-28;
                            vp_OutGlosa := 'ERROR AL OBTENER FEC_TASA';
                            RAISE ERROR_CALC_LIMITECONS;
                END;
                BEGIN
                    LN_cod_cliente:= TO_CHAR(lCod_cliente);
                    LN_largo := LENGTH(LN_cod_cliente);

                    IF LN_largo  >= 2 THEN
                        LN_modulo := MOD(SUBSTR(LN_cod_cliente, LENGTH(LN_cod_cliente)-1,2), 10);
                    ELSIF LN_largo = 1 THEN
                        LN_modulo := LN_cod_cliente;
                    END IF;

                EXCEPTION
                        WHEN OTHERS THEN
                            vp_OutRetorno:=-28;
                            vp_OutGlosa := 'ERROR AL CALCULAR MODULO';
                            RAISE ERROR_CALC_LIMITECONS;
                END;

                BEGIN
                    DATOS_SQL:='';
                    IF (vp_Cod_Operacion= '3') THEN
                        -- para pago de limite de consumo por Plan Tarifario
                        DATOS_SQL:=DATOS_SQL||'    SELECT   1, (c.acu_consumo-c.acu_pagos) AS monto_pago, NULL, NULL ';
                        DATOS_SQL:=DATOS_SQL||'    FROM tol_cliente a, ga_limite_cliabo_to b, lc_acumula_0'||TO_CHAR(LN_modulo)||' c, lc_limites d, lc_umbral f ';
                        DATOS_SQL:=DATOS_SQL||'    WHERE a.cod_cliente = '||lCod_cliente;
                        IF (vnum_abonado>0) THEN
                            DATOS_SQL:=DATOS_SQL||'    AND a.cod_abonado = '||vnum_abonado;
                        END IF;
                        DATOS_SQL:=DATOS_SQL||'    AND SYSDATE BETWEEN a.fec_ini_vig AND a.fec_ter_vig';
                        DATOS_SQL:=DATOS_SQL||'    AND a.cod_plan = b.cod_plantarif ';
                        DATOS_SQL:=DATOS_SQL||'    AND b.cod_cliente = a.cod_cliente ';
                        DATOS_SQL:=DATOS_SQL||'    AND b.num_abonado = a.cod_abonado ';
                        DATOS_SQL:=DATOS_SQL||'    AND SYSDATE BETWEEN b.fec_desde AND NVL(b.fec_hasta , SYSDATE) ';
                        DATOS_SQL:=DATOS_SQL||'    AND c.cod_cliente = a.cod_cliente ';
                        DATOS_SQL:=DATOS_SQL||'    AND c.cod_abonado = a.cod_abonado ';
                        DATOS_SQL:=DATOS_SQL||'    AND c.fec_tasa = '||LD_FecTasa;
                        DATOS_SQL:=DATOS_SQL||'    AND c.cod_ciclo = '||LV_CodCiclo;
                        DATOS_SQL:=DATOS_SQL||'    AND c.cod_plan = a.cod_plan ';
                        DATOS_SQL:=DATOS_SQL||'    AND d.cod_limcons = b.cod_limcons ';
                        DATOS_SQL:=DATOS_SQL||'    AND d.cod_limcons = c.cod_limite';
                        DATOS_SQL:=DATOS_SQL||'    AND d.fec_desde = ( SELECT MAX(e.fec_desde) FROM lc_limites e WHERE e.cod_limcons = d.cod_limcons) ';
                        DATOS_SQL:=DATOS_SQL||'    AND f.cod_umbral = d.cod_umbral_min';
                        DATOS_SQL:=DATOS_SQL||'    AND SYSDATE BETWEEN f.fec_ini_vig AND f.fec_ter_vig';
                    ELSIF (vp_Cod_Operacion= '4') THEN
                        -- para pago de limite de consumo por Servicio Suplementario
                        IF (vnum_abonado>0) THEN
                            LV_NomTabla:=' GA_SERVSUPLABO ';
                        ELSE
                            LV_NomTabla:=' GA_SERVSUPLCLI_TO ';
                        END IF;

                        DATOS_SQL:=DATOS_SQL||' SELECT b.cod_plantarif,  ((f.mto_umbral*(c.acu_consumo-c.acu_pagos))/100) AS monto_pago, NULL, NULL ';
                        DATOS_SQL:=DATOS_SQL||'   FROM '||LV_NomTabla ||' a, gad_servsup_plan b, lc_acumula_0'||TO_CHAR(LN_modulo)||' c, lc_limites d, lc_umbral f,  ga_servsupl g,ta_plantarif h  ';
                        IF (vnum_abonado>0) THEN
                            DATOS_SQL:=DATOS_SQL||' WHERE a.num_abonado = '||vnum_abonado;
                        ELSE
                            DATOS_SQL:=DATOS_SQL||' WHERE a.cod_cliente = '||lCod_cliente;
                        END IF;
                           DATOS_SQL:=DATOS_SQL||' AND b.cod_servicio = ''' || vp_CodPlanSrv ||'''';
                         DATOS_SQL:=DATOS_SQL||' AND b.cod_producto = a.cod_producto  ';
                        DATOS_SQL:=DATOS_SQL||' AND b.cod_servicio = a.cod_servicio  ';
                        DATOS_SQL:=DATOS_SQL||' AND b.cod_producto = g.cod_producto  ';
                        DATOS_SQL:=DATOS_SQL||' AND b.cod_servicio = g.cod_servicio  ';
                        DATOS_SQL:=DATOS_SQL||' AND b.fec_desde <= ( SELECT MAX(g.fec_desde) ';
                        DATOS_SQL:=DATOS_SQL||'                        FROM gad_servsup_plan g ';
                        DATOS_SQL:=DATOS_SQL||'                       WHERE g.cod_producto = b.cod_producto ';
                        DATOS_SQL:=DATOS_SQL||' AND g.cod_servicio = b.cod_servicio)  ';
                        DATOS_SQL:=DATOS_SQL||' AND c.cod_cliente = '||lCod_cliente;
                        IF (vnum_abonado>0) THEN
                            DATOS_SQL:=DATOS_SQL||' AND c.cod_abonado = a.num_abonado ';
                        END IF;
                        DATOS_SQL:=DATOS_SQL||' AND c.fec_tasa = '||LD_FecTasa;
                        DATOS_SQL:=DATOS_SQL||' AND c.cod_ciclo = '||LV_CodCiclo;
                        DATOS_SQL:=DATOS_SQL||' AND c.cod_plan = b.cod_plantarif ';
                        DATOS_SQL:=DATOS_SQL||' AND a.cod_limcons = c.cod_limite ';
                        DATOS_SQL:=DATOS_SQL||' AND a.cod_limcons = d.cod_limcons ';
                        DATOS_SQL:=DATOS_SQL||' AND d.fec_desde <= ( SELECT MAX(e.fec_desde) ';
                        DATOS_SQL:=DATOS_SQL||'                        FROM lc_limites e ';
                        DATOS_SQL:=DATOS_SQL||'                       WHERE e.cod_limcons = d.cod_limcons) ';
                        DATOS_SQL:=DATOS_SQL||' AND f.cod_umbral = d.cod_umbral_min ';
                        DATOS_SQL:=DATOS_SQL||' AND b.cod_plantarif = h.cod_plantarif';
                        DATOS_SQL:=DATOS_SQL||' AND h.cla_plantarif = ''' || LV_Srv||'''';
                        DATOS_SQL:=DATOS_SQL||' AND B.TIP_RELACION =4 ';
                    ELSIF (vp_Cod_Operacion= '5') THEN
                        DATOS_SQL:=DATOS_SQL||' SELECT 1, (c.acu_consumo-c.acu_pagos) AS monto_pago, b.cod_servicio_base, c.cod_limite, ';
                        DATOS_SQL:=DATOS_SQL||' FROM pr_productos_contratados_to a,';
                        DATOS_SQL:=DATOS_SQL||' se_detalles_especificacion_to b,';
                        DATOS_SQL:=DATOS_SQL||' lc_acumula_0<Módulo del Cliente> c,';
                        DATOS_SQL:=DATOS_SQL||' lc_limites d, lc_umbral f,';
                        DATOS_SQL:=DATOS_SQL||' pf_productos_ofertados_td g';
                        DATOS_SQL:=DATOS_SQL||' WHERE a.num_abonado_contratante = ' ||vnum_abonado;
                        DATOS_SQL:=DATOS_SQL||' AND a.cod_cliente_contratante = '||lCod_cliente;
                        DATOS_SQL:=DATOS_SQL||' AND c.cod_cliente = '||lCod_cliente;
                        DATOS_SQL:=DATOS_SQL||' AND c.cod_abonado = ' ||vnum_abonado;
                        DATOS_SQL:=DATOS_SQL||' AND c.fec_tasa = '||LD_FecTasa;
                        DATOS_SQL:=DATOS_SQL||' AND c.cod_ciclo = '||LV_CodCiclo;
                        DATOS_SQL:=DATOS_SQL||' AND c.cod_plan    = b.cod_servicio_base ';
                        DATOS_SQL:=DATOS_SQL||' AND d.cod_limcons = c.cod_limite';
                        DATOS_SQL:=DATOS_SQL||' AND b.ind_tipo_servicio = ''TOL''';
                        DATOS_SQL:=DATOS_SQL||' AND a.cod_prod_ofertado = g.cod_prod_ofertado';
                        DATOS_SQL:=DATOS_SQL||' AND g.cod_espec_prod    = b.cod_espec_prod';
                        DATOS_SQL:=DATOS_SQL||' AND d.fec_desde <= (SELECT MAX(e.fec_desde) FROM lc_limites e WHERE e.cod_limcons = d.cod_limcons)';
                        DATOS_SQL:=DATOS_SQL||' AND f.cod_umbral = d.cod_umbral_min';
                        DATOS_SQL:=DATOS_SQL||' AND (c.acu_consumo-c.acu_pagos) > 0';
                        DATOS_SQL:=DATOS_SQL||' ORDER BY (c.acu_consumo-c.acu_pagos) DESC';
                    END IF;

                       /* MA 41252 - Soporte RyC CPalma 26/06/2007          */
                    OPEN CO_CARTERA03 FOR DATOS_SQL;
                        LOOP
                            FETCH CO_CARTERA03 INTO  LV_CodPlanSrv, dMto_Consumo, LV_ServicioBase, LV_limite ;
                            EXIT WHEN CO_CARTERA03%NOTFOUND;

                           --if dNumColumna = 0 THEN    Requerimiento de Soporte 150579
                                BEGIN
                                    vp_OutRetorno:=-29;
                                    vp_OutGlosa := 'SELECT  COLUMNA FROM CO_SECARTERA (1).';
                                    SELECT COLUMNA
                                      INTO dNumColumna
                                      FROM CO_SECARTERA
                                     WHERE COD_TIPDOCUM = iDoc_LimConsumo
                                       AND COD_VENDEDOR_AGENTE = iAgenteInterno
                                       AND LETRA = sLetraCobros
                                       AND COD_CENTREMI = vcod_centremi
                                       AND NUM_SECUENCI = lSec_LimConsumo
                                       AND COD_CONCEPTO = iConcep_Pag
                                    FOR UPDATE;

                                EXCEPTION
                                        WHEN NO_DATA_FOUND THEN
                                    dNumColumna:=0;
                                END;
                            --END IF;

                            dNumAuxColumna:=dNumColumna;
                            vp_OutRetorno:=-30;
                            lPref_Plaza2:=lPref_Plaza;

                            IF (dNumAuxColumna=0) THEN
                                vp_OutRetorno:=-31;
                                vp_OutGlosa := 'INSERT INTO CO_SECARTERA(1).';
                                BEGIN
                                    INSERT INTO CO_SECARTERA (
                                        COD_TIPDOCUM,COD_VENDEDOR_AGENTE,LETRA,COD_CENTREMI,NUM_SECUENCI,COD_CONCEPTO,COLUMNA)
                                    VALUES (
                                        iDoc_LimConsumo,iAgenteInterno,sLetraCobros,vcod_centremi,lSec_LimConsumo,iConcep_Pag,(dNumAuxColumna+1));

                                    dNumAuxColumna:=dNumAuxColumna+1;
                                    EXCEPTION
                                        WHEN OTHERS THEN
                                            RAISE ERROR_PROCESO;
                                END;
                            ELSE
                                IF (dNumAuxColumna=9999) THEN
                                    dNumAuxColumna:=1;
                                ELSE
                                     dNumAuxColumna:=dNumAuxColumna+1;
                                END IF;

                                vp_OutRetorno:=-32;
                                vp_OutGlosa := 'UPDATE CO_SECARTERA(1).';

                                UPDATE CO_SECARTERA
                                   SET COLUMNA = dNumAuxColumna
                                 WHERE COD_TIPDOCUM = iDoc_LimConsumo
                                   AND COD_VENDEDOR_AGENTE = iAgenteInterno
                                   AND LETRA = sLetraCobros
                                   AND COD_CENTREMI = vcod_centremi
                                   AND NUM_SECUENCI = lSec_LimConsumo
                                   AND COD_CONCEPTO = iConcep_Pag;
                            END IF;

                            v_folio_ctc:=NULL;

                            dSaldoAux:=0;
                            vp_OutRetorno:=-33;
                            vp_OutGlosa := 'INSERTA ABONO EN CO_CARTERA. Cliente : '||lCod_cliente;

                            IF LN_montoaplicado + dMto_Consumo > vp_Imp_pago THEN
                                dMto_Consumo := vp_Imp_pago - LN_montoaplicado;
                            END IF;

                            LN_montoaplicado := LN_montoaplicado +  dMto_Consumo;

                            BEGIN
                                lNum_Folio:=lSec_LimConsumo;
                                INSERT INTO CO_CARTERA(
                                    COD_CLIENTE,    COD_TIPDOCUM,    COD_CENTREMI,    NUM_SECUENCI,    COD_VENDEDOR_AGENTE,LETRA,
                                      COD_CONCEPTO,    COLUMNA,        COD_PRODUCTO,      IMPORTE_DEBE,    IMPORTE_HABER,        IND_CONTADO,
                                      IND_FACTURADO,    FEC_EFECTIVIDAD,FEC_VENCIMIE,    FEC_CADUCIDA,    FEC_ANTIGUEDAD,        FEC_PAGO,
                                     NUM_ABONADO,    NUM_FOLIO,        PREF_PLAZA,        NUM_CUOTA,        SEC_CUOTA,            NUM_FOLIOCTC,
                                    NUM_VENTA,        COD_OPERADORA_SCL,    COD_PLAZA)
                                   VALUES(
                                       lCod_cliente,    iDoc_LimConsumo,    vcod_centremi,    lSec_LimConsumo,iAgenteInterno,    sLetraCobros,
                                       iConcep_Pag,    dNumAuxColumna,    vcod_producto,    Ge_Pac_General.REDONDEA(dSaldoAux, iDecimal, vp_uso),
                                       Ge_Pac_General.REDONDEA(dMto_Consumo, iDecimal,vp_uso), vind_contado,vind_facturado,    SYSDATE,
                                       TO_DATE(vp_Fecha_efec,sFormatoFecha||' HH24:MI:SS'),TO_DATE(vp_Fecha_efec,sFormatoFecha||' HH24:MI:SS'),
                                       TO_DATE(vp_Fecha_efec,sFormatoFecha||' HH24:MI:SS'), SYSDATE,vnum_abonado, lNum_Folio ,lPref_Plaza2,
                                       --Soporte RyC CGLagos Inc. 87004 22-04-2009
                                    --vaux_num_cuota,vaux_sec_cuota,v_folio_ctc,NULL,sCod_OperadorAbono,sCod_PlazaAbono);
                                    vnum_cuota, vsec_cuota,v_folio_ctc,NULL,sCod_OperadorAbono,sCod_PlazaAbono);
                                EXCEPTION
                                    WHEN OTHERS THEN
                                        RAISE ERROR_PROCESO;
                            END;

                            dSaldoAux:=TO_NUMBER(dTotal_pago);
                            vp_OutRetorno:=-34;
                            vp_OutGlosa := 'INSERTA REGISTRO EN TOL_PAGO_LIMITE_TO. Cliente : '||lCod_cliente;

                            BEGIN
                                IF (vp_Cod_Operacion= '4') THEN
                                    LV_CodPlan:= LV_CodPlanSrv;
                                END IF;
                                IF LV_primerregistro THEN
                                    lSec_PagoLimite := lSec_Pago;
                                    LV_primerregistro := FALSE;
                                ELSE
                                    SELECT CO_SEQ_PAGO.NEXTVAL
                                      INTO lSec_PagoLimite
                                      FROM DUAL;
                                END IF;

                                INSERT INTO TOL_PAGO_LIMITE_TO(
                                    COD_TIPDOCUM,        NUM_SECUENCI,    COD_CLIENTE,              COD_ABONADO,
                                    COD_MOVIMIENTO,        IMP_PAGO,        FEC_EFECTIVIDAD,        FEC_VALOR,
                                    NOM_USUARORA,         DES_PAGO,         COD_CICLO,                 COD_OPERADORA,
                                    PREF_PLAZA,         NUM_COMPAGO,    COD_PLAN, COD_LIMITE )
                                VALUES(
                                    iDoc_LimConsumo,     lSec_PagoLimite,       lCod_cliente,     vnum_abonado,
                                    vcod_movimiento,     dMto_Consumo,            SYSDATE,        SYSDATE,
                                    sNom_User,           vp_emp_recauda_aux_tec,    iCod_Ciclo,     sCod_OperadorAbono,
                                    lPref_Plaza2,        lSecCompago,            LV_ServicioBase, LV_limite);

                                EXCEPTION
                                    WHEN OTHERS THEN
                                        RAISE ERROR_PROCESO;
                            END;
                            vp_OutRetorno:=-35;
                            vp_OutGlosa := 'INSERTA ABONO EN PAGOSCONC. Cliente : '||lCod_cliente;
                            BEGIN
                                INSERT INTO CO_PAGOSCONC(
                                    COD_TIPDOCUM,         COD_CENTREMI,         NUM_SECUENCI,         COD_VENDEDOR_AGENTE,     LETRA,
                                    IMP_CONCEPTO,         COD_PRODUCTO,        COD_TIPDOCREL,         COD_AGENTEREL,             LETRA_REL,
                                    COD_CENTRREL,         NUM_SECUREL,         COD_CONCEPTO,         COLUMNA,                 NUM_ABONADO,
                                     NUM_FOLIO,             PREF_PLAZA,         NUM_CUOTA,             SEC_CUOTA,                 NUM_FOLIOCTC,
                                     COD_OPERADORA_SCL,    COD_PLAZA,            NUM_VENTA)
                                   VALUES(
                                       iDoc_LimConsumo,    vcod_centremi,         lSec_Pago,            iAgenteInterno,            sLetraCobros,
                                       dMto_Consumo,        vcod_producto,        iDoc_LimConsumo,    iAgenteInterno,         sLetraCobros,
                                       vcod_centremi,         lSec_LimConsumo,    iConcep_Pag,         dNumAuxColumna,         vnum_abonado,
                                       lNum_Folio,         lPref_Plaza2,         vnum_cuota,         vsec_cuota,                v_folio_ctc,
                                       sCod_OperadorAbono,    sCod_PlazaAbono,    NULL);

                            EXCEPTION
                                    WHEN OTHERS THEN
                                        RAISE ERROR_PROCESO;
                            END;

                        END LOOP;
                    CLOSE CO_CARTERA03;
                     /* MA 41252 - Soporte RyC CPalma 26/06/2007          */

                EXCEPTION
                        WHEN NO_DATA_FOUND THEN
                            dMto_Umbral:=0;
                            dMto_Consumo:=0;
                END;

            END;

         END;

    END  LOOP;

    IF LN_montoaplicado != vp_imp_pago THEN
        vp_OutRetorno:=-37;
        vp_OutGlosa := 'No se pudo aplicar monto del Pago.  Monto Pago = ' || vp_imp_pago || ', Monto que se podia aplicar = ' || LN_montoaplicado ;
        RAISE ERROR_MONTO_APLICADO;
    END IF;

    IF ( vp_tip_valor=4 ) THEN

        BEGIN
            vp_OutGlosa := 'SELECT A.NUM_IDENT FROM GE_CLIENTES A, GE_TIPIDENT B. Cliente :'||lCod_cliente;
            SELECT A.NUM_IDENT,A.COD_TIPIDENT
            INTO sNumIdent,sCod_tipident
            FROM GE_CLIENTES A, GE_TIPIDENT B
            WHERE A.COD_CLIENTE = lCod_cliente
            AND A.COD_TIPIDENT = B.COD_TIPIDENT;

            vp_OutGlosa := 'SELECT CO_SEQ_PAGOCHEQUE.NEXTVAL FROM DUAL.';
            SELECT CO_SEQ_PAGOCHEQUE.NEXTVAL
            INTO sNumSecueChe
            FROM DUAL;

            vp_OutGlosa := 'INSERT INTO CO_DOCUMENTOS. Secuenci cheque : '||sNumSecueChe;
            INSERT INTO CO_DOCUMENTOS (
                    NUM_SECUENCI      , COD_TIPDOCUM    , NUM_SEC_CUOTA,
                     COD_TIPVALOR      , NUM_CONVENIO    , NUM_DOCUMENTO,
                     COD_OFICINA       , COD_CAJA        , NUM_SECUMOV,
                     COD_BANCO         , COD_SUCURSAL    , COD_PLAZA,
                     CTA_CORRIENTE     , COD_AUTORIZACION, IND_TITULAR,
                     NUM_IDENT         , IMPORTE_DOCUM   , FECHA_VENCTO,
                     FECHA_DEPOSITO    , NUN_DEPOSITO    , COD_BANCO_DEPO,
                     COD_SUCURSAL_DEPO , COD_PLAZA_DEPO  , CTA_CORRIENTE_DEPO,
                     COD_ESTADO        , COD_PROTESTO    , COD_UBICACION,
                     FEC_ULT_MOVIMIENTO, NOM_USUARIO     , COD_OPERADORA_SCL,
                     COD_PLAZA_OP      , COD_TIPIDENT    )
            VALUES (
                    sNumSecueChe      , vcod_tipdocum   , vnum_sec_cuota,
                     vp_tip_valor      , NULL            , vp_num_docum,
                     vp_Cod_Oficina    , icod_caja       , nSecuencia,
                     vp_Cod_banco      , NULL            , NULL,
                     vp_ctecorriente_aux,NULL            , vind_titular,
                     sNumIdent         , Ge_Pac_General.REDONDEA(vp_imp_pago, iDecimal, vp_uso),
                    TO_DATE(vp_fecha_efec,sFormatoFecha||' HH24:MI:SS'),
                     NULL              , NULL            , NULL,
                    NULL              , NULL            , NULL,
                       vcod_estado       , NULL            , vcod_ubicacion,
                    SYSDATE           , sNom_User       , sCod_OperadorAbono,
                     sCod_PlazaAbono   , sCod_tipident   );

            i:=Tab_CARGA_CARTERA.LAST;
            IF i>0 THEN
                i:=1;
                FOR i IN Tab_CARGA_CARTERA.FIRST .. Tab_CARGA_CARTERA.LAST LOOP
                        sNumSecuenciaDet:=sNumSecuenciaDet + 1;
                        vp_OutGlosa := 'INSERT INTO CO_DET_DOCUMENTOS (2). Cliente :'||lCod_cliente;
                        INSERT INTO CO_DET_DOCUMENTOS(
                            NUM_SECUENCI,        NUM_DOCUMENTO,            NUM_SECUENCI_DOC,
                            COD_CLIENTE,        NUM_SECUENCI_PAGO,        NUM_SECUENCI_CA,
                            COD_TIPDOCUM_CA,    COD_VEND_AGENTE_CA,        LETRA_CA,
                            NUM_FOLIO_CA,        PREF_PLAZA,                NUM_CUOTA_CA,
                            SEC_CUOTA_CA,        IMPORTE_CA)
                        VALUES (
                            sNumSecuenciaDet,                     vp_num_docum,                                sNumSecueChe,
                            lCod_cliente,                        lSec_Pago,                                    Tab_CARGA_CARTERA(i).NUM_SECUENCI,
                            Tab_CARGA_CARTERA(i).COD_TIPDOCUM,     Tab_CARGA_CARTERA(i).COD_VENDEDOR_AGENTE,     Tab_CARGA_CARTERA(i).LETRA,
                            Tab_CARGA_CARTERA(i).NUM_FOLIO,     Tab_CARGA_CARTERA(i).PREF_PLAZA,             Tab_CARGA_CARTERA(i).NUM_CUOTA,
                            Tab_CARGA_CARTERA(i).SEC_CUOTA,        Tab_CARGA_CARTERA(i).MONTO);
                END LOOP;
            END IF;

            BEGIN
                vp_OutGlosa := 'SELECT  COLUMNA FROM CO_SECARTERA (2).';
                SELECT COLUMNA
                  INTO dNumColumna
                  FROM CO_SECARTERA
                 WHERE COD_TIPDOCUM            = vcod_tipdocum
                   AND COD_VENDEDOR_AGENTE     = iAgenteInterno
                   AND LETRA                 = sLetraCobros
                   AND COD_CENTREMI         = vcod_centremi
                   AND NUM_SECUENCI         = sNumSecueChe
                   AND COD_CONCEPTO         = iConcep_Pag
                FOR UPDATE;

                EXCEPTION
                    WHEN NO_DATA_FOUND THEN
                        dNumColumna:=0;
            END;

            IF dNumColumna = 9999 THEN
                dNumAuxColumna := 1;
            ELSE
                dNumAuxColumna := dNumColumna + 1;
            END IF;

            IF (dNumColumna>0) THEN
                BEGIN
                    vp_OutGlosa := 'UPDATE CO_SECARTERA (2).';
                    UPDATE CO_SECARTERA
                       SET COLUMNA = dNumAuxColumna
                     WHERE COD_TIPDOCUM         = vcod_tipdocum
                       AND COD_VENDEDOR_AGENTE     = iAgenteInterno
                       AND LETRA                 = sLetraCobros
                       AND COD_CENTREMI         = vcod_centremi
                       AND NUM_SECUENCI         = sNumSecueChe
                       AND COD_CONCEPTO         = iConcep_Pag;
                END;
            ELSE
                BEGIN
                    vp_OutGlosa := 'INSERT INTO CO_SECARTERA(2).';
                    INSERT INTO CO_SECARTERA(
                        COD_TIPDOCUM, COD_VENDEDOR_AGENTE,    LETRA,
                        COD_CENTREMI, NUM_SECUENCI,    COD_CONCEPTO, COLUMNA)
                    VALUES(
                        vcod_tipdocum,    iAgenteInterno,    SLetraCobros,
                        vcod_centremi, SNumSecueChe, iConcep_Pag, dNumColumna+1);
                END;
            END IF;

            vp_OutGlosa := 'INSERT CHEQUE INTO CO_CARTERA (2). Cliente :'||lCod_cliente;
            IF vnum_cuota IS NULL THEN
                vnum_cuota := 0;
            END IF;
            IF vsec_cuota IS NULL THEN
                   vsec_cuota := 0;
            END IF;

            INSERT INTO CO_CARTERA(
                COD_CLIENTE,    COD_TIPDOCUM,        COD_CENTREMI,
                NUM_SECUENCI,    COD_VENDEDOR_AGENTE,LETRA,
                COD_CONCEPTO,    COLUMNA,            COD_PRODUCTO,
                IMPORTE_DEBE,    IMPORTE_HABER,        IND_CONTADO,
                IND_FACTURADO,    FEC_EFECTIVIDAD,    FEC_VENCIMIE,
                FEC_CADUCIDA,    FEC_ANTIGUEDAD,        FEC_PAGO,
                NUM_ABONADO,    NUM_FOLIO,            PREF_PLAZA,
                NUM_CUOTA,        SEC_CUOTA,            NUM_FOLIOCTC,
                NUM_VENTA,        COD_OPERADORA_SCL,    COD_PLAZA)
            VALUES(
                lCod_cliente,    vcod_tipdocum,    vcod_centremi,
                sNumSecueChe,    iAgenteInterno,    sLetraCobros,
                iConcep_Pag,    dNumColumna,    sCodProducto,
                Ge_Pac_General.REDONDEA(vp_imp_pago, iDecimal, vp_uso), vimporte_haber,    vind_contado,
                vind_facturado, TO_DATE(vp_fecha_efec,sFormatoFecha||' HH24:MI:SS'), TO_DATE(vp_fecha_efec,sFormatoFecha||' HH24:MI:SS'),
                TO_DATE(vp_fecha_efec,sFormatoFecha||' HH24:MI:SS'),    TO_DATE(vp_fecha_efec,sFormatoFecha||' HH24:MI:SS'), TO_DATE(vp_fecha_efec,sFormatoFecha||' HH24:MI:SS'),
                vnum_abonado,    vp_num_docum,        NULL,
                vnum_cuota,        vsec_cuota,            NULL,
                NULL,            sCod_OperadorAbono,    sCod_PlazaAbono);
        END;
    END IF;

    vp_OutRetorno:=-36;
    vp_OutGlosa := 'UPDATE CO_INTERFAZ_PAGOS. Num_transaccion :'||vp_transaccion;
    UPDATE CO_INTERFAZ_PAGOS
    SET NUM_COMPAGO= lSecCompago,
    PREF_PLAZA = lPref_Plaza,
    COD_ESTADO = 'PRO'
    WHERE EMP_RECAUDADORA  = vp_emp_recauda
    AND COD_CAJA_RECAUDA = vp_caja
    AND FEC_EFECTIVIDAD  = TO_DATE(vp_Fecha_efec,sFormatoFecha||' HH24:MI:SS')
    AND NUM_TRANSACCION  = vp_transaccion
    AND TIP_TRANSACCION  = 'K';

    vp_OutRetorno:=1;
    vp_OutGlosa  :='OK';

    EXCEPTION
        WHEN ERROR_MONTO_APLICADO THEN
            vp_Gls_Error:=vp_OutGlosa;
            ROLLBACK;
            vp_OutRetorno := -1;
             v_sqlcode := SQLCODE;
             v_sqlerrm := 'CLIENTE : '||lCod_cliente;
             INSERT INTO CO_TRANSAC_ERROR (
                 NOM_PROCESO, COD_RETORNO, FEC_PROCESO,DESC_SQL,DESC_CADENA)
              VALUES (
                  sNom_proceso, v_sqlcode, SYSDATE,vp_Gls_Error, v_sqlerrm);
             COMMIT;

        WHEN TIPVAL_NO_PARAM THEN
              ROLLBACK;
            vp_OutRetorno := -1;
            vp_OutGlosa  := 'No hay parametrizacion para Tipo Valor ingresado.';
              vp_Gls_Error:=vp_OutGlosa;
             v_sqlcode := SQLCODE;
            IF vp_tip_valor IS NULL THEN
                 v_sqlerrm := 'CLIENTE : '||lCod_cliente||' - Tipo Valor : NULO';
            ELSE
                 v_sqlerrm := 'CLIENTE : '||lCod_cliente||' - Tipo Valor : '||vp_tip_valor;
            END IF;
             INSERT INTO CO_TRANSAC_ERROR (
                 NOM_PROCESO, COD_RETORNO, FEC_PROCESO,DESC_SQL,DESC_CADENA)
              VALUES (
                  sNom_proceso, v_sqlcode, SYSDATE,vp_Gls_Error, v_sqlerrm);
             COMMIT;
        WHEN ERROR_PROCESO THEN
            vp_Gls_Error:=vp_OutGlosa;
            ROLLBACK;
            vp_OutRetorno := -1;
            vp_OutGlosa  := 'Error Sql : '||SQLERRM;
             v_sqlcode := SQLCODE;
             v_sqlerrm := 'CLIENTE : '||lCod_cliente||' - SQLCODE '||v_sqlcode;
             INSERT INTO CO_TRANSAC_ERROR (
                 NOM_PROCESO, COD_RETORNO, FEC_PROCESO,DESC_SQL,DESC_CADENA)
              VALUES (
                  sNom_proceso, v_sqlcode, SYSDATE,vp_Gls_Error, v_sqlerrm);
             COMMIT;
        WHEN NO_DATA_FOUND THEN
            vp_Gls_Error:=vp_OutGlosa;
            ROLLBACK;
            vp_OutGlosa  := 'Error Sql : '||SQLERRM;
            v_sqlerrm := 'CLIENTE : '||lCod_cliente||' - Otros Errores - ' || SQLERRM;
            v_sqlcode := SQLCODE;
            INSERT INTO CO_TRANSAC_ERROR (
                NOM_PROCESO, COD_RETORNO, FEC_PROCESO,DESC_SQL,DESC_CADENA)
            VALUES (
                sNom_proceso, v_sqlcode, SYSDATE,vp_Gls_Error, v_sqlerrm);
            COMMIT;
        WHEN CLIENTE_BLOQUEADO THEN
            vp_Gls_Error:=vp_OutGlosa;
            vp_OutRetorno := 0;
            vp_OutGlosa  := 'Cliente Pendiente por bloqueo';
            v_sqlerrm := 'CLIENTE : '||lCod_Cliente|| ' Bloquedo por Cajero '|| sNomCajero;
            INSERT INTO CO_TRANSAC_ERROR (
                NOM_PROCESO, COD_RETORNO, FEC_PROCESO,DESC_SQL,DESC_CADENA)
            VALUES (
                sNom_proceso, vp_OutRetorno, SYSDATE,vp_OutGlosa, v_sqlerrm);
            COMMIT;
        WHEN ERROR_CALC_LIMITECONS THEN
            vp_Gls_Error:=vp_OutGlosa;
            ROLLBACK;
            vp_OutRetorno := -1;
            v_sqlerrm := 'CLIENTE : '||lCod_cliente||' - Otros Errores - ' || SQLERRM;
            v_sqlcode := SQLCODE;
            INSERT INTO CO_TRANSAC_ERROR (
                NOM_PROCESO, COD_RETORNO, FEC_PROCESO,DESC_SQL,DESC_CADENA)
            VALUES (
                sNom_proceso, v_sqlcode, SYSDATE,vp_Gls_Error, v_sqlerrm);
            COMMIT;
        WHEN OTHERS THEN
            vp_Gls_Error:=vp_OutGlosa;
            ROLLBACK;
            vp_OutGlosa  := 'Error Sql : '||SQLERRM;
            v_sqlerrm := 'CLIENTE : '||lCod_cliente||' - Otros Errores - ' || SQLERRM;
            v_sqlcode := SQLCODE;
            INSERT INTO CO_TRANSAC_ERROR (
                NOM_PROCESO, COD_RETORNO, FEC_PROCESO,DESC_SQL,DESC_CADENA)
            VALUES (
                sNom_proceso, v_sqlcode, SYSDATE,vp_Gls_Error, v_sqlerrm);
            COMMIT;
END CO_APLICAPAGO_LIMITECONSUMO_PR;
/
SHOW ERRORS