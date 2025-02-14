CREATE OR REPLACE PACKAGE BODY GA_CONVERSION_MONETARIA_PG IS

FUNCTION GA_CONVIERTE_MONTO_FN ( EV_COD_MONEDA     IN  VARCHAR,
                                 EN_COD_CLIENTE    IN  NUMBER,
                                 EN_MONTO_ORIGEN   IN  NUMBER,
                                 EV_FECHA_ORIGEN   IN  VARCHAR2)  RETURN NUMBER                       
IS

LN_MONTO_DESTINO  NUMBER;
LN_cod_retorno    ge_errores_pg.CodError;
LV_mens_retorno   ge_errores_pg.MsgError;
LN_num_evento     ge_errores_pg.Evento;
LN_valor          NUMBER;
ERROR_FUNCION     EXCEPTION;
BEGIN

    SELECT COUNT(1)
    INTO LN_valor
    FROM GED_PARAMETROS
    WHERE NOM_PARAMETRO = 'MONEDA_LOCAL'
    AND   VAL_PARAMETRO = EV_COD_MONEDA;
    
    IF LN_valor = 0 THEN
        GA_CONVIERTE_MONTO_PR(en_cod_cliente,en_monto_origen,ev_fecha_origen,ln_monto_destino,ln_cod_retorno, lv_mens_retorno,ln_num_evento);
        IF ln_num_evento <> 0 then
            RAISE ERROR_FUNCION;
        end if;
    ELSE
        ln_monto_destino:= en_monto_origen;
    END IF;
    RETURN ln_monto_destino;

EXCEPTION
    WHEN ERROR_FUNCION THEN
        LN_num_evento := -LN_num_evento;
        RETURN LN_num_evento;

    WHEN OTHERS THEN
        RETURN -1;


END GA_CONVIERTE_MONTO_FN;
  
PROCEDURE GA_CONVIERTE_MONTO_PR (EN_COD_CLIENTE    IN  NUMBER,
                                 EN_MONTO_ORIGEN   IN  NUMBER,
                                 EV_FECHA_ORIGEN   IN  VARCHAR2,
                                 EN_MONTO_DESTINO  OUT NOCOPY NUMBER,
                                 SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                 SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                 SN_num_evento     OUT NOCOPY ge_errores_pg.Evento)                                 
IS
        LV_SQL              GE_ERRORES_PG.vQuery;
        LV_DES_ERROR        GE_ERRORES_PG.DesEvent;
        NO_HAY_CATEGORIA    EXCEPTION;
        NO_HAY_CONVERSION   EXCEPTION;        
        LN_IND_CONVERSION   FA_TASA_CAMBIO_TD.IND_CONVERSION%TYPE;
        LN_VALOR            FA_TASA_CAMBIO_TD.VALOR%TYPE;
        LN_DIA_MES_APLIC    FA_TASA_CAMBIO_TD.DIA_MES_APLIC%TYPE;
        LN_CATEGORIA_CAMBIO FA_TASA_CAMBIO_TD.COD_CATEGORIA_CAMBIO%TYPE;
        LV_MONEDA_LOCAL     GED_PARAMETROS.VAL_PARAMETRO%TYPE;
        LN_CAMBIO           GE_CONVERSION.CAMBIO%TYPE;
        LD_FECHA_ORIGEN     DATE;
        LB_EXITO            BOOLEAN := FALSE;
        LV_FECHAAUX         VARCHAR2(14);
        LV_DIAAUX           VARCHAR2(2);
        LV_DIAsEMANA        VARCHAR2(2);        
        LV_DIACICLO         VARCHAR2(2);        
        LV_MESCICLO         VARCHAR2(2);
        LV_ANOCICLO         VARCHAR2(4);
        LV_FECHACICLO       VARCHAR2(8);
        LV_NOMBREDIA        VARCHAR2(20);
        LN_NUMERODIAFESTIVO NUMBER;
        LN_NUMEROFESTIVO    NUMBER;
       
