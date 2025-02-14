CREATE OR REPLACE PACKAGE IC_PROCPROVISION_PG
/*
<Documentación
        TipoDoc = "Package">
        <Elemento
                Nombre = "IC_PROCPROVISION_PG"
                Lenguaje="PL/SQL"
                Fecha creación="06-2009"
                Creado por="Carlos Sellao H."
                Fecha modificacion=""
                Modificado por=""
                Ambiente Desarrollo="BD">
                <Retorno>N/A</Retorno>
                <Descripción>Contiene funciones que rescatan valores de parametros para ser enviados en los Comandos hacia P+S</Descripción>
                <Parámetros>
                        <Entrada>N/A</Entrada>
                        <Salida>N/A</Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/
IS
        CN_Producto   CONSTANT NUMBER(1) := 1;
        CN_altaservBD CONSTANT NUMBER(1) := 1;
        CN_altaservIC CONSTANT NUMBER(1) := 2;
        CN_bajaservBD CONSTANT NUMBER(1) := 3;
        CN_ind_ip     CONSTANT NUMBER(1) := 1;
        CN_ind_comerc CONSTANT NUMBER(1) := 1;

        CV_MensajeNoRep VARCHAR2(50) := 'Representante no identificado';
        CV_Modulo_Cen CONSTANT VARCHAR2(2) := 'IC';
        CV_Modulo_ST  CONSTANT VARCHAR2(2) := 'ST';
        CN_Err_Abo CONSTANT NUMBER(3) := 203;
        CN_Err_Cli CONSTANT NUMBER(3) := 149;
        CN_Err_Usuario CONSTANT NUMBER(7) := 300008;
        CN_Err_TipPlan CONSTANT NUMBER(3) := 282;
        CV_Err_NoClasif VARCHAR2(25) := 'Error no Clasificado';

        CN_PlanPrep  CONSTANT NUMBER(1) := 1;
        CN_PlanPost  CONSTANT NUMBER(1) := 2;
        CN_PlanHibr  CONSTANT NUMBER(1) := 3;

        CV_PayTypePre  CONSTANT VARCHAR(2) := '1';
        CV_PayTypePos  CONSTANT VARCHAR(2) := '0';
        CV_PayTypeHib  CONSTANT VARCHAR(2) := '4';
        CV_PayTypeAtl  CONSTANT VARCHAR(2) := '3';

          PROCEDURE ic_valida_imei_pr(VP_TRANSAC IN VARCHAR2, EV_num_imei IN ga_aboamist.num_serie%TYPE);
          PROCEDURE ic_Desb_iPhone_pr(VP_TRANSAC IN VARCHAR2, EV_num_imei IN ga_aboamist.num_serie%TYPE);
          PROCEDURE ic_BuscaMov_iPhone_pr(VP_TRANSAC IN VARCHAR2, EV_num_imei IN ga_aboamist.num_serie%TYPE);

          FUNCTION ic_busca_parametros_fn (
                  ev_nom_parametro    IN               ged_parametros.nom_parametro%TYPE,
                  ev_cod_modulo       IN               ged_parametros.cod_modulo%TYPE,
                  en_cod_producto     IN               ged_parametros.cod_producto%TYPE,
                  sv_val_parametro    OUT NOCOPY       ged_parametros.val_parametro%TYPE,
                  sn_cod_retorno      OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
                  sv_mens_retorno     OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
                  sn_num_evento       OUT NOCOPY       ge_errores_pg.evento) RETURN BOOLEAN;

END IC_PROCPROVISION_PG;
/
SHOW ERRORS
