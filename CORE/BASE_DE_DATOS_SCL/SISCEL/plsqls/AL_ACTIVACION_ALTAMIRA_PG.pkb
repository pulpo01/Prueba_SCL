CREATE OR REPLACE PACKAGE BODY AL_ACTIVACION_ALTAMIRA_PG AS

    PROCEDURE AL_ASIGNA_SERIE_PR(SN_cod_retorno  OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                 SV_mens_retorno OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                 SN_num_evento   OUT NOCOPY ge_errores_pg.evento)IS
 
    LV_des_error    ge_errores_pg.DesEvent;
    LV_sSql         ge_errores_pg.vQuery; 
    LV_tecnologiaGSM ged_parametros.val_parametro%TYPE;   
    LV_nomparametroGSM VARCHAR2(13) := 'GRUPO_TEC_GSM'; 
    LV_situacionBAA VARCHAR2(3) := 'BAA';                                
                                   
    BEGIN
        SN_cod_retorno := 0;
        SV_mens_retorno := 'Ok';  
            
        LV_sSql := 'GE_FN_DEVVALPARAM(' || CV_cod_modulo_GA || ', ' || CV_cod_producto || ', ' || 'LV_nomparametroGSM)';          
        LV_tecnologiaGSM := GE_FN_DEVVALPARAM(CV_cod_modulo_GA, CV_cod_producto, LV_nomparametroGSM);

        LV_sSql := 'UPDATE al_activacion_altamira_to a';
        LV_sSql := LV_sSql || ' SET a.num_serie = ';
        LV_sSql := LV_sSql || ' (SELECT decode(b.cod_tecnologia,''' || LV_tecnologiaGSM || ''',b.num_imei,b.num_serie) ';
        LV_sSql := LV_sSql || ' FROM ga_aboamist b ';
        LV_sSql := LV_sSql || ' WHERE a.num_celular = b.num_celular';
        LV_sSql := LV_sSql || ' AND b.cod_situacion NOT IN (''BAA'') and rownum=1)';
        LV_sSql := LV_sSql || ' WHERE a.num_serie IS NULL;'; 
        
        UPDATE al_activacion_altamira_to a
        SET a.num_serie = 
            (SELECT decode(b.cod_tecnologia, LV_tecnologiaGSM, b.num_imei, b.num_serie) 
            FROM ga_aboamist b 
            WHERE a.num_celular = b.num_celular 
            AND b.cod_situacion NOT IN (LV_situacionBAA) and rownum=1)
        WHERE a.num_serie IS NULL;              
        
    COMMIT;    
    
    EXCEPTION
    WHEN OTHERS THEN
       SN_cod_retorno := 2940; --Error al Actualizar Numero de serie en tabla de Activaciones Altamira
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;

       LV_des_error   := 'AL_ACTIVACION_ALTAMIRA_PG.AL_ASIGNA_SERIE_PR()' || SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'AL_ACTIVACION_ALTAMIRA_PG.AL_ASIGNA_SERIE_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
    END;
END;
/
SHOW ERRORS