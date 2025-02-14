CREATE OR REPLACE PACKAGE BODY Co_Indemnizacion_Pg IS

FUNCTION CO_RETORNA_VERSION_GENERAL_FN RETURN VARCHAR2
IS
  GV_version    CONSTANT VARCHAR2(3) := '001';
  GV_subversion CONSTANT VARCHAR2(3) := '001';
BEGIN
   RETURN('Version : '||GV_version||' <--> SubVersion : '||GV_subversion);
END;

PROCEDURE CO_INDEMNIZACION_PR (
        EN_cod_cliente    IN NUMBER,
        EN_num_abonado    IN NUMBER,
        EV_cod_modulo    IN VARCHAR2,
        EN_cod_producto    IN NUMBER,
        EN_cod_retorno    IN OUT NOCOPY NUMBER,
        EN_des_retorno    IN OUT NOCOPY VARCHAR2
) IS
/*
<Documentación TipoDoc = "Procedimiento">
<Elemento Nombre = "CO_INDEMNIZACION_PR" Lenguaje="PL/SQL" Fecha="27-05-2005" Versión="1.0.1" Diseñador="NN" Programador="GAC" Ambiente="BD NN">
<Retorno>NA</Retorno>
<Descripción>Realiza pago de indemnizacion</Descripción>
<Parámetros>
<Entrada>
<param nom="EN_cod_cliente"    Tipo="NUMBER">   Codigo del cliente </param>
<param nom="EN_num_abonado"    Tipo="NUMBER">   Numero de abonado </param>
<param nom="EV_cod_modulo"     Tipo="VARCHAR2"> Codigo del modulo </param>
<param nom="EN_cod_producto"   Tipo="VARCHAR2"> Codigo del producto </param>
<Entrada>
<Salida>
<param nom="EN_cod_retorno"    Tipo="VARCHAR2"> Codigo de retorno </param>
<param nom="EN_des_retorno"    Tipo="VARCHAR2"> Descripcion de retorno </param>
<Salida>
</Parámetros>
</Elemento>
</Documentación>
*/

LN_cod_indemnizacion    GA_ABOCEL.cod_indemnizacion%TYPE;
LN_sec_cargo            GE_CARGOS.num_cargo%TYPE;
LN_monto                GE_CARGOS.imp_cargo%TYPE;
LN_cod_concepto            GE_CARGOS.cod_concepto%TYPE;
LV_cod_moneda            GE_MONEDAS.cod_moneda%TYPE;
LV_indicador            VARCHAR2(5);
LN_cod_retorno            NUMBER(1);
LN_cod_error            NUMBER(1);
LV_des_retorno            VARCHAR2(200);
LV_des_error            VARCHAR2(200);

ERROR_PROCESO EXCEPTION;
TERMINADO_OK  EXCEPTION;

BEGIN

    LN_cod_error := 1;
    LV_des_error := 'Llamada a PL pv_indemnizacion_pg.pv_indemnizacion_pr';
    --Pv_Plan_Indemnizacion_Pg.pv_indemnizacion_pr( EN_num_abonado, EV_cod_modulo, LV_indicador, LN_monto, LN_cod_concepto, LN_cod_retorno, LV_des_retorno );
    Pv_Penalizacion_Pg.pv_indemnizacion_pr( EN_num_abonado, EV_cod_modulo, LV_indicador, LN_monto, LN_cod_concepto, LN_cod_retorno, LV_des_retorno );

    IF LN_cod_retorno <> 0 THEN
        RAISE ERROR_PROCESO;
    ELSE
        IF ((LN_monto IS NULL OR TRIM(LN_monto) = '') AND LN_cod_retorno = 0) THEN
            RAISE TERMINADO_OK;
        END IF;
    END IF;

    LN_cod_error := 2;
    LV_des_error := 'Select Cod_Moneda from ge_monedas, fa_conceptos';
    SELECT C.COD_MONEDA
      INTO LV_cod_moneda
      FROM GE_MONEDAS C, FA_CONCEPTOS F
     WHERE C.COD_MONEDA    = F.COD_MONEDA
       AND F.COD_CONCEPTO = LN_cod_concepto;

    LN_cod_error := 3;
    LV_des_error := 'Select ge_seq_cargos.nextval from dual';
    SELECT GE_SEQ_CARGOS.NEXTVAL
      INTO LN_sec_cargo
      FROM DUAL;

    LN_cod_error := 4;
    LV_des_error := 'Llamada a PL co_gen_cargo';
    Co_Gen_Cargo( EN_cod_cliente, EN_num_abonado, LN_cod_concepto, LN_monto, LV_cod_moneda, EN_cod_producto, LN_sec_cargo );

    EN_cod_retorno := 0;
    EN_des_retorno := 'OK';

EXCEPTION
    WHEN TERMINADO_OK THEN
        EN_cod_retorno := 0;
        EN_des_retorno := 'OK';

    WHEN ERROR_PROCESO THEN
        EN_cod_retorno := LN_cod_error;
        EN_des_retorno := LV_des_error || ' - ' || LV_des_retorno;

    WHEN OTHERS THEN
        EN_cod_retorno := LN_cod_error;
        EN_des_retorno := LV_des_error || ' - ' || SQLERRM;

END CO_INDEMNIZACION_PR;

END Co_Indemnizacion_Pg;
/
SHOW ERRORS
