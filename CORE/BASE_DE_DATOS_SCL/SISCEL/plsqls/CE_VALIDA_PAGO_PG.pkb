CREATE OR REPLACE PACKAGE BODY          "CE_VALIDA_PAGO_PG"  AS

FUNCTION CE_IsRevEmpresa_FN (
   pRevEmpresa  IN  VARCHAR2
  ,p_cErrFrom   OUT VARCHAR2
  ,p_cErrCode   OUT VARCHAR2
  ,p_cErrMens   OUT VARCHAR2
)  RETURN BOOLEAN AS

   vdummy ced_empresas.cod_empresa%TYPE;

BEGIN

   p_cErrFrom := 'CE_IsRevEmpresa_FN';
   p_cErrCode := '0';
   p_cErrMens := 'Ejecucion Exitosa';

   SELECT cod_empresa
   INTO vdummy
   FROM ced_empresas
   WHERE cod_empresa=pRevempresa;

   RETURN TRUE;

EXCEPTION

   WHEN NO_DATA_FOUND THEN
       p_cErrCode := '1001';
       p_cErrMens := 'Empresa Recaudadora: [' || pRevEmpresa || '] No Registrada en SCL';
       RETURN FALSE;

   WHEN OTHERS THEN
       p_cErrCode := TO_CHAR(SQLCODE);
       p_cErrMens := '[' || p_cErrFrom || '] ' || SUBSTR(SQLERRM, 1, 172);
       RETURN FALSE;

END CE_IsRevEmpresa_FN;

FUNCTION CE_IsRevCaja_FN (
   pRevCaja     IN  VARCHAR2
  ,p_cErrFrom   OUT VARCHAR2
  ,p_cErrCode   OUT VARCHAR2
  ,p_cErrMens   OUT VARCHAR2
)  RETURN BOOLEAN AS

   vdummy co_cajas.cod_caja%TYPE;

BEGIN

   p_cErrFrom := 'CE_IsRevCaja_FN';
   p_cErrCode := '0';
   p_cErrMens := 'Ejecucion Exitosa';

   SELECT cod_caja
   INTO vdummy
   FROM co_cajas
   WHERE cod_caja=pRevCaja
   AND ROWNUM<2
   ;

   RETURN TRUE;

EXCEPTION

   WHEN NO_DATA_FOUND THEN
       p_cErrCode := '1002';
       p_cErrMens := 'Codigo de Caja Recaudadora: [' || pRevCaja || '] No Registrado en SCL';
       RETURN FALSE;

   WHEN OTHERS THEN
       p_cErrCode := TO_CHAR(SQLCODE);
       p_cErrMens := '[' || p_cErrFrom || '] ' || SUBSTR(SQLERRM, 1, 172);
       RETURN FALSE;

END CE_IsRevCaja_FN;

FUNCTION CE_IsRevOperador_FN (
   pRevOperador IN  VARCHAR2
  ,p_cErrFrom   OUT VARCHAR2
  ,p_cErrCode   OUT VARCHAR2
  ,p_cErrMens   OUT VARCHAR2
)  RETURN BOOLEAN AS

   vdummy ge_seg_usuario.nom_usuario%TYPE;

BEGIN

   p_cErrFrom := 'CE_IsRevOperador_FN';
   p_cErrCode := '0';
   p_cErrMens := 'Ejecucion Exitosa';

   SELECT nom_usuario
   INTO vdummy
   FROM ge_seg_usuario
   WHERE nom_usuario=pRevOperador;

   RETURN TRUE;

EXCEPTION

   WHEN NO_DATA_FOUND THEN
       p_cErrCode := '1003';
       p_cErrMens := 'Usuario Oracle utilizado: [' || pRevOperador || ']  No Registrado en SCL';
       RETURN FALSE;

   WHEN OTHERS THEN
       p_cErrCode := TO_CHAR(SQLCODE);
       p_cErrMens := '[' || p_cErrFrom || '] ' || SUBSTR(SQLERRM, 1, 172);
       RETURN FALSE;

END CE_IsRevOperador_FN;

FUNCTION CE_IsRevCliente_FN (
   pRevCliente  IN  VARCHAR2
  ,p_cErrFrom   OUT VARCHAR2
  ,p_cErrCode   OUT VARCHAR2
  ,p_cErrMens   OUT VARCHAR2
)  RETURN BOOLEAN AS

   vdummy ge_clientes.cod_cliente%TYPE;

