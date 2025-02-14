CREATE OR REPLACE PACKAGE IC_PERFILES_PG
/*
<Documentación
        TipoDoc = "Package">
        <Elemento
                Nombre = "IC_PERFILES_PG"
                Lenguaje="PL/SQL"
                Fecha creación="03-2010"
                Creado por="Carlos Sellao H."
                Fecha modificacion=""
                Modificado por=""
                Ambiente Desarrollo="BD">
                <Retorno>N/A</Retorno>
                <Descripción>Contiene funciones y procedimientos para lógicas de perfiles de Altamira.</Descripción>
                <Parámetros>
                        <Entrada>N/A</Entrada>
                        <Salida>N/A</Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/
IS

        GV_des_error              ge_errores_pg.DesEvent;
        GV_sSql                   ge_errores_pg.vQuery;
        GV_version                CONSTANT VARCHAR2(5)  := '1.0';
        CN_err_ejecutar_servicio  NUMBER(3)     := 302;

        CN_Producto   CONSTANT NUMBER(1) := 1;

        CV_MensajeNoRep VARCHAR2(50) := 'Representante no identificado';
        CV_Modulo_Cen CONSTANT VARCHAR2(2) := 'IC';
        CV_Modulo_AL  CONSTANT VARCHAR2(2) := 'AL';
        CV_Modulo_GA  CONSTANT VARCHAR2(2) := 'GA';
        CV_TecnoGSM   CONSTANT VARCHAR2(7) := 'GSM';
        CV_tipo_KIT   CONSTANT VARCHAR2(25) := 'TIP_ARTICULO_KIT';
        CV_SIKIT      CONSTANT VARCHAR2(2) := 'S';
        CV_NOKIT      CONSTANT VARCHAR2(2) := 'N';

        CN_Err_Abo          NUMBER(3) := 203;
        CN_Err_Cli CONSTANT NUMBER(3) := 149;
        CN_Err_Usuario CONSTANT NUMBER(7) := 300008;
        CN_Err_TipPlan CONSTANT NUMBER(3) := 282;
        CV_Err_NoClasif VARCHAR2(25) := 'Error no Clasificado';

        CN_PlanPrep  CONSTANT NUMBER(1) := 1;
        CN_PlanPost  CONSTANT NUMBER(1) := 2;
        CN_PlanHibr  CONSTANT NUMBER(1) := 3;
        CV_error_no_clasif        CONSTANT VARCHAR2(30) := 'Error no clasificado';


PROCEDURE GA_INGRESA_PERFIL_PR(EN_tip_abonado  IN          GA_PERFIL_AA_TD.tip_abonado%TYPE,
                               EN_num_celular  IN          GA_PERFIL_AA_TD.num_celular%TYPE,
                               EV_num_imei     IN          GA_PERFIL_AA_TD.num_imei%TYPE,
                               EN_cod_distrib  IN          GA_PERFIL_AA_TD.cod_distribuidor%TYPE,
                               EN_id_terminal  IN          GA_PERFIL_AA_TD.id_terminal%TYPE,
                               EV_kit          IN          GA_PERFIL_AA_TD.kit%TYPE,
                               EV_cod_perfil   IN          GA_PERFIL_AA_TD.cod_perfil%TYPE,
                               EN_num_dias_vig IN          GA_PERFIL_AA_TD.num_dias_vig%TYPE,
                               ED_fec_desdevig IN          VARCHAR2,
                               ED_fec_hastavig IN          VARCHAR2,
                               EV_cod_plan     IN          GA_PERFIL_AA_TD.cod_plan%TYPE,
                               SN_COD_RETORNO  OUT NOCOPY  ge_errores_pg.CodError,
                               SV_MENS_RETORNO OUT NOCOPY  ge_errores_pg.MsgError,
                               SN_NUM_EVENTO   OUT NOCOPY  ge_errores_pg.evento );

FUNCTION IC_PERFIL_AA_FN(EN_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING;
FUNCTION IC_PERFIL_AA_BAJA_FN(EN_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING;

PROCEDURE GA_INICIA_PERFIL_PR
          (
          EN_num_movimiento IN  icc_movimiento.num_movimiento%TYPE
          );

PROCEDURE IC_SOLBAJAPERFIL_PR
          (
          EN_num_abonado   IN  icc_movimiento.num_abonado%TYPE,
          EN_num_celular   IN  icc_movimiento.num_celular%TYPE,
          EV_cod_actabo    IN  icc_movimiento.cod_actabo%TYPE,
          EN_cod_actuacion IN  icc_movimiento.cod_actuacion%TYPE,
          SN_cod_retorno   OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
          SV_mens_retorno  OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
          SN_num_evento    OUT NOCOPY ge_errores_pg.evento
          );

PROCEDURE IC_BUSCABAJASPERFIL_PR
          (
          SN_reg_leidos     OUT NOCOPY NUMBER,
          SN_reg_procesados OUT NOCOPY NUMBER,
          SN_cod_retorno    OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
          SV_mens_retorno   OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
          SN_num_evento     OUT NOCOPY ge_errores_pg.evento
          );

END IC_PERFILES_PG;
/
SHOW ERRORS