--Conversion Monetaria
--1.- Verificar la Categoria de Tasa de Cambio (FA_TASA_CAMBIO_TO)
--2.- Una vez visto esto verificar IND_CONVERSION 0: Se va a la GE_CONVERSION como siempre 
--    si es uno se basa en los valores de la FA_TASA_CAMBIO_TO
--2.1 Verificar Valor de IND_VALOR si este es 0 validar el dia de la tasa en base a 
--    GE_CONVERSION en base al campo DIA_MES_APLIC,
--1: Validar campo valor de la tabla FA_TASA_CAMBIO_TO
BEGIN
    
            LD_FECHA_ORIGEN := TO_DATE(EV_FECHA_ORIGEN,'YYYYMMDDHH24MISS');
            
            LN_IND_CONVERSION := 0;  
            
            --1.- Query que va a la GE_CLIENTE_TASA_TO
            BEGIN
                SELECT COD_CATEGORIA_CAMBIO
                INTO   LN_CATEGORIA_CAMBIO
                FROM   GE_CLIENTE_TASA_TO 
                WHERE  COD_CLIENTE = EN_COD_CLIENTE;
            EXCEPTION
                -- Cliente No Registra Categoria de Cambio
                WHEN NO_DATA_FOUND THEN
                     LN_IND_CONVERSION := 3;                      
            END;
            
            IF LN_IND_CONVERSION = 3 THEN
               --Consulta GE_CONVERSION, Cliente No Reguistra Categoria de Cambio
               BEGIN
                   SELECT CAMBIO 
                   INTO   LN_CAMBIO
                   FROM   GE_CONVERSION 
                   WHERE  SYSDATE BETWEEN FEC_DESDE AND FEC_HASTA
                   AND    COD_MONEDA NOT IN (SELECT VAL_PARAMETRO
                                             FROM GED_PARAMETROS
                                             WHERE NOM_PARAMETRO = 'MONEDA_LOCAL')                      
                   AND    ROWNUM=1;
               
                   EN_MONTO_DESTINO := EN_MONTO_ORIGEN * LN_CAMBIO;
               
               EXCEPTION
                   WHEN NO_DATA_FOUND THEN
                        RAISE NO_HAY_CONVERSION;
               END;
                           
            ELSE -- LN_IND_CONVERSION = 3
            
            -- Obtener Valores de  FA_TASA_CAMBIO_TO
               BEGIN
                   SELECT IND_CONVERSION,VALOR,DIA_MES_APLIC
                   INTO   LN_IND_CONVERSION,LN_VALOR,LN_DIA_MES_APLIC
                   FROM   FA_TASA_CAMBIO_TD 
                   WHERE  COD_CATEGORIA_CAMBIO = LN_CATEGORIA_CAMBIO;
                   
               EXCEPTION
                   WHEN NO_DATA_FOUND THEN
                        RAISE NO_HAY_CATEGORIA;
               END; 
               
               IF LN_IND_CONVERSION=0 THEN 
                  -- Consulta GE_CONVERSION
                  BEGIN
                      SELECT CAMBIO 
                      INTO   LN_CAMBIO
                      FROM   GE_CONVERSION 
                      WHERE  SYSDATE BETWEEN FEC_DESDE AND FEC_HASTA
                      AND    COD_MONEDA NOT IN (SELECT VAL_PARAMETRO
                                                   FROM GED_PARAMETROS
                                                   WHERE NOM_PARAMETRO = 'MONEDA_LOCAL')                      
                      AND    ROWNUM=1;                    
               
                      EN_MONTO_DESTINO := EN_MONTO_ORIGEN * LN_CAMBIO;
               
                  EXCEPTION
                   WHEN NO_DATA_FOUND THEN
                        RAISE NO_HAY_CONVERSION;
                  END;
                                                
               ELSE -- LN_IND_CONVERSION=0   
               
                  -- Si IND_VALOR=0 DE FA_TASA_CAMBIO_TO E IND_CONVERSION=1 query 
                  -- Para Obtener el dia especifico 
                  IF LN_DIA_MES_APLIC <> 0 THEN
                  
                     SELECT TRIM(TO_CHAR(ADD_MONTHS(LD_FECHA_ORIGEN, - 1),'YYYYMMDDHH24MISS'))
                     INTO   LV_FECHAAUX
                     FROM   DUAL;
                     
                     SELECT TO_CHAR(LAST_DAY(TO_DATE(LV_FECHAAUX,'YYYYMMDDHH24MISS')),'DD'),
                            TO_CHAR(TO_DATE(LV_FECHAAUX,'YYYYMMDDHH24MISS'),'MM'),
                            TO_CHAR(TO_DATE(LV_FECHAAUX,'YYYYMMDDHH24MISS'),'YYYY')
                     INTO   LV_DIAAUX, 
                            LV_MESCICLO, 
                            LV_ANOCICLO
                     FROM   DUAL;
                     
                     -- Comparación Dia ingresado con último día del mes
                     IF (TO_NUMBER(LN_DIA_MES_APLIC) > TO_NUMBER(LV_DIAAUX)) THEN                           
                         LV_DIACICLO := LV_DIAAUX; 
                     ELSE
                         IF LN_DIA_MES_APLIC > 9 THEN
                            LV_DIACICLO := TO_CHAR(LN_DIA_MES_APLIC);
                         ELSE
                            LV_DIACICLO := '0'||TO_CHAR(LN_DIA_MES_APLIC);
                         END IF;
                     END IF;
                  
                     LV_FECHACICLO := LV_ANOCICLO || LV_MESCICLO || LV_DIACICLO;
                  
                     IF TO_NUMBER(LV_DIACICLO) <> 1 AND TO_NUMBER(LV_DIACICLO) <> 31 THEN                                                                          
                  
                        WHILE NOT LB_EXITO LOOP
                         -- Al Restar dia este es el primer dia del mes, aplico conversión con esta fecha
                           IF TO_NUMBER(TO_CHAR(TO_DATE(LV_FECHACICLO,'YYYYMMDD'),'DD')) = 1 OR 
                              TO_NUMBER(TO_CHAR(TO_DATE(LV_FECHACICLO,'YYYYMMDD'),'DD')) = 31 THEN                           
                              LB_EXITO := TRUE;
                           ELSE                             
    	                     SELECT TO_CHAR(TO_DATE(LV_FECHACICLO,'YYYYMMDD'),'D'), 
    	                            TO_CHAR(TO_DATE(LV_FECHACICLO,'YYYYMMDD'),'DAY')
    	                     INTO   LV_DIASEMANA, LV_NOMBREDIA
    	                     FROM   DUAL;                                                  
                           
                             IF (TO_NUMBER(LV_DIASEMANA) = 6 OR TO_NUMBER(LV_DIASEMANA) = 7) THEN
                                 -- Si es Domingo o Sabado resto un día 
    	                         SELECT TO_CHAR(TO_DATE(LV_FECHACICLO,'YYYYMMDD') - 1 ,'YYYYMMDD')
    	                         INTO   LV_FECHACICLO
    	                         FROM   DUAL;                               
                             ELSE
                                 -- Consultar si es Festivo
                                 SELECT COUNT(1)
                                 INTO   LN_NUMERODIAFESTIVO
                                 FROM   FA_DIASFEST
                                 WHERE  FEC_FESTIVO = TO_DATE(LV_FECHACICLO,'YYYYMMDD');
                               
                                 IF (LN_NUMEROFESTIVO > 0) THEN
                                     --Si es Festivo resto un día 
    	                             SELECT TO_CHAR(TO_DATE(LV_FECHACICLO,'YYYYMMDD') - 1 ,'YYYYMMDD')
    	                             INTO   LV_FECHACICLO
    	                             FROM   DUAL;                               
                                 ELSE
                                     --Si no, es una Fecha Habil
                                     LB_EXITO := TRUE;                               
                                 END IF;                                   
                                                          
                             END IF;
                           
                           END IF;                           
                                                       
	                    END LOOP;
                     END IF;                   
                   
                     BEGIN                                           
                     
                         SELECT CAMBIO 
                         INTO   LN_CAMBIO
                         FROM   GE_CONVERSION 
                         WHERE  FEC_DESDE = TO_DATE(LV_FECHACICLO||'000000','YYYYMMDDHH24MISS')                         
                         AND    COD_MONEDA NOT IN (SELECT VAL_PARAMETRO
                                                   FROM GED_PARAMETROS
                                                   WHERE NOM_PARAMETRO = 'MONEDA_LOCAL')                         
                         AND ROWNUM = 1;
         
                         EN_MONTO_DESTINO := EN_MONTO_ORIGEN * LN_CAMBIO;                                                                           
                         
                     END;    
                  --3.2 SI IND_VALOR =1 TOMAR EN CUENTA EL VALOR DE LA TASA CAMBIO 
                  ELSE
                     EN_MONTO_DESTINO := EN_MONTO_ORIGEN * LN_VALOR;
                  END IF;                   
               END IF;                                                       
            END IF; -- LN_IND_CONVERSION = 3                                      
            
    EXCEPTION
        WHEN NO_HAY_CATEGORIA THEN
             SN_cod_retorno:=890054;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(sn_cod_retorno,sv_mens_retorno) THEN
                    sv_mens_retorno := CV_error_no_clasif;
             END IF;
             sn_num_evento  :=  Ge_Errores_Pg.Grabarpl( sn_num_evento, CV_cod_modulo, sv_mens_retorno, CV_version, USER, 'GA_CONVERSION_MONETARIA_PG.GA_CONVIERTE_MONTO_PR', LV_SQL, sn_cod_retorno, LV_des_error );
        WHEN NO_HAY_CONVERSION THEN
             SN_cod_retorno:=890063;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(sn_cod_retorno,sv_mens_retorno) THEN
                    sv_mens_retorno := CV_error_no_clasif;
             END IF;
             sn_num_evento  :=  Ge_Errores_Pg.Grabarpl( sn_num_evento, CV_cod_modulo, sv_mens_retorno, CV_version, USER, 'GA_CONVERSION_MONETARIA_PG.GA_CONVIERTE_MONTO_PR', LV_SQL, sn_cod_retorno, LV_des_error );
        WHEN NO_DATA_FOUND THEN
             SN_cod_retorno:=1621;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(sn_cod_retorno,sv_mens_retorno) THEN
                    sv_mens_retorno := CV_error_no_clasif;
             END IF;
             sn_num_evento  :=  Ge_Errores_Pg.Grabarpl( sn_num_evento, CV_cod_modulo, sv_mens_retorno, CV_version, USER, 'GA_CONVERSION_MONETARIA_PG.GA_CONVIERTE_MONTO_PR', LV_SQL, sn_cod_retorno, LV_des_error );
        WHEN OTHERS THEN
             SN_cod_retorno:=890062;            
             IF NOT Ge_Errores_Pg.MENSAJEERROR(sn_cod_retorno,sv_mens_retorno) THEN
                    sv_mens_retorno := CV_error_no_clasif;
             END IF;
             sn_num_evento  :=  Ge_Errores_Pg.Grabarpl( sn_num_evento, CV_cod_modulo, sv_mens_retorno, CV_version, USER, 'GA_CONVERSION_MONETARIA_PG.GA_CONVIERTE_MONTO_PR', LV_SQL, sn_cod_retorno, LV_des_error );
    END GA_CONVIERTE_MONTO_PR;
    
