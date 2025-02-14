CREATE OR REPLACE PACKAGE BODY AL_ACTIVACION_TARJETAS_PG IS

PROCEDURE AL_GENERA_RANGOS_ORDEN_PR(EN_Num_Orden        IN al_cabecera_ordenes2.num_orden%TYPE,
                                    EN_NumTransaccion   IN ga_transacabo.num_transaccion%TYPE
                                    )

IS

LV_sSql              VARCHAR2(3000);
LV_DesError          VARCHAR2(3000);
LV_OraErrm           VARCHAR2(3000);
LV_Proc              VARCHAR2(3000);
LV_Tabla             VARCHAR2(100);
LV_Act               VARCHAR2(1);

LN_NumEvento         NUMBER;


LN_NUM_LINEA_F       al_lineas_ordenes2.num_linea%TYPE;
LN_COD_ARTICULO      al_lineas_ordenes2.cod_articulo%TYPE;
LN_num_linea         al_lineas_ordenes2.num_linea%TYPE;

GV_rango_inicial     al_series_ordenes2.num_serie%TYPE;
GV_rango_final       al_series_ordenes2.num_serie%TYPE;
GV_serie_anterior    al_series_ordenes2.num_serie%TYPE;

LV_cod_actabo        icc_movimiento.cod_actabo%TYPE;
LV_cod_actcen        ga_actabo.cod_actcen%TYPE;

LV_parametro         ged_parametros.nom_parametro%TYPE;
LV_cod_modulo        ged_parametros.cod_modulo%TYPE := 'AL';
LV_TiposArt          ged_parametros.val_parametro%TYPE;

LN_SeqNumMov         icc_movimiento.num_movimiento%TYPE;

LN_CodMsg            ge_errores_td.cod_msgerror%TYPE;

LI_Cursor            INTEGER;
LI_Ejecutar          INTEGER;

Ind                  PLS_INTEGER := 0 ;
v_j                  PLS_INTEGER := 0 ;
v_k                  PLS_INTEGER := 0 ;

TYPE TYP_RANGO_INI   IS TABLE OF AL_SERIES_ORDENES2.num_serie%TYPE  INDEX BY BINARY_INTEGER;
TYPE TYP_RANGO_FIN   IS TABLE OF AL_SERIES_ORDENES2.num_serie%TYPE  INDEX BY BINARY_INTEGER;
TYPE TYP_MOVIMIENTO  IS TABLE OF NP_RANGO_SERIES_TO.num_movimiento%TYPE  INDEX BY BINARY_INTEGER;

RANGO_INI            TYP_RANGO_INI;
RANGO_FIN            TYP_RANGO_FIN;
MOVIMIENTO           TYP_MOVIMIENTO;

ERROR_PROCESO        EXCEPTION;

CURSOR SERIES(LN_num_linea al_lineas_ordenes2.num_linea%TYPE) IS
SELECT c.num_serie serie
FROM   al_lineas_ordenes2 a, al_series_ordenes2 c
WHERE  a.num_orden = EN_num_orden
AND    a.num_linea = LN_num_linea
AND    a.num_orden = c.num_orden
AND    a.num_linea = c.num_linea
ORDER BY c.num_serie;

