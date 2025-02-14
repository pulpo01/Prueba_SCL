CREATE OR REPLACE PACKAGE "GA_EXTRA_TIEMPO_PG"
/*
<Documentación
   TipoDoc = "Package">
   <Elemento
       Nombre = "GA_Extra_Tiempo_PG"
       Lenguaje="PL/SQL"
       Fecha="18-06-2005"
       Versión="1.0"
       Diseñador="Carlos Navarro H. - Marcelo Godoy S."
       Programador="Marcelo Godoy S. - Carlos Navarro H."
       Ambiente Desarrollo="BD">
       <Retorno>NA</Retorno>
       <Descripción>Package negocio de recarga y extratiempo</Descripción>
       <Parámetros>
          <Entrada>NA</Entrada>
          <Salida>NA</Salida>
       </Parámetros>
    </Elemento>
   </Documentación>
*/
AS

GV_version CONSTANT VARCHAR2(5)  := '1.0';
GV_des_error ge_errores_PG.DesEvent;
GV_sSql ge_errores_PG.vQuery;
CV_error_no_clasif CONSTANT VARCHAR2(30) := 'Error no clasificado';
CN_cod_producto CONSTANT NUMBER(1) := 1;
CN_largoquery CONSTANT NUMBER(4) := 3000;
CN_abonado_prepago CONSTANT NUMBER(1) := 1;
CN_abonado_pospago CONSTANT NUMBER(1) := 2;
CN_abonado_hibrido CONSTANT NUMBER(1) := 3;

CN_num_perafec CONSTANT NUMBER(1) := 1;
CN_cod_estado CONSTANT NUMBER(1) := 1;
CV_null CONSTANT VARCHAR2(4)  := NULL;
CV_cod_oper_ag CONSTANT VARCHAR2(2)  := 'AG';
CV_cod_actabo CONSTANT VARCHAR2(2)  := 'TR';
CV_cod_os_Pos_Hib CONSTANT ci_orserv.cod_os%TYPE := '40001';
CV_cod_os_Pos_pre CONSTANT ci_orserv.cod_os%TYPE := '40002';
CV_comment_ci_orv CONSTANT ci_orserv.comentario%TYPE := 'El monto facturado fue: ';
CV_comment_ci CONSTANT ci_orserv.comentario%TYPE := 'El monto facturado al celular postpago numero ';

-- Parametros de Restriccion.
GV_param_entrada VARCHAR2(500);
CV_excecute CONSTANT VARCHAR2(7) := 'EXECUTE';
CV_cod_actuacion CONSTANT ga_actabo.cod_actabo%TYPE:='IV';
CV_cod_modulo CONSTANT VARCHAR(2) := 'GA';

-- Estructura de ga_segmentacion.ga_origen_cliente_PR --
GN_cod_ciclo ga_abocel.cod_ciclo%TYPE;
GN_cod_cliente ga_abocel.cod_cliente%TYPE;
GN_cod_cuenta ga_abocel.cod_cuenta%TYPE;
GN_cod_producto ga_abocel.cod_producto%TYPE;
GN_fono_contacto VARCHAR2(15);
GN_num_abonado ga_abocel.num_abonado%TYPE;
GV_cod_clave VARCHAR2(7);
GV_cod_estado ga_abocel.cod_estado%TYPE;
GV_cod_perfil ge_valores_cli.des_valor%TYPE;
GV_cod_plantarif ga_abocel.cod_plantarif%TYPE;
GV_cod_situacion ga_abocel.cod_situacion%TYPE;
GV_cod_tecnologia ga_abocel.cod_tecnologia%TYPE;
GV_cod_transaccion VARCHAR2(2);
GV_nom_abocli VARCHAR2(91);
GV_nom_responsable VARCHAR2(91);
GV_num_imei ga_abocel.num_imei%TYPE;
GV_num_min ga_abocel.num_min%TYPE;
GV_num_min_mdn ga_abocel.num_min_mdn%TYPE;
GV_num_serie ga_abocel.num_serie%TYPE;
GV_num_seriehex ga_abocel.num_seriehex%TYPE;
GV_num_seriemec ga_abocel.num_seriemec%TYPE;
GV_tip_abonado ta_plantarif.cod_tiplan%TYPE;
GV_tip_plantarif ga_abocel.tip_plantarif%TYPE;
GV_des_plantarif ta_plantarif.des_plantarif%TYPE;
GV_tip_terminal ga_abocel.tip_terminal%TYPE;
CV_version VARCHAR2(3) := '1.0';
CV_mens_atendio CONSTANT VARCHAR2(23) := 'Se atendió al celular: ';
CV_nom_usuario ci_reg_atencion_clientes.nom_usuarora%TYPE:= 'USUARIO_SERV_PL_SQL';

CN_largoerrtec CONSTANT NUMBER:=500;
CN_largodesc CONSTANT NUMBER:=1000;
CV_postpago VARCHAR(8) := 'POSTPAGO';
cv_mens_atendido CONSTANT VARCHAR2(23):='Se atendió al celular: ';

-----------------------------------------------------------------------------------------------------------------
FUNCTION GA_Obtiene_Concepto_PorPlan_FN
(
        EN_cod_plan IN VARCHAR2,
        SN_cod_retorno OUT NOCOPY NUMBER
)
RETURN BOOLEAN;

-----------------------------------------------------------------------------------------------------------------
PROCEDURE GA_Extratiempo_Contrato_PR
(
        EN_num_celular IN NUMBER,
        EN_valor_recarga IN NUMBER,
        EN_cod_plan IN VARCHAR2,
        SN_cod_retorno OUT NOCOPY NUMBER,
        SV_mens_retorno OUT NOCOPY VARCHAR2,
        SN_num_evento OUT NOCOPY NUMBER,
        EV_sis_origen IN VARCHAR2 DEFAULT 'XX' -- JGC MACOL-34287 25/09/2006 (Parametro opcional)
);