----------------------------------------------------------------------------------
/*Inicio modificaciones JM*/    
----------------------------------------------------------------------------------
FUNCTION  GA_INS_CLIE_CT_TEMP_FN (EN_ID_PROCESO            IN ge_cliente_tasa_opp_to.id_proceso%TYPE,
                                  EN_COD_CLIENTE		   IN ge_cliente_tasa_opp_to.cod_cliente%TYPE,
                                  EN_COD_CATEGORIA_CAMBIO  IN ge_cliente_tasa_opp_to.cod_categoria_cambio%TYPE,
                                  EN_NUM_LINEA_ARCHIVO     IN ge_cliente_tasa_opp_to.num_linea_archivo%TYPE,
                                  EN_COD_ESTADO            IN ge_cliente_tasa_opp_to.cod_estado%TYPE,
                                  EV_DES_ESTADO            IN ge_cliente_tasa_opp_to.des_estado%TYPE,
                                  SN_COD_RETORNO           OUT NOCOPY      ge_errores_pg.CodError,
                                  SV_MENS_RETORNO          OUT NOCOPY      ge_errores_pg.MsgError
) RETURN BOOLEAN
IS
    LV_des_error    ge_errores_pg.DesEvent;
    LV_sSql         ge_errores_pg.vQuery;
