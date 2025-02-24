CREATE OR REPLACE PACKAGE IC_PARAMPROVISION_PG
/*
<Documentación
        TipoDoc = "Package">
        <Elemento
                Nombre = "IC_PARAMPROVISION_PG"
                Lenguaje="PL/SQL"
                Fecha creación="07-2009"
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
        CN_ind_ipfija CONSTANT NUMBER(1) := 1;
        CN_ind_comerc CONSTANT NUMBER(1) := 1;
        CN_ind_no_comerc CONSTANT NUMBER(1) := 0;
       CN_ind_avlini CONSTANT NUMBER(1) := 0;
        CV_tipo_KIT   CONSTANT VARCHAR2(25) := 'TIP_ARTICULO_KIT';
        CV_SIKIT      CONSTANT VARCHAR2(2) := 'S';
        CV_NOKIT      CONSTANT VARCHAR2(2) := 'N';
        CV_SS_FAX     CONSTANT VARCHAR2(25) := 'SS_FAX';        
        CV_MensajeNoRep VARCHAR2(50) := 'Representante no identificado';
        CV_Modulo_Cen CONSTANT VARCHAR2(2) := 'IC';
        CV_Modulo_AL  CONSTANT VARCHAR2(2) := 'AL';
        CV_Modulo_GA  CONSTANT VARCHAR2(2) := 'GA';        
        CN_Err_Abo CONSTANT NUMBER(3) := 203;
        CN_Err_Cli CONSTANT NUMBER(3) := 149;
        CN_Err_Usuario CONSTANT NUMBER(7) := 300008;
        CN_Err_TipPlan CONSTANT NUMBER(3) := 282;
        CV_Err_NoClasif VARCHAR2(25) := 'Error no Clasificado';

        CN_PlanPrep  CONSTANT NUMBER(1) := 1;
        CN_PlanPost  CONSTANT NUMBER(1) := 2;
        CN_PlanHibr  CONSTANT NUMBER(1) := 3;

          FUNCTION IC_ALTADATAIPFIJA_FN(EN_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING;
          FUNCTION IC_BAJADATAIPFIJA_FN(EN_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING;
          FUNCTION IC_MODIFDATAIPFIJA_FN(EN_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING;          
          FUNCTION IC_NUMMOV_FN(EN_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING;

          FUNCTION IC_CLICODCLIANT_FN(EN_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING;
          FUNCTION IC_CODCTAANT_FN(EN_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING;
          FUNCTION IC_PLAN_ACTUAL_FN(EN_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING;
          FUNCTION IC_CICLO_FN(EN_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING;
          FUNCTION IC_SMSPROMOBLOQ_FN(EN_NUM_MOV IN icc_movimiento.num_movimiento%TYPE) RETURN STRING;
          FUNCTION IC_SMSPROMOSUSP_FN(EN_NUM_MOV IN icc_movimiento.num_movimiento%TYPE) RETURN STRING;
          FUNCTION IC_SMSPROMOSINIESTRO_FN(EN_NUM_MOV IN icc_movimiento.num_movimiento%TYPE) RETURN STRING;
          FUNCTION IC_IDPROMO_FN(EN_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING;
          FUNCTION IC_NUMEROSFF_FN(EN_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING;
          FUNCTION IC_SERVICIOVPN_FN(EN_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING;
          FUNCTION IC_CODPRESTACION_FN(EN_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING;
          FUNCTION IC_PRESTACION_ART_FN(EN_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING;
          FUNCTION IC_OPERADOR_FN(EN_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING;
          FUNCTION IC_LISTA_OPERMOTIVO_FN(EN_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING;
          FUNCTION IC_DISPOSITIVOAVL_FN(EN_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING;
          FUNCTION IC_NUMEROFAX_FN(EN_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING;
          FUNCTION IC_SEC_BOLSAS_FN(EN_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING;
          FUNCTION IC_PLANCOMVERSE_FN(EN_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING;
          FUNCTION IC_FECCORTE_FN(EN_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING;
                    
END IC_PARAMPROVISION_PG; 
/
SHOW ERRORS