BEGIN

   p_cErrFrom := 'CE_IsRevCliente_FN';
   p_cErrCode := '0';
   p_cErrMens := 'Ejecucion Exitosa';

   SELECT cod_cliente
   INTO vdummy
   FROM ge_clientes
   WHERE cod_cliente=TO_NUMBER(pRevCliente);

   RETURN TRUE;

EXCEPTION

   WHEN NO_DATA_FOUND THEN
       p_cErrCode := '1004';
       p_cErrMens := 'Cliente: [' || pRevCliente || ']  No Registrado en SCL';
       RETURN FALSE;

   WHEN OTHERS THEN
       p_cErrCode := TO_CHAR(SQLCODE);
       p_cErrMens := '[' || p_cErrFrom || '] ' || SUBSTR(SQLERRM, 1, 172);
       RETURN FALSE;

END CE_IsRevCliente_FN;

FUNCTION CE_IsRevBcoDocum_FN (
   pRevBcoDocum IN  VARCHAR2
  ,p_cErrFrom   OUT VARCHAR2
  ,p_cErrCode   OUT VARCHAR2
  ,p_cErrMens   OUT VARCHAR2
)  RETURN BOOLEAN AS

   vdummy ge_bancos.cod_banco%TYPE;

BEGIN

   p_cErrFrom := 'CE_IsRevBcoDocum_FN';
   p_cErrCode := '0';
   p_cErrMens := 'Ejecucion Exitosa';

   SELECT cod_banco
   INTO vdummy
   FROM ge_bancos
   WHERE cod_banco=pRevBcoDocum;

   RETURN TRUE;

EXCEPTION

   WHEN NO_DATA_FOUND THEN
       p_cErrCode := '1005';
       p_cErrMens := 'Codigo de Banco: [' || pRevBcoDocum || '] No Registrado en SCL';
       RETURN FALSE;

   WHEN OTHERS THEN
       p_cErrCode := TO_CHAR(SQLCODE);
       p_cErrMens := '[' || p_cErrFrom || '] ' || SUBSTR(SQLERRM, 1, 172);
       RETURN FALSE;

END CE_IsRevBcoDocum_FN;

FUNCTION CE_IsRevFechaEfectiva_FN (
    pRevFechaEfectiva IN  VARCHAR2
   ,p_cErrFrom        OUT VARCHAR2
   ,p_cErrCode        OUT VARCHAR2
   ,p_cErrMens        OUT VARCHAR2
)   RETURN BOOLEAN AS

    vdummy        DATE;
    vdummy2       VARCHAR2(255);
    vExceptio     EXCEPTION;
	vExceptioNull EXCEPTION;

BEGIN

    p_cErrFrom := 'CE_IsRevFechaEfectiva_FN';
    p_cErrCode := '0';
    p_cErrMens := 'Ejecucion Exitosa';

    IF pRevFechaEfectiva IS NULL THEN RAISE vExceptioNull; END IF;

    vdummy2 := LTRIM(RTRIM(pRevFechaEfectiva)) || 'X';
    IF vdummy2='X' THEN RAISE vExceptioNull; END IF;

    vdummy  := TO_DATE(pRevFechaEfectiva, 'YYYYMMDD HH24MISS');
    vdummy2 := TO_CHAR(vdummy, 'YYYYMMDD HH24MISS');
    IF pRevFechaEfectiva <> vdummy2 THEN RAISE vExceptio; END IF;

    RETURN TRUE;

EXCEPTION

    WHEN vExceptioNull THEN
       p_cErrCode := '1007';
       p_cErrMens := 'Valor NULO para fecha de Pago';
       RETURN FALSE;

    WHEN vExceptio THEN
       p_cErrCode := '1006';
       p_cErrMens := 'Fecha de Pago: [' || pRevFechaEfectiva || '] debe tener formato YYYYMMDD HH24MISS';
       RETURN FALSE;

    WHEN OTHERS THEN
       p_cErrCode := TO_CHAR(SQLCODE);
       p_cErrMens := '[' || p_cErrFrom || '] ' || SUBSTR(SQLERRM, 1, 172);
       RETURN FALSE;

END CE_IsRevFechaEfectiva_FN;

END CE_VALIDA_PAGO_PG;
/
SHOW ERRORS
