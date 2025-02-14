CREATE OR REPLACE PACKAGE PV_DATOS_CLIENTES_PG
IS

   TYPE refCursor IS REF CURSOR;
   CV_error_no_clasif      CONSTANT VARCHAR2 (50) := 'No es posible clasificar el error';
   CV_cod_modulo           CONSTANT VARCHAR2 (2)  := 'GA';
   CV_version              CONSTANT VARCHAR2 (2)  := '1';
   CN_cod_ret_no_found       CONSTANT NUMBER(4)  := 1162;

    CN_LISTA_NULA constant number:=1;
    CN_USOPOSPAGO CONSTANT NUMBER := 2;
    CN_USOHIBRIDO CONSTANT NUMBER := 10;


--------------------------------------------------------------------------------------------------------
--1.- Metodo obtenerDatos   (PL nueva)
    PROCEDURE PV_OBTIENE_DATOS_CLIENTE_PR(
                   SO_Cliente       IN  OUT NOCOPY   PV_CLIENTE_QT,
                SN_cod_retorno   OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
                SV_mens_retorno  OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
                SN_num_evento    OUT NOCOPY        ge_errores_pg.evento);


 PROCEDURE PV_OBTIENE_DATOS_CLIENTE2_PR(
                   SO_Cliente       IN  OUT NOCOPY   PV_CLIENTE_QT,
                SN_cod_retorno   OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
                SV_mens_retorno  OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
                SN_num_evento    OUT NOCOPY        ge_errores_pg.evento);


  PROCEDURE PV_OBTIENE_DATOS_ABOCLIE2_PR(
  		EN_num_abonado    IN              ga_abocel.num_abonado%TYPE,
                SO_Cliente       IN OUT NOCOPY       PV_CLIENTE_QT,
                SN_cod_retorno   OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
                SV_mens_retorno  OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
                SN_num_evento    OUT NOCOPY       ge_errores_pg.evento);



-----------------------------------------------------------------------------------------------------------
--2.-   Metodo :  ActualizaCantAboCliente
    PROCEDURE PV_ACTUA_CANT_ABOCLIENTE_PR(
              EO_GE_CLIENTES        IN                        GE_CLIENTES_QT,
              SN_cod_retorno        OUT       NOCOPY    ge_errores_td.cod_msgerror%TYPE,
              SV_mens_retorno       OUT       NOCOPY    ge_errores_td.det_msgerror%TYPE,
              SN_num_evento         OUT       NOCOPY    ge_errores_pg.evento);

--------------------------------------------------------------------------------------------------------------------------------------------------
--3.- Metodo : obtenerCargoBasicoActual ( pv_bolsas_dinamicas_pg.pv_cnslta_carbasicoclte_fn )
      PROCEDURE  PV_Obt_CargoBasico_Actual_PR (
                SO_CLIENTE       IN OUT NOCOPY PV_BOLSAS_DINAMICAS_QT,
              SN_cod_retorno   OUT NOCOPY    ge_errores_td.cod_msgerror%TYPE,
              SV_mens_retorno  OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
              SN_num_evento    OUT NOCOPY    ge_errores_pg.evento);

--------------------------------------------------------------------------------------------------------------------------------------------------
--4.- Metodo : obtenerCargoBasico
    PROCEDURE PV_OBTENER_CARGO_BASICO_PR(
                SO_CARGOS_BA             OUT NOCOPY         refcursor,
                SN_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
                SV_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
                SN_num_evento            OUT NOCOPY        ge_errores_pg.evento);
--------------------------------------------------------------------------------------------------------
--5,. metodo validarTipoPlanCliente
PROCEDURE PV_VALIDAR_TIPO_PLANCLIENTE_PR(
              SO_CLIENTE       IN               PV_CLIENTE_QT,
                SN_retorno       OUT NOCOPY       VARCHAR,
                SN_cod_retorno   OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
                SV_mens_retorno  OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
              SN_num_evento    OUT NOCOPY        ge_errores_pg.evento);

--------------------------------------------------------------------------------------------------------
--6.- Metodo obtenerCategoriaCliente
PROCEDURE PV_OBTENER_CATEG_CLIENTE_PR(
                   SO_Cliente       IN  OUT NOCOPY   PV_CLIENTE_QT,
                SN_cod_retorno   OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
                SV_mens_retorno  OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
                SN_num_evento    OUT NOCOPY        ge_errores_pg.evento);

--------------------------------------------------------------------------------------------------------
--7
PROCEDURE PV_cliente_Busqueda_PR(
                   EO_Cliente           IN     PV_CLIENTE_QT,
              SO_Cliente_Cur     OUT NOCOPY       refcursor,
                SN_cod_retorno    OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
                SV_mens_retorno   OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
                SN_num_evento    OUT NOCOPY        ge_errores_pg.evento);

--------------------------------------------------------------------------------------------------------
--8.- Metodo obtenerValorCalculado
PROCEDURE PV_OBTENER_VALOR_CALC_PR(
                   SO_Cliente       IN  OUT NOCOPY   PV_CLIENTE_QT,
                SN_cod_retorno   OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
                SV_mens_retorno  OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
                SN_num_evento    OUT NOCOPY        ge_errores_pg.evento);

