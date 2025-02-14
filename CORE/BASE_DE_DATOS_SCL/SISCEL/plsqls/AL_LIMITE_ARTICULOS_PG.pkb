CREATE OR REPLACE PACKAGE BODY AL_LIMITE_ARTICULOS_PG IS
/*
<NOMBRE>           : AL_LIMITE_ARTICULOS_PG  .</NOMBRE>
<FECHACREA>        : 31-10-2011<FECHACREA/>
<MODULO >          : Logistica </MODULO >
<AUTOR >       :  Kay Vera</AUTOR >
<VERSION >     : 1.0</VERSION >
<DESCRIPCION>  : Package Proyeccion de Traspaso</DESCRIPCION>
*/
  
        
  PROCEDURE AL_VALIDA_CANTIDAD_LIMITE_PR  (         V_COD_BODEGA        IN  AL_LIMITE_ARTICULO_TD.COD_BODEGA%TYPE, 
                                                    V_COD_ARTICULO      IN  AL_LIMITE_ARTICULO_TD.COD_ARTICULO%TYPE,
                                                    V_COD_USO           IN  AL_LIMITE_ARTICULO_TD.COD_USO%TYPE,
                                                    V_CANT_PROY         OUT NOCOPY AL_LIMITE_ARTICULO_TD.CANTIDAD%TYPE,
                                                    V_CANT_CONS         OUT NOCOPY NUMBER,
                                                    V_CANT_SALDO        OUT NOCOPY AL_LIMITE_ARTICULO_TD.CANTIDAD%TYPE,
                                                    V_NOM_BODEGA        OUT NOCOPY AL_BODEGAS.DES_BODEGA%TYPE,
                                                    V_NOM_ARTICULO      OUT NOCOPY AL_ARTICULOS.DES_ARTICULO%TYPE,
                                                    SN_COD_RETORNO      OUT NOCOPY GE_ERRORES_PG.CODERROR,
                                                    SV_MENS_RETORNO     OUT NOCOPY GE_ERRORES_PG.MSGERROR,
                                                    SN_NUM_EVENTO       OUT NOCOPY GE_ERRORES_PG.EVENTO) IS 
                                                
         
          
          v_cantidad_lim        AL_LIMITE_ARTICULO_TD.CANTIDAD%TYPE ;
          v_cantidad_ped        AL_LIMITE_ARTICULO_TD.CANTIDAD%TYPE ;
          v_count_limite        NUMBER;
          v_count_detalle       NUMBER;
          v_count_parametro     NUMBER;
          LV_SQL                VARCHAR2(3000) := '';
          LV_parametro          VARCHAR2(100) := '';
          LV_TIP_STOCK_TRASP    GED_PARAMETROS.VAL_PARAMETRO%TYPE;
          LV_EST_ABI_TRAS       GED_PARAMETROS.VAL_PARAMETRO%TYPE;
          LV_FEC_DESDE          AL_LIMITE_ARTICULO_TD.FEC_DESDE%TYPE;
          LV_FEC_HASTA          AL_LIMITE_ARTICULO_TD.FEC_HASTA%TYPE;
          LV_INGRESO            NUMBER;
          LV_EGRESO             NUMBER;
          EXP_SIN_ERROR         EXCEPTION;
          EXP_SIN_PARAMETRO     EXCEPTION;
          
          LV_des_error ge_errores_pg.DesEvent;
          
          
          
          
         
    BEGIN
    
            SN_COD_RETORNO:=0;
            SV_MENS_RETORNO:='';
            SN_NUM_EVENTO:=0;
            V_CANT_SALDO:=0;
            
            
            
            BEGIN
            
                SELECT DES_BODEGA 
                INTO V_NOM_BODEGA
                FROM AL_BODEGAS 
                WHERE COD_BODEGA=V_COD_BODEGA;
                
                SELECT DES_ARTICULO
                INTO V_NOM_ARTICULO
                FROM AL_ARTICULOS
                WHERE COD_ARTICULO=V_COD_ARTICULO;
            
            
            END;
    
            
            BEGIN
                
                LV_SQL := '                 SELECT   VAL_PARAMETRO ';
                LV_SQL := LV_SQL || '                INTO LV_TIP_STOCK_TRASP ';
                LV_SQL := LV_SQL || '                FROM   ged_parametros ';
                LV_SQL := LV_SQL || '                WHERE       nom_parametro = TIP_STOCK_TRASP';
                LV_SQL := LV_SQL || '                AND cod_modulo = AL';
                LV_SQL := LV_SQL || '                AND cod_producto = 1 ';


                SELECT   VAL_PARAMETRO
                INTO LV_TIP_STOCK_TRASP
                FROM   ged_parametros
                WHERE       nom_parametro = 'TIP_STOCK_TRASP'
                AND cod_modulo = 'AL'
                AND cod_producto = 1;
                    
           EXCEPTION WHEN NO_DATA_FOUND THEN
                RAISE EXP_SIN_PARAMETRO;     
                 
           END;     
           
           
           
           BEGIN
           
                LV_SQL := '                 SELECT VAL_PARAMETRO ';
                LV_SQL := LV_SQL || '                INTO LV_EST_ABI_TRAS ';
                LV_SQL := LV_SQL || '                FROM GED_PARAMETROS ';
                LV_SQL := LV_SQL || '                WHERE NOM_PARAMETRO=ESTADO_CAB_PET_TRAS';
                LV_SQL := LV_SQL || '                AND cod_modulo = AL';
                LV_SQL := LV_SQL || '                AND cod_producto = 1 ';

           
                SELECT VAL_PARAMETRO
                INTO LV_EST_ABI_TRAS
                FROM GED_PARAMETROS
                WHERE NOM_PARAMETRO='ESTADO_CAB_PET_TRAS'
                AND cod_modulo = 'AL'
                AND cod_producto = 1;
                    
           EXCEPTION WHEN NO_DATA_FOUND THEN
                RAISE EXP_SIN_PARAMETRO;    
           END;



            BEGIN
            
                LV_SQL := '                 SELECT CANTIDAD,FEC_DESDE,FEC_HASTA ';
                LV_SQL := LV_SQL || '                INTO V_CANTIDAD_LIM,LV_FEC_DESDE,LV_FEC_HASTA ';
                LV_SQL := LV_SQL || '                FROM AL_LIMITE_ARTICULO_TD ';
                LV_SQL := LV_SQL || '                WHERE COD_ARTICULO = ' || V_COD_ARTICULO ;
                LV_SQL := LV_SQL || '                AND COD_USO = ' || V_COD_USO ;
                LV_SQL := LV_SQL || '                AND COD_BODEGA = ' || V_COD_BODEGA ;
                LV_SQL := LV_SQL || '                AND SYSDATE BETWEEN FEC_DESDE AND FEC_HASTA ';


                SELECT CANTIDAD,FEC_DESDE,FEC_HASTA
                INTO V_CANTIDAD_LIM,LV_FEC_DESDE,LV_FEC_HASTA
                FROM AL_LIMITE_ARTICULO_TD
                WHERE COD_ARTICULO = V_COD_ARTICULO
                AND COD_USO = V_COD_USO
                AND COD_BODEGA = V_COD_BODEGA
                AND TRUNC(SYSDATE) BETWEEN FEC_DESDE AND FEC_HASTA;
            
            EXCEPTION WHEN NO_DATA_FOUND THEN
                v_cant_saldo:=0;
                V_CANT_PROY:=0;
                V_CANT_CONS:=0;
                RAISE EXP_SIN_ERROR;
            
            END;
                  
            
            BEGIN      
                
            
                LV_SQL := '             SELECT   VAL_PARAMETRO ';
                LV_SQL := LV_SQL || '            INTO LV_parametro ';
                LV_SQL := LV_SQL || '            FROM   ged_parametros ';
                LV_SQL := LV_SQL || '            WHERE       nom_parametro = ESTADO_TRASPASO';
                LV_SQL := LV_SQL || '            AND cod_modulo = AL';
                LV_SQL := LV_SQL || '            AND cod_producto = 1 ';

                SELECT   VAL_PARAMETRO
                INTO LV_parametro
                FROM   ged_parametros
                WHERE       nom_parametro = 'ESTADO_TRASPASO'
                AND cod_modulo = 'AL'
                AND cod_producto = 1;
            
            
            EXCEPTION WHEN NO_DATA_FOUND THEN
                v_cant_saldo:=V_CANTIDAD_LIM;
                RAISE EXP_SIN_ERROR;
            
            END;
            
            
            LV_SQL := ' SELECT  NVL(SUM (A.CAN_TRASPASO),0)  ';
            LV_SQL := LV_SQL || 'FROM   AL_LIN_PETICION A, AL_CAB_PETICION B , AL_TRASPASOS C ';
            LV_SQL := LV_SQL || 'WHERE       B.COD_BODEGA_DEST = ' || V_COD_BODEGA;
            LV_SQL := LV_SQL || ' AND B.NUM_PETICION = A.NUM_PETICION ';
            LV_SQL := LV_SQL || ' AND A.COD_ARTICULO =  ' || V_COD_ARTICULO;
            LV_SQL := LV_SQL || ' AND TRUNC(B.FEC_PETICION) BETWEEN TO_DATE('''|| TO_CHAR(LV_FEC_DESDE,'DD-MM-YYYY') || ''',''DD-MM-YYYY'') AND  TO_DATE(''' || TO_CHAR(LV_FEC_HASTA,'DD-MM-YYYY') || ''',''DD-MM-YYYY'')';
            LV_SQL := LV_SQL || ' AND C.NUM_PETICION(+)=B.NUM_PETICION ';
            LV_SQL := LV_SQL || ' AND C.COD_ESTADO(+) NOT IN ('''|| LV_parametro ||''') ';
            LV_SQL := LV_SQL || ' AND C.FEC_RECEPCION(+) IS NULL ';
            LV_SQL := LV_SQL || ' AND B.COD_ESTADO NOT IN ('''|| LV_EST_ABI_TRAS ||''')';
            
            

            EXECUTE IMMEDIATE LV_SQL INTO LV_INGRESO;

            
            LV_SQL := ' SELECT  NVL(SUM (A.CAN_TRASPASO),0)  ';
            LV_SQL := LV_SQL || 'FROM   AL_LIN_PETICION A, AL_CAB_PETICION B , AL_TRASPASOS C ';
            LV_SQL := LV_SQL || 'WHERE       B.COD_BODEGA_ORI = ' || V_COD_BODEGA;
            LV_SQL := LV_SQL || ' AND B.NUM_PETICION = A.NUM_PETICION ';
            LV_SQL := LV_SQL || ' AND A.COD_ARTICULO =  ' || V_COD_ARTICULO;
            LV_SQL := LV_SQL || ' AND TRUNC(B.FEC_PETICION) BETWEEN TO_DATE('''|| TO_CHAR(LV_FEC_DESDE,'DD-MM-YYYY') || ''',''DD-MM-YYYY'') AND  TO_DATE(''' || TO_CHAR(LV_FEC_HASTA,'DD-MM-YYYY') || ''',''DD-MM-YYYY'')';
            LV_SQL := LV_SQL || ' AND C.NUM_PETICION(+)=B.NUM_PETICION ';
            LV_SQL := LV_SQL || ' AND C.COD_ESTADO(+) NOT IN ('''|| LV_parametro ||''') ';
            LV_SQL := LV_SQL || ' AND C.FEC_RECEPCION(+) IS NULL ';
            LV_SQL := LV_SQL || ' AND B.COD_ESTADO NOT IN ('''|| LV_EST_ABI_TRAS ||''')';

            
            EXECUTE IMMEDIATE LV_SQL INTO LV_EGRESO;
            
            
            IF LV_INGRESO > 0 THEN
                    V_CANT_SALDO:= (V_CANTIDAD_LIM + LV_EGRESO) - LV_INGRESO;
            
            ELSE
                    V_CANT_SALDO:= (V_CANTIDAD_LIM + LV_EGRESO);
            END IF;          
            
            
            V_CANT_CONS :=  LV_INGRESO - LV_EGRESO;
            
            IF V_CANT_CONS < 0 THEN
                V_CANT_SALDO := (V_CANT_CONS * -1) + V_CANT_SALDO;
                V_CANT_CONS:=0;
            END IF;   
            
            IF V_CANT_SALDO < 0 THEN
                V_CANT_SALDO:=0; 
            END IF;
                
           V_CANT_PROY:= V_CANTIDAD_LIM;     
                

    EXCEPTION 
        WHEN EXP_SIN_ERROR THEN
            NULL; 
    
        WHEN EXP_SIN_PARAMETRO THEN
            SN_cod_retorno:=890069;
     
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := CV_error_no_clasIF;
             END IF;
     
             LV_des_error := SUBSTR('OTHERS:AL_LIMITE_ARTICULOS_PG.AL_VALIDA_CANTIDAD_LIMITE(); - '|| SQLERRM,1,CN_largoerrtec);
             SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
             SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
             'AL_LIMITE_ARTICULOS_PG.AL_VALIDA_CANTIDAD_LIMITE', LV_Sql, SN_cod_retorno, LV_des_error );     
         WHEN OTHERS THEN
            
             SN_cod_retorno:=156;
            
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := CV_error_no_clasIF;
             END IF;
             LV_des_error := SUBSTR('OTHERS:AL_LIMITE_ARTICULOS_PG.AL_VALIDA_CANTIDAD_LIMITE_PR(); - '|| SQLERRM,1,CN_largoerrtec);
             SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
             SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
             'AL_LIMITE_ARTICULOS_PG.AL_VALIDA_CANTIDAD_LIMITE_PR', LV_Sql, SN_cod_retorno, LV_des_error );                     

                  
    END AL_VALIDA_CANTIDAD_LIMITE_PR;   
         


PROCEDURE AL_VALIDA_STOCK_PROYECCION_PR(    V_COD_BODEGA_ORI        IN  AL_LIMITE_ARTICULO_TD.COD_BODEGA%TYPE,
                                            V_COD_BODEGA_DET        IN  AL_LIMITE_ARTICULO_TD.COD_BODEGA%TYPE,
                                            V_COD_ARTICULO          IN  AL_LIMITE_ARTICULO_TD.COD_ARTICULO%TYPE,
                                            V_COD_USO               IN  AL_LIMITE_ARTICULO_TD.COD_USO%TYPE,
                                            V_TOTAL_STOCK           OUT NOCOPY AL_STOCK.CAN_STOCK%TYPE,
                                            V_NOM_ARTICULO          OUT NOCOPY AL_ARTICULOS.DES_ARTICULO%TYPE,
                                            V_CANT_TRANSITO         OUT NOCOPY NUMBER,
                                            SN_COD_RETORNO          OUT NOCOPY GE_ERRORES_PG.CODERROR,
                                            SV_MENS_RETORNO         OUT NOCOPY GE_ERRORES_PG.MSGERROR,
                                            SN_NUM_EVENTO           OUT NOCOPY GE_ERRORES_PG.EVENTO)
                                            
IS

LV_TIP_STOCK        GED_PARAMETROS.VAL_PARAMETRO%TYPE;
LV_COD_BOD_STOCK    GED_PARAMETROS.VAL_PARAMETRO%TYPE;
LV_ESTADO_STOCK     GED_PARAMETROS.VAL_PARAMETRO%TYPE;
LV_parametro        GED_PARAMETROS.VAL_PARAMETRO%TYPE;
ERR_NO_EXI_STOCK    EXCEPTION;

LV_des_error        ge_errores_pg.DesEvent;
LV_Sql             ge_errores_pg.vQuery;


BEGIN


        SN_COD_RETORNO:=0;
        SV_MENS_RETORNO:='';
        SN_NUM_EVENTO:=0;
        V_TOTAL_STOCK:=0;
        
        BEGIN
        
            LV_SQL := '             SELECT   VAL_PARAMETRO ';
            LV_SQL := LV_SQL || '            INTO LV_TIP_STOCK ';
            LV_SQL := LV_SQL || '            FROM   ged_parametros ';
            LV_SQL := LV_SQL || '            WHERE       nom_parametro = TIP_STOCK_TRASP';
            LV_SQL := LV_SQL || '            AND cod_modulo = AL';
            LV_SQL := LV_SQL || '            AND cod_producto = 1 ';


            SELECT   VAL_PARAMETRO
            INTO LV_TIP_STOCK
            FROM   ged_parametros
            WHERE       nom_parametro = 'TIP_STOCK_TRASP'
            AND cod_modulo = 'AL'
            AND cod_producto = 1;

            LV_SQL := '             SELECT   VAL_PARAMETRO ';
            LV_SQL := LV_SQL || '            INTO LV_ESTADO_STOCK ';
            LV_SQL := LV_SQL || '            FROM   ged_parametros ';
            LV_SQL := LV_SQL || '            WHERE       nom_parametro = ESTADO_STOCK';
            LV_SQL := LV_SQL || '            AND cod_modulo = AL';
            LV_SQL := LV_SQL || '            AND cod_producto = 1 ';

            
            SELECT   VAL_PARAMETRO
            INTO LV_ESTADO_STOCK
            FROM   ged_parametros
            WHERE       nom_parametro = 'ESTADO_STOCK'
            AND cod_modulo = 'AL'
            AND cod_producto = 1;
        
        
        EXCEPTION 
            WHEN NO_DATA_FOUND THEN
            V_TOTAL_STOCK:=0;
            RAISE ERR_NO_EXI_STOCK;
        
        END;
        
        
        
        LV_SQL := '         SELECT DES_ARTICULO ';
        LV_SQL := LV_SQL || '        INTO V_NOM_ARTICULO ';
        LV_SQL := LV_SQL || '        FROM AL_ARTICULOS ';
        LV_SQL := LV_SQL || '        WHERE COD_ARTICULO=' || V_COD_ARTICULO;

        
        SELECT DES_ARTICULO
        INTO V_NOM_ARTICULO
        FROM AL_ARTICULOS
        WHERE COD_ARTICULO=V_COD_ARTICULO;
        
        
        
        
        LV_SQL := '         SELECT   NVL(SUM(CAN_STOCK),0) ';
        LV_SQL := LV_SQL || '        INTO   V_TOTAL_STOCK ';
        LV_SQL := LV_SQL || '        FROM   AL_STOCK ';
        LV_SQL := LV_SQL || '        WHERE  COD_BODEGA = ' || V_COD_BODEGA_ORI ;
        LV_SQL := LV_SQL || '        AND TIP_STOCK = ' || LV_TIP_STOCK ;
        LV_SQL := LV_SQL || '        AND COD_ARTICULO = ' || V_COD_ARTICULO ;
        LV_SQL := LV_SQL || '        AND COD_USO = ' || V_COD_USO  ;
        LV_SQL := LV_SQL || '        AND COD_ESTADO = ' || LV_ESTADO_STOCK ;

        
        
        SELECT   NVL(SUM(CAN_STOCK),0)
        INTO   V_TOTAL_STOCK
        FROM   AL_STOCK
        WHERE  COD_BODEGA = V_COD_BODEGA_ORI
        AND TIP_STOCK = LV_TIP_STOCK
        AND COD_ARTICULO = V_COD_ARTICULO
        AND COD_USO = V_COD_USO 
        AND COD_ESTADO = LV_ESTADO_STOCK;
        
        
        
        LV_SQL := '             SELECT   VAL_PARAMETRO ';
        LV_SQL := LV_SQL || '            INTO LV_parametro ';
        LV_SQL := LV_SQL || '            FROM   ged_parametros ';
        LV_SQL := LV_SQL || '            WHERE       nom_parametro = ESTADO_TRASPASO';
        LV_SQL := LV_SQL || '            AND cod_modulo = AL';
        LV_SQL := LV_SQL || '            AND cod_producto = 1 ';

        SELECT   VAL_PARAMETRO
        INTO LV_parametro
        FROM   ged_parametros
        WHERE       nom_parametro = 'ESTADO_TRASPASO'
        AND cod_modulo = 'AL'
        AND cod_producto = 1;
        
        LV_SQL := '         SELECT  NVL(SUM (A.CAN_TRASPASO),0)  ';
        LV_SQL := LV_SQL || '        INTO V_CANT_TRANSITO  ';
        LV_SQL := LV_SQL || '        FROM   AL_LIN_PETICION A, AL_CAB_PETICION B , AL_TRASPASOS C  ';
        LV_SQL := LV_SQL || '        WHERE  B.COD_BODEGA_ORI=8 AND ';
        LV_SQL := LV_SQL || '        B.COD_BODEGA_DEST = 17 ';
        LV_SQL := LV_SQL || '        AND B.NUM_PETICION = A.NUM_PETICION  ';
        LV_SQL := LV_SQL || '        AND A.COD_ARTICULO = 19855 ';
        LV_SQL := LV_SQL || '        AND C.NUM_PETICION(+)=B.NUM_PETICION  ';
        LV_SQL := LV_SQL || '        AND C.COD_ESTADO(+) NOT IN (LV_parametro)  ';
        LV_SQL := LV_SQL || '        AND C.FEC_RECEPCION(+) IS NULL; ';

        
        
        SELECT  NVL(SUM (A.CAN_TRASPASO),0) 
        INTO V_CANT_TRANSITO 
        FROM   AL_LIN_PETICION A, AL_CAB_PETICION B , AL_TRASPASOS C 
        WHERE  B.COD_BODEGA_ORI=V_COD_BODEGA_ORI
        AND  B.COD_BODEGA_DEST = V_COD_BODEGA_ORI
        AND B.NUM_PETICION = A.NUM_PETICION 
        AND A.COD_ARTICULO = V_COD_ARTICULO
        AND C.NUM_PETICION(+)=B.NUM_PETICION 
        AND C.COD_ESTADO(+) NOT IN (LV_parametro) 
        AND C.FEC_RECEPCION(+) IS NULL;


EXCEPTION
        WHEN ERR_NO_EXI_STOCK THEN
            NULL;
         WHEN OTHERS THEN
            
             SN_cod_retorno:=156;
            
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := CV_error_no_clasIF;
             END IF;
             LV_des_error := SUBSTR('OTHERS:AL_LIMITE_ARTICULOS_PG.AL_VALIDA_STOCK_PROYECCION_PR(); - '|| SQLERRM,1,CN_largoerrtec);
             SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
             SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
             'AL_LIMITE_ARTICULOS_PG.AL_VALIDA_STOCK_PROYECCION_PR', LV_Sql, SN_cod_retorno, LV_des_error );  



END AL_VALIDA_STOCK_PROYECCION_PR;                                                                                           
         
         
                                   
END;
/