BEGIN
    
    LV_OraErrm   := '0';
    LN_NumEvento :=  0 ;
    LV_DesError  := '0';
    
    LV_Proc      := 'AL_ACTIVACION_TARJETAS_PG.AL_GENERA_RANGOS_ORDEN_PR';
    
    INSERT INTO ga_transacabo 
    (num_transaccion,cod_retorno,des_cadena)
    VALUES (EN_NumTransaccion,0,NULL);
    
    LV_parametro := 'PREACTIVA_TARJETA';
    
    BEGIN
    
       LV_Tabla := 'GED_PARAMETROS|A';
       LV_Act   := 'S';
       
       LV_sSql := 'SELECT val_parametro FROM ged_parametros WHERE nom_parametro = :v1 AND cod_modulo = :v2 AND cod_producto  = :v3';
       
       EXECUTE IMMEDIATE LV_sSql INTO LV_cod_actabo USING LV_parametro,LV_cod_modulo,CI_uno; 
       
    EXCEPTION 
       WHEN OTHERS THEN
            
           LV_OraErrm  := SQLERRM;
           LN_CodMsg   := 215;
           LV_DesError := 'ERROR AL OBTENER[' || LV_parametro || '] PARAMETRO [' ||LV_parametro || '][' || LV_cod_modulo || '][' || CI_uno || ']';
           
           RAISE ERROR_PROCESO;
    END;
    
    BEGIN
       
       LV_Tabla := 'GA_ACTABO';
       LV_Act   := 'S';
    
       LV_sSql := ' SELECT cod_actcen FROM ga_actabo WHERE cod_actabo = :v1 AND cod_modulo = :v2 AND cod_tecnologia = :v3 ';
       
       EXECUTE IMMEDIATE LV_sSql INTO LV_cod_actcen USING LV_cod_actabo,LV_cod_modulo,'GSM'; 
       
    EXCEPTION 
       WHEN OTHERS THEN
            
            LV_OraErrm  := SQLERRM;
            LN_CodMsg   := 1870;
            LV_DesError := 'ERROR AL OBTENER ACTABO PARAMETROS [' || LV_cod_actabo || '][' || LV_cod_modulo || ']';
            
            RAISE ERROR_PROCESO;
            
    END;
    
    LV_sSql := NULL;
    
    LV_parametro := 'TIPOART_TARJETARASCA';
    
    BEGIN
    
       LV_Tabla := 'GED_PARAMETROS|B';
       LV_Act   := 'S';
       
       LV_sSql := 'SELECT val_parametro FROM ged_parametros WHERE nom_parametro = :v1 AND cod_modulo = :v2 AND cod_producto  = :v3';
       
       EXECUTE IMMEDIATE LV_sSql INTO LV_TiposArt USING LV_parametro,LV_cod_modulo,CI_uno; 
       
    EXCEPTION 
       WHEN OTHERS THEN
            
           LV_OraErrm  := SQLERRM;
           LN_CodMsg   := 215;
           LV_DesError := 'ERROR AL OBTENER[' || LV_parametro || '] PARAMETRO [' ||LV_parametro || '][' || LV_cod_modulo || '][' || CI_uno || ']';
           
           RAISE ERROR_PROCESO;
    END;
    
    --::::::::: INI: DEFINO EL CURSOR :::::::::::-
    LI_Cursor := DBMS_SQL.OPEN_CURSOR;
    
    LV_Tabla := 'LINEAS';
    LV_Act   := 'C';
    
    LV_sSql := ' SELECT a.num_linea, a.cod_articulo FROM al_lineas_ordenes2 a, al_articulos b '; 
    LV_sSql := LV_sSql || ' WHERE  a.num_orden    = :v1 ';
    LV_sSql := LV_sSql || ' AND    a.cod_articulo = b.cod_articulo ';
    LV_sSql := LV_sSql || ' AND    b.tip_articulo IN (' || LV_TiposArt || ') ';
    LV_sSql := LV_sSql || ' GROUP BY a.num_linea, a.cod_articulo';
    
    DBMS_SQL.PARSE(LI_Cursor,LV_sSql,DBMS_SQL.V7);
    
    DBMS_SQL.BIND_VARIABLE(LI_Cursor,':v1' ,EN_Num_Orden);
    
    DBMS_SQL.DEFINE_COLUMN(LI_Cursor, 1,LN_NUM_LINEA_F);
    DBMS_SQL.DEFINE_COLUMN(LI_Cursor, 2,LN_COD_ARTICULO);
    
    LI_Ejecutar := DBMS_SQL.EXECUTE(LI_Cursor);
    
    LOOP
    
        IF DBMS_SQL.FETCH_ROWS(LI_Cursor) = 0 THEN
            EXIT;
        END IF;
                    
        DBMS_SQL.COLUMN_VALUE(LI_Cursor, 1,LN_NUM_LINEA_F);
        DBMS_SQL.COLUMN_VALUE(LI_Cursor, 2,LN_COD_ARTICULO);
        
        Ind := 0;
          
        GV_serie_anterior:= NULL;
        GV_rango_inicial := NULL;
           
        FOR C_SERIES IN SERIES(LN_NUM_LINEA_F) LOOP
           
           IF GV_rango_inicial IS NULL THEN
               GV_rango_inicial := GV_serie_anterior;
           END IF;
           
           IF GV_serie_anterior IS NOT NULL THEN
           
               IF TO_number(substr(GV_serie_anterior,1,length(GV_serie_anterior)-1)) + 1 < TO_NUMBER(substr(C_SERIES.serie,1,length(C_SERIES.serie)-1)) THEN

                      Ind := Ind + 1;
                      GV_rango_final := GV_serie_anterior;
                      
                      RANGO_INI(Ind):= GV_RANGO_INICIAL;
                      RANGO_FIN(Ind):= GV_RANGO_FINAL;
                      
                      LV_Tabla := 'icc_seq_nummov.NEXTVAL|A';
                      LV_Act   := 'S';
                      
                      LV_sSql := 'SELECT icc_seq_nummov.NEXTVAL FROM DUAL';
                      
                      EXECUTE IMMEDIATE LV_sSql INTO LN_SeqNumMov;
                      
                      MOVIMIENTO(Ind)  := LN_SeqNumMov;

                      GV_rango_inicial := NULL;
                      GV_rango_final   := NULL;
                      
               END IF;
               
           END IF;

           GV_serie_anterior:= C_SERIES.serie;
           
        END LOOP;

        Ind := Ind + 1;
        
        IF GV_rango_inicial IS NOT NULL THEN
        
           IF GV_serie_anterior IS NULL THEN
               GV_rango_final := GV_rango_inicial;
           ELSE
               GV_rango_final := GV_serie_anterior;
           END IF;
           
        ELSE
           
           GV_rango_inicial:= GV_serie_anterior;
           GV_rango_final:= GV_serie_anterior;
           
        END IF;

        RANGO_INI(Ind):= GV_rango_inicial;
        RANGO_FIN(Ind):= GV_rango_final;
        
        LV_Tabla := 'icc_seq_nummov.NEXTVAL|B';
        LV_Act   := 'S';
                      
        LV_sSql := 'SELECT icc_seq_nummov.NEXTVAL FROM DUAL';
                      
        EXECUTE IMMEDIATE LV_sSql INTO LN_SeqNumMov;
        
        MOVIMIENTO(Ind):= LN_SeqNumMov;
        
        BEGIN
          
          LV_sSql := NULL;
        
          LV_Tabla := 'NP_RANGO_SERIES_TO';
          LV_Act   := 'I';
          
          FORALL v_j IN 1 .. Ind
          INSERT INTO np_rango_series_to
                 (num_proceso,num_linea,serie_inicial,ind_accion,serie_final,num_movimiento,cod_articulo,nom_usuario,fec_rangos)
          VALUES (EN_num_orden,LN_NUM_LINEA_F,RANGO_INI(v_j),'A',RANGO_FIN(v_j),MOVIMIENTO(v_j),LN_COD_ARTICULO,USER,SYSDATE);
        
        EXCEPTION 
            WHEN OTHERS THEN
                
                LV_OraErrm  := SQLERRM;
                LN_CodMsg   := 956;
                LV_DesError := 'ERROR AL GENERAR RANGO DE SERIES PARAMETRO [' || EN_num_orden || '][' || LN_NUM_LINEA_F || '][' || LN_COD_ARTICULO || ']';
                
                RAISE ERROR_PROCESO;
        END;

        BEGIN
          
          LV_sSql := NULL;
        
          LV_Tabla := 'ICC_MOVIMIENTO';
          LV_Act   := 'I';
        
          FORALL v_k IN 1 .. Ind
          INSERT INTO icc_movimiento
                      (num_movimiento,nom_usuarora, num_abonado, cod_modulo, num_intentos, des_respuesta, cod_actuacion, cod_actabo, cod_central, num_celular, num_serie, tip_terminal,tip_tecnologia)
          VALUES (MOVIMIENTO(v_k),USER, CI_zero, LV_cod_modulo,0,'PENDIENTE',LV_cod_actcen,LV_cod_actabo,CI_zero,CI_uno,CI_zero,'G','GSM');
        
        EXCEPTION
            WHEN OTHERS THEN
                
                LV_OraErrm  := SQLERRM;
                LN_CodMsg   := 215;
                LV_DesError := 'ERROR AL GENERAR MOVIMIENTOS PARAMETROS [' || LV_cod_modulo || '][' || LV_cod_actcen || '][' || LV_cod_actabo || ']';
           
                RAISE ERROR_PROCESO;
          
        END;
        
    END LOOP;
    
    DBMS_SQL.CLOSE_CURSOR(LI_Cursor);
    
    --::::::::: FIN: DEFINO EL CURSOR :::::::::::-
        
    COMMIT;

