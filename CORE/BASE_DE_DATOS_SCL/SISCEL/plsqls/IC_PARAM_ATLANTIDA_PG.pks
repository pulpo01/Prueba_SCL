CREATE OR REPLACE PACKAGE IC_Param_Atlantida_PG
/*
<Documentación
        TipoDoc = "Package">
        <Elemento
                Nombre = "IC_Param_Atlantida_PG"
                Lenguaje="PL/SQL"
                Fecha creación="03-2006"
                Creado por="Juan Gonzalez C."
                Fecha modificacion=""
                Modificado por=""
                Ambiente Desarrollo="BD">
                <Retorno>N/A</Retorno>
                <Descripción>Contiene funciones que rescatan valores de parametros para ser enviados en los Comandos hacia la Plataforma Atlantida</Descripción>
                <Parámetros>
                        <Entrada>N/A</Entrada>
                        <Salida>N/A</Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/
IS
        CN_Producto CONSTANT NUMBER(1) := 1;
        CV_MensajeNoRep VARCHAR2(50) := 'Representante no identificado';
        CV_Modulo_Cen CONSTANT VARCHAR2(2) := 'IC';
        CV_Modulo_Fac CONSTANT VARCHAR2(2) := 'FA';
        CV_NomPar01 CONSTANT VARCHAR2(16) := 'SERV_VPN';
        CV_ParFlagPorc CONSTANT VARCHAR2(16) := 'FLAG_PORCENTAJE'; -- aplicabilidad de porcentaje.
        CV_ParFlagCalculo CONSTANT VARCHAR2(16) := 'FLAG_CALCULO';
        CV_ParFlagFactor CONSTANT VARCHAR2(16) := 'FLAG_FACTOR';
        CV_ParLimDefecto CONSTANT VARCHAR2(16) := 'LIM_DEFECTO';
        CV_Plataforma CONSTANT VARCHAR2(16) := 'ATLANTIDA';
        CV_TipCodigo CONSTANT VARCHAR2(16) := '10007'; -- para Planes Atlantida.
        CV_TipCodPorc CONSTANT VARCHAR2(16) := '10008'; -- para Porcentajes por plan.
        CV_TipMaxAbrev CONSTANT VARCHAR2(16) := '10009'; -- para MaxAbreviados por plan.
        CN_Err_Abo CONSTANT NUMBER(3) := 203;
        CN_Err_Cli CONSTANT NUMBER(3) := 149;
        CN_Err_Usuario CONSTANT NUMBER(7) := 300008;
        CN_Err_Fec CONSTANT NUMBER(3) := 289;
        CN_Err_Emp CONSTANT NUMBER(3) := 502;
        CN_Err_Cel CONSTANT NUMBER(3) := 480;
        CN_Err_TipPlan CONSTANT NUMBER(3) := 282;
        CN_Err_Promo CONSTANT NUMBER(3) := 203;
        CV_Err_NoClasif VARCHAR2(25) := 'Error no Clasificado';
        CV_Existe CONSTANT VARCHAR2(2) := '1';
        CV_Ejecuta CONSTANT VARCHAR2(2) := '1';
        CV_NoTiene CONSTANT VARCHAR2(2) := '1';
        CV_NoData CONSTANT VARCHAR2(2) := '0';
        CV_LimiteCte CONSTANT VARCHAR2(2) := '1';
        CV_TecnoGSM CONSTANT VARCHAR2(4) := 'GSM';
        CV_TecnoTDMA CONSTANT VARCHAR2(4) := 'TDMA';
        CV_TecnoCDMA CONSTANT VARCHAR2(4) := 'CDMA';
        CN_PlanPrep  CONSTANT NUMBER(1) := 1;
        CN_PlanPost  CONSTANT NUMBER(1) := 2;
        CN_PlanHibr  CONSTANT NUMBER(1) := 3;

        CN_EstSuspen  CONSTANT NUMBER(1) := 0;
        CN_EstActivo  CONSTANT NUMBER(1) := 1;
        CN_EstPendCrea  CONSTANT NUMBER(1) := 2;
        CN_EstPendModi  CONSTANT NUMBER(1) := 3;
        CN_EstPendElim  CONSTANT NUMBER(1) := 4;
        CV_AltaActivAbo CONSTANT VARCHAR2(3) := 'AAA';

        CV_ParamSmsPrep CONSTANT VARCHAR2(20) := 'PARAM_SMSPRE';
        CV_ParamSmsHibr CONSTANT VARCHAR2(20) := 'PARAM_SMSHIB';
        CV_ParamSmsPost CONSTANT VARCHAR2(20) := 'PARAM_SMSPOS';
        CV_ParamSmsAtla CONSTANT VARCHAR2(20) := 'PARAM_SMSATL';
        CV_Fecha_Abierta CONSTANT VARCHAR2(10) := '31/12/3000';
        CV_Formato_Fecha CONSTANT VARCHAR2(10) := 'dd/mm/yyyy';

FUNCTION IC_NumAbonado_FN(
        EN_num_mov IN icc_movimiento.num_movimiento%TYPE) RETURN NUMBER;
FUNCTION IC_IdEmpresa_FN(
        EN_num_mov IN icc_movimiento.num_movimiento%TYPE) RETURN STRING;
FUNCTION IC_LimiteEmpresa_FN(
        EN_num_mov IN icc_movimiento.num_movimiento%TYPE) RETURN STRING;
FUNCTION IC_LimiteConsumo_FN(
        EN_num_mov IN icc_movimiento.num_movimiento%TYPE) RETURN STRING;
FUNCTION IC_LimiteConsumo2_FN(
        EN_num_mov IN icc_movimiento.num_movimiento%TYPE) RETURN STRING;
FUNCTION IC_LimiteConsumo3_FN(
        EN_num_mov IN icc_movimiento.num_movimiento%TYPE) RETURN STRING;
FUNCTION IC_LimiteConsumo4_FN(
        EN_num_mov IN icc_movimiento.num_movimiento%TYPE) RETURN STRING;
FUNCTION IC_LimiteConsumo5_FN(
        EN_num_mov IN icc_movimiento.num_movimiento%TYPE) RETURN STRING;
FUNCTION IC_LimiteConsumo6_FN(
        EN_num_mov IN icc_movimiento.num_movimiento%TYPE) RETURN STRING;
FUNCTION IC_CargoBasPorcen_FN(
        EN_num_mov IN icc_movimiento.num_movimiento%TYPE) RETURN STRING;
FUNCTION IC_LimiteUsuario_FN(
        EN_num_mov IN icc_movimiento.num_movimiento%TYPE) RETURN STRING;
FUNCTION IC_FecReseteo_FN(
        EN_num_mov IN icc_movimiento.num_movimiento%TYPE) RETURN STRING;
FUNCTION IC_NomRepEmp_FN(
        EN_num_mov IN icc_movimiento.num_movimiento%TYPE) RETURN STRING;
FUNCTION IC_EMail_FN(
        EN_num_mov IN icc_movimiento.num_movimiento%TYPE) RETURN STRING;
FUNCTION IC_NumCorto_FN(
        EN_num_mov IN icc_movimiento.num_movimiento%TYPE) RETURN STRING;
FUNCTION IC_TipoPlan_FN(
        EN_num_mov IN icc_movimiento.num_movimiento%TYPE) RETURN STRING;
FUNCTION IC_TipoPlan2_FN(
        EN_num_mov IN icc_movimiento.num_movimiento%TYPE) RETURN STRING;
FUNCTION IC_ExisteAboEmp_FN(
        EN_num_mov IN icc_movimiento.num_movimiento%TYPE) RETURN STRING;
FUNCTION IC_EsTraspaso_FN(
        EN_num_mov IN icc_movimiento.num_movimiento%TYPE) RETURN STRING;
FUNCTION IC_NoTieneVPN_FN(
        EN_num_mov IN icc_movimiento.num_movimiento%TYPE) RETURN STRING;
FUNCTION IC_MaxAbreviados_FN(
        EN_num_mov IN icc_movimiento.num_movimiento%TYPE) RETURN STRING;
FUNCTION IC_NombreEmpresa_FN(
        EN_num_mov IN icc_movimiento.num_movimiento%TYPE) RETURN STRING;
FUNCTION IC_ValidaCambioPlan_FN(
        EN_num_mov IN icc_movimiento.num_movimiento%TYPE) RETURN STRING;
FUNCTION IC_ValTipoPlanTarif_FN(
        EN_Num_Mov IN icc_movimiento.num_movimiento%TYPE) RETURN NUMBER;
FUNCTION IC_ATLADATOSLINEA_FN(
        EN_num_mov IN icc_movimiento.num_movimiento%TYPE) RETURN STRING;
FUNCTION IC_CTAPERMODIF_FN(
        EN_num_mov IN icc_movimiento.num_movimiento%TYPE) RETURN STRING;
FUNCTION IC_CTAPERBAJA_FN(
        EN_num_mov IN icc_movimiento.num_movimiento%TYPE) RETURN STRING;
FUNCTION IC_CTAPERCAMNUM_FN(
        EN_num_mov IN icc_movimiento.num_movimiento%TYPE) RETURN STRING;
FUNCTION IC_CTAPERMASIVO_FN(
        EN_num_mov IN icc_movimiento.num_movimiento%TYPE) RETURN STRING;
FUNCTION IC_ATLACUENTAPER_FN(
        EN_num_mov IN icc_movimiento.num_movimiento%TYPE) RETURN STRING;
FUNCTION IC_IdEmpresa_Icc_Mov_FN(
        EN_num_mov IN icc_movimiento.num_movimiento%TYPE) RETURN STRING;
FUNCTION IC_ExisteAboEmp_Icc_Mov_FN(
        EN_num_mov IN icc_movimiento.num_movimiento%TYPE) RETURN STRING;
FUNCTION IC_NombreEmpresa_Icc_Mov_FN(
        EN_num_mov IN icc_movimiento.num_movimiento%TYPE) RETURN STRING;
END IC_Param_Atlantida_PG;
/
SHOW ERRORS
