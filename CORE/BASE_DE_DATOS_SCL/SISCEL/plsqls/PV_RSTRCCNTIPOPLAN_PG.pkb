CREATE OR REPLACE PACKAGE BODY Pv_Rstrccntipoplan_Pg IS

PROCEDURE PV_Prepago_PR( 
                                  EV_param_entrada IN         VARCHAR2,
                                SV_resultado     OUT NOCOPY VARCHAR2,
                                SV_mensaje       OUT NOCOPY ga_transacabo.des_cadena%TYPE
                            )  IS 

string GE_TABTYPE_VCH2ARRAY:= GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');

LN_codtiplan                   ta_plantarif.cod_tiplan%TYPE;
LN_num_abonado                   ga_abocel.num_abonado%TYPE;
LV_tip_plan_prep              ged_parametros.val_parametro%TYPE;

BEGIN

    GE_PAC_ARREGLOPR.GE_PR_RETORNAARREGLO(EV_param_entrada, string);
    LN_num_abonado := TO_NUMBER(string(5));
    
    SELECT val_parametro INTO LV_tip_plan_prep
    FROM ged_parametros 
    WHERE nom_parametro = 'TIP_PLAN_PREPAGO'
    AND cod_modulo='GA'
    AND cod_producto=1;
    
    SELECT b.cod_tiplan INTO LN_codtiplan
    FROM ga_abocel a, ta_plantarif b 
    WHERE a.num_abonado = LN_num_abonado
    AND a.cod_plantarif = b.cod_plantarif
    UNION
    SELECT cod_tiplan
    FROM ga_aboamist a, ta_plantarif b 
    WHERE a.num_abonado = LN_num_abonado
    AND a.cod_plantarif = b.cod_plantarif;
    
    IF TO_NUMBER(LV_tip_plan_prep) =  LN_codtiplan THEN
           SV_RESULTADO := 'FALSE';
        SV_MENSAJE := 'La operación no puede continuar porque el tipo de plan del abonado es prepago.';
    ELSE
        SV_RESULTADO := 'TRUE';
    END IF;

EXCEPTION    
    WHEN OTHERS THEN
               SV_RESULTADO := 'FALSE';
            SV_MENSAJE := 'Error en el pl-sql PV_RstrccnTipoPlanAbonado.PV_Prepago_PR.';
END PV_Prepago_PR;

PROCEDURE PV_Hibrido_PR( 
                                  EV_param_entrada IN         VARCHAR2,
                                SV_resultado     OUT NOCOPY VARCHAR2,
                                SV_mensaje       OUT NOCOPY ga_transacabo.des_cadena%TYPE
                            )  IS 

string GE_TABTYPE_VCH2ARRAY:= GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');

LN_codtiplan                   ta_plantarif.cod_tiplan%TYPE;
LN_num_abonado                   ga_abocel.num_abonado%TYPE;
LV_tip_plan_hib                  ged_parametros.val_parametro%TYPE;

BEGIN

    GE_PAC_ARREGLOPR.GE_PR_RETORNAARREGLO(EV_param_entrada, string);
    LN_num_abonado := TO_NUMBER(string(5));
    
    SELECT val_parametro INTO LV_tip_plan_hib
    FROM ged_parametros 
    WHERE nom_parametro = 'TIP_PLAN_HIBRIDO'
    AND cod_modulo='GA'
    AND cod_producto=1;
    
    SELECT b.cod_tiplan INTO LN_codtiplan
    FROM ga_abocel a, ta_plantarif b 
    WHERE a.num_abonado = LN_num_abonado
    AND a.cod_plantarif = b.cod_plantarif
    UNION
    SELECT cod_tiplan
    FROM ga_aboamist a, ta_plantarif b 
    WHERE a.num_abonado = LN_num_abonado
    AND a.cod_plantarif = b.cod_plantarif;
    
    IF TO_NUMBER(LV_tip_plan_hib) = LN_codtiplan THEN
           SV_RESULTADO := 'FALSE';
        SV_MENSAJE := 'La operación no puede continuar porque el tipo de plan del abonado es hibrido.';
    ELSE
        SV_RESULTADO := 'TRUE';
    END IF;

EXCEPTION    
    WHEN OTHERS THEN
               SV_RESULTADO := 'FALSE';
            SV_MENSAJE := 'Error en el pl-sql PV_RstrccnTipoPlanAbonado.PV_Hibrido_PR.';
END PV_Hibrido_PR;

PROCEDURE PV_Postpago_PR( 
                                  EV_param_entrada IN         VARCHAR2,
                                SV_resultado     OUT NOCOPY VARCHAR2,
                                SV_mensaje       OUT NOCOPY ga_transacabo.des_cadena%TYPE
                            )  IS 

string GE_TABTYPE_VCH2ARRAY:= GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');

LN_codtiplan                   ta_plantarif.cod_tiplan%TYPE;
LN_num_abonado                   ga_abocel.num_abonado%TYPE;
LV_tip_plan_pos                  ged_parametros.val_parametro%TYPE;

BEGIN

    GE_PAC_ARREGLOPR.GE_PR_RETORNAARREGLO(EV_param_entrada, string);
    LN_num_abonado := TO_NUMBER(string(5));
    
    SELECT val_parametro INTO LV_tip_plan_pos
    FROM ged_parametros 
    WHERE nom_parametro = 'TIPOPOSTPAGO'
    AND cod_modulo='GA'
    AND cod_producto=1;
    
    SELECT b.cod_tiplan INTO LN_codtiplan
    FROM ga_abocel a, ta_plantarif b 
    WHERE a.num_abonado = LN_num_abonado
    AND a.cod_plantarif = b.cod_plantarif
    UNION
    SELECT cod_tiplan
    FROM ga_aboamist a, ta_plantarif b 
    WHERE a.num_abonado = LN_num_abonado
    AND a.cod_plantarif = b.cod_plantarif;
    
    IF TO_NUMBER(LV_tip_plan_pos) = LN_codtiplan THEN
           SV_RESULTADO := 'FALSE';
        SV_MENSAJE := 'La operación no puede continuar porque el tipo de plan del abonado es pospago.';
    ELSE
        SV_RESULTADO := 'TRUE';
    END IF;

EXCEPTION    
    WHEN OTHERS THEN
               SV_RESULTADO := 'FALSE';
            SV_MENSAJE := 'Error en el pl-sql PV_RstrccnTipoPlanAbonado.PV_Postpago_PR.';
END PV_Postpago_PR;

END PV_RstrccnTipoPlan_pg; 
/
SHOW ERRORS