BEGIN
    sn_cod_retorno  := 0;

    LV_sSql := 'INSERT INTO ge_cliente_tasa_opp_to (id_proceso, cod_cliente, ';
    LV_sSql := LV_sSql || ' cod_categoria_cambio, num_linea_archivo, cod_estado, des_estado) ';
    LV_sSql := LV_sSql || ' VALUES ('||en_id_proceso||','|| en_cod_cliente||',';
    LV_sSql := LV_sSql || en_cod_categoria_cambio||','|| en_num_linea_archivo ||','|| en_cod_estado||','|| ev_des_estado||')';

    INSERT INTO ge_cliente_tasa_opp_to (id_proceso, cod_cliente, 
                                        cod_categoria_cambio, num_linea_archivo, cod_estado, des_estado) 
        VALUES                         (en_id_proceso, en_cod_cliente, 
                                        en_cod_categoria_cambio, en_num_linea_archivo, en_cod_estado, ev_des_estado);

    RETURN TRUE;
    EXCEPTION
        WHEN OTHERS THEN
            SN_cod_retorno := 890053;
            SV_MENS_RETORNO   := 'GA_CONVERSION_MONETARIA_PG.GA_INS_SERIE_LN_TEMP_FN' || SQLERRM;
            RETURN FALSE;
END GA_INS_CLIE_CT_TEMP_FN;
----------------------------------------------------------------------------------
FUNCTION  GA_VAL_CATEGORIA_FN    (EN_ID_PROCESO            IN ge_cliente_tasa_opp_to.id_proceso%TYPE,
                                  SN_COD_RETORNO           OUT NOCOPY      ge_errores_pg.CodError,
                                  SV_MENS_RETORNO          OUT NOCOPY      ge_errores_pg.MsgError
) RETURN BOOLEAN
IS
    LV_des_error    ge_errores_pg.DesEvent;
    LV_sSql         ge_errores_pg.vQuery;
BEGIN
    sn_cod_retorno  := 0;

    LV_sSql := 'update ge_cliente_tasa_opp_to a';
    LV_sSql := LV_sSql || ' set a.cod_estado = '||cn_error_categoria; 
    LV_sSql := LV_sSql || '    ,a.des_estado = '||cv_error_categoria;
    LV_sSql := LV_sSql || ' where id_proceso = '||en_id_proceso;
    LV_sSql := LV_sSql || ' and   not exists (select 1 from fa_tasa_cambio_td b';
    LV_sSql := LV_sSql || ' where b.cod_categoria_cambio = a.cod_categoria_cambio';
    LV_sSql := LV_sSql || ' and   sysdate between b.fec_desde and b.fec_hasta)';


    update ge_cliente_tasa_opp_to a
    set a.cod_estado = cn_error_categoria
       ,a.des_estado = cv_error_categoria
    where id_proceso = en_id_proceso 
    and   not exists (select 1 from fa_tasa_cambio_td b
                      where b.cod_categoria_cambio = a.cod_categoria_cambio
                      and   sysdate between b.fec_desde and b.fec_hasta); 
                  
    RETURN TRUE;
    EXCEPTION
        WHEN OTHERS THEN
            SN_cod_retorno := 890054;
            SV_MENS_RETORNO   := 'GA_INT_LISTAS_NEGRAS_PG.GA_VAL_CATEGORIA_FN' || SQLERRM;
            RETURN FALSE;
END GA_VAL_CATEGORIA_FN;
----------------------------------------------------------------------------------
FUNCTION  GA_VAL_ABON_ACT_FN    (EN_ID_PROCESO            IN ge_cliente_tasa_opp_to.id_proceso%TYPE,
                                 SN_COD_RETORNO           OUT NOCOPY      ge_errores_pg.CodError,
                                 SV_MENS_RETORNO          OUT NOCOPY      ge_errores_pg.MsgError
) RETURN BOOLEAN
IS
    LV_des_error    ge_errores_pg.DesEvent;
    LV_sSql         ge_errores_pg.vQuery;
BEGIN
    sn_cod_retorno  := 0;

    LV_sSql := 'update ge_cliente_tasa_opp_to a';
    LV_sSql := LV_sSql || ' set a.cod_estado = '||cn_clie_sinabonado; 
    LV_sSql := LV_sSql || '    ,a.des_estado = '||cv_clie_sinabonado;    
    LV_sSql := LV_sSql || ' where id_proceso = '||en_id_proceso;
    LV_sSql := LV_sSql || ' and    not exists (select 1 from ga_abocel b';
    LV_sSql := LV_sSql || ' where  b.cod_cliente = a.cod_cliente';
    LV_sSql := LV_sSql || ' and    b.cod_situacion not in ('||CV_BAJA_ABONADO||','||CV_BAJA_ABONADOPDTE||'))';

    update ge_cliente_tasa_opp_to a
       set a.cod_estado = cn_clie_sinabonado
          ,a.des_estado = cv_clie_sinabonado
    where  a.id_proceso = en_id_proceso 
    and    not exists (select 1 from ga_abocel b
                      where b.cod_cliente = a.cod_cliente
                      and    b.cod_situacion not in (CV_BAJA_ABONADO,CV_BAJA_ABONADOPDTE)); 

                 
    RETURN TRUE;
    EXCEPTION
        WHEN OTHERS THEN
            SN_cod_retorno := 890055;
            SV_MENS_RETORNO   := 'GA_INT_LISTAS_NEGRAS_PG.GA_VAL_ABON_ACT_FN' || SQLERRM;
            RETURN FALSE;
