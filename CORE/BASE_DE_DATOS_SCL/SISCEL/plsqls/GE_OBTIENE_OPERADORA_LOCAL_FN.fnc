CREATE OR REPLACE FUNCTION GE_Obtiene_Operadora_Local_FN (SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
SN_num_evento     OUT NOCOPY ge_errores_pg.Evento) RETURN VARCHAR2 IS 

/*--
<Documentacion TipoDoc = "Funcion">
           Elemento Nombre = "GE_Obtiene_Operadora_Local_FN"
           Lenguaje="PL/SQL"
           Fecha="12/05/2009"
           Version="1.0.0"
           Diseñador="Vladimir Maureira"
           Programador="Vladimir Maureira
           Ambiente="BD"
<Retorno> VARCHAR2 </Retorno>
<Descripcion>
           retornar parametro Operadora
</Descripcion>
<Parametros>
<Entrada>
</Entrada>
<Salida>
           <param nom="SN_cod_retorno"     Tipo="NUMBER"> codigo retorno </param>
           <param nom="SV_mens_retorno"    Tipo="STRING"> glosa mensaje error </param>
           <param nom="SN_num_evento"      Tipo="NUMBER"> numero de evento </param>
</Salida>
</Parametros>
</Elemento>
</Documentacion>
--*/


PARAM_NO_CONFIG     EXCEPTION;
lv_des_error        ge_errores_pg.DesEvent;
LV_sSql             ge_errores_pg.vQuery;
lv_valor_texto      ge_parametros_sistema_vw.valor_texto%type;

CV_MODULO_GE         CONSTANT VARCHAR2(2)  := 'GE';
CV_ERROR_NO_CLASIF   CONSTANT VARCHAR2(30) := 'Error no clasificado';

CN_LARGOERRTEC       CONSTANT NUMBER       := 4000;
CN_LARGODESC         CONSTANT NUMBER       := 2000;


BEGIN
    SN_num_evento:= 0;
    SN_cod_retorno:=0;
    SV_mens_retorno:='';
    
 
    LV_sSql := 'SELECT  vw.valor_texto';
    LV_sSql := LV_sSql || ' FROM ge_parametros_sistema_vw vw';
    LV_sSql := LV_sSql || ' WHERE  vw.nom_parametro = COD_OPERADORA_LOCAL';
    LV_sSql := LV_sSql || ' AND    vw.cod_modulo    = ' || CV_MODULO_GE;
     
    SELECT  vw.valor_texto
    INTO    lv_valor_texto
    FROM  ge_parametros_sistema_vw vw
    WHERE  vw.nom_parametro = 'COD_OPERADORA_LOCAL'
    AND    vw.cod_modulo    = CV_MODULO_GE;
     
    IF lv_valor_texto IS NULL THEN
       RAISE PARAM_NO_CONFIG;
    END IF;
            
    return  lv_valor_texto;
 
EXCEPTION
WHEN PARAM_NO_CONFIG THEN
    SN_cod_retorno:=274;
    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
        SV_mens_retorno := 'Parametro No configurado';
    END IF;
    
    LV_des_error := SUBSTR('GE_Obtiene_Operadora_Local_FN(); - '|| SQLERRM,1,CN_LARGOERRTEC);
    SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_LARGODESC);
    SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_MODULO_GE,SV_mens_retorno, '1.0', USER,
    'GE_Obtiene_Operadora_Local_FN', LV_sSql, SN_cod_retorno, LV_des_error );
    return '';          
                                   
WHEN OTHERS THEN
    SN_cod_retorno:=4;
    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
        SV_mens_retorno := CV_ERROR_NO_CLASIF;
    END IF;
    
    LV_des_error := SUBSTR('OTHERS:GE_Obtiene_Operadora_Local_FN(); - '|| SQLERRM,1,CN_LARGOERRTEC);
    SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_LARGODESC);
    SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_MODULO_GE,SV_mens_retorno, '1.0', USER,
    'GE_Obtiene_Operadora_Local_FN', LV_sSql, SN_cod_retorno, LV_des_error );
    return '';
END;
/
SHOW ERRORS