EXCEPTION

    WHEN ERROR_PROCESO THEN
        
        ROLLBACK;
        
        IF NOT ge_errores_pg.mensajeerror(LN_CodMsg, LV_DesError) THEN
           LV_DesError := 'Error No Clasificado';
        END IF;

        LV_DesError :=LV_DesError ||'-T:'||LV_Tabla;
        LV_DesError :=LV_DesError ||'('||LV_Act||')';
        LV_DesError :=LV_DesError ||'-'|| LV_OraErrm;

        LN_NumEvento := ge_errores_pg.grabarpl( LN_NumEvento, LV_cod_modulo,LV_DesError, '1.0', USER, LV_Proc, LV_sSql, LN_CodMsg, LV_DesError);
        
        UPDATE ga_transacabo
        SET    cod_retorno     = 1
             , des_cadena      = SUBSTR('EVENTO[' || LN_NumEvento || '] '||LV_DesError,1,255)
        WHERE  num_transaccion = EN_NumTransaccion;
        
        COMMIT;
        
    WHEN OTHERS THEN
        
        ROLLBACK;
    
        LN_CodMsg := 156;
        
        LV_OraErrm  :=SQLERRM;

        IF NOT ge_errores_pg.mensajeerror(LN_CodMsg, LV_DesError) THEN
           LV_DesError := 'Error No Clasificado';
        END IF;

        LV_DesError :=LV_DesError ||'-T:'||LV_Tabla;
        LV_DesError :=LV_DesError ||'('||LV_Act||')';
        LV_DesError :=LV_DesError ||'-'|| LV_OraErrm;
        
        LN_NumEvento := ge_errores_pg.grabarpl( LN_NumEvento, LV_cod_modulo,LV_DesError, '1.0', USER, LV_Proc, LV_sSql, LN_CodMsg, LV_DesError);
        
        UPDATE ga_transacabo
        SET    cod_retorno     = 1
             , des_cadena      = SUBSTR('EVENTO[' || LN_NumEvento || '] '||LV_DesError,1,255)
        WHERE  num_transaccion = EN_NumTransaccion;
        
        COMMIT;
        
END AL_GENERA_RANGOS_ORDEN_PR;

END AL_ACTIVACION_TARJETAS_PG;
/