END GA_VAL_ABON_ACT_FN;
----------------------------------------------------------------------------------
FUNCTION  GA_VAL_MORA_CLIE_FN    (EN_ID_PROCESO            IN ge_cliente_tasa_opp_to.id_proceso%TYPE,
                                 SN_COD_RETORNO           OUT NOCOPY      ge_errores_pg.CodError,
                                 SV_MENS_RETORNO          OUT NOCOPY      ge_errores_pg.MsgError
) RETURN BOOLEAN
IS
    LV_des_error    ge_errores_pg.DesEvent;
    LV_sSql         ge_errores_pg.vQuery;
BEGIN
    sn_cod_retorno  := 0;

    LV_sSql := 'update ge_cliente_tasa_opp_to a';
    LV_sSql := LV_sSql || ' set a.cod_estado = '||cn_clie_moroso; 
    LV_sSql := LV_sSql || '    ,a.des_estado = '||cv_clie_moroso;    
    LV_sSql := LV_sSql || ' where id_proceso = '||en_id_proceso;
    LV_sSql := LV_sSql || ' and   exists (select 1 from co_cartera b';
    LV_sSql := LV_sSql || ' where b.cod_cliente = a.cod_cliente';
    LV_sSql := LV_sSql || ' and    b.ind_facturado = cn_ind_facturado';
    LV_sSql := LV_sSql || ' and    b.cod_tipdocum not in (select to_number(cod_valor)';
    LV_sSql := LV_sSql || ' from   co_codigos';
    LV_sSql := LV_sSql || ' where  nom_tabla   ='|| cv_co_cartera;
    LV_sSql := LV_sSql || ' and    nom_columna ='|| cv_tip_docum||'))';

    update ge_cliente_tasa_opp_to a
       set a.cod_estado = cn_clie_moroso
          ,a.des_estado = cv_clie_moroso   
    where  a.id_proceso = en_id_proceso 
    and    exists ( select 1 from co_cartera b
                        where  b.cod_cliente   = a.cod_cliente
                        and    b.ind_facturado = cn_ind_facturado
                        and    b.cod_tipdocum not in (select to_number(cod_valor)
                                                      from   co_codigos
                                                      where  nom_tabla   = cv_co_cartera
                                                      and    nom_columna = cv_tip_docum)); 

    RETURN TRUE;
    EXCEPTION
        WHEN OTHERS THEN
            SN_cod_retorno := 890056;
            SV_MENS_RETORNO   := 'GA_INT_LISTAS_NEGRAS_PG.GA_VAL_MORA_CLIE_FN' || SQLERRM;
            RETURN FALSE;
END GA_VAL_MORA_CLIE_FN;
----------------------------------------------------------------------------------
FUNCTION  GA_VAL_DUPL_CLIE_FN    (EN_ID_PROCESO            IN ge_cliente_tasa_opp_to.id_proceso%TYPE,
                                 SN_COD_RETORNO           OUT NOCOPY      ge_errores_pg.CodError,
                                 SV_MENS_RETORNO          OUT NOCOPY      ge_errores_pg.MsgError
) RETURN BOOLEAN
IS
    LV_des_error    ge_errores_pg.DesEvent;
    LV_sSql         ge_errores_pg.vQuery;
BEGIN
    sn_cod_retorno  := 0;

    LV_sSql := 'update ge_cliente_tasa_opp_to a';
    LV_sSql := LV_sSql || ' set a.cod_estado = '||cn_clie_duplicado;
    LV_sSql := LV_sSql || '    ,a.des_estado = '||cv_clie_duplicado;     
    LV_sSql := LV_sSql || ' where id_proceso = '||en_id_proceso;
    LV_sSql := LV_sSql || ' and   not exists (select 1 from co_cartera b';
    LV_sSql := LV_sSql || ' where en_id_proceso  = a.ind_proceso' ;
    LV_sSql := LV_sSql || ' and    b.ind_facturado = cn_ind_facturado';
    LV_sSql := LV_sSql || ' group by cod_cliente having count(0)> 1);';

    update ge_cliente_tasa_opp_to a
       set a.cod_estado = cn_clie_duplicado
          ,a.des_estado = cv_clie_duplicado       
    where  a.id_proceso = en_id_proceso 
    and    a.cod_cliente in (select cod_cliente from ge_cliente_tasa_opp_to
                             where id_proceso  = a.id_proceso
                             group by cod_cliente having count(0)> 1);                 
 
    RETURN TRUE;
    EXCEPTION
        WHEN OTHERS THEN
            SN_cod_retorno := 890062;
            SV_MENS_RETORNO   := 'GA_INT_LISTAS_NEGRAS_PG.GA_VAL_DUPL_CLIE_FN' || SQLERRM;
            RETURN FALSE;
