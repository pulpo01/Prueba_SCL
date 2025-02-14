CREATE OR REPLACE PACKAGE VE_VALIDACION_PG
AS
/*
<Documentación TipoDoc = "procedure">
<Elemento Nombre = "VE_VALIDACION_PG" Lenguaje="PL/SQL" Fecha="26-04-2005" Versión="1.0.0" Diseñador="" Programador="vmb" Ambiente="DEIMOS_ANDINA">
<Retorno>NA</Retorno>
<Descripción> Encabezado de VE_VALIDACION_COL_PG</Descripción>
<Parámetros>
<Entrada>
<param nom="" Tipo="STRING">Descripción Parametro1</param>
</Entrada>
<Salida>
<param nom="" Tipo="STRING">Descripción Parametro4</param>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/

TYPE IntArray IS VARRAY(9) OF INTEGER;
PROCEDURE GE_SEQ_CLIENTES_PR (EN_num_transaccion IN NUMBER);
FUNCTION VE_CALCULADIGITO_FN (EV_cadena    IN GE_CLIENTES.NUM_IDENT%TYPE,
                              EN_avalores  IntArray,
                              EN_posfinal  NUMBER,
                              EN_modulo    NUMBER,
                              EB_dividir   BOOLEAN) RETURN NUMBER;

PROCEDURE VE_GA_TRANSACABO_PR(EN_num_transaccion  IN NUMBER,
                              EN_coderror         IN NUMBER,
                              EV_msgerror         IN VARCHAR2);

PROCEDURE VE_GRABA_ERROR_PR (EV_cod_actabo    IN VARCHAR2,
                             EN_codigo        IN NUMBER,
                             ED_fec_error     IN DATE,
                             EN_cod_producto  IN NUMBER,
                             EV_nom_proc      IN VARCHAR2,
                             EV_nom_tabla     IN VARCHAR2,
                             EV_cod_act       IN VARCHAR2,
                             EV_cod_sqlcode   IN VARCHAR2,
                             EV_cod_sqlerrm   IN VARCHAR2);

PROCEDURE VE_VENTA_LEGALIZADAS_PR(EN_num_transaccion IN NUMBER,
                                  EV_cod_tipcomis    IN VARCHAR2,
                                  EV_cod_vendealer   IN VARCHAR2,
                                  EV_cod_vendedor    IN VARCHAR2);

PROCEDURE VE_VENTA_VENCIDAS_PR(EN_num_transaccion IN NUMBER,
                   EV_cod_vendealer    IN ga_ventas.cod_vendealer%TYPE,
                               EV_tipo_vendedor   IN VARCHAR2 := 'V');

PROCEDURE VE_VALIDANUMFIJO_PR(EN_num_transaccion IN NUMBER,
                              EV_num_telefono IN VARCHAR2,
                              EV_cod_area     IN VARCHAR2);

PROCEDURE VE_VALIDAPOSVENTA_PR(EN_num_transaccion IN  NUMBER,
                               EV_parametros      IN VARCHAR2);

PROCEDURE VE_VALIDAVENTA_PR(EN_num_transaccion IN  NUMBER,
                            EV_parametros      IN VARCHAR2);

PROCEDURE VE_VALIDAFACTURA_PR(EN_num_transaccion IN  NUMBER,
                              EV_parametros      IN VARCHAR2);

FUNCTION VE_VALIDANIT_FN(EV_num_ident    IN ge_clientes.num_ident%TYPE,
                         EV_cod_tipident IN ge_tipident.cod_tipident%TYPE) RETURN VARCHAR2;

FUNCTION VE_VALIDARUC_FN(EV_num_ident    IN ge_clientes.num_ident%TYPE,
                         EV_cod_tipident IN ge_tipident.cod_tipident%TYPE) RETURN VARCHAR2;

FUNCTION VE_VALIDARUCTIPO_FN (EV_num_ident    IN ge_clientes.num_ident%TYPE,
                             EV_cod_tipident IN ge_tipident.cod_tipident%TYPE)RETURN VARCHAR2;

FUNCTION VE_VALIDARUCESPECIAL_FN (EV_num_ident    IN ge_clientes.num_ident%TYPE,
                                 EV_cod_tipident IN ge_tipident.cod_tipident%TYPE) RETURN VARCHAR2;

END VE_VALIDACION_PG;
/
SHOW ERRORS