--------------------------------------------------------------------------------------------------------
FUNCTION PV_CLIENTE_CANTLINEAS_FN (
              EN_CodCliente    IN                  ge_clientes.cod_cliente%TYPE,
                SN_cod_retorno   OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
                SV_mens_retorno  OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
                SN_num_evento    OUT NOCOPY        ge_errores_pg.evento)
    RETURN NUMBER;

--------------------------------------------------------------------------------------------------------
FUNCTION PV_OBTIENE_LIMITELINEAS_FN (
              SO_Cliente       IN     PV_CLIENTE_QT,
                SN_cod_retorno   OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
                SV_mens_retorno  OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
                SN_num_evento    OUT NOCOPY        ge_errores_pg.evento)
    RETURN VARCHAR2;

--------------------------------------------------------------------------------------------------------
--Método obtenerMorosidadCliente

FUNCTION PV_DETERMINA_MOROCIDAD_FN (EO_Cliente  IN PV_CLIENTE_QT,
                                    SN_cod_retorno      OUT NOCOPY    ge_errores_td.cod_msgerror%TYPE,
                                    SV_mens_retorno     OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
                                    SN_num_evento       OUT NOCOPY    ge_errores_pg.evento )
RETURN NUMBER;

-------------------------------------------------------------------------------------------------------
--método validarClienteNPW
PROCEDURE VALIDAR_CLIENTE_NPW_PR (
              EO_Cliente      IN                  PV_CLIENTE_QT,
                SN_cod_retorno   OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
                SV_mens_retorno  OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
                SN_num_evento    OUT NOCOPY        ge_errores_pg.evento);

--------------------------------------------------------------------------------------------------------
--método obtenerNumAbonadosCliente
PROCEDURE PV_OBTIENE_NUMABO_CLIENTE_PR (
              SO_Cliente       IN  OUT NOCOPY   PV_CLIENTE_QT,
                SN_cod_retorno   OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
                SV_mens_retorno  OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
                SN_num_evento    OUT NOCOPY        ge_errores_pg.evento);

--------------------------------------------------------------------------------------------------------


PROCEDURE VALIDAR_SITU_CLIEMP_PR (
              EO_Cliente         IN            PV_CLIENTE_QT,
                SN_cod_retorno   OUT NOCOPY    ge_errores_td.cod_msgerror%TYPE,
                SV_mens_retorno  OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
                SN_num_evento    OUT NOCOPY     ge_errores_pg.evento);

--------------------------------------------------------------------------------------------------------
PROCEDURE TRASPASAR_CUOTAS_ABONADO_PR (
              EO_Cliente                 IN    PV_REG_REORD_PLAN_QT,
              SN_cod_retorno   OUT NOCOPY    ge_errores_td.cod_msgerror%TYPE,
                SV_mens_retorno  OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
                SN_num_evento    OUT NOCOPY     ge_errores_pg.evento);

-----------------------------------------------------------------------------------------------------------
PROCEDURE PV_VALIDA_ABOACTIVOCLIDEST_PR(
                   EN_cod_cliente   IN     ge_clientes.COD_CLIENTE%TYPE,
              EN_num_abonado     IN      ga_abocel.num_abonado%TYPE,
              SN_retorno          OUT                       NUMBER,
                SN_cod_retorno   OUT NOCOPY        ge_errores_td.cod_msgerror%TYPE,
                SV_mens_retorno  OUT NOCOPY        ge_errores_td.det_msgerror%TYPE,
                SN_num_evento   OUT NOCOPY        ge_errores_pg.evento);

-----------------------------------------------------------------------------------------------------------

PROCEDURE PV_OBTIENE_TIPOPLAN_CLIE_PR (
              EN_COD_CLIENTE   IN    ga_abocel.cod_cliente%TYPE,
              SN_PREPAGOS       OUT NOCOPY    NUMBER,
              SN_POSPAGOS       OUT NOCOPY    NUMBER,
              SN_HIBRIDOS       OUT NOCOPY    NUMBER,
              SN_cod_retorno   OUT NOCOPY    ge_errores_pg.coderror,
                SV_mens_retorno  OUT NOCOPY    ge_errores_pg.msgerror,
                SN_num_evento    OUT NOCOPY     ge_errores_pg.evento);
-----------------------------------------------------------------------------------------------------------
PROCEDURE PV_OBTIENE_DATOSADIC_CLIE_PR (
              EN_COD_CLIENTE   IN    ga_abocel.cod_cliente%TYPE,
              SV_DES_COLOR     OUT NOCOPY   VARCHAR2,
              SV_DES_SEGMENTO  OUT NOCOPY   VARCHAR2,
              SN_cod_retorno   OUT NOCOPY    ge_errores_pg.coderror,
              SV_mens_retorno  OUT NOCOPY    ge_errores_pg.msgerror,
              SN_num_evento    OUT NOCOPY     ge_errores_pg.evento);

END PV_DATOS_CLIENTES_PG;
/
SHOW ERRORS