END GA_VAL_DUPL_CLIE_FN;
----------------------------------------------------------------------------------
PROCEDURE GA_CARGA_CLIE_CTG_PR (EN_ID_PROCESO            IN ge_cliente_tasa_opp_to.id_proceso%TYPE,
                                EN_COD_CLIENTE		     IN ge_cliente_tasa_opp_to.cod_cliente%TYPE,
                                EN_COD_CATEGORIA_CAMBIO  IN ge_cliente_tasa_opp_to.cod_categoria_cambio%TYPE,
                                EN_NUM_LINEA_ARCHIVO     IN ge_cliente_tasa_opp_to.num_linea_archivo%TYPE,
                                EN_COD_ESTADO            IN ge_cliente_tasa_opp_to.cod_estado%TYPE,
                                EV_DES_ESTADO            IN ge_cliente_tasa_opp_to.des_estado%TYPE,
                                SN_COD_RETORNO           OUT NOCOPY   ge_errores_pg.CodError,
                                SV_MENS_RETORNO          OUT NOCOPY   ge_errores_pg.MsgError,
                                SN_NUM_EVENTO            OUT NOCOPY   ge_errores_pg.evento )

IS
    LV_des_error    ge_errores_pg.DesEvent;
    LV_sSql         ge_errores_pg.vQuery;
    ERROR_FUNCION   EXCEPTION;
BEGIN
    sn_cod_retorno  := 0;
    sn_num_evento  := 0;
    
    IF NOT GA_INS_CLIE_CT_TEMP_FN(EN_ID_PROCESO,EN_COD_CLIENTE,EN_COD_CATEGORIA_CAMBIO,EN_NUM_LINEA_ARCHIVO,EN_COD_ESTADO,EV_DES_ESTADO,sn_cod_retorno,sv_mens_retorno) THEN
        RAISE ERROR_FUNCION;
    END IF;


    EXCEPTION
        WHEN ERROR_FUNCION THEN
             IF NOT Ge_Errores_Pg.MENSAJEERROR(sn_cod_retorno,sv_mens_retorno) THEN
                    sv_mens_retorno := CV_error_no_clasif;
             END IF;
             LV_des_error   := SV_MENS_RETORNO;
             sn_num_evento  :=  Ge_Errores_Pg.Grabarpl( sn_num_evento, CV_cod_modulo, sv_mens_retorno, CV_version, USER, 'GA_CONVERSION_MONETARIA_PG.GA_CARGA_CLIE_CTG_PR', LV_sSQL, sn_cod_retorno, LV_des_error );

END GA_CARGA_CLIE_CTG_PR;
----------------------------------------------------------------------------------
PROCEDURE GA_VALIDA_CLIE_CTG_PR (EN_ID_PROCESO            IN ge_cliente_tasa_opp_to.id_proceso%TYPE,
                                SN_COD_RETORNO           OUT NOCOPY   ge_errores_pg.CodError,
                                SV_MENS_RETORNO          OUT NOCOPY   ge_errores_pg.MsgError,
                                SN_NUM_EVENTO            OUT NOCOPY   ge_errores_pg.evento )

IS
    LV_des_error    ge_errores_pg.DesEvent;
    LV_sSql         ge_errores_pg.vQuery;
    ERROR_FUNCION   EXCEPTION;
BEGIN
    sn_cod_retorno  := 0;
    sn_num_evento  := 0;
    

    IF NOT GA_VAL_CATEGORIA_FN(EN_ID_PROCESO,sn_cod_retorno,sv_mens_retorno) THEN
        RAISE ERROR_FUNCION;
    END IF;

    IF NOT GA_VAL_ABON_ACT_FN(EN_ID_PROCESO,sn_cod_retorno,sv_mens_retorno) THEN
        RAISE ERROR_FUNCION;
    END IF;

    IF NOT GA_VAL_MORA_CLIE_FN(EN_ID_PROCESO,sn_cod_retorno,sv_mens_retorno) THEN
        RAISE ERROR_FUNCION;
    END IF;

    IF NOT GA_VAL_DUPL_CLIE_FN(EN_ID_PROCESO,sn_cod_retorno,sv_mens_retorno) THEN
        RAISE ERROR_FUNCION;
    END IF;


    EXCEPTION
        WHEN ERROR_FUNCION THEN
             IF NOT Ge_Errores_Pg.MENSAJEERROR(sn_cod_retorno,sv_mens_retorno) THEN
                    sv_mens_retorno := CV_error_no_clasif;
             END IF;
             LV_des_error   := SV_MENS_RETORNO;
             sn_num_evento  :=  Ge_Errores_Pg.Grabarpl( sn_num_evento, CV_cod_modulo, sv_mens_retorno, CV_version, USER, 'GA_CONVERSION_MONETARIA_PG.GA_CARGA_CLIE_CTG_PR', LV_sSQL, sn_cod_retorno, LV_des_error );

END GA_VALIDA_CLIE_CTG_PR;
----------------------------------------------------------------------------------

FUNCTION  GA_EJECUTA_MOD_FN     (EN_ID_PROCESO            IN ge_cliente_tasa_opp_to.id_proceso%TYPE,
                                  SN_COD_RETORNO           OUT NOCOPY      ge_errores_pg.CodError,
                                  SV_MENS_RETORNO          OUT NOCOPY      ge_errores_pg.MsgError
) RETURN BOOLEAN
IS
    LV_des_error    ge_errores_pg.DesEvent;
    LV_sSql         ge_errores_pg.vQuery;