-----------------------------------------------------------------------------------------------------------------
PROCEDURE GA_Carga_Prepago_A_Postpago_PR
(
        EN_num_celular_origen IN NUMBER,
        EN_num_celular_destino IN NUMBER,
        EN_valor_recarga IN NUMBER,
        SN_cod_retorno OUT NOCOPY NUMBER,
        SV_mens_retorno OUT NOCOPY VARCHAR2,
        SN_num_evento OUT NOCOPY NUMBER
);

-----------------------------------------------------------------------------------------------------------------
FUNCTION GA_Obtiene_Prefijo_FN
(
        SV_prefijox OUT NOCOPY VARCHAR2,
        SN_cod_retorno OUT NOCOPY NUMBER,
        SV_mens_retorno OUT NOCOPY VARCHAR2,
        SN_num_evento OUT NOCOPY NUMBER
)
RETURN BOOLEAN;

-----------------------------------------------------------------------------------------------------------------
FUNCTION GA_Valida_Prefijo_FN
(
        EV_cod_plan IN VARCHAR2,
        SN_cod_retorno OUT NOCOPY NUMBER,
        SV_mens_retorno OUT NOCOPY VARCHAR2,
        SN_num_evento OUT NOCOPY NUMBER
)
RETURN BOOLEAN;

-----------------------------------------------------------------------------------------------------------------
FUNCTION GA_Valida_Planex_FN
(
        EV_cod_plan IN VARCHAR2,
        SV_tip_dcto OUT NOCOPY VARCHAR2,
        SN_cod_retorno OUT NOCOPY NUMBER,
        SV_mens_retorno OUT NOCOPY VARCHAR2,
        SN_num_evento OUT NOCOPY NUMBER
)
RETURN BOOLEAN;

-----------------------------------------------------------------------------------------------------------------
FUNCTION GA_Minutos_Extra_FN
(
        EN_tip_dcto IN VARCHAR2,
        EV_cod_plan IN VARCHAR2,
        EN_cod_cliente IN ga_abocel.cod_cliente%TYPE,
        EN_num_abonado IN NUMBER,
        EN_cod_ciclo IN ga_abocel.cod_ciclo%TYPE,
        SN_val_mintotal OUT NOCOPY NUMBER,
        SN_val_usado OUT NOCOPY NUMBER,
        SN_val_disponible OUT NOCOPY NUMBER,
        SN_cod_retorno OUT NOCOPY NUMBER,
        SV_mens_retorno OUT NOCOPY VARCHAR2,
        SN_num_evento OUT NOCOPY NUMBER
)
RETURN BOOLEAN;

-----------------------------------------------------------------------------------------------------------------
FUNCTION GA_Minutos_Bolsa_FN
(
        EN_cod_ciclfact IN tol_acumbolsa_gral.fec_tasa%TYPE,
        EN_num_abonado IN NUMBER,
        SN_usado_bolsa OUT NOCOPY NUMBER,
        SN_disponible_bolsa OUT NOCOPY NUMBER,
        SN_cod_retorno OUT NOCOPY NUMBER,
        SV_mens_retorno OUT NOCOPY VARCHAR2,
        SN_num_evento OUT NOCOPY NUMBER
)
RETURN BOOLEAN;

-----------------------------------------------------------------------------------------------------------------
FUNCTION GA_Obtiene_Datos_Tol_FN
(
        EN_tip_dcto IN VARCHAR2,
        EV_cod_plan IN VARCHAR2,
        EN_cod_cliente IN ga_abocel.cod_cliente%TYPE,
        EN_num_abonado IN NUMBER,
        EN_cod_ciclo IN ga_abocel.cod_ciclo%TYPE,
        EN_cod_ciclfact IN tol_acumbolsa_gral.fec_tasa%TYPE,
        SN_val_mintotal OUT NOCOPY NUMBER,
        SN_val_usado OUT NOCOPY NUMBER,
        SN_val_disponible OUT NOCOPY NUMBER,
        SN_usado_bolsa OUT NOCOPY NUMBER,
        SN_disponible_bolsa OUT NOCOPY NUMBER,
        SN_cod_retorno OUT NOCOPY NUMBER,
        SV_mens_retorno OUT NOCOPY VARCHAR2,
        SN_num_evento OUT NOCOPY NUMBER
)
RETURN BOOLEAN;

-----------------------------------------------------------------------------------------------------------------
PROCEDURE GA_Extratiempo_Consulta_PR
(
        EN_num_celular IN NUMBER,
        EV_cod_plan IN VARCHAR2,
        EN_ind_registro IN BOOLEAN DEFAULT TRUE,
        SN_val_mintotal OUT NOCOPY NUMBER,
        SN_val_usado OUT NOCOPY NUMBER,
        SN_val_disponible OUT NOCOPY NUMBER,
        SN_usado_bolsa OUT NOCOPY NUMBER,
        SN_disponible_bolsa OUT NOCOPY NUMBER,
        SN_cod_retorno OUT NOCOPY NUMBER,
        SV_mens_retorno OUT NOCOPY VARCHAR2,
        SN_num_evento OUT NOCOPY NUMBER
);

PROCEDURE GA_Obtiene_tipo_Plan_PR
(
        EN_cod_plan IN VARCHAR2,
        SN_cod_retorno OUT NOCOPY varchar2
);

END GA_Extra_Tiempo_PG;
/
SHOW ERRORS
