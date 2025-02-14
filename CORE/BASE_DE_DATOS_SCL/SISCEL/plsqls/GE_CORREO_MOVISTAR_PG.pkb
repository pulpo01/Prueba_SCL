CREATE OR REPLACE PACKAGE BODY GE_CORREO_MOVISTAR_PG AS

/*---------------------------------------------------------------------------------------------------------------------------------*/
FUNCTION GE_GED_PARAMETROS_FN(EV_NOM_PARAMETRO   IN  VARCHAR2,
                              EV_COD_MODULO      IN  VARCHAR2,
                              EN_COD_PRODUCTO    IN  VARCHAR2,
                              SV_DES_PARAMETRO   OUT VARCHAR2,
                              SN_COD_ERROR       OUT NOCOPY NUMBER,
                              SV_MENS_RETORNO    OUT NOCOPY VARCHAR2,
                              SV_SQL             OUT NOCOPY VARCHAR2

) RETURN VARCHAR2
IS
   LV_VAL_PARAMETRO VARCHAR2(20);
BEGIN
    
    SV_SQL := ' SELECT VAL_PARAMETRO,DES_PARAMETRO';
    SV_SQL := SV_SQL || ' FROM   GED_PARAMETROS';
    SV_SQL := SV_SQL || ' WHERE  NOM_PARAMETRO =''' || EV_NOM_PARAMETRO ||'''';
    SV_SQL := SV_SQL || ' AND    COD_MODULO   = ''' || EV_COD_MODULO ||'''';
    SV_SQL := SV_SQL || ' AND    COD_PRODUCTO   = ' || EN_COD_PRODUCTO;
    
    SELECT VAL_PARAMETRO, DES_PARAMETRO
    INTO   LV_VAL_PARAMETRO,SV_DES_PARAMETRO
    FROM   GED_PARAMETROS
    WHERE  NOM_PARAMETRO = EV_NOM_PARAMETRO
    AND    COD_MODULO    = EV_COD_MODULO
    AND    COD_PRODUCTO  = EN_COD_PRODUCTO;
    
    RETURN LV_VAL_PARAMETRO;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
         SN_COD_ERROR    := 1362;
         SV_MENS_RETORNO := 'GE_GED_PARAMETROS_FN' ||' : '||' NO SE ENCUENTRA PARAMETROS DE SERVIDOR DE CORREOS.';
         RETURN '';
    WHEN OTHERS THEN
         SN_COD_ERROR    := 1362;
         SV_MENS_RETORNO := 'GE_GED_PARAMETROS_FN' ||' : '||SQLERRM;
         RETURN '';
END GE_GED_PARAMETROS_FN;
/*---------------------------------------------------------------------------------------------------------------------------------*/
FUNCTION GE_EMAIL_USU_FN(EV_TIP_CORREO   IN  ge_usuario_aplic_td.cod_programa%type,
                         SC_REG_EMAIL    OUT NOCOPY refcursor,
                         SN_COD_ERROR    OUT NOCOPY NUMBER,
                         SV_MENS_RETORNO OUT NOCOPY VARCHAR2,
                         SV_SQL          OUT NOCOPY VARCHAR2

) RETURN BOOLEAN
IS
   LV_EMAIL VARCHAR2(100);
BEGIN
    


        SV_SQL := ' SELECT EMAIL';
        SV_SQL := SV_SQL || ' FROM  GE_USUARIO_APLIC_TD B';
        SV_SQL := SV_SQL || ' WHERE B.COD_PROGRAMA =''' ||ev_tip_correo ||'''';
    
         OPEN SC_REG_EMAIL  FOR
         select b.email 
         from ge_usuario_aplic_td b
         where b.cod_programa = ev_tip_correo;
        


    
    RETURN TRUE;
EXCEPTION
    WHEN OTHERS THEN
         SN_COD_ERROR    := 1119;
         SV_MENS_RETORNO := 'GE_EMAIL_USU_FN' ||' : '||SQLERRM;
         RETURN FALSE;
END GE_EMAIL_USU_FN;
/*---------------------------------------------------------------------------------------------------------------------------------*/
FUNCTION GE_REC_INFO_CLIE_FN (EN_NUM_VENTA    IN ga_abocel.num_venta%TYPE,
                              SN_COD_CLIENTE  OUT NOCOPY ga_abocel.cod_cliente%TYPE,
                              SN_NUM_CELULAR  OUT NOCOPY ga_abocel.num_celular%TYPE,
                              SV_NOM_CLIENTE  OUT NOCOPY VARCHAR2,
                              SV_NUM_IMSI     OUT NOCOPY ga_abocel.num_serie%TYPE,
                              SN_COD_ERROR    OUT NOCOPY NUMBER,
                              SV_MENS_RETORNO OUT NOCOPY VARCHAR2,
                              SV_SQL          OUT NOCOPY VARCHAR2
) RETURN BOOLEAN
IS
BEGIN

    SV_SQL:=' SELECT  abon.cod_cliente';
    SV_SQL:=SV_SQL || ' ,abon.num_celular';     
    SV_SQL:=SV_SQL || ' ,clie.nom_cliente || '''' '''' || clie.nom_apeclien1 || '''' '''' || clie.nom_apeclien2';
    SV_SQL:=SV_SQL || ' ,abon.num_serie';      
    SV_SQL:=SV_SQL || ' FROM   ga_abocel abon, ge_clientes clie';
    SV_SQL:=SV_SQL || ' WHERE  abon.num_venta   =  '|| en_num_venta;
    SV_SQL:=SV_SQL || ' AND    clie.cod_cliente = abon.cod_cliente;';
   
    SELECT  abon.cod_cliente
           ,abon.num_celular
           ,clie.nom_cliente || ' ' || clie.nom_apeclien1 || ' ' || clie.nom_apeclien2
           ,sim.num_simcard
    into    sn_cod_cliente
           ,sn_num_celular
           ,sv_nom_cliente
           ,sv_num_imsi
    FROM   ga_abocel abon, ge_clientes clie,gsm_det_simcard_to sim
    WHERE  abon.num_venta   = en_num_venta
    AND    clie.cod_cliente = abon.cod_cliente
    AND    sim.num_simcard  = abon.num_serie
    AND    sim.cod_campo    = CV_campo_imsi;

   RETURN TRUE;

EXCEPTION
    WHEN OTHERS THEN
         SN_COD_ERROR    := 2917;
         SV_MENS_RETORNO := 'GE_REC_INFO_CLIE_FN' ||' : '||SQLERRM;
         RETURN FALSE;
END GE_REC_INFO_CLIE_FN;
/*---------------------------------------------------------------------------------------------------------------------------------*/
FUNCTION GE_ENVIA_CORREO_FN  (EN_COD_CLIENTE  IN ga_abocel.cod_cliente%TYPE,
                              EN_NUM_CELULAR  IN ga_abocel.num_celular%TYPE,
                              EV_NOM_CLIENTE  IN VARCHAR2,
                              EV_NUM_IMSI     IN ga_abocel.num_serie%TYPE,
                              EV_TIP_BB       IN VARCHAR2,
                              EV_SUBJECT      IN VARCHAR2,
                              EV_BODY         IN VARCHAR2,
                              EN_COD_CORREO   IN ge_usuario_aplic_td.cod_programa%TYPE,
                              SN_COD_ERROR    OUT NOCOPY NUMBER,
                              SV_MENS_RETORNO OUT NOCOPY VARCHAR2,
                              SV_SQL          OUT NOCOPY VARCHAR2
) RETURN BOOLEAN
IS
            
    LV_IPCORREO     VARCHAR2(20);
    LV_EMAIL        VARCHAR2(50);
    LV_EMAIL_USU    VARCHAR2(100);
    LV_NOM_CLIENTE  VARCHAR2(100);
    LV_DESC_PARAM   VARCHAR2(50);
    LV_Body         CLOB;
    LV_Subject      CLOB;
    LC_REG_EMAIL    refcursor;
    ERROR_FUNCION   EXCEPTION;    
BEGIN   
        
        LV_EMAIL_USU := '';
        LV_IPCORREO := GE_GED_PARAMETROS_FN('IP_SERVCORREO','GA',CN_cod_producto,LV_DESC_PARAM,SN_COD_ERROR,SV_MENS_RETORNO,SV_SQL); 
        LV_EMAIL    := GE_GED_PARAMETROS_FN('DIREMAIL_CC_MPA','GA',CN_cod_producto,LV_DESC_PARAM,SN_COD_ERROR,SV_MENS_RETORNO,SV_SQL);
        LV_EMAIL    := LV_DESC_PARAM;
        LV_Subject  := EV_SUBJECT || ' Cliente: ' || EN_COD_CLIENTE;
        
        IF NOT GE_EMAIL_USU_FN(EN_COD_CORREO,LC_REG_EMAIL,SN_COD_ERROR,SV_MENS_RETORNO,SV_SQL) THEN
            RAISE ERROR_FUNCION;
        END IF;
        
        LOOP
            FETCH LC_REG_EMAIL INTO LV_EMAIL_USU;
            EXIT WHEN LC_REG_EMAIL%NOTFOUND;
                LV_Body  := 'Estimado:'|| chr(13);
                LV_Body  := LV_Body ||chr(13)|| 'Con fecha ' || TO_CHAR(SYSDATE,'DD-MM-YYYY HH24:MI:SS')||chr(13);
                LV_Body  := LV_Body ||chr(13)|| 'Se ha contratado servicio: '||EV_BODY ||chr(13);
                LV_Body  := LV_Body ||chr(13)|| 'Código de Cliente : ' ||TO_CHAR(EN_COD_CLIENTE);
                LV_Body  := LV_Body ||chr(13)|| 'Nombre de Cliente : ' ||EV_NOM_CLIENTE;
                LV_Body  := LV_Body ||chr(13)|| 'Número de Teléfono: ' ||TO_CHAR(EN_NUM_CELULAR);
                IF EV_TIP_BB IS NOT NULL THEN
                    LV_Body  := LV_Body ||chr(13)|| 'IMSI: ' ||EV_NUM_IMSI;
                    LV_Body  := LV_Body ||chr(13)|| 'Tipo Correo BlackBerry :' ||EV_TIP_BB;
                END IF;
                LV_Body  := LV_Body ||chr(13);
                LV_Body  := LV_Body ||chr(13)|| 'Nota:';
                LV_Body  := LV_Body ||chr(13)|| 'Este correo es generado de manera automatica, por favor no lo conteste.';           
                VE_SERVICIOS_VENTA_PG.VE_ENVIAR_CORREO_PR(LV_EMAIL,LV_EMAIL_USU,LV_Subject,LV_Body,LV_IPCORREO);
        END LOOP;
        
        
        RETURN TRUE;
        
EXCEPTION
        WHEN ERROR_FUNCION THEN
        RETURN FALSE;
END GE_ENVIA_CORREO_FN;
                            
/*---------------------------------------------------------------------------------------------------------------------------------*/
PROCEDURE GE_ENVIO_CORREO_PR(EN_NUM_VENTA       IN ga_abocel.num_venta%TYPE,
                             EN_COD_CORREO      IN ge_usuario_aplic_td.cod_programa%TYPE,
                             EV_TIP_BB          IN VARCHAR2,
                             EV_SUBJECT         IN VARCHAR2,
                             EV_BODY            IN VARCHAR2,
                             SV_MENS_RETORNO    OUT NOCOPY VARCHAR2,
                             SN_NUM_EVENTO      OUT NOCOPY NUMBER )
IS
    LV_Sql              varchar2(2000);
    LN_COD_CLIENTE      ga_abocel.cod_cliente%TYPE;
    LN_NUM_CELULAR      ga_abocel.num_celular%TYPE;
    LV_NOM_CLIENTE      varchar2(100);
    LV_NUM_IMSI         ga_abocel.num_serie%TYPE;
    LN_COD_ERROR        number;
    LV_MENSAJE_RETORNO  varchar2(100);
    LV_TIP_BB           varchar2(15);
    lCursor             refCursor;
    ERROR_FUNCION       EXCEPTION;
    
BEGIN
    LV_Sql:='';
    SN_NUM_EVENTO := 0;
    SV_MENS_RETORNO := '';
   
    IF NOT GE_REC_INFO_CLIE_FN (en_num_venta,ln_cod_cliente,ln_num_celular,lv_nom_cliente,lv_num_imsi ,ln_cod_error,sv_mens_retorno ,lv_sql) THEN
        RAISE ERROR_FUNCION;
    END IF;
    
    IF  ev_tip_bb = 'I' THEN
        lv_tip_bb := CV_individual;
    ELSIF ev_tip_bb = 'P' THEN
        lv_tip_bb := CV_profesional;
    ELSIF ev_tip_bb = 'C' THEN
        lv_tip_bb := CV_corporativo;
    ELSE
        lv_tip_bb := NULL;
    END IF;
    IF NOT GE_ENVIA_CORREO_FN(LN_COD_CLIENTE,LN_NUM_CELULAR,LV_NOM_CLIENTE,LV_NUM_IMSI,LV_TIP_BB,EV_SUBJECT,EV_BODY,EN_COD_CORREO,LN_COD_ERROR,SV_MENS_RETORNO,LV_SQL) THEN
        RAISE ERROR_FUNCION;
    END IF;   
        
EXCEPTION
        WHEN ERROR_FUNCION THEN
                LV_MENSAJE_RETORNO:= SV_MENS_RETORNO;
                IF NOT GE_ERRORES_PG.MENSAJEERROR(LN_COD_ERROR,SV_MENS_RETORNO) THEN
                       SV_MENS_RETORNO := CV_error_no_clasif;
                END IF;                        
                SV_MENS_RETORNO := SV_MENS_RETORNO || ' ' || LV_MENSAJE_RETORNO;
                SN_NUM_EVENTO   := GE_ERRORES_PG.GRABARPL( SN_NUM_EVENTO, CV_COD_MODULO, SV_MENS_RETORNO, CV_VERSION, USER, 'GE_UPD_INFO_CLIENTES_PG', LV_Sql, LN_COD_ERROR, SV_MENS_RETORNO );
                ROLLBACK;
        WHEN OTHERS THEN
                LV_MENSAJE_RETORNO:= SV_MENS_RETORNO;
                IF NOT GE_ERRORES_PG.MENSAJEERROR(LN_COD_ERROR,SV_MENS_RETORNO) THEN
                       SV_MENS_RETORNO := CV_error_no_clasif;
                END IF;                        
                SV_MENS_RETORNO := SV_MENS_RETORNO || ' ' || LV_MENSAJE_RETORNO;
                SN_NUM_EVENTO   := GE_ERRORES_PG.GRABARPL( SN_NUM_EVENTO, CV_COD_MODULO, SV_MENS_RETORNO, CV_VERSION, USER, 'GE_UPD_INFO_CLIENTES_PG', LV_Sql, LN_COD_ERROR, SV_MENS_RETORNO );
                ROLLBACK;
END GE_ENVIO_CORREO_PR;

END GE_CORREO_MOVISTAR_PG;
/
SHOW ERRORS