BEGIN
    sn_cod_retorno  := 0;

    LV_sSql := 'INSERT INTO ge_cliente_tasa_to (cod_cliente,cod_categoria_cambio,fec_modific,nom_usuario) ';
    LV_sSql := LV_sSql || ' SELECT cod_cliente,cod_categoria_cambio,sysdate,user ';
    LV_sSql := LV_sSql || ' FROM   ge_cliente_tasa_opp_to';
    LV_sSql := LV_sSql || ' WHERE  id_proceso =' || en_id_proceso;
    LV_sSql := LV_sSql || ' AND    cod_estado =' || cn_estado_ok;

    INSERT INTO ge_cliente_tasa_to (cod_cliente,cod_categoria_cambio,fec_modific,nom_usuario)
    SELECT cod_cliente,cod_categoria_cambio,sysdate,user
    FROM   ge_cliente_tasa_opp_to
    WHERE  id_proceso = en_id_proceso
    AND    cod_estado = cn_estado_ok;

    RETURN TRUE;
    EXCEPTION
        WHEN OTHERS THEN
            SN_cod_retorno := 890057;
            SV_MENS_RETORNO   := 'GA_CONVERSION_MONETARIA_PG.GA_EJECUTA_MOD_FN' || SQLERRM;
            RETURN FALSE;
END GA_EJECUTA_MOD_FN;

----------------------------------------------------------------------------------
FUNCTION  GA_PASO_HIST_FN     (EN_ID_PROCESO            IN ge_cliente_tasa_opp_to.id_proceso%TYPE,
                               SN_COD_RETORNO           OUT NOCOPY      ge_errores_pg.CodError,
                               SV_MENS_RETORNO          OUT NOCOPY      ge_errores_pg.MsgError
) RETURN BOOLEAN
IS
    LV_des_error    ge_errores_pg.DesEvent;
    LV_sSql         ge_errores_pg.vQuery;
BEGIN
    sn_cod_retorno  := 0;

    LV_sSql := 'INSERT INTO ge_cliente_tasa_th (cod_cliente,cod_categoria_cambio,fec_modific,nom_usuario) ';
    LV_sSql := LV_sSql || ' SELECT a.cod_cliente,a.cod_categoria_cambio,a.fec_modific,a.nom_usuario  FROM ge_cliente_tasa_to a ';
    LV_sSql := LV_sSql || ' WHERE  exists   (SELECT 1';
    LV_sSql := LV_sSql || ' FROM   ge_cliente_tasa_opp_to b';
    LV_sSql := LV_sSql || ' WHERE b.id_proceso =' || en_id_proceso;
    LV_sSql := LV_sSql || ' AND   b.cod_estado =' || cn_estado_ok;
    LV_sSql := LV_sSql || ' AND    b.cod_cliente = a.cod_cliente)';

    INSERT INTO ge_cliente_tasa_th (cod_cliente,cod_categoria_cambio,fec_modific,nom_usuario)
    SELECT a.cod_cliente,a.cod_categoria_cambio,a.fec_modific,a.nom_usuario  FROM ge_cliente_tasa_to a
    WHERE  exists  ( SELECT 1
                    FROM   ge_cliente_tasa_opp_to b
                    WHERE  b.id_proceso = en_id_proceso
                    AND    b.cod_estado = cn_estado_ok
                    AND    b.cod_cliente = a.cod_cliente);
                    
                    

    LV_sSql := 'DELETE FROM ge_cliente_tasa_to a ';
    LV_sSql := LV_sSql || ' WHERE  exists   (SELECT 1';
    LV_sSql := LV_sSql || ' FROM   ge_cliente_tasa_opp_to b';
    LV_sSql := LV_sSql || ' WHERE b.id_proceso =' || en_id_proceso;
    LV_sSql := LV_sSql || ' AND   b.cod_estado =' || cn_estado_ok;
    LV_sSql := LV_sSql || ' AND    b.cod_cliente = a.cod_cliente)';

    DELETE FROM ge_cliente_tasa_to a
    WHERE  exists  ( SELECT 1
                    FROM   ge_cliente_tasa_opp_to b
                    WHERE  b.id_proceso = en_id_proceso
                    AND    b.cod_estado = cn_estado_ok
                    AND    b.cod_cliente = a.cod_cliente);
                    

    RETURN TRUE;
    EXCEPTION
        WHEN OTHERS THEN
            SN_cod_retorno := 890058;
            SV_MENS_RETORNO   := 'GA_CONVERSION_MONETARIA_PG.GA_PASO_HIST_FN' || SQLERRM;
            RETURN FALSE;
END GA_PASO_HIST_FN;

----------------------------------------------------------------------------------
FUNCTION  GA_DEL_TMP_FN     (EN_ID_PROCESO            IN ge_cliente_tasa_opp_to.id_proceso%TYPE,
                             SN_COD_RETORNO           OUT NOCOPY      ge_errores_pg.CodError,
                             SV_MENS_RETORNO          OUT NOCOPY      ge_errores_pg.MsgError
) RETURN BOOLEAN
IS
    LV_des_error    ge_errores_pg.DesEvent;
    LV_sSql         ge_errores_pg.vQuery;
BEGIN
    sn_cod_retorno  := 0;

    LV_sSql := '    DELETE FROM ge_cliente_tasa_opp_to b ';
    LV_sSql := LV_sSql || ' WHERE b.id_proceso =' || en_id_proceso;
    
    DELETE FROM ge_cliente_tasa_opp_to b
    WHERE  b.id_proceso = en_id_proceso;

    RETURN TRUE;
    EXCEPTION
        WHEN OTHERS THEN
            SN_cod_retorno := 890060;
            SV_MENS_RETORNO   := 'GA_CONVERSION_MONETARIA_PG.GA_DEL_TMP_FN' || SQLERRM;
            RETURN FALSE;
END GA_DEL_TMP_FN;
----------------------------------------------------------------------------------

PROCEDURE GA_EJECUTA_MOD_PR (EN_ID_PROCESO            IN ge_cliente_tasa_opp_to.id_proceso%TYPE,
                             SN_COD_RETORNO           OUT NOCOPY   ge_errores_pg.CodError,
                             SV_MENS_RETORNO          OUT NOCOPY   ge_errores_pg.MsgError,
                             SN_NUM_EVENTO            OUT NOCOPY   ge_errores_pg.evento )

IS
    LV_des_error    ge_errores_pg.DesEvent;
    LV_sSql         ge_errores_pg.vQuery;
    ERROR_FUNCION   EXCEPTION;
BEGIN
    sn_cod_retorno  := 0;
    sn_num_evento  := 0;

    IF NOT GA_PASO_HIST_FN(EN_ID_PROCESO,sn_cod_retorno,sv_mens_retorno) THEN
        RAISE ERROR_FUNCION;
    END IF;

    
    IF NOT GA_EJECUTA_MOD_FN(EN_ID_PROCESO,sn_cod_retorno,sv_mens_retorno) THEN
        RAISE ERROR_FUNCION;
    END IF;

    IF NOT GA_DEL_TMP_FN(EN_ID_PROCESO,sn_cod_retorno,sv_mens_retorno) THEN
        RAISE ERROR_FUNCION;
    END IF;



    EXCEPTION
        WHEN ERROR_FUNCION THEN
             IF NOT Ge_Errores_Pg.MENSAJEERROR(sn_cod_retorno,sv_mens_retorno) THEN
                    sv_mens_retorno := CV_error_no_clasif;
             END IF;
             LV_des_error   := SV_MENS_RETORNO;
             sn_num_evento  :=  Ge_Errores_Pg.Grabarpl( sn_num_evento, CV_cod_modulo, sv_mens_retorno, CV_version, USER, 'GA_CONVERSION_MONETARIA_PG.GA_EJECUTA_MOD_PR', LV_sSQL, sn_cod_retorno, LV_des_error );

END GA_EJECUTA_MOD_PR;


PROCEDURE GA_BUSCAR_REGISTROS_PR(EN_ID_PROCESO   IN ge_cliente_tasa_opp_to.id_proceso%TYPE,
                                 SC_REG_CLIE_LN  OUT NOCOPY      refcursor)
/*
*/
IS
    SN_COD_RETORNO      ge_errores_pg.CodError;
    SV_MENS_RETORNO     ge_errores_pg.MsgError;
    SN_NUM_EVENTO       ge_errores_pg.evento;
    LV_des_error    ge_errores_pg.DesEvent;
    LV_sSql         ge_errores_pg.vQuery;
    error_exception EXCEPTION;

BEGIN
    sn_cod_retorno := 0;
    sn_num_evento  := 0;


    LV_sSql := 'SELECT  a.cod_cliente, ';
    LV_sSql := LV_sSql || ' a.cod_categoria_cambio,';
    LV_sSql := LV_sSql || ' a.num_linea_archivo,';
    LV_sSql := LV_sSql || ' a.cod_estado, ';
    LV_sSql := LV_sSql || ' a.des_estado, ';
    LV_sSql := LV_sSql || ' FROM ge_cliente_tasa_opp_to a ';
    LV_sSql := LV_sSql || ' WHERE a.id_proceso = ' || en_id_proceso;

    OPEN SC_REG_CLIE_LN FOR
    SELECT  a.cod_cliente, 
            a.cod_categoria_cambio,
            a.num_linea_archivo,
            a.cod_estado,
            a.des_estado
    FROM ge_cliente_tasa_opp_to a
    WHERE a.id_proceso = en_id_proceso;
    
    EXCEPTION
        WHEN error_exception THEN
             SN_cod_retorno := 890061;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(sn_cod_retorno,sv_mens_retorno) THEN
                    sv_mens_retorno := CV_error_no_clasif;
             END IF;
             LV_des_error   := 'GA_CONVERSION_MONETARIA_PG.GA_BUSCAR_REGISTROS_PR ';
             sn_num_evento  := Ge_Errores_Pg.Grabarpl( sn_num_evento, CV_cod_modulo, sv_mens_retorno, CV_version, USER, 'GA_CONVERSION_MONETARIA_PG.GA_BUSCAR_REGISTROS_PR', LV_sSQL, sn_cod_retorno, LV_des_error );

        WHEN OTHERS THEN
             SN_cod_retorno := 890061;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(sn_cod_retorno,sv_mens_retorno) THEN
                    sv_mens_retorno := CV_error_no_clasif;
             END IF;
             LV_des_error   := 'GA_CONVERSION_MONETARIA_PG.GA_BUSCAR_REGISTROS_PR ' || SQLERRM;
             sn_num_evento  := Ge_Errores_Pg.Grabarpl( sn_num_evento, CV_cod_modulo, sv_mens_retorno, CV_version, USER, 'GA_CONVERSION_MONETARIA_PG.GA_BUSCAR_REGISTROS_PR', LV_sSQL, sn_cod_retorno, LV_des_error );

END GA_BUSCAR_REGISTROS_PR;
/*Fin modificaciones JM*/   
----------------------------------------------------------------------------------
    
END GA_CONVERSION_MONETARIA_PG;
/
SHOW ERROR